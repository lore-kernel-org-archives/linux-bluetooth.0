Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] profiles/network: Add support for handling extension hdr in ctrl msg
Date: Thu,  9 Apr 2015 13:55:18 +0200
Message-Id: <1428580519-3856-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1428580519-3856-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1428580519-3856-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support for extension headers is mandatory functionality. This patch
add support to it and leave responsibility for processing extension
header and sending setup success response to kernel.

This patch is necessary to pass PTS bnep test TC_CTRL_BV_19_C.
---
 android/pan.c             |  2 +-
 profiles/network/bnep.c   | 41 +++++++++++++++++++++++++++++++++++++----
 profiles/network/server.c |  2 +-
 tools/bneptest.c          |  2 +-
 4 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index 6c9815b..b98fccd 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -472,7 +472,7 @@ static gboolean nap_setup_cb(GIOChannel *chan, GIOCondition cond,
 	sk = g_io_channel_unix_get_fd(chan);
 
 	/* Reading BNEP_SETUP_CONNECTION_REQUEST_MSG */
-	n = read(sk, packet, sizeof(packet));
+	n = recv(sk, packet, sizeof(packet), MSG_PEEK);
 	if (n  < 0) {
 		error("read(): %s(%d)", strerror(errno), errno);
 		goto failed;
diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index e325b72..79ca80d 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -124,6 +124,7 @@ static int bnep_connadd(int sk, uint16_t role, char *dev)
 
 	req.sock = sk;
 	req.role = role;
+	req.flags = (1 << BNEP_SETUP_RESPONSE);
 	if (ioctl(ctl, BNEPCONNADD, &req) < 0) {
 		int err = -errno;
 		error("bnep: Failed to add device %s: %s(%d)",
@@ -135,6 +136,21 @@ static int bnep_connadd(int sk, uint16_t role, char *dev)
 	return 0;
 }
 
+static uint32_t bnep_getsuppfeat(void)
+{
+	uint32_t feat;
+
+	if (ioctl(ctl, BNEPGETSUPPFEAT, &feat) < 0) {
+		int err = -errno;
+
+		info("bnep: Failed to get supported features: %s(%d)",
+							strerror(err), err);
+		return 0;
+	}
+
+	return feat;
+}
+
 static int bnep_if_up(const char *devname)
 {
 	struct ifreq ifr;
@@ -530,7 +546,9 @@ static uint16_t bnep_setup_decode(int sk, struct bnep_setup_conn_req *req,
 	uint8_t *dest, *source;
 	uint32_t val;
 
-	if (req->type != BNEP_CONTROL || req->ctrl != BNEP_SETUP_CONN_REQ)
+	if (((req->type != BNEP_CONTROL) &&
+		(req->type != (BNEP_CONTROL | BNEP_EXT_HEADER)))  ||
+					req->ctrl != BNEP_SETUP_CONN_REQ)
 		return BNEP_CONN_NOT_ALLOWED;
 
 	dest = req->service;
@@ -591,6 +609,7 @@ int bnep_server_add(int sk, char *bridge, char *iface, const bdaddr_t *addr,
 						uint8_t *setup_data, int len)
 {
 	int err;
+	uint32_t feat;
 	uint16_t rsp, dst;
 	struct bnep_setup_conn_req *req = (void *) setup_data;
 
@@ -617,6 +636,16 @@ int bnep_server_add(int sk, char *bridge, char *iface, const bdaddr_t *addr,
 		goto reply;
 	}
 
+	feat = bnep_getsuppfeat();
+
+	/*
+	 * Take out setup data if kernel doesn't support handling it, especially
+	 * setup request. If kernel would have set session flags, they should
+	 * be checked and handled respectively.
+	 */
+	if (!feat || !(feat & (1 << BNEP_SETUP_RESPONSE)))
+		read(sk, setup_data, len);
+
 	err = bnep_connadd(sk, dst, iface);
 	if (err < 0) {
 		rsp = BNEP_CONN_NOT_ALLOWED;
@@ -626,15 +655,19 @@ int bnep_server_add(int sk, char *bridge, char *iface, const bdaddr_t *addr,
 	err = bnep_add_to_bridge(iface, bridge);
 	if (err < 0) {
 		bnep_conndel(addr);
-		rsp = BNEP_CONN_NOT_ALLOWED;
-		goto reply;
+		return err;
 	}
 
 	err = bnep_if_up(iface);
 	if (err < 0)
-		rsp = BNEP_CONN_NOT_ALLOWED;
+		return err;
+
+	/* Kernel will handle success setup response */
+	if (feat & (1 << BNEP_SETUP_RESPONSE))
+		return err;
 
 reply:
+	/* If supported - setup success is handled by bnep session in kernel */
 	if (bnep_send_ctrl_rsp(sk, BNEP_SETUP_CONN_RSP, rsp) < 0) {
 		err = -errno;
 		error("bnep: send ctrl rsp error: %s (%d)", strerror(errno),
diff --git a/profiles/network/server.c b/profiles/network/server.c
index 32aafc3..ec37c97 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -328,7 +328,7 @@ static gboolean bnep_setup(GIOChannel *chan,
 	sk = g_io_channel_unix_get_fd(chan);
 
 	/* Reading BNEP_SETUP_CONNECTION_REQUEST_MSG */
-	n = read(sk, packet, sizeof(packet));
+	n = recv(sk, packet, sizeof(packet), MSG_PEEK);
 	if (n < 0) {
 		error("read(): %s(%d)", strerror(errno), errno);
 		return FALSE;
diff --git a/tools/bneptest.c b/tools/bneptest.c
index 98ee9b1..a7d5815 100644
--- a/tools/bneptest.c
+++ b/tools/bneptest.c
@@ -327,7 +327,7 @@ static gboolean setup_bnep_cb(GIOChannel *chan, GIOCondition cond,
 	sk = g_io_channel_unix_get_fd(chan);
 
 	/* Reading BNEP_SETUP_CONNECTION_REQUEST_MSG */
-	n = read(sk, packet, sizeof(packet));
+	n = recv(sk, packet, sizeof(packet), MSG_PEEK);
 	if (n < 0) {
 		error("read(): %s(%d)", strerror(errno), errno);
 		return FALSE;
-- 
2.1.0

