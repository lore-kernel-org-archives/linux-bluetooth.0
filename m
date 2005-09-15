Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bluetooth speed
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050915090118.62189.qmail@web50602.mail.yahoo.com>
References: <20050915090118.62189.qmail@web50602.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1126777440.28510.43.camel@station6.example.com>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 15 Sep 2005 11:44:00 +0200

Hi Christian,

> I tested several phones to see the bluetooth speed
> (sending a file from a PC). Here's are the scores: 
> 
> Nokia 3650 - 24-26KB/sec 
> Motorola MPx220 - 10-11KB/sec 
> Sony Ericsson 1010 - 25-28KB/sec 

this depends on the internal UART inside the phone and of course it
depends on the supported packet types from the features.

> My PC's bluetooth device is a bluetooth 1.1 one. 
> My question is : why is bluetooth so slow?? There's
> something wrong with these phone or with my bluetooth
> device? Is a 1.2 bluetooth device faster? 
> What's new with bluetooth 2?

The speed improvement comes with Bluetooth 2.0 with EDR.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
