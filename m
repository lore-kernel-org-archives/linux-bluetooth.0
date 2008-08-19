Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: question on btusb_open()
Date: Tue, 19 Aug 2008 14:57:07 +0200
References: <200808191425.50406.oliver@neukum.org> <1219149374.7591.132.camel@violet.holtmann.net>
In-Reply-To: <1219149374.7591.132.camel@violet.holtmann.net>
Cc: linux-bluetooth@vger.kernel.org,
 linux-usb@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200808191457.07486.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Dienstag 19 August 2008 14:36:14 schrieben Sie:
> Hi Oliver,
> 
> > if this function is reentered there's a race with the error path. Can
> > it be reentered?
> 
> no. The Bluetooth core will protect against it. The open callback will
> be triggered by "hciconfig hci0 up" or hcid/bluetoothd.

Good. I can see no further obvious bugs in btusb. I am going on to do
power management for it.

	Regards
		Oliver
