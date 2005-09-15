Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] power consumption
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1126765997.2406.16.camel@localhost.localdomain>
References: <1126765997.2406.16.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1126778108.28510.49.camel@station6.example.com>
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
Date: Thu, 15 Sep 2005 11:55:08 +0200

Hi David,

> I am working on an an embedded phone, so power consumption is very
> important to me. Bluez-utils-2.9 supports the following link policy,
> RSWITH, HOLD, PARK, SNIFF mode. Dose it support
> auto-sniff/hold/park-mode, or it must be done by ourselves by sending
> HCI command?

you should first update your bluez-utils, because version 2.9 is quite
old.

The auto-sniff is on my todo list, but so far I haven't done it and
nobody offered me something for doing it now. The support for hold mode
or park state is not needed. The hold mode is used internally by every
chip to support multiple connections with scatternet formation and the
park state doesn't give you any advantage at all. This means that you
have to use sniff at the moment by yourself. However the only source for
doing good decisions of putting a device into sniff mode, is the kernel
and thus the auto-sniff support should be implemented there.

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
