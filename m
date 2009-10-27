Return-Path: <cyrus@holtmann.org>
Message-ID: <4AE7651C.7010809@dell.com>
Date: Tue, 27 Oct 2009 16:24:44 -0500
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: =?ISO-8859-1?Q?Ozan_=C7ag=28layan?= <ozan@pardus.org.tr>,
        linux-bluetooth@vger.kernel.org
Subject: Re: hid2hci rules breaks standard USB dell mouses
References: <4AE18EA3.50701@pardus.org.tr>  <4AE1E1E8.3080902@dell.com> <1256373518.7812.1.camel@localhost.localdomain>
In-Reply-To: <1256373518.7812.1.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC129F9F7F9B3E6DEF6A4267C"
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC129F9F7F9B3E6DEF6A4267C
Content-Type: multipart/mixed;
 boundary="------------010309010108020407010709"

This is a multi-part message in MIME format.
--------------010309010108020407010709
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Marcel:

Marcel Holtmann wrote:
>
> and please send a patch to fix the ones in BlueZ, too
I sent a patch to drop it from bluez so it doesn't have to be maintained
in two places, but it was never responded to.  Here it is again taken
from my mail archive.

Regards
--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com

--------------010309010108020407010709
Content-Type: text/x-patch;
 name="0001-Remove-hid2hci-from-bluez.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="0001-Remove-hid2hci-from-bluez.patch"

=46rom 5a631382e95a08ba69561d18ff48098c12e0a217 Mon Sep 17 00:00:00 2001
From: Mario Limonciello <mario_limonciello@dell.com>
Date: Sun, 14 Jun 2009 09:59:19 -0500
Subject: [PATCH] Remove hid2hci from bluez. =20
 It's now been moved into udev-extras
 and will be maintained there instead.

---
 acinclude.m4                    |    6 -
 bootstrap-configure             |    1 -
 scripts/Makefile.am             |    8 +-
 scripts/bluetooth-hid2hci.rules |   36 ----
 tools/Makefile.am               |   18 +--
 tools/hid2hci.8                 |   51 ------
 tools/hid2hci.c                 |  375 ---------------------------------=
------
 7 files changed, 5 insertions(+), 490 deletions(-)
 delete mode 100644 scripts/bluetooth-hid2hci.rules
 delete mode 100644 tools/hid2hci.8
 delete mode 100644 tools/hid2hci.c

diff --git a/acinclude.m4 b/acinclude.m4
index eb7cdeb..ce716de 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -193,7 +193,6 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	cups_enable=3Dno
 	test_enable=3Dno
 	bccmd_enable=3Dno
-	hid2hci_enable=3Dno
 	dfutool_enable=3Dno
 	manpages_enable=3Dyes
 	configfiles_enable=3Dyes
@@ -253,10 +252,6 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		bccmd_enable=3D${enableval}
 	])
=20
-	AC_ARG_ENABLE(hid2hci, AC_HELP_STRING([--enable-hid2hci], [install HID =
mode switching utility]), [
-		hid2hci_enable=3D${enableval}
-	])
-
 	AC_ARG_ENABLE(dfutool, AC_HELP_STRING([--enable-dfutool], [install DFU =
firmware upgrade utility]), [
 		dfutool_enable=3D${enableval}
 	])
@@ -351,7 +346,6 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(TEST, test "${test_enable}" =3D "yes")
 	AM_CONDITIONAL(TOOLS, test "${tools_enable}" =3D "yes")
 	AM_CONDITIONAL(BCCMD, test "${bccmd_enable}" =3D "yes")
-	AM_CONDITIONAL(HID2HCI, test "${hid2hci_enable}" =3D "yes" && test "${u=
sb_found}" =3D "yes")
 	AM_CONDITIONAL(DFUTOOL, test "${dfutool_enable}" =3D "yes" && test "${u=
sb_found}" =3D "yes")
 	AM_CONDITIONAL(MANPAGES, test "${manpages_enable}" =3D "yes")
 	AM_CONDITIONAL(CONFIGFILES, test "${configfiles_enable}" =3D "yes")
diff --git a/bootstrap-configure b/bootstrap-configure
index 5ec8e4c..f865c39 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -20,7 +20,6 @@ fi
 		--enable-tools \
 		--enable-bccmd \
 		--enable-dfutool \
