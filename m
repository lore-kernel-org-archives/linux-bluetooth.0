Return-Path: <lcapitulino@conectiva.com.br>
Message-ID: <42B82F8E.1050506@conectiva.com.br>
Date: Tue, 21 Jun 2005 12:17:34 -0300
From: Luiz Fernando Capitulino <lcapitulino@conectiva.com.br>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net, marcel@holtmann.org
Subject: [PATCH] - Some errno usage fixes (bluez-libs).
Content-Type: multipart/mixed;
 boundary="------------030303090009090908020405"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------030303090009090908020405
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi there!

The bluez-libs functions hci_for_each_dev(), hci_devinfo() and
hci_inquiry() don't save the 'errno' value when an error occurs.
This causes the value of 'errno' to be overwrinting on some kind
of errors.

The attached patch fixes it. Note that was necessary to change
hci_inquiry() a bit, and I've added the missing error code to 'errno'
when a device is not found by hci_for_each_dev(), it fixes things like
that:

~/ hcitool scan
Device is not available: Success
~/ 

src/hci.c |   70 ++++++++++++++++++++++++++++++++++++--------------------------
1 files changed, 41 insertions(+), 29 deletions(-)

Thank you,

-- 
Luiz Fernando N. Capitulino

--------------030303090009090908020405
Content-Type: text/x-patch;
 name="bluez_libs_errno_usage.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bluez_libs_errno_usage.patch"

 src/hci.c |   70 ++++++++++++++++++++++++++++++++++++--------------------------
 1 files changed, 41 insertions(+), 29 deletions(-)


diff -X /home/lcapitulino/kernels/2.6/dontdiff -Nparu a/src/hci.c a~/src/hci.c
--- a/src/hci.c	2005-06-16 10:53:09.000000000 -0300
+++ a~/src/hci.c	2005-06-21 11:32:53.000000000 -0300
@@ -463,17 +463,15 @@ int hci_for_each_dev(int flag, int (*fun
 	struct hci_dev_list_req *dl;
 	struct hci_dev_req *dr;
 	int dev_id = -1;
-	int i, sk;
+	int err, i, sk;
 
 	sk = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
 	if (sk < 0)
 		return -1;
 
 	dl = malloc(HCI_MAX_DEV * sizeof(*dr) + sizeof(*dl));
-	if (!dl) {
-		close(sk);
-		return -1;
-	}
+	if (!dl)
+		goto done;
 
 	dl->dev_num = HCI_MAX_DEV;
 	dr = dl->dev_req;
@@ -489,9 +487,15 @@ int hci_for_each_dev(int flag, int (*fun
 			}
 	}
 
+	if (dev_id < 0)
+		errno = ENODEV;
+
 done:
+	err = errno;
 	close(sk);
-	free(dl);
+	if (dl)
+		free(dl);
+	errno = err;
 	return dev_id;
 }
 
@@ -545,17 +549,20 @@ int hci_devid(const char *str)
 
 int hci_devinfo(int dev_id, struct hci_dev_info *di)
 {
-	int s, err;
+	int s, err, ret;
 
 	s = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
 	if (s < 0)
 		return s;
 
 	di->dev_id = dev_id;
-	err = ioctl(s, HCIGETDEVINFO, (void *) di);
+	ret = ioctl(s, HCIGETDEVINFO, (void *) di);
+
+	err = errno;
 	close(s);
+	errno = err;
 
-	return err;
+	return ret;
 }
 
 int hci_devba(int dev_id, bdaddr_t *bdaddr)
@@ -579,7 +586,8 @@ int hci_inquiry(int dev_id, int len, int
 	struct hci_inquiry_req *ir;
 	uint8_t num_rsp = nrsp;
 	void *buf;
-	int s, err;
+	int ret = -1;
+	int size, s, err;
 
 	if (nrsp <= 0) {
 		num_rsp = 0;
@@ -596,10 +604,8 @@ int hci_inquiry(int dev_id, int len, int
 		return -1;
 
 	buf = malloc(sizeof(*ir) + (sizeof(inquiry_info) * (nrsp)));
-	if (!buf) {
-		close(s);
-		return -1;
-	}
+	if (!buf)
+		goto out;
 
 	ir = buf;
 	ir->dev_id  = dev_id;
@@ -615,23 +621,29 @@ int hci_inquiry(int dev_id, int len, int
 		ir->lap[2] = 0x9e;
 	}
 
-	err = ioctl(s, HCIINQUIRY, (unsigned long) buf);
-	close(s);
-
-	if (!err) {
-		int size = sizeof(inquiry_info) * ir->num_rsp;
+	ret = ioctl(s, HCIINQUIRY, (unsigned long) buf);
+	if (ret < 0)
+		goto out;
+
+	size = sizeof(inquiry_info) * ir->num_rsp;
+
+	if (!*ii)
+		*ii = (void *) malloc(size);
+
+	if (*ii) {
+		memcpy((void *) *ii, buf + sizeof(*ir), size);
+		ret = ir->num_rsp;
+	} else
+		ret = -1;
 
-		if (!*ii) 
-			*ii = (void *) malloc(size);
+out:
+	err = errno;
+	close(s);
+	if (buf)
+		free(buf);
+	errno = err;
 
-		if (*ii) {
-			memcpy((void *) *ii, buf + sizeof(*ir), size);
-			err = ir->num_rsp;
-		} else
-			err = -1;
-	}
-	free(buf);
-	return err;
+	return ret;
 }
 
 /* Open HCI device. 

--------------030303090009090908020405--
