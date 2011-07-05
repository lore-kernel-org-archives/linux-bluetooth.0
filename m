Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ] btio: Fix the return value of bt_io functions
Date: Tue,  5 Jul 2011 14:00:00 -0300
Message-Id: <1309885200-27393-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some bt_io methods were ignoring the value stored in errno when
reporting the error to the caller.
---
 btio/btio.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index e84f6d0..2cc9082 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -271,8 +271,9 @@ static int l2cap_bind(int sock, const bdaddr_t *src, uint16_t psm,
 		addr.l2_psm = htobs(psm);
 
 	if (bind(sock, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		int error = -errno;
 		ERROR_FAILED(err, "l2cap_bind", errno);
-		return -1;
+		return error;
 	}
 
 	return 0;
@@ -294,7 +295,7 @@ static int l2cap_connect(int sock, const bdaddr_t *dst,
 
 	err = connect(sock, (struct sockaddr *) &addr, sizeof(addr));
 	if (err < 0 && !(errno == EAGAIN || errno == EINPROGRESS))
-		return err;
+		return -errno;
 
 	return 0;
 }
@@ -558,8 +559,9 @@ static int rfcomm_bind(int sock,
 	addr.rc_channel = channel;
 
 	if (bind(sock, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		int error = -errno;
 		ERROR_FAILED(err, "rfcomm_bind", errno);
-		return -1;
+		return error;
 	}
 
 	return 0;
@@ -577,7 +579,7 @@ static int rfcomm_connect(int sock, const bdaddr_t *dst, uint8_t channel)
 
 	err = connect(sock, (struct sockaddr *) &addr, sizeof(addr));
 	if (err < 0 && !(errno == EAGAIN || errno == EINPROGRESS))
-		return err;
+		return -errno;
 
 	return 0;
 }
@@ -604,8 +606,9 @@ static int sco_bind(int sock, const bdaddr_t *src, GError **err)
 	bacpy(&addr.sco_bdaddr, src);
 
 	if (bind(sock, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		int error = -errno;
 		ERROR_FAILED(err, "sco_bind", errno);
-		return -1;
+		return error;
 	}
 
 	return 0;
@@ -622,7 +625,7 @@ static int sco_connect(int sock, const bdaddr_t *dst)
 
 	err = connect(sock, (struct sockaddr *) &addr, sizeof(addr));
 	if (err < 0 && !(errno == EAGAIN || errno == EINPROGRESS))
-		return err;
+		return -errno;
 
 	return 0;
 }
-- 
1.7.6

