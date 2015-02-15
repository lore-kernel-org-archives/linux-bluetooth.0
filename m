Return-Path: <cyrus@holtmann.org>
From: "Kim, Ben Young Tae" <ytkim@qca.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH v2 1/2] Bluetooth: btusb: Add setup callback for chip init on
 USB
Date: Sun, 15 Feb 2015 23:06:14 +0000
Message-ID: <ed9be4d986c749d7a0b35a335184a932@nalasexr02e.na.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some of chipset does not allow to send a patch or config files through
HCI VS channel at early stage as well as they don't support to send
USB patch files to other channel except USB bulk path.

New callback added is for initialization of BT controller through USB

Signed-off-by: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3ca2e1b..73e1066 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -337,6 +337,8 @@ struct btusb_data {
 
 	int (*recv_event)(struct hci_dev *hdev, struct sk_buff *skb);
 	int (*recv_bulk)(struct btusb_data *data, void *buffer, int count);
+
+	int (*setup_on_usb)(struct hci_dev *hdev);
 };
 
 static inline void btusb_free_frags(struct btusb_data *data)
@@ -878,6 +880,15 @@ static int btusb_open(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
+	/* Patching USB firmware files prior to starting any URBs of HCI path
+	 * It is more safe to use USB bulk channel for downloading USB patch
+	 */
+	if (data->setup_on_usb) {
+		err = data->setup_on_usb(hdev);
+		if (err <0)
+			return err;
+	}
+
 	err = usb_autopm_get_interface(data->intf);
 	if (err < 0)
 		return err;
-- 
1.8.1.5
