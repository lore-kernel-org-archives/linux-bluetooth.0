Return-Path: <cyrus@holtmann.org>
From: Antti Julku <antti.julku@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Antti Julku <antti.julku@nokia.com>
Subject: [PATCH] Add blacklisting support for management interface
Date: Wed, 15 Jun 2011 12:02:03 +0300
Message-Id: <1308128523-11705-1-git-send-email-antti.julku@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Management interface commands for blocking and unblocking devices.
---
 doc/mgmt-api.txt  |   16 ++++++++++++++++
 lib/mgmt.h        |   10 ++++++++++
 plugins/mgmtops.c |   46 ++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 353705e..d89467c 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -319,6 +319,22 @@ Stop Discovery Command
 	Command Parameters:
 	Return Parameters:
 
+Block Device Command
+====================
+
+	Command Code:		0x0001D
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+	Return Parameters:	Status (1 octet)
+
+Unblock Device Command
+======================
+
+	Command Code:		0x0001E
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+	Return Parameters:	Status (1 octet)
+
 Read Tracing Buffer Size Command
 ================================
 
diff --git a/lib/mgmt.h b/lib/mgmt.h
index 57e7603..f22434e 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -205,6 +205,16 @@ struct mgmt_cp_remove_remote_oob_data {
 
 #define MGMT_OP_STOP_DISCOVERY		0x001C
 
+#define MGMT_OP_BLOCK_DEVICE		0x001D
+struct mgmt_cp_block_device {
+	bdaddr_t bdaddr;
+} __packed;
+
+#define MGMT_OP_UNBLOCK_DEVICE		0x001E
+struct mgmt_cp_unblock_device {
+	bdaddr_t bdaddr;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 4302813..d6226c4 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1201,6 +1201,12 @@ static void mgmt_cmd_complete(int sk, uint16_t index, void *buf, size_t len)
 	case MGMT_OP_REMOVE_REMOTE_OOB_DATA:
 		DBG("remove_remote_oob_data complete");
 		break;
+	case MGMT_OP_BLOCK_DEVICE:
+		DBG("block_device complete");
+		break;
+	case MGMT_OP_UNBLOCK_DEVICE:
+		DBG("unblock_device complete");
+		break;
 	default:
 		error("Unknown command complete for opcode %u", opcode);
 		break;
@@ -1691,22 +1697,58 @@ static int mgmt_read_bdaddr(int index, bdaddr_t *bdaddr)
 
 static int mgmt_block_device(int index, bdaddr_t *bdaddr)
 {
+	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_block_device)];
+	struct mgmt_hdr *hdr = (void *) buf;
+	struct mgmt_cp_block_device *cp;
+	size_t buf_len;
 	char addr[18];
 
 	ba2str(bdaddr, addr);
 	DBG("index %d addr %s", index, addr);
 
-	return -ENOSYS;
+	memset(buf, 0, sizeof(buf));
+
+	hdr->opcode = htobs(MGMT_OP_BLOCK_DEVICE);
+	hdr->len = htobs(sizeof(*cp));
+	hdr->index = htobs(index);
+
+	cp = (void *) &buf[sizeof(*hdr)];
+	bacpy(&cp->bdaddr, bdaddr);
+
+	buf_len = sizeof(*hdr) + sizeof(*cp);
+
+	if (write(mgmt_sock, buf, buf_len) < 0)
+		return -errno;
+
+	return 0;
 }
 
 static int mgmt_unblock_device(int index, bdaddr_t *bdaddr)
 {
+	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_unblock_device)];
+	struct mgmt_hdr *hdr = (void *) buf;
+	struct mgmt_cp_unblock_device *cp;
+	size_t buf_len;
 	char addr[18];
 
 	ba2str(bdaddr, addr);
 	DBG("index %d addr %s", index, addr);
 
-	return -ENOSYS;
+	memset(buf, 0, sizeof(buf));
+
+	hdr->opcode = htobs(MGMT_OP_UNBLOCK_DEVICE);
+	hdr->len = htobs(sizeof(*cp));
+	hdr->index = htobs(index);
+
+	cp = (void *) &buf[sizeof(*hdr)];
+	bacpy(&cp->bdaddr, bdaddr);
+
+	buf_len = sizeof(*hdr) + sizeof(*cp);
+
+	if (write(mgmt_sock, buf, buf_len) < 0)
+		return -errno;
+
+	return 0;
 }
 
 static int mgmt_get_conn_list(int index, GSList **conns)
-- 
1.7.2.5

