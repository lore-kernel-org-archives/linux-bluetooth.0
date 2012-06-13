Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] mgmtops: Move error message after command status handlers calls
Date: Wed, 13 Jun 2012 16:03:53 +0200
Message-ID: <1339596233-16643-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1339596233-16643-1-git-send-email-szymon.janc@tieto.com>
References: <1339596233-16643-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Don't print error message for actions that are expected or recoverable
i.e. add_uuid returning EBUSY status.
---
 plugins/mgmtops.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 4ce3ee4..ea1552d 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1470,19 +1470,21 @@ static void mgmt_cmd_status(int sk, uint16_t index, void *buf, size_t len)
 		return;
 	}
 
-	error("hci%u: %s (0x%04x) failed: %s (0x%02x)", index,
-			mgmt_opstr(opcode), opcode, mgmt_errstr(ev->status),
-			ev->status);
-
 	switch (opcode) {
 	case MGMT_OP_READ_LOCAL_OOB_DATA:
 		read_local_oob_data_failed(sk, index);
 		break;
 	case MGMT_OP_ADD_UUID:
-		if (ev->status == MGMT_STATUS_BUSY)
+		if (ev->status == MGMT_STATUS_BUSY) {
 			mgmt_add_uuid_busy(sk, index);
+			return;
+		}
 		break;
 	}
+
+	error("hci%u: %s (0x%04x) failed: %s (0x%02x)", index,
+			mgmt_opstr(opcode), opcode, mgmt_errstr(ev->status),
+			ev->status);
 }
 
 static void mgmt_controller_error(int sk, uint16_t index, void *buf, size_t len)
-- 
on behalf of ST-Ericsson

