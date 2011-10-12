Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 07/12] Add callback to list available metadata IDs
Date: Wed, 12 Oct 2011 12:11:17 -0300
Message-Id: <1318432282-25002-7-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1318432282-25002-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1318432282-25002-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/avrcp.h |    1 +
 audio/media.c |   13 +++++++++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/audio/avrcp.h b/audio/avrcp.h
index 66d09bc..360a80a 100644
--- a/audio/avrcp.h
+++ b/audio/avrcp.h
@@ -76,6 +76,7 @@ struct avrcp_player_cb {
 	int (*get_setting) (uint8_t attr, void *user_data);
 	int (*set_setting) (uint8_t attr, uint8_t value, void *user_data);
 	void *(*get_metadata) (uint32_t id, void *user_data);
+	GList *(*list_metadata) (void *user_data);
 	uint8_t (*get_status) (void *user_data);
 	uint32_t (*get_position) (void *user_data);
 };
diff --git a/audio/media.c b/audio/media.c
index 56913d5..5a74fec 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -1156,6 +1156,18 @@ static int set_setting(uint8_t attr, uint8_t val, void *user_data)
 	return 0;
 }
 
+static GList *list_metadata(void *user_data)
+{
+	struct media_player *mp = user_data;
+
+	DBG("");
+
+	if (mp->track == NULL)
+		return NULL;
+
+	return g_hash_table_get_keys(mp->track);
+}
+
 static void *get_metadata(uint32_t id, void *user_data)
 {
 	struct media_player *mp = user_data;
@@ -1207,6 +1219,7 @@ static uint32_t get_position(void *user_data)
 static struct avrcp_player_cb player_cb = {
 	.get_setting = get_setting,
 	.set_setting = set_setting,
+	.list_metadata = list_metadata,
 	.get_metadata = get_metadata,
 	.get_position = get_position,
 	.get_status = get_status
-- 
1.7.7

