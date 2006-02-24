Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: DBT-120
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <43FEA2E7.3020409@gmail.com>
References: <43FEA2E7.3020409@gmail.com>
Content-Type: text/plain
Message-Id: <1140799990.7264.17.camel@localhost>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 24 Feb 2006 17:53:10 +0100

Hi Doug,

> dfutool worked great, I now have HID proxy support. Well sort of.
> What happen's is this. I can reboot, and at post, I don't get the "no 
> keyboard" error, but I still
> can't use the keyboard to enter the bios?
> 
> Once I get to my bootloader (grub), I don't have keyboard control there 
> either. When I get to my
> X logon prompt, thing's are fine. Couple of key's pressed, and it work's 
> like it should.
> 
> What am I missing here?

you need to connect (and disconnect) your keyboard at least once and the
keyboard must be paired. The CSR version of HID proxy is not accepting
unpaired keyboards.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
