Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ] attrib-server: Fix sending "not supported" for indications/notifications
Date: Wed, 14 Mar 2012 19:07:40 -0300
Message-Id: <1331762860-6987-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now that our Attribute Client is able to handle notifications and
indications we don't need to respond that they are not supported.
---
 src/attrib-server.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 6268fe4..5775861 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -981,6 +981,10 @@ static void channel_handler(const uint8_t *ipdu, uint16_t len,
 		break;
 	case ATT_OP_HANDLE_CNF:
 		return;
+	case ATT_OP_HANDLE_IND:
+	case ATT_OP_HANDLE_NOTIFY:
+		/* The attribute client is already handling these */
+		return;
 	case ATT_OP_READ_MULTI_REQ:
 	case ATT_OP_PREP_WRITE_REQ:
 	case ATT_OP_EXEC_WRITE_REQ:
-- 
1.7.9.3

