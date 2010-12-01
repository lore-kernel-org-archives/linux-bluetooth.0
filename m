Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Rahul Ruikar <rahul.ruikar@gmail.com>
Date: Wed, 1 Dec 2010 22:24:19 +0530
Message-ID: <AANLkTi=4rW7kuYL0arf98UHBzNfiWz2-nixtP=2yx1sk@mail.gmail.com>
Subject: not able to connect mobile with laptop using bluetooth
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am not able to pair my mobile with laptop.
when I try to pair it..it times out very soonwhile tying "pin"
i get following error
Dec  1 22:17:38 ganesha bluetoothd[1094]: Discovery session 0xb8fc95b8
with :1.73 activated
Dec  1 22:17:48 ganesha bluetoothd[1094]: Stopping discovery
Dec  1 22:17:50 ganesha bluetoothd[1094]: link_key_request
(sba=00:16:CF:FB:D4:99, dba=00:23:AF:D7:53:20)
Dec  1 22:17:50 ganesha bluetoothd[1094]: pin_code_request
(sba=00:16:CF:FB:D4:99, dba=00:23:AF:D7:53:20)
Dec  1 22:18:01 ganesha NetworkManager[914]: <info> BT device
00:23:AF:D7:53:20 removed
Dec  1 22:18:01 ganesha bluetoothd[1094]: Stopping discovery

sometimes i get this error if i use option "Send files to device"
Dec  1 20:13:48 ganesha bluetoothd[1267]: link_key_notify
(sba=00:16:CF:FB:D4:99, dba=00:23:AF:D7:53:20, type=0)
Dec  1 20:13:59 ganesha bluetoothd[1267]: probe failed with driver
input-headset for device /org/bluez/1252/hci0/dev_00_23_AF_D7_53_20
Dec  1 20:13:59 ganesha bluetoothd[1267]: Stopping discovery
Dec  1 20:14:06 ganesha kernel: btusb_intr_complete: hci0 urb d15cf580
failed to resubmit (1)
Dec  1 20:14:06 ganesha kernel: btusb_bulk_complete: hci0 urb d15cf080
failed to resubmit (1)
Dec  1 20:14:06 ganesha kernel: btusb_bulk_complete: hci0 urb d15cf480
failed to resubmit (1)
Dec  1 20:14:24 ganesha kernel: btusb_intr_complete: hci0 urb d1491a00
failed to resubmit (1)
Dec  1 20:14:24 ganesha kernel: btusb_bulk_complete: hci0 urb d1491300
failed to resubmit (1)
Dec  1 20:14:24 ganesha kernel: btusb_bulk_complete: hci0 urb d1491b80
failed to resubmit (1)
Dec  1 20:14:37 ganesha kernel: btusb_intr_complete: hci0 urb f6683400
failed to resubmit (1)
Dec  1 20:14:37 ganesha kernel: btusb_bulk_complete: hci0 urb f6683200
failed to resubmit (1)
Dec  1 20:14:37 ganesha kernel: btusb_bulk_complete: hci0 urb f6683180
failed to resubmit (1)


any idea what could be wrong ..also why it says "input-headset"

Thanks,
Rahul
