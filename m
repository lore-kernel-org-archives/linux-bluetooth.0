Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot Nemesio <sancane@gmail.com>
Subject: [PATCH 08/25] Profiles using MCAP can close a MCL deciding if it should be cached
Date: Mon, 10 May 2010 12:15:10 +0200
Message-Id: <1273486527-7855-8-git-send-email-sancane@gmail.com>
In-Reply-To: <1273486527-7855-7-git-send-email-sancane@gmail.com>
References: <1273486527-7855-1-git-send-email-sancane@gmail.com>
 <1273486527-7855-2-git-send-email-sancane@gmail.com>
 <1273486527-7855-3-git-send-email-sancane@gmail.com>
 <1273486527-7855-4-git-send-email-sancane@gmail.com>
 <1273486527-7855-5-git-send-email-sancane@gmail.com>
 <1273486527-7855-6-git-send-email-sancane@gmail.com>
 <1273486527-7855-7-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Santiago Carot Nemesio <sancane@gmail.com>

---
 mcap/mcap.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 0112154..8f6fb78 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -305,6 +305,23 @@ static void mcap_uncache_mcl(struct mcap_mcl *mcl)
 	mcl->ctrl &= ~MCAP_CTRL_FREE;
 }
 
+void mcap_close_mcl(struct mcap_mcl *mcl, gboolean cache)
+{
+	if (!mcl)
+		return;
+
+	if (mcl->cc) {
+		g_io_channel_shutdown(mcl->cc, TRUE, NULL);
+		g_io_channel_unref(mcl->cc);
+		mcl->cc = NULL;
+	}
+
+	mcl->state = MCL_IDLE;
+
+	if (!cache)
+		mcl->ctrl |= MCAP_CTRL_NOCACHE;
+}
+
 struct mcap_mcl *mcap_mcl_ref(struct mcap_mcl *mcl)
 {
 	mcl->ref++;
-- 
1.6.3.3

