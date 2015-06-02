Return-Path: <cyrus@holtmann.org>
From: Laura Abbott <labbott@fedoraproject.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Laura Abbott <labbott@fedoraproject.org>,
        Alan Stern <stern@rowland.harvard.edu>, Takashi Iwai <tiwai@suse.de>,
        Oliver Neukum <oneukum@suse.com>, Ming Lei <ming.lei@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>, netdev <netdev@vger.kernel.org>
Subject: [PATCH 2/2] Bluetooth: btusb: Add reset_resume function
Date: Mon,  1 Jun 2015 18:14:42 -0700
Message-Id: <1433207682-15064-2-git-send-email-labbott@fedoraproject.org>
In-Reply-To: <1433207682-15064-1-git-send-email-labbott@fedoraproject.org>
References: <1433207682-15064-1-git-send-email-labbott@fedoraproject.org>
In-Reply-To: <DF182762-5B64-4B76-8D3E-AF3728102881@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>


Some USB hubs may lose power across suspend/resume.
Add a reset_resume callback to properly reset those bluetoot devices.

Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
---
Now the setup function is called again with the HCI_RESET_RESUME
flag set. The various functions could then use that RESET_RESUME
flag to determine if loading the firmware is appropriate or not.
---
 drivers/bluetooth/btusb.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3c10d4d..34884cf 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3382,6 +3382,21 @@ done:
 
 	return err;
 }
+
+static int btusb_reset_resume(struct usb_interface *intf)
+{
+	struct btusb_data *data = usb_get_intfdata(intf);
+	struct hci_dev *hdev = data->hdev;
+	int ret;
+
+	BT_DBG("intf %p", intf);
+
+	ret = btusb_resume(intf);
+	if (ret)
+		return ret;
+
+	return hci_reset_resume_dev(hdev);
+}
 #endif
 
 static struct usb_driver btusb_driver = {
@@ -3391,6 +3406,7 @@ static struct usb_driver btusb_driver = {
 #ifdef CONFIG_PM
 	.suspend	= btusb_suspend,
 	.resume		= btusb_resume,
+	.reset_resume	= btusb_reset_resume,
 #endif
 	.id_table	= btusb_table,
 	.supports_autosuspend = 1,
-- 
2.4.1
