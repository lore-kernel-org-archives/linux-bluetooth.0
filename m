Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jos=C3=A9=20Antonio=20Santos-Cadenas?=
	<santoscadenas@gmail.com>
Subject: [PATCH 26/60] Free memory when a unref operation happens over a cached MCL
Date: Thu, 22 Jul 2010 10:56:19 +0200
Message-Id: <1279789001-4587-8-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1279789001-4587-7-git-send-email-santoscadenas@gmail.com>
References: <1279788733-2324-19-git-send-email-sancane@gmail.com>
 <1279789001-4587-1-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-2-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-3-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-4-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-5-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-6-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-7-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: José Antonio Santos-Cadenas <santoscadenas@gmail.com>

MCAP should free memory in cached MCL list if an unref operation
happens over a cached MCL and only MCAP has a local copy of it.
MCL is removed from cached list and memory resources are freed.
---
 mcap/mcap.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index a32511e..43b215b 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -779,6 +779,15 @@ void mcap_mcl_unref(struct mcap_mcl *mcl)
 
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

