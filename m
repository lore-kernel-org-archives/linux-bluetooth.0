Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Feb 2015 18:28:56 -0800
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: "An, Tedd" <tedd.an@intel.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [RFC 1/2] Bluetooth: Add led_off callback to manually turn off the
 LED before closing device
Message-ID: <20150204182856.43bd5644@tedd-test>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This callback allows a vendor to send the vendor specific command, for example
turn off the LED, before cloing the hci interface.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 include/net/bluetooth/hci_core.h | 1 +
 net/bluetooth/hci_core.c         | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 52863c3..99a9ecd 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -377,6 +377,7 @@ struct hci_dev {
 	void (*notify)(struct hci_dev *hdev, unsigned int evt);
 	void (*hw_error)(struct hci_dev *hdev, u8 code);
 	int (*set_bdaddr)(struct hci_dev *hdev, const bdaddr_t *bdaddr);
+	int (*led_off)(struct hci_dev *hdev);
 };
 
 #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3322d3f..329f117 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1591,6 +1591,10 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 {
 	BT_DBG("%s %p", hdev->name, hdev);
 
+	/* allows vendors to send the command before close the device */
+	if (!test_bit(HCI_UNREGISTER, &hdev->dev_flags) && hdev->led_off)
+		hdev->led_off(hdev);
+
 	cancel_delayed_work(&hdev->power_off);
 
 	hci_req_cancel(hdev, ENODEV);
-- 
1.9.1

