Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 5/8] core: Use ENOSYS to indicate not implemented function
Date: Sat, 18 Feb 2012 17:19:00 +0200
Message-Id: <1329578343-31663-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1329578343-31663-1-git-send-email-luiz.dentz@gmail.com>
References: <1329578343-31663-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/obex.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/src/obex.c b/src/obex.c
index 2b10103..786398d 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -767,7 +767,7 @@ static void cmd_get(GObex *obex, GObexPacket *req, gpointer user_data)
 	}
 
 	if (os->service->get == NULL) {
-		os_set_response(os, -EINVAL);
+		os_set_response(os, -ENOSYS);
 		return;
 	}
 
@@ -782,7 +782,7 @@ static void cmd_get(GObex *obex, GObexPacket *req, gpointer user_data)
 
 	if (!os->driver) {
 		error("No driver found");
-		os_set_response(os, -EINVAL);
+		os_set_response(os, -ENOSYS);
 		return;
 	}
 
@@ -814,7 +814,7 @@ static void cmd_setpath(GObex *obex, GObexPacket *req, gpointer user_data)
 	}
 
 	if (os->service->setpath == NULL) {
-		err = -EINVAL;
+		err = -ENOSYS;
 		goto done;
 	}
 
@@ -955,7 +955,7 @@ static void cmd_put(GObex *obex, GObexPacket *req, gpointer user_data)
 
 	if (os->driver == NULL) {
 		error("No driver found");
-		os_set_response(os, -EINVAL);
+		os_set_response(os, -ENOSYS);
 		return;
 	}
 
@@ -971,7 +971,7 @@ static void cmd_put(GObex *obex, GObexPacket *req, gpointer user_data)
 	}
 
 	if (os->service->put == NULL) {
-		os_set_response(os, -EINVAL);
+		os_set_response(os, -ENOSYS);
 		return;
 	}
 
@@ -1036,7 +1036,7 @@ static void cmd_action(GObex *obex, GObexPacket *req, gpointer user_data)
 	}
 
 	if (os->service->action == NULL) {
-		err = -EINVAL;
+		err = -ENOSYS;
 		goto done;
 	}
 
@@ -1052,7 +1052,7 @@ static void cmd_action(GObex *obex, GObexPacket *req, gpointer user_data)
 						os->service->who,
 						os->service->who_size);
 	if (os->driver == NULL) {
-		err = -EINVAL;
+		err = -ENOSYS;
 		goto done;
 	}
 
@@ -1168,7 +1168,7 @@ const char *obex_get_type(struct obex_session *os)
 int obex_remove(struct obex_session *os, const char *path)
 {
 	if (os->driver == NULL)
-		return -EINVAL;
+		return -ENOSYS;
 
 	return os->driver->remove(path);
 }
@@ -1177,7 +1177,7 @@ int obex_copy(struct obex_session *os, const char *source,
 						const char *destination)
 {
 	if (os->driver == NULL || os->driver->copy == NULL)
-		return -EINVAL;
+		return -ENOSYS;
 
 	DBG("%s %s", source, destination);
 
@@ -1188,7 +1188,7 @@ int obex_move(struct obex_session *os, const char *source,
 						const char *destination)
 {
 	if (os->driver == NULL || os->driver->move == NULL)
-		return -EINVAL;
+		return -ENOSYS;
 
 	DBG("%s %s", source, destination);
 
-- 
1.7.7.6

