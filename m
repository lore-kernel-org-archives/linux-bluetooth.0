Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6] bnep: Make error logging more descriptive
Date: Fri, 17 Oct 2014 15:54:06 +0300
Message-Id: <1413550450-16577-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1413550450-16577-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1413550450-16577-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add "bnep" before error message.
---
 profiles/network/bnep.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 035beb1..e17a130 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -140,7 +140,7 @@ int bnep_init(void)
 		if (err == -EPROTONOSUPPORT)
 			warn("kernel lacks bnep-protocol support");
 		else
-			error("Failed to open control socket: %s (%d)",
+			error("bnep: Failed to open control socket: %s (%d)",
 						strerror(-err), -err);
 
 		return err;
@@ -164,7 +164,7 @@ static int bnep_conndel(const bdaddr_t *dst)
 	req.flags = 0;
 	if (ioctl(ctl, BNEPCONNDEL, &req)) {
 		int err = -errno;
-		error("Failed to kill connection: %s (%d)",
+		error("bnep: Failed to kill connection: %s (%d)",
 						strerror(-err), -err);
 		return err;
 	}
@@ -183,7 +183,7 @@ static int bnep_connadd(int sk, uint16_t role, char *dev)
 	req.role = role;
 	if (ioctl(ctl, BNEPCONNADD, &req) < 0) {
 		int err = -errno;
-		error("Failed to add device %s: %s(%d)",
+		error("bnep: Failed to add device %s: %s(%d)",
 				dev, strerror(-err), -err);
 		return err;
 	}
@@ -210,7 +210,7 @@ static int bnep_if_up(const char *devname)
 	close(sk);
 
 	if (err < 0) {
-		error("Could not bring up %s", devname);
+		error("bnep: Could not bring up %s", devname);
 		return err;
 	}
 
@@ -235,7 +235,7 @@ static int bnep_if_down(const char *devname)
 	close(sk);
 
 	if (err < 0) {
-		error("Could not bring down %s", devname);
+		error("bnep: Could not bring down %s", devname);
 		return err;
 	}
 
@@ -272,7 +272,7 @@ static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 	}
 
 	if (cond & (G_IO_HUP | G_IO_ERR)) {
-		error("Hangup or error on l2cap server socket");
+		error("bnep: Hangup or error on l2cap server socket");
 		goto failed;
 	}
 
@@ -280,25 +280,25 @@ static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 	memset(pkt, 0, BNEP_MTU);
 	r = read(sk, pkt, sizeof(pkt) - 1);
 	if (r < 0) {
-		error("IO Channel read error");
+		error("bnep: IO Channel read error");
 		goto failed;
 	}
 
 	if (r == 0) {
-		error("No packet received on l2cap socket");
+		error("bnep: No packet received on l2cap socket");
 		goto failed;
 	}
 
 	errno = EPROTO;
 
 	if ((size_t) r < sizeof(*rsp)) {
-		error("Packet received is not bnep type");
+		error("bnep: Packet received is not bnep type");
 		goto failed;
 	}
 
 	rsp = (void *) pkt;
 	if (rsp->type != BNEP_CONTROL) {
-		error("Packet received is not bnep type");
+		error("bnep: Packet received is not bnep type");
 		goto failed;
 	}
 
@@ -307,7 +307,7 @@ static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 
 	r = ntohs(rsp->resp);
 	if (r != BNEP_SUCCESS) {
-		error("bnep failed");
+		error("bnep: failed");
 		goto failed;
 	}
 
@@ -320,7 +320,7 @@ static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 		goto failed;
 
 	if (bnep_if_up(session->iface)) {
-		error("could not up %s", session->iface);
+		error("bnep: could not up %s", session->iface);
 		bnep_conndel(&session->dst_addr);
 		goto failed;
 	}
@@ -359,7 +359,7 @@ static int bnep_setup_conn_req(struct bnep *session)
 
 	fd = g_io_channel_unix_get_fd(session->io);
 	if (write(fd, pkt, sizeof(*req) + sizeof(*s)) < 0) {
-		error("bnep connection req send failed: %s", strerror(errno));
+		error("bnep: connection req send failed: %s", strerror(errno));
 		return -errno;
 	}
 
@@ -373,9 +373,9 @@ static gboolean bnep_conn_req_to(gpointer user_data)
 	struct bnep *session = user_data;
 
 	if (session->attempts == CON_SETUP_RETRIES) {
-		error("Too many bnep connection attempts");
+		error("bnep: Too many bnep connection attempts");
 	} else {
-		error("bnep connection setup TO, retrying...");
+		error("bnep: connection setup TO, retrying...");
 		if (bnep_setup_conn_req(session) == 0)
 			return TRUE;
 	}
@@ -444,7 +444,7 @@ int bnep_connect(struct bnep *session, bnep_connect_cb conn_cb, void *data)
 	bt_io_get(session->io, &gerr, BT_IO_OPT_DEST_BDADDR, &session->dst_addr,
 							BT_IO_OPT_INVALID);
 	if (gerr) {
-		error("%s", gerr->message);
+		error("bnep: connect failed: %s", gerr->message);
 		g_error_free(gerr);
 		return -EINVAL;
 	}
@@ -564,14 +564,14 @@ int bnep_server_add(int sk, uint16_t dst, char *bridge, char *iface,
 		return err;
 
 	if (bnep_add_to_bridge(iface, bridge) < 0) {
-		error("Can't add %s to the bridge %s: %s(%d)",
+		error("bnep: Can't add %s to the bridge %s: %s(%d)",
 					iface, bridge, strerror(errno), errno);
 		bnep_conndel(addr);
 		return -errno;
 	}
 
 	if (bnep_if_up(iface) < 0) {
-		error("Can't up the interface %s: %s(%d)",
+		error("bnep: Can't up the interface %s: %s(%d)",
 						iface, strerror(errno), errno);
 		return -errno;
 	}
-- 
1.9.1

