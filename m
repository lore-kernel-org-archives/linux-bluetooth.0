Return-Path: <cyrus@holtmann.org>
From: Antti Julku <antti.julku@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Antti Julku <antti.julku@nokia.com>
Subject: [PATCH 1/2] Implement fast connectable mode for mgmt interface
Date: Thu, 16 Jun 2011 14:55:20 +0300
Message-Id: <1308225321-15910-1-git-send-email-antti.julku@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Management interface implementation for fast connectable mode.
---
 doc/mgmt-api.txt  |    8 ++++++++
 lib/mgmt.h        |    5 +++++
 plugins/mgmtops.c |   24 +++++++++++++++++++++---
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 353705e..b3863e6 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -319,6 +319,14 @@ Stop Discovery Command
 	Command Parameters:
 	Return Parameters:
 
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
index 57e7603..be2f567 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -205,6 +205,11 @@ struct mgmt_cp_remove_remote_oob_data {
 
 #define MGMT_OP_STOP_DISCOVERY		0x001C
 
+#define MGMT_OP_SET_FAST_CONNECTABLE	0x001F
+struct mgmt_cp_set_fast_connectable {
+	uint8_t enable;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 4302813..2893dfd 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1201,6 +1201,9 @@ static void mgmt_cmd_complete(int sk, uint16_t index, void *buf, size_t len)
 	case MGMT_OP_REMOVE_REMOTE_OOB_DATA:
 		DBG("remove_remote_oob_data complete");
 		break;
+	case MGMT_OP_SET_FAST_CONNECTABLE:
+		DBG("set_fast_connectable complete");
+		break;
 	default:
 		error("Unknown command complete for opcode %u", opcode);
 		break;
@@ -1655,10 +1658,25 @@ static int mgmt_cancel_resolve_name(int index, bdaddr_t *bdaddr)
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
@@ -2014,7 +2032,7 @@ static struct btd_adapter_ops mgmt_ops = {
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

