Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Problem with l2test, rctest
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <becc9d2c0509160023565fe262@mail.gmail.com>
References: <becc9d2c05091505534b795f7b@mail.gmail.com>
	 <becc9d2c05091506452748d6a0@mail.gmail.com>
	 <1126792737.3505.6.camel@station6.example.com>
	 <becc9d2c050915091830e5a609@mail.gmail.com>
	 <1126801476.15633.2.camel@localhost.localdomain>
	 <becc9d2c0509150944132bb8f1@mail.gmail.com>
	 <1126802829.15633.7.camel@localhost.localdomain>
	 <becc9d2c0509160023565fe262@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1126877009.5512.0.camel@localhost.localdomain>
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
Date: Fri, 16 Sep 2005 15:23:29 +0200

Hi Andrea,

> i think i ve solved the problem
> i ve set "hciconfig hciconfig hci0 lm ACCEPT" on my
> server side and the connection seems to go fine

this is what I expected, because it is not possible that both sides are
the master and thus the role switch fails. Don't change default values
when you don't know what they mean ;)

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
