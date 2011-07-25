Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH v2 07/16] Bluetooth: Create cancel_inquiry()
Date: Mon, 25 Jul 2011 16:49:56 -0300
Message-Id: <1311623405-31108-8-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1311623405-31108-1-git-send-email-andre.guedes@openbossa.org>
References: <1311623405-31108-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch moves all cancel inquiry code from stop_discovery() to
a new function called cancel_inquiry().

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/mgmt.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7ea8f95..e43940e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1665,6 +1665,11 @@ failed:
 	return err;
 }
 
+static int cancel_inquiry(struct hci_dev *hdev)
+{
+	return hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
+}
+
 static int stop_discovery(struct sock *sk, u16 index)
 {
 	struct hci_dev *hdev;
@@ -1696,7 +1701,7 @@ static int stop_discovery(struct sock *sk, u16 index)
 		goto failed;
 	}
 
-	err = hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
+	err = cancel_inquiry(hdev);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 
-- 
1.7.4.1

