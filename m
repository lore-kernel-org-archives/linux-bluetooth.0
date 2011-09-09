Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 06/16] Bluetooth: Create hci_cancel_inquiry()
Date: Fri,  9 Sep 2011 18:56:21 -0300
Message-Id: <1315605391-2407-7-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1315605391-2407-1-git-send-email-andre.guedes@openbossa.org>
References: <1315605391-2407-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a function to hci_core to cancel an ongoing inquiry.

According to the Bluetooth spec, the inquiry cancel command should
only be issued after the inquiry command has been issued, a command
status event has been received for the inquiry command, and before
the inquiry complete event occurs.

As HCI_INQUIRY flag is only set just after an inquiry command status
event occurs and it is cleared just after an inquiry complete event
occurs, the inquiry cancel command should be issued only if HCI_INQUIRY
flag is set.

Additionally, cancel inquiry related code from stop_discovery() were
replaced by a hci_cancel_inquiry() call.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_core.c         |   10 ++++++++++
 net/bluetooth/mgmt.c             |    2 +-
 3 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5ca07df..8992f24 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -917,5 +917,6 @@ void hci_le_ltk_reply(struct hci_conn *conn, u8 ltk[16]);
 void hci_le_ltk_neg_reply(struct hci_conn *conn);
 
 int hci_do_inquiry(struct hci_dev *hdev, u8 length);
+int hci_cancel_inquiry(struct hci_dev *hdev);
 
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index abe59b1..2509409 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2434,3 +2434,13 @@ int hci_do_inquiry(struct hci_dev *hdev, u8 length)
 
 	return hci_send_cmd(hdev, HCI_OP_INQUIRY, sizeof(cp), &cp);
 }
+
+int hci_cancel_inquiry(struct hci_dev *hdev)
+{
+	BT_DBG("%s", hdev->name);
+
+	if (!test_bit(HCI_INQUIRY, &hdev->flags))
+		return -EPERM;
+
+	return hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
+}
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7620c3a..8a2f243 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1695,7 +1695,7 @@ static int stop_discovery(struct sock *sk, u16 index)
 		goto failed;
 	}
 
-	err = hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
+	err = hci_cancel_inquiry(hdev);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 
-- 
1.7.5.2

