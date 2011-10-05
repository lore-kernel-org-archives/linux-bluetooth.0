Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 4/4] Simplify code for calling mime driver flush()
Date: Wed,  5 Oct 2011 16:32:40 +0200
Message-Id: <1317825160-21429-4-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1317825160-21429-1-git-send-email-lkslawek@gmail.com>
References: <1317825160-21429-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

OBEX_EV_REQ is the last thing that we are going to receive on PUT and
this is always going to be delivered. As the service driver will start
receiving data at or before its .put(), we can simply call flush() after
that. This also makes flush() usable in PUTs without length header.
---
 src/obex.c |   28 ++++++++++------------------
 1 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/src/obex.c b/src/obex.c
index 38c5ca6..2cabadb 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -625,11 +625,6 @@ write:
 		os->pending -= w;
 	}
 
-	/* Flush on EOS */
-	if (os->size != OBJECT_SIZE_UNKNOWN && os->size == os->offset &&
-							os->driver->flush)
-		return os->driver->flush(os->object) > 0 ? -EAGAIN : 0;
-
 	return 0;
 }
 
@@ -1140,19 +1135,16 @@ static void cmd_put(struct obex_session *os, obex_t *obex, obex_object_t *obj)
 		return;
 	}
 
-	/* Check if there is a body and it is not empty (size > 0), otherwise
-	   openobex won't notify us with OBEX_EV_STREAMAVAIL and it gonna reply
-	   right away */
-	if (os->size != 0)
-		return;
-
-	/* Flush immediatly since there is nothing to write so the driver
-	   has a chance to do something before we reply */
-	if (os->object && os->driver && os->driver->flush &&
-					os->driver->flush(os->object) > 0) {
-		OBEX_SuspendRequest(obex, obj);
-		os->obj = obj;
-		os->driver->set_io_watch(os->object, handle_async_io, os);
+	if (os->object && os->driver && os->driver->flush) {
+		err = os->driver->flush(os->object);
+		if (err == -EAGAIN) {
+			OBEX_SuspendRequest(obex, obj);
+			os->obj = obj;
+			os->driver->set_io_watch(os->object,
+							handle_async_io, os);
+		} else if (err < 0) {
+			os_set_response(obj, err);
+		}
 	}
 }
 
-- 
1.7.4.1

