Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Multisync Bluetooth No devices
From: Marcel Holtmann <marcel@holtmann.org>
To: andy@beuth.info
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1092127580.9886.56.camel@goya>
References: <1092127580.9886.56.camel@goya>
Content-Type: text/plain
Message-Id: <1092127904.4564.79.camel@pegasus>
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
Date: Tue, 10 Aug 2004 10:51:44 +0200

Hi Andy,

> I run debian unstable with kernel 2.6.7 and mh4 from Marcel Holtmann
> (thanx). My problem is the following. By booting my pc i got the message
> No devices in HCI mode found.
> My Bluetooth is working under gnome with all applications exclude
> MULTISYNC. My Card is PCCARD 3COM 3CRWB6096 mit Kernel Driver und
> firmware loader. I can send SMS via Bluetooth and scmxx to my Siemens
> S55 but there is no way to get it work with Multisync.
> The Bluetooth Button in the "Connect with" selection is only grey.
> Any Idea??
> hid2hci say "No devices in HCI mode found" too.

the Multisync package maintainer linked the Bluetooth plugin against the
libsdp which is no longer present. File a Debian bug report, because
this is not a BlueZ problem.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
