Return-Path: <cyrus@holtmann.org>
Subject: [PATCHes] Add sixpair
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-SALUMSSndBB+So5TnjZF"
Date: Wed, 15 Oct 2008 16:15:27 +0100
Message-Id: <1224083727.5268.3149.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-SALUMSSndBB+So5TnjZF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Heya,

Here are the patches to get sixpair support built into BlueZ. It uses
libusb-1.0 as well as a yet to be merged libusb-1.0 patch to allow
re-attaching a driver to a device.

Problems left to solve:
- sixaxis enabler code (as seen in enable_sixaxis() in compat/hidd.c)
seems to have disappeared from the input plugin. Is that done in the
kernel now, or was it just removed?
- After "cable pairing" the device, I need to unplug/replug the adapter,
or restart bluetoothd. Can anyone think of a better way of getting the
list of devices updated?
- Some minor niggles in the code itself (use D-Bus instead of parsing
command-line tools)
- udev rule(s) and parsing only the selected device would be necessary
if not required

Cheers

--=-SALUMSSndBB+So5TnjZF
Content-Disposition: attachment; filename="0001-Add-sixpair-tool.patch"
Content-Type: text/x-patch; name="0001-Add-sixpair-tool.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From c06f9fa3f7d088c173403d602209d7a18e7b00e5 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Sat, 11 Oct 2008 00:55:02 +0100
Subject: [PATCH] Add sixpair tool

Sixpair is an unfinished helper to automatically pair a
plugged in Playstation 3 Sixaxis Bluetooth joypad.
---
 input/sixpair.c |  393 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 393 insertions(+), 0 deletions(-)
 create mode 100644 input/sixpair.c

