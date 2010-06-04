Return-Path: <cyrus@holtmann.org>
From: Zhu Yanhai <yanhai.zhu@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Zhu Yanhai <yanhai.zhu@linux.intel.com>
Subject: [PATCH] gateway_server_remove should unref audio_adapter
Date: Fri,  4 Jun 2010 16:19:58 +0800
Message-Id: <1275639598-22048-1-git-send-email-yanhai.zhu@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

gateway_server_remove should unrefer the adapter, not refer it.

Signed-off-by: Zhu Yanhai <yanhai.zhu@linux.intel.com>
---
 audio/manager.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/manager.c b/audio/manager.c
index 28fd8af..f6a98cd 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -932,7 +932,7 @@ static void gateway_server_remove(struct btd_adapter *adapter)
 		adp->hfp_hs_server = NULL;
 	}
 
-	audio_adapter_ref(adp);
+	audio_adapter_unref(adp);
 }
 
 static int a2dp_server_probe(struct btd_adapter *adapter)
-- 
1.6.2.2

