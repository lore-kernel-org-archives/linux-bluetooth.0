Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Failed to send data over a writable l2cap socket
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <6.2.3.4.0.20050916111745.02ae0008@mail.impulsesoft.com>
References: <6.2.3.4.0.20050916111745.02ae0008@mail.impulsesoft.com>
Content-Type: text/plain
Message-Id: <1126877192.5512.5.camel@localhost.localdomain>
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
Date: Fri, 16 Sep 2005 15:26:31 +0200

Hi Pragya,

> I am trying to establish more than one l2cap channel over same hci 
> link between a pair of devices. I am using "select" to find out when 
> a socket becomes writable. When I say "connect" for first two l2cap 
> sockets , I come out of select when it becomes writable and I am able 
> to send data to it. But when I repeat the same for the third l2cap 
> socket, the socket is writable but I am unable to send data on it . 
> The data goes out successfully only after few attempts.

I need a "hcidump -X -V" of this problem and an example problem to
reproduce this behavior at home. Make sure you use the latest kernel and
bluez-utils.

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
