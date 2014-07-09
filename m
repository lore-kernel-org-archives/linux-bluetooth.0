Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/gatt: Set need_resp flag in when received PREP_WRITE_REQ
Date: Wed,  9 Jul 2014 10:53:53 +0200
Message-Id: <1404896033-17337-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1404896033-17337-1-git-send-email-marcin.kraglak@tieto.com>
References: <1404896033-17337-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Set need_resp flag if pepare write request have been received.
This is needed because application should send response to stack.
---
 android/gatt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index cccf23e..ef831ad 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4580,7 +4580,10 @@ static void write_cb(uint16_t handle, uint16_t offset,
 	ev->trans_id = transaction->id;
 
 	ev->is_prep = att_opcode == ATT_OP_PREP_WRITE_REQ;
-	ev->need_rsp = att_opcode == ATT_OP_WRITE_REQ;
+
+	if (att_opcode == ATT_OP_WRITE_REQ ||
+					att_opcode == ATT_OP_PREP_WRITE_REQ)
+		ev->need_rsp = true;
 
 	ev->length = len;
 	memcpy(ev->value, value, len);
-- 
1.9.3

