Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH V2 4/7] mgmtops: Add support for setting Device ID
Date: Tue, 20 Mar 2012 17:27:24 +0100
Message-ID: <1332260847-20079-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1332260847-20079-1-git-send-email-szymon.janc@tieto.com>
References: <1332260847-20079-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/mgmt.h        |    9 +++++++++
 plugins/mgmtops.c |   27 ++++++++++++++++++++++++---
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index f3bc6da..c9b0f1a 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -311,6 +311,14 @@ struct mgmt_cp_unblock_device {
 	struct mgmt_addr_info addr;
 } __packed;
 
+#define MGMT_OP_SET_DEVICE_ID		0x0028
+struct mgmt_cp_set_device_id {
+	uint16_t source;
+	uint16_t vendor;
+	uint16_t product;
+	uint16_t version;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
@@ -475,6 +483,7 @@ static const char *mgmt_op[] = {
 	"Confirm Name",
 	"Block Device",
 	"Unblock Device",
+	"Set Device ID",
 };
 
 static const char *mgmt_ev[] = {
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index c24757c..c08117f 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1426,6 +1426,9 @@ static void mgmt_cmd_complete(int sk, uint16_t index, void *buf, size_t len)
 	case MGMT_OP_STOP_DISCOVERY:
 		DBG("stop_discovery complete");
 		break;
+	case MGMT_OP_SET_DEVICE_ID:
+		DBG("set_did complete");
+		break;
 	default:
 		error("Unknown command complete for opcode %u", opcode);
 		break;
@@ -2118,9 +2121,27 @@ static int mgmt_encrypt_link(int index, bdaddr_t *dst, bt_hci_result_t cb,
 static int mgmt_set_did(int index, uint16_t vendor, uint16_t product,
 					uint16_t version, uint16_t source)
 {
-	DBG("index %d vendor %u product %u version %u source %u",
-				index, vendor, product, version, source);
-	return -ENOSYS;
+	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_set_device_id)];
+	struct mgmt_hdr *hdr = (void *) buf;
+	struct mgmt_cp_set_device_id *cp = (void *) &buf[sizeof(*hdr)];
+
+	DBG("index %d source %x vendor %x product %x version %x",
+				index, source, vendor, product, version);
+
+	memset(buf, 0, sizeof(buf));
+	hdr->opcode = htobs(MGMT_OP_SET_DEVICE_ID);
+	hdr->len = htobs(sizeof(*cp));
+	hdr->index = htobs(index);
+
+	cp->source = htobs(source);
+	cp->vendor = htobs(vendor);
+	cp->product = htobs(product);
+	cp->version = htobs(version);
+
+	if (write(mgmt_sock, buf, sizeof(buf)) < 0)
+		return -errno;
+
+	return 0;
 }
 
 static int mgmt_disable_cod_cache(int index)
-- 
on behalf of ST-Ericsson

