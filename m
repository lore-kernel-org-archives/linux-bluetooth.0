Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm: permission denied
From: Marcel Holtmann <marcel@holtmann.org>
To: "Zbigniew Diaczyszyn (gmx)" <z.dia@gmx.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <000101c3ee91$fa205f40$f84ab850@ULLA>
References: <000101c3ee91$fa205f40$f84ab850@ULLA>
Content-Type: text/plain
Message-Id: <1076321608.6869.78.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 09 Feb 2004 11:13:28 +0100

Hi Zbigniew,

> linux:~ # rfcomm bind 0 00:10:60:A6:97:8C
> linux:~ # rfcomm show
> rfcomm0: 00:10:60:A6:97:8C channel 1 clean
> linux:~ # hcitool scan
> Scanning ...
>         00:10:60:29:AC:2C       BluetoothModem
> linux:~ # rfcomm connect 0 00:10:60:29:AC:2C
> Can't connect RFCOMM socket: Permission denied

this can't work. If you bind the device you don't need an additional
connect. You only have to open /dev/rfcomm0 with pppd or any other TTY
related program.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
