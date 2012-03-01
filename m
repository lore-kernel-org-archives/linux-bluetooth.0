Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, <vani.patel@stericsson.com>,
	<joohi.rastogi@stericsson.com>,
	Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH 3/3] avrcp: Treat position as unknown when duration is unavailable
Date: Thu, 1 Mar 2012 15:45:35 +0100
Message-ID: <1330613135-16552-3-git-send-email-michal.labedzki@tieto.com>
In-Reply-To: <1330613135-16552-1-git-send-email-michal.labedzki@tieto.com>
References: <1330613135-16552-1-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to the specification when duration and position are not
supported then 0xFFFFFFFF should be returned. This patch avoid random
position on stream where duration is not available.
---
 audio/avrcp.c |   10 ++++++----
 audio/media.c |    3 ++-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 2d29d56..e141030 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -859,16 +859,18 @@ static uint8_t avrcp_handle_get_play_status(struct avrcp_player *player,
 		return AVC_CTYPE_REJECTED;
 	}
 
-	position = player->cb->get_position(player->user_data);
 	pduration = player->cb->get_metadata(AVRCP_MEDIA_ATTRIBUTE_DURATION,
 							player->user_data);
 
-	if (pduration != NULL)
+	if (pduration != NULL) {
 		duration = htonl(GPOINTER_TO_UINT(pduration));
-	else
+		position = htonl(player->cb->get_position(player->user_data));
+	} else {
 		duration = htonl(UINT32_MAX);
+		position = htonl(UINT32_MAX);
+	}
 
-	position = htonl(position);
+	DBG("position=%u duration=%u", ntohl(position), ntohl(duration));
 
 	memcpy(&pdu->params[0], &duration, 4);
 	memcpy(&pdu->params[4], &position, 4);
diff --git a/audio/media.c b/audio/media.c
index c0fd0c3..4887753 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -1569,7 +1569,8 @@ static struct media_player *media_player_create(struct media_adapter *adapter,
 	mp->sender = g_strdup(sender);
 	mp->path = g_strdup(path);
 	mp->timer = g_timer_new();
-
+	mp->position = UINT32_MAX;
+	mp->status = AVRCP_PLAY_STATUS_STOPPED;
 	mp->watch = g_dbus_add_disconnect_watch(adapter->conn, sender,
 						media_player_exit, mp,
 						NULL);
-- 
on behalf of ST-Ericsson

