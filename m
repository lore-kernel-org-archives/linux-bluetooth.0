Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/5] tools/btgatt-server: Fix sign counter
Date: Wed, 25 Feb 2015 15:42:09 +0200
Message-Id: <1424871733-14610-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The sing counter should be set with the counter received not
incremented by one since the check is for > the counter received may be
bigger than the increment making the counters go out of sync.
---
 tools/btgatt-server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index 09a123c..9eeea3b 100644
--- a/tools/btgatt-server.c
+++ b/tools/btgatt-server.c
@@ -1004,7 +1004,7 @@ static bool remote_counter(uint32_t *sign_cnt, void *user_data)
 	if (*sign_cnt < cnt)
 		return false;
 
-	cnt++;
+	cnt = *sign_cnt;
 
 	return true;
 }
-- 
2.1.0

