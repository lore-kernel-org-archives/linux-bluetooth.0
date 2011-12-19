Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 2/5] Bluetooth: Initialize default flow control mode
Date: Mon, 19 Dec 2011 16:31:28 +0200
Message-Id: <1324305091-19393-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1324305091-19393-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1324305091-19393-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h |    4 ++++
 net/bluetooth/hci_core.c    |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c019b27..4ab1880 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -280,6 +280,10 @@ enum {
 #define HCI_ERROR_LOCAL_HOST_TERM	0x16
 #define HCI_ERROR_PAIRING_NOT_ALLOWED	0x18
 
+/* Flow control modes */
+#define HCI_FLOW_CTL_MODE_PACKET_BASED	0x00
+#define HCI_FLOW_CTL_MODE_BLOCK_BASED	0x01
+
 /* -----  HCI Commands ---- */
 #define HCI_OP_NOP			0x0000
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index bb089e3..884eb85 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -199,6 +199,8 @@ static void bredr_init(struct hci_dev *hdev)
 	__le16 param;
 	__u8 flt_type;
 
+	hdev->flow_ctl_mode = HCI_FLOW_CTL_MODE_PACKET_BASED;
+
 	/* Mandatory initialization */
 
 	/* Reset */
@@ -245,6 +247,8 @@ static void bredr_init(struct hci_dev *hdev)
 
 static void amp_init(struct hci_dev *hdev)
 {
+	hdev->flow_ctl_mode = HCI_FLOW_CTL_MODE_BLOCK_BASED;
+
 	/* Reset */
 	hci_send_cmd(hdev, HCI_OP_RESET, 0, NULL);
 
-- 
1.7.4.1

