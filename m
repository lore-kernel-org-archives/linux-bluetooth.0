Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 1/5] profiles/network: Use interface name passed to bnep_connadd
Date: Wed,  5 Feb 2014 17:00:30 +0100
Message-Id: <1391616034-23312-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1391616034-23312-1-git-send-email-szymon.janc@tieto.com>
References: <1391616034-23312-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/network/bnep.c   | 5 +++--
 profiles/network/server.c | 4 ++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 0d57056..82d0d99 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -174,9 +174,10 @@ static int bnep_connadd(int sk, uint16_t role, char *dev)
 {
 	struct bnep_connadd_req req;
 
-	memset(dev, 0, 16);
 	memset(&req, 0, sizeof(req));
-	strcpy(req.device, "bnep%d");
+	strncpy(req.device, dev, 16);
+	req.device[15] = '\0';
+
 	req.sock = sk;
 	req.role = role;
 	if (ioctl(ctl, BNEPCONNADD, &req) < 0) {
diff --git a/profiles/network/server.c b/profiles/network/server.c
index f14d688..3fb031f 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -51,6 +51,7 @@
 #include "server.h"
 
 #define NETWORK_SERVER_INTERFACE "org.bluez.NetworkServer1"
+#define BNEP_INTERFACE "bnep%d"
 #define SETUP_TIMEOUT		1
 
 /* Pending Authorization */
@@ -347,6 +348,9 @@ static gboolean bnep_setup(GIOChannel *chan,
 		goto reply;
 	}
 
+	strncpy(na->setup->dev, BNEP_INTERFACE, 16);
+	na->setup->dev[15] = '\0';
+
 	if (bnep_server_add(sk, dst_role, ns->bridge, na->setup->dev,
 							&na->setup->dst) < 0)
 		goto reply;
-- 
1.8.3.2

