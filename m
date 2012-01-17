Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 08/11] Add support for sending the Load Long Term Keys commands
Date: Tue, 17 Jan 2012 20:28:47 -0300
Message-Id: <1326842930-31623-8-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1326842930-31623-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1326842930-31623-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Also this adds another method to the adapter_ops method table,
this method allows LTKs to be loaded to the kernel.
---
 plugins/hciops.c  |    6 +++++
 plugins/mgmtops.c |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/adapter.h     |   12 +++++++++++
 3 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 0c59c31..f519e0c 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -3779,6 +3779,11 @@ static int hciops_confirm_name(int index, bdaddr_t *bdaddr,
 	return 0;
 }
 
+static int hciops_load_ltks(int index, GSList *keys)
+{
+	return -ENOSYS;
+}
+
 static struct btd_adapter_ops hci_ops = {
 	.setup = hciops_setup,
 	.cleanup = hciops_cleanup,
@@ -3815,6 +3820,7 @@ static struct btd_adapter_ops hci_ops = {
 	.add_remote_oob_data = hciops_add_remote_oob_data,
 	.remove_remote_oob_data = hciops_remove_remote_oob_data,
 	.confirm_name = hciops_confirm_name,
+	.load_ltks = hciops_load_ltks,
 };
 
 static int hciops_init(void)
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 610bb72..40e1572 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -2075,6 +2075,60 @@ static int mgmt_confirm_name(int index, bdaddr_t *bdaddr, gboolean name_known)
 	return 0;
 }
 
+
+static int mgmtops_load_ltks(int index, GSList *keys)
+{
+	char *buf;
+	struct mgmt_hdr *hdr;
+	struct mgmt_cp_load_long_term_keys *cp;
+	struct mgmt_ltk_info *key;
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
+	hdr->opcode = htobs(MGMT_OP_LOAD_LONG_TERM_KEYS);
+	hdr->len = htobs(cp_size);
+	hdr->index = htobs(index);
+
+	cp = (void *) (buf + sizeof(*hdr));
+	cp->key_count = htobs(key_count);
+
+	for (l = keys, key = cp->keys; l != NULL; l = g_slist_next(l), key++) {
+		struct smp_ltk_info *info = l->data;
+
+		bacpy(&key->addr.bdaddr, &info->bdaddr);
+		key->addr.type = info->addr_type;
+		memcpy(key->val, info->val, sizeof(info->val));
+		memcpy(key->rand, info->rand, sizeof(info->rand));
+		memcpy(&key->ediv, &info->ediv, sizeof(key->ediv));
+		key->authenticated = info->authenticated;
+		key->master = info->master;
+		key->enc_size = info->enc_size;
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
@@ -2111,6 +2165,7 @@ static struct btd_adapter_ops mgmt_ops = {
 	.add_remote_oob_data = mgmt_add_remote_oob_data,
 	.remove_remote_oob_data = mgmt_remove_remote_oob_data,
 	.confirm_name = mgmt_confirm_name,
+	.load_ltks = mgmtops_load_ltks,
 };
 
 static int mgmt_init(void)
diff --git a/src/adapter.h b/src/adapter.h
index fb1dcdf..1e11e93 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -56,6 +56,17 @@ struct link_key_info {
 	uint8_t pin_len;
 };
 
+struct smp_ltk_info {
+	bdaddr_t bdaddr;
+	addr_type_t addr_type;
+	uint8_t authenticated;
+	uint8_t master;
+	uint8_t enc_size;
+	uint16_t ediv;
+	uint8_t rand[8];
+	uint8_t val[16];
+};
+
 struct remote_dev_info {
 	bdaddr_t bdaddr;
 	addr_type_t type;
@@ -209,6 +220,7 @@ struct btd_adapter_ops {
 							uint8_t *randomizer);
 	int (*remove_remote_oob_data) (int index, bdaddr_t *bdaddr);
 	int (*confirm_name) (int index, bdaddr_t *bdaddr, gboolean name_known);
+	int (*load_ltks) (int index, GSList *keys);
 };
 
 int btd_register_adapter_ops(struct btd_adapter_ops *ops, gboolean priority);
-- 
1.7.8.1

