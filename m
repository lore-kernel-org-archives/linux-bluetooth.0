Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 14/14] tools: Emit changes to HasTrackList in mpris-player
Date: Wed, 15 May 2013 18:31:46 +0300
Message-Id: <1368631906-15951-14-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1368631906-15951-1-git-send-email-luiz.dentz@gmail.com>
References: <1368631906-15951-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 tools/mpris-player.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/mpris-player.c b/tools/mpris-player.c
index df0ac7c..d3a42a8 100644
--- a/tools/mpris-player.c
+++ b/tools/mpris-player.c
@@ -2048,6 +2048,10 @@ static void register_tracklist(GDBusProxy *proxy)
 
 	player->tracklist = tracklist;
 
+	g_dbus_emit_property_changed(player->conn, MPRIS_PLAYER_PATH,
+						MPRIS_INTERFACE,
+						"HasTrackList");
+
 	if (player->playlist == NULL)
 		return;
 
-- 
1.8.1.4

