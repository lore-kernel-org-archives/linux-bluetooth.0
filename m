Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/9] tools/mpris-player: Fix overflow before type widening
Date: Thu, 19 Jun 2014 16:55:29 +0300
Message-Id: <1403186136-30041-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403186136-30041-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403186136-30041-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Expression is evaluated using 32-bit arithmetic before conversion to
64-bit.
---
 tools/mpris-player.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/mpris-player.c b/tools/mpris-player.c
index c94330c..397f064 100644
--- a/tools/mpris-player.c
+++ b/tools/mpris-player.c
@@ -1135,7 +1135,7 @@ static gboolean get_position(const GDBusPropertyTable *property,
 
 	dbus_message_iter_get_basic(&var, &position);
 
-	value = position * 1000;
+	value = position * 1000ll;
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_INT64, &value);
 
@@ -1195,7 +1195,7 @@ static gboolean parse_int64_metadata(DBusMessageIter *iter, const char *key,
 
 	dbus_message_iter_get_basic(iter, &duration);
 
-	value = duration * 1000;
+	value = duration * 1000ll;
 
 	dict_append_entry(metadata, key, DBUS_TYPE_INT64, &value);
 
@@ -2412,7 +2412,7 @@ static void player_property_changed(GDBusProxy *proxy, const char *name,
 
 	dbus_message_iter_get_basic(iter, &position);
 
-	value = position * 1000;
+	value = position * 1000ll;
 
 	g_dbus_emit_signal(player->conn, MPRIS_PLAYER_PATH,
 					MPRIS_PLAYER_INTERFACE, "Seeked",
-- 
1.8.3.2

