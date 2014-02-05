Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 4/5] android/pan: Fix unregistering NAP bridge
Date: Wed,  5 Feb 2014 17:00:33 +0100
Message-Id: <1391616034-23312-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1391616034-23312-1-git-send-email-szymon.janc@tieto.com>
References: <1391616034-23312-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix not removing NAP bridge in case of error or last device
disconnect.
---
 android/pan.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index 7e44e58..b5f8d56 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -72,11 +72,14 @@ struct pan_device {
 static struct {
 	uint32_t	record_id;
 	GIOChannel	*io;
+	bool		bridge;
 } nap_dev = {
 	.record_id = 0,
 	.io = NULL,
+	.bridge = false,
 };
 
+
 static int set_forward_delay(void)
 {
 	int fd, ret;
@@ -103,6 +106,9 @@ static int nap_create_bridge(void)
 
 	DBG("%s", BNEP_BRIDGE);
 
+	if (nap_dev.bridge)
+		return 0;
+
 	sk = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
 	if (sk < 0)
 		return -EOPNOTSUPP;
@@ -121,6 +127,8 @@ static int nap_create_bridge(void)
 
 	close(sk);
 
+	nap_dev.bridge = err == 0;
+
 	return err;
 }
 
@@ -130,6 +138,11 @@ static int nap_remove_bridge(void)
 
 	DBG("%s", BNEP_BRIDGE);
 
+	if (!nap_dev.bridge)
+		return 0;
+
+	nap_dev.bridge = false;
+
 	sk = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
 	if (sk < 0)
 		return -EOPNOTSUPP;
@@ -169,8 +182,10 @@ static void pan_device_free(struct pan_device *dev)
 	devices = g_slist_remove(devices, dev);
 	g_free(dev);
 
-	if (g_slist_length(devices) == 0)
+	if (g_slist_length(devices) == 0) {
 		local_role = HAL_PAN_ROLE_NONE;
+		nap_remove_bridge();
+	}
 }
 
 static void bt_pan_notify_conn_state(struct pan_device *dev, uint8_t state)
@@ -447,8 +462,12 @@ static gboolean nap_setup_cb(GIOChannel *chan, GIOCondition cond,
 		goto failed;
 	}
 
+	if (nap_create_bridge() < 0)
+		goto failed;
+
 	if (bnep_server_add(sk, dst_role, BNEP_BRIDGE, dev->iface,
 							&dev->dst) < 0) {
+		nap_remove_bridge();
 		error("server_connadd failed");
 		rsp = BNEP_CONN_NOT_ALLOWED;
 		goto failed;
@@ -549,14 +568,9 @@ static void destroy_nap_device(void)
 static int register_nap_server(void)
 {
 	GError *gerr = NULL;
-	int err;
 
 	DBG("");
 
-	err = nap_create_bridge();
-	if (err < 0)
-		return err;
-
 	nap_dev.io = bt_io_listen(NULL, nap_confirm_cb, NULL, NULL, &gerr,
 					BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
 					BT_IO_OPT_PSM, BNEP_PSM,
-- 
1.8.3.2

