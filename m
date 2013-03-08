Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 6/6] Bluetooth: Add LE scan type macros
Date: Fri,  8 Mar 2013 20:06:19 -0300
Message-Id: <1362783979-10142-7-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1362783979-10142-1-git-send-email-andre.guedes@openbossa.org>
References: <1362783979-10142-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds macros for active and passive LE scan type values. It
also removes the LE_SCAN_TYPE macro since it is not used anymore.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h | 4 ++++
 net/bluetooth/mgmt.c             | 3 +--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0e4d893..8ce48ee 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1163,6 +1163,10 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
 							__u8 ltk[16]);
 int hci_do_inquiry(struct hci_dev *hdev, u8 length);
 int hci_cancel_inquiry(struct hci_dev *hdev);
+
+#define LE_SCAN_PASSIVE		0x00
+#define LE_SCAN_ACTIVE		0x01
+
 int hci_le_scan(struct hci_request *req, u8 type, u16 interval, u16 window);
 int hci_cancel_le_scan(struct hci_dev *hdev);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 8567bec..e6dde64 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -106,7 +106,6 @@ static const u16 mgmt_events[] = {
  * These LE scan and inquiry parameters were chosen according to LE General
  * Discovery Procedure specification.
  */
-#define LE_SCAN_TYPE			0x01
 #define LE_SCAN_WIN			0x12
 #define LE_SCAN_INT			0x12
 #define LE_SCAN_TIMEOUT_LE_ONLY		msecs_to_jiffies(10240)
@@ -2519,7 +2518,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 
 		hci_req_init(&req, hdev);
 
-		err = hci_le_scan(&req, LE_SCAN_TYPE, LE_SCAN_INT,
+		err = hci_le_scan(&req, LE_SCAN_ACTIVE, LE_SCAN_INT,
 				  LE_SCAN_WIN);
 		if (err)
 			break;
-- 
1.8.1.2

