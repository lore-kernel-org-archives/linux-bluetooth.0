Return-Path: <cyrus@holtmann.org>
Subject: [PATCH 0/2] Bluetooth: btusb: handle usb_submit_urb error similarly
From: Paul Bolle <pebolle@tiscali.nl>
To: Marcel Holtmann <marcel@holtmann.org>, "Gustavo F. Padovan"
 <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 09 Oct 2011 12:11:30 +0200
Message-ID: <1318155090.1903.22.camel@x61.thuisdomein>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

0) These two patches are follow-ups to commit
4935f1c164ac528dff3538f97953b385ba500710 ("Bluetooth: btusb: be quiet on
device disconnect"). One difference with that commit is that I stopped
adding comments explaining -EPERM and -ENODEV, because it seemed a bit
silly to repeat those comments that often.

1) Note that I haven't actually ever seen the errors I now hide (in case
of "urb is being killed" or "device got disconnected") in the second
patch, so I'd appreciate a more careful review of that patch.

2) Also note that there's a call of usb_submit_urb() in play_deferred()
which never prints an error. Should it do that if usb_submit_urb()
returns a negative value?

Paul Bolle (2):
  Bluetooth: btusb: also be quiet when suspending
  Bluetooth: btusb: hide more usb_submit_urb errors

 drivers/bluetooth/btusb.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

-- 
1.7.4.4
