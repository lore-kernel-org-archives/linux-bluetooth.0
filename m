Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 02/15] profiles/network: Add appropriate log prefix
Date: Tue,  3 Mar 2015 17:59:46 +0100
Message-Id: <1425401999-21203-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1425401999-21203-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1425401999-21203-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Logs should have appropriate prefixes eg. bnep, pan.
---
 android/pan.c           | 2 +-
 profiles/network/bnep.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index 511f4fd..94f2daf 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -517,7 +517,7 @@ static gboolean nap_setup_cb(GIOChannel *chan, GIOCondition cond,
 
 	if (bnep_server_add(sk, dst_role, BNEP_BRIDGE, dev->iface,
 							&dev->dst) < 0) {
-		error("server_connadd failed");
+		error("pann: server_connadd failed");
 		rsp = BNEP_CONN_NOT_ALLOWED;
 		goto failed;
 	}
diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 3986638..b3c6179 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -509,7 +509,7 @@ static int bnep_add_to_bridge(const char *devname, const char *bridge)
 		error("bnep: Can't add %s to the bridge %s: %s(%d)",
 					devname, bridge, strerror(-err), -err);
 	} else {
-		info("bridge %s: interface %s added", bridge, devname);
+		info("bnep: bridge %s: interface %s added", bridge, devname);
 	}
 
 	close(sk);
@@ -541,7 +541,7 @@ static int bnep_del_from_bridge(const char *devname, const char *bridge)
 		error("bnep: Can't delete %s from the bridge %s: %s(%d)",
 					devname, bridge, strerror(-err), -err);
 	} else {
-		info("bridge %s: interface %s removed", bridge, devname);
+		info("bnep: bridge %s: interface %s removed", bridge, devname);
 	}
 
 	close(sk);
-- 
2.1.0

