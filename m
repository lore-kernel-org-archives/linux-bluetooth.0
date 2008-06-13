Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 13 Jun 2008 10:55:19 +0200
Message-ID: <499929A843E2C541A8AD31A881A2B6A201965229@hsl-lj-mail.hermes.si>
In-Reply-To: <03d101c8cc50$d2aa8660$0132a8c0@Raymondpc>
References: <03d101c8cc50$d2aa8660$0132a8c0@Raymondpc>
From: "Sanja Kolundzija" <Sanja.Kolundzija@hermes-softlab.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>,
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
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

> what is the right process ? Can any one help me out ?
> Thanks
=A0
> Raymond


Hi Raymond,

we are using BC6 ROM, and also had problems initializing it. This is the pr=
ocedure that works for us:

1. We run bccmd before hciattach!

bccmd -t BCSP -d /dev/ttyS2 psload -r pskeys.psr

Obviously, BC6 is connected to ttyS2. =


pskeys.psr looks like this:
=A0
// PSKEY_BDADDR
&0001 =3D 0044 5566 0033 1122
// PSKEY_UART_BAUDRATE - 921600
&01be =3D 0ebf
// PSKEY_ANA_FREQ
&01fe =3D 6590

Before executing bccmd, chip has baudrate 38400. After executing bccmd, bau=
drate will be 921600, so hciattach has to use that speed.=A0

bccmd without -r didn't work for us.
=A0

2. Now we run hciattach:

hciattach -s 921600 /dev/ttyS2 bcsp 921600 noflow

After this we do hciconfig hci0 reset, and continue working with hci0 devic=
e normally from BlueZ.

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
