Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [rfc]btusb with SCO support
Date: Mon, 18 Aug 2008 23:26:47 +0200
Cc: linux-bluetooth@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <200807311452.24166.oliver@neukum.org> <200808181803.48778.oliver@neukum.org> <1219079273.7591.62.camel@violet.holtmann.net>
In-Reply-To: <1219079273.7591.62.camel@violet.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200808182326.48365.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Montag 18 August 2008 19:07:53 schrieb Marcel Holtmann:
> Hi Oliver,
> 
> > > actually we can't move the URB killing for ACL into notify() since that
> > > gives me a kernel panic (fatal exception in interrupt).
> > > 
> > > Your patch for the IRQ disabling doesn't make a difference.
> > 
> > Please send me the version that triggers it.
> 
> the attached version makes it oops. Just create a connection with rfcomm
> or sdptool and you will see it when disconnecting.

This is a context you cannot sleep in:

@@ -504,8 +674,62 @@ static void btusb_notify(struct hci_dev *hdev, unsigned int evt)
 
 	BT_DBG("%s evt %d", hdev->name, evt);
 
-	if (evt == HCI_NOTIFY_CONN_ADD || evt == HCI_NOTIFY_CONN_DEL)
-		schedule_work(&data->work);
+	if (hdev->conn_hash.acl_num > 0) {
+		if (!test_and_set_bit(BTUSB_BULK_RUNNING, &data->flags)) {
+			if (btusb_submit_bulk_urb(hdev) < 0)
+				clear_bit(BTUSB_BULK_RUNNING, &data->flags);
+			else
+				btusb_submit_bulk_urb(hdev);
+		}
+	} else {
+		clear_bit(BTUSB_BULK_RUNNING, &data->flags);
+		usb_kill_anchored_urbs(&data->bulk_anchor);

But you use usb_kill_anchored_urbs(). You should use usb_unlink_anchored_urbs()

	Regards
		Oliver
