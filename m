Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Allow SCO with Asus WL-BTD202 dongle in btusb
From: Marcel Holtmann <marcel@holtmann.org>
To: Guillaume Bedot <littletux@zarb.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1225167617.7998.10.camel@localhost>
References: <1225152042.17240.18.camel@localhost>
	 <1225159804.7157.41.camel@californication>
	 <1225167617.7998.10.camel@localhost>
Content-Type: text/plain
Date: Sun, 30 Nov 2008 11:46:08 +0100
Message-Id: <1228041968.9176.12.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Guillaume,

> > > This an other patch that allows my dongle to be configured correctly for
> > > the voice/sco profile.
> > > 
> > > I already sent one for hci_usb some time ago, so it may sound familiar,
> > > but it probably didn't have correct style...
> > 
> > you have to prove this one. Boot a kernel without the patch and call
> > hciconfig hci0 up and then show me the output of hciconfig -a.
> 
> The file "hciconfig-...-before" was the output without the patch.
> The file "hciconfig-...-after" is the output with the patch.
> The last file contains some info from "/proc/bus/usb/devices".
> 
> Is it just proof that my dongle's firmware is out-of-date ?

I applied a modified patch to my tree since it didn't apply clean
anymore. Thanks.

Regards

Marcel


