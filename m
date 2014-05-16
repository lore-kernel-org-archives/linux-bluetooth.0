Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] android/gatt: Set length to READ_INIT before read request
Date: Fri, 16 May 2014 10:37:38 +0200
Message-Id: <1400229459-21617-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1400229459-21617-1-git-send-email-marcin.kraglak@tieto.com>
References: <1400229459-21617-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is needed while we pass read request to framework.
---
 android/gatt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 2a2e649..f2fd17d 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4337,6 +4337,7 @@ static uint8_t read_by_type(const uint8_t *cmd, uint16_t cmd_len,
 			return ATT_ECODE_INSUFF_RESOURCES;
 		}
 
+		data->length = READ_INIT;
 		data->handle = handle;
 		queue_push_tail(device->pending_requests, data);
 	}
@@ -4550,6 +4551,7 @@ static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
 			return ATT_ECODE_INSUFF_RESOURCES;
 		}
 
+		data->length = READ_INIT;
 		data->handle = handle;
 		data->filter_vlen = search_vlen;
 		memcpy(data->filter_value, search_value, search_vlen);
-- 
1.9.0

