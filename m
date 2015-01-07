Return-Path: <cyrus@holtmann.org>
From: kernel@gkr.i24.cc
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Cc: Gordon Kramer <kernel@gkr.i24.cc>
Subject: [PATCH v4] hid2hci add CSR 8510 A10 support
Date: Wed,  7 Jan 2015 11:10:17 +0100
Message-Id: <1420625417-9282-1-git-send-email-kernel@gkr.i24.cc>
In-Reply-To: <20150107091248.GA11467@t440s.lan>
References: <20150107091248.GA11467@t440s.lan>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gordon Kramer <kernel@gkr.i24.cc>

add a new method "csr2" to hid2hci that sends a control message
to the usb device which switches the Cambridge Silicon Radio 8510 A10
as used in Sitecom CNT-524

fixes: https://bugzilla.kernel.org/show_bug.cgi?id=69181
---

Notes:
    4th version, coding style corrections from Johan Hedberg and Anderson Lizardo, resend

 tools/hid2hci.1 |  2 +-
 tools/hid2hci.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 51 insertions(+), 2 deletions(-)

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
index a183bfa..49dcada 100644
--- a/tools/hid2hci.c
+++ b/tools/hid2hci.c
@@ -119,6 +119,52 @@ static int usb_switch_csr(int fd, enum mode mode)
 	return err;
 }
 
+static int usb_switch_csr2(int fd, enum mode mode)
+{
+	int err;
+	struct usbfs_disconnect disconnect;
+	uint8_t report[] = {
+		0x01, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+	};
+
+	switch (mode) {
+	case HCI:
+		/* send report as is */
+		disconnect.interface = 0;
+		disconnect.flags = USBFS_DISCONNECT_EXCEPT_DRIVER;
+		strcpy(disconnect.driver, "usbfs");
+
+		if (ioctl(fd, USBFS_IOCTL_DISCONNECT, &disconnect) < 0) {
+			fprintf(stderr, "Can't claim interface: %s (%d)\n",
+				strerror(errno), errno);
+			return -1;
+		}
+
+		/* Set_report request with 
+		 * report id: 0x01, report type: feature (0x03) 
+		 * on interface 0
+		 */
+		err = control_message(fd,
+				      USB_ENDPOINT_OUT | USB_TYPE_CLASS |
+				      USB_RECIP_INTERFACE,
+				      USB_REQ_SET_CONFIGURATION,
+				      0x01 | (0x03 << 8),
+				      0, report, sizeof(report), 5000);
+		/* unable to detect whether the previous state 
+		 * already was HCI (EALREADY)  
+		 */
+		break;
+	case HID:
+		/* currently unknown how to switch to HID */
+		fprintf(stderr,
+			"csr2: Switching to hid mode is not implemented\n");
+		err = -1;
+		break;
+	}
+
+	return err;
+}
+
 static int hid_logitech_send_report(int fd, const char *buf, size_t size)
 {
 	struct hiddev_report_info rinfo;
@@ -258,7 +304,7 @@ static void usage(const char *error)
 	printf("Usage: hid2hci [options]\n"
 		"  --mode=       mode to switch to [hid|hci] (default hci)\n"
 		"  --devpath=    sys device path\n"
-		"  --method=     method to use to switch [csr|logitech-hid|dell]\n"
+		"  --method=     method to use to switch [csr|csr2|logitech-hid|dell]\n"
 		"  --help\n\n");
 }
 
@@ -311,6 +357,9 @@ int main(int argc, char *argv[])
 			if (!strcmp(optarg, "csr")) {
 				method = METHOD_CSR;
 				usb_switch = usb_switch_csr;
+			} else if (!strcmp(optarg, "csr2")) {
+				method = METHOD_CSR;
+				usb_switch = usb_switch_csr2;
 			} else if (!strcmp(optarg, "logitech-hid")) {
 				method = METHOD_LOGITECH_HID;
 			} else if (!strcmp(optarg, "dell")) {
-- 
1.9.1

