Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <45118E52.8080303@csr.com>
References: <freemail.20060820112703.62459@fm06.freemail.hu>
	<45118E52.8080303@csr.com>
Date: Wed, 20 Sep 2006 21:06:37 +0200
Message-Id: <1158779197.10356.3.camel@localhost>
Mime-Version: 1.0
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

Hi Steven,

> > First of all, I have a few USB-BT dongle (no brand info, CSR
> > chipset, HCI and LMP ver. 2.0, EEPROM on the board). They
> > all have the same BD address (Yes, it seems I bought pirated
> > dongles).
> 
> Hmm, I'm guessing you can't tell me who manufactured the dongles?
> 
> Can you tell me the firmware revision and which Bluetooth address they're
> booting up with (hciconfig version and hciconfig revision should give you
> all that information)?
> 
> Are there any BlueZ tools that can dump all the values written to
> persistent store for a module (equivalent to CSR's btcli's psslurp
> command)? If so, a dump of the PS might be useful for me.

with "bccmd psread" or "bccmd pslist" you can do that. However you need
to pick the correct stores value to get all info.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
