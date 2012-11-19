Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/4] neard: Use ENONET error when adapter is not enabled
Date: Mon, 19 Nov 2012 16:03:55 +0100
Message-ID: <1353337438-21865-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This results in returning error 'Disabled' instead of 'No such Device'.
Will allow neard to properly set power state of Bluetooth carrier.
---
 plugins/neard.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index 8f8381c..1576be5 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -380,7 +380,7 @@ static int check_adapter(struct btd_adapter *adapter)
 	btd_adapter_get_mode(adapter, NULL, NULL, &pairable);
 
 	if (!pairable || !adapter_get_agent(adapter))
-		return -ENOENT;
+		return -ENONET;
 
 	if (!btd_adapter_ssp_enabled(adapter))
 		return -ENOTSUP;
-- 
1.7.9.5

