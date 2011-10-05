Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 06/15] Bluetooth: Create hci_cancel_inquiry()
Date: Wed,  5 Oct 2011 20:20:38 -0300
Message-Id: <1317856847-28167-7-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1317856847-28167-1-git-send-email-andre.guedes@openbossa.org>
References: <1317856847-28167-1-git-send-email-andre.guedes@openbossa.org>
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
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_core.c         |   10 ++++++++++
 net/bluetooth/mgmt.c             |    2 +-
 3 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b7c070b..4a79a50 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -915,5 +915,6 @@ void hci_le_ltk_reply(struct hci_conn *conn, u8 ltk[16]);
 void hci_le_ltk_neg_reply(struct hci_conn *conn);
 
 int hci_do_inquiry(struct hci_dev *hdev, u8 length);
+int hci_cancel_inquiry(struct hci_dev *hdev);
 
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8516420..e60f16a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2424,3 +2424,13 @@ int hci_do_inquiry(struct hci_dev *hdev, u8 length)
 
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
index 4f77468..d84f242 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1674,7 +1674,7 @@ static int stop_discovery(struct sock *sk, u16 index)
 		goto failed;
 	}
 
-	err = hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
+	err = hci_cancel_inquiry(hdev);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 
-- 
1.7.5.2

