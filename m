Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Dec 2008 15:14:44 -0800
From: Khem Raj <raj.khem@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: raj.khem@gmail.com
Subject: [patch] hid2hci check usb_init return value
Message-ID: <20081225231444.GA23751@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

Working on a system which did not have a USB in it. I was getting a
segfault with hid2hci. The problem tracked down was usb_init () was 
failing and we did not check for it and carried on with execution. 
As a result the next call to libusb failed because we passed in NULL for
ctx because during usb_init () this should have been malloc'ed if all
have gone correctly but in case of error usb_init () free's up the
allocated memory and hence the segfault. 

We should check for return value of usb_init () call and exit
immediately if it fails. Tested on 4.24 release. 

OK ?

Thanks

-Khem



--EVF5PPMfhYS0aIcm
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="hid2hci_usb_init.patch"

# Signed-off-by: Khem Raj <raj.khem@gmail.com>
#
# Use the new usb1 API for usb_init() and check for fails from 
# usb_init (). Currently we see a crash on a system which does
# not have USB because usb_init() fails and it cleans up all initialized
# data (e.g. ctx) which is used in subsequent calls to libusb
# We return immediately if usb_init() fails for some reason.

Index: bluez-4.24/tools/hid2hci.c
===================================================================
--- bluez-4.24.orig/tools/hid2hci.c	2008-10-25 23:40:34.000000000 -0700
+++ bluez-4.24/tools/hid2hci.c	2008-12-25 01:24:12.000000000 -0800
@@ -337,7 +337,7 @@
 int main(int argc, char *argv[])
 {
 	struct device_info dev[16];
-	int i, opt, num, quiet = 0, mode = HCI;
+	int i, ret, opt, num, quiet = 0, mode = HCI;
 
 	while ((opt = getopt_long(argc, argv, "+01qh", main_options, NULL)) != -1) {
 		switch (opt) {
@@ -361,8 +361,9 @@
 	argc -= optind;
 	argv += optind;
 	optind = 0;
-
-	usb_init();
+	ret = usb_init();
+	if (ret < 0)
+		return ret;
 
 	num = find_devices(mode, dev, sizeof(dev) / sizeof(dev[0]));
 	if (num <= 0) {

--EVF5PPMfhYS0aIcm--
