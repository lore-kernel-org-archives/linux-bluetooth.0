Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth 1.2 and HID Proxy
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200406061210.52170.cijoml@volny.cz>
References: <1086429803.16316.44.camel@pegasus>
	 <200406052338.15162.cijoml@volny.cz> <1086476014.16316.129.camel@pegasus>
	 <200406061210.52170.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1086536540.4765.35.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 06 Jun 2004 17:42:20 +0200

Hi Michal,

> > currently I am preparing a site with notes about firmware upgrade and
> > DFU. I will also summarize the public statements of the CSR signature
> 
> Site is nice, but you should provide screenshoots of steps how to use MacOS to 
> extract that firmware. Many people (including me) don't know how to work with 
> MacOS :)

I don't either. Can anyone with Mac OS X write some small words how to
extract GenericCSR.dfu from the BluetoothFWUpdate1.1.dmg file?

Btw the best way is to reverse engineer the Apple UDIF disk image format
and provide an open source tool for it.

> > and so on. However don't expect a howto for getting firmware from one
> > device into another. I am not concerned in upgrading of any dongle,
> > because today an USB Bluetooth dongle is so cheap that you can buy
> > yourself a new one if the firmware is too old. I paid 14 EUR for my
> > D-Link dongle at eBay. 
> 
> This is bad way. We as customers should make a preasure to vendors to allow us 
> upgrade our devices for free! I better spend my 14 euros in cinema with my 
> girl :) When device allow me to upgrade it's functionality, vendors should 
> allow us to do it. And if not, other vendors will support us and then we 
> should make preasure to vendors via market to allow us upgrading our devices.
> And those how will block us to do it, we should turn them bankrupt via market.

You can't look at it with this naive view. The problem is much more
complex. I have contacts to many "Bluetooth companies" here in Germany,
but most of their products are build in Japan, Taiwan etc. The European
headquarters are better support and sales centers, because in most cases
they can't influence any decisions. Most companies I talked to are
willing to help, but actually they can't, because they don't have the
resources to do so.

My resources are limited, too. Only asking for firmware upgrade and
other information doesn't help. Start doing something and I mean start
writing code that allows us to work with. We still miss the DFU download
functionality and a PS Tool program for Linux.

> To firmware licencing. I think you can share your extracted firmware, because 
> of this:
> 
> Re: [Bluez-users] CSR firmware
> From:
> Carl Orsborn <cjo@csr.com>
> To: 
> cijoml@volny.cz
> Date: 
> 30.5.2004 09:58
> 
> SNIP
> >This is great on Intersil. They allow users to upgrade their firmwares in 
> >their wifi cards.
> >
> We also allow it, but we have provided the means to prevent it.
> 
> Carl
> SNIP

I don't get that point, but of course you can upload the firmware from
an already updated dongle. Actually I don't think that I am going to
provide such a firmware file. Maybe someone else and then I will link,
but without written permission from Apple I don't think so.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
