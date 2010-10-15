Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH] Type conversion in read and write obex streams
Date: Fri, 15 Oct 2010 14:46:19 +0300
Message-Id: <1287143179-22136-2-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1287143179-22136-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1287143179-22136-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Integer types in obex_write_stream and obex_read_stream shell be the
same as those returned by read and write function prototypes of
obex_mime_type_driver.
---
 src/obex.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/obex.c b/src/obex.c
index adfcc95..f37cd90 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -555,7 +555,7 @@ static int obex_read_stream(struct obex_session *os, obex_t *obex,
 						obex_object_t *obj)
 {
 	int size;
-	int32_t len = 0;
+	ssize_t len = 0;
 	const uint8_t *buffer;
 
 	DBG("name=%s type=%s rx_mtu=%d file=%p",
@@ -596,7 +596,7 @@ static int obex_read_stream(struct obex_session *os, obex_t *obex,
 
 write:
 	while (os->pending > 0) {
-		int w;
+		ssize_t w;
 
 		w = os->driver->write(os->object, os->buf + len,
 					os->pending);
@@ -622,7 +622,7 @@ static int obex_write_stream(struct obex_session *os,
 {
 	obex_headerdata_t hd;
 	uint8_t *ptr;
-	int32_t len;
+	ssize_t len;
 	unsigned int flags;
 	uint8_t hi;
 
@@ -644,7 +644,7 @@ static int obex_write_stream(struct obex_session *os,
 
 	len = os->driver->read(os->object, os->buf, os->tx_mtu, &hi);
 	if (len < 0) {
-		error("read(): %s (%d)", strerror(-len), -len);
+		error("read(): %s (%zd)", strerror(-len), -len);
 		if (len == -EAGAIN)
 			return len;
 		else if (len == -ENOSTR)
-- 
1.7.0.4

