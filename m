Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] audio/player: Fix attempting to set the same setting value
Date: Tue, 23 Jul 2013 15:52:32 +0300
Message-Id: <1374583952-16361-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1374583952-16361-1-git-send-email-luiz.dentz@gmail.com>
References: <1374583952-16361-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This cause unnecessary commands to be sent over the air so instead the
code should just return success as nothing should be changed.
---
 profiles/audio/player.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 917c66e..a817b54 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -263,7 +263,7 @@ static void set_setting(const GDBusPropertyTable *property,
 			void *data)
 {
 	struct media_player *mp = data;
-	const char *value;
+	const char *value, *current;
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING) {
 		g_dbus_pending_property_error(id,
@@ -274,6 +274,12 @@ static void set_setting(const GDBusPropertyTable *property,
 
 	dbus_message_iter_get_basic(iter, &value);
 
+	current = g_hash_table_lookup(mp->settings, property->name);
+	if (g_strcmp0(current, value) == 0) {
+		g_dbus_pending_property_success(id);
+		return;
+	}
+
 	player_set_setting(mp, id, property->name, value);
 }
 
-- 
1.8.3.1

