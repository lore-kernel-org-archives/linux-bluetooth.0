Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v4 01/10] shared/att: Guard against invalid ref in callbacks
Date: Tue, 16 Dec 2014 18:07:09 -0800
Message-Id: <1418782038-10999-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1418782038-10999-1-git-send-email-armansito@chromium.org>
References: <1418782038-10999-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a ref-count guard around incoming PDU handling so that
calling bt_att_unref from a callback doesn't free the bt_att instance.
---
 src/shared/att.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/shared/att.c b/src/shared/att.c
index a5bf244..4be0652 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -722,6 +722,8 @@ static bool can_read_data(struct io *io, void *user_data)
 	pdu = att->buf;
 	opcode = pdu[0];
 
+	bt_att_ref(att);
+
 	/* Act on the received PDU based on the opcode type */
 	switch (get_op_type(opcode)) {
 	case ATT_OP_TYPE_RSP:
@@ -745,6 +747,7 @@ static bool can_read_data(struct io *io, void *user_data)
 					"Received request while another is "
 					"pending: 0x%02x", opcode);
 			io_shutdown(att->io);
+			bt_att_unref(att);
 
 			return false;
 		}
@@ -766,6 +769,8 @@ static bool can_read_data(struct io *io, void *user_data)
 		break;
 	}
 
+	bt_att_unref(att);
+
 	return true;
 }
 
-- 
2.2.0.rc0.207.ga3a616c

