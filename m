Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 17 Jun 2008 10:25:09 +0200
Message-ID: <499929A843E2C541A8AD31A881A2B6A2019C1525@hsl-lj-mail.hermes.si>
In-Reply-To: <078501c8d02f$587b1200$0132a8c0@Raymondpc>
References: <03d101c8cc50$d2aa8660$0132a8c0@Raymondpc>
	<499929A843E2C541A8AD31A881A2B6A201965229@hsl-lj-mail.hermes.si>
	<060701c8cf51$f8730fd0$0132a8c0@Raymondpc>
	<499929A843E2C541A8AD31A881A2B6A2019C136C@hsl-lj-mail.hermes.si>
	<078501c8d02f$587b1200$0132a8c0@Raymondpc>
From: "Sanja Kolundzija" <Sanja.Kolundzija@hermes-softlab.com>
To: "skyflame" <skyflame@21cn.com>,
	"BlueZ development" <bluez-devel@lists.sourceforge.net>,
	<attaboyu@163.com>, "hong zhang" <henryzhang62@yahoo.com>
Subject: Re: [Bluez-devel] How to run up CSR chip without eeprom with BLUEZ ?
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

Hi Raymond,

great that it works! These CSR ROM devices can be really frustrating.

>     (  However, It is really strange here, without setting this value,
why 
> hciattach can connect the chip for the first time, while do a
warmreset , it 
> won't ? Is csr's chip do a self uart baudrate adjustment to match the
host 
> for the first time ? )

Yes, you are right, they perform auto-baud procedure at the beginning.
They don't have any value set, but guess from the incoming message what
is the baud rate. That's why if you look with the scope at signals, you
see that chip doesn't reply to the first message from the processor, but
needs typically few messages to guess the baud rate.

Regards,
Sanja

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
