Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [rfc]btusb with SCO support
Date: Tue, 19 Aug 2008 09:30:58 +0200
Cc: linux-bluetooth@vger.kernel.org,
 linux-usb@vger.kernel.org,
 Alan Stern <stern@rowland.harvard.edu>
References: <200807311452.24166.oliver@neukum.org> <200808190903.05919.oliver@neukum.org> <1219130384.7591.83.camel@violet.holtmann.net>
In-Reply-To: <1219130384.7591.83.camel@violet.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200808190930.59698.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Dienstag 19 August 2008 09:19:44 schrieb Marcel Holtmann:
> So do we have any chance to make usb_set_interface asynchron? For
> example have the USB core queue submitted URBs until the new alternate
> setting has been selected?

Alan,

this one's for you. Is there a deeper reason we enable and disable endpoints
therein?

	Regards
		Oliver