-		--enable-hid2hci \
 		--enable-hidd \
 		--enable-pand \
 		--enable-dund \
diff --git a/scripts/Makefile.am b/scripts/Makefile.am
index 494a9c2..311f5c7 100644
--- a/scripts/Makefile.am
+++ b/scripts/Makefile.am
@@ -4,10 +4,6 @@ rulesdir =3D $(sysconfdir)/udev
=20
 rules_DATA =3D
=20
-if HID2HCI
-rules_DATA +=3D bluetooth-hid2hci.rules
-endif
-
 if PCMCIARULES
 rules_DATA +=3D bluetooth-serial.rules
 endif
@@ -19,8 +15,8 @@ udevdir =3D $(libexecdir)/udev
 udev_SCRIPTS =3D bluetooth_serial
 endif
=20
-EXTRA_DIST =3D bluetooth.init bluetooth.default bluetooth-hid2hci.rules =
\
-				bluetooth-serial.rules bluetooth_serial
+EXTRA_DIST =3D bluetooth.init bluetooth.default bluetooth-serial.rules\
+				bluetooth_serial
=20
 MAINTAINERCLEANFILES =3D Makefile.in
=20
diff --git a/scripts/bluetooth-hid2hci.rules b/scripts/bluetooth-hid2hci.=
rules
deleted file mode 100644
index 1b231d1..0000000
--- a/scripts/bluetooth-hid2hci.rules
+++ /dev/null
@@ -1,36 +0,0 @@
-# Variety of Dell Bluetooth devices
-#
-# it looks like a bit of an odd rule, because it is matching
-# on a mouse device that is self powered, but that is where
-# a HID report needs to be sent to switch modes.
-#
-# Known supported devices:
-#   413c:8154
-#   413c:8158
-#   413c:8162
-ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"413c", ENV{ID_CLASS}=3D=3D"mouse=
", ATTRS{bmAttributes}=3D=3D"e0", KERNEL=3D=3D"mouse*", RUN+=3D"/usr/sbin=
/hid2hci --method dell -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"
-
-# Logitech devices
-ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"046d", ENV{ID_MODEL}=3D=3D"c703"=
 RUN+=3D"/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{I=
D_MODEL} --mode hci"
-ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"046d", ENV{ID_MODEL}=3D=3D"c704"=
 RUN+=3D"/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{I=
D_MODEL} --mode hci"
-ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"046d", ENV{ID_MODEL}=3D=3D"c705"=
 RUN+=3D"/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{I=
D_MODEL} --mode hci"
-ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"046d", ENV{ID_MODEL}=3D=3D"c70a"=
 RUN+=3D"/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{I=
D_MODEL} --mode hci"
-ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"046d", ENV{ID_MODEL}=3D=3D"c70b"=
 RUN+=3D"/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{I=
D_MODEL} --mode hci"
-ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"046d", ENV{ID_MODEL}=3D=3D"c70c"=
 RUN+=3D"/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{I=
D_MODEL} --mode hci"
-ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"046d", ENV{ID_MODEL}=3D=3D"c70e"=
 RUN+=3D"/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{I=
D_MODEL} --mode hci"
-ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"046d", ENV{ID_MODEL}=3D=3D"c713"=
 RUN+=3D"/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{I=
D_MODEL} --mode hci"
-ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"046d", ENV{ID_MODEL}=3D=3D"c714"=
 RUN+=3D"/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{I=
D_MODEL} --mode hci"
-ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"046d", ENV{ID_MODEL}=3D=3D"c71b"=
 RUN+=3D"/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{I=
D_MODEL} --mode hci"
-ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"046d", ENV{ID_MODEL}=3D=3D"c71c"=
 RUN+=3D"/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{I=
D_MODEL} --mode hci"
-
-# CSR devices (in HID mode)
-ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"0a12", ENV{ID_MODEL}=3D=3D"1000"=
 RUN+=3D"/usr/sbin/hid2hci --method csr -v $env{ID_VENDOR} -p $env{ID_MOD=
EL} --mode hci"
-ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"0458", ENV{ID_MODEL}=3D=3D"1000"=
 RUN+=3D"/usr/sbin/hid2hci --method csr -v $env{ID_VENDOR} -p $env{ID_MOD=
EL} --mode hci"
-ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"05ac", ENV{ID_MODEL}=3D=3D"1000"=
 RUN+=3D"/usr/sbin/hid2hci --method csr -v $env{ID_VENDOR} -p $env{ID_MOD=
