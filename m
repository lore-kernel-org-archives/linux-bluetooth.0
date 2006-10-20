Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Atomic <atomic@baslug.org>
To: bluez-users@lists.sourceforge.net
Date: Fri, 20 Oct 2006 10:34:35 +0200
References: <200610192137.07419.atomic@baslug.org>
	<200610200934.26194.atomic@baslug.org>
	<20061020075332.GD16506@suse.de>
In-Reply-To: <20061020075332.GD16506@suse.de>
MIME-Version: 1.0
Message-Id: <200610201034.35600.atomic@baslug.org>
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

Alle 09:53, venerd=EC 20 ottobre 2006, Stefan Seyfried ha scritto:

> I do not think it has anything to do with it being a toshiba bt device.
> It is probably just a USB device that can be activated with some Fn-Fx
> hotkey.

OK. It was my doubt. So I have to forget all Toshiba laptop related solutio=
ns.

> Maybe there is something the asus_acpi module can do for you under =

> /proc/acpi/asus, but from looking at its source code you probably need to
> add support for your machine first.

Yesterday I fixed the original DSDT on my laptop and I'm going to supply it=
 to =

acpi4asus developers if they hold as correct my fixes.
Seems the only thing I can do is waiting for the support in acpi4asus modul=
e, =

hoping that it is enough to make BT device working.
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
