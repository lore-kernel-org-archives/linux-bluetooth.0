Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH 1/2] audio: Replace g_hash_table_contains() with
 g_hash_table_lookup()
Date: Mon, 07 Jan 2013 18:03:52 +0530
Message-id: <1357562033-26230-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

g_hash_table_contains() is supported only from GLib 2.32. If BlueZ has to
build against GLib 2.28 this patch replaces g_hash_table_contains() to
g_hash_table_lookup()
---
 profiles/audio/player.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 8748893..4198bdb 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -172,8 +172,13 @@ static gboolean get_status(const GDBusPropertyTable *property,
 static gboolean setting_exists(const GDBusPropertyTable *property, void *data)
 {
 	struct media_player *mp = data;
+	const char *value;
+
+	value = g_hash_table_lookup(mp->settings, property->name);
+	if (value == NULL)
+		return FALSE;
 
-	return g_hash_table_contains(mp->settings, property->name);
+	return TRUE;
 }
 
 static gboolean get_setting(const GDBusPropertyTable *property,
-- 
1.7.9.5

