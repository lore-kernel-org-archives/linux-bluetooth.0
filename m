Return-Path: <konrad.zapalowicz@canonical.com>
From: Konrad Zapalowicz <konrad.zapalowicz@canonical.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	=?UTF-8?q?Konrad=20Zapa=C5=82owicz?= <konrad.zapalowicz@canonical.com>
Subject: [PATCH] bluetooth: increase timeout for le auto connections
Date: Tue, 17 Oct 2017 15:53:49 +0200
Message-Id: <1508248429-19415-1-git-send-email-konrad.zapalowicz@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

From: Konrad Zapałowicz <konrad.zapalowicz@canonical.com>

This patch increases the connection timeout for LE connections that are
triggered by the advertising report to 4 seconds.

It has been observed that devices equipped with wifi+bt combo SoC fail
to create a connection with BLE devices due to their coexistence issues.
Increasing this timeout gives them enough time to complete the
connection with success.

Signed-off-by: Konrad Zapałowicz <konrad.zapalowicz@canonical.com>
---
 include/net/bluetooth/hci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index fe98f0a..1668211 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -273,7 +273,7 @@ enum {
 #define HCI_AUTO_OFF_TIMEOUT	msecs_to_jiffies(2000)	/* 2 seconds */
 #define HCI_POWER_OFF_TIMEOUT	msecs_to_jiffies(5000)	/* 5 seconds */
 #define HCI_LE_CONN_TIMEOUT	msecs_to_jiffies(20000)	/* 20 seconds */
-#define HCI_LE_AUTOCONN_TIMEOUT	msecs_to_jiffies(2000)	/* 2 seconds */
+#define HCI_LE_AUTOCONN_TIMEOUT	msecs_to_jiffies(4000)	/* 4 seconds */
 
 /* HCI data types */
 #define HCI_COMMAND_PKT		0x01
-- 
2.7.4
