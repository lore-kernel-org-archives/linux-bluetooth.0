Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 4/4] hdp.c: Fix memory leak aborting data channel connections
Date: Wed, 14 Dec 2011 11:11:52 +0100
Message-Id: <1323857512-5626-4-git-send-email-sancane@gmail.com>
In-Reply-To: <1323857512-5626-3-git-send-email-sancane@gmail.com>
References: <1323857512-5626-1-git-send-email-sancane@gmail.com>
 <1323857512-5626-2-git-send-email-sancane@gmail.com>
 <1323857512-5626-3-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use GDestroyNotify function to decrease the reference counter of
the data channel provided in the callback when abort operation is
invoked in MCAP.
---
 health/hdp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index cf6ec76..db715f5 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -1780,8 +1780,8 @@ fail:
 	/* Send abort request because remote side is now in PENDING */
 	/* state. Then we have to delete it because we couldn't */
 	/* register the HealthChannel interface */
-	if (!mcap_mdl_abort(mdl, abort_and_del_mdl_cb, mcap_mdl_ref(mdl), NULL,
-								&gerr)) {
+	if (!mcap_mdl_abort(mdl, abort_and_del_mdl_cb, mcap_mdl_ref(mdl),
+				(GDestroyNotify) mcap_mdl_unref, &gerr)) {
 		error("%s", gerr->message);
 		g_error_free(gerr);
 		mcap_mdl_unref(mdl);
-- 
1.7.8

