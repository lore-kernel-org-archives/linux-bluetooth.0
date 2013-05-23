Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/1] obexd: Fix SetPath response
Date: Thu, 23 May 2013 18:33:30 +0200
Message-Id: <1369326810-6397-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

This fixes the issue, that failed attempts to the OBEX SetPath command
are not propagated through the D-Bus API.

Trace:

  method call sender=:1.942 -> dest=:1.934 serial=8
  path=/org/bluez/obex/client/session3;
  interface=org.bluez.obex.MessageAccess1; member=SetFolder
     string "test"
  method return sender=:1.934 -> dest=:1.942 reply_serial=8

  method call sender=:1.946 -> dest=:1.945 serial=8
  path=/org/bluez/obex/client/session0;
  interface=org.bluez.obex.MessageAccess1; member=SetFolder
     string "test"
  error sender=:1.945 -> dest=:1.946
  error_name=org.bluez.obex.Error.Failed reply_serial=8
     string "Not Found"
---
 obexd/client/session.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/obexd/client/session.c b/obexd/client/session.c
index 17a3d3f..f1bdf18 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -895,7 +895,7 @@ static void setpath_cb(GObex *obex, GError *err, GObexPacket *rsp,
 		GError *gerr = NULL;
 		g_set_error(&gerr, OBEX_IO_ERROR, code, "%s",
 							g_obex_strerror(code));
-		setpath_complete(p->session, NULL, err, user_data);
+		setpath_complete(p->session, NULL, gerr, user_data);
 		g_clear_error(&gerr);
 		return;
 	}
-- 
1.8.2.3

