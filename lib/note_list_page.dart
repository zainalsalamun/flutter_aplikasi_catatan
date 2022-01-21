import 'package:flutter/material.dart';
import 'package:flutter_aplikasi_catatan/db_provider.dart';
import 'package:flutter_aplikasi_catatan/note_add_update_page.dart';
import 'package:provider/provider.dart';

class NoteListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: Consumer<DbProvider>(
        builder: (context, provider, child) {
          final notes = provider.notes;

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return Dismissible(
                key: Key(note.id.toString()),
                background: Container(color: Colors.red),

                  // TODO : Kode untuk menghapus note
                  onDismissed: (direction) {
                    provider.deleteNote(note.id!);

                },
                child: Card(
                  child: ListTile(
                    title: Text(note.title),
                    subtitle: Text(note.description),
                    onTap: () async {
                      // TODO : Kode untuk mendapatkan note yang dipilih dan dikirimkan ke NoteAddUpdatePage
                      final selectedNote = await provider.getNoteById(note.id!);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return NoteAddUpdatePage(selectedNote);
                          },
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NoteAddUpdatePage()));
        },
      ),
    );
  }
}