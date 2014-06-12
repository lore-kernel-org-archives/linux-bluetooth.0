Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] android/gatt: Set state of pending responses
Date: Thu, 12 Jun 2014 11:08:25 +0200
Message-Id: <1402564106-27044-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1402564106-27044-1-git-send-email-marcin.kraglak@tieto.com>
References: <1402564106-27044-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Set state to PENDING before read. If state was not set to PENDING,
response was sent immediatelly even if there was no response from upper
layer.
---
 android/gatt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 7ae0f55..4c2488f 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4167,6 +4167,8 @@ static void read_requested_attributes(void *data, void *user_data)
 	if (error)
 		goto done;
 
+	resp_data->state = REQUEST_PENDING;
+
 	if (!gatt_db_read(gatt_db, resp_data->handle,
 						resp_data->offset,
 						process_data->opcode,
-- 
1.9.3

