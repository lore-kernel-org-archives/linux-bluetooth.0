Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] "hcitool dev" shows no devices
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <41FD3E26.1000401@gmx.ch>
References: <41FD3E26.1000401@gmx.ch>
Content-Type: text/plain
Message-Id: <1107116116.8384.4.camel@pegasus>
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
Date: Sun, 30 Jan 2005 21:15:16 +0100

Hi Marco,

> I've a 2.4.26 kernel. I patched it using the "patch-2.4.26-mh2.gz" from the 
> bluez homepage. *
> Then, in "make menuconfig" I selected this points:
> # Bluetooth support -> Bluetooth subsystem support
> #                      L2CAP protocol support (NEW)
> #                      RFCOMM protocol support
> #                        RFCOMM TTY support (NEW)
> # Bluetooth support -> Bluetooth device drivers -> HCI USB driver (new)
> 
> Then I compiled and installed the new kernel.
> After that I compiled and installed the bluez-libs and bluez-utils.
> 
> Everything works well...
> Now I try "hcitool dev" but no devices are showed (I have two D-Link DBT120 
> connected to usb ports).
> 
> Any Ideas why they aren't recognized?
> Did I miss to add a feature to the kernel?

what does "hciconfig -a" say? What is in /proc/bus/usb/devices?

> * Something gets rejected during the patch (It doesn't seem important to 
> me, but maybee it is):
> 
> Makefile.rej:
> ***************
> *** 1,7 ****
>    VERSION = 2
>    PATCHLEVEL = 4
>    SUBLEVEL = 26
> - EXTRAVERSION =
> 
>    KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
> 
> --- 1,7 ----
>    VERSION = 2
>    PATCHLEVEL = 4
>    SUBLEVEL = 26
> + EXTRAVERSION = -mh2
> 
>    KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)

You can ignore this one. It will almost fail if you don't use a vanilla
base.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
