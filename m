Return-Path: <cyrus@holtmann.org>
From: Antti Julku <antti.julku@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Antti Julku <antti.julku@nokia.com>
Subject: [PATCH 1/2] Implement fast connectable mode for mgmt interface
Date: Fri, 17 Jun 2011 12:44:13 +0300
Message-Id: <1308303854-2017-1-git-send-email-antti.julku@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Management interface implementation for fast connectable mode.
---
 doc/mgmt-api.txt  |    8 ++++++++
 lib/mgmt.h        |    5 +++++
 plugins/mgmtops.c |   24 +++++++++++++++++++++---
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index d89467c..8bf5e52 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -335,6 +335,14 @@ Unblock Device Command
 	Command Parameters:	Address (6 Octets)
 	Return Parameters:	Status (1 octet)
 
+Set Fast Connectable Command
+============================
+
+        Command Code:           0x0001F
+        Controller Index:       <controller id>
+        Command Parameters:     Enable (1 Octet)
+        Return Parameters:      Status (1 octet)
+
 Read Tracing Buffer Size Command
 ================================
 
diff --git a/lib/mgmt.h b/lib/mgmt.h
index f22434e..95003a2 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -215,6 +215,11 @@ struct mgmt_cp_unblock_device {
 	bdaddr_t bdaddr;
 } __packed;
 
+#define MGMT_OP_SET_FAST_CONNECTABLE	0x001F
+struct mgmt_cp_set_fast_connectable {
+	uint8_t enable;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index d6226c4..b98c995 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1207,6 +1207,9 @@ static void mgmt_cmd_complete(int sk, uint16_t index, void *buf, size_t len)
 	case MGMT_OP_UNBLOCK_DEVICE:
 		DBG("unblock_device complete");
 		break;
+	case MGMT_OP_SET_FAST_CONNECTABLE:
+		DBG("set_fast_connectable complete");
+		break;
 	default:
 		error("Unknown command complete for opcode %u", opcode);
 		break;
@@ -1661,10 +1664,25 @@ static int mgmt_cancel_resolve_name(int index, bdaddr_t *bdaddr)
 	return -ENOSYS;
 }
 
-static int mgmt_fast_connectable(int index, gboolean enable)
+static int mgmt_set_fast_connectable(int index, gboolean enable)
 {
+	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_set_fast_connectable)];
+	struct mgmt_hdr *hdr = (void *) buf;
+	struct mgmt_cp_set_fast_connectable *cp = (void *) &buf[sizeof(*hdr)];
+
 	DBG("index %d enable %d", index, enable);
-	return -ENOSYS;
+
+	memset(buf, 0, sizeof(buf));
+	hdr->opcode = htobs(MGMT_OP_SET_FAST_CONNECTABLE);
+	hdr->len = htobs(sizeof(*cp));
+	hdr->index = htobs(index);
+
+	cp->enable = enable;
+
+	if (write(mgmt_sock, buf, sizeof(buf)) < 0)
+		return -errno;
+
+	return 0;
 }
 
 static int mgmt_read_clock(int index, bdaddr_t *bdaddr, int which, int timeout,
@@ -2056,7 +2074,7 @@ static struct btd_adapter_ops mgmt_ops = {
 	.cancel_resolve_name = mgmt_cancel_resolve_name,
 	.set_name = mgmt_set_name,
 	.set_dev_class = mgmt_set_dev_class,
-	.set_fast_connectable = mgmt_fast_connectable,
+	.set_fast_connectable = mgmt_set_fast_connectable,
 	.read_clock = mgmt_read_clock,
 	.read_bdaddr = mgmt_read_bdaddr,
 	.block_device = mgmt_block_device,
-- 
1.7.2.5

