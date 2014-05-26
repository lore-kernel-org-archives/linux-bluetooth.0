Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android/gatt: Fix possible memory leak in write request
Date: Mon, 26 May 2014 16:06:22 +0200
Message-Id: <1401113183-6617-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If write cannot be executed, remove data from queue and free
allocated memory.
---
 android/gatt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index e41a69e..721785a 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4969,8 +4969,11 @@ static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,
 	}
 
 	if (!gatt_db_write(gatt_db, handle, 0, value, vlen, cmd[0],
-								&dev->bdaddr))
+								&dev->bdaddr)) {
+		queue_remove(dev->pending_requests, data);
+		free(data);
 		return ATT_ECODE_UNLIKELY;
+	}
 
 	return 0;
 }
-- 
1.9.0

