Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/5] adapter: Remove not needed variable from btd_adapter_start
Date: Mon, 19 Nov 2012 16:02:43 +0100
Message-ID: <1353337366-21590-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1353337366-21590-1-git-send-email-szymon.janc@tieto.com>
References: <1353337366-21590-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

address is no longer used and can be removed.
---
 src/adapter.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index d208cfa..8b599da 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2259,9 +2259,6 @@ void adapter_connect_list_remove(struct btd_adapter *adapter,
 void btd_adapter_start(struct btd_adapter *adapter)
 {
 	struct session_req *req;
-	char address[18];
-
-	ba2str(&adapter->bdaddr, address);
 
 	adapter->off_requested = FALSE;
 	adapter->up = TRUE;
-- 
1.7.9.5

