Return-Path: <cyrus@holtmann.org>
From: Jakub Adamek <adamek.kuba@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Adamek <adamek.kuba@gmail.com>
Subject: [RFC obexd 2/4] Stop get_next_headers on OBEX_HEADER_EMPTY
Date: Fri, 12 Aug 2011 01:43:06 +0200
Message-Id: <1313106188-30273-3-git-send-email-adamek.kuba@gmail.com>
In-Reply-To: <1313106188-30273-1-git-send-email-adamek.kuba@gmail.com>
References: <1313106188-30273-1-git-send-email-adamek.kuba@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The current code interprets returning 0 from
get_next_header as signaling the end of headers
to be sent. This prevents drivers from sending
headers of 0 length. To alleviate this,
we now set the header number in get_next_header
to OBEX_HEADER_EMPTY after all signals have been
sent.
---
 src/obex.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/obex.c b/src/obex.c
index 9595aad..e207f66 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -637,8 +637,10 @@ static int obex_write(struct obex_session *os, obex_t *obex, obex_object_t *obj)
 	if (os->buf == NULL)
 		os->buf = g_malloc0(os->tx_mtu);
 
-	while ((len = os->driver->get_next_header(os->object, os->buf,
-					os->tx_mtu, &hi)) != 0) {
+	while (TRUE) {
+		len = os->driver->get_next_header(os->object, os->buf,
+					os->tx_mtu, &hi);
+
 		if (len < 0) {
 			error("get_next_header(): %s (%zd)", strerror(-len),
 								-len);
@@ -652,6 +654,9 @@ static int obex_write(struct obex_session *os, obex_t *obex, obex_object_t *obj)
 			return len;
 		}
 
+		if (hi == OBEX_HDR_EMPTY)
+			break;
+
 		hd.bs = os->buf;
 		OBEX_ObjectAddHeader(obex, obj, hi, hd, len, 0);
 	}
-- 
1.7.4.1

