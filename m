Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 01/19] android/bluetooth: Minor typo fix
Date: Wed, 17 Dec 2014 16:48:59 +0100
Message-Id: <1418831357-23100-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418831357-23100-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418831357-23100-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 169f0bf..56405d1 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -5278,7 +5278,7 @@ bool bt_bluetooth_register(struct ipc *ipc, uint8_t mode)
 
 	unpaired_cb_list = queue_new();
 	if (!unpaired_cb_list) {
-		error("Can not allocate queue for unpaired callbacks");
+		error("Cannot allocate queue for unpaired callbacks");
 		return false;
 	}
 
-- 
1.8.4

