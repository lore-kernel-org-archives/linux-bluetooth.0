Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 1/2] Utilise os_set_response in check_put
Date: Wed,  5 Oct 2011 16:52:04 +0200
Message-Id: <1317826325-26436-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/obex.c |   11 +----------
 1 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/src/obex.c b/src/obex.c
index 2cabadb..b0a4183 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -1076,22 +1076,13 @@ static gboolean check_put(obex_t *obex, obex_object_t *obj)
 	switch (ret) {
 	case 0:
 		break;
-	case -EPERM:
-		OBEX_ObjectSetRsp(obj, OBEX_RSP_FORBIDDEN, OBEX_RSP_FORBIDDEN);
-		return FALSE;
-	case -EBADR:
-		OBEX_ObjectSetRsp(obj, OBEX_RSP_BAD_REQUEST,
-					OBEX_RSP_BAD_REQUEST);
-		return FALSE;
 	case -EAGAIN:
 		OBEX_SuspendRequest(obex, obj);
 		os->obj = obj;
 		os->driver->set_io_watch(os->object, handle_async_io, os);
 		return TRUE;
 	default:
-		DBG("Unhandled chkput error: %d", ret);
-		OBEX_ObjectSetRsp(obj, OBEX_RSP_INTERNAL_SERVER_ERROR,
-				OBEX_RSP_INTERNAL_SERVER_ERROR);
+		os_set_response(obj, ret);
 		return FALSE;
 
 	}
-- 
1.7.4.1

