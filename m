Return-Path: <cyrus@holtmann.org>
From: Simon Fels <simon.fels@canonical.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Fels <simon.fels@canonical.com>
Subject: [PATCH v2] bluetooth: ask for MWS transport config only if controller supports 4.1
Date: Tue, 15 Sep 2015 11:29:41 +0200
Message-Id: <1442309381-15914-1-git-send-email-simon.fels@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some controllers doesn't seem to clear the bitfield to indicate which
HCI commands are supported correctly. This leads to wrong conclusions
which HCI commands we can send at initialization time. In this case
the problem appeared with the command to retrieve the MWS transport
configuration which is only available since version 4.1

Signed-off-by: Simon Fels <simon.fels@canonical.com>
---
 include/net/bluetooth/bluetooth.h | 1 +
 net/bluetooth/hci_core.c          | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index fcf2ae7..d4a070a 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -38,6 +38,7 @@
 #define BLUETOOTH_VER_1_1	1
 #define BLUETOOTH_VER_1_2	2
 #define BLUETOOTH_VER_2_0	3
+#define BLUETOOTH_VER_4_1	7
 
 /* Reserv for core and drivers use */
 #define BT_SKB_RESERVE	8
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a7cdd99..f376ab6 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -824,8 +824,13 @@ static void hci_init4_req(struct hci_request *req, unsigned long opt)
 	if (hdev->commands[29] & 0x20)
 		hci_req_add(req, HCI_OP_READ_LOCAL_CODECS, 0, NULL);
 
-	/* Get MWS transport configuration if the HCI command is supported */
-	if (hdev->commands[30] & 0x08)
+	/* Get MWS transport configuration if the HCI command is supported
+	 * but only when reported HCI version is at minimum 4.1. Some
+	 * controllers doesn't seem to clear the bit field they transmit
+	 * correctly so all resevered fields are invalid and let to
+	 * failing commands */
+	if (hdev->hci_ver >= BLUETOOTH_VER_4_1 &&
+		hdev->commands[30] & 0x08)
 		hci_req_add(req, HCI_OP_GET_MWS_TRANSPORT_CONFIG, 0, NULL);
 
 	/* Check for Synchronization Train support */
-- 
2.1.4

