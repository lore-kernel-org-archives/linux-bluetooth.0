Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v3 1/7] profiles/network: Remove redundant code for bnep interface name
Date: Fri, 29 Nov 2013 11:54:00 +0200
Message-Id: <1385718846-19070-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1385718846-19070-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1385718846-19070-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove redundant code for copying bnepX interface name from connection
and server files. It is better to place on actual function call.
---
 profiles/network/common.c     | 4 ++--
 profiles/network/connection.c | 2 --
 profiles/network/server.c     | 3 ---
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/profiles/network/common.c b/profiles/network/common.c
index 0b291bd..c2da925 100644
--- a/profiles/network/common.c
+++ b/profiles/network/common.c
@@ -149,9 +149,9 @@ int bnep_connadd(int sk, uint16_t role, char *dev)
 {
 	struct bnep_connadd_req req;
 
+	memset(dev, 0, 16);
 	memset(&req, 0, sizeof(req));
-	strncpy(req.device, dev, 16);
-	req.device[15] = '\0';
+	strcpy(req.device, "bnep%d");
 	req.sock = sk;
 	req.role = role;
 	if (ioctl(ctl, BNEPCONNADD, &req) < 0) {
diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index 5966268..301f66d 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -692,8 +692,6 @@ int connection_register(struct btd_service *service)
 
 	nc = g_new0(struct network_conn, 1);
 	nc->id = id;
-	memset(nc->dev, 0, sizeof(nc->dev));
-	strcpy(nc->dev, "bnep%d");
 	nc->service = btd_service_ref(service);
 	nc->state = DISCONNECTED;
 	nc->peer = peer;
diff --git a/profiles/network/server.c b/profiles/network/server.c
index 0050b30..3a7e52a 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -269,9 +269,6 @@ static int server_connadd(struct network_server *ns,
 	char devname[16];
 	int err, nsk;
 
-	memset(devname, 0, sizeof(devname));
-	strcpy(devname, "bnep%d");
-
 	nsk = g_io_channel_unix_get_fd(session->io);
 	err = bnep_connadd(nsk, dst_role, devname);
 	if (err < 0)
-- 
1.8.3.2

