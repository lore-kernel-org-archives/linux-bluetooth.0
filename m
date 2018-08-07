Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: David Carlos Manuelda <stormbyte@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: David Carlos Manuelda <stormbyte@gmail.com>
Subject: [PATCH BlueZ 1/1] build: Clang fix - ISO C forbids nested functions
Date: Tue,  7 Aug 2018 16:09:33 +0200
Message-Id: <20180807140933.11528-2-stormbyte@gmail.com>
In-Reply-To: <20180807140933.11528-1-stormbyte@gmail.com>
References: <20180807140933.11528-1-stormbyte@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/midi/midi.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/profiles/midi/midi.c b/profiles/midi/midi.c
index 1ee5cb16f..f08728e4b 100644
--- a/profiles/midi/midi.c
+++ b/profiles/midi/midi.c
@@ -71,20 +71,20 @@ struct midi {
 	struct midi_write_parser midi_out;
 };
 
+static void foreach_cb(const struct midi_write_parser *parser, void *user_data) {
+	struct midi *midi = user_data;
+	bt_gatt_client_write_without_response(midi->client,
+	                                      midi->midi_io_handle,
+	                                      false,
+	                                      midi_write_data(parser),
+	                                      midi_write_data_size(parser));
+}
+
 static bool midi_write_cb(struct io *io, void *user_data)
 {
 	struct midi *midi = user_data;
 	int err;
 
-	void foreach_cb(const struct midi_write_parser *parser, void *user_data) {
-		struct midi *midi = user_data;
-		bt_gatt_client_write_without_response(midi->client,
-		                                      midi->midi_io_handle,
-		                                      false,
-		                                      midi_write_data(parser),
-		                                      midi_write_data_size(parser));
-	};
-
 	do {
 		snd_seq_event_t *event = NULL;
 
-- 
2.18.0

