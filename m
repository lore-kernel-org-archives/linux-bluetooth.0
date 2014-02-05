Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH v2 5/5] android/pan: Fix bnep interface name
Date: Wed,  5 Feb 2014 17:00:34 +0100
Message-Id: <1391616034-23312-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1391616034-23312-1-git-send-email-szymon.janc@tieto.com>
References: <1391616034-23312-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>

Android uses bt-pan static interface in PAN profile. In server role
it uses it as bridge name. But current implementaion passes interface
names like bnep0, bnep1... Android Framework is unaware of this name
and unable to allocate IP address after profile connection setup.
---
 android/pan.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index b5f8d56..eeeadeb 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -51,8 +51,9 @@
 
 #define SVC_HINT_NETWORKING 0x02
 
-#define BNEP_BRIDGE "bnep"
+#define BNEP_BRIDGE "bt-pan"
 #define BNEP_PANU_INTERFACE "bt-pan"
+#define BNEP_NAP_INTERFACE "bt-pan%d"
 #define FORWARD_DELAY_PATH "/sys/class/net/"BNEP_BRIDGE"/bridge/forward_delay"
 
 static bdaddr_t adapter_addr;
@@ -221,8 +222,13 @@ static void bt_pan_notify_ctrl_state(struct pan_device *dev, uint8_t state)
 	ev.state = state;
 	ev.local_role = local_role;
 	ev.status = HAL_STATUS_SUCCESS;
+
 	memset(ev.name, 0, sizeof(ev.name));
-	memcpy(ev.name, dev->iface, sizeof(dev->iface));
+
+	if (local_role == HAL_PAN_ROLE_NAP)
+		memcpy(ev.name, BNEP_BRIDGE, sizeof(BNEP_BRIDGE));
+	else
+		memcpy(ev.name, dev->iface, sizeof(dev->iface));
 
 	ipc_send_notif(HAL_SERVICE_ID_PAN, HAL_EV_PAN_CTRL_STATE, sizeof(ev),
 									&ev);
@@ -534,6 +540,9 @@ static void nap_confirm_cb(GIOChannel *chan, gpointer data)
 	local_role = HAL_PAN_ROLE_NAP;
 	dev->role = HAL_PAN_ROLE_PANU;
 
+	strncpy(dev->iface, BNEP_NAP_INTERFACE, 16);
+	dev->iface[15] = '\0';
+
 	dev->io = g_io_channel_ref(chan);
 	g_io_channel_set_close_on_unref(dev->io, TRUE);
 
-- 
1.8.3.2

