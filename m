Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Atomic <atomic@baslug.org>
To: bluez-users@lists.sourceforge.net
Date: Fri, 20 Oct 2006 09:34:25 +0200
References: <200610192137.07419.atomic@baslug.org>
	<200610192325.17260.atomic@baslug.org>
	<20061019230405.GF7251@suse.de>
In-Reply-To: <20061019230405.GF7251@suse.de>
MIME-Version: 1.0
Message-Id: <200610200934.26194.atomic@baslug.org>
Subject: Re: [Bluez-users] Unsupported bluetooth device?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Alle 01:04, venerd=EC 20 ottobre 2006, Stefan Seyfried ha scritto:

> It's not toshiba_acpi, it's the toshiba module:
> seife@strolchi:~> modinfo toshiba
[CUT]
> CONFIG_TOSHIBA=3Dm

You're right...

> But why do you think that your ASUS notebook will need the toshiba SMM
> module? Is it manufactured by Toshiba?

As I wrote in the first post, I only need to turn on the bluetooth device =

manufactured by Toshiba. Brad Midgley in his first replay to my post =

suggested me to use toshset to turn on the device.
Toshset requires toshiba support in kernel. =


# ./toshset -bluetooth on
required kernel toshiba support not enabled

Do you know another way to turn on a Toshiba BT device without having a =

Toshiba laptop?
Thanks.

-- =

Antonio


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
