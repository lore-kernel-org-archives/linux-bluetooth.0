Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>,
 linux-bluetooth@vger.kernel.org
Subject: question on use of flags in btusb
Date: Sun, 10 May 2009 10:38:37 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200905101038.38169.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

btusb still has the BTUSB_INTR_RUNNING and BTUSB_BULK_RUNNING flags.
This seems to collide with the need to keep interrupt and bulk running.
Is this just legacy, a plan for future extensions or am I misunderstanding 
things?

	Regards
		Oliver
