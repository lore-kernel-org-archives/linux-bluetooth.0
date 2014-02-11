Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 5/6] shared: Add support for local disconnect to HFP
Date: Tue, 11 Feb 2014 17:49:05 +0100
Message-Id: <1392137346-26272-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1392137346-26272-1-git-send-email-szymon.janc@tieto.com>
References: <1392137346-26272-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to locally trigger disconnection.
---
 src/shared/hfp.c | 8 ++++++++
 src/shared/hfp.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 3944e97..2c793f9 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -445,3 +445,11 @@ bool hfp_gw_set_disconnect_handler(struct hfp_gw *hfp,
 
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
index 75ec484..5a86dfe 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -92,3 +92,5 @@ bool hfp_gw_set_disconnect_handler(struct hfp_gw *hfp,
 					hfp_disconnect_func_t callback,
 					void *user_data,
 					hfp_destroy_func_t destroy);
+
+bool hfp_gw_disconnect(struct hfp_gw *hfp);
-- 
1.8.5.3

