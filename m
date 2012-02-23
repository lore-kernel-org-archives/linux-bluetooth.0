Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 2/2] mgmtops: Add SET_LE/SET_SSP command complete handling
Date: Thu, 23 Feb 2012 11:58:27 -0400
Message-Id: <1330012707-32536-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1330012707-32536-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1330012707-32536-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This avoids "Unknown command complete for opcode <nn>" errors.
---
 plugins/mgmtops.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 91b4a22..84d9adc 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1185,6 +1185,12 @@ static void mgmt_cmd_complete(int sk, uint16_t index, void *buf, size_t len)
 	case MGMT_OP_SET_PAIRABLE:
 		mgmt_new_settings(sk, index, ev->data, len);
 		break;
+	case MGMT_OP_SET_SSP:
+		DBG("set_ssp complete");
+		break;
+	case MGMT_OP_SET_LE:
+		DBG("set_le complete");
+		break;
 	case MGMT_OP_ADD_UUID:
 		DBG("add_uuid complete");
 		break;
-- 
1.7.5.4

