Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: question on btusb_open()
Date: Tue, 19 Aug 2008 14:25:50 +0200
Cc: linux-bluetooth@vger.kernel.org,
 linux-usb@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200808191425.50406.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

if this function is reentered there's a race with the error path. Can
it be reentered?

	Regards
		Oliver
