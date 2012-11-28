Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] adapter: Fix memory leak in convert_config
Date: Wed, 28 Nov 2012 15:59:28 +0100
Message-ID: <1354114768-28937-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

'converted' was not freed if config file was already converted.
---
 src/adapter.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/src/adapter.c b/src/adapter.c
index 163360f..b44eb36 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2698,6 +2698,7 @@ static void convert_config(struct btd_adapter *adapter, const char *filename,
 	if (converted) {
 		if (strcmp(converted, "yes") == 0) {
 			DBG("Legacy config file already converted");
+			g_free(converted);
 			return;
 		}
 
-- 
1.7.9.5

