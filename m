Return-Path: <lcapitulino@conectiva.com.br>
Date: Thu, 22 Sep 2005 18:05:10 -0300
From: Luiz Fernando Capitulino <lcapitulino@conectiva.com.br>
To: marcel@holtmann.org
Cc: bluez-devel@lists.sourceforge.net
Subject: [PATCH 1/2] - Fixes errno overwrite in hci_for_each_dev().
Message-Id: <20050922180510.64bfeac9.lcapitulino@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>


If the call to ioctl() fails or 'dev_id < 0' is true (at the end of the
function), the calls to free() and close() will overwrite the error code in
errno.

 src/hci.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)


diff -X /home/lcapitulino/kernels/2.6/dontdiff -Nparu a/src/hci.c a~/src/hci.c
--- a/src/hci.c	2005-09-07 13:14:55.000000000 -0300
+++ a~/src/hci.c	2005-09-22 17:34:33.000000000 -0300
@@ -647,21 +647,25 @@ int hci_for_each_dev(int flag, int (*fun
 	struct hci_dev_list_req *dl;
 	struct hci_dev_req *dr;
 	int dev_id = -1;
-	int i, sk, err;
+	int i, sk, err = 0;
 
 	sk = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
 	if (sk < 0)
 		return -1;
 
 	dl = malloc(HCI_MAX_DEV * sizeof(*dr) + sizeof(*dl));
-	if (!dl)
+	if (!dl) {
+		err = errno;
 		goto done;
+	}
 
 	dl->dev_num = HCI_MAX_DEV;
 	dr = dl->dev_req;
 
-	if (ioctl(sk, HCIGETDEVLIST, (void *) dl) < 0)
+	if (ioctl(sk, HCIGETDEVLIST, (void *) dl) < 0) {
+		err = errno;
 		goto free;
+	}
 
 	for (i = 0; i < dl->dev_num; i++, dr++) {
 		if (hci_test_bit(flag, &dr->dev_opt))
@@ -672,13 +676,12 @@ int hci_for_each_dev(int flag, int (*fun
 	}
 
 	if (dev_id < 0)
-		errno = ENODEV;
+		err = ENODEV;
 
 free:
 	free(dl);
 
 done:
-	err = errno;
 	close(sk);
 	errno = err;
 
