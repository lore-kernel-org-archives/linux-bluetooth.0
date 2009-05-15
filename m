Return-Path: <cyrus@holtmann.org>
Message-ID: <4A0DC533.8080900@dell.com>
Date: Fri, 15 May 2009 14:40:35 -0500
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH 1/3] Add support for command line arguments on hid2hci tool
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8731BA0B5BA810ED7D0EBA0A"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8731BA0B5BA810ED7D0EBA0A
Content-Type: multipart/mixed;
 boundary="------------030102020700020201000904"

This is a multi-part message in MIME format.
--------------030102020700020201000904
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This means that hid2hci won't have to run
 on every bootup for every machine with bluetooth installed.  It instead
gets ran on demand if a
 product that is called out from the dbus rules file contains the
correct attributes and/or VID/PID.

 It also makes it easier for users to manually test new VID/PID
combinations that may or may not
 be yet supported by bluez.
---
 scripts/Makefile.am       |   12 ++-
 scripts/bluetooth.default |    3 -
 scripts/bluetooth.init    |    7 --
 scripts/hid2hci.rules     |   38 ++++++++++
 tools/hid2hci.c           |  179
+++++++++++++++++++-------------------------
 5 files changed, 124 insertions(+), 115 deletions(-)
 create mode 100644 scripts/hid2hci.rules

Attaching patch as Exchange would mangle otherwise.

Thanks,
--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com

--------------030102020700020201000904
Content-Type: text/x-patch;
 name="0001-Add-support-for-command-line-arguments-on-hid2hci-to.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename*0="0001-Add-support-for-command-line-arguments-on-hid2hci-to.pa";
 filename*1="tch"

=46rom d95fe2f74815243123bff8f34cb427d901e3ba32 Mon Sep 17 00:00:00 2001
From: Mario Limonciello <Mario_Limonciello@Dell.com>
Date: Fri, 15 May 2009 14:29:03 -0500
Subject: [PATCH] Add support for command line arguments on hid2hci tool. =
=20
 This means that hid2hci won't have to run
 on every bootup for every machine with bluetooth installed.  It instead =
gets ran on demand if a
 product that is called out from the dbus rules file contains the correct=
 attributes and/or VID/PID.

 It also makes it easier for users to manually test new VID/PID combinati=
ons that may or may not
 be yet supported by bluez.
---
 scripts/Makefile.am       |   12 ++-
 scripts/bluetooth.default |    3 -
 scripts/bluetooth.init    |    7 --
 scripts/hid2hci.rules     |   38 ++++++++++
 tools/hid2hci.c           |  179 +++++++++++++++++++--------------------=
-----
 5 files changed, 124 insertions(+), 115 deletions(-)
 create mode 100644 scripts/hid2hci.rules

diff --git a/scripts/Makefile.am b/scripts/Makefile.am
index 6a8eec7..a9d09c0 100644
--- a/scripts/Makefile.am
+++ b/scripts/Makefile.am
@@ -1,14 +1,20 @@
+rulesdir =3D $(sysconfdir)/udev
+
+udevdir =3D $(libexecdir)/udev
=20
 if PCMCIARULES
-rulesdir =3D $(sysconfdir)/udev
=20
 rules_DATA =3D bluetooth.rules
=20
-udevdir =3D $(libexecdir)/udev
-
 udev_SCRIPTS =3D bluetooth_serial
 endif
=20
+if HID2HCI
+
+rules_DATA =3D $rules_DATA hid2hci.rules
+
+endif
+
 EXTRA_DIST =3D bluetooth.rules bluetooth_serial bluetooth.init bluetooth=
=2Edefault
=20
 MAINTAINERCLEANFILES =3D Makefile.in
diff --git a/scripts/bluetooth.default b/scripts/bluetooth.default
index b0c4493..cdf37fa 100644
--- a/scripts/bluetooth.default
+++ b/scripts/bluetooth.default
@@ -1,4 +1 @@
 # Bluetooth configuraton file
-
-# Run hid2hci (allowed values are "true" and "false")
-HID2HCI_ENABLE=3Dtrue
diff --git a/scripts/bluetooth.init b/scripts/bluetooth.init
index ee12408..3ea8a89 100644
--- a/scripts/bluetooth.init
+++ b/scripts/bluetooth.init
@@ -10,13 +10,10 @@ NAME=3Dbluetooth
 DESC=3D"Bluetooth subsystem"
