Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth dongle not working under extendedUSB2.0
	  host
From: Fredy P <digitalfredy@debiancolombia.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <7aa80ced05080301443cd355cd@mail.gmail.com>
References: <7aa80ced05080301443cd355cd@mail.gmail.com>
Content-Type: text/plain;
	charset=iso-8859-1
Message-Id: <1123166702.3903.4.camel@localhost.localdomain>
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
Date: Thu, 04 Aug 2005 09:45:02 -0500

El mi=E9, 03-08-2005 a las 14:14 +0530, Mohan K escribi=F3:
> Hi All,
> We are using a VIA mother board with FC3(kernel2.6.12) installed.  We
> have extended one of the USB port using a USB controller.
> When I plugged a mouse it is working fine. But if I plug and use a
> bluetooth dongle it is not working. The kernel is detecting the USB.
> I tried to use "hcitool scan",but it fails with an error message "No
> route to host".
>=20
> Can anyone tell me why this is happening? Advanced thanks for your sugges=
tions.

try restart the hotplug=20
in debian is:
/etc/init.d/hotplug restart
>=20
> Thanks & Regards,
> Mohan
>=20
>=20
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_idt77&alloc_id=16492&op=3Dclick
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
