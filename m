Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH] android/client: Fix uninitialized variable
Date: Mon, 4 Nov 2013 10:55:40 +0100
Message-ID: <1383558940-18520-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Pin accept variable was intended to be set to 1
only when pin was typed by user. If no pin was given
accept should be set to 0. This patch fixes this.
---
 android/client/if-bt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 43e8788..fb1b3f3 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -605,7 +605,7 @@ static void pin_reply_p(int argc, const char **argv)
 	bt_bdaddr_t addr;
 	bt_pin_code_t pin;
 	int pin_len = 0;
-	int accept;
+	int accept = 0;
 
 	RETURN_IF_NULL(if_bluetooth);
 	VERIFY_ADDR_ARG(2, &addr);
-- 
1.7.9.5

