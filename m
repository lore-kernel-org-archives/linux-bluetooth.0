Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 2/2] Make title always available in metadata
Date: Thu, 13 Oct 2011 09:57:03 -0300
Message-Id: <1318510623-7484-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1318510623-7484-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1318510623-7484-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/media.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index eecb44d..519cafe 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -1448,12 +1448,16 @@ static gboolean parse_player_metadata(struct media_player *mp,
 		dbus_message_iter_next(&dict);
 	}
 
-	if (title == FALSE)
-		goto parse_error;
-
 	if (g_hash_table_size(track) == 0) {
 		g_hash_table_unref(track);
 		track = NULL;
+	} else if (title == FALSE) {
+		struct metadata_value *value = g_new(struct metadata_value, 1);
+		uint32_t id = AVRCP_MEDIA_ATTRIBUTE_TITLE;
+
+		value->type = DBUS_TYPE_STRING;
+		value->value.str = g_strdup("");
+		g_hash_table_insert(track, GUINT_TO_POINTER(id), value);
 	}
 
 	if (mp->track != NULL)
-- 
1.7.7

