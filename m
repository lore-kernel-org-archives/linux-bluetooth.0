Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 1/2] adaptername: Remove not needed empty remove callback
Date: Mon, 26 Nov 2012 12:48:43 +0100
Message-ID: <1353930524-22701-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove callback is called only if it is not NULL so there is no need to
register empty callback function.
---
 plugins/adaptername.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/plugins/adaptername.c b/plugins/adaptername.c
index 353f11c..2013b7b 100644
--- a/plugins/adaptername.c
+++ b/plugins/adaptername.c
@@ -261,14 +261,9 @@ fail:
 	return FALSE;
 }
 
-static void adaptername_remove(struct btd_adapter *adapter)
-{
-}
-
 static struct btd_adapter_driver adaptername_driver = {
 	.name	= "adaptername",
 	.probe	= adaptername_probe,
-	.remove	= adaptername_remove,
 };
 
 static int adaptername_init(void)
-- 
1.7.9.5

