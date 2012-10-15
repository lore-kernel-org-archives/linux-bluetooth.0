Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 11/16] AVRCP: Fix reading wrong profile when acting as a controller
Date: Mon, 15 Oct 2012 16:05:31 +0200
Message-Id: <1350309936-31588-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1350309936-31588-1-git-send-email-luiz.dentz@gmail.com>
References: <1350309936-31588-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The role indicate which record should be read so we properly determine
the version and what features are supported.
---
 audio/avrcp.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 7188039..8abb426 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -58,6 +58,9 @@
 #include "avrcp.h"
 #include "sdpd.h"
 #include "dbus-common.h"
+#include "control.h"
+#include "avdtp.h"
+#include "sink.h"
 
 /* Company IDs for vendor dependent commands */
 #define IEEEID_BTSIG		0x001958
@@ -181,6 +184,7 @@ struct avrcp {
 	struct avctp *conn;
 	struct audio_device *dev;
 	struct avrcp_player *player;
+	gboolean target;
 	uint16_t version;
 	int features;
 
@@ -1368,7 +1372,20 @@ static struct avrcp *session_create(struct avrcp_server *server,
 
 	server->sessions = g_slist_append(server->sessions, session);
 
-	rec = btd_device_get_record(dev->btd_dev, AVRCP_TARGET_UUID);
+	if (dev->sink && !dev->source)
+		session->target = TRUE;
+	else if (dev->source && !dev->sink)
+		session->target = FALSE;
+	else if (dev->sink && sink_is_active(dev))
+		session->target = TRUE;
+	else
+		session->target = FALSE;
+
+	if (session->target)
+		rec = btd_device_get_record(dev->btd_dev, AVRCP_REMOTE_UUID);
+	else
+		rec = btd_device_get_record(dev->btd_dev, AVRCP_TARGET_UUID);
+
 	if (rec == NULL)
 		return session;
 
-- 
1.7.11.4

