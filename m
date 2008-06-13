Return-Path: <cyrus@holtmann.org>
Message-ID: <049e01c8ccf1$013a4600$0132a8c0@Raymondpc>
From: "skyflame" <skyflame@21cn.com>
To: "hong zhang" <henryzhang62@yahoo.com>,
	"BlueZ development" <bluez-devel@lists.sourceforge.net>,
	<attaboyu@163.com>
References: <564535.96437.qm@web57901.mail.re3.yahoo.com>
Date: Fri, 13 Jun 2008 09:01:22 +0800
MIME-Version: 1.0
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



> Raymond,
>
> Have you tried to use psr file from your demo package.
> If demo package works then its psr file should be
> good.
>

Hi Heny

the csr's demo do not use bluez , it is so called bchs, and it don't have 
psr file , it send the pskey in it's startup function.

I send the same pskey by psr file yesterday, it's not working

And I think the problem is not what kind of pskey I should send :

But , if I set the uart baudrate with pskey, after warm reset, the 
connection with the chip is lost.

If I do not set the baudrate pskey, after warm reset, the chip turn to it's 
start stat call tshy stat ... and then every thing went wrong.

Do you encounter such things? Can you set the baudrate and after warmreset 
the chip still work ?

Thanks.

> I only have experience for CSR with eeprom where psr
> file is preload.



-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
