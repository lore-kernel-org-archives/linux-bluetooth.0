Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] Add support for MediaPlayer.Release to mpris-player
Date: Fri, 28 Oct 2011 10:49:21 +0300
Message-Id: <1319788162-5606-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1319788162-5606-1-git-send-email-luiz.dentz@gmail.com>
References: <1319788162-5606-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 test/mpris-player.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/test/mpris-player.c b/test/mpris-player.c
index 4592e5d..a1632f3 100644
--- a/test/mpris-player.c
+++ b/test/mpris-player.c
@@ -429,6 +429,22 @@ static char *sender2path(const char *sender)
 	return g_strdelimit(path, ":.", '_');
 }
 
+static DBusHandlerResult player_message(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	if (dbus_message_is_method_call(msg, "org.bluez.MediaPlayer",
+								"Release")) {
+		printf("Release\n");
+		exit(1);
+	}
+
+	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+}
+
+static const DBusObjectPathVTable player_table = {
+	.message_function = player_message,
+};
+
 static void add_player(DBusConnection *conn, const char *name,
 							const char *sender)
 {
@@ -492,6 +508,10 @@ static void add_player(DBusConnection *conn, const char *name,
 		goto done;
 	}
 
+	if (!dbus_connection_register_object_path(sys, path, &player_table,
+								NULL))
+		fprintf(stderr, "Can't register object path for agent\n");
+
 done:
 	if (reply)
 		dbus_message_unref(reply);
-- 
1.7.6.4

