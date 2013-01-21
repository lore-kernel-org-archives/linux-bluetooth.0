Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/6] tools: Emit Seeked signal if Position changes
Date: Mon, 21 Jan 2013 17:21:58 +0200
Message-Id: <1358781718-386-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1358781718-386-1-git-send-email-luiz.dentz@gmail.com>
References: <1358781718-386-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

MPRIS spec says PropertiesChanged is not emitted for Position, which is
probably to make clear that progress is done using the rate, so instead
Seeked should be emitted.
---
 tools/mpris-player.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/mpris-player.c b/tools/mpris-player.c
index 448050d..b8de9a1 100644
--- a/tools/mpris-player.c
+++ b/tools/mpris-player.c
@@ -1646,6 +1646,8 @@ static void player_property_changed(GDBusProxy *proxy, const char *name,
 {
 	struct player *player;
 	const char *property;
+	uint32_t position;
+	uint64_t value;
 
 	player = find_player(proxy);
 	if (player == NULL)
@@ -1658,6 +1660,18 @@ static void player_property_changed(GDBusProxy *proxy, const char *name,
 	g_dbus_emit_property_changed(player->conn, MPRIS_PLAYER_PATH,
 						MPRIS_PLAYER_INTERFACE,
 						property);
+
+	if (strcasecmp(name, "Position") != 0)
+		return;
+
+	dbus_message_iter_get_basic(iter, &position);
+
+	value = position * 1000;
+
+	g_dbus_emit_signal(player->conn, MPRIS_PLAYER_PATH,
+					MPRIS_PLAYER_INTERFACE, "Seeked",
+					DBUS_TYPE_INT64, &value,
+					DBUS_TYPE_INVALID);
 }
 
 static void transport_property_changed(GDBusProxy *proxy, const char *name,
-- 
1.8.0.2

