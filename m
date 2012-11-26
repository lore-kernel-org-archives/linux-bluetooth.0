Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 5/5] formfactor: Remove not needed empty remove callback
Date: Mon, 26 Nov 2012 10:07:40 +0100
Message-ID: <1353920860-14912-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1353920860-14912-1-git-send-email-szymon.janc@tieto.com>
References: <1353920860-14912-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove callback is called only if it is not NULL so there is no need to
register empty callback function.
---
 plugins/formfactor.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/plugins/formfactor.c b/plugins/formfactor.c
index 0e19ac6..41f9c2a 100644
--- a/plugins/formfactor.c
+++ b/plugins/formfactor.c
@@ -124,14 +124,10 @@ static int formfactor_probe(struct btd_adapter *adapter)
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
+	.remove	= NULL,
 };
 
 static int formfactor_init(void)
-- 
1.7.9.5