=20
 DAEMON_NAME=3Dbluetoothd
-HID2HCI_NAME=3Dhid2hci
=20
 DAEMON_EXEC=3D"`which $DAEMON_NAME || true`"
-HID2HCI_EXEC=3D"`which $HID2HCI_NAME || true`"
=20
 DAEMON_ENABLE=3Dtrue
-HID2HCI_ENABLE=3Dfalse
=20
 [ -e /etc/default/bluetooth ] && . /etc/default/bluetooth
=20
@@ -27,10 +24,6 @@ case "$1" in
 		$DAEMON_EXEC
 		echo -n " $DAEMON_NAME"
 	fi
-	if $HID2HCI_ENABLE && [ -x "$HID2HCI_EXEC" ] ; then
-		$HID2HCI_EXEC --tohci > /dev/null 2>&1 || true
-		echo -n " $HID2HCI_NAME"
-	fi
 	echo "."
 	;;
   stop)
diff --git a/scripts/hid2hci.rules b/scripts/hid2hci.rules
new file mode 100644
index 0000000..ee15c72
--- /dev/null
+++ b/scripts/hid2hci.rules
@@ -0,0 +1,38 @@
+#UDEV Rules to match on Bluetooth USB dongles that need to be switched t=
o HCI mode upon
+#being plugged into the PC's USB bus.
+
+##Variety of Dell Bluetooth adapters
+# it looks like a bit of an odd rule, because it is matching
+# on a mouse device that is self powered, but that is where
+# a HID report needs to be sent to switch modes.
+#Known supported devices:
+# 413c:8154
+# 413c:8158
+# 413c:8162
+ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"413c", ENV{ID_CLASS}=3D=3D"mouse=
", ATTRS{bmAttributes}=3D=3D"e0", KERNEL=3D=3D"mouse*", RUN+=3D"/usr/sbin=
/hid2hci --method dell -v $env{ID_VENDOR} -p $env{ID_MODEL} --radiomode h=
ci"
+
+##Logitech adapters
+ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"046d", ENV{ID_MODEL}=3D=3D"c703"=
 RUN+=3D"/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{I=
D_MODEL} --radiomode hci"
+ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"046d", ENV{ID_MODEL}=3D=3D"c704"=
 RUN+=3D"/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{I=
D_MODEL} --radiomode hci"
+ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"046d", ENV{ID_MODEL}=3D=3D"c705"=
 RUN+=3D"/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{I=
D_MODEL} --radiomode hci"
+ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"046d", ENV{ID_MODEL}=3D=3D"c70a"=
 RUN+=3D"/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{I=
D_MODEL} --radiomode hci"
+ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"046d", ENV{ID_MODEL}=3D=3D"c70b"=
 RUN+=3D"/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{I=
D_MODEL} --radiomode hci"
+ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"046d", ENV{ID_MODEL}=3D=3D"c70c"=
 RUN+=3D"/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{I=
D_MODEL} --radiomode hci"
+ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"046d", ENV{ID_MODEL}=3D=3D"c70e"=
 RUN+=3D"/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{I=
D_MODEL} --radiomode hci"
+ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"046d", ENV{ID_MODEL}=3D=3D"c713"=
 RUN+=3D"/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{I=
D_MODEL} --radiomode hci"
+ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"046d", ENV{ID_MODEL}=3D=3D"c714"=
 RUN+=3D"/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{I=
D_MODEL} --radiomode hci"
+ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"046d", ENV{ID_MODEL}=3D=3D"c71b"=
 RUN+=3D"/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{I=
D_MODEL} --radiomode hci"
+ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"046d", ENV{ID_MODEL}=3D=3D"c71c"=
 RUN+=3D"/usr/sbin/hid2hci --method logitech -v $env{ID_VENDOR} -p $env{I=
D_MODEL} --radiomode hci"
+
+##HID Proxy adapters
+#These rules are for hid proxy adapters to default them to hci mode
+ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"0a12", ENV{ID_MODEL}=3D=3D"1000"=
 RUN+=3D"/usr/sbin/hid2hci --method hidproxy -v $env{ID_VENDOR} -p $env{I=
