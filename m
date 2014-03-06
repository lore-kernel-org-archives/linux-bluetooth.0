Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] android/avrcp: Add remote features notification
Date: Thu,  6 Mar 2014 15:03:20 +0200
Message-Id: <1394111003-2396-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/android/avrcp.c b/android/avrcp.c
index cb46dcc..d5eb31d 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -43,6 +43,7 @@
 #include "ipc.h"
 #include "bluetooth.h"
 #include "avrcp.h"
+#include "utils.h"
 
 #define L2CAP_PSM_AVCTP 0x17
 
@@ -699,6 +700,7 @@ static const struct avrcp_control_handler control_handlers[] = {
 static int avrcp_device_add_session(struct avrcp_device *dev, int fd,
 						uint16_t imtu, uint16_t omtu)
 {
+	struct hal_ev_avrcp_remote_features ev;
 	char address[18];
 
 	dev->session = avrcp_new(fd, imtu, omtu, dev->version);
@@ -717,6 +719,21 @@ static int avrcp_device_add_session(struct avrcp_device *dev, int fd,
 	/* FIXME: get the real name of the device */
 	avrcp_init_uinput(dev->session, "bluetooth", address);
 
+	bdaddr2android(&dev->dst, ev.bdaddr);
+	ev.features = HAL_AVRCP_FEATURE_NONE;
+
+	DBG("version 0x%02x", dev->version);
+
+	if (dev->version < 0x0103)
+		goto done;
+
+	ev.features |= HAL_AVRCP_FEATURE_METADATA;
+
+done:
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_AVRCP,
+					HAL_EV_AVRCP_REMOTE_FEATURES,
+					sizeof(ev), &ev);
+
 	return 0;
 }
 
-- 
1.8.5.3

