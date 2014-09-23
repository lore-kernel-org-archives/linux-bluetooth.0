Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH ] attrib: Fix condition check for attr delete
Date: Tue, 23 Sep 2014 17:49:17 +0530
Message-id: <1411474757-22719-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Checks handle value for non-zero as well as >= 0xffff, to avoid
infinite loop and deletion of unspecified attrib handles.
---
 attrib/gatt-service.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/attrib/gatt-service.c b/attrib/gatt-service.c
index 874552b..bcf360e 100644
--- a/attrib/gatt-service.c
+++ b/attrib/gatt-service.c
@@ -295,7 +295,12 @@ static void service_attr_del(struct btd_adapter *adapter, uint16_t start_handle,
 {
 	uint16_t handle;
 
-	for (handle = start_handle; handle <= end_handle; handle++)
+	/* For a 128-bit category primary service below handle should be checked
+	 * for both non-zero as well as >= 0xffff. As on last iteration the handle
+	 * will turn to 0 from 0xffff and loop will be infinite.
+	 */
+
+	for (handle = start_handle; (handle != 0 && handle <= end_handle); handle++)
 		if (attrib_db_del(adapter, handle) < 0)
 			error("Can't delete handle 0x%04x", handle);
 }
-- 
1.9.1

