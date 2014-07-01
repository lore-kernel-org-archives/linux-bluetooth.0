Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Add support for hdev->set_bdaddr callback handling
Date: Wed,  2 Jul 2014 00:53:47 +0200
Message-Id: <1404255228-51661-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some embedded controllers allow the programming of a public address
and this adds vendor support for supporting OEM confguration of such
addresses.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_core.c         | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 01fbbe20defb..ee480a86e558 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -171,6 +171,7 @@ struct hci_dev {
 	__u8		bus;
 	__u8		dev_type;
 	bdaddr_t	bdaddr;
+	bdaddr_t	public_addr;
 	bdaddr_t	random_addr;
 	bdaddr_t	static_addr;
 	__u8		adv_addr_type;
@@ -344,6 +345,7 @@ struct hci_dev {
 	int (*setup)(struct hci_dev *hdev);
 	int (*send)(struct hci_dev *hdev, struct sk_buff *skb);
 	void (*notify)(struct hci_dev *hdev, unsigned int evt);
+	int (*set_bdaddr)(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 };
 
 #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 615d0cf5e511..63197d70d8eb 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2249,6 +2249,17 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 	if (hdev->setup && test_bit(HCI_SETUP, &hdev->dev_flags))
 		ret = hdev->setup(hdev);
 
+	/* If public address change is configured, ensure that the
+	 * address gets programmed. If the driver does not support
+	 * changing the public address, fail the power on procedure.
+	 */
+	if (!ret && bacmp(&hdev->public_addr, BDADDR_ANY)) {
+		if (hdev->set_bdaddr)
+			ret = hdev->set_bdaddr(hdev, &hdev->public_addr);
+		else
+			ret = -EADDRNOTAVAIL;
+	}
+
 	if (!ret) {
 		if (!test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks) &&
 		    !test_bit(HCI_USER_CHANNEL, &hdev->dev_flags))
-- 
1.9.3

