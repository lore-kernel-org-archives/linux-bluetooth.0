Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 02/25] android/bluetooth: Minor fix, add missing NULL assignment
Date: Tue,  9 Dec 2014 16:11:24 +0100
Message-Id: <1418137907-16981-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index ddd3a7b..5652d82 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -5300,6 +5300,8 @@ bool bt_bluetooth_register(struct ipc *ipc, uint8_t mode)
 
 failed:
 	queue_destroy(unpaired_cb_list, NULL);
+	unpaired_cb_list = NULL;
+
 	return false;
 }
 
-- 
1.8.4

