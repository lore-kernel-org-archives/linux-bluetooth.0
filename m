Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4537F256.7010806@xmission.com>
Date: Thu, 19 Oct 2006 15:47:02 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <200610192137.07419.atomic@baslug.org>	<4537DA8F.2040102@xmission.com>
	<200610192325.17260.atomic@baslug.org>
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
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Atomic

doh. looks like a dead end. it's likely you need some kind of acpi magic
but it would have to be provided through the acpi module for your machine.

brad

>> toshset -bluetooth on
> 
> # ./toshset
> required kernel toshiba support not enabled.
> 
> I tried compiling toshiba support in the kernel as module, but `modprobe -v 
> toshiba_acpi` says:
> insmod /lib/modules/2.6.18-gentoo/kernel/drivers/acpi/toshiba_acpi.ko
> FATAL: Error inserting toshiba_acpi 
> (/lib/modules/2.6.18-gentoo/kernel/drivers/acpi/toshiba_acpi.ko): No such 
> device
> 
> 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
