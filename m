Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4 5/7] shared/gatt-client: Add coexistence of long write and prepare write
Date: Mon,  9 Mar 2015 09:23:20 +0100
Message-Id: <1425889402-9123-6-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1425889402-9123-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1425889402-9123-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch makes sure that long write is not proceeded when prepare
write has been called. Instead long write commands will be queued and
once write execute command is done, queued long write requests will
be proceeded.

It does not work in other way. Meaning, when long write is ongoing,
prepare write will not be proceeded nor queued. This feature can be
added later on if really needed.
---
 src/shared/gatt-client.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 30fa883..7b5c232 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -110,6 +110,7 @@ struct bt_gatt_client {
 struct request {
 	struct bt_gatt_client *client;
 	bool long_write;
+	bool prep_write;
 	bool removed;
 	int ref_count;
 	unsigned int id;
@@ -2566,7 +2567,7 @@ unsigned int bt_gatt_client_write_long_value(struct bt_gatt_client *client,
 	req->destroy = long_write_op_free;
 	req->long_write = true;
 
-	if (client->in_long_write) {
+	if (client->in_long_write || client->reliable_write_session_id > 0) {
 		queue_push_tail(client->long_write_queue, req);
 		return req->id;
 	}
@@ -2726,6 +2727,7 @@ unsigned int bt_gatt_client_prepare_write(struct bt_gatt_client *client,
 	op->destroy = destroy;
 
 	req->destroy = destroy_prep_write_op;
+	req->prep_write = true;
 
 	put_le16(value_handle, pdu);
 	put_le16(offset, pdu + 2);
-- 
1.8.4

