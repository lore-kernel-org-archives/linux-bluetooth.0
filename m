Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] Fix common spelling error in code and comments
Date: Thu, 29 Mar 2012 16:12:44 +0200
Message-ID: <1333030364-6918-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Correct spelling is "incoming" not "incomming".
---
 audio/audio.conf  |    2 +-
 audio/headset.c   |    2 +-
 lib/sdp.c         |   14 +++++++-------
 network/manager.c |    2 +-
 sap/server.c      |    4 ++--
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/audio/audio.conf b/audio/audio.conf
index 302e046..1bcc85c 100644
--- a/audio/audio.conf
+++ b/audio/audio.conf
@@ -33,7 +33,7 @@ HFP=true
 MaxConnected=1
 
 # Set to true to enable use of fast connectable mode (faster page scanning)
-# for HFP when incomming call starts. Default settings are restored after
+# for HFP when incoming call starts. Default settings are restored after
 # call is answered or rejected. Page scan interval is much shorter and page
 # scan type changed to interlaced. Such allows faster connection initiated
 # by a headset.
diff --git a/audio/headset.c b/audio/headset.c
index a10a386..04b26a9 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -1299,7 +1299,7 @@ static gboolean rfcomm_io_cb(GIOChannel *chan, GIOCondition cond,
 	if (free_space < (size_t) bytes_read) {
 		/* Very likely that the HS is sending us garbage so
 		 * just ignore the data and disconnect */
-		error("Too much data to fit incomming buffer");
+		error("Too much data to fit incoming buffer");
 		goto failed;
 	}
 
diff --git a/lib/sdp.c b/lib/sdp.c
index e12bace..eaf8d00 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -3708,8 +3708,8 @@ int sdp_set_notify(sdp_session_t *session, sdp_callback_t *func, void *udata)
 
 /*
  * This function starts an asynchronous service search request.
- * The incomming and outgoing data are stored in the transaction structure
- * buffers. When there is incomming data the sdp_process function must be
+ * The incoming and outgoing data are stored in the transaction structure
+ * buffers. When there is incoming data the sdp_process function must be
  * called to get the data and handle the continuation state.
  *
  * INPUT :
@@ -3800,8 +3800,8 @@ end:
 
 /*
  * This function starts an asynchronous service attribute request.
- * The incomming and outgoing data are stored in the transaction structure
- * buffers. When there is incomming data the sdp_process function must be
+ * The incoming and outgoing data are stored in the transaction structure
+ * buffers. When there is incoming data the sdp_process function must be
  * called to get the data and handle the continuation state.
  *
  * INPUT :
@@ -3911,9 +3911,9 @@ end:
 
 /*
  * This function starts an asynchronous service search attributes.
- * It is a service search request combined with attribute request. The incomming
+ * It is a service search request combined with attribute request. The incoming
  * and outgoing data are stored in the transaction structure buffers. When there
- * is incomming data the sdp_process function must be called to get the data
+ * is incoming data the sdp_process function must be called to get the data
  * and handle the continuation state.
  *
  * INPUT:
@@ -4056,7 +4056,7 @@ int sdp_get_error(sdp_session_t *session)
 }
 
 /*
- * Receive the incomming SDP PDU. This function must be called when there is data
+ * Receive the incoming SDP PDU. This function must be called when there is data
  * available to be read. On continuation state, the original request (with a new
  * transaction ID) and the continuation state data will be appended in the initial PDU.
  * If an error happens or the transaction finishes the callback function will be called.
diff --git a/network/manager.c b/network/manager.c
index 00a55aa..dd0f311 100644
--- a/network/manager.c
+++ b/network/manager.c
@@ -179,7 +179,7 @@ int network_manager_init(DBusConnection *conn)
 	}
 
 	/*
-	 * There is one socket to handle the incomming connections. NAP,
+	 * There is one socket to handle the incoming connections. NAP,
 	 * GN and PANU servers share the same PSM. The initial BNEP message
 	 * (setup connection request) contains the destination service
 	 * field that defines which service the source is connecting to.
diff --git a/sap/server.c b/sap/server.c
index c7ea112..5213871 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -1208,7 +1208,7 @@ static void connect_confirm_cb(GIOChannel *io, gpointer data)
 
 	conn = g_try_new0(struct sap_connection, 1);
 	if (!conn) {
-		error("Can't allocate memory for incomming SAP connection.");
+		error("Can't allocate memory for incoming SAP connection.");
 		g_io_channel_shutdown(io, TRUE, NULL);
 		return;
 	}
@@ -1241,7 +1241,7 @@ static void connect_confirm_cb(GIOChannel *io, gpointer data)
 		return;
 	}
 
-	DBG("Authorizing incomming SAP connection from %s", dstaddr);
+	DBG("Authorizing incoming SAP connection from %s", dstaddr);
 }
 
 static inline DBusMessage *message_failed(DBusMessage *msg,
-- 
on behalf of ST-Ericsson

