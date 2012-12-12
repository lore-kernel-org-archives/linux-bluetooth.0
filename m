Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 02/16] a2dp: Remove useless return
Date: Wed, 12 Dec 2012 11:27:54 +0100
Message-ID: <1355308088-9080-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
References: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This code does nothing.
---
 profiles/audio/a2dp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 8e9f626..aef998a 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1257,9 +1257,6 @@ void a2dp_unregister(const bdaddr_t *src)
 		remove_record_from_server(server->sink_record_id);
 
 	g_free(server);
-
-	if (servers)
-		return;
 }
 
 struct a2dp_sep *a2dp_add_sep(const bdaddr_t *src, uint8_t type,
-- 
1.8.0