diff --git a/input/sixpair.c b/input/sixpair.c
new file mode 100644
index 0000000..818d283
--- /dev/null
+++ b/input/sixpair.c
@@ -0,0 +1,393 @@
+/* To compile
+ * gcc -g -Wall -I../src -I../lib/ -I../include -DSTORAGEDIR=\"/var/lib/bluetooth\" -o sixpair sixpair.c ../src/storage.c ../common/libhelper.a -I../common `pkg-config --libs --cflags glib-2.0 libusb` -lbluetooth
+ */
+
+#include <unistd.h>
+#include <stdio.h>
+#include <inttypes.h>
+
+#include <sdp.h>
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/hidp.h>
+#include <glib.h>
+#include <usb.h>
+
+#include "storage.h"
+
+/* Vendor and product ID for the Sixaxis PS3 controller */
+#define VENDOR 0x054c
+#define PRODUCT 0x0268
+
+#define USB_DIR_IN 0x80
+#define USB_DIR_OUT 0
+
+gboolean option_get_master = TRUE;
+char *option_master= NULL;
+gboolean option_store_info = TRUE;
+const char *option_device = NULL;
+gboolean option_quiet = FALSE;
+
+const GOptionEntry options[] = {
+	{ "get-master", '\0', 0, G_OPTION_ARG_NONE, &option_get_master, "Get currently set master address", NULL },
+	{ "set-master", '\0', 0, G_OPTION_ARG_STRING, &option_master, "Set master address (\"auto\" for automatic)", NULL },
+	{ "store-info", '\0', 0, G_OPTION_ARG_NONE, &option_store_info, "Store the HID info into the input database", NULL },
+	{ "device", '\0', 0, G_OPTION_ARG_STRING, &option_device, "Only handle one device (default, all supported", NULL },
+	{ "quiet", 'q', 0, G_OPTION_ARG_NONE, &option_quiet, "Quieten the output", NULL },
+	{ NULL }
+};
+
+static gboolean
+show_master (usb_dev_handle *devh, int itfnum)
+{
+	unsigned char msg[8];
+	int res;
+
+	res = usb_control_msg (devh,
+			       USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
+			       0x01, 0x03f5, itfnum,
+			       (void*) msg, sizeof(msg),
+			       5000);
+
+	if (res < 0) {
+		g_warning ("Getting the master Bluetooth address failed");
+		return FALSE;
+	}
+	g_print ("Current Bluetooth master: %02x:%02x:%02x:%02x:%02x:%02x\n",
+		 msg[2], msg[3], msg[4], msg[5], msg[6], msg[7]);
+
+	return TRUE;
+}
+
+static char *
+get_bdaddr (usb_dev_handle *devh, int itfnum)
+{
+	unsigned char msg[17];
+	char *address;
+	int res;
+
+	res = usb_control_msg (devh,
+			       USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
+			       0x01, 0x03f2, itfnum,
+			       (void*) msg, sizeof(msg),
+			       5000);
+
+	if (res < 0) {
+		g_warning ("Getting the device Bluetooth address failed");
+		return NULL;
+	}
+
+	address = g_strdup_printf ("%02x:%02x:%02x:%02x:%02x:%02x",
+				   msg[4], msg[5], msg[6], msg[7], msg[8], msg[9]);
+
+	if (option_quiet == FALSE) {
+		g_print ("Device Bluetooth address: %s\n", address);
+	}
+
+	return address;
+}
+
+static gboolean
+set_master_bdaddr (usb_dev_handle *devh, int itfnum, char *host)
+{
+	unsigned char msg[8];
+	int mac[6];
+	int res;
+
+	if (sscanf(host, "%x:%x:%x:%x:%x:%x",
+		   &mac[0],&mac[1],&mac[2],&mac[3],&mac[4],&mac[5]) != 6) {
+		return FALSE;
+	}
+
+	msg[0] = 0x01;
+	msg[1] = 0x00;
+	msg[2] = mac[0];
+	msg[3] = mac[1];
+	msg[4] = mac[2];
+	msg[5] = mac[3];
+	msg[6] = mac[4];
+	msg[7] = mac[5];
+
+	res = usb_control_msg (devh,
+			       USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
+			       0x09, 0x03f5, itfnum,
+			       (void*) msg, sizeof(msg),
+			       5000);
+
+	if (res < 0) {
+		g_warning ("Setting the master Bluetooth address failed");
+		return FALSE;
+	}
+
+	return TRUE;
+
+}
+
+static char *
+get_host_bdaddr (void)
+{
+	FILE *f;
+	int mac[6];
+
+	//FIXME use dbus to get the default adapter
+
+	f = popen("hcitool dev", "r");
+
+	if (f == NULL) {
+		//FIXME
+		return NULL;
+	}
+	if (fscanf(f, "%*s\n%*s %x:%x:%x:%x:%x:%x",
+		   &mac[0],&mac[1],&mac[2],&mac[3],&mac[4],&mac[5]) != 6) {
+		//FIXME
+		return NULL;
+	}
+
+	return g_strdup_printf ("%x:%x:%x:%x:%x:%x", mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
+}
+
+static int
+get_record_info (struct usb_interface_descriptor *alt, unsigned int *_len, unsigned int *_country, uint16_t *_version)
+{
+	unsigned char *buf;
+	unsigned int size, len, country;
+	uint16_t version;
+	int l;
+
+	len = 0;
+	country = 0;
+	version = 0;
+
+	if (!alt->extralen)
+		return 0;
+
+	size = alt->extralen;
+	buf = alt->extra;
+	while (size >= 2 * sizeof(u_int8_t)) {
+		if (buf[0] < 2 || buf[1] != USB_DT_HID)
+			continue;
+
+		//FIXME that should be "21"
+		//g_message ("country: %u", buf[4]);
+		//country = buf[4];
+		//country = 0x21;
+		country = 0;
+		version = (buf[3] << 8) + buf[2];
+
+		for (l = 0; l < buf[5]; l++) {
+			/* we are just interested in report descriptors*/
+			if (buf[6+3*l] != USB_DT_REPORT)
+				continue;
+			len = buf[7+3*l] | (buf[8+3*l] << 8);
+		}
+		size -= buf[0];
+		buf += buf[0];
+	}
+
+	if (len == 0)
+		return -1;
+	*_len = len;
+	*_country = country;
+	*_version = version;
+
+	return 0;
+}
+
+static void
+fill_req_from_usb (struct usb_device *dev, struct hidp_connadd_req *req, void *data, unsigned int len, unsigned int country, uint16_t version)
+{
+	req->vendor = dev->descriptor.idVendor;
+	req->product = dev->descriptor.idProduct;
+	req->version = version;
+	/* req->subclass already set */
+	req->country = country;
+	/* Default value */
+	req->parser = 0x0100;
+	/* What are we expecting here? No idea, but we don't seem to need it */
+	req->flags = 0;
+
+	req->rd_size = len;
+	req->rd_data = data;
+}
+
+static void
+store_info (const char *host, const char *device, struct hidp_connadd_req *req)
+{
+	bdaddr_t dest, src;
+
+	if (str2ba (host, &src) < 0) {
+		//FIXME
+		return;
+	}
+	if (str2ba (device, &dest) < 0) {
+		//FIXME
+		return;
+	}
+
+#if 0
+	if (store_device_info (&src, &dest, req) < 0)
+#endif
+		g_message ("store_device_info failed");
+}
+
+static int
+handle_device (struct usb_device *dev, struct usb_config_descriptor *cfg, int itfnum, struct usb_interface_descriptor *alt)
+{
+	usb_dev_handle *devh;
+	int res, retval;
+
+	retval = -1;
+
+	devh = usb_open (dev);
+	if (devh == NULL) {
+		g_warning ("Can't open device");
+		goto bail;
+	}
+	usb_detach_kernel_driver_np (devh, itfnum);
+
+	res = usb_claim_interface (devh, itfnum);
+	if (res < 0) {
+		g_warning ("Can't claim interface %d", itfnum);
+		goto bail;
+	}
+
+	if (option_get_master != FALSE) {
+		if (show_master (devh, itfnum) == FALSE)
+			goto bail;
+		retval = 0;
+	}
+
+	if (option_master != NULL) {
+		if (strcmp (option_master, "auto") == 0) {
+			g_free (option_master);
+			option_master = get_host_bdaddr ();
+			if (option_master == NULL) {
+				g_warning ("Can't get bdaddr from default device");
+				retval = -1;
+				goto bail;
+			}
+		}
+	} else {
+		option_master = get_host_bdaddr ();
+		if (option_master == NULL) {
+			g_warning ("Can't get bdaddr from default device");
+			retval = -1;
+			goto bail;
+		}
+	}
+
+	if (option_store_info != FALSE) {
+		unsigned char data[8192];
+		struct hidp_connadd_req req;
+		unsigned int len, country;
+		int n;
+		uint16_t version;
+		char *device;
+
+		device = get_bdaddr (devh, itfnum);
+		if (device == NULL) {
+			retval = -1;
+			goto bail;
+		}
+
+		if (get_record_info (alt, &len, &country, &version) < 0) {
+			g_warning ("Can't get record info");
+			retval = -1;
+			goto bail;
+		}
+
+		if ((n = usb_control_msg(devh,
+				    USB_ENDPOINT_IN | USB_TYPE_STANDARD | USB_RECIP_INTERFACE,
+				    USB_REQ_GET_DESCRIPTOR,
+				    (USB_DT_REPORT << 8),
+				    itfnum, (void *) &data, len, 5000)) < 0) {
+			g_warning ("Can't get report descriptor (length: %d, interface: %d)", len, itfnum);
+			retval = -1;
+			goto bail;
+		}
+
+		req.subclass = alt->bInterfaceSubClass;
+		fill_req_from_usb (dev, &req, data, len, country, version);
+
+		store_info (option_master, device, &req);
+
+		if (set_master_bdaddr (devh, itfnum, option_master) == FALSE) {
+			retval = -1;
+			goto bail;
+		}
+
+		//FIXME finally, set device as trusted
+	}
+
+bail:
+	if (devh != NULL)
+		usb_close (devh);
+
+	return retval;
+}
+
+int main (int argc, char **argv)
+{
+	GOptionContext *context;
+	GError *error = NULL;
+	struct usb_bus *busses, *bus;
+
+	context = g_option_context_new ("- Manage Sixaxis PS3 controllers");
+	g_option_context_add_main_entries (context, options, NULL);
+	if (g_option_context_parse (context, &argc, &argv, &error) == FALSE) {
+		g_warning ("Couldn't parse command-line options: %s", error->message);
+		return 1;
+	}
+
+	/* Check that the passed bdaddr is correct */
+	if (option_master != NULL && strcmp (option_master, "auto") != 0) {
+		//FIXME check bdaddr
+	}
+
+	/* Find device(s) */
+	usb_init ();
+	if (usb_find_busses () < 0) {
+		g_warning ("usb_find_busses failed");
+		return 1;
+	}
+	if (usb_find_devices () < 0) {
+		g_warning ("usb_find_devices failed");
+		return 1;
+	}
+
+	busses = usb_get_busses();
+	if (busses == NULL) {
+		g_warning ("usb_get_busses failed");
+		return 1;
+	}
+
+	for (bus = busses; bus; bus = bus->next) {
+		struct usb_device *dev;
+
+		for (dev = bus->devices; dev; dev = dev->next) {
+			struct usb_config_descriptor *cfg;
+
+			/* Here we check for the supported devices */
+			if (dev->descriptor.idVendor != VENDOR || dev->descriptor.idProduct != PRODUCT)
+				continue;
+
+			/* Look for the interface number that interests us */
+			for (cfg = dev->config; cfg < dev->config + dev->descriptor.bNumConfigurations; ++cfg) {
+				int itfnum;
+
+				for (itfnum = 0; itfnum < cfg->bNumInterfaces; ++itfnum) {
+					struct usb_interface *itf = &cfg->interface[itfnum];
+					struct usb_interface_descriptor *alt;
+
+					for (alt = itf->altsetting; alt < itf->altsetting + itf->num_altsetting; ++alt) {
+						if (alt->bInterfaceClass == 3) {
+							handle_device (dev, cfg, itfnum, alt);
+						}
+					}
+				}
+			}
+		}
+	}
+
+	return 0;
+}
+
-- 
1.5.5.2


--=-SALUMSSndBB+So5TnjZF
Content-Disposition: attachment; filename="0002-Port-sixpair-to-libusb-1.0.patch"
Content-Type: text/x-patch; name="0002-Port-sixpair-to-libusb-1.0.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From a08bf92d81cf0bd5201a5de18b313836726c2a7f Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Sat, 11 Oct 2008 23:34:34 +0100
Subject: [PATCH] Port sixpair to libusb 1.0

Port sixpair to libusb-1.0, as it allows us to re-attach
the driver to the device after we're done.
---
 input/sixpair.c |  142 ++++++++++++++++++++++++++++---------------------------
 1 files changed, 72 insertions(+), 70 deletions(-)

diff --git a/input/sixpair.c b/input/sixpair.c
index 818d283..07fa679 100644
--- a/input/sixpair.c
+++ b/input/sixpair.c
@@ -1,5 +1,5 @@
 /* To compile
- * gcc -g -Wall -I../src -I../lib/ -I../include -DSTORAGEDIR=\"/var/lib/bluetooth\" -o sixpair sixpair.c ../src/storage.c ../common/libhelper.a -I../common `pkg-config --libs --cflags glib-2.0 libusb` -lbluetooth
+ * gcc -g -Wall -I../src -I../lib/ -I../include -DSTORAGEDIR=\"/var/lib/bluetooth\" -o sixpair sixpair.c ../src/storage.c ../common/libhelper.a -I../common `pkg-config --libs --cflags glib-2.0 libusb-1.0` -lbluetooth
  */
 
 #include <unistd.h>
@@ -10,7 +10,7 @@
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hidp.h>
 #include <glib.h>
-#include <usb.h>
+#include <libusb.h>
 
 #include "storage.h"
 
@@ -18,9 +18,6 @@
 #define VENDOR 0x054c
 #define PRODUCT 0x0268
 
-#define USB_DIR_IN 0x80
-#define USB_DIR_OUT 0
-
 gboolean option_get_master = TRUE;
 char *option_master= NULL;
 gboolean option_store_info = TRUE;
@@ -37,16 +34,16 @@ const GOptionEntry options[] = {
 };
 
 static gboolean
-show_master (usb_dev_handle *devh, int itfnum)
+show_master (libusb_device_handle *devh, int itfnum)
 {
 	unsigned char msg[8];
 	int res;
 
-	res = usb_control_msg (devh,
-			       USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
-			       0x01, 0x03f5, itfnum,
-			       (void*) msg, sizeof(msg),
-			       5000);
+	res = libusb_control_transfer (devh,
+				       LIBUSB_ENDPOINT_IN | LIBUSB_REQUEST_TYPE_CLASS | LIBUSB_RECIPIENT_INTERFACE,
+				       0x01, 0x03f5, itfnum,
+				       (void*) msg, sizeof(msg),
+				       5000);
 
 	if (res < 0) {
 		g_warning ("Getting the master Bluetooth address failed");
@@ -59,17 +56,17 @@ show_master (usb_dev_handle *devh, int itfnum)
 }
 
 static char *
-get_bdaddr (usb_dev_handle *devh, int itfnum)
+get_bdaddr (libusb_device_handle *devh, int itfnum)
 {
 	unsigned char msg[17];
 	char *address;
 	int res;
 
-	res = usb_control_msg (devh,
-			       USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
-			       0x01, 0x03f2, itfnum,
-			       (void*) msg, sizeof(msg),
-			       5000);
+	res = libusb_control_transfer (devh,
+				       LIBUSB_ENDPOINT_IN | LIBUSB_REQUEST_TYPE_CLASS | LIBUSB_RECIPIENT_INTERFACE,
+				       0x01, 0x03f2, itfnum,
+				       (void*) msg, sizeof(msg),
+				       5000);
 
 	if (res < 0) {
 		g_warning ("Getting the device Bluetooth address failed");
@@ -87,7 +84,7 @@ get_bdaddr (usb_dev_handle *devh, int itfnum)
 }
 
 static gboolean
-set_master_bdaddr (usb_dev_handle *devh, int itfnum, char *host)
+set_master_bdaddr (libusb_device_handle *devh, int itfnum, char *host)
 {
 	unsigned char msg[8];
 	int mac[6];
@@ -107,11 +104,11 @@ set_master_bdaddr (usb_dev_handle *devh, int itfnum, char *host)
 	msg[6] = mac[4];
 	msg[7] = mac[5];
 
-	res = usb_control_msg (devh,
-			       USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
-			       0x09, 0x03f5, itfnum,
-			       (void*) msg, sizeof(msg),
-			       5000);
+	res = libusb_control_transfer (devh,
+				       LIBUSB_ENDPOINT_IN | LIBUSB_REQUEST_TYPE_CLASS | LIBUSB_RECIPIENT_INTERFACE,
+				       0x09, 0x03f5, itfnum,
+				       (void*) msg, sizeof(msg),
+				       5000);
 
 	if (res < 0) {
 		g_warning ("Setting the master Bluetooth address failed");
@@ -119,7 +116,6 @@ set_master_bdaddr (usb_dev_handle *devh, int itfnum, char *host)
 	}
 
 	return TRUE;
-
 }
 
 static char *
@@ -146,8 +142,9 @@ get_host_bdaddr (void)
 }
 
 static int
-get_record_info (struct usb_interface_descriptor *alt, unsigned int *_len, unsigned int *_country, uint16_t *_version)
+get_record_info (const struct libusb_interface_descriptor *alt, unsigned int *_len, unsigned int *_country, uint16_t *_version)
 {
+#if 0
 	unsigned char *buf;
 	unsigned int size, len, country;
 	uint16_t version;
@@ -188,13 +185,14 @@ get_record_info (struct usb_interface_descriptor *alt, unsigned int *_len, unsig
 	*_len = len;
 	*_country = country;
 	*_version = version;
-
+#endif
 	return 0;
 }
 
 static void
-fill_req_from_usb (struct usb_device *dev, struct hidp_connadd_req *req, void *data, unsigned int len, unsigned int country, uint16_t version)
+fill_req_from_usb (libusb_device *dev, struct hidp_connadd_req *req, void *data, unsigned int len, unsigned int country, uint16_t version)
 {
+#if 0
 	req->vendor = dev->descriptor.idVendor;
 	req->product = dev->descriptor.idProduct;
 	req->version = version;
@@ -207,6 +205,7 @@ fill_req_from_usb (struct usb_device *dev, struct hidp_connadd_req *req, void *d
 
 	req->rd_size = len;
 	req->rd_data = data;
+#endif
 }
 
 static void
@@ -230,21 +229,20 @@ store_info (const char *host, const char *device, struct hidp_connadd_req *req)
 }
 
 static int
-handle_device (struct usb_device *dev, struct usb_config_descriptor *cfg, int itfnum, struct usb_interface_descriptor *alt)
+handle_device (libusb_device *dev, struct libusb_config_descriptor *cfg, int itfnum, const struct libusb_interface_descriptor *alt)
 {
-	usb_dev_handle *devh;
+	libusb_device_handle *devh;
 	int res, retval;
 
 	retval = -1;
 
-	devh = usb_open (dev);
-	if (devh == NULL) {
+	if (libusb_open (dev, &devh) < 0) {
 		g_warning ("Can't open device");
 		goto bail;
 	}
-	usb_detach_kernel_driver_np (devh, itfnum);
+	libusb_detach_kernel_driver (devh, itfnum);
 
-	res = usb_claim_interface (devh, itfnum);
+	res = libusb_claim_interface (devh, itfnum);
 	if (res < 0) {
 		g_warning ("Can't claim interface %d", itfnum);
 		goto bail;
@@ -279,7 +277,6 @@ handle_device (struct usb_device *dev, struct usb_config_descriptor *cfg, int it
 		unsigned char data[8192];
 		struct hidp_connadd_req req;
 		unsigned int len, country;
-		int n;
 		uint16_t version;
 		char *device;
 
@@ -295,11 +292,11 @@ handle_device (struct usb_device *dev, struct usb_config_descriptor *cfg, int it
 			goto bail;
 		}
 
-		if ((n = usb_control_msg(devh,
-				    USB_ENDPOINT_IN | USB_TYPE_STANDARD | USB_RECIP_INTERFACE,
-				    USB_REQ_GET_DESCRIPTOR,
-				    (USB_DT_REPORT << 8),
-				    itfnum, (void *) &data, len, 5000)) < 0) {
+		if (libusb_control_transfer(devh,
+						 LIBUSB_ENDPOINT_IN | LIBUSB_REQUEST_TYPE_CLASS | LIBUSB_RECIPIENT_INTERFACE,
+						 LIBUSB_REQUEST_GET_DESCRIPTOR,
+						 (LIBUSB_DT_REPORT << 8),
+						 itfnum, (void *) &data, len, 5000) < 0) {
 			g_warning ("Can't get report descriptor (length: %d, interface: %d)", len, itfnum);
 			retval = -1;
 			goto bail;
@@ -319,8 +316,10 @@ handle_device (struct usb_device *dev, struct usb_config_descriptor *cfg, int it
 	}
 
 bail:
+	libusb_release_interface (devh, itfnum);
+	libusb_attach_kernel_driver(devh, itfnum);
 	if (devh != NULL)
-		usb_close (devh);
+		libusb_close (devh);
 
 	return retval;
 }
@@ -329,7 +328,8 @@ int main (int argc, char **argv)
 {
 	GOptionContext *context;
 	GError *error = NULL;
-	struct usb_bus *busses, *bus;
+	libusb_device **list;
+	ssize_t num_devices, i;
 
 	context = g_option_context_new ("- Manage Sixaxis PS3 controllers");
 	g_option_context_add_main_entries (context, options, NULL);
@@ -343,45 +343,47 @@ int main (int argc, char **argv)
 		//FIXME check bdaddr
 	}
 
+	libusb_init (NULL);
+
 	/* Find device(s) */
-	usb_init ();
-	if (usb_find_busses () < 0) {
-		g_warning ("usb_find_busses failed");
-		return 1;
-	}
-	if (usb_find_devices () < 0) {
-		g_warning ("usb_find_devices failed");
+	num_devices = libusb_get_device_list (NULL, &list);
+	if (num_devices < 0) {
+		g_warning ("libusb_get_device_list failed");
 		return 1;
 	}
 
-	busses = usb_get_busses();
-	if (busses == NULL) {
-		g_warning ("usb_get_busses failed");
-		return 1;
-	}
+	for (i = 0; i < num_devices; i++) {
+		struct libusb_config_descriptor *cfg;
+		libusb_device *dev = list[i];
+		struct libusb_device_descriptor desc;
+		guint8 j;
+
+		if (libusb_get_device_descriptor (dev, &desc) < 0) {
+			g_warning ("libusb_get_device_descriptor failed");
+			continue;
+		}
 
-	for (bus = busses; bus; bus = bus->next) {
-		struct usb_device *dev;
+		/* Here we check for the supported devices */
+		if (desc.idVendor != VENDOR || desc.idProduct != PRODUCT)
+			continue;
 
-		for (dev = bus->devices; dev; dev = dev->next) {
-			struct usb_config_descriptor *cfg;
+		/* Look for the interface number that interests us */
+		for (j = 0; j < desc.bNumConfigurations; j++) {
+			struct libusb_config_descriptor *config;
+			guint8 k;
 
-			/* Here we check for the supported devices */
-			if (dev->descriptor.idVendor != VENDOR || dev->descriptor.idProduct != PRODUCT)
-				continue;
+			libusb_get_config_descriptor (dev, j, &config);
 
-			/* Look for the interface number that interests us */
-			for (cfg = dev->config; cfg < dev->config + dev->descriptor.bNumConfigurations; ++cfg) {
-				int itfnum;
+			for (k = 0; k < config->bNumInterfaces; k++) {
+				const struct libusb_interface *itf = &config->interface[k];
+				int l;
 
-				for (itfnum = 0; itfnum < cfg->bNumInterfaces; ++itfnum) {
-					struct usb_interface *itf = &cfg->interface[itfnum];
-					struct usb_interface_descriptor *alt;
+				for (l = 0; l < itf->num_altsetting ; l++) {
+					struct libusb_interface_descriptor alt;
 
-					for (alt = itf->altsetting; alt < itf->altsetting + itf->num_altsetting; ++alt) {
-						if (alt->bInterfaceClass == 3) {
-							handle_device (dev, cfg, itfnum, alt);
-						}
+					alt = itf->altsetting[l];
+					if (alt.bInterfaceClass == 3) {
+						handle_device (dev, cfg, l, &alt);
 					}
 				}
 			}
-- 
1.5.5.2


--=-SALUMSSndBB+So5TnjZF
Content-Disposition: attachment; filename="0006-Fix-setting-the-master-address-on-the-sixaxis.patch"
Content-Type: text/x-patch; name="0006-Fix-setting-the-master-address-on-the-sixaxis.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 4a45364efa67dc7c5546f180bc7b67d64186d24c Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Wed, 15 Oct 2008 12:50:40 +0100
Subject: [PATCH] Fix setting the master address on the sixaxis

Direction for the USB command was wrong, also disable
all the report code, so sixpair can run (minus saving device
records)
---
 input/sixpair.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/input/sixpair.c b/input/sixpair.c
index 07fa679..92aa5f7 100644
--- a/input/sixpair.c
+++ b/input/sixpair.c
@@ -105,7 +105,7 @@ set_master_bdaddr (libusb_device_handle *devh, int itfnum, char *host)
 	msg[7] = mac[5];
 
 	res = libusb_control_transfer (devh,
-				       LIBUSB_ENDPOINT_IN | LIBUSB_REQUEST_TYPE_CLASS | LIBUSB_RECIPIENT_INTERFACE,
+				       LIBUSB_ENDPOINT_OUT | LIBUSB_REQUEST_TYPE_CLASS | LIBUSB_RECIPIENT_INTERFACE,
 				       0x09, 0x03f5, itfnum,
 				       (void*) msg, sizeof(msg),
 				       5000);
@@ -285,7 +285,7 @@ handle_device (libusb_device *dev, struct libusb_config_descriptor *cfg, int itf
 			retval = -1;
 			goto bail;
 		}
-
+#if 0
 		if (get_record_info (alt, &len, &country, &version) < 0) {
 			g_warning ("Can't get record info");
 			retval = -1;
@@ -306,7 +306,7 @@ handle_device (libusb_device *dev, struct libusb_config_descriptor *cfg, int itf
 		fill_req_from_usb (dev, &req, data, len, country, version);
 
 		store_info (option_master, device, &req);
-
+#endif
 		if (set_master_bdaddr (devh, itfnum, option_master) == FALSE) {
 			retval = -1;
 			goto bail;
@@ -317,7 +317,11 @@ handle_device (libusb_device *dev, struct libusb_config_descriptor *cfg, int itf
 
 bail:
 	libusb_release_interface (devh, itfnum);
-	libusb_attach_kernel_driver(devh, itfnum);
+	res = libusb_attach_kernel_driver(devh, itfnum);
+	if (res < 0) {
+		//FIXME sometimes the kernel tells us ENOENT, but succeeds anyway...
+		g_warning ("Reattaching the driver failed: %d", res);
+	}
 	if (devh != NULL)
 		libusb_close (devh);
 
-- 
1.5.5.2


--=-SALUMSSndBB+So5TnjZF
Content-Disposition: attachment; filename="0007-Export-record_from_string-from-the-storage-functio.patch"
Content-Type: text/x-patch; name="0007-Export-record_from_string-from-the-storage-functio.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 44c1f80129e2279246fff4e33fe7b2e89dc200a6 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Wed, 15 Oct 2008 15:20:22 +0100
Subject: [PATCH] Export record_from_string() from the storage functions

Export record_from_string() from the storage functions,
so it can be used to generate an sdp_record from a
static string in sixpair.c
---
 src/storage.c |    2 +-
 src/storage.h |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index d99fb33..ac1ec5b 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -771,7 +771,7 @@ int store_record(const gchar *src, const gchar *dst, sdp_record_t *rec)
 	return err;
 }
 
-static sdp_record_t *record_from_string(const gchar *str)
+sdp_record_t *record_from_string(const gchar *str)
 {
 	sdp_record_t *rec;
 	int size, i, len;
diff --git a/src/storage.h b/src/storage.h
index bff36a7..29f08d8 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -57,6 +57,7 @@ GSList *list_trusts(bdaddr_t *local, const char *service);
 int write_device_profiles(bdaddr_t *src, bdaddr_t *dst, const char *profiles);
 int delete_entry(bdaddr_t *src, const char *storage, const char *key);
 int store_record(const gchar *src, const gchar *dst, sdp_record_t *rec);
+sdp_record_t *record_from_string(const gchar *str);
 sdp_record_t *fetch_record(const gchar *src, const gchar *dst, const uint32_t handle);
 int delete_record(const gchar *src, const gchar *dst, const uint32_t handle);
 sdp_list_t *read_records(bdaddr_t *src, bdaddr_t *dst);
-- 
1.5.5.2


--=-SALUMSSndBB+So5TnjZF
Content-Disposition: attachment; filename*0=0008-Store-every-record-information-for-the-sixaxis-contr.pat; filename*1=ch
Content-Type: text/x-patch; name="0008-Store-every-record-information-for-the-sixaxis-contr.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From c78d0dfeeda1208bad41686b51b0a815c372be95 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Wed, 15 Oct 2008 15:25:13 +0100
Subject: [PATCH] Store every record information for the sixaxis controllers

Remove out-dated code to parse the HID input descriptor
Make sure that all the Bluetooth addresses used are upper-case
Add captured once SDP PNP record for the sixaxis controller
Store device id, profile, and trust information about the device
---
 input/sixpair.c |  137 +++++++-----------------------------------------------
 1 files changed, 18 insertions(+), 119 deletions(-)

diff --git a/input/sixpair.c b/input/sixpair.c
index 92aa5f7..3a2bd32 100644
--- a/input/sixpair.c
+++ b/input/sixpair.c
@@ -8,7 +8,7 @@
 
 #include <sdp.h>
 #include <bluetooth/bluetooth.h>
-#include <bluetooth/hidp.h>
+#include <bluetooth/sdp_lib.h>
 #include <glib.h>
 #include <libusb.h>
 
@@ -18,6 +18,8 @@
 #define VENDOR 0x054c
 #define PRODUCT 0x0268
 
+#define PS3_PNP_RECORD "3601920900000A000100000900013503191124090004350D35061901000900113503190011090006350909656E09006A0901000900093508350619112409010009000D350F350D350619010009001335031900110901002513576972656C65737320436F6E74726F6C6C65720901012513576972656C65737320436F6E74726F6C6C6572090102251B536F6E7920436F6D707574657220456E7465727461696E6D656E740902000901000902010901000902020800090203082109020428010902052801090206359A35980822259405010904A101A102850175089501150026FF00810375019513150025013500450105091901291381027501950D0600FF8103150026FF0005010901A10075089504350046FF0009300931093209358102C0050175089527090181027508953009019102750895300901B102C0A1028502750895300901B102C0A10285EE750895300901B102C0A10285EF750895300901B102C0C0090207350835060904090901000902082800090209280109020A280109020B09010009020C093E8009020D280009020E2800"
+
 gboolean option_get_master = TRUE;
 char *option_master= NULL;
 gboolean option_store_info = TRUE;
@@ -49,7 +51,7 @@ show_master (libusb_device_handle *devh, int itfnum)
 		g_warning ("Getting the master Bluetooth address failed");
 		return FALSE;
 	}
-	g_print ("Current Bluetooth master: %02x:%02x:%02x:%02x:%02x:%02x\n",
+	g_print ("Current Bluetooth master: %02X:%02X:%02X:%02X:%02X:%02X\n",
 		 msg[2], msg[3], msg[4], msg[5], msg[6], msg[7]);
 
 	return TRUE;
@@ -73,7 +75,7 @@ get_bdaddr (libusb_device_handle *devh, int itfnum)
 		return NULL;
 	}
 
-	address = g_strdup_printf ("%02x:%02x:%02x:%02x:%02x:%02x",
+	address = g_strdup_printf ("%02X:%02X:%02X:%02X:%02X:%02X",
 				   msg[4], msg[5], msg[6], msg[7], msg[8], msg[9]);
 
 	if (option_quiet == FALSE) {
@@ -90,7 +92,7 @@ set_master_bdaddr (libusb_device_handle *devh, int itfnum, char *host)
 	int mac[6];
 	int res;
 
-	if (sscanf(host, "%x:%x:%x:%x:%x:%x",
+	if (sscanf(host, "%X:%X:%X:%X:%X:%X",
 		   &mac[0],&mac[1],&mac[2],&mac[3],&mac[4],&mac[5]) != 6) {
 		return FALSE;
 	}
@@ -132,100 +134,13 @@ get_host_bdaddr (void)
 		//FIXME
 		return NULL;
 	}
-	if (fscanf(f, "%*s\n%*s %x:%x:%x:%x:%x:%x",
+	if (fscanf(f, "%*s\n%*s %X:%X:%X:%X:%X:%X",
 		   &mac[0],&mac[1],&mac[2],&mac[3],&mac[4],&mac[5]) != 6) {
 		//FIXME
 		return NULL;
 	}
 
-	return g_strdup_printf ("%x:%x:%x:%x:%x:%x", mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
-}
-
-static int
-get_record_info (const struct libusb_interface_descriptor *alt, unsigned int *_len, unsigned int *_country, uint16_t *_version)
-{
-#if 0
-	unsigned char *buf;
-	unsigned int size, len, country;
-	uint16_t version;
-	int l;
-
-	len = 0;
-	country = 0;
-	version = 0;
-
-	if (!alt->extralen)
-		return 0;
-
-	size = alt->extralen;
-	buf = alt->extra;
-	while (size >= 2 * sizeof(u_int8_t)) {
-		if (buf[0] < 2 || buf[1] != USB_DT_HID)
-			continue;
-
-		//FIXME that should be "21"
-		//g_message ("country: %u", buf[4]);
-		//country = buf[4];
-		//country = 0x21;
-		country = 0;
-		version = (buf[3] << 8) + buf[2];
-
-		for (l = 0; l < buf[5]; l++) {
-			/* we are just interested in report descriptors*/
-			if (buf[6+3*l] != USB_DT_REPORT)
-				continue;
-			len = buf[7+3*l] | (buf[8+3*l] << 8);
-		}
-		size -= buf[0];
-		buf += buf[0];
-	}
-
-	if (len == 0)
-		return -1;
-	*_len = len;
-	*_country = country;
-	*_version = version;
-#endif
-	return 0;
-}
-
-static void
-fill_req_from_usb (libusb_device *dev, struct hidp_connadd_req *req, void *data, unsigned int len, unsigned int country, uint16_t version)
-{
-#if 0
-	req->vendor = dev->descriptor.idVendor;
-	req->product = dev->descriptor.idProduct;
-	req->version = version;
-	/* req->subclass already set */
-	req->country = country;
-	/* Default value */
-	req->parser = 0x0100;
-	/* What are we expecting here? No idea, but we don't seem to need it */
-	req->flags = 0;
-
-	req->rd_size = len;
-	req->rd_data = data;
-#endif
-}
-
-static void
-store_info (const char *host, const char *device, struct hidp_connadd_req *req)
-{
-	bdaddr_t dest, src;
-
-	if (str2ba (host, &src) < 0) {
-		//FIXME
-		return;
-	}
-	if (str2ba (device, &dest) < 0) {
-		//FIXME
-		return;
-	}
-
-#if 0
-	if (store_device_info (&src, &dest, req) < 0)
-#endif
-		g_message ("store_device_info failed");
+	return g_strdup_printf ("%02X:%02X:%02X:%02X:%02X:%02X", mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
 }
 
 static int
@@ -274,45 +189,29 @@ handle_device (libusb_device *dev, struct libusb_config_descriptor *cfg, int itf
 	}
 
 	if (option_store_info != FALSE) {
-		unsigned char data[8192];
-		struct hidp_connadd_req req;
-		unsigned int len, country;
-		uint16_t version;
+		sdp_record_t *rec;
 		char *device;
+		bdaddr_t dst, src;
 
 		device = get_bdaddr (devh, itfnum);
 		if (device == NULL) {
 			retval = -1;
 			goto bail;
 		}
-#if 0
-		if (get_record_info (alt, &len, &country, &version) < 0) {
-			g_warning ("Can't get record info");
-			retval = -1;
-			goto bail;
-		}
 
-		if (libusb_control_transfer(devh,
-						 LIBUSB_ENDPOINT_IN | LIBUSB_REQUEST_TYPE_CLASS | LIBUSB_RECIPIENT_INTERFACE,
-						 LIBUSB_REQUEST_GET_DESCRIPTOR,
-						 (LIBUSB_DT_REPORT << 8),
-						 itfnum, (void *) &data, len, 5000) < 0) {
-			g_warning ("Can't get report descriptor (length: %d, interface: %d)", len, itfnum);
-			retval = -1;
-			goto bail;
-		}
-
-		req.subclass = alt->bInterfaceSubClass;
-		fill_req_from_usb (dev, &req, data, len, country, version);
+		rec = record_from_string (PS3_PNP_RECORD);
+		store_record(option_master, device, rec);
+		write_trust(option_master, device, "[all]", TRUE);
+		store_device_id(option_master, device, 0xffff, 0x054c, 0x0268, 0);
+		str2ba(option_master, &src);
+		str2ba(device, &dst);
+		write_device_profiles(&src, &dst, "");
+		sdp_record_free(rec);
 
-		store_info (option_master, device, &req);
-#endif
 		if (set_master_bdaddr (devh, itfnum, option_master) == FALSE) {
 			retval = -1;
 			goto bail;
 		}
-
-		//FIXME finally, set device as trusted
 	}
 
 bail:
-- 
1.5.5.2


--=-SALUMSSndBB+So5TnjZF
Content-Disposition: attachment; filename="0009-Save-name-for-the-sixaxis-controller.patch"
Content-Type: text/x-patch; name="0009-Save-name-for-the-sixaxis-controller.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 48e9d01b184c9ff5a353dd6502847fb249d278c1 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Wed, 15 Oct 2008 15:28:42 +0100
Subject: [PATCH] Save name for the sixaxis controller

The name won't be there until we connect otherwise
---
 input/sixpair.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/input/sixpair.c b/input/sixpair.c
index 3a2bd32..5c58b9b 100644
--- a/input/sixpair.c
+++ b/input/sixpair.c
@@ -206,6 +206,7 @@ handle_device (libusb_device *dev, struct libusb_config_descriptor *cfg, int itf
 		str2ba(option_master, &src);
 		str2ba(device, &dst);
 		write_device_profiles(&src, &dst, "");
+		write_device_name(&src, &dst, "PLAYSTATION(R)3 Controller");
 		sdp_record_free(rec);
 
 		if (set_master_bdaddr (devh, itfnum, option_master) == FALSE) {
-- 
1.5.5.2


--=-SALUMSSndBB+So5TnjZF
Content-Disposition: attachment; filename="0010-Detect-libusb-1.0-and-enable-it-by-default.patch"
Content-Type: text/x-patch; name="0010-Detect-libusb-1.0-and-enable-it-by-default.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From c9b2d0599a6a1d30f96a0064a524a7f904faf1a0 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Wed, 15 Oct 2008 15:47:28 +0100
Subject: [PATCH] Detect libusb 1.0 and enable it by default

Necessary for sixpair to compile
---
 acinclude.m4        |   15 +++++++++++++++
 bootstrap-configure |    1 +
 configure.ac        |    1 +
 3 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/acinclude.m4 b/acinclude.m4
index 45dd909..0a8fdbb 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -156,6 +156,12 @@ AC_DEFUN([AC_PATH_USB], [
 			[Define to 1 if you need the usb_interrupt_read() function.]))
 ])
 
+AC_DEFUN([AC_PATH_USB1], [
+	PKG_CHECK_MODULES(USB1, libusb-1.0, usb1_found=yes, usb1_found=no)
+	AC_SUBST(USB_CFLAGS)
+	AC_SUBST(USB_LIBS)
+])
+
 AC_DEFUN([AC_PATH_NETLINK], [
 	PKG_CHECK_MODULES(NETLINK, libnl-1, netlink_found=yes, netlink_found=no)
 	AC_SUBST(NETLINK_CFLAGS)
@@ -238,6 +244,10 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		usb_enable=${enableval}
 	])
 
+	AC_ARG_ENABLE(usb1, AC_HELP_STRING([--enable-usb1], [enable libusb 1.0 support]), [
+		usb1_enable=${enableval}
+	])
+
 	AC_ARG_ENABLE(netlink, AC_HELP_STRING([--enable-netlink], [enable NETLINK support]), [
 		netlink_enable=${enableval}
 	])
@@ -321,6 +331,10 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		AC_DEFINE(HAVE_LIBUSB, 1, [Define to 1 if you have USB library.])
 	fi
 
+	if (test "${usb1_enable}" = "yes" && test "${usb1_found}" = "yes"); then
+		AC_DEFINE(HAVE_LIBUSB1, 1, [Define to 1 if you have libusb-1.0.])
+	fi
+
 	AC_SUBST([BLUEZ_CFLAGS], ['-I$(top_builddir)/include'])
 	AC_SUBST([BLUEZ_LIBS], ['$(top_builddir)/lib/libbluetooth.la'])
 
@@ -333,6 +347,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(SNDFILE, test "${sndfile_enable}" = "yes" && test "${sndfile_found}" = "yes")
 	AM_CONDITIONAL(NETLINK, test "${netlink_enable}" = "yes" && test "${netlink_found}" = "yes")
 	AM_CONDITIONAL(USB, test "${usb_enable}" = "yes" && test "${usb_found}" = "yes")
+	AM_CONDITIONAL(USB1, test "${usb1_enable}" = "yes" && test "${usb1_found}" = "yes")
 	AM_CONDITIONAL(SBC, test "${alsa_enable}" = "yes" || test "${gstreamer_enable}" = "yes")
 	AM_CONDITIONAL(ALSA, test "${alsa_enable}" = "yes" && test "${alsa_found}" = "yes")
 	AM_CONDITIONAL(GSTREAMER, test "${gstreamer_enable}" = "yes" && test "${gstreamer_found}" = "yes")
diff --git a/bootstrap-configure b/bootstrap-configure
index 7b07fe1..3b22dd5 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -27,6 +27,7 @@ fi
 		--enable-dund \
 		--enable-test \
 		--enable-cups \
+		--enable-usb1 \
 		--disable-manpages \
 		--disable-configfiles \
 		--disable-initscripts \
diff --git a/configure.ac b/configure.ac
index 33b4583..f603223 100644
--- a/configure.ac
+++ b/configure.ac
@@ -32,6 +32,7 @@ AC_PATH_GMODULE
 AC_PATH_ALSA
 AC_PATH_GSTREAMER
 AC_PATH_USB
+AC_PATH_USB1
 AC_PATH_NETLINK
 AC_PATH_SNDFILE
 
-- 
1.5.5.2


--=-SALUMSSndBB+So5TnjZF
Content-Disposition: attachment; filename="0011-Separate-storage-functions-into-a-library.patch"
Content-Type: text/x-patch; name="0011-Separate-storage-functions-into-a-library.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 8c2c57718e32d4da5c49c8df38f5a48a1c105375 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Wed, 15 Oct 2008 15:48:51 +0100
Subject: [PATCH] Separate storage functions into a library

The separate storage functions will be used by sixpair
---
 src/Makefile.am |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/src/Makefile.am b/src/Makefile.am
index 2a353a4..d39d73d 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -13,15 +13,19 @@ statedir = $(localstatedir)/lib/bluetooth
 state_DATA =
 endif
 
+noinst_LIBRARIES = libbtd-storage.a
+libbtd_storage_a_SOURCES = storage.h storage.c
+
 sbin_PROGRAMS = bluetoothd
 
 bluetoothd_SOURCES = main.c security.c hcid.h sdpd.h \
 	sdpd-server.c sdpd-request.c sdpd-service.c sdpd-database.c \
-	plugin.h plugin.c storage.h storage.c agent.h agent.c \
+	plugin.h plugin.c agent.h agent.c \
 	error.h error.c manager.h manager.c adapter.h adapter.c \
 	device.h device.c dbus-common.c dbus-common.h dbus-hci.h dbus-hci.c
 
 bluetoothd_LDADD = $(top_builddir)/common/libhelper.a \
+	$(builddir)/libbtd-storage.a \
 	@GDBUS_LIBS@ @GMODULE_LIBS@ @GLIB_LIBS@ @DBUS_LIBS@ @BLUEZ_LIBS@
 
 if MAINTAINER_MODE
-- 
1.5.5.2


--=-SALUMSSndBB+So5TnjZF
Content-Disposition: attachment; filename="0012-Build-sixpair-through-the-build-system.patch"
Content-Type: text/x-patch; name="0012-Build-sixpair-through-the-build-system.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 444bfee09d378ac4e5fdd8c05b8bb01b8b57f418 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Wed, 15 Oct 2008 15:49:58 +0100
Subject: [PATCH] Build sixpair through the build system

Using the libusb 1.0 libs as well as the separate storage
library, compile sixpair without hacks
---
 input/Makefile.am |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/input/Makefile.am b/input/Makefile.am
index 1b3ab5d..59cf481 100644
--- a/input/Makefile.am
+++ b/input/Makefile.am
@@ -8,14 +8,23 @@ input_la_SOURCES = main.c manager.h manager.c \
 		server.h server.c device.h device.c \
 		fakehid.c fakehid.h
 
-LDADD = $(top_builddir)/common/libhelper.a \
+input_la_LIBADD = $(top_builddir)/common/libhelper.a \
 		@GDBUS_LIBS@ @GLIB_LIBS@ @DBUS_LIBS@ @BLUEZ_LIBS@
+
+if USB1
+bin_PROGRAMS = sixpair
+sixpair_SOURCES = sixpair.c
+sixpair_LDADD = $(top_builddir)/src/libbtd-storage.a \
+		$(top_builddir)/common/libhelper.a \
+		@USB1_LIBS@ @GLIB_LIBS@ @BLUEZ_LIBS@
+endif
+
 endif
 
 AM_LDFLAGS = -module -avoid-version -no-undefined \
 			-export-symbols-regex bluetooth_plugin_desc
 
-AM_CFLAGS = @BLUEZ_CFLAGS@ @DBUS_CFLAGS@ @GLIB_CFLAGS@ @GDBUS_CFLAGS@
+AM_CFLAGS = @BLUEZ_CFLAGS@ @DBUS_CFLAGS@ @GLIB_CFLAGS@ @GDBUS_CFLAGS@ @USB1_CFLAGS@
 
 INCLUDES = -I$(top_srcdir)/common -I$(top_srcdir)/src
 
-- 
1.5.5.2


--=-SALUMSSndBB+So5TnjZF
Content-Disposition: attachment; filename="0013-Remove-compilation-instructions-from-sixpair.patch"
Content-Type: text/x-patch; name="0013-Remove-compilation-instructions-from-sixpair.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From b2c8fe5f5b1141284dce71a0345712cf16c1f665 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Wed, 15 Oct 2008 15:50:29 +0100
Subject: [PATCH] Remove compilation instructions from sixpair

Not needed anymore
---
 input/sixpair.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/input/sixpair.c b/input/sixpair.c
index 5c58b9b..41d7791 100644
--- a/input/sixpair.c
+++ b/input/sixpair.c
@@ -1,7 +1,3 @@
-/* To compile
- * gcc -g -Wall -I../src -I../lib/ -I../include -DSTORAGEDIR=\"/var/lib/bluetooth\" -o sixpair sixpair.c ../src/storage.c ../common/libhelper.a -I../common `pkg-config --libs --cflags glib-2.0 libusb-1.0` -lbluetooth
- */
-
 #include <unistd.h>
 #include <stdio.h>
 #include <inttypes.h>
-- 
1.5.5.2


--=-SALUMSSndBB+So5TnjZF--

