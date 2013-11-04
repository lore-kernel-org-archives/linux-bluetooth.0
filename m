Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH] android/client: Change interface name to bluetooth
Date: Mon, 4 Nov 2013 12:29:39 +0100
Message-ID: <1383564579-32025-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This changes 'adapter' to 'bluetooth' as name of HAL interface.
This name matches name fond in bluetooth.h where all interfaces
are defined.
---
 android/client/if-bt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index fb1b3f3..4c501a5 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -777,6 +777,6 @@ static struct method methods[] = {
 };
 
 const struct interface bluetooth_if = {
-	.name = "adapter",
+	.name = "bluetooth",
 	.methods = methods
 };
-- 
1.7.9.5

