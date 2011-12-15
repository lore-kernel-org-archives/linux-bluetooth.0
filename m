Return-Path: <cyrus@holtmann.org>
From: Hemant Gupta <hemant.gupta@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Hemant Gupta <hemant.gupta@stericsson.com>
Subject: [PATCHv3] mgmt: Add support for Passkey handling
Date: Thu, 15 Dec 2011 19:44:05 +0530
Message-ID: <1323958445-660-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for handling Passkey Requests
and response over management interface.
---
 lib/mgmt.h        |    3 ++
 plugins/mgmtops.c |   85 ++++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 78 insertions(+), 10 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index b77970f..07d325d 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -226,6 +226,9 @@ struct mgmt_rp_user_passkey_reply {
 } __packed;
 
 #define MGMT_OP_USER_PASSKEY_NEG_REPLY	0x001D
+struct mgmt_cp_user_passkey_neg_reply {
+	bdaddr_t bdaddr;
+} __packed;
 
 #define MGMT_OP_READ_LOCAL_OOB_DATA	0x001E
 struct mgmt_rp_read_local_oob_data {
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 8e6eb4d..e9920f4 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -572,6 +572,78 @@ static int mgmt_confirm_reply(int index, bdaddr_t *bdaddr, gboolean success)
 	return 0;
 }
 
+static int mgmt_passkey_reply(int index, bdaddr_t *bdaddr, uint32_t passkey)
+{
+	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_user_passkey_reply)];
+	struct mgmt_hdr *hdr = (void *) buf;
+	size_t buf_len;
+	char addr[18];
+
+	ba2str(bdaddr, addr);
+	DBG("index %d addr %s passkey %06u", index, addr, passkey);
+
+	memset(buf, 0, sizeof(buf));
+
+	hdr->index = htobs(index);
+	if (passkey == INVALID_PASSKEY) {
+		struct mgmt_cp_user_passkey_neg_reply *cp;
+
+		hdr->opcode = htobs(MGMT_OP_USER_PASSKEY_NEG_REPLY);
+		hdr->len = htobs(sizeof(*cp));
+
+		cp = (void *) &buf[sizeof(*hdr)];
+		bacpy(&cp->bdaddr, bdaddr);
+
+		buf_len = sizeof(*hdr) + sizeof(*cp);
+	} else {
+		struct mgmt_cp_user_passkey_reply *cp;
+
+		hdr->opcode = htobs(MGMT_OP_USER_PASSKEY_REPLY);
+		hdr->len = htobs(sizeof(*cp));
+
+		cp = (void *) &buf[sizeof(*hdr)];
+		bacpy(&cp->bdaddr, bdaddr);
+		cp->passkey = htobl(passkey);
+
+		buf_len = sizeof(*hdr) + sizeof(*cp);
+	}
+
+	if (write(mgmt_sock, buf, buf_len) < 0)
+		return -errno;
+
+	return 0;
+}
+
+static void mgmt_passkey_request(int sk, uint16_t index, void *buf, size_t len)
+{
+	struct mgmt_ev_user_passkey_request *ev = buf;
+	struct controller_info *info;
+	char addr[18];
+	int err;
+
+	if (len < sizeof(*ev)) {
+		error("Too small passkey_request event");
+		return;
+	}
+
+	ba2str(&ev->bdaddr, addr);
+
+	DBG("hci%u %s", index, addr);
+
+	if (index > max_index) {
+		error("Unexpected index %u in passkey_request event", index);
+		return;
+	}
+
+	info = &controllers[index];
+
+	err = btd_event_user_passkey(&info->bdaddr, &ev->bdaddr);
+	if (err < 0) {
+		error("btd_event_user_passkey: %s", strerror(-err));
+		mgmt_passkey_reply(index, &ev->bdaddr, INVALID_PASSKEY);
+	}
+}
+
 struct confirm_data {
 	int index;
 	bdaddr_t bdaddr;
@@ -1406,6 +1478,9 @@ static gboolean mgmt_event(GIOChannel *io, GIOCondition cond, gpointer user_data
 	case MGMT_EV_DEVICE_UNBLOCKED:
 		mgmt_device_unblocked(sk, index, buf + MGMT_HDR_SIZE, len);
 		break;
+	case MGMT_EV_USER_PASSKEY_REQUEST:
+		mgmt_passkey_request(sk, index, buf + MGMT_HDR_SIZE, len);
+		break;
 	default:
 		error("Unknown Management opcode %u (index %u)", opcode, index);
 		break;
@@ -1749,16 +1824,6 @@ static int mgmt_remove_bonding(int index, bdaddr_t *bdaddr)
 	return 0;
 }
 
-static int mgmt_passkey_reply(int index, bdaddr_t *bdaddr, uint32_t passkey)
-{
-	char addr[18];
-
-	ba2str(bdaddr, addr);
-	DBG("index %d addr %s passkey %06u", index, addr, passkey);
-
-	return -ENOSYS;
-}
-
 static int mgmt_encrypt_link(int index, bdaddr_t *dst, bt_hci_result_t cb,
 							gpointer user_data)
 {
-- 
1.6.6.1

