Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/6] plugins/policy: Revert patch 96db78604252eeb17614b9982ced95fd66c6c6fc
Date: Thu, 28 Jul 2016 17:27:46 +0300
Message-Id: <1469716070-16506-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1469716070-16506-1-git-send-email-luiz.dentz@gmail.com>
References: <1469716070-16506-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Patch 96db78604252eeb17614b9982ced95fd66c6c6fc actually breaks
iterating to each attempt since the attempt++ is already done in
reconnect_timeout callback.
---
 plugins/policy.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/plugins/policy.c b/plugins/policy.c
index 218a3ed..bbb6961 100644
--- a/plugins/policy.c
+++ b/plugins/policy.c
@@ -685,8 +685,6 @@ static void reconnect_set_timer(struct reconnect_data *reconnect)
 {
 	static int timeout = 0;
 
-	reconnect->attempt++;
-
 	if (reconnect->attempt < reconnect_intervals_len)
 		timeout = reconnect_intervals[reconnect->attempt];
 
-- 
2.7.4

