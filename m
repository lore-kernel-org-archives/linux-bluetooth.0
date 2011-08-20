Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 06/12] Add handlers for the new mgmt SMP messages
Date: Fri, 19 Aug 2011 21:12:02 -0300
Message-Id: <1313799128-8842-7-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1313799128-8842-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1313799128-8842-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/hciops.c  |    6 +++
 plugins/mgmtops.c |   94 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/adapter.h     |   10 ++++++
 3 files changed, 110 insertions(+), 0 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 869a814..cf8dd3a 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -3636,6 +3636,11 @@ static int hciops_remove_remote_oob_data(int index, bdaddr_t *bdaddr)
 	return 0;
 }
 
+static int hciops_load_smp_keys(int index, GSList *keys)
+{
+	return -ENOSYS;
+}
+
 static struct btd_adapter_ops hci_ops = {
 	.setup = hciops_setup,
 	.cleanup = hciops_cleanup,
@@ -3674,6 +3679,7 @@ static struct btd_adapter_ops hci_ops = {
 	.read_local_oob_data = hciops_read_local_oob_data,
 	.add_remote_oob_data = hciops_add_remote_oob_data,
 	.remove_remote_oob_data = hciops_remove_remote_oob_data,
+	.load_smp_keys = hciops_load_smp_keys,
 };
 
 static int hciops_init(void)
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index bf9e9af..3fd1b3f 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1386,6 +1386,45 @@ static void mgmt_discovering(int sk, uint16_t index, void *buf, size_t len)
 	adapter_set_state(adapter, state);
 }
 
+static void mgmt_new_smp_key(int sk, uint16_t index, void *buf, size_t len)
+{
+	struct mgmt_ev_new_smp_key *ev = buf;
+	struct controller_info *info;
+
+	if (len != sizeof(*ev)) {
+		error("new_smp_key event size mismatch (%zu != %zu)",
+							len, sizeof(*ev));
+		return;
+	}
+
+	DBG("Controller %u new key of type %u pin_len %u", index,
+					ev->key.type, ev->key.pin_len);
+
+	if (index > max_index) {
+		error("Unexpected index %u in new_key event", index);
+		return;
+	}
+
+	if (ev->key.pin_len > 16) {
+		error("Invalid PIN length (%u) in new_key event",
+							ev->key.pin_len);
+		return;
+	}
+
+	info = &controllers[index];
+
+	if (ev->store_hint) {
+		struct smp_ltk_info *ltk = &ev->key.ltk;
+
+		btd_event_link_key_notify(&info->bdaddr, &ev->key.bdaddr,
+					ev->key.val, ev->key.type,
+					ev->key.pin_len, ev->key.data,
+					sizeof(*ltk));
+	}
+
+	btd_event_bonding_complete(&info->bdaddr, &ev->key.bdaddr, 0);
+}
+
 static gboolean mgmt_event(GIOChannel *io, GIOCondition cond, gpointer user_data)
 {
 	char buf[MGMT_BUF_SIZE];
@@ -1490,6 +1529,9 @@ static gboolean mgmt_event(GIOChannel *io, GIOCondition cond, gpointer user_data
 	case MGMT_EV_DISCOVERING:
 		mgmt_discovering(sk, index, buf + MGMT_HDR_SIZE, len);
 		break;
+	case MGMT_EV_NEW_SMP_KEY:
+		mgmt_new_smp_key(sk, index, buf + MGMT_HDR_SIZE, len);
+		break;
 	default:
 		error("Unknown Management opcode %u (index %u)", opcode, index);
 		break;
@@ -2030,6 +2072,57 @@ static int mgmt_remove_remote_oob_data(int index, bdaddr_t *bdaddr)
 	return 0;
 }
 
+static int mgmtops_load_smp_keys(int index, GSList *keys)
+{
+	char *buf;
+	struct mgmt_hdr *hdr;
+	struct mgmt_cp_load_smp_keys *cp;
+	struct mgmt_smp_key_info *key;
+	size_t key_count, cp_size;
+	GSList *l;
+	int err;
+
+	key_count = g_slist_length(keys);
+
+	DBG("index %d keys %zu", index, key_count);
+
+	cp_size = sizeof(*cp) + (key_count * sizeof(*key));
+
+	buf = g_try_malloc0(sizeof(*hdr) + cp_size);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	memset(buf, 0, sizeof(buf));
+
+	hdr = (void *) buf;
+	hdr->opcode = htobs(MGMT_OP_LOAD_SMP_KEYS);
+	hdr->len = htobs(cp_size);
+	hdr->index = htobs(index);
+
+	cp = (void *) (buf + sizeof(*hdr));
+	cp->key_count = htobs(key_count);
+
+	for (l = keys, key = cp->keys; l != NULL; l = g_slist_next(l), key++) {
+		struct smp_key_info *info = l->data;
+
+		bacpy(&key->bdaddr, &info->bdaddr);
+		key->type = info->type;
+		memcpy(key->val, info->val, 16);
+		key->pin_len = info->pin_len;
+
+		memcpy(key->data, info->data, info->dlen);
+	}
+
+	if (write(mgmt_sock, buf, sizeof(*hdr) + cp_size) < 0)
+		err = -errno;
+	else
+		err = 0;
+
+	g_free(buf);
+
+	return err;
+}
+
 static struct btd_adapter_ops mgmt_ops = {
 	.setup = mgmt_setup,
 	.cleanup = mgmt_cleanup,
@@ -2068,6 +2161,7 @@ static struct btd_adapter_ops mgmt_ops = {
 	.read_local_oob_data = mgmt_read_local_oob_data,
 	.add_remote_oob_data = mgmt_add_remote_oob_data,
 	.remove_remote_oob_data = mgmt_remove_remote_oob_data,
+	.load_smp_keys = mgmtops_load_smp_keys,
 };
 
 static int mgmt_init(void)
diff --git a/src/adapter.h b/src/adapter.h
index 687275a..a835eed 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -63,6 +63,15 @@ struct link_key_info {
 	uint8_t pin_len;
 };
 
+struct smp_key_info {
+	bdaddr_t bdaddr;
+	uint8_t type;
+	uint8_t pin_len;
+	uint8_t val[16];
+	int dlen;
+	uint8_t *data;
+};
+
 struct remote_dev_info {
 	bdaddr_t bdaddr;
 	int8_t rssi;
@@ -220,6 +229,7 @@ struct btd_adapter_ops {
 	int (*add_remote_oob_data) (int index, bdaddr_t *bdaddr, uint8_t *hash,
 							uint8_t *randomizer);
 	int (*remove_remote_oob_data) (int index, bdaddr_t *bdaddr);
+	int (*load_smp_keys) (int index, GSList *keys);
 };
 
 int btd_register_adapter_ops(struct btd_adapter_ops *ops, gboolean priority);
-- 
1.7.6

