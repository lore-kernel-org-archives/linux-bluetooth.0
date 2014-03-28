Return-Path: <cyrus@holtmann.org>
Message-ID: <1396034462.3390.5.camel@g-VPCF13Z1E>
Subject: Re: PATCH hid2hci for CSR 8510 A10
From: Gordon <kernel@gkr.i24.cc>
To: linux-bluetooth@vger.kernel.org
Date: Fri, 28 Mar 2014 20:21:02 +0100
In-Reply-To: <1388440779.28025.21.camel@g-VPCF13Z1E>
References: <1388440779.28025.21.camel@g-VPCF13Z1E>
Content-Type: multipart/mixed; boundary="=-holNY3VmkoKP2Z5HHU7e"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-holNY3VmkoKP2Z5HHU7e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi,

some time ago I sent a patch attached to following mail.

On Mo, 2013-12-30 at 22:59 +0100, Gordon wrote:
> Hi,
> 
> ich had a problem with the Sitecom CNT-524 as described by someone else
> here:
> http://blog.ruecker.fi/2013/10/06/adventures-in-bluetooth-4-0-part-i/
> 
> so i tried to fix that by introducing --mode csr2 for hid2hci
> 
> I neither know how to switch back to hid nor how to detect the EALREADY
> state, otherwise the patch is very small.
> 
> I works on my machine in ubuntu 13.04 with bluez 4.101-0ubuntu8b1 and
> said sitecom usb dongle. the patch is against bluez commit
> fd00064e0bb2c81e53e9d0b7d22ce919b41dbe60
> 
> Could someone please review.

I didn't get a reply yet. Since it has been my first mail to this list I
wonder whether there is anything wrong with this request, or just nobody
is interested ?


Cheers,

Gordon


--=-holNY3VmkoKP2Z5HHU7e
Content-Disposition: attachment; filename="bluez_hid2hci.patch"
Content-Type: text/x-patch; name="bluez_hid2hci.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff --git a/tools/hid2hci.1 b/tools/hid2hci.1
index 8c5d520..c6876a3 100644
--- a/tools/hid2hci.1
+++ b/tools/hid2hci.1
@@ -32,7 +32,7 @@ mode and back.
 .B --mode= [hid, hci]
 Sets the mode to switch the device into
 .TP
-.B --method= [csr, logitech-hid, dell]
+.B --method= [csr, csr2, logitech-hid, dell]
 Which vendor method to use for switching the device.
 .TP
 .B --devpath=
diff --git a/tools/hid2hci.c b/tools/hid2hci.c
index 95b4abf..514accc 100644
--- a/tools/hid2hci.c
+++ b/tools/hid2hci.c
@@ -118,6 +118,41 @@ static int usb_switch_csr(int fd, enum mode mode)
 	return err;
 }
 
+static int usb_switch_csr2(int fd, enum mode mode)
+{
+	int err = 0;
+	struct usbfs_disconnect disconnect;
+	char report[] = { 0x1 , 0x5 , 0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 0x0 };
+	switch (mode) {
+	case HCI:
+		//send report as is
+		disconnect.interface = 0;
+		disconnect.flags = USBFS_DISCONNECT_EXCEPT_DRIVER;
+		strcpy(disconnect.driver, "usbfs");
+
+		if (ioctl(fd, USBFS_IOCTL_DISCONNECT, &disconnect) < 0) {
+			fprintf(stderr, "Can't claim interface: %s (%d)\n",
+						strerror(errno), errno);
+			return -1;
+		}
+
+		err = control_message(fd, USB_ENDPOINT_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
+					USB_REQ_SET_CONFIGURATION, //Set_Report Request
+					0x01 | (0x03 << 8), //report id: 0x01, report type: feature (0x03)
+					0, //interface
+					report, sizeof(report), 5000);
+		//unable to detect EALREADY
+		break;
+	case HID:
+		// currently unknown what to do here
+		fprintf(stderr, "csr2: Switching to hid mode is not implemented\n");
+		return -1;
+		break;
+	}
+
+	return err;
+}
+
 static int hid_logitech_send_report(int fd, const char *buf, size_t size)
 {
 	struct hiddev_report_info rinfo;
@@ -257,7 +292,7 @@ static void usage(const char *error)
 	printf("Usage: hid2hci [options]\n"
 		"  --mode=       mode to switch to [hid|hci] (default hci)\n"
 		"  --devpath=    sys device path\n"
-		"  --method=     method to use to switch [csr|logitech-hid|dell]\n"
+		"  --method=     method to use to switch [csr|csr2|logitech-hid|dell]\n"
 		"  --help\n\n");
 }
 
@@ -310,6 +345,9 @@ int main(int argc, char *argv[])
 			if (!strcmp(optarg, "csr")) {
 				method = METHOD_CSR;
 				usb_switch = usb_switch_csr;
+			} else if (!strcmp(optarg, "csr2")) {
+				method = METHOD_CSR;
+				usb_switch = usb_switch_csr2;
 			} else if (!strcmp(optarg, "logitech-hid")) {
 				method = METHOD_LOGITECH_HID;
 			} else if (!strcmp(optarg, "dell")) {

--=-holNY3VmkoKP2Z5HHU7e--

