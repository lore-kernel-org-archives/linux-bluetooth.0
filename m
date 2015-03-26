Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  7/7] shared/gatt-client: Add const qualifier to prepare write
 value
Date: Thu, 26 Mar 2015 18:29:12 +0530
Message-id: <1427374752-26053-8-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1427374752-26053-1-git-send-email-gowtham.ab@samsung.com>
References: <1427374752-26053-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For all GATT write operation, value remains constant throughout the
transaction. All bt_gatt_client_write procedure in
src/shared/gatt-client.h follows this convention.
Tested in ubuntu.
---
 src/shared/gatt-client.c | 2 +-
 src/shared/gatt-client.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 729bd87..056f812 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -2703,7 +2703,7 @@ static struct request *get_reliable_request(struct bt_gatt_client *client,
 
 unsigned int bt_gatt_client_prepare_write(struct bt_gatt_client *client,
 				unsigned int id, uint16_t value_handle,
-				uint16_t offset, uint8_t *value,
+				uint16_t offset, const uint8_t *value,
 				uint16_t length,
 				bt_gatt_client_write_long_callback_t callback,
 				void *user_data,
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index 8e5e0f5..b816cc4 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -111,7 +111,7 @@ unsigned int bt_gatt_client_write_long_value(struct bt_gatt_client *client,
 unsigned int bt_gatt_client_prepare_write(struct bt_gatt_client *client,
 				unsigned int id,
 				uint16_t value_handle, uint16_t offset,
-				uint8_t *value, uint16_t length,
+				const uint8_t *value, uint16_t length,
 				bt_gatt_client_write_long_callback_t callback,
 				void *user_data,
 				bt_gatt_client_destroy_func_t destroy);
-- 
1.9.1

