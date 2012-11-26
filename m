Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 2/2] formfactor: Remove not needed empty remove callback
Date: Mon, 26 Nov 2012 12:48:44 +0100
Message-ID: <1353930524-22701-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1353930524-22701-1-git-send-email-szymon.janc@tieto.com>
References: <1353930524-22701-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove callback is called only if it is not NULL so there is no need to
register empty callback function.
---
 plugins/formfactor.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/plugins/formfactor.c b/plugins/formfactor.c
index 0e19ac6..1978f03 100644
--- a/plugins/formfactor.c
+++ b/plugins/formfactor.c
@@ -124,14 +124,9 @@ static int formfactor_probe(struct btd_adapter *adapter)
 	return 0;
 }
 
-static void formfactor_remove(struct btd_adapter *adapter)
-{
-}
-
 static struct btd_adapter_driver formfactor_driver = {
 	.name	= "formfactor",
 	.probe	= formfactor_probe,
-	.remove	= formfactor_remove,
 };
 
 static int formfactor_init(void)
-- 
1.7.9.5

