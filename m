Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 02/32] android/handsfree: Connect SCO audio on demand
Date: Fri,  4 Jul 2014 16:46:47 +0300
Message-Id: <1404481637-900-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1404481637-900-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1404481637-900-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/handsfree.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index f27c93b..a2e3921 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -169,6 +169,8 @@ static GIOChannel *hsp_server = NULL;
 
 static GIOChannel *sco_server = NULL;
 
+static void bt_sco_connect(const void *buf, uint16_t len);
+
 static void device_set_state(uint8_t state)
 {
 	struct hal_ev_handsfree_conn_state ev;
@@ -892,6 +894,9 @@ static void connect_sco_cb(GIOChannel *chan, GError *err, gpointer user_data)
 							sco_watch_cb, NULL);
 
 	device_set_audio_state(HAL_EV_HANDSFREE_AUDIO_STATE_CONNECTED);
+
+	if (ipc_is_connected(sco_ipc))
+		bt_sco_connect(NULL, 0);
 }
 
 static bool connect_sco(void)
@@ -2577,8 +2582,12 @@ static void bt_sco_connect(const void *buf, uint16_t len)
 
 	DBG("");
 
-	if (!device.sco)
-		goto failed;
+	if (!device.sco) {
+		DBG("SCO is not established, connecting...");
+		if (!connect_audio())
+			goto failed;
+		return;
+	}
 
 	err = NULL;
 	if (!bt_io_get(device.sco, &err, BT_IO_OPT_MTU, &rsp.mtu,
-- 
1.9.1

