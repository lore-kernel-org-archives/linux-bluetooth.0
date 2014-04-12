Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	claudio.takahasi@openbossa.org, anderson.lizardo@openbossa.org,
	armansito@chromium.org,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 06/10] android/gatt: Fix error msg
Date: Sun, 13 Apr 2014 00:00:27 +0200
Message-Id: <1397340031-29711-7-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1397340031-29711-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1397340031-29711-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 9d45968..523a141 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -2076,7 +2076,7 @@ static void handle_client_write_characteristic(const void *buf, uint16_t len)
 
 	if (!gatt_write_char(dev->attrib, ch->ch.value_handle, cmd->value,
 					cmd->len, write_char_cb, cb_data)) {
-		error("gatt: Cannot read characteristic with inst_id: %d",
+		error("gatt: Cannot write characteristic with inst_id: %d",
 							cmd->gatt_id.inst_id);
 		status = HAL_STATUS_FAILED;
 		free(cb_data);
-- 
1.8.4

