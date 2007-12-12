Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <e378cfb20712032238t7a07a305k8f039d81c6d96154@mail.gmail.com>
References: <e378cfb20712022232yff12800gd8a6ae68dffbb530@mail.gmail.com>
	<1196699321.12292.118.camel@violet>
	<e378cfb20712032238t7a07a305k8f039d81c6d96154@mail.gmail.com>
Date: Wed, 12 Dec 2007 16:47:45 +0100
Message-Id: <1197474465.5644.9.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Support for multicasting in bluetooth
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

> 
> Thanks for the reply, i basically want to stream audio over a network
> of Bluetooth enabled devices in a piconet. I had a look at PAN
> profile. On the kernel side i saw BNEP has multicast filter support.
> So i figured that software has multicast support, its the hardware
> that should support multicast support.  

if you use multicast in a point-to-point connection, it doesn't mean
that it is a real multicast. So don't confuse higher level multicast
support with multicast support of the Bluetooth radio. If the baseband
doesn't support it, it doesn't matter what the higher protocols layers
support.

And you should really get yourself a book with the Bluetooth basics. If
you don't understand how the basics work, you have problems to
understand what are the limitations of Bluetooth.

Regards

Marcel



-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
