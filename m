Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 4/7] Bluetooth: Add LE scan type macros
Date: Fri,  1 Feb 2013 21:44:35 -0300
Message-Id: <1359765878-31409-5-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1359765878-31409-1-git-send-email-andre.guedes@openbossa.org>
References: <1359765878-31409-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds macros for active and passive LE scan type values. It
also removes the LE_SCAN_TYPE macro since it is not used anymore.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h | 3 +++
 net/bluetooth/mgmt.c             | 5 ++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 00923ef..b089968 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -117,6 +117,9 @@ struct oob_data {
 	u8 randomizer[16];
 };
 
+#define LE_SCAN_PASSIVE		0x00
+#define LE_SCAN_ACTIVE		0x01
+
 struct le_scan_params {
 	u8 type;
 	u16 interval;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 39395c7..43db12e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -106,7 +106,6 @@ static const u16 mgmt_events[] = {
  * These LE scan and inquiry parameters were chosen according to LE General
  * Discovery Procedure specification.
  */
-#define LE_SCAN_TYPE			0x01
 #define LE_SCAN_WIN			0x12
 #define LE_SCAN_INT			0x12
 #define LE_SCAN_TIMEOUT_LE_ONLY		10240	/* TGAP(gen_disc_scan_min) */
@@ -2485,7 +2484,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 			goto failed;
 		}
 
-		err = hci_le_scan(hdev, LE_SCAN_TYPE, LE_SCAN_INT,
+		err = hci_le_scan(hdev, LE_SCAN_ACTIVE, LE_SCAN_INT,
 				  LE_SCAN_WIN, LE_SCAN_TIMEOUT_LE_ONLY);
 		break;
 
@@ -2497,7 +2496,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 			goto failed;
 		}
 
-		err = hci_le_scan(hdev, LE_SCAN_TYPE, LE_SCAN_INT, LE_SCAN_WIN,
+		err = hci_le_scan(hdev, LE_SCAN_ACTIVE, LE_SCAN_INT, LE_SCAN_WIN,
 				  LE_SCAN_TIMEOUT_BREDR_LE);
 		break;
 
-- 
1.8.1.1

