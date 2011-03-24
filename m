Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v6 3/6] Add support for Out of Band (OOB) association model in hciops
Date: Thu, 24 Mar 2011 14:47:36 +0100
Message-ID: <1300974459-24076-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1300974459-24076-1-git-send-email-szymon.janc@tieto.com>
References: <1300974459-24076-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/hciops.c |  118 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 110 insertions(+), 8 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 3dbb381..0914285 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -50,6 +50,7 @@
 #include "storage.h"
 #include "event.h"
 #include "manager.h"
+#include "oob.h"
 
 static int child_pipe[2] = { -1, -1 };
 
@@ -77,11 +78,18 @@ struct bt_conn {
 	uint8_t loc_auth;
 	uint8_t rem_cap;
 	uint8_t rem_auth;
+	uint8_t rem_oob_data;
 	gboolean bonding_initiator;
 	gboolean secmode3;
 	GIOChannel *io; /* For raw L2CAP socket (bonding) */
 };
 
+struct oob_data {
+	bdaddr_t bdaddr;
+	uint8_t hash[16];
+	uint8_t randomizer[16];
+};
+
 static int max_dev = -1;
 static struct dev_info {
 	int id;
@@ -120,6 +128,8 @@ static struct dev_info {
 	GSList *keys;
 	uint8_t pin_length;
 
+	GSList *oob_data;
+
 	GSList *uuids;
 
 	GSList *connections;
@@ -1053,14 +1063,43 @@ static void user_passkey_notify(int index, void *ptr)
 						btohl(req->passkey));
 }
 
-static void remote_oob_data_request(int index, void *ptr)
+static gint oob_bdaddr_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct oob_data *data = a;
+	const bdaddr_t *bdaddr = b;
+
+	return bacmp(&data->bdaddr, bdaddr);
+}
+
+static void remote_oob_data_request(int index, bdaddr_t *bdaddr)
 {
 	struct dev_info *dev = &devs[index];
+	GSList *match;
 
 	DBG("hci%d", index);
 
-	hci_send_cmd(dev->sk, OGF_LINK_CTL,
-				OCF_REMOTE_OOB_DATA_NEG_REPLY, 6, ptr);
+	match = g_slist_find_custom(dev->oob_data, bdaddr, oob_bdaddr_cmp);
+
+	if (match) {
+		struct oob_data *data;
+		remote_oob_data_reply_cp cp;
+
+		data = match->data;
+
+		bacpy(&cp.bdaddr, &data->bdaddr);
+		memcpy(cp.hash, data->hash, sizeof(cp.hash));
+		memcpy(cp.randomizer, data->randomizer, sizeof(cp.randomizer));
+
+		dev->oob_data = g_slist_delete_link(dev->oob_data, match);
+
+		hci_send_cmd(dev->sk, OGF_LINK_CTL, OCF_REMOTE_OOB_DATA_REPLY,
+				REMOTE_OOB_DATA_REPLY_CP_SIZE, &cp);
+
+	} else {
+		hci_send_cmd(dev->sk, OGF_LINK_CTL,
+				OCF_REMOTE_OOB_DATA_NEG_REPLY, 6, bdaddr);
+	}
+
 }
 
 static int get_io_cap(int index, bdaddr_t *bdaddr, uint8_t *cap, uint8_t *auth)
@@ -1158,11 +1197,23 @@ static void io_capa_request(int index, void *ptr)
 					IO_CAPABILITY_NEG_REPLY_CP_SIZE, &cp);
 	} else {
 		io_capability_reply_cp cp;
+		struct bt_conn *conn;
+		GSList *match;
+
 		memset(&cp, 0, sizeof(cp));
 		bacpy(&cp.bdaddr, dba);
 		cp.capability = cap;
-		cp.oob_data = 0x00;
 		cp.authentication = auth;
+
+		conn = find_connection(dev, dba);
+		match = g_slist_find_custom(dev->oob_data, dba, oob_bdaddr_cmp);
+
+		if ((conn->bonding_initiator || conn->rem_oob_data == 0x01) &&
+				match)
+			cp.oob_data = 0x01;
+		else
+			cp.oob_data = 0x00;
+
 		hci_send_cmd(dev->sk, OGF_LINK_CTL, OCF_IO_CAPABILITY_REPLY,
 					IO_CAPABILITY_REPLY_CP_SIZE, &cp);
 	}
