Return-Path: <cyrus@holtmann.org>
Message-ID: <4A0DE78B.8080503@dell.com>
Date: Fri, 15 May 2009 17:07:07 -0500
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/3] Add support for command line arguments on hid2hci
 tool
References: <4A0DC533.8080900@dell.com> <1242418278.3446.20.camel@localhost.localdomain>
In-Reply-To: <1242418278.3446.20.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1621B82AF2BCECFF7703D681"
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1621B82AF2BCECFF7703D681
Content-Type: multipart/mixed;
 boundary="------------080605090509020303040808"

This is a multi-part message in MIME format.
--------------080605090509020303040808
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Marcel:

Marcel Holtmann wrote:
> Hi Mario,
>
> please restrict the commit message to 70-72 chars per line.
>
> And please do the following changes:
>
> s/radiomode/mode/ since it is not about the radio part here.
>
> s/hidproxy/csr/ if you wanna expose this then call it what it is.
>
> And go over the coding style once more since there are some cases where=

> it breaks.
>
> Also please split Makefile/rules changes from the actual code changes. =
I
> want two patches here. One that fixes the code and another one that
> takes care of the udev integration.
>
> Other than that, looks pretty good.
>
> Regards
>
> Marcel
>  =20
Thanks for the feedback.  I've hopefully addressed all of your
concerns.  If you still have problems with coding style, can you please
point them out specifically?  The attached patch is the code portion of
the split up patch.  Again it's attached so my mail server doesn't
mangle it.

Regards
--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com

--------------080605090509020303040808
Content-Type: text/x-patch;
 name="0001-Add-support-for-command-line-arguments-on-hid2hci-to.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename*0="0001-Add-support-for-command-line-arguments-on-hid2hci-to.pa";
 filename*1="tch"

=46rom cdb895e4ed76b2474ae6309456ec0f4222a7051c Mon Sep 17 00:00:00 2001
From: Mario Limonciello <Mario_Limonciello@Dell.com>
Date: Fri, 15 May 2009 16:31:42 -0500
Subject: [PATCH] Add support for command line arguments on hid2hci tool.
 This means that the hid2hci tool will not have to run on every bootup
 for every machine with bluez installed.  It instead gets ran on demand
 if a product that is called out from a udev rules file contains the
 correct attributes and/or VID/PID.

It also makes it easier for users to manually test new VID/PID
combinations to determine if they should be supported by bluez.
---
 tools/hid2hci.8 |   18 ++++--
 tools/hid2hci.c |  172 ++++++++++++++++++++++---------------------------=
------
 2 files changed, 81 insertions(+), 109 deletions(-)

diff --git a/tools/hid2hci.8 b/tools/hid2hci.8
index 6aa9be2..e3dd0d6 100644
--- a/tools/hid2hci.8
+++ b/tools/hid2hci.8
@@ -14,7 +14,7 @@
 .\"	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 .\"
 .\"
-.TH HID2HCI 8 "JUNE 6, 2003" "" ""
+.TH HID2HCI 8 "MAY 15, 2009" "" ""
=20
 .SH NAME
 hid2hci \- Bluetooth HID to HCI mode switching utility
@@ -25,7 +25,7 @@ hid2hci \- Bluetooth HID to HCI mode switching utility
 ]
 .SH DESCRIPTION
 .B hid2hci
-is used to set up switch HID proxy Bluetooth dongle into the HCI
+is used to set up switch supported bluetooth devices into the HCI
 mode and back.
 .SH OPTIONS
 .TP
@@ -35,11 +35,17 @@ Gives a list of possible options.
 .BI -q
 Don't display any messages.
 .TP
-.BI -0
-Switches the device into HCI mode.
+.BI -r [hid,hci]
+Sets the mode to switch the device into
 .TP
-.BI -1
-Switches the device into HID mode.
+.BI -v
+Specifies the 4 digit vendor ID assigned to the device being switched
+.TP
+.BI -p
+Specifies the 4 digit product ID assigned to the device being switched
+.TP
+.BI -m [csr, logitech, dell]
+Which vendor method to use for switching the device.
 .SH AUTHOR
 Written by Marcel Holtmann <marcel@holtmann.org>.
 .br
