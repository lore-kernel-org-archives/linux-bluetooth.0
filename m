Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	claudio.takahasi@openbossa.org, anderson.lizardo@openbossa.org,
	armansito@chromium.org,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 08/10] android/gatt: Add support for reliable write
Date: Sun, 13 Apr 2014 00:00:29 +0200
Message-Id: <1397340031-29711-9-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1397340031-29711-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1397340031-29711-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch add support for reliable write
---
 android/gatt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index c98a4f1..e5da1b2 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -55,6 +55,7 @@
 #define GATT_FAILURE	0x00000101
 
 #define GATT_WRITE_DEFAULT	0x02
+#define GATT_WRITE_RELIABLE	0x03
 
 struct gatt_client {
 	int32_t id;
@@ -2078,6 +2079,11 @@ static void handle_client_write_characteristic(const void *buf, uint16_t len)
 	}
 
 	switch (cmd->write_type) {
+	case GATT_WRITE_RELIABLE:
+		res = gatt_reliable_write_char(dev->attrib, ch->ch.value_handle,
+							cmd->value, cmd->len,
+							write_char_cb, cb_data);
+		break;
 	case GATT_WRITE_DEFAULT:
 		res = gatt_write_char(dev->attrib, ch->ch.value_handle,
 							cmd->value, cmd->len,
@@ -2377,6 +2383,12 @@ static void handle_client_write_descriptor(const void *buf, uint16_t len)
 	}
 
 	switch (cmd->write_type) {
+	case GATT_WRITE_RELIABLE:
+		res = gatt_reliable_write_char(dev->attrib, descr->handle,
+							cmd->value, cmd->len,
+							write_descr_cb,
+							cb_data);
+		break;
 	case GATT_WRITE_DEFAULT:
 		res = gatt_write_char(dev->attrib, descr->handle, cmd->value,
 					cmd->len, write_descr_cb, cb_data);
-- 
1.8.4

