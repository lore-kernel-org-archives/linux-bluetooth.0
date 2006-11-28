Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <77ADC7D0C96B1F44A924DC4E952A5E0E0123D00A@AZ25EXM01.gddsi.com>
References: <77ADC7D0C96B1F44A924DC4E952A5E0E0123D00A@AZ25EXM01.gddsi.com>
Date: Tue, 28 Nov 2006 05:12:40 +0100
Message-Id: <1164687160.13955.9.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Trying to connect using a BCSP dongle
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

Hi Scott,

> I'm trying to connect a bluetooth module using the BCSP transport on a
> Linux machine.
> 
> I have all my services running, but when I try notifying the Linux
> bluez stack that the transport will be bcsp using: 
> "hciattach ttyS0 bcsp", the Linux PC locks up.  I have to reboot to
> recover.

which kernel version do you use. Can you call "dmesg -n 8" and try it
again from the console to catch possible error messages from the kernel.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
