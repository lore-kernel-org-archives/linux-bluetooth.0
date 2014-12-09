Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 01/25] android/bluetooth: Minor typo fix
Date: Tue,  9 Dec 2014 16:11:23 +0100
Message-Id: <1418137907-16981-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index ca3dd24..ddd3a7b 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -5230,7 +5230,7 @@ bool bt_bluetooth_register(struct ipc *ipc, uint8_t mode)
 
 	unpaired_cb_list = queue_new();
 	if (!unpaired_cb_list) {
-		error("Can not allocate queue for unpaired callbacks");
+		error("Cannot allocate queue for unpaired callbacks");
 		return false;
 	}
 
-- 
1.8.4

