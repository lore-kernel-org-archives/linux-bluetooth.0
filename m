Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: RE : RE : [Bluez-users] SuSE and Audio
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?J=E9r=F4me?= Stadelmann <jerome.stadelmann@hta-bi.bfh.ch>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <008901c3e9a0$4b488970$2d105793@N64101>
References: <008901c3e9a0$4b488970$2d105793@N64101>
Content-Type: text/plain
Message-Id: <1075739193.29899.61.camel@pegasus>
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
Date: Mon, 02 Feb 2004 17:26:34 +0100

Hi Jerome,

> > what kernel are you talking about 2.4.21 or 2.6.1? For the 2.4.21 you need
> at least -mh4.
> 
> Sorry :) It's the 2.6.1-mh3

you have to enable CONFIG_BT_HCIUSB_SCO, but this can cause crashes at
unplug on UHCI host adapters.

> > What does "hciconfig hci0 revision" say? You need a SCO over HCI mapping
> and I never tested this stuff on a 2.6 kernel.
> 
> It gives me SCO mapping : HCI

This is correct, but I never checked that it also works with 2.6.

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
