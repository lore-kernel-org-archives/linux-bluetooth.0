Return-Path: <cyrus@holtmann.org>
Subject: [PATCHes] Patches for OpenObex
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-xHntgueBRRNPrLHFv8Sp"
Date: Fri, 19 Feb 2010 12:10:33 +0000
Message-ID: <1266581433.678.6028.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-xHntgueBRRNPrLHFv8Sp
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Heya,

2 small patches for openobex.

The first patch fixes libusb1 compilation on my machine.

For the second patch, when libusb1 is used, we can set self->fd to be a
monitoring file descriptor for incoming data.

With that patch, I could make osso-gwobex work with USB connections.

There's still some bugs to take care of, but I believe this patch to be
correct. Are there any places in openobex where the self->fd will be
directly when connected via USB? If so, those would need to be fixed as
well.

Cheers

--=-xHntgueBRRNPrLHFv8Sp
Content-Disposition: attachment; filename="0001-Fix-libusb1-detection.patch"
Content-Type: text/x-patch; name="0001-Fix-libusb1-detection.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 80ac78ca813d057b2c506f936e1b8b8d3c939357 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Fri, 19 Feb 2010 12:03:01 +0000
Subject: [PATCH 1/2] Fix libusb1 detection

There's no need to check for the presence of a .pc file in
/usr/lib/, pkg-config will already do that for you, and it would
fail on machines where /usr/lib64 is used, or when libusb1 is
installed in another prefix.
---
 acinclude.m4 |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/acinclude.m4 b/acinclude.m4
index 81fa9da..d813b71 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -191,7 +191,6 @@ AC_DEFUN([AC_PATH_USB], [
 AC_DEFUN([AC_PATH_USB1], [
 	usb1_lib_found=no
 	PKG_CHECK_MODULES(USB1, libusb-1.0, usb1_lib_found=yes, usb1_lib_found=no)
-	AC_CHECK_FILE(${prefix}/lib/pkgconfig/libusb-1.0.pc, REQUIRES="libusb1")
 	AC_SUBST(USB1_CFLAGS)
 	AC_SUBST(USB1_LIBS)
 
-- 
1.6.6.1


--=-xHntgueBRRNPrLHFv8Sp
Content-Disposition: attachment; filename="0002-Export-the-libusb1-read-file-descriptor.patch"
Content-Type: text/x-patch; name="0002-Export-the-libusb1-read-file-descriptor.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 55979f925051f794337a59a8e76727d03a215c62 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Fri, 19 Feb 2010 12:04:43 +0000
Subject: [PATCH 2/2] Export the libusb1 read file descriptor

When using libusb1, we can export the file descriptor that
corresponds to reading from the device, so it can be used to
setup polling sources, and timeout based operations.

This would be used by osso-gwobex to monitor incoming data, for
USB support.
---
 lib/usb1obex.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/lib/usb1obex.c b/lib/usb1obex.c
index dfa1685..6a80fbb 100644
--- a/lib/usb1obex.c
+++ b/lib/usb1obex.c
@@ -30,6 +30,7 @@
 #include <stdio.h>		/* perror */
 #include <errno.h>		/* errno and EADDRNOTAVAIL */
 #include <stdlib.h>
+#include <poll.h>		/* POLLOUT */
 
 #include <libusb.h>
 
@@ -339,6 +340,35 @@ void usbobex_free_interfaces(int num, obex_interface_t *intf)
 }
 
 /*
+ * Function usbobex_get_fd ()
+ *
+ *    Get the "poll out" file descriptor for the USB device,
+ *    used to check for events in an async way
+ *
+ */
+static int usbobex_get_fd(void)
+{
+	const struct libusb_pollfd **usbfds;
+	const struct libusb_pollfd *usbfd;
+	int i = 0;
+
+	DEBUG(4, "Getting the USB file descriptor");
+
+	usbfds = libusb_get_pollfds(libusb_ctx);
+	if (usbfds == NULL) {
+		DEBUG(4, "Could not get USB file descriptors");
+		return INVALID_SOCKET;
+	}
+
+	while ((usbfd = usbfds[i++]) != NULL) {
+		if (usbfd->events & POLLOUT)
+			return usbfd->fd;
+	}
+
+	return INVALID_SOCKET;
+}
+
+/*
  * Function usbobex_connect_request (self)
  *
  *    Open the USB connection
@@ -379,6 +409,7 @@ int usbobex_connect_request(obex_t *self)
 	}
 
 	self->trans.mtu = OBEX_MAXIMUM_MTU;
+	self->fd = usbobex_get_fd();
 	DEBUG(2, "transport mtu=%d\n", self->trans.mtu);
 	return 1;
 
-- 
1.6.6.1


--=-xHntgueBRRNPrLHFv8Sp--

