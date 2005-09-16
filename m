Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] PAN and RFCOMM
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <432A5DD6.2090205@avantwave.com>
References: <432A314C.4050701@avantwave.com>
	 <1126844755.5934.9.camel@localhost.localdomain>
	 <432A5DD6.2090205@avantwave.com>
Content-Type: text/plain
Message-Id: <1126877114.5512.3.camel@localhost.localdomain>
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
Date: Fri, 16 Sep 2005 15:25:14 +0200

Hi,

> >this can be and depends on the chips of the other devices.
> >
>     That means it is restricted by the CSR chip. It is too bad

it can be, but in general using CSR chips are less problematic.

>     I am now using 2.12 utils. I will change it later
>     Because it seem to be a problem on bluetooth architechure, I choose
> to turn bnep off whenever there is rfcomm connection. But i find that
> when i disconnect bnep several time by "pand -K" a kernel error message
> come out "unregister_netdevice: waiting for bnep0 to become free. Usage
> count = 1".
>     Do i need to close all the network application first?

If you wanna make this error go away, then yes.

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
