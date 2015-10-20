Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Introduce driver specific post init callback
Date: Tue, 20 Oct 2015 23:25:42 +0200
Message-Id: <1445376342-94161-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some drivers might have to restore certain settings after the init
procedure has been completed. This driver callback allows them to hook
into that stage. This callback is run just before the controller is
declared as powered up.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 1 +
 net/bluetooth/hci_core.c         | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 989c72aabc45..44fb95685611 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -398,6 +398,7 @@ struct hci_dev {
 	int (*send)(struct hci_dev *hdev, struct sk_buff *skb);
 	void (*notify)(struct hci_dev *hdev, unsigned int evt);
 	void (*hw_error)(struct hci_dev *hdev, u8 code);
+	int (*post_init)(struct hci_dev *hdev);
 	int (*set_diag)(struct hci_dev *hdev, bool enable);
 	int (*set_bdaddr)(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 };
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ac5cb251f9fb..964fba4c96bf 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1503,8 +1503,11 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 
 	if (!ret) {
 		if (!hci_dev_test_flag(hdev, HCI_UNCONFIGURED) &&
-		    !hci_dev_test_flag(hdev, HCI_USER_CHANNEL))
+		    !hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
 			ret = __hci_init(hdev);
+			if (!ret && hdev->post_init)
+				ret = hdev->post_init(hdev);
+		}
 	}
 
 	/* If the HCI Reset command is clearing all diagnostic settings,
-- 
2.4.3

