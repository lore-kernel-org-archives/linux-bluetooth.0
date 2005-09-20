Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] multi connection with dund and rfcomm
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <9c68c0a7050918021457e7fe3c@mail.gmail.com>
References: <9c68c0a7050918021457e7fe3c@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1127217088.5168.33.camel@localhost.localdomain>
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
Date: Tue, 20 Sep 2005 13:51:28 +0200

Hi,

>  I have three pc, they are ubuntu linux 5.0.4(kernel 2.6.10)
> and three bluetooth usb adapters.
> Then I have one pc to listen using command:
> "sdptool add --channel=2 SP"
> "dund -n --listen --channel 2 --msdun file /etc/bluetooth/hcid.conf"
> 
> Another pc to connect to the first one using
> "dund --search --msdun -n"
> the connection establish.

why don't you use pand and the PAN profile using BNEP. The DUN profile
has been deprecated by the Bluetooth SIG.

> but when i let the third pc connect to the first one using
> "dund --search --msdun -n"
> it fails.It seams that the third one even can not scan the first one.

Maybe it is a chip limitation when forming a scatternet situation.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
