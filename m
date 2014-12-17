Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 02/19] android/bluetooth: Minor fix, add missing NULL assignment
Date: Wed, 17 Dec 2014 16:49:00 +0100
Message-Id: <1418831357-23100-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418831357-23100-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418831357-23100-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 56405d1..3d60a49 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -5348,6 +5348,8 @@ bool bt_bluetooth_register(struct ipc *ipc, uint8_t mode)
 
 failed:
 	queue_destroy(unpaired_cb_list, NULL);
+	unpaired_cb_list = NULL;
+
 	return false;
 }
 
-- 
1.8.4

