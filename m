Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 3/3] android/gatt: Add info debug to connect function
Date: Sun, 23 Mar 2014 21:20:10 +0100
Message-ID: <1395606010-19807-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1395606010-19807-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1395606010-19807-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Because we handle connect always in "auto connect" mode we want this
info log to give us idea how BLE applications use that.

Also add comment about we handle is_direct in this function.
---
 android/gatt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 5384a72..705a441 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -636,8 +636,15 @@ static void handle_client_connect(const void *buf, uint16_t len)
 	bdaddr_t addr;
 	uint8_t status;
 	bool send_notify = false;
+	char a[18];
 
-	DBG("");
+	/* For now we handle direct connect in the same way as auto.
+	 * connect. This is to avoid issues with broken applications which
+	 * might block HCI by calling connect to device not in range. However
+	 * we can consider later to change that.
+	*/
+	ba2str((bdaddr_t *)&cmd->bdaddr, a);
+	info("gatt: Connect to: %s(is_direct=%d)", a, cmd->is_direct);
 
 	/* Check if client is registered */
 	l = queue_find(gatt_clients, match_client_by_id,
-- 
1.8.4

