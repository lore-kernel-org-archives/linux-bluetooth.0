Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] (no subject)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050916004341.47261.qmail@web15705.mail.cnb.yahoo.com>
References: <20050916004341.47261.qmail@web15705.mail.cnb.yahoo.com>
Content-Type: text/plain
Message-Id: <1126844287.5934.1.camel@localhost.localdomain>
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
Date: Fri, 16 Sep 2005 06:18:07 +0200

Hi Gadfly,

> hciattach /dev/ttyS1 any 57600 noflow. 
>  
> but if I change to 115200,it says :Can't init device hci0: Connection
> timed out (110). it seems that only 57600 is right!

with an UART speed of 57600 you Bluetooth data transfer is limited. If
these are CSR chips then you can use the type csr or bcsp and it is
possible to change the initial baud rate of these chips.

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
