Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/6] bnep: Avoid double error print for bnep_connadd()
Date: Fri, 17 Oct 2014 15:54:05 +0300
Message-Id: <1413550450-16577-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This avoids double printing the same error with bnep connection add
ioctl.
---
 profiles/network/bnep.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 136709d..035beb1 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -316,10 +316,8 @@ static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 	setsockopt(sk, SOL_SOCKET, SO_RCVTIMEO, &timeo, sizeof(timeo));
 
 	sk = g_io_channel_unix_get_fd(session->io);
-	if (bnep_connadd(sk, session->src, session->iface)) {
-		error("bnep conn could not be added");
+	if (bnep_connadd(sk, session->src, session->iface) < 0)
 		goto failed;
-	}
 
 	if (bnep_if_up(session->iface)) {
 		error("could not up %s", session->iface);
@@ -556,14 +554,14 @@ static int bnep_del_from_bridge(const char *devname, const char *bridge)
 int bnep_server_add(int sk, uint16_t dst, char *bridge, char *iface,
 						const bdaddr_t *addr)
 {
+	int err;
+
 	if (!bridge || !iface || !addr)
 		return -EINVAL;
 
-	if (bnep_connadd(sk, dst, iface) < 0) {
-		error("Can't add connection to the bridge %s: %s(%d)",
-						bridge, strerror(errno), errno);
-		return -errno;
-	}
+	err = bnep_connadd(sk, dst, iface);
+	if (err < 0)
+		return err;
 
 	if (bnep_add_to_bridge(iface, bridge) < 0) {
 		error("Can't add %s to the bridge %s: %s(%d)",
-- 
1.9.1