D_MODEL} --radiomode hci"
+ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"0458", ENV{ID_MODEL}=3D=3D"1000"=
 RUN+=3D"/usr/sbin/hid2hci --method hidproxy -v $env{ID_VENDOR} -p $env{I=
D_MODEL} --radiomode hci"
+ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"05ac", ENV{ID_MODEL}=3D=3D"1000"=
 RUN+=3D"/usr/sbin/hid2hci --method hidproxy -v $env{ID_VENDOR} -p $env{I=
D_MODEL} --radiomode hci"
+
+#These rules are for hid proxy adapters to default them to hid mode
+#ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"0a12", ENV{ID_MODEL}=3D=3D"0001=
" RUN+=3D"/usr/sbin/hid2hci --method hidproxy -v $env{ID_VENDOR} -p $env{=
ID_MODEL} --radiomode hid"
+#ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"0458", ENV{ID_MODEL}=3D=3D"003f=
" RUN+=3D"/usr/sbin/hid2hci --method hidproxy -v $env{ID_VENDOR} -p $env{=
ID_MODEL} --radiomode hid"
+#ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"05ac", ENV{ID_MODEL}=3D=3D"8203=
" RUN+=3D"/usr/sbin/hid2hci --method hidproxy -v $env{ID_VENDOR} -p $env{=
ID_MODEL} --radiomode hid"
+#ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"05ac", ENV{ID_MODEL}=3D=3D"8204=
" RUN+=3D"/usr/sbin/hid2hci --method hidproxy -v $env{ID_VENDOR} -p $env{=
ID_MODEL} --radiomode hid"
+#ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"05ac", ENV{ID_MODEL}=3D=3D"8207=
" RUN+=3D"/usr/sbin/hid2hci --method hidproxy -v $env{ID_VENDOR} -p $env{=
ID_MODEL} --radiomode hid"
diff --git a/tools/hid2hci.c b/tools/hid2hci.c
index cd38aac..dace0ea 100644
--- a/tools/hid2hci.c
+++ b/tools/hid2hci.c
@@ -83,21 +83,15 @@ struct hiddev_usage_ref {
=20
 #define HID_REPORT_TYPE_OUTPUT	2
=20
-#define HCI 0
-#define HID 1
-
-struct device_info;
-
-struct device_id {
-	int mode;
-	uint16_t vendor;
-	uint16_t product;
-	int (*func)(struct device_info *dev);
+enum radio_modes {
+	HCI=3D0, HID=3D1=20
 };
=20
 struct device_info {
 	struct usb_device *dev;
-	struct device_id *id;
+	int mode;
+	uint16_t vendor;
+	uint16_t product;
 };
=20
 static int switch_hidproxy(struct device_info *devinfo)
@@ -110,7 +104,7 @@ static int switch_hidproxy(struct device_info *devinf=
o)
 		return -errno;
=20
 	err =3D usb_control_msg(udev, USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP=
_DEVICE,
-				0, devinfo->id->mode, 0, NULL, 0, 10000);
+				0, devinfo->mode, 0, NULL, 0, 10000);
=20
 	if (err =3D=3D 0) {
 		err =3D -1;
@@ -243,77 +237,33 @@ static int switch_dell(struct device_info *devinfo)=

 	return err;
 }
=20
-static struct device_id device_list[] =3D {
-	{ HCI, 0x0a12, 0x1000, switch_hidproxy },
-	{ HID, 0x0a12, 0x0001, switch_hidproxy },
-	{ HCI, 0x0458, 0x1000, switch_hidproxy },
-	{ HID, 0x0458, 0x003f, switch_hidproxy },
-	{ HCI, 0x05ac, 0x1000, switch_hidproxy },
-	{ HID, 0x05ac, 0x8203, switch_hidproxy },
-	{ HID, 0x05ac, 0x8204, switch_hidproxy },	/* Apple Mac mini */
-	{ HID, 0x05ac, 0x8207, switch_hidproxy },	/* Apple Power Mac G5 */
-	{ HCI, 0x046d, 0xc703, switch_logitech },
-	{ HCI, 0x046d, 0xc704, switch_logitech },
-	{ HCI, 0x046d, 0xc705, switch_logitech },
-	{ HCI, 0x046d, 0xc70a, switch_logitech },	/* Logitech diNovo mouse */
-	{ HCI, 0x046d, 0xc70b, switch_logitech },	/* Logitech diNovo Laser keyb=
oard */
-	{ HCI, 0x046d, 0xc70c, switch_logitech },	/* Logitech diNovo Laser mous=
e */
-	{ HCI, 0x046d, 0xc70e, switch_logitech },	/* Logitech diNovo keyboard *=
/
-	{ HCI, 0x046d, 0xc713, switch_logitech },	/* Logitech diNovo Edge */
-	{ HCI, 0x046d, 0xc714, switch_logitech },	/* Logitech diNovo Edge */
-	{ HCI, 0x046d, 0xc71b, switch_logitech },	/* Logitech diNovo Edge */
-	{ HCI, 0x046d, 0xc71c, switch_logitech },	/* Logitech diNovo Edge */
-	{ HCI, 0x413c, 0x8154, switch_dell     },	/* Dell Wireless 410 */
-	{ HCI, 0x413c, 0x8158, switch_dell     },	/* Dell Wireless 370 */
-	{ HCI, 0x413c, 0x8162, switch_dell     },	/* Dell Wireless 365 */
-	{ -1 }
-};
-
-static struct device_id *match_device(int mode, uint16_t vendor, uint16_=
t product)
-{
-	int i;
-
-	for (i =3D 0; device_list[i].mode >=3D 0; i++) {
-		if (mode !=3D device_list[i].mode)
-			continue;
-		if (vendor =3D=3D device_list[i].vendor &&
-				product =3D=3D device_list[i].product)
-			return &device_list[i];
-	}
-
-	return NULL;
-}
-
-static int find_devices(int mode, struct device_info *devinfo, size_t si=
ze)
+static int find_device(struct device_info* devinfo)
 {
 	struct usb_bus *bus;
 	struct usb_device *dev;
-	struct device_id *id;
-	unsigned int count =3D 0;
=20
 	usb_find_busses();
 	usb_find_devices();
=20
 	for (bus =3D usb_get_busses(); bus; bus =3D bus->next)
 		for (dev =3D bus->devices; dev; dev =3D dev->next) {
-			id =3D match_device(mode, dev->descriptor.idVendor,
-						dev->descriptor.idProduct);
-			if (!id)
-				continue;
-
-			if (count < size) {
-				devinfo[count].dev =3D dev;
-				devinfo[count].id =3D id;
-				count++;
+			if (dev->descriptor.idVendor =3D=3D devinfo->vendor &&
+			    dev->descriptor.idProduct =3D=3D devinfo->product) {
+				devinfo->dev=3Ddev;
+				break;
 			}
 		}
-
-	return count;
+	if (!devinfo->dev)
+		return 0;
+	return 1;
 }
=20
-static void usage(void)
+static void usage(char* error)
 {
-	printf("hid2hci - Bluetooth HID to HCI mode switching utility\n\n");
+	if (error)
+		printf("\n%s\n", error);
+	else
+		printf("hid2hci - Bluetooth HID to HCI mode switching utility\n\n");
=20
 	printf("Usage:\n"
 		"\thid2hci [options]\n"
@@ -322,42 +272,71 @@ static void usage(void)
 	printf("Options:\n"
 		"\t-h, --help           Display help\n"
 		"\t-q, --quiet          Don't display any messages\n"
-		"\t-0, --tohci          Switch to HCI mode (default)\n"
-		"\t-1, --tohid          Switch to HID mode\n"
+		"\t-r, --radiomode=3D     Radio Mode to switch to [hid, hci]\n"
+		"\t-v, --vendor=3D        Vendor ID to act upon\n"
+		"\t-p, --product=3D       Product ID to act upon\n"
+		"\t-m, --method=3D        Method to use to switch [hidproxy, logitech,=
 dell]\n"
 		"\n");
+	if (error)
+		exit(1);
+	exit(0);
 }
=20
 static struct option main_options[] =3D {
-	{ "help",	0, 0, 'h' },
-	{ "quiet",	0, 0, 'q' },
-	{ "tohci",	0, 0, '0' },
-	{ "tohid",	0, 0, '1' },
+	{ "help",	no_argument, 0, 'h' },
+	{ "quiet",	no_argument, 0, 'q' },
+	{ "radiomode",	required_argument, 0, 'r' },
+	{ "vendor",	required_argument, 0, 'v' },
+	{ "product",	required_argument, 0, 'p' },
+	{ "method",	required_argument, 0, 'm' },
 	{ 0, 0, 0, 0 }
 };
=20
 int main(int argc, char *argv[])
 {
-	struct device_info dev[16];
-	int i, opt, num, quiet =3D 0, mode =3D HCI;
+	struct device_info dev =3D { NULL, HCI, 0, 0 };
+	int opt, quiet =3D 0;
+	int (*method)(struct device_info *dev) =3D NULL;
=20
-	while ((opt =3D getopt_long(argc, argv, "+01qh", main_options, NULL)) !=
=3D -1) {
+	while ((opt =3D getopt_long(argc, argv, "+r:v:p:m:qh", main_options, NU=
LL)) !=3D -1) {
 		switch (opt) {
-		case '0':
-			mode =3D HCI;
-			break;
-		case '1':
-			mode =3D HID;
+		case 'r':
+			if (optarg && !strcmp(optarg, "hid"))
+				dev.mode =3D HID;
+			else if (optarg && !strcmp(optarg, "hci"))
+				dev.mode =3D HCI;
+			else {
+				usage("ERROR: Undefined radio mode\n");
+			}
 			break;
+		case 'v':
+				sscanf(optarg, "%4hx", &dev.vendor);
+				break;
+		case 'p':
+				sscanf(optarg, "%4hx", &dev.product);
+				break;
+		case 'm':
+				if (optarg && !strcmp(optarg, "hidproxy"))
+					method =3D switch_hidproxy;
+				else if (optarg && !strcmp(optarg, "logitech"))
+					method =3D switch_logitech;
+				else if (optarg && !strcmp(optarg, "dell"))
+					method =3D switch_dell;
+				else
+					usage("ERROR: Undefined switching method\n");
+				break;
 		case 'q':
 			quiet =3D 1;
 			break;
 		case 'h':
-			usage();
-			exit(0);
+			usage(NULL);
 		default:
 			exit(0);
 		}
 	}
+=09
+	if (!quiet && (!dev.vendor || !dev.product || !method))
+		usage("ERROR: Vendor ID, Product ID, and Switching Method must all be =
defined.\n");
=20
 	argc -=3D optind;
 	argv +=3D optind;
@@ -365,29 +344,25 @@ int main(int argc, char *argv[])
=20
 	usb_init();
=20
-	num =3D find_devices(mode, dev, sizeof(dev) / sizeof(dev[0]));
-	if (num <=3D 0) {
+	if (!find_device(&dev)) {
 		if (!quiet)
-			fprintf(stderr, "No devices in %s mode found\n",
-							mode ? "HCI" : "HID");
+			fprintf(stderr, "Device %04x:%04x not found on USB bus.\n",
+				dev.vendor, dev.product);
 		exit(1);
 	}
=20
-	for (i =3D 0; i < num; i++) {
-		struct device_id *id =3D dev[i].id;
+	if (!quiet)
+		printf("Attempting to switch device %04x:%04x to %s mode ",
+			dev.vendor, dev.product, dev.mode ? "HID" : "HCI");
+	fflush(stdout);
=20
+	if (method(&dev) < 0) {
 		if (!quiet)
-			printf("Switching device %04x:%04x to %s mode ",
-				id->vendor, id->product, mode ? "HID" : "HCI");
-		fflush(stdout);
-
-		if (id->func(&dev[i]) < 0) {
-			if (!quiet)
-				printf("failed (%s)\n", strerror(errno));
-		} else {
-			if (!quiet)
-				printf("was successful\n");
-		}
+			printf("failed (%s)\n", strerror(errno));
+		exit(errno);
+	} else {
+		if (!quiet)
+			printf("was successful\n");
 	}
=20
 	return 0;
--=20
1.6.0.4



--------------030102020700020201000904--

--------------enig8731BA0B5BA810ED7D0EBA0A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkoNxTMACgkQ2CrZjkA73YuYuwCfWTNs1o0YUuEs5nshdSfAxJRn
i+sAn3b0HK22iLdGLhWXGn3uHqUz0q5h
=aJHu
-----END PGP SIGNATURE-----

--------------enig8731BA0B5BA810ED7D0EBA0A--
