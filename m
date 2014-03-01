Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/3] android/avrcp-lib: Fix not freeing tx buffer on AVRCP shutdown
Date: Sat,  1 Mar 2014 20:04:17 +0100
Message-Id: <1393700658-14323-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1393700658-14323-1-git-send-email-szymon.janc@tieto.com>
References: <1393700658-14323-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/avrcp-lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index e71f95c..feab303 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -126,6 +126,7 @@ void avrcp_shutdown(struct avrcp *session)
 		avctp_shutdown(session->conn);
 	}
 
+	g_free(session->tx_buf);
 	g_free(session);
 }
 
-- 
1.8.5.3