diff --git a/tools/hid2hci.c b/tools/hid2hci.c
index cd38aac..7692de3 100644
--- a/tools/hid2hci.c
+++ b/tools/hid2hci.c
@@ -86,21 +86,14 @@ struct hiddev_usage_ref {
 #define HCI 0
 #define HID 1
=20
-struct device_info;
-
-struct device_id {
+struct device_info {
+	struct usb_device *dev;
 	int mode;
 	uint16_t vendor;
 	uint16_t product;
-	int (*func)(struct device_info *dev);
-};
-
-struct device_info {
-	struct usb_device *dev;
-	struct device_id *id;
 };
=20
-static int switch_hidproxy(struct device_info *devinfo)
+static int switch_csr(struct device_info *devinfo)
 {
 	struct usb_dev_handle *udev;
 	int err;
@@ -110,7 +103,7 @@ static int switch_hidproxy(struct device_info *devinf=
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
@@ -243,77 +236,31 @@ static int switch_dell(struct device_info *devinfo)=

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
+				return 1;
 			}
 		}
-
-	return count;
+	return 0;
 }
=20
-static void usage(void)
+static void usage(char* error)
 {
-	printf("hid2hci - Bluetooth HID to HCI mode switching utility\n\n");
+	if (error)
+		fprintf(stderr,"\n%s\n", error);
+	else
+		printf("hid2hci - Bluetooth HID to HCI mode switching utility\n\n");
=20
 	printf("Usage:\n"
 		"\thid2hci [options]\n"
@@ -322,73 +269,92 @@ static void usage(void)
 	printf("Options:\n"
 		"\t-h, --help           Display help\n"
 		"\t-q, --quiet          Don't display any messages\n"
-		"\t-0, --tohci          Switch to HCI mode (default)\n"
-		"\t-1, --tohid          Switch to HID mode\n"
+		"\t-r, --mode=3D          Mode to switch to [hid, hci]\n"
+		"\t-v, --vendor=3D        Vendor ID to act upon\n"
+		"\t-p, --product=3D       Product ID to act upon\n"
+		"\t-m, --method=3D        Method to use to switch [csr, logitech, dell=
]\n"
 		"\n");
+	if (error)
+		exit(1);
 }
=20
 static struct option main_options[] =3D {
-	{ "help",	0, 0, 'h' },
-	{ "quiet",	0, 0, 'q' },
-	{ "tohci",	0, 0, '0' },
-	{ "tohid",	0, 0, '1' },
+	{ "help",	no_argument, 0, 'h' },
+	{ "quiet",	no_argument, 0, 'q' },
+	{ "mode",	required_argument, 0, 'r' },
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
+		case 'r':
+			if (optarg && !strcmp(optarg, "hid"))
+				dev.mode =3D HID;
+			else if (optarg && !strcmp(optarg, "hci"))
+				dev.mode =3D HCI;
+			else
+				usage("ERROR: Undefined radio mode\n");
+			break;
+		case 'v':
+			sscanf(optarg, "%4hx", &dev.vendor);
+			break;
+		case 'p':
+			sscanf(optarg, "%4hx", &dev.product);
 			break;
-		case '1':
-			mode =3D HID;
+		case 'm':
+			if (optarg && !strcmp(optarg, "csr"))
+				method =3D switch_csr;
+			else if (optarg && !strcmp(optarg, "logitech"))
+				method =3D switch_logitech;
+			else if (optarg && !strcmp(optarg, "dell"))
+				method =3D switch_dell;
+			else
+				usage("ERROR: Undefined switching method\n");
 			break;
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
=20
+	if (!quiet && (!dev.vendor || !dev.product || !method))
+		usage("ERROR: Vendor ID, Product ID, and Switching Method must all be =
defined.\n");
+
 	argc -=3D optind;
 	argv +=3D optind;
 	optind =3D 0;
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
-		if (!quiet)
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
-	}
+	if (method(&dev) < 0 && !quiet)
+		printf("failed (%s)\n", strerror(errno));
+	else if (!quiet)
+		printf("was successful\n");
=20
-	return 0;
+	return errno;
 }
--=20
1.6.0.4


--------------080605090509020303040808--

--------------enig1621B82AF2BCECFF7703D681
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkoN54sACgkQ2CrZjkA73YuJTwCgg432kqy8N0eYH36mslZcReZY
450An2v7bXGt1x2LztYr1gQ8d7c+Bb07
=dCAX
-----END PGP SIGNATURE-----

--------------enig1621B82AF2BCECFF7703D681--
