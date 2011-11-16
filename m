Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 12/17] network: Fix errno handling convention
Date: Wed, 16 Nov 2011 09:19:59 -0400
Message-Id: <1321449604-4188-13-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Variables which are assigned to the errno variable (usually called
"err") should be negative, and "-err" should be used where a positive
value is needed.
---
 network/common.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/network/common.c b/network/common.c
index 6da9f0a..c498c25 100644
--- a/network/common.c
+++ b/network/common.c
@@ -108,10 +108,10 @@ int bnep_init(void)
 	ctl = socket(PF_BLUETOOTH, SOCK_RAW, BTPROTO_BNEP);
 
 	if (ctl < 0) {
-		int err = errno;
+		int err = -errno;
 		error("Failed to open control socket: %s (%d)",
-						strerror(err), err);
-		return -err;
+						strerror(-err), -err);
+		return err;
 	}
 
 	return 0;
@@ -131,10 +131,10 @@ int bnep_kill_connection(bdaddr_t *dst)
 	baswap((bdaddr_t *)&req.dst, dst);
 	req.flags = 0;
 	if (ioctl(ctl, BNEPCONNDEL, &req)) {
-		int err = errno;
+		int err = -errno;
 		error("Failed to kill connection: %s (%d)",
-						strerror(err), err);
-		return -err;
+						strerror(-err), -err);
+		return err;
 	}
 	return 0;
 }
@@ -150,10 +150,10 @@ int bnep_kill_all_connections(void)
 	req.cnum = 7;
 	req.ci   = ci;
 	if (ioctl(ctl, BNEPGETCONNLIST, &req)) {
-		err = errno;
+		err = -errno;
 		error("Failed to get connection list: %s (%d)",
-						strerror(err), err);
-		return -err;
+						strerror(-err), -err);
+		return err;
 	}
 
 	for (i = 0; i < req.cnum; i++) {
@@ -177,10 +177,10 @@ int bnep_connadd(int sk, uint16_t role, char *dev)
 	req.sock = sk;
 	req.role = role;
 	if (ioctl(ctl, BNEPCONNADD, &req) < 0) {
-		int err = errno;
+		int err = -errno;
 		error("Failed to add device %s: %s(%d)",
-				dev, strerror(err), err);
-		return -err;
+				dev, strerror(-err), -err);
+		return err;
 	}
 
 	strncpy(dev, req.device, 16);
-- 
1.7.0.4

