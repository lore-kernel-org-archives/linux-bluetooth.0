Return-Path: <cyrus@holtmann.org>
Message-Id: <DBFFAB62-8CD8-4827-93A2-19B6E884AD27@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Jiri Slaby <jirislaby@gmail.com>
In-Reply-To: <1206543023-10767-1-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Wed, 26 Mar 2008 17:18:46 +0100
References: <1206543023-10767-1-git-send-email-jirislaby@gmail.com>
Cc: bluez-devel@lists.sourceforge.net,
	Maxim Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] [PATCH] HIDD: add psm offset possibilty
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Jiri,

> This feature allows using cell phones as remote controllers, because  
> it
> usually denies to bind psms lower than 0x1000.

you have to explain why this is needed and useful since even creating  
the HID device needs root capabilities.

And why for example using the input service with its D-Bus API is not  
working for you.

Regards

Marcel


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
