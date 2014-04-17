Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 3/5] android/gatt: Add support for reliable write
Date: Thu, 17 Apr 2014 13:57:46 +0200
Message-Id: <1397735868-19092-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1397735868-19092-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1397735868-19092-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch add support for reliable write
---
 android/gatt.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index e339789..281f520 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -2294,6 +2294,11 @@ static void handle_client_write_characteristic(const void *buf, uint16_t len)
 	}
 
 	switch (cmd->write_type) {
+	case GATT_WRITE_TYPE_PREPARE:
+		res = gatt_reliable_write_char(dev->attrib, ch->ch.value_handle,
+							cmd->value, cmd->len,
+							write_char_cb, cb_data);
+		break;
 	case GATT_WRITE_TYPE_DEFAULT:
 		res = gatt_write_char(dev->attrib, ch->ch.value_handle,
 							cmd->value, cmd->len,
@@ -2593,6 +2598,12 @@ static void handle_client_write_descriptor(const void *buf, uint16_t len)
 	}
 
 	switch (cmd->write_type) {
+	case GATT_WRITE_TYPE_PREPARE:
+		res = gatt_reliable_write_char(dev->attrib, descr->handle,
+							cmd->value, cmd->len,
+							write_descr_cb,
+							cb_data);
+		break;
 	case GATT_WRITE_TYPE_DEFAULT:
 		res = gatt_write_char(dev->attrib, descr->handle, cmd->value,
 					cmd->len, write_descr_cb, cb_data);
-- 
1.8.4