EL} --mode hci"
-
-# CSR devices (in HCI mode)
-#ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"0a12", ENV{ID_MODEL}=3D=3D"0001=
" RUN+=3D"/usr/sbin/hid2hci --method csr -v $env{ID_VENDOR} -p $env{ID_MO=
DEL} --mode hid"
-#ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"0458", ENV{ID_MODEL}=3D=3D"003f=
" RUN+=3D"/usr/sbin/hid2hci --method csr -v $env{ID_VENDOR} -p $env{ID_MO=
DEL} --mode hid"
-#ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"05ac", ENV{ID_MODEL}=3D=3D"8203=
" RUN+=3D"/usr/sbin/hid2hci --method csr -v $env{ID_VENDOR} -p $env{ID_MO=
DEL} --mode hid"
-#ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"05ac", ENV{ID_MODEL}=3D=3D"8204=
" RUN+=3D"/usr/sbin/hid2hci --method csr -v $env{ID_VENDOR} -p $env{ID_MO=
DEL} --mode hid"
-#ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"05ac", ENV{ID_MODEL}=3D=3D"8207=
" RUN+=3D"/usr/sbin/hid2hci --method csr -v $env{ID_VENDOR} -p $env{ID_MO=
DEL} --mode hid"
diff --git a/tools/Makefile.am b/tools/Makefile.am
index 6b0ad49..887b4ee 100644
--- a/tools/Makefile.am
+++ b/tools/Makefile.am
@@ -15,14 +15,6 @@ bccmd_programs =3D
 bccmd_manfiles =3D
 endif
=20
-if HID2HCI
-hid2hci_programs =3D hid2hci
-hid2hci_manfiles =3D hid2hci.8
-else
-hid2hci_programs =3D
-hid2hci_manfiles =3D
-endif
-
 if DFUTOOL
 dfutool_programs =3D dfutool
 dfutool_manfiles =3D dfutool.1
@@ -37,7 +29,7 @@ else
 usb_programs =3D
 endif
=20
-sbin_PROGRAMS =3D hciattach hciconfig $(bccmd_programs) $(avctrl_program=
s) $(hid2hci_programs)
+sbin_PROGRAMS =3D hciattach hciconfig $(bccmd_programs) $(avctrl_program=
s)
=20
 bin_PROGRAMS =3D $(tools_programs) $(dfutool_programs) $(dfubabel_progra=
ms)
=20
@@ -77,10 +69,6 @@ bccmd_LDADD +=3D @USB_LIBS@
 endif
 endif
=20
-if HID2HCI
-hid2hci_LDADD =3D @USB_LIBS@
-endif
-
 if DFUTOOL
 dfutool_SOURCES =3D dfutool.c dfu.h dfu.c
 dfutool_LDADD =3D @USB_LIBS@
@@ -97,10 +85,10 @@ INCLUDES =3D -I$(top_srcdir)/common
=20
 if MANPAGES
 man_MANS =3D hciattach.8 hciconfig.8 $(tools_manfiles) \
-		$(bccmd_manfiles) $(hid2hci_manfiles) $(dfutool_manfiles)
+		$(bccmd_manfiles) $(dfutool_manfiles)
 endif
=20
 EXTRA_DIST =3D hciattach.8 hciconfig.8 hcitool.1 l2ping.1 sdptool.1 cipt=
ool.1 \
-		 bccmd.8 avctrl.8 hid2hci.8 dfutool.1 dfubabel.1 example.psr
+		 bccmd.8 avctrl.8 dfutool.1 dfubabel.1 example.psr
=20
 MAINTAINERCLEANFILES =3D Makefile.in
diff --git a/tools/hid2hci.8 b/tools/hid2hci.8
deleted file mode 100644
index 5d35274..0000000
--- a/tools/hid2hci.8
+++ /dev/null
@@ -1,51 +0,0 @@
-.\"
-.\"	This program is free software; you can redistribute it and/or modify=

-.\"	it under the terms of the GNU General Public License as published by=

