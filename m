Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: Re: [Bluez-users] Help, Xscale-based Linux machin cannot
	useBluetooth USB  dongle ^^;;;
From: Marcel Holtmann <marcel@holtmann.org>
To: =?UTF-8?Q?=EC=95=88=ED=9D=AC?= =?UTF-8?Q?=EC=A4=80?= <heejune@snut.ac.kr>
Cc: "Marcel Holtmann<marcel@holtmann.org>;  BlueZ Mailing List" <bluez-users@lists.sourceforge.net>
In-Reply-To: <3132c39ad0101.heejune@snut.ac.kr>
References: <3132c39ad0101.heejune@snut.ac.kr>
Content-Type: text/plain
Message-Id: <1104036221.8758.49.camel@pegasus>
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
Date: Sun, 26 Dec 2004 05:43:41 +0100

Hi,

> Ja,  I think it is mostly probable due to the the USB host device
> driver for SL811 in Linux-Arm Branch.
> 
> The reason I posted it I think that there must be many people who
> works Bluez in ARM-based system, (at leaset next large number for
> developers to x86), So I am asking how they solved this problems and
> whether I made some dull mistakes for using bluez.
> 
> Since the bluez site anounces that it support Xscale machine, I
> believe someone can answer me.

actually most people use UART interface and the iPAQs also connected
their Bluetooth modules through an UART. However I don't know what's
wrong, but I doubt that it is a BlueZ problem.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
