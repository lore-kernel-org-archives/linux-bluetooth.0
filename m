Return-Path: <edd@usefulinc.com>
From: Edd Dumbill <edd@usefulinc.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1086429803.16316.44.camel@pegasus>
References: <1086429803.16316.44.camel@pegasus>
Message-Id: <1086791061.17594.53.camel@saag>
Mime-Version: 1.0
Date: Wed, 09 Jun 2004 15:24:21 +0100
Subject: Re: [Bluez-users] Bluetooth 1.2 and HID Proxy
Content-Type: text/plain
List-ID: <bluez-users.lists.sourceforge.net>

On Sat, 2004-06-05 at 12:03 +0200, Marcel Holtmann wrote:
> The bad news are that you must extract the file GenericCSR.dfu from the
> Apple firmware update. Actually that is impossible without using Mac OS.
> And the other problem is that you need a DFU Upgrade utility. The CSR
> one is not for free and I never really finished the download code for
> btdfu. Right now I don't know how to get these two thinks worked out.

I wonder if those code is a good starting point for DFU download:
http://www.alfalab.ca/arm/arm.html

It looks as though it needs updating for the current libusb API a
little, but might be useful to you.

-- Edd
