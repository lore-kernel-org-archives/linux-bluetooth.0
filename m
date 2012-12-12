Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 01/16] a2dp: Remove bogus '\' at the end of line
Date: Wed, 12 Dec 2012 11:27:53 +0100
Message-ID: <1355308088-9080-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
References: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/audio/a2dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 177f653..8e9f626 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1337,7 +1337,7 @@ struct a2dp_sep *a2dp_add_sep(const bdaddr_t *src, uint8_t type,
 	}
 
 	if (add_record_to_server(&server->src, record) < 0) {
-		error("Unable to register A2DP service record");\
+		error("Unable to register A2DP service record");
 		sdp_record_free(record);
 		avdtp_unregister_sep(sep->lsep);
 		g_free(sep);
-- 
1.8.0

