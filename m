Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45118E52.8080303@csr.com>
Date: Wed, 20 Sep 2006 19:54:10 +0100
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <freemail.20060820112703.62459@fm06.freemail.hu>
In-Reply-To: <freemail.20060820112703.62459@fm06.freemail.hu>
Subject: Re: [Bluez-users] Changing BD address on CSR based USB dongle
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

SZABO Tamas wrote:
> First of all, I have a few USB-BT dongle (no brand info, CSR
> chipset, HCI and LMP ver. 2.0, EEPROM on the board). They
> all have the same BD address (Yes, it seems I bought pirated
> dongles).

Hmm, I'm guessing you can't tell me who manufactured the dongles?

Can you tell me the firmware revision and which Bluetooth address they're
booting up with (hciconfig version and hciconfig revision should give you
all that information)?

Are there any BlueZ tools that can dump all the values written to
persistent store for a module (equivalent to CSR's btcli's psslurp
command)? If so, a dump of the PS might be useful for me.

You say they have EEPROM on board. If they were ROM parts without
non-volatile storage then their behaviour would be reasonable. They'd
be expecting the host to configure them. I believe there are suitable
tools in BlueZ.

If they're ROM parts with EEPROM but it's not configured, that looks
like a manufacturing error. You'll need to assign them unique
addresses (getting hold of such addresses can be tricky).

The real question is whether any of the other settings have been
programmed correctly.

Thanks.

	- Steven
-- 


To access the latest news from CSR copy this link into a web browser:  http://www.csr.com/email_sig.php

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
