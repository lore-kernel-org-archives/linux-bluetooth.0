Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
	<lukasz.rymanowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
	<lukasz.rymanowski@codecoup.pl>
Subject: [PATCH v2 07/11] shared/gatt-server: Fix handle error on execute write
Date: Fri, 27 Nov 2015 12:11:46 +0100
Message-Id: <1448622711-17562-8-git-send-email-lukasz.rymanowski@codecoup.pl>
In-Reply-To: <1448622711-17562-1-git-send-email-lukasz.rymanowski@codecoup.pl>
References: <1448622711-17562-1-git-send-email-lukasz.rymanowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If there is an error during execute write we should drop all
outstanding prep_write data. This patch fix that.
---
 src/shared/gatt-server.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index a32aeb1..49dced9 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -1204,6 +1204,9 @@ static void exec_next_prep_write(struct bt_gatt_server *server,
 	err = BT_ATT_ERROR_UNLIKELY;
 
 error:
+	queue_remove_all(server->prep_queue, NULL, NULL,
+						prep_write_data_destroy);
+
 	bt_att_send_error_rsp(server->att, BT_ATT_OP_EXEC_WRITE_REQ,
 								ehandle, err);
 }
@@ -1248,6 +1251,8 @@ static void exec_write_cb(uint8_t opcode, const void *pdu,
 	return;
 
 error:
+	queue_remove_all(server->prep_queue, NULL, NULL,
+						prep_write_data_destroy);
 	bt_att_send_error_rsp(server->att, opcode, 0, ecode);
 }
 
-- 
2.5.0

