Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCHes] Add sixpair
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1224083727.5268.3149.camel@cookie.hadess.net>
References: <1224083727.5268.3149.camel@cookie.hadess.net>
Content-Type: text/plain
Date: Wed, 15 Oct 2008 17:22:30 +0200
Message-Id: <1224084150.4764.12.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> Here are the patches to get sixpair support built into BlueZ. It uses
> libusb-1.0 as well as a yet to be merged libusb-1.0 patch to allow
> re-attaching a driver to a device.

with the 2.6.28 kernel we should get a better HID driver model (aka HID
bus) and then we might not need to libusb stuff anymore. We can go
directly to HID and read the descriptors and send vendor HID reports.

Regards

Marcel


