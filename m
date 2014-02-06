Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 4/8] android/pan: Fix unregistering NAP bridge
Date: Thu,  6 Feb 2014 16:28:38 +0100
Message-Id: <1391700522-9036-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1391700522-9036-1-git-send-email-szymon.janc@tieto.com>
References: <1391700522-9036-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix not removing NAP bridge in case of error or last device
disconnect.
---
 android/pan.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index d010e09..0d6adaf 100644
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
 
@@ -130,6 +138,9 @@ static int nap_remove_bridge(void)
 
 	DBG("%s", BNEP_BRIDGE);
 
+	if (!nap_dev.bridge)
+		return 0;
+
 	sk = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
 	if (sk < 0)
 		return -EOPNOTSUPP;
@@ -140,6 +151,8 @@ static int nap_remove_bridge(void)
 	if (err < 0)
 		return -EOPNOTSUPP;
 
+	nap_dev.bridge = false;
+
 	return 0;
 }
 
@@ -175,8 +188,10 @@ static void pan_device_remove(struct pan_device *dev)
 {
 	devices = g_slist_remove(devices, dev);
 
-	if (g_slist_length(devices) == 0)
+	if (g_slist_length(devices) == 0) {
 		local_role = HAL_PAN_ROLE_NONE;
+		nap_remove_bridge();
+	}
 
 	pan_device_free(dev);
 }
@@ -455,8 +470,12 @@ static gboolean nap_setup_cb(GIOChannel *chan, GIOCondition cond,
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
@@ -557,14 +576,9 @@ static void destroy_nap_device(void)
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

