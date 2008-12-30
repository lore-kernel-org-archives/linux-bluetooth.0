Return-Path: <cyrus@holtmann.org>
Date: Mon, 29 Dec 2008 22:26:56 -0800
From: Khem Raj <raj.khem@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [patch] hid2hci check usb_init return value
Message-ID: <20081230062656.GA31902@gmail.com>
References: <20081225231444.GA23751@gmail.com> <1230552751.15666.17.camel@californication>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
In-Reply-To: <1230552751.15666.17.camel@californication>
List-ID: <linux-bluetooth.vger.kernel.org>


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On (29/12/08 13:12), Marcel Holtmann wrote:
> Hi Khem,
> 
> > Working on a system which did not have a USB in it. I was getting a
> > segfault with hid2hci. The problem tracked down was usb_init () was 
> > failing and we did not check for it and carried on with execution. 
> > As a result the next call to libusb failed because we passed in NULL for
> > ctx because during usb_init () this should have been malloc'ed if all
> > have gone correctly but in case of error usb_init () free's up the
> > allocated memory and hence the segfault. 
> > 
> > We should check for return value of usb_init () call and exit
> > immediately if it fails. Tested on 4.24 release. 
> 
> the problem is that usb_init() doesn't return any errors on the versions
> that I have here:
> 
> ii  libusb-0.1-4   2:0.1.12-12    userspace USB programming library
> ii  libusb-dev     2:0.1.12-12    userspace USB programming library
> 
> Applying your patch would break complication on multiple platforms.
What you have is libusb-0.1 which has older API I suppose. There is 
libusb-compat which can be used as a wrapper over libusb1 to give
libusb0 like interfaces. 

Actually I was using libusb-1.0.0 API as mentioned here
http://libusb.sourceforge.net/api-1.0/group__lib.html
that also means that the patch I attached should have been using
libusb_init() instead. 

Here is updated patch

Thanks

-Khem


--r5Pyd7+fXNt84Ff3
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
+++ bluez-4.24/tools/hid2hci.c	2008-12-29 22:06:04.000000000 -0800
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
+	ret = libusb_init();
+	if (ret < 0)
+		return ret;
 
 	num = find_devices(mode, dev, sizeof(dev) / sizeof(dev[0]));
 	if (num <= 0) {

--r5Pyd7+fXNt84Ff3--
