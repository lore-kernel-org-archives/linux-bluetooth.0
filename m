Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] mgmtops: Add CANCEL_PAIR_DEVICE command complete handling
Date: Wed, 29 Feb 2012 15:57:15 -0400
Message-Id: <1330545435-2770-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This avoids the "Unknown command complete for opcode 26" error.
---
 plugins/mgmtops.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 95fbe8b..42a8a1f 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1326,6 +1326,9 @@ static void mgmt_cmd_complete(int sk, uint16_t index, void *buf, size_t len)
 	case MGMT_OP_LOAD_LINK_KEYS:
 		DBG("load_link_keys complete");
 		break;
+	case MGMT_OP_CANCEL_PAIR_DEVICE:
+		DBG("cancel_pair_device complete");
+		break;
 	case MGMT_OP_UNPAIR_DEVICE:
 		DBG("unpair_device complete");
 		break;
-- 
1.7.5.4

