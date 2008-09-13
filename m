Return-Path: <cyrus@holtmann.org>
Message-ID: <48CC2789.6010203@free.fr>
Date: Sat, 13 Sep 2008 22:50:17 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <48CBE24E.6080507@free.fr>
In-Reply-To: <48CBE24E.6080507@free.fr>
Content-Type: multipart/mixed; boundary="------------030601060101010508090906"
Subject: Re: [Bluez-devel] Some Audio error handling fixes.
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------030601060101010508090906
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

Updated patchset attached !

Luiz: I tried to find some doc to get started on gitorious but didn't 
found any... how to i create my remote clone ?

Regards,

Fabien

--------------030601060101010508090906
Content-Type: text/x-patch;
 name="0001-Error-code-fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Error-code-fixes.patch"

>>From 66048184e4d7c88afae449236a2e62ef352c4438 Mon Sep 17 00:00:00 2001
From: Fabien Chevalier <fabchevalier@free.fr>
Date: Sat, 13 Sep 2008 17:11:08 +0200
Subject: [PATCH] Error code fixes

In case of socket errors, we used to return a positive value
where the convention is to return negative values only : fix that
---
 audio/avdtp.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index 592322f..bf5c0d3 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -489,7 +489,7 @@ static gboolean disconnect_timeout(gpointer user_data)
 
 	session->dc_timer = 0;
 
-	connection_lost(session, -ETIMEDOUT);
+	connection_lost(session, ETIMEDOUT);
 
 	return FALSE;
 }
@@ -728,7 +728,7 @@ static void finalize_discovery(struct avdtp *session, int err)
 {
 	struct avdtp_error avdtp_err;
 
-	avdtp_error_init(&avdtp_err, AVDTP_ERROR_ERRNO, -err);
+	avdtp_error_init(&avdtp_err, AVDTP_ERROR_ERRNO, err);
 
 	if (!session->discov_cb)
 		return;
@@ -1380,7 +1380,7 @@ static gboolean avdtp_parse_cmd(struct avdtp *session,
 		debug("Received DISCOVER_CMD");
 		return avdtp_discover_cmd(session, (void *) header, size);
 	case AVDTP_GET_CAPABILITIES:
-		debug("Received  GET_CAPABILITIES_CMD");
+		debug("Received	GET_CAPABILITIES_CMD");
 		return avdtp_getcap_cmd(session, (void *) header, size);
 	case AVDTP_SET_CONFIGURATION:
 		debug("Received SET_CONFIGURATION_CMD");
@@ -1519,7 +1519,7 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 	return TRUE;
 
 failed:
-	connection_lost(session, -EIO);
+	connection_lost(session, EIO);
 
 	return FALSE;
 }
@@ -1559,9 +1559,9 @@ static void l2cap_connect_cb(GIOChannel *chan, int err, const bdaddr_t *src,
 	len = sizeof(l2o);
 	if (getsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &l2o,
 				&len) < 0) {
-		err = errno;
-		error("getsockopt(L2CAP_OPTIONS): %s (%d)", strerror(err),
-				err);
+		err = -errno;
+		error("getsockopt(L2CAP_OPTIONS): %s (%d)", strerror(-err),
+				-err);
 		goto failed;
 	}
 
@@ -1710,7 +1710,7 @@ static gboolean request_timeout(gpointer user_data)
 	goto done;
 
 failed:
-	connection_lost(session, -ETIMEDOUT);
+	connection_lost(session, ETIMEDOUT);
 done:
 	pending_req_free(req);
 	return FALSE;
@@ -2716,7 +2716,7 @@ static void auth_cb(DBusError *derr, void *user_data)
 	if (derr && dbus_error_is_set(derr)) {
 		error("Access denied: %s", derr->message);
 
-		connection_lost(session, -EACCES);
+		connection_lost(session, EACCES);
 		return;
 	}
 
-- 
1.5.6.5


--------------030601060101010508090906
Content-Type: text/x-patch;
 name="0002-Connect-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0002-Connect-fix.patch"

>>From 8da5a48ab9667f13066d6e048100da9269d8a205 Mon Sep 17 00:00:00 2001
From: Fabien Chevalier <fabchevalier@free.fr>
Date: Sat, 13 Sep 2008 17:13:27 +0200
Subject: [PATCH] Connect() fix.

In case we are unable to connect the sink, we forget to send DBUS reply.
Caller is stuck forever...
---
 audio/sink.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/audio/sink.c b/audio/sink.c
index c6d2dc4..e79b9f1 100644
--- a/audio/sink.c
+++ b/audio/sink.c
@@ -381,11 +381,11 @@ static void discovery_complete(struct avdtp *session, GSList *seps, struct avdtp
 	return;
 
 failed:
-	pending_request_free(pending);
+	error_failed(pending->conn, pending->msg, "Stream setup failed");
+ 	pending_request_free(pending);
 	sink->connect = NULL;
 	avdtp_unref(sink->session);
 	sink->session = NULL;
-	error_failed(pending->conn, pending->msg, "Stream setup failed");
 }
 
 static DBusMessage *sink_connect(DBusConnection *conn,
-- 
1.5.6.5


--------------030601060101010508090906
Content-Type: text/x-patch;
 name="0003-Error-value-fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0003-Error-value-fixes.patch"

>>From d79457b70e1480f0c590d043208dbe61ceca4026 Mon Sep 17 00:00:00 2001
From: Fabien Chevalier <fabchevalier@free.fr>
Date: Sat, 13 Sep 2008 17:14:34 +0200
Subject: [PATCH] Error value fixes.

In case the HSP/HFP headset is down, we return "not supported" : this is non-sense :
change that to connection attempt failed
---
 audio/headset.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index 102d0bc..45bcf34 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -1074,7 +1074,9 @@ static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
 	if (err < 0) {
 		error("Unable to get service record: %s (%d)", strerror(-err),
 			-err);
-		goto failed_not_supported;
+		error_connection_attempt_failed(dev->conn, p->msg, p->err);
+
+		goto failed;
 	}
 
 	if (!recs || !recs->data) {
@@ -1140,10 +1142,13 @@ static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
 failed_not_supported:
 	if (p->msg) {
 		error_not_supported(dev->conn, p->msg);
+	}
+failed:
+	if (p->msg) {
 		dbus_message_unref(p->msg);
 		p->msg = NULL;
 	}
-failed:
+
 	if (classes)
 		sdp_list_free(classes, free);
 	pending_connect_finalize(dev);
-- 
1.5.6.5


--------------030601060101010508090906
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--------------030601060101010508090906
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------030601060101010508090906--
