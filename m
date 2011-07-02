Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Sat, 2 Jul 2011 13:48:09 -0400
Subject: [PATCH] Improve input server connect log messages
Message-ID: <1309628889.22449.15.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added error log message for connection refusals and added
remote device BDADDR to existing debug messages.
---
 input/server.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/input/server.c b/input/server.c
index 7fd00f2..cea08d1 100644
--- a/input/server.c
+++ b/input/server.c
@@ -62,6 +62,7 @@ static void connect_event_cb(GIOChannel *chan, GError *err, gpointer data)
 {
 	uint16_t psm;
 	bdaddr_t src, dst;
+	char address[18];
 	GError *gerr = NULL;
 	int ret;
 
@@ -82,12 +83,15 @@ static void connect_event_cb(GIOChannel *chan, GError *err, gpointer data)
 		return;
 	}
 
-	DBG("Incoming connection on PSM %d", psm);
+	ba2str(&dst, address);
+	DBG("Incoming connection from %s on PSM %d", address, psm);
 
 	ret = input_device_set_channel(&src, &dst, psm, chan);
 	if (ret == 0)
 		return;
 
+	error("Refusing input device connect: %s (%d)", strerror(-ret), -ret);
+
 	/* Send unplug virtual cable to unknown devices */
 	if (ret == -ENOENT && psm == L2CAP_PSM_HIDP_CTRL) {
 		unsigned char unplug = 0x15;
@@ -157,7 +161,11 @@ static void confirm_event_cb(GIOChannel *chan, gpointer user_data)
 	}
 
 	if (server->confirm) {
-		error("Refusing connection: setup in progress");
+		char address[18];
+
+		ba2str(&dst, address);
+		error("Refusing connection from %s: setup in progress",
+								address);
 		goto drop;
 	}
 
-- 
1.7.4.1

