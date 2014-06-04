Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCV2 28/28] android/handsfree: Refactor SCO audio connect sequence
Date: Wed,  4 Jun 2014 17:17:59 +0300
Message-Id: <1401891479-11965-28-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use connect_pending to identify when we need to return msg to HAL.
---
 android/handsfree.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 49e6a22..28fcb2c 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -169,7 +169,8 @@ static GIOChannel *hsp_server = NULL;
 
 static GIOChannel *sco_server = NULL;
 
-static void bt_sco_connect(const void *buf, uint16_t len);
+static bool connect_pending = false;
+static void bt_sco_connect_rsp(bool is_error);
 
 static void device_set_state(uint8_t state)
 {
@@ -896,7 +897,7 @@ static void connect_sco_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	device_set_audio_state(HAL_EV_HANDSFREE_AUDIO_STATE_CONNECTED);
 
 	if (ipc_is_connected(sco_ipc))
-		bt_sco_connect(NULL, 0);
+		bt_sco_connect_rsp(false);
 }
 
 static bool connect_sco(void)
@@ -2574,22 +2575,22 @@ static void disable_sco_server(void)
 	}
 }
 
-static void bt_sco_connect(const void *buf, uint16_t len)
+static void bt_sco_connect_rsp(bool is_error)
 {
 	int fd;
-	GError *err;
+	GError *err = NULL;
 	struct sco_rsp_connect rsp;
 
-	DBG("");
+	DBG("error %d pending %d", is_error, connect_pending);
 
-	if (!device.sco) {
-		DBG("SCO is not established, connecting...");
-		if (!connect_audio())
-			goto failed;
+	if (!connect_pending)
 		return;
-	}
 
-	err = NULL;
+	connect_pending = false;
+
+	if (is_error)
+		goto failed;
+
 	if (!bt_io_get(device.sco, &err, BT_IO_OPT_MTU, &rsp.mtu,
 							BT_IO_OPT_INVALID)) {
 		error("Unable to get MTU: %s\n", err->message);
@@ -2610,6 +2611,24 @@ failed:
 	ipc_send_rsp(sco_ipc, SCO_SERVICE_ID, SCO_OP_STATUS, SCO_STATUS_FAILED);
 }
 
+static void bt_sco_connect(const void *buf, uint16_t len)
+{
+	DBG("");
+
+	connect_pending = true;
+
+	if (!device.sco) {
+		DBG("SCO is not established, connecting...");
+		if (!connect_audio()) {
+			DBG("Connect audio failed");
+			return bt_sco_connect_rsp(true);
+		} else
+			return;
+	}
+
+	return bt_sco_connect_rsp(false);
+}
+
 static const struct ipc_handler sco_handlers[] = {
 	/* SCO_OP_CONNECT */
 	{ bt_sco_connect, false, 0 }
-- 
1.8.3.2