-.\"	the Free Software Foundation; either version 2 of the License, or
-.\"	(at your option) any later version.
-.\"
-.\"	This program is distributed in the hope that it will be useful,
-.\"	but WITHOUT ANY WARRANTY; without even the implied warranty of
-.\"	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-.\"	GNU General Public License for more details.
-.\"
-.\"	You should have received a copy of the GNU General Public License
-.\"	along with this program; if not, write to the Free Software
-.\"	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-.\"
-.\"
-.TH HID2HCI 8 "MAY 15, 2009" "" ""
-
-.SH NAME
-hid2hci \- Bluetooth HID to HCI mode switching utility
-.SH SYNOPSIS
-.BR "hid2hci
-[
-.I options
-]
-.SH DESCRIPTION
-.B hid2hci
-is used to set up switch supported Bluetooth devices into the HCI
-mode and back.
-.SH OPTIONS
-.TP
-.BI -h
-Gives a list of possible options.
-.TP
-.BI -q
-Don't display any messages.
-.TP
-.BI -r [hid,hci]
-Sets the mode to switch the device into
-.TP
-.BI -v
-Specifies the 4 digit vendor ID assigned to the device being switched
-.TP
-.BI -p
-Specifies the 4 digit product ID assigned to the device being switched
-.TP
-.BI -m [csr, logitech, dell]
-Which vendor method to use for switching the device.
-.SH AUTHOR
-Written by Marcel Holtmann <marcel@holtmann.org>.
-.br
diff --git a/tools/hid2hci.c b/tools/hid2hci.c
deleted file mode 100644
index 11d707f..0000000
--- a/tools/hid2hci.c
+++ /dev/null
@@ -1,375 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2003-2009  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify=

- *  it under the terms of the GNU General Public License as published by=

- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-130=
1  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <stdio.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <stdint.h>
-#include <string.h>
-#include <getopt.h>
-#include <sys/ioctl.h>
-
-#include <usb.h>
-
-#ifdef NEED_USB_GET_BUSSES
-static inline struct usb_bus *usb_get_busses(void)
-{
-	return usb_busses;
-}
-#endif
-
-#ifndef USB_DIR_OUT
-#define USB_DIR_OUT	0x00
-#endif
-
-static char devpath[PATH_MAX + 1] =3D "/dev";
-
-struct hiddev_devinfo {
-	unsigned int bustype;
-	unsigned int busnum;
-	unsigned int devnum;
-	unsigned int ifnum;
-	short vendor;
-	short product;
-	short version;
-	unsigned num_applications;
-};
-
-struct hiddev_report_info {
-	unsigned report_type;
-	unsigned report_id;
-	unsigned num_fields;
-};
-
-typedef __signed__ int __s32;
-
-struct hiddev_usage_ref {
-	unsigned report_type;
-	unsigned report_id;
-	unsigned field_index;
-	unsigned usage_index;
-	unsigned usage_code;
-	__s32 value;
-};
-
-#define HIDIOCGDEVINFO		_IOR('H', 0x03, struct hiddev_devinfo)
-#define HIDIOCINITREPORT	_IO('H', 0x05)
-#define HIDIOCSREPORT		_IOW('H', 0x08, struct hiddev_report_info)
-#define HIDIOCSUSAGE		_IOW('H', 0x0C, struct hiddev_usage_ref)
-
-#define HID_REPORT_TYPE_OUTPUT	2
-
-#define HCI 0
-#define HID 1
-
-struct device_info {
-	struct usb_device *dev;
-	int mode;
-	uint16_t vendor;
-	uint16_t product;
-};
-
-static int switch_csr(struct device_info *devinfo)
-{
-	struct usb_dev_handle *udev;
-	int err;
-
-	udev =3D usb_open(devinfo->dev);
-	if (!udev)
-		return -errno;
-
-	err =3D usb_control_msg(udev, USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP=
_DEVICE,
-				0, devinfo->mode, 0, NULL, 0, 10000);
-
-	if (err =3D=3D 0) {
-		err =3D -1;
-		errno =3D EALREADY;
-	} else {
-		if (errno =3D=3D ETIMEDOUT)
-			err =3D 0;
-	}
-
-	usb_close(udev);
-
-	return err;
-}
-
-static int send_report(int fd, const char *buf, size_t size)
-{
-	struct hiddev_report_info rinfo;
-	struct hiddev_usage_ref uref;
-	unsigned int i;
-	int err;
-
-	for (i =3D 0; i < size; i++) {
-		memset(&uref, 0, sizeof(uref));
-		uref.report_type =3D HID_REPORT_TYPE_OUTPUT;
-		uref.report_id   =3D 0x10;
-		uref.field_index =3D 0;
-		uref.usage_index =3D i;
-		uref.usage_code  =3D 0xff000001;
-		uref.value       =3D buf[i] & 0x000000ff;
-		err =3D ioctl(fd, HIDIOCSUSAGE, &uref);
-		if (err < 0)
-			return err;
-	}
-
-	memset(&rinfo, 0, sizeof(rinfo));
-	rinfo.report_type =3D HID_REPORT_TYPE_OUTPUT;
-	rinfo.report_id   =3D 0x10;
-	rinfo.num_fields  =3D 1;
-	err =3D ioctl(fd, HIDIOCSREPORT, &rinfo);
-
-	return err;
-}
-
-static int switch_logitech(struct device_info *devinfo)
-{
-	char devname[PATH_MAX + 1];
-	int i, fd, err =3D -1;
-
-	for (i =3D 0; i < 16; i++) {
-		struct hiddev_devinfo dinfo;
-		char rep1[] =3D { 0xff, 0x80, 0x80, 0x01, 0x00, 0x00 };
-		char rep2[] =3D { 0xff, 0x80, 0x00, 0x00, 0x30, 0x00 };
-		char rep3[] =3D { 0xff, 0x81, 0x80, 0x00, 0x00, 0x00 };
-
-		sprintf(devname, "%s/hiddev%d", devpath, i);
-		fd =3D open(devname, O_RDWR);
-		if (fd < 0) {
-			sprintf(devname, "%s/usb/hiddev%d", devpath, i);
-			fd =3D open(devname, O_RDWR);
-			if (fd < 0) {
-				sprintf(devname, "%s/usb/hid/hiddev%d", devpath, i);
-				fd =3D open(devname, O_RDWR);
-				if (fd < 0)
-					continue;
-			}
-		}
-
-		memset(&dinfo, 0, sizeof(dinfo));
-		err =3D ioctl(fd, HIDIOCGDEVINFO, &dinfo);
-		if (err < 0 || (int) dinfo.busnum !=3D atoi(devinfo->dev->bus->dirname=
) ||
-				(int) dinfo.devnum !=3D atoi(devinfo->dev->filename)) {
-			close(fd);
-			continue;
-		}
-
-		err =3D ioctl(fd, HIDIOCINITREPORT, 0);
-		if (err < 0) {
-			close(fd);
-			break;
-		}
-
-		err =3D send_report(fd, rep1, sizeof(rep1));
-		if (err < 0) {
-			close(fd);
-			break;
-		}
-
-		err =3D send_report(fd, rep2, sizeof(rep2));
-		if (err < 0) {
-			close(fd);
-			break;
-		}
-
-		err =3D send_report(fd, rep3, sizeof(rep3));
-		close(fd);
-		break;
-	}
-
-	return err;
-}
-
-static int switch_dell(struct device_info *devinfo)
-{
-	char report[] =3D { 0x7f, 0x00, 0x00, 0x00 };
-
-	struct usb_dev_handle *handle;
-	int err;
-
-	switch (devinfo->mode) {
-	case HCI:
-		report[1] =3D 0x13;
-		break;
-	case HID:
-		report[1] =3D 0x14;
-		break;
-	}
-
-	handle =3D usb_open(devinfo->dev);
-	if (!handle)
-		return -EIO;
-
-	/* Don't need to check return, as might not be in use */
-	usb_detach_kernel_driver_np(handle, 0);
-
-	if (usb_claim_interface(handle, 0) < 0) {
-		usb_close(handle);
-		return -EIO;
-	}
-
-	err =3D usb_control_msg(handle,
-		USB_ENDPOINT_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
-			USB_REQ_SET_CONFIGURATION, 0x7f | (0x03 << 8), 0,
-						report, sizeof(report), 5000);
-
-	if (err =3D=3D 0) {
-		err =3D -1;
-		errno =3D EALREADY;
-	} else {
-		if (errno =3D=3D ETIMEDOUT)
-			err =3D 0;
-	}
-
-	usb_close(handle);
-
-	return err;
-}
-
-static int find_device(struct device_info* devinfo)
-{
-	struct usb_bus *bus;
-	struct usb_device *dev;
-
-	usb_find_busses();
-	usb_find_devices();
-
-	for (bus =3D usb_get_busses(); bus; bus =3D bus->next)
-		for (dev =3D bus->devices; dev; dev =3D dev->next) {
-			if (dev->descriptor.idVendor =3D=3D devinfo->vendor &&
-			    dev->descriptor.idProduct =3D=3D devinfo->product) {
-				devinfo->dev=3Ddev;
-				return 1;
-			}
-		}
-	return 0;
-}
-
-static void usage(char* error)
-{
-	if (error)
-		fprintf(stderr,"\n%s\n", error);
-	else
-		printf("hid2hci - Bluetooth HID to HCI mode switching utility\n\n");
-
-	printf("Usage:\n"
-		"\thid2hci [options]\n"
-		"\n");
-
-	printf("Options:\n"
-		"\t-h, --help           Display help\n"
-		"\t-q, --quiet          Don't display any messages\n"
-		"\t-r, --mode=3D          Mode to switch to [hid, hci]\n"
-		"\t-v, --vendor=3D        Vendor ID to act upon\n"
-		"\t-p, --product=3D       Product ID to act upon\n"
-		"\t-m, --method=3D        Method to use to switch [csr, logitech, dell=
]\n"
-		"\n");
-	if (error)
-		exit(1);
-}
-
-static struct option main_options[] =3D {
-	{ "help",	no_argument, 0, 'h' },
-	{ "quiet",	no_argument, 0, 'q' },
-	{ "mode",	required_argument, 0, 'r' },
-	{ "vendor",	required_argument, 0, 'v' },
-	{ "product",	required_argument, 0, 'p' },
-	{ "method",	required_argument, 0, 'm' },
-	{ 0, 0, 0, 0 }
-};
-
-int main(int argc, char *argv[])
-{
-	struct device_info dev =3D { NULL, HCI, 0, 0 };
-	int opt, quiet =3D 0;
-	int (*method)(struct device_info *dev) =3D NULL;
-
-	while ((opt =3D getopt_long(argc, argv, "+r:v:p:m:qh", main_options, NU=
LL)) !=3D -1) {
-		switch (opt) {
-		case 'r':
-			if (optarg && !strcmp(optarg, "hid"))
-				dev.mode =3D HID;
-			else if (optarg && !strcmp(optarg, "hci"))
-				dev.mode =3D HCI;
-			else
-				usage("ERROR: Undefined radio mode\n");
-			break;
-		case 'v':
-			sscanf(optarg, "%4hx", &dev.vendor);
-			break;
-		case 'p':
-			sscanf(optarg, "%4hx", &dev.product);
-			break;
-		case 'm':
-			if (optarg && !strcmp(optarg, "csr"))
-				method =3D switch_csr;
-			else if (optarg && !strcmp(optarg, "logitech"))
-				method =3D switch_logitech;
-			else if (optarg && !strcmp(optarg, "dell"))
-				method =3D switch_dell;
-			else
-				usage("ERROR: Undefined switching method\n");
-			break;
-		case 'q':
-			quiet =3D 1;
-			break;
-		case 'h':
-			usage(NULL);
-		default:
-			exit(0);
-		}
-	}
-
-	if (!quiet && (!dev.vendor || !dev.product || !method))
-		usage("ERROR: Vendor ID, Product ID, and Switching Method must all be =
defined.\n");
-
-	argc -=3D optind;
-	argv +=3D optind;
-	optind =3D 0;
-
-	usb_init();
-
-	if (!find_device(&dev)) {
-		if (!quiet)
-			fprintf(stderr, "Device %04x:%04x not found on USB bus.\n",
-				dev.vendor, dev.product);
-		exit(1);
-	}
-
-	if (!quiet)
-		printf("Attempting to switch device %04x:%04x to %s mode ",
-			dev.vendor, dev.product, dev.mode ? "HID" : "HCI");
-	fflush(stdout);
-
-	if (method(&dev) < 0 && !quiet)
-		printf("failed (%s)\n", strerror(errno));
-	else if (!quiet)
-		printf("was successful\n");
-
-	return errno;
-}
--=20
1.6.0.4


--------------010309010108020407010709--

--------------enigC129F9F7F9B3E6DEF6A4267C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkrnZRwACgkQ2CrZjkA73YuM5gCfZ0RfNRZcUUCY5Gu3bGLNDjhk
tuUAnA1yVz9gN1enNbwnSZMIPHsA5+H6
=Dfk6
-----END PGP SIGNATURE-----

--------------enigC129F9F7F9B3E6DEF6A4267C--
