Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 01/15] android/pan: Fix removing PAN NAP bridge
Date: Tue,  3 Mar 2015 17:59:45 +0100
Message-Id: <1425401999-21203-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PAN NAP bridge shouldn't be removed if bnep server add fails. Pan device
remove function is decreasing amount of connected devices, if count will
be zero - NAP bridge will be removed.
---
 android/pan.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/android/pan.c b/android/pan.c
index 972af89..511f4fd 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -517,7 +517,6 @@ static gboolean nap_setup_cb(GIOChannel *chan, GIOCondition cond,
 
 	if (bnep_server_add(sk, dst_role, BNEP_BRIDGE, dev->iface,
 							&dev->dst) < 0) {
-		nap_remove_bridge();
 		error("server_connadd failed");
 		rsp = BNEP_CONN_NOT_ALLOWED;
 		goto failed;
-- 
2.1.0

