Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 3/5] shared/gatt: Add bt_send_att_with_id functions
Date: Mon, 15 Dec 2014 10:59:05 +0100
Message-Id: <1418637547-20848-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418637547-20848-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418637547-20848-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch it is possible to send ATT request with a given id
request. It might be useful for ATT user for example to keep track of
the GATT request which requires more then one ATT request e.g. search
services
---
 src/shared/att.c | 26 ++++++++++++++++++++++++++
 src/shared/att.h |  6 ++++++
 2 files changed, 32 insertions(+)

diff --git a/src/shared/att.c b/src/shared/att.c
index 2a131e0..f51f893 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -1083,6 +1083,32 @@ static unsigned int send_att(struct bt_att *att, struct att_send_op *op)
 	return op->id;
 }
 
+unsigned int bt_att_send_with_id(struct bt_att *att, unsigned int id,
+					uint8_t opcode, const void *pdu,
+					uint16_t length,
+					bt_att_response_func_t callback,
+					void *user_data,
+					bt_att_destroy_func_t destroy)
+{
+	struct att_send_op *op;
+
+	if (!att || !att->io)
+		return 0;
+
+	op = create_att_send_op(opcode, pdu, length, att->mtu, callback,
+							user_data, destroy);
+	if (!op)
+		return 0;
+
+	/*
+	 * TODO: Some verification might be needed here. For now we
+	 * believe that user know what he is doing.
+	 */
+	op->id = id;
+
+	return send_att(att, op);
+}
+
 unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
 				const void *pdu, uint16_t length,
 				bt_att_response_func_t callback,
diff --git a/src/shared/att.h b/src/shared/att.h
index 99b5a5b..1210ddc 100644
--- a/src/shared/att.h
+++ b/src/shared/att.h
@@ -60,6 +60,12 @@ unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
 					bt_att_response_func_t callback,
 					void *user_data,
 					bt_att_destroy_func_t destroy);
+unsigned int bt_att_send_with_id(struct bt_att *att, unsigned int id,
+					uint8_t opcode, const void *pdu,
+					uint16_t length,
+					bt_att_response_func_t callback,
+					void *user_data,
+					bt_att_destroy_func_t destroy);
 bool bt_att_cancel(struct bt_att *att, unsigned int id);
 bool bt_att_cancel_all(struct bt_att *att);
 
-- 
1.8.4

