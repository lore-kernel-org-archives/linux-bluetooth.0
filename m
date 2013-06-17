Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] obexd: Call setpath_complete with the correct parameter
Date: Mon, 17 Jun 2013 14:10:53 +0200
Message-Id: <1371471055-25591-2-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1371471055-25591-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1371471055-25591-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

The function setpath_complete has to be called with a pending_request as
user_data. In one possible error case, the current code calls it
incorrectly with setpath_data.
---
 obexd/client/session.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/obexd/client/session.c b/obexd/client/session.c
index eda3412..a780b8c 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -967,7 +967,7 @@ static void setpath_cb(GObex *obex, GError *err, GObexPacket *rsp,
 
 	p->req_id = g_obex_setpath(obex, next, setpath_cb, p, &err);
 	if (err != NULL) {
-		setpath_complete(p->session, NULL, err, data);
+		setpath_complete(p->session, NULL, err, user_data);
 		g_error_free(err);
 	}
 }
-- 
1.8.2.3

