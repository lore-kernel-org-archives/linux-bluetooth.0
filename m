Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 04/12] Make title always available in metadata
Date: Wed, 12 Oct 2011 12:11:14 -0300
Message-Id: <1318432282-25002-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1318432282-25002-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1318432282-25002-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/media.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index c9fe0f0..56913d5 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -1438,6 +1438,11 @@ static gboolean parse_player_metadata(struct media_player *mp,
 	if (g_hash_table_size(track) == 0) {
 		g_hash_table_unref(track);
 		track = NULL;
+	} else if (title == FALSE) {
+		struct metadata_value *value = g_new(struct metadata_value, 1);
+
+		value->type = DBUS_TYPE_STRING;
+		value->value.str = g_strdup("");
 	}
 
 	if (mp->track != NULL)
-- 
1.7.7

