Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 26/26] Free memory when a unref operation happens over a cached MCL
Date: Fri,  4 Jun 2010 10:27:19 +0200
Message-Id: <1275640039-7245-27-git-send-email-sancane@gmail.com>
In-Reply-To: <1275640039-7245-26-git-send-email-sancane@gmail.com>
References: <1275640039-7245-1-git-send-email-sancane@gmail.com>
 <1275640039-7245-2-git-send-email-sancane@gmail.com>
 <1275640039-7245-3-git-send-email-sancane@gmail.com>
 <1275640039-7245-4-git-send-email-sancane@gmail.com>
 <1275640039-7245-5-git-send-email-sancane@gmail.com>
 <1275640039-7245-6-git-send-email-sancane@gmail.com>
 <1275640039-7245-7-git-send-email-sancane@gmail.com>
 <1275640039-7245-8-git-send-email-sancane@gmail.com>
 <1275640039-7245-9-git-send-email-sancane@gmail.com>
 <1275640039-7245-10-git-send-email-sancane@gmail.com>
 <1275640039-7245-11-git-send-email-sancane@gmail.com>
 <1275640039-7245-12-git-send-email-sancane@gmail.com>
 <1275640039-7245-13-git-send-email-sancane@gmail.com>
 <1275640039-7245-14-git-send-email-sancane@gmail.com>
 <1275640039-7245-15-git-send-email-sancane@gmail.com>
 <1275640039-7245-16-git-send-email-sancane@gmail.com>
 <1275640039-7245-17-git-send-email-sancane@gmail.com>
 <1275640039-7245-18-git-send-email-sancane@gmail.com>
 <1275640039-7245-19-git-send-email-sancane@gmail.com>
 <1275640039-7245-20-git-send-email-sancane@gmail.com>
 <1275640039-7245-21-git-send-email-sancane@gmail.com>
 <1275640039-7245-22-git-send-email-sancane@gmail.com>
 <1275640039-7245-23-git-send-email-sancane@gmail.com>
 <1275640039-7245-24-git-send-email-sancane@gmail.com>
 <1275640039-7245-25-git-send-email-sancane@gmail.com>
 <1275640039-7245-26-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

MCAP should free memory in cached MCL list if an unref operation
happens over a cached MCL and only MCAP has a local copy of it.
MCL is removed from cached list and memory resources are freed.
---
 mcap/mcap.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index d907eca..b2e4946 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -780,6 +780,15 @@ void mcap_mcl_unref(struct mcap_mcl *mcl)
 
 	DBG("mcap_mcl_unref(%p): ref=%d", mcl, mcl->ref);
 
+	if ((mcl->ctrl & MCAP_CTRL_CACHED) && (mcl->ref < 2)) {
+		/* Free space in cache memory due any other profile has a local
+		 * copy of current MCL stored in cache */
+		DBG("Remove from cache (%p): ref=%d", mcl, mcl->ref);
+		mcl->ms->cached = g_slist_remove(mcl->ms->cached, mcl);
+		mcap_mcl_release(mcl);
+		return;
+	}
+
 	if (mcl->ref > 0)
 		return;
 
-- 
1.6.3.3