@@ -1182,6 +1233,7 @@ static void io_capa_response(int index, void *ptr)
 	if (conn) {
 		conn->rem_cap = evt->capability;
 		conn->rem_auth = evt->authentication;
+		conn->rem_oob_data = evt->oob_data;
 	}
 }
 
@@ -1785,6 +1837,20 @@ static void write_class_complete(int index, uint8_t status)
 		write_class(index, dev->wanted_cod);
 }
 
+static void read_local_oob_data_complete(int index, uint8_t status,
+						read_local_oob_data_rp *rp)
+{
+	struct btd_adapter *adapter = manager_find_adapter_by_id(index);
+
+	if (!adapter)
+		return;
+
+	if (status)
+		oob_local_data_read(adapter, NULL, NULL);
+	else
+		oob_local_data_read(adapter, rp->hash, rp->randomizer);
+}
+
 static inline void cmd_complete(int index, void *ptr)
 {
 	struct dev_info *dev = &devs[index];
@@ -1858,6 +1924,10 @@ static inline void cmd_complete(int index, void *ptr)
 		ptr += sizeof(evt_cmd_complete);
 		read_tx_power_complete(index, ptr);
 		break;
+	case cmd_opcode_pack(OGF_HOST_CTL, OCF_READ_LOCAL_OOB_DATA):
+		ptr += sizeof(evt_cmd_complete);
+		read_local_oob_data_complete(index, status, ptr);
+		break;
 	};
 }
 
@@ -2387,7 +2457,7 @@ static gboolean io_security_event(GIOChannel *chan, GIOCondition cond,
 		break;
 
 	case EVT_REMOTE_OOB_DATA_REQUEST:
-		remote_oob_data_request(index, ptr);
+		remote_oob_data_request(index, (bdaddr_t *) ptr);
 		break;
 	}
 
@@ -3557,30 +3627,62 @@ static int hciops_cancel_bonding(int index, bdaddr_t *bdaddr)
 
 static int hciops_read_local_oob_data (int index)
 {
+	struct dev_info *dev = &devs[index];
+
 	DBG("hci%d", index);
 
-	return -ENOSYS;
+	if (hci_send_cmd(dev->sk, OGF_HOST_CTL, OCF_READ_LOCAL_OOB_DATA, 0, 0)
+									< 0)
+		return -errno;
+
+	return 0;
 }
 
 static int hciops_add_remote_oob_data (int index, bdaddr_t *bdaddr,
 					uint8_t *hash, uint8_t *randomizer)
 {
 	char addr[18];
+	struct dev_info *dev = &devs[index];
+	GSList *match;
+	struct oob_data *data;
 
 	ba2str(bdaddr, addr);
 	DBG("hci%d bdaddr %s", index, addr);
 
-	return -ENOSYS;
+	match = g_slist_find_custom(dev->oob_data, &bdaddr, oob_bdaddr_cmp);
+
+	if (match) {
+		data = match->data;
+	} else {
+		data = g_new(struct oob_data, 1);
+		bacpy(&data->bdaddr, bdaddr);
+		dev->oob_data = g_slist_prepend(dev->oob_data, data);
+	}
+
+	memcpy(data->hash, hash, sizeof(data->hash));
+	memcpy(data->randomizer, randomizer, sizeof(data->randomizer));
+
+	return 0;
 }
 
 static int hciops_remove_remote_oob_data (int index, bdaddr_t *bdaddr)
 {
 	char addr[18];
+	struct dev_info *dev = &devs[index];
+	GSList *match;
 
 	ba2str(bdaddr, addr);
 	DBG("hci%d bdaddr %s", index, addr);
 
-	return -ENOSYS;
+	match = g_slist_find_custom(dev->oob_data, &bdaddr, oob_bdaddr_cmp);
+
+	if (!match)
+		return -ENOENT;
+
+	g_free(match->data);
+	dev->oob_data = g_slist_delete_link(dev->oob_data, match);
+
+	return 0;
 }
 
 static struct btd_adapter_ops hci_ops = {
-- 
1.7.0.4

