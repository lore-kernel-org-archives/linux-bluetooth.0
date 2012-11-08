Return-Path: <cyrus@holtmann.org>
From: Sunil Kumar Behera <sunil.behera@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sunil Kumar Behera <sunil.behera@samsung.com>
Subject: [PATCH obexd 3/3] Reset ap_sent variable
Date: Thu, 08 Nov 2012 16:16:14 +0530
Message-id: <1352371574-18110-1-git-send-email-sunil.behera@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For multiple subsequent request for message listing
we need to reset this variable to FALSE. So that each
time the get next header function is executed properly.
---
 plugins/mas.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/mas.c b/plugins/mas.c
index bdf2b6b..459df87 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -162,6 +162,7 @@ static void reset_request(struct mas_session *mas)
 
 	mas->nth_call = FALSE;
 	mas->finished = FALSE;
+	mas->ap_sent = FALSE;
 }
 
 static void mas_clean(struct mas_session *mas)
-- 
1.7.9.5

