Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/5] adaptername: Remove not needed empty remove callback
Date: Mon, 26 Nov 2012 10:07:39 +0100
Message-ID: <1353920860-14912-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1353920860-14912-1-git-send-email-szymon.janc@tieto.com>
References: <1353920860-14912-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove callback is called only if it is not NULL so there is no need to
register empty callback function.
---
 plugins/adaptername.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/plugins/adaptername.c b/plugins/adaptername.c
index 353f11c..745238a 100644
--- a/plugins/adaptername.c
+++ b/plugins/adaptername.c
@@ -261,14 +261,10 @@ fail:
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
+	.remove	= NULL,
 };
 
 static int adaptername_init(void)
-- 
1.7.9.5

