Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] audio/media: Send status changed if position changes
Date: Fri, 11 Oct 2013 14:53:23 +0300
Message-Id: <1381492404-25765-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1381492404-25765-1-git-send-email-luiz.dentz@gmail.com>
References: <1381492404-25765-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If position changes send a status changed event to force the position to
be resynced.
---
 profiles/audio/media.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 646c76a..0adc7c2 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1306,13 +1306,21 @@ static gboolean set_status(struct media_player *mp, DBusMessageIter *iter)
 static gboolean set_position(struct media_player *mp, DBusMessageIter *iter)
 {
 	uint64_t value;
+	const char *status;
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_INT64)
 			return FALSE;
 
 	dbus_message_iter_get_basic(iter, &value);
 
-	mp->position = value / 1000;
+	value /= 1000;
+
+	if (value > get_position(mp))
+		status = "forward-seek";
+	else
+		status = "reverse-seek";
+
+	mp->position = value;
 	g_timer_start(mp->timer);
 
 	DBG("Position=%u", mp->position);
@@ -1327,9 +1335,14 @@ static gboolean set_position(struct media_player *mp, DBusMessageIter *iter)
 	 * If position is the maximum value allowed or greater than track's
 	 * duration, we send a track-reached-end event.
 	 */
-	if (mp->position == UINT32_MAX || mp->position >= mp->duration)
+	if (mp->position == UINT32_MAX || mp->position >= mp->duration) {
 		avrcp_player_event(mp->player, AVRCP_EVENT_TRACK_REACHED_END,
 									NULL);
+		return TRUE;
+	}
+
+	/* Send a status change to force resync the position */
+	avrcp_player_event(mp->player, AVRCP_EVENT_STATUS_CHANGED, status);
 
 	return TRUE;
 }
-- 
1.8.3.1

