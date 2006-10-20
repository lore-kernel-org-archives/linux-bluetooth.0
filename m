Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Fri, 20 Oct 2006 09:53:32 +0200
From: Stefan Seyfried <seife@suse.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20061020075332.GD16506@suse.de>
References: <200610192137.07419.atomic@baslug.org>
	<200610192325.17260.atomic@baslug.org>
	<20061019230405.GF7251@suse.de>
	<200610200934.26194.atomic@baslug.org>
MIME-Version: 1.0
In-Reply-To: <200610200934.26194.atomic@baslug.org>
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

On Fri, Oct 20, 2006 at 09:34:25AM +0200, Atomic wrote:
> Alle 01:04, venerd=EC 20 ottobre 2006, Stefan Seyfried ha scritto:
> =

> > It's not toshiba_acpi, it's the toshiba module:
> > seife@strolchi:~> modinfo toshiba
> [CUT]
> > CONFIG_TOSHIBA=3Dm
> =

> You're right...
> =

> > But why do you think that your ASUS notebook will need the toshiba SMM
> > module? Is it manufactured by Toshiba?
> =

> As I wrote in the first post, I only need to turn on the bluetooth device =

> manufactured by Toshiba. Brad Midgley in his first replay to my post =

> suggested me to use toshset to turn on the device.
> Toshset requires toshiba support in kernel. =


Ok. It is still a weird idea :-)

> Do you know another way to turn on a Toshiba BT device without having a =

> Toshiba laptop?

I do not think it has anything to do with it being a toshiba bt device.
It is probably just a USB device that can be activated with some Fn-Fx hotk=
ey.
Maybe there is something the asus_acpi module can do for you under =

/proc/acpi/asus, but from looking at its source code you probably need to
add support for your machine first.
-- =

Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out." =


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
