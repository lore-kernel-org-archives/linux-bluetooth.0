Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC 08/16] Bluetooth: Create cancel_inquiry()
Date: Fri, 10 Jun 2011 16:36:05 -0300
Message-Id: <1307734573-1630-9-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1307734573-1630-1-git-send-email-andre.guedes@openbossa.org>
References: <1307734573-1630-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch moves all cancel inquiry code from stop_discovery() to
a new function called cancel_inquiry().

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/mgmt.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 21bbf69..36f6bc2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1647,6 +1647,12 @@ failed:
 	return err;
 }
 
+/* hdev must be locked */
+static inline int cancel_inquiry(struct hci_dev *hdev)
+{
+	return hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
+}
+
 static int stop_discovery(struct sock *sk, u16 index)
 {
 	struct hci_dev *hdev;
@@ -1679,7 +1685,7 @@ static int stop_discovery(struct sock *sk, u16 index)
 	}
 
 	if (test_bit(HCI_INQUIRY, &hdev->flags))
-		err = hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
+		err = cancel_inquiry(hdev);
 
 	if (err < 0)
 		mgmt_pending_remove(cmd);
-- 
1.7.4.1

