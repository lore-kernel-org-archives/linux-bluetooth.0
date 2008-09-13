Return-Path: <cyrus@holtmann.org>
Message-ID: <48CBE24E.6080507@free.fr>
Date: Sat, 13 Sep 2008 17:54:54 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="------------010602090708070409070506"
Subject: [Bluez-devel] Some Audio error handling fixes.
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
--------------010602090708070409070506
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

While running tests on bluez-utils lately i found a number of big and
little error handling issues.
Attached patchset fixes all of them :-)

Can anyone have a look to it ?

While reading the latest code, i noticed common/error.{c, h} is gone...
There's a new one in src/, but with only one generic
error handling routine. I have the feeling this is a big step backwards,
as DBUS error names get duplicated into each service
again and again, paving the way for un unmanageable level of error
strings fragmentation :-( What do you guys think ?

Cheers,

Fabien


--------------010602090708070409070506
Content-Type: text/x-patch;
 name="0001-Error-code-fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Error-code-fixes.patch"

>>From a22fa4ea791b5555673cdb1729f8d72510fbb74f Mon Sep 17 00:00:00 2001
From: Fabien Chevalier <fabchevalier@free.fr>
Date: Sat, 13 Sep 2008 17:11:08 +0200
Subject: [PATCH] Error code fixes

In case of socket errors, we used to return a positive value
where the convention is to return negative values only
---
 audio/avdtp.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index 592322f..ae56910 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -1380,7 +1380,7 @@ static gboolean avdtp_parse_cmd(struct avdtp *session,
 		debug("Received DISCOVER_CMD");
 		return avdtp_discover_cmd(session, (void *) header, size);
 	case AVDTP_GET_CAPABILITIES:
-		debug("Received  GET_CAPABILITIES_CMD");
+		debug("Received	GET_CAPABILITIES_CMD");
 		return avdtp_getcap_cmd(session, (void *) header, size);
 	case AVDTP_SET_CONFIGURATION:
 		debug("Received SET_CONFIGURATION_CMD");
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
 
@@ -1598,7 +1598,7 @@ failed:
 					AVDTP_STATE_IDLE);
 		session->pending_open = NULL;
 	} else
-		connection_lost(session, -err);
+		connection_lost(session, err);
 
 	return;
 }
-- 
1.5.6.5



--------------010602090708070409070506
Content-Type: text/x-patch;
 name="0002-Connect-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0002-Connect-fix.patch"

>>From dbaed0dc30ebe2a4503a43d2e8e9fd69f1eced2d Mon Sep 17 00:00:00 2001
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



--------------010602090708070409070506
Content-Type: text/x-patch;
 name="0003-Error-value-fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0003-Error-value-fixes.patch"

>>From 6a3a4f1229728754e01f3bc7911c3d508348a56f Mon Sep 17 00:00:00 2001
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



--------------010602090708070409070506
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--------------010602090708070409070506
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------010602090708070409070506--
