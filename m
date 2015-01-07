Return-Path: <cyrus@holtmann.org>
From: kernel@gkr.i24.cc
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Gordon Kramer <kernel@gkr.i24.cc>
Subject: [PATCH v5 2/2] use const uint_8* for pointer in control_message
Date: Wed,  7 Jan 2015 23:04:00 +0100
Message-Id: <1420668240-5100-3-git-send-email-kernel@gkr.i24.cc>
In-Reply-To: <1420668240-5100-1-git-send-email-kernel@gkr.i24.cc>
References: <20150107203159.GA4571@t440s.P-661HNU-F1>
 <1420668240-5100-1-git-send-email-kernel@gkr.i24.cc>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gordon Kramer <kernel@gkr.i24.cc>

change control_message signature
requires const void* usbfs_ctrltransfer for ioctl
use uint8 * in usb_switch_dell
---
 tools/hid2hci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/hid2hci.c b/tools/hid2hci.c
index 3eedf4e..033fcfd 100644
--- a/tools/hid2hci.c
+++ b/tools/hid2hci.c
@@ -59,7 +59,7 @@ struct usbfs_ctrltransfer {
 	uint16_t wIndex;
 	uint16_t wLength;
 	uint32_t timeout;	/* in milliseconds */
-	void *data;		/* pointer to data */
+	const void *data;	/* pointer to data */
 };
 
 
@@ -77,7 +77,7 @@ struct usbfs_disconnect{
 
 static int control_message(int fd, int requesttype, int request,
 					int value, int index,
-					char *bytes, int size, int timeout)
+					const uint8_t *bytes, int size, int timeout)
 {
 	struct usbfs_ctrltransfer transfer;
 
@@ -123,7 +123,7 @@ static int usb_switch_csr2(int fd, enum mode mode)
 {
 	int err = 0;
 	struct usbfs_disconnect disconnect;
-	char report[] = {
+	const uint8_t report[] = {
 		0x01, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
 	};
 
@@ -226,7 +226,7 @@ out:
 
 static int usb_switch_dell(int fd, enum mode mode)
 {
-	char report[] = { 0x7f, 0x00, 0x00, 0x00 };
+	uint8_t report[] = { 0x7f, 0x00, 0x00, 0x00 };
 	struct usbfs_disconnect disconnect;
 	int err;
 
-- 
1.9.1

