Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: linux-bluetooth@vger.kernel.org
Subject: implementing reset_resume() in btusb
Date: Wed, 3 Sep 2008 12:28:20 +0200
Cc: Marcel Holtmann <marcel@holtmann.org>,
 linux-usb@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200809031228.21116.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I've looked into implementing reset_resume() in btusb. It seems to
me that it cannot be done at the driver level. hci_dev_reset() does
not do what I need. Is there a support function in bluetooth core that could
be called to restore state?

	Regards
		Oliver
