Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Add discovery cases to mgmt_cmd_complete()
Date: Thu,  3 Nov 2011 16:53:59 -0300
Message-Id: <1320350039-25678-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/mgmtops.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index ef49a0d..d4221b8 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1225,6 +1225,12 @@ static void mgmt_cmd_complete(int sk, uint16_t index, void *buf, size_t len)
 	case MGMT_OP_SET_FAST_CONNECTABLE:
 		DBG("set_fast_connectable complete");
 		break;
+	case MGMT_OP_START_DISCOVERY:
+		DBG("start_discovery complete");
+		break;
+	case MGMT_OP_STOP_DISCOVERY:
+		DBG("stop_discovery complete");
+		break;
 	default:
 		error("Unknown command complete for opcode %u", opcode);
 		break;
-- 
1.7.7.1

