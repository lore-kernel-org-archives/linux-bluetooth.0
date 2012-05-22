Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/5] AVCTP: Fix setting wrong transaction id expected for responses
Date: Tue, 22 May 2012 17:00:51 +0300
Message-Id: <1337695255-9197-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The id were incremented after being set to the request so it is always
+1 of the actual transaction.
---
 audio/avctp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index d98d097..f2d5954 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -981,7 +981,7 @@ int avctp_send_vendordep_req(struct avctp *session, uint8_t code,
 	struct avctp_rsp_handler *handler;
 	int err;
 
-	err = avctp_send(session, id++, AVCTP_COMMAND, code, subunit,
+	err = avctp_send(session, ++id, AVCTP_COMMAND, code, subunit,
 				AVC_OP_VENDORDEP, operands, operand_count);
 	if (err < 0)
 		return err;
-- 
1.7.7.6

