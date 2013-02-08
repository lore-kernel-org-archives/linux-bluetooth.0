Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] adapter: Fix registering adapter with no address
Date: Fri, 8 Feb 2013 11:03:13 +0100
Message-ID: <1360317793-2015-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

adapter->bdaddr is set later in read_info_complete and current check
always returns false. Check against bdaddr received in command response
instead and fail if it is all zeros.
---
 src/adapter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 9ddd2fc..5165bed 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5727,7 +5727,7 @@ static void read_info_complete(uint8_t status, uint16_t length,
 		goto failed;
 	}
 
-	if (bacmp(&adapter->bdaddr, BDADDR_ANY)) {
+	if (bacmp(&rp->bdaddr, BDADDR_ANY) == 0) {
 		error("No Bluetooth address for index %u", adapter->dev_id);
 		goto failed;
 	}
-- 
1.8.1.1

