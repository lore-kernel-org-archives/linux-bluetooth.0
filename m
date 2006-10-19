Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Atomic <atomic@baslug.org>
To: bluez-users@lists.sourceforge.net
Date: Thu, 19 Oct 2006 23:25:17 +0200
References: <200610192137.07419.atomic@baslug.org>
	<4537DA8F.2040102@xmission.com>
In-Reply-To: <4537DA8F.2040102@xmission.com>
MIME-Version: 1.0
Message-Id: <200610192325.17260.atomic@baslug.org>
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

Alle 22:05, gioved=EC 19 ottobre 2006, Brad Midgley ha scritto:

> toshset -bluetooth on

# ./toshset
required kernel toshiba support not enabled.

I tried compiling toshiba support in the kernel as module, but `modprobe -v =

toshiba_acpi` says:
insmod /lib/modules/2.6.18-gentoo/kernel/drivers/acpi/toshiba_acpi.ko
FATAL: Error inserting toshiba_acpi =

(/lib/modules/2.6.18-gentoo/kernel/drivers/acpi/toshiba_acpi.ko): No such =

device


-- =

Antonio
-- =

Ciao,
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
