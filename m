Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth Audio gateway in linux kernel 2.4.20
From: Fredy P <digitalfredy@debiancolombia.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <fe0a97c20602280215l790a32fer80a255cc24086132@mail.gmail.com>
References: <fe0a97c20602250326l26572f44ge080939c3a57e0e7@mail.gmail.com>
	 <fe0a97c20602280215l790a32fer80a255cc24086132@mail.gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1141154883.3940.7.camel@PINGU>
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
Date: Tue, 28 Feb 2006 14:28:02 -0500

El mar, 28-02-2006 a las 15:45 +0530, Sowmya Gattupalli escribi=F3:
>=20
> Hello Everyone,=20
> I have 2 questions:
>=20
> 1)Can I not connect to a bluetooth headset from linux 2.4.20 with
> downloaded ALSA libraries and utilities??
> =20
> 2) I downloaded latest kernel 2.6.9  and when i built and rebooted it
> I found that the kernel was unable to detect the dongle connected. i.e
> it is not showing in /proc/bus/usb/devices....=20
review hotplug, bluetooth and hci modules in your kernel.
in debian you can made it using modconf=20
> =20
> =20
> I am a novice in Linux ... so can u please let me know what iam
> missing.
> =20
> Thanks a zillion
> regards
> Soumya
> =20
> =20



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
