Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Fri, 20 Oct 2006 01:04:05 +0200
From: Stefan Seyfried <seife@suse.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20061019230405.GF7251@suse.de>
References: <200610192137.07419.atomic@baslug.org>
	<4537DA8F.2040102@xmission.com>
	<200610192325.17260.atomic@baslug.org>
MIME-Version: 1.0
In-Reply-To: <200610192325.17260.atomic@baslug.org>
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

On Thu, Oct 19, 2006 at 11:25:17PM +0200, Atomic wrote:
> Alle 22:05, gioved=EC 19 ottobre 2006, Brad Midgley ha scritto:
> =

> > toshset -bluetooth on
> =

> # ./toshset
> required kernel toshiba support not enabled.
> =

> I tried compiling toshiba support in the kernel as module, but `modprobe =
-v =

> toshiba_acpi` says:
> insmod /lib/modules/2.6.18-gentoo/kernel/drivers/acpi/toshiba_acpi.ko
> FATAL: Error inserting toshiba_acpi =


It's not toshiba_acpi, it's the toshiba module:
seife@strolchi:~> modinfo toshiba
filename:       /lib/modules/2.6.18-14-default/kernel/drivers/char/toshiba.=
ko
license:        GPL
author:         Jonathan Buzzard <jonathan@buzzard.org.uk>
description:    Toshiba laptop SMM driver
vermagic:       2.6.18-14-default SMP mod_unload 586 REGPARM gcc-4.1
supported:      yes
depends:
srcversion:     4084FFFFC74CA02E5586716
parm:           fn:User specified Fn key detection port (int)

CONFIG_TOSHIBA=3Dm

But why do you think that your ASUS notebook will need the toshiba SMM
module? Is it manufactured by Toshiba?
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
