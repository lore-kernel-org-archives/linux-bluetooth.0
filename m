Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <00f301c4118c$a33eec00$b67ba8c0@zaz1>
From: "Xavier Garreau" <x.garreau@prim-time.fr>
To: "Alvin Lam" <alvinlam@shaw.ca>, <bluez-users@lists.sourceforge.net>
References: <20040323223102.25A8F1D0425@sc8-sf-uberspam1.sourceforge.net> <40616653.3000904@shaw.ca>
Subject: Re: [Bluez-users] hcitool returns error 0x11 with RSSI command
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
Date: Wed, 24 Mar 2004 11:42:00 +0100

> I am using BlueZ with two Socket CompactFlash BT card using the dtl1_cs
> driver.  I run "sdptool browse &" and when a connection is established =
I
> then run "hcitool <rssi | lq | tpl> <bdaddr>".  This yields the
> following errors:
>
> HCI get_link_quality cmd failed (0x11)
> Read RSSI returned (error) status 0x11
> HCI read_transmit_power_level cmd failed (0x11)
>
> Since 0x11 is 17 in decimal, looking at errno.h shows that this error
> corresponds to "File Exists".  I found several previous messages on the
> mailing list referring to a similar error, but a different return value
> (0x01).


This is a bluetooth Error Code and means (BT Spec. =A76.17) "Unsupported
Feature or parameter value".

Regards,
--=20
Xavier Garreau <x.garreau@prim-time.fr>
Prim'Time Technology
http://www.prim-time.fr/



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
