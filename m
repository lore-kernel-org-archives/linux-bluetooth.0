Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Thu, 22 Jun 2017 13:50:23 +0300
From: Matias Karhumaa <matias.karhumaa@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] obexd: Fix null pointer dereference.
Message-ID: <20170622105020.GA5388@makarhum-e6330>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

By sending OPP Put request before CONNECT we were able to cause
SIGSEGV in obexd. Crash was caused by null pointer dereference.
Crash was found using Synopsys Defensics Obex Server test suite.

This was fixed by calling os->service->connect if CONNECT was not
done before.
---
 obexd/src/obex.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/obexd/src/obex.c b/obexd/src/obex.c
index 788bffc..be79a77 100644
--- a/obexd/src/obex.c
+++ b/obexd/src/obex.c
@@ -864,6 +864,17 @@ static void cmd_put(GObex *obex, GObexPacket *req, gpointer user_data)
 		return;
 	}
 
+	/* OPP session don't require CONNECT, in which case just call connect
+	 * callback to register the transfer.
+	 */
+	if (!os->service_data && os->service->service == OBEX_OPP) {
+		os->service_data = os->service->connect(os, &err);
+		if (err < 0) {
+			os_set_response(os, err);
+			return;
+		}
+	}
+
 	parse_type(os, req);
 
 	if (os->driver == NULL) {
-- 
2.7.4

