Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: [patch]full autosuspend for btusb
Date: Mon, 13 Oct 2008 11:10:19 +0200
Cc: Greg KH <greg@kroah.com>, USB list <linux-usb@vger.kernel.org>,
	linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200810131110.19630.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

this is the full autosuspend support for btusb.
It depends on the patch usb-anchor-api-changes-needed-for-btusb.patch
and should go in after it to allow bisect to work under all circumstances.

	Regards
		Oliver
