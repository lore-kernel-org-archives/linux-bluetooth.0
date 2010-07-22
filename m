Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 06/60] Release MCAP instances
Date: Thu, 22 Jul 2010 10:52:01 +0200
Message-Id: <1279788733-2324-7-git-send-email-sancane@gmail.com>
In-Reply-To: <1279788733-2324-6-git-send-email-sancane@gmail.com>
References: <1279788733-2324-1-git-send-email-sancane@gmail.com>
 <1279788733-2324-2-git-send-email-sancane@gmail.com>
 <1279788733-2324-3-git-send-email-sancane@gmail.com>
 <1279788733-2324-4-git-send-email-sancane@gmail.com>
 <1279788733-2324-5-git-send-email-sancane@gmail.com>
 <1279788733-2324-6-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mcap/mcap.c |   31 ++++++++++++++++++++++++++++++-
 1 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 8551ddf..0bc5035 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -603,5 +603,34 @@ struct mcap_instance *mcap_create_instance(struct btd_adapter *btd_adapter,
 
 void mcap_release_instance(struct mcap_instance *ms)
 {
-	/* TODO */
+	GSList *l;
+
+	if (!ms)
+		return;
+
+	if (ms->ccio) {
+		g_io_channel_shutdown(ms->ccio, TRUE, NULL);
+		g_io_channel_unref(ms->ccio);
+		ms->ccio = NULL;
+	}
+
+	if (ms->dcio) {
+		g_io_channel_shutdown(ms->dcio, TRUE, NULL);
+		g_io_channel_unref(ms->dcio);
+		ms->dcio = NULL;
+	}
+
+	for (l = ms->mcls; l; l = l->next) {
+		mcap_mcl_shutdown(l->data);
+		mcap_mcl_unref(l->data);
+	}
+	g_slist_free(ms->mcls);
+	ms->mcls = NULL;
+
+	for (l = ms->cached; l; l = l->next)
+		mcap_mcl_unref(l->data);
+	g_slist_free(ms->cached);
+	ms->cached = NULL;
+
+	g_free(ms);
 }
-- 
1.6.3.3

