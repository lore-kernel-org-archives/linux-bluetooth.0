Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 1/2] Do not increment mdl reference in reconnections
Date: Mon, 22 Nov 2010 09:10:46 +0100
Message-Id: <1290413446-5391-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

diff --git a/health/hdp.c b/health/hdp.c
index 2e06a6b..769e300 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -921,7 +921,8 @@ static void hdp_mcap_mdl_connected_cb(struct mcap_mdl *mdl, void *data)
 		return;
 
 	chan = dev->ndc;
-	chan->mdl = mcap_mdl_ref(mdl);
+	if (!chan->mdl)
+		chan->mdl = mcap_mdl_ref(mdl);
 
 	if (!g_slist_find(dev->channels, chan))
 		dev->channels = g_slist_prepend(dev->channels,
-- 
1.7.3.2

