Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 6/7] shared: Add support for local disconnect to HFP
Date: Sat, 22 Feb 2014 22:09:24 +0100
Message-Id: <1393103365-19908-6-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1393103365-19908-1-git-send-email-szymon.janc@gmail.com>
References: <1393103365-19908-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@tieto.com>

This allows to locally trigger disconnection.
---
 src/shared/hfp.c | 8 ++++++++
 src/shared/hfp.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 98408ca..854cf46 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -455,3 +455,11 @@ bool hfp_gw_set_disconnect_handler(struct hfp_gw *hfp,
 
 	return true;
 }
+
+bool hfp_gw_disconnect(struct hfp_gw *hfp)
+{
+	if (!hfp)
+		return false;
+
+	return io_shutdown(hfp->io);
+}
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index 6bb51bc..b0bd934 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -92,3 +92,5 @@ bool hfp_gw_set_disconnect_handler(struct hfp_gw *hfp,
 					hfp_disconnect_func_t callback,
 					void *user_data,
 					hfp_destroy_func_t destroy);
+
+bool hfp_gw_disconnect(struct hfp_gw *hfp);
-- 
1.9.0

