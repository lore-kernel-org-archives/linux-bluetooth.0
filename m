Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] BT-PM01B. hidd --connect <non-advertising device>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <42231E6A.90500@rcs.ei.tum.de>
References: <42231E6A.90500@rcs.ei.tum.de>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1109599532.17256.69.camel@pegasus>
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
Date: Mon, 28 Feb 2005 15:05:32 +0100

Hi Reinald,

> Epox Presenter BT-PM01B (with hid) works fine with bthid
> from http://klausler.com/msbtkb-linux.html
> (after puting uinput into modprobe.conf)
>=20
> bthid however is not part of bluez-utils-2.15.rpm or any other
> fc3-rpm that I know and seems to be depreciated (?)
>=20
> Can the same job be done with standard-tools? how ?
>=20
> Epox Presenter BT-PM01B works in non-advertising-mode
> (unless 3 Buttons are pressed after poweron)
> This means that hidd --connect xx:xx:xx... won=B4t work.
>=20
> Can hidd be brought to the same listening mode like bthid ?

yes, it can and actually every distribution should have at least some
config file for it. Make sure "hidd --server" is running. You've never
been to any of my talks and see me using this toy ;)

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
