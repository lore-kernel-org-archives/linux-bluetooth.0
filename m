Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon@janc.net.pl>
Subject: [PATCH] btmgmt: Fix use after free in mgmt_check_pending
Date: Wed,  6 Jun 2012 21:38:23 +0200
Message-Id: <1339011503-28756-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Break loop when pending command was found and callback called.
---
 mgmt/main.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/mgmt/main.c b/mgmt/main.c
index 6e35071..b2d6c3c 100644
--- a/mgmt/main.c
+++ b/mgmt/main.c
@@ -141,6 +141,7 @@ static void mgmt_check_pending(int mgmt_sk, uint16_t op, uint16_t index,
 		c->cb(mgmt_sk, op, index, status, data, len, c->user_data);
 
 		free(c);
+		break;
 	}
 }
 
-- 
1.7.10


