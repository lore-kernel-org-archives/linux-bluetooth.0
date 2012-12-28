Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 11/11] AVRCP: Fix not checking for media_player_controller_create
Date: Fri, 28 Dec 2012 14:51:09 +0200
Message-Id: <1356699069-5469-12-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1356699069-5469-1-git-send-email-luiz.dentz@gmail.com>
References: <1356699069-5469-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Now that the MediaPlayer1 interface is experimental the interface
registration may fail which return NULL, in that case there is no
point on register to any notifications.
---
 profiles/audio/avrcp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 4e3d31d..ce070cd 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1987,6 +1987,11 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn,
 
 	count = pdu->params[1];
 
+	path = device_get_path(session->dev->btd_dev);
+	mp = media_player_controller_create(path);
+	if (mp == NULL)
+		return FALSE;
+
 	for (; count > 0; count--) {
 		uint8_t event = pdu->params[1 + count];
 
@@ -2001,8 +2006,6 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn,
 		}
 	}
 
-	path = device_get_path(session->dev->btd_dev);
-	mp = media_player_controller_create(path);
 	media_player_set_callbacks(mp, &ct_cbs, player);
 	player->user_data = mp;
 	player->destroy = (GDestroyNotify) media_player_destroy;
-- 
1.8.0.1

