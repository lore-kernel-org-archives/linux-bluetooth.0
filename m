Return-Path: <cyrus@holtmann.org>
Message-ID: <4EB854F0.60808@codeaurora.org>
Date: Mon, 07 Nov 2011 14:00:16 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: [RFC 1/1] Bluetooth: Add LE SecMgr and mgmtops support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implemented missing components of MGMTOPS interface
Differentiated as needed between BR/EDR pairing and LE pairing

These are a combination of changes we made to get make MGMTOPS more
robust, and provide MITM pairing options for LE.  Much work has been put 
into
merging these changes into the current master branch of Bluetooth Next, but
they have not been extensively tested on that build.

This is anticipated to be the first step towards upstreaming these changes,

Signed-off-by: Brian Gix <bgix@codeaurora.org>
---
  include/net/bluetooth/hci.h      |   36 ++
  include/net/bluetooth/hci_core.h |   32 ++-
  include/net/bluetooth/l2cap.h    |    5 +
  include/net/bluetooth/mgmt.h     |   24 ++-
  include/net/bluetooth/smp.h      |   14 +-
  net/bluetooth/hci_conn.c         |   58 +++-
  net/bluetooth/hci_core.c         |   64 +++-
  net/bluetooth/hci_event.c        |  166 ++++++---
  net/bluetooth/hci_sock.c         |    9 +-
  net/bluetooth/l2cap_core.c       |   15 +-
  net/bluetooth/mgmt.c             |  743 
++++++++++++++++++++++++++++++++------
  net/bluetooth/smp.c              |  661 ++++++++++++++++++++++++---------
  12 files changed, 1441 insertions(+), 386 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c5fcd13..8ae8dca 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -632,6 +632,12 @@ struct hci_cp_host_buffer_size {
  	__le16   sco_max_pkt;
  } __packed;

+#define HCI_OP_WRITE_CURRENT_IAC_LAP	0x0c3a
+struct hci_cp_write_current_iac_lap {
+	__u8     num_current_iac;
+	__u8     lap[6];
+} __packed;
+
  #define HCI_OP_WRITE_INQUIRY_MODE	0x0c45

  #define HCI_MAX_EIR_LENGTH		240
@@ -753,6 +759,15 @@ struct hci_rp_le_read_buffer_size {
  	__u8     le_max_pkt;
  } __packed;

+#define HCI_OP_LE_SET_SCAN_PARAMETERS	0x200b
+struct hci_cp_le_set_scan_parameters {
+	__u8	type;
+	__le16	interval;
+	__le16	window;
+	__u8	own_bdaddr_type;
+	__u8	filter;
+} __packed;
+
  #define HCI_OP_LE_SET_SCAN_ENABLE	0x200c
  struct hci_cp_le_set_scan_enable {
  	__u8     enable;
@@ -788,6 +803,16 @@ struct hci_cp_le_conn_update {
  	__le16   max_ce_len;
  } __packed;

+#define HCI_OP_LE_ENCRYPT		0x2017
+struct hci_cp_le_encrypt {
+	__u8	key[16];
+	__u8	data[16];
+} __packed;
+struct hci_cp_le_encrypt_reply {
+	__u8     status;
+	__u8     encrypted[16];
+} __packed;
+
  #define HCI_OP_LE_START_ENC		0x2019
  struct hci_cp_le_start_enc {
  	__le16	handle;
@@ -1069,6 +1094,11 @@ struct hci_ev_user_confirm_req {
  	__le32		passkey;
  } __packed;

+#define HCI_EV_USER_PASSKEY_REQUEST	0x34
+struct hci_ev_user_passkey_request {
+	bdaddr_t bdaddr;
+} __packed;
+
  #define HCI_EV_REMOTE_OOB_DATA_REQUEST	0x35
  struct hci_ev_remote_oob_data_request {
  	bdaddr_t bdaddr;
@@ -1080,6 +1110,12 @@ struct hci_ev_simple_pair_complete {
  	bdaddr_t bdaddr;
  } __packed;

+#define HCI_EV_USER_PASSKEY_NOTIFICATION	0x3b
+struct hci_ev_user_passkey_notification {
+	bdaddr_t	bdaddr;
+	__le32		passkey;
+} __packed;
+
  #define HCI_EV_REMOTE_HOST_FEATURES	0x3d
  struct hci_ev_remote_host_features {
  	bdaddr_t bdaddr;
diff --git a/include/net/bluetooth/hci_core.h 
b/include/net/bluetooth/hci_core.h
index f97792c..9cadb41 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -89,11 +89,17 @@ struct key_master_id {
  	u8 rand[8];
  } __packed;

+#define KEY_TYPE_LE_BASE	0x11
+#define KEY_TYPE_LTK		0x11
+#define KEY_TYPE_IRK		0x12
+#define KEY_TYPE_CSRK		0x13
+
  struct link_key_data {
  	bdaddr_t bdaddr;
  	u8 type;
  	u8 val[16];
  	u8 pin_len;
+	u8 auth;
  	u8 dlen;
  	u8 data[0];
  } __packed;
@@ -101,9 +107,11 @@ struct link_key_data {
  struct link_key {
  	struct list_head list;
  	bdaddr_t bdaddr;
-	u8 type;
+	u8 addr_type;
+	u8 key_type;
  	u8 val[16];
  	u8 pin_len;
+	u8 auth;
  	u8 dlen;
  	u8 data[0];
  };
@@ -119,6 +127,7 @@ struct adv_entry {
  	struct list_head list;
  	bdaddr_t bdaddr;
  	u8 bdaddr_type;
+	u8 flags;
  };

  #define NUM_REASSEMBLY 4
@@ -215,6 +224,8 @@ struct hci_dev {

  	__u16			init_last_cmd;

+	struct crypto_blkcipher	*tfm;
+	
  	struct inquiry_cache	inq_cache;
  	struct hci_conn_hash	conn_hash;
  	struct list_head	blacklist;
@@ -282,6 +293,7 @@ struct hci_conn {
  	__u8		pin_length;
  	__u8		enc_key_size;
  	__u8		io_capability;
+	__u8		auth_initiator;
  	__u8		power_save;
  	__u16		disc_timeout;
  	unsigned long	pend;
@@ -311,6 +323,9 @@ struct hci_conn {

  	struct hci_conn	*link;

+	/* Low Energy SMP Connection */
+	void		*smp_conn;
+
  	void (*connect_cfm_cb)	(struct hci_conn *conn, u8 status);
  	void (*security_cfm_cb)	(struct hci_conn *conn, u8 status);
  	void (*disconn_cfm_cb)	(struct hci_conn *conn, u8 reason);
@@ -627,8 +642,8 @@ int hci_add_link_key(struct hci_dev *hdev, struct 
hci_conn *conn, int new_key,
  struct link_key *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 
rand[8]);
  struct link_key *hci_find_link_key_type(struct hci_dev *hdev,
  					bdaddr_t *bdaddr, u8 type);
-int hci_add_ltk(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
-			u8 key_size, __le16 ediv, u8 rand[8], u8 ltk[16]);
+int hci_add_ltk(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr, u8 
type,
+		u8 auth, u8 key_size, __le16 ediv, u8 rand[8], u8 ltk[16]);
  int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);

  int hci_remote_oob_data_clear(struct hci_dev *hdev);
@@ -918,6 +933,7 @@ int mgmt_pin_code_reply_complete(u16 index, bdaddr_t 
*bdaddr, u8 status);
  int mgmt_pin_code_neg_reply_complete(u16 index, bdaddr_t *bdaddr, u8 
status);
  int mgmt_user_confirm_request(u16 index, bdaddr_t *bdaddr, __le32 value,
  							u8 confirm_hint);
+int mgmt_user_oob_request(u16 index, bdaddr_t *bdaddr);
  int mgmt_user_confirm_reply_complete(u16 index, bdaddr_t *bdaddr, u8 
status);
  int mgmt_user_confirm_neg_reply_complete(u16 index, bdaddr_t *bdaddr,
  								u8 status);
@@ -925,14 +941,18 @@ int mgmt_auth_failed(u16 index, bdaddr_t *bdaddr, 
u8 status);
  int mgmt_set_local_name_complete(u16 index, u8 *name, u8 status);
  int mgmt_read_local_oob_data_reply_complete(u16 index, u8 *hash, u8 
*randomizer,
  								u8 status);
-int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 *dev_class, s8 rssi,
-								u8 *eir);
-int mgmt_remote_name(u16 index, bdaddr_t *bdaddr, u8 *name);
+int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 type, u8 le,
+				u8 *dev_class, s8 rssi, u8 eir_len, u8 *eir);
+int mgmt_remote_name(u16 index, bdaddr_t *bdaddr, u8 status, u8 *name);
  int mgmt_inquiry_failed(u16 index, u8 status);
  int mgmt_discovering(u16 index, u8 discovering);
+void mgmt_inquiry_complete_evt(u16 index, u8 status);
  int mgmt_device_blocked(u16 index, bdaddr_t *bdaddr);
  int mgmt_device_unblocked(u16 index, bdaddr_t *bdaddr);

+/* LE SMP Management interface */
+int smp_user_confirm_reply(struct hci_conn *conn, u16 mgmt_op, void *cp);
+
  /* HCI info for socket */
  #define hci_pi(sk) ((struct hci_pinfo *) sk)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index fdb2b78..a411288 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -538,6 +538,11 @@ struct l2cap_conn {
  	rwlock_t	chan_lock;
  };

+struct sock_del_list {
+	struct sock *sk;
+	struct list_head list;
+};
+
  #define L2CAP_INFO_CL_MTU_REQ_SENT	0x01
  #define L2CAP_INFO_FEAT_MASK_REQ_SENT	0x04
  #define L2CAP_INFO_FEAT_MASK_REQ_DONE	0x08
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 3062fd3..b0191d2 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -90,6 +90,8 @@ struct mgmt_cp_set_dev_class {
  	__u8 major;
  	__u8 minor;
  } __packed;
+#define MGMT_MAJOR_CLASS_MASK		0x1F
+#define MGMT_MAJOR_CLASS_LIMITED	0x20

  #define MGMT_OP_SET_SERVICE_CACHE	0x000C
  struct mgmt_cp_set_service_cache {
@@ -98,9 +100,13 @@ struct mgmt_cp_set_service_cache {

  struct mgmt_key_info {
  	bdaddr_t bdaddr;
-	u8 type;
+	u8 addr_type;
+	u8 key_type;
  	u8 val[16];
  	u8 pin_len;
+	u8 auth;
+	u8 dlen;
+	u8 data[10];
  } __packed;

  #define MGMT_OP_LOAD_KEYS		0x000D
@@ -214,6 +220,19 @@ struct mgmt_cp_set_fast_connectable {
  	__u8 enable;
  } __packed;

+#define MGMT_OP_USER_PASSKEY_REPLY	0x0020
+struct mgmt_cp_user_passkey_reply {
+	bdaddr_t bdaddr;
+	__le32 passkey;
+} __packed;
+
+#define MGMT_OP_RESOLVE_NAME		0x0021
+struct mgmt_cp_resolve_name {
+	bdaddr_t bdaddr;
+} __packed;
+
+#define MGMT_OP_SET_LIMIT_DISCOVERABLE	0x0022
+
  #define MGMT_EV_CMD_COMPLETE		0x0001
  struct mgmt_ev_cmd_complete {
  	__le16 opcode;
@@ -295,12 +314,15 @@ struct mgmt_ev_device_found {
  	bdaddr_t bdaddr;
  	__u8 dev_class[3];
  	__s8 rssi;
+	__u8 le;
+	__u8 type;
  	__u8 eir[HCI_MAX_EIR_LENGTH];
  } __packed;

  #define MGMT_EV_REMOTE_NAME		0x0013
  struct mgmt_ev_remote_name {
  	bdaddr_t bdaddr;
+	__u8 status;
  	__u8 name[MGMT_MAX_NAME_LENGTH];
  } __packed;

diff --git a/include/net/bluetooth/smp.h b/include/net/bluetooth/smp.h
index 15b97d5..8fc0c84 100644
--- a/include/net/bluetooth/smp.h
+++ b/include/net/bluetooth/smp.h
@@ -55,6 +55,13 @@ struct smp_cmd_pairing {
  #define SMP_AUTH_BONDING	0x01
  #define SMP_AUTH_MITM		0x04

+#define SMP_JUST_WORKS		0x00
+#define SMP_JUST_CFM		0x01
+#define SMP_REQ_PASSKEY		0x02
+#define SMP_CFM_PASSKEY		0x03
+#define SMP_REQ_OOB		0x04
+#define SMP_OVERLAP		0xFF
+
  #define SMP_CMD_PAIRING_CONFIRM	0x03
  struct smp_cmd_pairing_confirm {
  	__u8	confirm_val[16];
@@ -123,7 +130,11 @@ struct smp_chan {
  	u8              rrnd[16]; /* SMP Pairing Random (remote) */
  	u8		pcnf[16]; /* SMP Pairing Confirm */
  	u8		tk[16]; /* SMP Temporary Key */
+	u8		smp_tk_valid;
+	u8		smp_cfm_pending;
  	u8		smp_key_size;
+	u8		smp_sec_req;
+	u8		smp_auth;
  	struct crypto_blkcipher	*tfm;
  	struct work_struct confirm;
  	struct work_struct random;
@@ -133,7 +144,8 @@ struct smp_chan {
  /* SMP Commands */
  int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level);
  int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb);
-int smp_distribute_keys(struct l2cap_conn *conn, __u8 force);
+int smp_link_encrypt_cmplt(struct l2cap_conn *conn, __u8 status, __u8 
encrypt);
+void smp_timeout(struct l2cap_conn *conn);

  void smp_chan_destroy(struct l2cap_conn *conn);

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index e545376..b543434 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -50,10 +50,13 @@ static void hci_le_connect(struct hci_conn *conn)
  	struct hci_dev *hdev = conn->hdev;
  	struct hci_cp_le_create_conn cp;

+	BT_DBG("%p", conn);
+
  	conn->state = BT_CONNECT;
  	conn->out = 1;
  	conn->link_mode |= HCI_LM_MASTER;
  	conn->sec_level = BT_SECURITY_LOW;
+	conn->type = LE_LINK;

  	memset(&cp, 0, sizeof(cp));
  	cp.scan_interval = cpu_to_le16(0x0060);
@@ -283,9 +286,6 @@ static void hci_conn_timeout(unsigned long arg)

  	BT_DBG("conn %p state %d", conn, conn->state);

-	if (atomic_read(&conn->refcnt))
-		return;
-
  	hci_dev_lock(hdev);

  	switch (conn->state) {
@@ -300,11 +300,14 @@ static void hci_conn_timeout(unsigned long arg)
  		break;
  	case BT_CONFIG:
  	case BT_CONNECTED:
-		reason = hci_proto_disconn_ind(conn);
-		hci_acl_disconn(conn, reason);
+		if (!atomic_read(&conn->refcnt)) {
+			reason = hci_proto_disconn_ind(conn);
+			hci_acl_disconn(conn, reason);
+		}
  		break;
  	default:
-		conn->state = BT_CLOSED;
+		if (!atomic_read(&conn->refcnt))
+			conn->state = BT_CLOSED;
  		break;
  	}

@@ -493,7 +496,8 @@ EXPORT_SYMBOL(hci_get_route);

  /* Create SCO, ACL or LE connection.
   * Device _must_ be locked */
-struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t 
*dst, __u8 sec_level, __u8 auth_type)
+struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
+						__u8 sec_level, __u8 auth_type)
  {
  	struct hci_conn *acl;
  	struct hci_conn *sco;
@@ -503,20 +507,31 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, 
int type, bdaddr_t *dst, __u8

  	if (type == LE_LINK) {
  		struct adv_entry *entry;
+		struct link_key *key;
+		u8 bdaddr_type;

  		le = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
-		if (le)
-			return ERR_PTR(-EBUSY);
+		if (le) {
+			hci_conn_hold(le);
+			return le;
+		}

-		entry = hci_find_adv_entry(hdev, dst);
-		if (!entry)
-			return ERR_PTR(-EHOSTUNREACH);
+		key = hci_find_link_key_type(hdev, dst, KEY_TYPE_LTK);
+		if (!key) {
+			entry = hci_find_adv_entry(hdev, dst);
+			if (entry)
+				bdaddr_type = entry->bdaddr_type;
+			else
+				bdaddr_type = 0;
+		} else {
+			bdaddr_type = key->addr_type;
+		}

  		le = hci_conn_add(hdev, LE_LINK, dst);
  		if (!le)
  			return ERR_PTR(-ENOMEM);

-		le->dst_type = entry->bdaddr_type;
+		le->dst_type = bdaddr_type;

  		hci_le_connect(le);

@@ -604,8 +619,8 @@ static int hci_conn_auth(struct hci_conn *conn, __u8 
sec_level, __u8 auth_type)

  	/* Make sure we preserve an existing MITM requirement*/
  	auth_type |= (conn->auth_type & 0x01);
-
  	conn->auth_type = auth_type;
+	conn->auth_initiator = 1;

  	if (!test_and_set_bit(HCI_CONN_AUTH_PEND, &conn->pend)) {
  		struct hci_cp_auth_requested cp;
@@ -636,7 +651,7 @@ static void hci_conn_encrypt(struct hci_conn *conn)
  /* Enable security */
  int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 
auth_type)
  {
-	BT_DBG("conn %p", conn);
+	BT_DBG("conn %p %d %d", conn, sec_level, auth_type);

  	/* For sdp we don't need the link key. */
  	if (sec_level == BT_SECURITY_SDP)
@@ -674,8 +689,19 @@ int hci_conn_security(struct hci_conn *conn, __u8 
sec_level, __u8 auth_type)
  		goto encrypt;

  auth:
-	if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->pend))
+	if (conn->type == LE_LINK) {
+		if (conn->pending_sec_level > sec_level)
+			sec_level = conn->pending_sec_level;
+
+		if (sec_level > conn->sec_level)
+			conn->pending_sec_level = sec_level;
+		hci_proto_connect_cfm(conn, 0);
+		return 0;
+	} else if (conn->link_mode & HCI_LM_ENCRYPT) {
+		return hci_conn_auth(conn, sec_level, auth_type);
+	} else if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, &conn->pend)) {
  		return 0;
+	}

  	if (!hci_conn_auth(conn, sec_level, auth_type))
  		return 0;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b7f6b5b..dbfe890 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -549,7 +549,8 @@ int hci_dev_open(__u16 dev)
  		hci_dev_hold(hdev);
  		set_bit(HCI_UP, &hdev->flags);
  		hci_notify(hdev, HCI_DEV_UP);
-		if (!test_bit(HCI_SETUP, &hdev->flags))
+		if (!test_bit(HCI_SETUP, &hdev->flags) &&
+				hdev->dev_type == HCI_BREDR)
  			mgmt_powered(hdev->id, 1);
  	} else {
  		/* Init failed, cleanup */
@@ -634,7 +635,8 @@ static int hci_dev_do_close(struct hci_dev *hdev)
  	 * and no tasks are scheduled. */
  	hdev->close(hdev);

-	mgmt_powered(hdev->id, 0);
+	if (hdev->dev_type == HCI_BREDR)
+		mgmt_powered(hdev->id, 0);

  	/* Clear flags */
  	hdev->flags = 0;
@@ -929,14 +931,16 @@ static void hci_power_on(struct work_struct *work)

  	BT_DBG("%s", hdev->name);

-	if (hci_dev_open(hdev->id) < 0)
+	if (hci_dev_open(hdev->id) < 0 && !test_bit(HCI_UP, &hdev->flags))
  		return;

-	if (test_bit(HCI_AUTO_OFF, &hdev->flags))
+	if (test_bit(HCI_AUTO_OFF, &hdev->flags) &&
+				hdev->dev_type == HCI_BREDR)
  		mod_timer(&hdev->off_timer,
  				jiffies + msecs_to_jiffies(AUTO_OFF_TIMEOUT));

-	if (test_and_clear_bit(HCI_SETUP, &hdev->flags))
+	if (test_and_clear_bit(HCI_SETUP, &hdev->flags) &&
+				hdev->dev_type == HCI_BREDR)
  		mgmt_index_added(hdev->id);
  }

@@ -1054,7 +1058,7 @@ struct link_key *hci_find_ltk(struct hci_dev 
*hdev, __le16 ediv, u8 rand[8])
  	list_for_each_entry(k, &hdev->link_keys, list) {
  		struct key_master_id *id;

-		if (k->type != HCI_LK_SMP_LTK)
+		if (k->key_type != HCI_LK_SMP_LTK)
  			continue;

  		if (k->dlen != sizeof(*id))
@@ -1071,12 +1075,12 @@ struct link_key *hci_find_ltk(struct hci_dev 
*hdev, __le16 ediv, u8 rand[8])
  EXPORT_SYMBOL(hci_find_ltk);

  struct link_key *hci_find_link_key_type(struct hci_dev *hdev,
-					bdaddr_t *bdaddr, u8 type)
+					bdaddr_t *bdaddr, u8 key_type)
  {
  	struct link_key *k;

  	list_for_each_entry(k, &hdev->link_keys, list)
-		if (k->type == type && bacmp(bdaddr, &k->bdaddr) == 0)
+		if (k->key_type == key_type && bacmp(bdaddr, &k->bdaddr) == 0)
  			return k;

  	return NULL;
@@ -1091,7 +1095,7 @@ int hci_add_link_key(struct hci_dev *hdev, struct 
hci_conn *conn, int new_key,

  	old_key = hci_find_link_key(hdev, bdaddr);
  	if (old_key) {
-		old_key_type = old_key->type;
+		old_key_type = old_key->key_type;
  		key = old_key;
  	} else {
  		old_key_type = conn ? conn->key_type : 0xff;
@@ -1119,9 +1123,9 @@ int hci_add_link_key(struct hci_dev *hdev, struct 
hci_conn *conn, int new_key,
  	key->pin_len = pin_len;

  	if (type == HCI_LK_CHANGED_COMBINATION)
-		key->type = old_key_type;
+		key->key_type = old_key_type;
  	else
-		key->type = type;
+		key->key_type = type;

  	if (!new_key)
  		return 0;
@@ -1139,39 +1143,39 @@ int hci_add_link_key(struct hci_dev *hdev, 
struct hci_conn *conn, int new_key,
  }

  int hci_add_ltk(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
-			u8 key_size, __le16 ediv, u8 rand[8], u8 ltk[16])
+			u8 addr_type, u8 key_size, u8 auth,
+			__le16 ediv, u8 rand[8], u8 ltk[16])
  {
  	struct link_key *key, *old_key;
  	struct key_master_id *id;
-	u8 old_key_type;

-	BT_DBG("%s addr %s", hdev->name, batostr(bdaddr));
+	BT_DBG("%s Auth: %2.2X addr %s", hdev->name, auth, batostr(bdaddr));

  	old_key = hci_find_link_key_type(hdev, bdaddr, HCI_LK_SMP_LTK);
  	if (old_key) {
  		key = old_key;
-		old_key_type = old_key->type;
  	} else {
  		key = kzalloc(sizeof(*key) + sizeof(*id), GFP_ATOMIC);
  		if (!key)
  			return -ENOMEM;
  		list_add(&key->list, &hdev->link_keys);
-		old_key_type = 0xff;
  	}

  	key->dlen = sizeof(*id);

  	bacpy(&key->bdaddr, bdaddr);
+	key->addr_type = addr_type;
  	memcpy(key->val, ltk, sizeof(key->val));
-	key->type = HCI_LK_SMP_LTK;
+	key->key_type = HCI_LK_SMP_LTK;
  	key->pin_len = key_size;
+	key->auth = auth;

  	id = (void *) &key->data;
  	id->ediv = ediv;
  	memcpy(id->rand, rand, sizeof(id->rand));

  	if (new_key)
-		mgmt_new_key(hdev->id, key, old_key_type);
+		mgmt_new_key(hdev->id, key, auth & 0x01);

  	return 0;
  }
@@ -1382,14 +1386,32 @@ int hci_add_adv_entry(struct hci_dev *hdev,
  					struct hci_ev_le_advertising_info *ev)
  {
  	struct adv_entry *entry;
+	u8 flags = 0;
+	int i;
+
+	BT_DBG("");

  	if (!is_connectable_adv(ev->evt_type))
  		return -EINVAL;

+	if (ev->data && ev->length) {
+		for (i = 0; (i + 2) < ev->length; i++)
+			if (ev->data[i+1] == 0x01) {
+				flags = ev->data[i+2];
+				BT_DBG("flags: %2.2x", flags);
+				break;
+			} else {
+				i += ev->data[i];
+			}
+	}
+
+	entry = hci_find_adv_entry(hdev, &ev->bdaddr);
  	/* Only new entries should be added to adv_entries. So, if
  	 * bdaddr was found, don't add it. */
-	if (hci_find_adv_entry(hdev, &ev->bdaddr))
+	if (entry) {
+		entry->flags = flags;
  		return 0;
+	}

  	entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
  	if (!entry)
@@ -1397,6 +1419,7 @@ int hci_add_adv_entry(struct hci_dev *hdev,

  	bacpy(&entry->bdaddr, &ev->bdaddr);
  	entry->bdaddr_type = ev->bdaddr_type;
+	entry->flags = flags;

  	list_add(&entry->list, &hdev->adv_entries);

@@ -1546,7 +1569,8 @@ void hci_unregister_dev(struct hci_dev *hdev)
  		kfree_skb(hdev->reassembly[i]);

  	if (!test_bit(HCI_INIT, &hdev->flags) &&
-					!test_bit(HCI_SETUP, &hdev->flags))
+				!test_bit(HCI_SETUP, &hdev->flags) &&
+				hdev->dev_type == HCI_BREDR)
  		mgmt_index_removed(hdev->id);

  	hci_notify(hdev, HCI_DEV_UNREG);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d8fa657..5eec6be 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -641,6 +641,23 @@ static void hci_cc_read_local_features(struct 
hci_dev *hdev, struct sk_buff *skb

  	memcpy(hdev->features, rp->features, 8);

+	if (hdev->dev_type == HCI_BREDR && test_bit(HCI_INIT, &hdev->flags)) {
+		if (hdev->features[6] & LMP_SIMPLE_PAIR) {
+			u8 mode = 0x01;
+			hci_send_cmd(hdev, HCI_OP_WRITE_SSP_MODE,
+					sizeof(mode), &mode);
+		}
+
+		if (hdev->features[3] & LMP_RSSI_INQ)
+			hci_setup_inquiry_mode(hdev);
+
+		if (hdev->features[7] & LMP_INQ_TX_PWR)
+			hci_send_cmd(hdev, HCI_OP_READ_INQ_RSP_TX_POWER,
+								0, NULL);
+
+		hci_setup_event_mask(hdev);
+	}
+
  	/* Adjust default settings according to features
  	 * supported by device. */

@@ -1071,9 +1088,6 @@ static void hci_cs_auth_requested(struct hci_dev 
*hdev, __u8 status)

  	BT_DBG("%s status 0x%x", hdev->name, status);

-	if (!status)
-		return;
-
  	cp = hci_sent_cmd_data(hdev, HCI_OP_AUTH_REQUESTED);
  	if (!cp)
  		return;
@@ -1082,10 +1096,11 @@ static void hci_cs_auth_requested(struct hci_dev 
*hdev, __u8 status)

  	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(cp->handle));
  	if (conn) {
-		if (conn->state == BT_CONFIG) {
+		if (status && conn->state == BT_CONFIG) {
  			hci_proto_connect_cfm(conn, status);
  			hci_conn_put(conn);
  		}
+		conn->auth_initiator = 1;
  	}

  	hci_dev_unlock(hdev);
@@ -1349,6 +1364,10 @@ static void hci_cs_le_create_conn(struct hci_dev 
*hdev, __u8 status)
  				BT_ERR("No memory for new connection");
  			}
  		}
+
+		if (conn)
+			mod_timer(&conn->disc_timer,
+					jiffies + msecs_to_jiffies(5000));
  	}

  	hci_dev_unlock(hdev);
@@ -1365,13 +1384,19 @@ static inline void 
hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff

  	BT_DBG("%s status %d", hdev->name, status);

-	if (test_and_clear_bit(HCI_INQUIRY, &hdev->flags) &&
-				test_bit(HCI_MGMT, &hdev->flags))
-		mgmt_discovering(hdev->id, 0);
+	if (!lmp_le_capable(hdev)) {
+		clear_bit(HCI_INQUIRY, &hdev->flags);
+		if (test_bit(HCI_MGMT, &hdev->flags))
+			mgmt_discovering(hdev->id, 0);
+	}

  	hci_req_complete(hdev, HCI_OP_INQUIRY, status);

-	hci_conn_check_pending(hdev);
+	if (test_bit(HCI_MGMT, &hdev->flags))
+		mgmt_inquiry_complete_evt(hdev->id, status);
+
+	if (!lmp_le_capable(hdev))
+		hci_conn_check_pending(hdev);
  }

  static inline void hci_inquiry_result_evt(struct hci_dev *hdev, struct 
sk_buff *skb)
@@ -1403,8 +1428,8 @@ static inline void hci_inquiry_result_evt(struct 
hci_dev *hdev, struct sk_buff *
  		data.rssi		= 0x00;
  		data.ssp_mode		= 0x00;
  		hci_inquiry_cache_update(hdev, &data);
-		mgmt_device_found(hdev->id, &info->bdaddr, info->dev_class, 0,
-									NULL);
+		mgmt_device_found(hdev->id, &info->bdaddr, 0, 0,
+					info->dev_class, 0, 0, NULL);
  	}

  	hci_dev_unlock(hdev);
@@ -1438,6 +1463,10 @@ static inline void hci_conn_complete_evt(struct 
hci_dev *hdev, struct sk_buff *s
  			conn->state = BT_CONFIG;
  			hci_conn_hold(conn);
  			conn->disc_timeout = HCI_DISCONN_TIMEOUT;
+			mgmt_connected(hdev->id, &ev->bdaddr, 0);
+		} else if (conn->type == LE_LINK) {
+			conn->state = BT_CONNECTED;
+			conn->disc_timeout = HCI_DISCONN_TIMEOUT;
  			mgmt_connected(hdev->id, &ev->bdaddr, conn->type);
  		} else
  			conn->state = BT_CONNECTED;
@@ -1469,7 +1498,7 @@ static inline void hci_conn_complete_evt(struct 
hci_dev *hdev, struct sk_buff *s
  		}
  	} else {
  		conn->state = BT_CLOSED;
-		if (conn->type == ACL_LINK)
+		if (conn->type == ACL_LINK || conn->type == LE_LINK)
  			mgmt_connect_failed(hdev->id, &ev->bdaddr, ev->status);
  	}

@@ -1668,8 +1697,8 @@ static inline void hci_remote_name_evt(struct 
hci_dev *hdev, struct sk_buff *skb

  	hci_dev_lock(hdev);

-	if (ev->status == 0 && test_bit(HCI_MGMT, &hdev->flags))
-		mgmt_remote_name(hdev->id, &ev->bdaddr, ev->name);
+	if (test_bit(HCI_MGMT, &hdev->flags))
+		mgmt_remote_name(hdev->id, &ev->bdaddr, ev->status, ev->name);

  	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
  	if (!conn)
@@ -2252,32 +2281,32 @@ static inline void 
hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff
  		goto not_found;
  	}

-	BT_DBG("%s found key type %u for %s", hdev->name, key->type,
+	BT_DBG("%s found key type %u for %s", hdev->name, key->key_type,
  							batostr(&ev->bdaddr));

  	if (!test_bit(HCI_DEBUG_KEYS, &hdev->flags) &&
-				key->type == HCI_LK_DEBUG_COMBINATION) {
+				key->key_type == HCI_LK_DEBUG_COMBINATION) {
  		BT_DBG("%s ignoring debug key", hdev->name);
  		goto not_found;
  	}

  	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
  	if (conn) {
-		if (key->type == HCI_LK_UNAUTH_COMBINATION &&
+		if (key->key_type == HCI_LK_UNAUTH_COMBINATION &&
  				conn->auth_type != 0xff &&
  				(conn->auth_type & 0x01)) {
  			BT_DBG("%s ignoring unauthenticated key", hdev->name);
  			goto not_found;
  		}

-		if (key->type == HCI_LK_COMBINATION && key->pin_len < 16 &&
+		if (key->key_type == HCI_LK_COMBINATION && key->pin_len < 16 &&
  				conn->pending_sec_level == BT_SECURITY_HIGH) {
  			BT_DBG("%s ignoring key unauthenticated for high \
  							security", hdev->name);
  			goto not_found;
  		}

-		conn->key_type = key->type;
+		conn->key_type = key->key_type;
  		conn->pin_length = key->pin_len;
  	}

@@ -2413,9 +2442,9 @@ static inline void 
hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct
  			data.rssi		= info->rssi;
  			data.ssp_mode		= 0x00;
  			hci_inquiry_cache_update(hdev, &data);
-			mgmt_device_found(hdev->id, &info->bdaddr,
+			mgmt_device_found(hdev->id, &info->bdaddr, 0, 0,
  						info->dev_class, info->rssi,
-						NULL);
+						0, NULL);
  		}
  	} else {
  		struct inquiry_info_with_rssi *info = (void *) (skb->data + 1);
@@ -2430,9 +2459,9 @@ static inline void 
hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct
  			data.rssi		= info->rssi;
  			data.ssp_mode		= 0x00;
  			hci_inquiry_cache_update(hdev, &data);
-			mgmt_device_found(hdev->id, &info->bdaddr,
+			mgmt_device_found(hdev->id, &info->bdaddr, 0, 0,
  						info->dev_class, info->rssi,
-						NULL);
+						0, NULL);
  		}
  	}

@@ -2579,8 +2608,9 @@ static inline void 
hci_extended_inquiry_result_evt(struct hci_dev *hdev, struct
  		data.rssi		= info->rssi;
  		data.ssp_mode		= 0x01;
  		hci_inquiry_cache_update(hdev, &data);
-		mgmt_device_found(hdev->id, &info->bdaddr, info->dev_class,
-						info->rssi, info->data);
+		mgmt_device_found(hdev->id, &info->bdaddr, 0, 0,
+				info->dev_class, info->rssi,
+				HCI_MAX_EIR_LENGTH, info->data);
  	}

  	hci_dev_unlock(hdev);
@@ -2588,19 +2618,23 @@ static inline void 
hci_extended_inquiry_result_evt(struct hci_dev *hdev, struct

  static inline u8 hci_get_auth_req(struct hci_conn *conn)
  {
+	BT_DBG("%p", conn);
+
  	/* If remote requests dedicated bonding follow that lead */
  	if (conn->remote_auth == 0x02 || conn->remote_auth == 0x03) {
  		/* If both remote and local IO capabilities allow MITM
  		 * protection then require it, otherwise don't */
-		if (conn->remote_cap == 0x03 || conn->io_capability == 0x03)
+		if (conn->remote_cap == 0x03 || conn->io_capability == 0x03) {
  			return 0x02;
-		else
+		} else {
+			conn->auth_type |= 0x01;
  			return 0x03;
+		}
  	}

  	/* If remote requests no-bonding follow that lead */
-	if (conn->remote_auth == 0x00 || conn->remote_auth == 0x01)
-		return conn->remote_auth | (conn->auth_type & 0x01);
+	if (conn->remote_auth <= 0x01)
+		return 0x00;

  	return conn->auth_type;
  }
@@ -2626,11 +2660,15 @@ static inline void 
hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff
  	if (test_bit(HCI_PAIRABLE, &hdev->flags) ||
  			(conn->remote_auth & ~0x01) == HCI_AT_NO_BONDING) {
  		struct hci_cp_io_capability_reply cp;
+		u8 io_cap = conn->io_capability;

+		/* ACL-SSP does not support IO CAP 0x04 */
+		cp.capability = (io_cap == 0x04) ? 0x01 : io_cap;
  		bacpy(&cp.bdaddr, &ev->bdaddr);
-		cp.capability = conn->io_capability;
-		conn->auth_type = hci_get_auth_req(conn);
-		cp.authentication = conn->auth_type;
+		if (conn->auth_initiator)
+			cp.authentication = conn->auth_type;
+		else
+			cp.authentication = hci_get_auth_req(conn);

  		if ((conn->out == 0x01 || conn->remote_oob == 0x01) &&
  				hci_find_remote_oob_data(hdev, &conn->dst))
@@ -2675,24 +2713,28 @@ unlock:
  	hci_dev_unlock(hdev);
  }

-static inline void hci_user_confirm_request_evt(struct hci_dev *hdev,
-							struct sk_buff *skb)
+static inline void hci_user_ssp_confirmation_evt(struct hci_dev *hdev,
+						u8 event, struct sk_buff *skb)
  {
  	struct hci_ev_user_confirm_req *ev = (void *) skb->data;
  	int loc_mitm, rem_mitm, confirm_hint = 0;
  	struct hci_conn *conn;
+	__le32 passkey = 0;

  	BT_DBG("%s", hdev->name);

  	hci_dev_lock(hdev);

-	if (!test_bit(HCI_MGMT, &hdev->flags))
-		goto unlock;
-
  	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
  	if (!conn)
  		goto unlock;

+	if (event != HCI_EV_USER_PASSKEY_REQUEST)
+		passkey = ev->passkey;
+
+	if (event != HCI_EV_USER_CONFIRM_REQUEST)
+		goto confirm;
+
  	loc_mitm = (conn->auth_type & 0x01);
  	rem_mitm = (conn->remote_auth & 0x01);

@@ -2736,7 +2778,8 @@ static inline void 
hci_user_confirm_request_evt(struct hci_dev *hdev,
  	}

  confirm:
-	mgmt_user_confirm_request(hdev->id, &ev->bdaddr, ev->passkey,
+	if (test_bit(HCI_MGMT, &hdev->flags))
+		mgmt_user_confirm_request(hdev->id, &ev->bdaddr, passkey,
  								confirm_hint);

  unlock:
@@ -2855,7 +2898,10 @@ static inline void 
hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff
  	conn->sec_level = BT_SECURITY_LOW;
  	conn->handle = __le16_to_cpu(ev->handle);
  	conn->state = BT_CONNECTED;
+	conn->disc_timeout = HCI_DISCONN_TIMEOUT;
+	mgmt_connected(hdev->id, &ev->bdaddr, 1);

+	hci_conn_hold(conn);
  	hci_conn_hold_device(conn);
  	hci_conn_add_sysfs(conn);

@@ -2865,25 +2911,6 @@ unlock:
  	hci_dev_unlock(hdev);
  }

-static inline void hci_le_adv_report_evt(struct hci_dev *hdev,
-						struct sk_buff *skb)
-{
-	u8 num_reports = skb->data[0];
-	void *ptr = &skb->data[1];
-
-	hci_dev_lock(hdev);
-
-	while (num_reports--) {
-		struct hci_ev_le_advertising_info *ev = ptr;
-
-		hci_add_adv_entry(hdev, ev);
-
-		ptr += sizeof(*ev) + ev->length + 1;
-	}
-
-	hci_dev_unlock(hdev);
-}
-
  static inline void hci_le_ltk_request_evt(struct hci_dev *hdev,
  						struct sk_buff *skb)
  {
@@ -2921,6 +2948,27 @@ not_found:
  	hci_dev_unlock(hdev);
  }

+static inline void hci_le_adv_report_evt(struct hci_dev *hdev,
+						struct sk_buff *skb)
+{
+	struct hci_ev_le_advertising_info *ev;
+	u8 num_reports;
+
+	num_reports = skb->data[0];
+	ev = (void *) &skb->data[1];
+
+	hci_dev_lock(hdev);
+
+	while (num_reports--) {
+		mgmt_device_found(hdev->id, &ev->bdaddr, ev->bdaddr_type,
+				1, NULL, 0, ev->length, ev->data);
+		hci_add_adv_entry(hdev, ev);
+		ev = (void *) (ev->data + ev->length + 1);
+	}
+
+	hci_dev_unlock(hdev);
+}
+
  static inline void hci_le_meta_evt(struct hci_dev *hdev, struct 
sk_buff *skb)
  {
  	struct hci_ev_le_meta *le_ev = (void *) skb->data;
@@ -2950,6 +2998,8 @@ void hci_event_packet(struct hci_dev *hdev, struct 
sk_buff *skb)
  	struct hci_event_hdr *hdr = (void *) skb->data;
  	__u8 event = hdr->evt;

+	BT_DBG("");
+
  	skb_pull(skb, HCI_EVENT_HDR_SIZE);

  	switch (event) {
@@ -3077,8 +3127,10 @@ void hci_event_packet(struct hci_dev *hdev, 
struct sk_buff *skb)
  		hci_io_capa_reply_evt(hdev, skb);
  		break;

+	case HCI_EV_USER_PASSKEY_REQUEST:
+	case HCI_EV_USER_PASSKEY_NOTIFICATION:
  	case HCI_EV_USER_CONFIRM_REQUEST:
-		hci_user_confirm_request_evt(hdev, skb);
+		hci_user_ssp_confirmation_evt(hdev, event, skb);
  		break;

  	case HCI_EV_SIMPLE_PAIR_COMPLETE:
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index f6afe3d..0f3918c 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -49,7 +49,7 @@
  #include <net/bluetooth/bluetooth.h>
  #include <net/bluetooth/hci_core.h>

-static int enable_mgmt;
+static int enable_mgmt = 1;

  /* ----- HCI socket interface ----- */

@@ -281,7 +281,12 @@ static int hci_sock_ioctl(struct socket *sock, 
unsigned int cmd, unsigned long a
  	case HCIDEVUP:
  		if (!capable(CAP_NET_ADMIN))
  			return -EACCES;
-		return hci_dev_open(arg);
+
+		err =  hci_dev_open(arg);
+		if (!err || err == -EALREADY)
+			return 0;
+		else
+			return err;

  	case HCIDEVDOWN:
  		if (!capable(CAP_NET_ADMIN))
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 6e0d4ce..0f80c7e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -947,7 +947,13 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
  		bh_lock_sock(sk);

  		if (conn->hcon->type == LE_LINK) {
-			if (smp_conn_security(conn, chan->sec_level))
+			u8 sec_level = chan->sec_level;
+			u8 pending_sec = conn->hcon->pending_sec_level;
+
+			if (pending_sec > sec_level)
+				sec_level = pending_sec;
+
+			if (smp_conn_security(conn, sec_level))
  				l2cap_chan_ready(sk);

  		} else if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
@@ -958,6 +964,7 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
  		} else if (chan->state == BT_CONNECT)
  			l2cap_do_start(chan);

+
  		bh_unlock_sock(sk);
  	}

@@ -1033,6 +1040,7 @@ static void security_timeout(unsigned long arg)
  {
  	struct l2cap_conn *conn = (void *) arg;

+	smp_timeout(conn);
  	l2cap_conn_del(conn->hcon, ETIMEDOUT);
  }

@@ -4456,7 +4464,6 @@ static int l2cap_security_cfm(struct hci_conn 
*hcon, u8 status, u8 encrypt)
  	BT_DBG("conn %p", conn);

  	if (hcon->type == LE_LINK) {
-		smp_distribute_keys(conn, 0);
  		del_timer(&conn->security_timer);
  	}

@@ -4475,6 +4482,10 @@ static int l2cap_security_cfm(struct hci_conn 
*hcon, u8 status, u8 encrypt)
  				l2cap_chan_ready(sk);
  			}

+			del_timer(&conn->security_timer);
+			l2cap_chan_ready(sk);
+			smp_link_encrypt_cmplt(conn, status, encrypt);
+
  			bh_unlock_sock(sk);
  			continue;
  		}
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 747366a..766660a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -27,11 +27,28 @@

  #include <net/bluetooth/bluetooth.h>
  #include <net/bluetooth/hci_core.h>
+#include <net/bluetooth/l2cap.h>
  #include <net/bluetooth/mgmt.h>
+#include <net/bluetooth/smp.h>

  #define MGMT_VERSION	0
  #define MGMT_REVISION	1

+enum scan_mode {
+	SCAN_IDLE,
+	SCAN_LE,
+	SCAN_BR
+};
+
+struct disco_interleave {
+	struct timer_list	timer;
+	struct timer_list	le_timer;
+	u16			index;
+	enum scan_mode		mode;
+	int			int_phase;
+	int			int_count;
+};
+
  struct pending_cmd {
  	struct list_head list;
  	__u16 opcode;
@@ -134,6 +151,9 @@ static int read_index_list(struct sock *sk)

  	count = 0;
  	list_for_each(p, &hci_dev_list) {
+		struct hci_dev *d = list_entry(p, struct hci_dev, list);
+		if (d->dev_type != HCI_BREDR)
+			continue;
  		count++;
  	}

@@ -144,16 +164,20 @@ static int read_index_list(struct sock *sk)
  		return -ENOMEM;
  	}

-	put_unaligned_le16(count, &rp->num_controllers);
+	put_unaligned_le16(0, &rp->num_controllers);

  	i = 0;
  	list_for_each_entry(d, &hci_dev_list, list) {
  		hci_del_off_timer(d);

+		if (d->dev_type != HCI_BREDR)
+			continue;
+
  		if (test_bit(HCI_SETUP, &d->flags))
  			continue;

  		put_unaligned_le16(d->id, &rp->index[i++]);
+		put_unaligned_le16((u16)i, &rp->num_controllers);
  		BT_DBG("Added hci%u", d->id);
  	}

@@ -217,6 +241,8 @@ static int read_controller_info(struct sock *sk, u16 
index)

  static void mgmt_pending_free(struct pending_cmd *cmd)
  {
+	BT_DBG("%d", cmd->opcode);
+
  	sock_put(cmd->sk);
  	kfree(cmd->param);
  	kfree(cmd);
@@ -227,6 +253,8 @@ static struct pending_cmd *mgmt_pending_add(struct 
sock *sk, u16 opcode,
  {
  	struct pending_cmd *cmd;

+	BT_DBG("%d", opcode);
+
  	cmd = kmalloc(sizeof(*cmd), GFP_ATOMIC);
  	if (!cmd)
  		return NULL;
@@ -257,6 +285,8 @@ static void mgmt_pending_foreach(u16 opcode, int index,
  {
  	struct list_head *p, *n;

+	BT_DBG(" %d", opcode);
+
  	list_for_each_safe(p, n, &cmd_list) {
  		struct pending_cmd *cmd;

@@ -291,6 +321,8 @@ static struct pending_cmd *mgmt_pending_find(u16 
opcode, int index)

  static void mgmt_pending_remove(struct pending_cmd *cmd)
  {
+	BT_DBG(" %d", cmd->opcode);
+
  	list_del(&cmd->list);
  	mgmt_pending_free(cmd);
  }
@@ -345,6 +377,124 @@ failed:
  	return err;
  }

+static u8 get_service_classes(struct hci_dev *hdev)
+{
+	struct list_head *p;
+	u8 val = 0;
+
+	list_for_each(p, &hdev->uuids) {
+		struct bt_uuid *uuid = list_entry(p, struct bt_uuid, list);
+
+		val |= uuid->svc_hint;
+	}
+
+	return val;
+}
+
+static int update_class(struct hci_dev *hdev)
+{
+	u8 cod[3];
+
+	BT_DBG("%s", hdev->name);
+
+	if (test_bit(HCI_SERVICE_CACHE, &hdev->flags))
+		return 0;
+
+	cod[0] = hdev->minor_class;
+	cod[1] = hdev->major_class;
+	cod[2] = get_service_classes(hdev);
+
+	if (memcmp(cod, hdev->dev_class, 3) == 0)
+		return 0;
+
+	return hci_send_cmd(hdev, HCI_OP_WRITE_CLASS_OF_DEV, sizeof(cod), cod);
+}
+
+static int set_limited_discoverable(struct sock *sk, u16 index,
+						unsigned char *data, u16 len)
+{
+	struct mgmt_mode *cp;
+	struct hci_dev *hdev;
+	struct pending_cmd *cmd;
+	struct hci_cp_write_current_iac_lap dcp;
+	int update_cod;
+	int err = 0;
+	/* General Inquiry LAP: 0x9E8B33, Limited Inquiry LAP: 0x9E8B00 */
+	u8 lap[] = { 0x33, 0x8b, 0x9e, 0x00, 0x8b, 0x9e };
+
+	cp = (void *) data;
+
+	BT_DBG("hci%u discoverable: %d", index, cp->val);
+
+	if (!cp || len != sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_SET_LIMIT_DISCOVERABLE,
+									EINVAL);
+
+	hdev = hci_dev_get(index);
+	if (!hdev)
+		return cmd_status(sk, index, MGMT_OP_SET_LIMIT_DISCOVERABLE,
+									ENODEV);
+
+	hci_dev_lock(hdev);
+
+	if (!test_bit(HCI_UP, &hdev->flags)) {
+		err = cmd_status(sk, index, MGMT_OP_SET_LIMIT_DISCOVERABLE,
+								ENETDOWN);
+		goto failed;
+	}
+
+	if (mgmt_pending_find(MGMT_OP_SET_LIMIT_DISCOVERABLE, index)) {
+		err = cmd_status(sk, index, MGMT_OP_SET_LIMIT_DISCOVERABLE,
+									EBUSY);
+		goto failed;
+	}
+
+	if (cp->val == test_bit(HCI_ISCAN, &hdev->flags) &&
+					test_bit(HCI_PSCAN, &hdev->flags)) {
+		err = cmd_status(sk, index, MGMT_OP_SET_LIMIT_DISCOVERABLE,
+								EALREADY);
+		goto failed;
+	}
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_LIMIT_DISCOVERABLE, index, data,
+									len);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto failed;
+	}
+
+	memset(&dcp, 0, sizeof(dcp));
+	dcp.num_current_iac = cp->val ? 2 : 1;
+	memcpy(&dcp.lap, lap, dcp.num_current_iac * 3);
+	update_cod = 1;
+
+	if (cp->val) {
+		if (hdev->major_class & MGMT_MAJOR_CLASS_LIMITED)
+			update_cod = 0;
+		hdev->major_class |= MGMT_MAJOR_CLASS_LIMITED;
+	} else {
+		if (!(hdev->major_class & MGMT_MAJOR_CLASS_LIMITED))
+			update_cod = 0;
+		hdev->major_class &= ~MGMT_MAJOR_CLASS_LIMITED;
+	}
+
+	if (update_cod)
+		err = update_class(hdev);
+
+	if (err >= 0)
+		err = hci_send_cmd(hdev, HCI_OP_WRITE_CURRENT_IAC_LAP,
+							sizeof(dcp), &dcp);
+
+	if (err < 0)
+		mgmt_pending_remove(cmd);
+
+failed:
+	hci_dev_unlock(hdev);
+	hci_dev_put(hdev);
+
+	return err;
+}
+
  static int set_discoverable(struct sock *sk, u16 index, unsigned char 
*data,
  									u16 len)
  {
@@ -472,6 +622,8 @@ static int mgmt_event(u16 event, u16 index, void 
*data, u16 data_len,
  	struct sk_buff *skb;
  	struct mgmt_hdr *hdr;

+	BT_DBG("hci%d %d", index, event);
+
  	skb = alloc_skb(sizeof(*hdr) + data_len, GFP_ATOMIC);
  	if (!skb)
  		return -ENOMEM;
@@ -684,36 +836,6 @@ static int update_eir(struct hci_dev *hdev)
  	return hci_send_cmd(hdev, HCI_OP_WRITE_EIR, sizeof(cp), &cp);
  }

-static u8 get_service_classes(struct hci_dev *hdev)
-{
-	struct bt_uuid *uuid;
-	u8 val = 0;
-
-	list_for_each_entry(uuid, &hdev->uuids, list)
-		val |= uuid->svc_hint;
-
-	return val;
-}
-
-static int update_class(struct hci_dev *hdev)
-{
-	u8 cod[3];
-
-	BT_DBG("%s", hdev->name);
-
-	if (test_bit(HCI_SERVICE_CACHE, &hdev->flags))
-		return 0;
-
-	cod[0] = hdev->minor_class;
-	cod[1] = hdev->major_class;
-	cod[2] = get_service_classes(hdev);
-
-	if (memcmp(cod, hdev->dev_class, 3) == 0)
-		return 0;
-
-	return hci_send_cmd(hdev, HCI_OP_WRITE_CLASS_OF_DEV, sizeof(cod), cod);
-}
-
  static int add_uuid(struct sock *sk, u16 index, unsigned char *data, 
u16 len)
  {
  	struct mgmt_cp_add_uuid *cp;
@@ -842,7 +964,8 @@ static int set_dev_class(struct sock *sk, u16 index, 
unsigned char *data,

  	hci_dev_lock_bh(hdev);

-	hdev->major_class = cp->major;
+	hdev->major_class &= ~MGMT_MAJOR_CLASS_MASK;
+	hdev->major_class |= cp->major & MGMT_MAJOR_CLASS_MASK;
  	hdev->minor_class = cp->minor;

  	err = update_class(hdev);
@@ -914,9 +1037,9 @@ static int load_keys(struct sock *sk, u16 index, 
unsigned char *data, u16 len)
  	key_count = get_unaligned_le16(&cp->key_count);

  	expected_len = sizeof(*cp) + key_count * sizeof(struct mgmt_key_info);
-	if (expected_len != len) {
+	if (expected_len > len) {
  		BT_ERR("load_keys: expected %u bytes, got %u bytes",
-							len, expected_len);
+							expected_len, len);
  		return cmd_status(sk, index, MGMT_OP_LOAD_KEYS, EINVAL);
  	}

@@ -938,11 +1061,31 @@ static int load_keys(struct sock *sk, u16 index, 
unsigned char *data, u16 len)
  	else
  		clear_bit(HCI_DEBUG_KEYS, &hdev->flags);

-	for (i = 0; i < key_count; i++) {
-		struct mgmt_key_info *key = &cp->keys[i];
+	len -= sizeof(*cp);
+	i = 0;
+
+	while (i < len) {
+		struct mgmt_key_info *key = (void *) cp->keys + i;
+
+		i += sizeof(*key);
+
+		if (key->key_type == KEY_TYPE_LTK) {
+			struct key_master_id *id = (void *) key->data;

-		hci_add_link_key(hdev, NULL, 0, &key->bdaddr, key->val, key->type,
-								key->pin_len);
+			i += key->dlen;
+
+			if (key->dlen != sizeof(struct key_master_id))
+				continue;
+
+			hci_add_ltk(hdev, 0, &key->bdaddr, key->addr_type,
+					key->pin_len, key->auth, id->ediv,
+					id->rand, key->val);
+
+			continue;
+		}
+
+		hci_add_link_key(hdev, NULL, 0, &key->bdaddr, key->val,
+						key->key_type, key->pin_len);
  	}

  	hci_dev_unlock_bh(hdev);
@@ -1283,6 +1426,8 @@ static void pairing_complete(struct pending_cmd 
*cmd, u8 status)
  	struct mgmt_rp_pair_device rp;
  	struct hci_conn *conn = cmd->user_data;

+	BT_DBG(" %u", status);
+
  	bacpy(&rp.bdaddr, &conn->dst);
  	rp.status = status;

@@ -1293,8 +1438,6 @@ static void pairing_complete(struct pending_cmd 
*cmd, u8 status)
  	conn->security_cfm_cb = NULL;
  	conn->disconn_cfm_cb = NULL;

-	hci_conn_put(conn);
-
  	mgmt_pending_remove(cmd);
  }

@@ -1302,7 +1445,7 @@ static void pairing_complete_cb(struct hci_conn 
*conn, u8 status)
  {
  	struct pending_cmd *cmd;

-	BT_DBG("status %u", status);
+	BT_DBG(" %u", status);

  	cmd = find_pairing(conn);
  	if (!cmd) {
@@ -1313,13 +1456,65 @@ static void pairing_complete_cb(struct hci_conn 
*conn, u8 status)
  	pairing_complete(cmd, status);
  }

+static void pairing_security_complete_cb(struct hci_conn *conn, u8 status)
+{
+	struct pending_cmd *cmd;
+
+	BT_DBG(" %u", status);
+
+	cmd = find_pairing(conn);
+	if (!cmd) {
+		BT_DBG("Unable to find a pending command");
+		return;
+	}
+
+	if (conn->type == LE_LINK)
+		smp_link_encrypt_cmplt(conn->l2cap_data, status,
+				status ? 0 : 1);
+	else
+		pairing_complete(cmd, status);
+}
+
+static void pairing_connect_complete_cb(struct hci_conn *conn, u8 status)
+{
+	struct pending_cmd *cmd;
+
+	BT_DBG("conn: %p %u", conn, status);
+
+	cmd = find_pairing(conn);
+	if (!cmd) {
+		BT_DBG("Unable to find a pending command");
+		return;
+	}
+
+	if (status)
+		pairing_complete(cmd, status);
+
+	hci_conn_put(conn);
+}
+
+static void discovery_terminated(struct pending_cmd *cmd, void *data)
+{
+	struct mgmt_mode ev = {0};
+	struct disco_interleave *ilp = cmd->param;
+
+	BT_DBG("");
+	del_timer_sync(&ilp->le_timer);
+	del_timer_sync(&ilp->timer);
+	mgmt_event(MGMT_EV_DISCOVERING, cmd->index, &ev, sizeof(ev), NULL);
+
+	list_del(&cmd->list);
+
+	mgmt_pending_free(cmd);
+}
+
  static int pair_device(struct sock *sk, u16 index, unsigned char 
*data, u16 len)
  {
  	struct hci_dev *hdev;
  	struct mgmt_cp_pair_device *cp;
  	struct pending_cmd *cmd;
  	struct adv_entry *entry;
-	u8 sec_level, auth_type;
+	u8 sec_level, auth_type, io_cap;
  	struct hci_conn *conn;
  	int err;

@@ -1331,24 +1526,30 @@ static int pair_device(struct sock *sk, u16 
index, unsigned char *data, u16 len)
  		return cmd_status(sk, index, MGMT_OP_PAIR_DEVICE, EINVAL);

  	hdev = hci_dev_get(index);
+
  	if (!hdev)
  		return cmd_status(sk, index, MGMT_OP_PAIR_DEVICE, ENODEV);

  	hci_dev_lock_bh(hdev);

  	sec_level = BT_SECURITY_MEDIUM;
-	if (cp->io_cap == 0x03)
+	io_cap = cp->io_cap;
+	if ((io_cap == 0) || (io_cap == 0x03))
  		auth_type = HCI_AT_DEDICATED_BONDING;
  	else
  		auth_type = HCI_AT_DEDICATED_BONDING_MITM;

  	entry = hci_find_adv_entry(hdev, &cp->bdaddr);
-	if (entry)
+	if (entry && entry->flags & 0x04) {
  		conn = hci_connect(hdev, LE_LINK, &cp->bdaddr, sec_level,
  								auth_type);
-	else
+	} else {
+		/* ACL-SSP does not support io_cap 0x04 (KeyboadDisplay) */
+		if (io_cap == 0x04)
+			io_cap = 0x01;
  		conn = hci_connect(hdev, ACL_LINK, &cp->bdaddr, sec_level,
  								auth_type);
+	}

  	if (IS_ERR(conn)) {
  		err = PTR_ERR(conn);
@@ -1369,12 +1570,10 @@ static int pair_device(struct sock *sk, u16 
index, unsigned char *data, u16 len)
  	}

  	/* For LE, just connecting isn't a proof that the pairing finished */
-	if (!entry)
-		conn->connect_cfm_cb = pairing_complete_cb;
-
-	conn->security_cfm_cb = pairing_complete_cb;
+	conn->connect_cfm_cb = pairing_connect_complete_cb;
+	conn->security_cfm_cb = pairing_security_complete_cb;
  	conn->disconn_cfm_cb = pairing_complete_cb;
-	conn->io_capability = cp->io_cap;
+	conn->io_capability = io_cap;
  	cmd->user_data = conn;

  	if (conn->state == BT_CONNECTED &&
@@ -1391,25 +1590,23 @@ unlock:
  }

  static int user_confirm_reply(struct sock *sk, u16 index, unsigned 
char *data,
-							u16 len, int success)
+							u16 len, u16 opcode)
  {
  	struct mgmt_cp_user_confirm_reply *cp = (void *) data;
-	u16 mgmt_op, hci_op;
+	u16 mgmt_op = opcode, hci_op;
  	struct pending_cmd *cmd;
  	struct hci_dev *hdev;
+	struct hci_conn *le_conn;
  	int err;

-	BT_DBG("");
+	BT_DBG("%d", mgmt_op);

-	if (success) {
-		mgmt_op = MGMT_OP_USER_CONFIRM_REPLY;
-		hci_op = HCI_OP_USER_CONFIRM_REPLY;
-	} else {
-		mgmt_op = MGMT_OP_USER_CONFIRM_NEG_REPLY;
+	if (mgmt_op == MGMT_OP_USER_CONFIRM_NEG_REPLY)
  		hci_op = HCI_OP_USER_CONFIRM_NEG_REPLY;
-	}
+	else
+		hci_op = HCI_OP_USER_CONFIRM_REPLY;

-	if (len != sizeof(*cp))
+	if (len < sizeof(*cp))
  		return cmd_status(sk, index, mgmt_op, EINVAL);

  	hdev = hci_dev_get(index);
@@ -1420,19 +1617,67 @@ static int user_confirm_reply(struct sock *sk, 
u16 index, unsigned char *data,

  	if (!test_bit(HCI_UP, &hdev->flags)) {
  		err = cmd_status(sk, index, mgmt_op, ENETDOWN);
-		goto failed;
+		goto done;
+	}
+
+	le_conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->bdaddr);
+	if (le_conn) {
+		err = smp_user_confirm_reply(le_conn, mgmt_op, (void *) cp);
+		goto done;
  	}
+	BT_DBG("BR/EDR: %s", mgmt_op == MGMT_OP_USER_CONFIRM_NEG_REPLY ?
+							"Reject" : "Accept");

  	cmd = mgmt_pending_add(sk, mgmt_op, index, data, len);
  	if (!cmd) {
  		err = -ENOMEM;
-		goto failed;
+		goto done;
  	}

  	err = hci_send_cmd(hdev, hci_op, sizeof(cp->bdaddr), &cp->bdaddr);
  	if (err < 0)
  		mgmt_pending_remove(cmd);

+done:
+	hci_dev_unlock(hdev);
+	hci_dev_put(hdev);
+
+	return err;
+}
+
+static int resolve_name(struct sock *sk, u16 index, unsigned char *data,
+								u16 len)
+{
+	struct mgmt_cp_resolve_name *mgmt_cp = (void *) data;
+	struct hci_cp_remote_name_req hci_cp;
+	struct hci_dev *hdev;
+	struct pending_cmd *cmd;
+	int err;
+
+	BT_DBG("");
+
+	if (len != sizeof(*mgmt_cp))
+		return cmd_status(sk, index, MGMT_OP_RESOLVE_NAME, EINVAL);
+
+	hdev = hci_dev_get(index);
+	if (!hdev)
+		return cmd_status(sk, index, MGMT_OP_RESOLVE_NAME, ENODEV);
+
+	hci_dev_lock(hdev);
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_RESOLVE_NAME, index, data, len);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto failed;
+	}
+
+	memset(&hci_cp, 0, sizeof(hci_cp));
+	bacpy(&hci_cp.bdaddr, &mgmt_cp->bdaddr);
+	err = hci_send_cmd(hdev, HCI_OP_REMOTE_NAME_REQ, sizeof(hci_cp),
+								&hci_cp);
+	if (err < 0)
+		mgmt_pending_remove(cmd);
+
  failed:
  	hci_dev_unlock_bh(hdev);
  	hci_dev_put(hdev);
@@ -1479,6 +1724,169 @@ failed:
  	return err;
  }

+static void discovery_rsp(struct pending_cmd *cmd, void *data)
+{
+	struct mgmt_mode ev;
+
+	BT_DBG("");
+	if (cmd->opcode == MGMT_OP_START_DISCOVERY) {
+		ev.val = 1;
+		cmd_status(cmd->sk, cmd->index, MGMT_OP_START_DISCOVERY, 0);
+	} else {
+		ev.val = 0;
+		cmd_complete(cmd->sk, cmd->index, MGMT_OP_STOP_DISCOVERY,
+								NULL, 0);
+		if (cmd->opcode == MGMT_OP_STOP_DISCOVERY) {
+			struct disco_interleave *ilp = cmd->param;
+
+			del_timer_sync(&ilp->le_timer);
+			del_timer_sync(&ilp->timer);
+		}
+	}
+
+	mgmt_event(MGMT_EV_DISCOVERING, cmd->index, &ev, sizeof(ev), NULL);
+
+	list_del(&cmd->list);
+
+	mgmt_pending_free(cmd);
+}
+
+void mgmt_inquiry_started(u16 index)
+{
+	BT_DBG("");
+	mgmt_pending_foreach(MGMT_OP_START_DISCOVERY, index,
+						discovery_rsp, NULL);
+}
+
+void mgmt_inquiry_complete_evt(u16 index, u8 status)
+{
+	struct hci_dev *hdev;
+	struct hci_cp_le_set_scan_enable le_cp = {1, 0};
+	struct pending_cmd *cmd;
+	int err = -1;
+
+	BT_DBG("");
+
+	hdev = hci_dev_get(index);
+
+	if (hdev)
+		hci_dev_lock(hdev);
+
+	if (!hdev || !lmp_le_capable(hdev)) {
+		struct mgmt_mode cp = {0};
+
+		mgmt_pending_foreach(MGMT_OP_STOP_DISCOVERY, index,
+						discovery_terminated, NULL);
+
+		mgmt_event(MGMT_EV_DISCOVERING, index, &cp, sizeof(cp), NULL);
+
+		if (hdev)
+			goto done;
+		else
+			return;
+	}
+
+	cmd = mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, index);
+	if (cmd && cmd->param) {
+		struct disco_interleave *ilp = cmd->param;
+
+		err = hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE,
+						sizeof(le_cp), &le_cp);
+		if (err >= 0) {
+			mod_timer(&ilp->le_timer, jiffies +
+				msecs_to_jiffies(ilp->int_phase * 1000));
+			ilp->mode = SCAN_LE;
+		} else
+			ilp->mode = SCAN_IDLE;
+	}
+
+	if (err < 0)
+		mgmt_pending_foreach(MGMT_OP_STOP_DISCOVERY, index,
+						discovery_terminated, NULL);
+
+done:
+	hci_dev_unlock(hdev);
+	hci_dev_put(hdev);
+}
+
+static void disco_to(unsigned long data)
+{
+	struct disco_interleave *ilp = (void *)data;
+	struct hci_dev *hdev;
+	struct pending_cmd *cmd;
+
+	BT_DBG("hci%d", ilp->index);
+
+	del_timer_sync(&ilp->le_timer);
+	hdev = hci_dev_get(ilp->index);
+
+	if (hdev) {
+		hci_dev_lock(hdev);
+
+		cmd = mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, ilp->index);
+
+		if (ilp->mode != SCAN_IDLE) {
+			struct hci_cp_le_set_scan_enable le_cp = {0, 0};
+
+			if (ilp->mode == SCAN_LE)
+				hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE,
+							sizeof(le_cp), &le_cp);
+			else
+				hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL,
+								0, NULL);
+
+			ilp->mode = SCAN_IDLE;
+		}
+
+		if (cmd) {
+			struct mgmt_mode cp = {0};
+
+			mgmt_event(MGMT_EV_DISCOVERING, ilp->index, &cp,
+							sizeof(cp), NULL);
+			mgmt_pending_remove(cmd);
+		}
+
+		hci_dev_unlock(hdev);
+		hci_dev_put(hdev);
+	}
+}
+
+static void disco_le_to(unsigned long data)
+{
+	struct disco_interleave *ilp = (void *)data;
+	struct hci_dev *hdev;
+	struct pending_cmd *cmd;
+	struct hci_cp_le_set_scan_enable le_cp = {0, 0};
+
+	BT_DBG("hci%d", ilp->index);
+
+	hdev = hci_dev_get(ilp->index);
+
+	if (hdev) {
+		hci_dev_lock(hdev);
+
+		cmd = mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, ilp->index);
+
+		if (ilp->mode == SCAN_LE)
+			hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE,
+							sizeof(le_cp), &le_cp);
+
+		/* re-start BR scan */
+		if (cmd) {
+			struct hci_cp_inquiry cp = {{0x33, 0x8b, 0x9e}, 4, 0};
+			ilp->int_phase *= 2;
+			ilp->int_count = 0;
+			cp.num_rsp = (u8) ilp->int_phase;
+			hci_send_cmd(hdev, HCI_OP_INQUIRY, sizeof(cp), &cp);
+			ilp->mode = SCAN_BR;
+		} else
+			ilp->mode = SCAN_IDLE;
+
+		hci_dev_unlock(hdev);
+		hci_dev_put(hdev);
+	}
+}
+
  static int read_local_oob_data(struct sock *sk, u16 index)
  {
  	struct hci_dev *hdev;
@@ -1598,19 +2006,18 @@ static int remove_remote_oob_data(struct sock 
*sk, u16 index,

  static int start_discovery(struct sock *sk, u16 index)
  {
-	u8 lap[3] = { 0x33, 0x8b, 0x9e };
-	struct hci_cp_inquiry cp;
-	struct pending_cmd *cmd;
+	struct hci_cp_inquiry cp = {{0x33, 0x8b, 0x9e}, 8, 0};
  	struct hci_dev *hdev;
+	struct pending_cmd *cmd;
  	int err;

-	BT_DBG("hci%u", index);
+	BT_DBG("");

  	hdev = hci_dev_get(index);
  	if (!hdev)
  		return cmd_status(sk, index, MGMT_OP_START_DISCOVERY, ENODEV);

-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);

  	cmd = mgmt_pending_add(sk, MGMT_OP_START_DISCOVERY, index, NULL, 0);
  	if (!cmd) {
@@ -1618,17 +2025,54 @@ static int start_discovery(struct sock *sk, u16 
index)
  		goto failed;
  	}

-	memset(&cp, 0, sizeof(cp));
-	memcpy(&cp.lap, lap, 3);
-	cp.length  = 0x08;
-	cp.num_rsp = 0x00;
+	/* If LE Capable, we will alternate between BR/EDR and LE */
+	if (lmp_le_capable(hdev)) {
+		struct hci_cp_le_set_scan_parameters le_cp;
+
+		/* Shorten BR scan params */
+		cp.num_rsp = 1;
+		cp.length /= 2;
+
+		/* Setup LE scan params */
+		memset(&le_cp, 0, sizeof(le_cp));
+		le_cp.type = 0x01;		/* Active scanning */
+		/* The recommended value for scan interval and window is
+		 * 11.25 msec. It is calculated by: time = n * 0.625 msec */
+		le_cp.interval = cpu_to_le16(0x0012);
+		le_cp.window = cpu_to_le16(0x0012);
+		le_cp.own_bdaddr_type = 0;	/* Public address */
+		le_cp.filter = 0;		/* Accept all adv packets */
+
+		hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_PARAMETERS,
+						sizeof(le_cp), &le_cp);
+	}

  	err = hci_send_cmd(hdev, HCI_OP_INQUIRY, sizeof(cp), &cp);
+
  	if (err < 0)
  		mgmt_pending_remove(cmd);
+	else if (lmp_le_capable(hdev)) {
+		struct disco_interleave il, *ilp;
+
+		il.int_phase = 1;
+		il.int_count = 0;
+		il.index = index;
+		il.mode = SCAN_BR;
+		mgmt_pending_add(sk, MGMT_OP_STOP_DISCOVERY, index, &il,
+					sizeof(struct disco_interleave));
+		cmd = mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, index);
+		if (cmd) {
+			ilp = cmd->param;
+			setup_timer(&ilp->le_timer, disco_le_to,
+							(unsigned long) ilp);
+			setup_timer(&ilp->timer, disco_to, (unsigned long) ilp);
+			mod_timer(&ilp->timer,
+					jiffies + msecs_to_jiffies(20000));
+		}
+	}

  failed:
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
  	hci_dev_put(hdev);

  	return err;
@@ -1636,33 +2080,60 @@ failed:

  static int stop_discovery(struct sock *sk, u16 index)
  {
+	struct hci_cp_le_set_scan_enable le_cp = {0, 0};
+	struct mgmt_mode mode_cp = {0};
+	struct disco_interleave *ilp = NULL;
  	struct hci_dev *hdev;
-	struct pending_cmd *cmd;
-	int err;
+	struct pending_cmd *cmd = NULL;
+	int err = -EPERM;

-	BT_DBG("hci%u", index);
+	BT_DBG("");

  	hdev = hci_dev_get(index);
  	if (!hdev)
  		return cmd_status(sk, index, MGMT_OP_STOP_DISCOVERY, ENODEV);

-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);

-	cmd = mgmt_pending_add(sk, MGMT_OP_STOP_DISCOVERY, index, NULL, 0);
-	if (!cmd) {
-		err = -ENOMEM;
-		goto failed;
+	if (lmp_le_capable(hdev)) {
+		cmd = mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, index);
+		if (!cmd) {
+			err = -ENOMEM;
+			goto failed;
+		}
+
+		ilp = cmd->param;
  	}

-	err = hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
-	if (err < 0)
+	if (lmp_le_capable(hdev) && ilp && (ilp->mode == SCAN_LE))
+		err = hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE,
+							sizeof(le_cp), &le_cp);
+
+	if (err < 0) {
+		if (!ilp || (ilp->mode == SCAN_BR))
+			err = hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL,
+								0, NULL);
+	}
+
+	if (ilp) {
+		ilp->mode = SCAN_IDLE;
+		del_timer_sync(&ilp->le_timer);
+		del_timer_sync(&ilp->timer);
+	}
+
+	if (err < 0 && cmd)
  		mgmt_pending_remove(cmd);

+	mgmt_event(MGMT_EV_DISCOVERING, index, &mode_cp, sizeof(mode_cp), NULL);
+
  failed:
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
  	hci_dev_put(hdev);

-	return err;
+	if (err < 0)
+		return cmd_status(sk, index, MGMT_OP_STOP_DISCOVERY, -err);
+	else
+		return err;
  }

  static int block_device(struct sock *sk, u16 index, unsigned char *data,
@@ -1840,6 +2311,7 @@ int mgmt_control(struct sock *sk, struct msghdr 
*msg, size_t msglen)
  		goto done;
  	}

+	BT_DBG("got opcode %x", opcode);
  	switch (opcode) {
  	case MGMT_OP_READ_VERSION:
  		err = read_version(sk);
@@ -1856,6 +2328,10 @@ int mgmt_control(struct sock *sk, struct msghdr 
*msg, size_t msglen)
  	case MGMT_OP_SET_DISCOVERABLE:
  		err = set_discoverable(sk, index, buf + sizeof(*hdr), len);
  		break;
+	case MGMT_OP_SET_LIMIT_DISCOVERABLE:
+		err = set_limited_discoverable(sk, index, buf + sizeof(*hdr),
+									len);
+		break;
  	case MGMT_OP_SET_CONNECTABLE:
  		err = set_connectable(sk, index, buf + sizeof(*hdr), len);
  		break;
@@ -1899,14 +2375,17 @@ int mgmt_control(struct sock *sk, struct msghdr 
*msg, size_t msglen)
  		err = pair_device(sk, index, buf + sizeof(*hdr), len);
  		break;
  	case MGMT_OP_USER_CONFIRM_REPLY:
-		err = user_confirm_reply(sk, index, buf + sizeof(*hdr), len, 1);
-		break;
+	case MGMT_OP_USER_PASSKEY_REPLY:
  	case MGMT_OP_USER_CONFIRM_NEG_REPLY:
-		err = user_confirm_reply(sk, index, buf + sizeof(*hdr), len, 0);
+		err = user_confirm_reply(sk, index, buf + sizeof(*hdr),
+								len, opcode);
  		break;
  	case MGMT_OP_SET_LOCAL_NAME:
  		err = set_local_name(sk, index, buf + sizeof(*hdr), len);
  		break;
+	case MGMT_OP_RESOLVE_NAME:
+		err = resolve_name(sk, index, buf + sizeof(*hdr), len);
+		break;
  	case MGMT_OP_READ_LOCAL_OOB_DATA:
  		err = read_local_oob_data(sk, index);
  		break;
@@ -1959,6 +2438,7 @@ static void cmd_status_rsp(struct pending_cmd 
*cmd, void *data)

  int mgmt_index_added(u16 index)
  {
+	BT_DBG("%d", index);
  	return mgmt_event(MGMT_EV_INDEX_ADDED, index, NULL, 0, NULL);
  }

@@ -2002,6 +2482,8 @@ int mgmt_powered(u16 index, u8 powered)
  	struct cmd_lookup match = { powered, NULL };
  	int ret;

+	BT_DBG("hci%u %d", index, powered);
+
  	mgmt_pending_foreach(MGMT_OP_SET_POWERED, index, mode_rsp, &match);

  	if (!powered) {
@@ -2058,17 +2540,29 @@ int mgmt_connectable(u16 index, u8 connectable)

  int mgmt_new_key(u16 index, struct link_key *key, u8 persistent)
  {
-	struct mgmt_ev_new_key ev;
+	struct mgmt_ev_new_key *ev;
+	int err, total;

-	memset(&ev, 0, sizeof(ev));
+	total = sizeof(struct mgmt_ev_new_key) + key->dlen;
+	ev = kzalloc(total, GFP_ATOMIC);
+	if (!ev)
+		return -ENOMEM;
+
+	ev->store_hint = persistent;
+	bacpy(&ev->key.bdaddr, &key->bdaddr);
+	ev->key.addr_type = key->addr_type;
+	ev->key.key_type = key->key_type;
+	memcpy(ev->key.val, key->val, 16);
+	ev->key.pin_len = key->pin_len;
+	ev->key.auth = key->auth;
+	ev->key.dlen = key->dlen;
+	memcpy(ev->key.data, key->data, key->dlen);
+
+	err = mgmt_event(MGMT_EV_NEW_KEY, index, ev, total, NULL);

-	ev.store_hint = persistent;
-	bacpy(&ev.key.bdaddr, &key->bdaddr);
-	ev.key.type = key->type;
-	memcpy(ev.key.val, key->val, 16);
-	ev.key.pin_len = key->pin_len;
+	kfree(ev);

-	return mgmt_event(MGMT_EV_NEW_KEY, index, &ev, sizeof(ev), NULL);
+	return err;
  }

  int mgmt_connected(u16 index, bdaddr_t *bdaddr, u8 link_type)
@@ -2145,6 +2639,8 @@ int mgmt_pin_code_request(u16 index, bdaddr_t 
*bdaddr, u8 secure)
  {
  	struct mgmt_ev_pin_code_request ev;

+	BT_DBG("hci%u", index);
+
  	bacpy(&ev.bdaddr, bdaddr);
  	ev.secure = secure;

@@ -2323,32 +2819,75 @@ int mgmt_read_local_oob_data_reply_complete(u16 
index, u8 *hash, u8 *randomizer,
  	return err;
  }

-int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 *dev_class, s8 rssi,
-								u8 *eir)
+int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 type, u8 le,
+			u8 *dev_class, s8 rssi, u8 eir_len, u8 *eir)
  {
  	struct mgmt_ev_device_found ev;
+	struct pending_cmd *cmd;
+	int err;
+
+	BT_DBG("le: %d", le);

  	memset(&ev, 0, sizeof(ev));

  	bacpy(&ev.bdaddr, bdaddr);
  	ev.rssi = rssi;
-
-	if (eir)
-		memcpy(ev.eir, eir, sizeof(ev.eir));
+	ev.type = type;
+	ev.le = le;

  	if (dev_class)
  		memcpy(ev.dev_class, dev_class, sizeof(ev.dev_class));

-	return mgmt_event(MGMT_EV_DEVICE_FOUND, index, &ev, sizeof(ev), NULL);
+	if (eir && eir_len)
+		memcpy(ev.eir, eir, eir_len);
+
+	err = mgmt_event(MGMT_EV_DEVICE_FOUND, index, &ev, sizeof(ev), NULL);
+
+	if (err < 0)
+		return err;
+
+	cmd = mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, index);
+	if (cmd) {
+		struct disco_interleave *ilp = cmd->param;
+		struct hci_dev *hdev = hci_dev_get(index);
+
+		ilp->int_count++;
+		if (hdev && ilp->int_count >= ilp->int_phase) {
+			/* Inquiry scan for General Discovery LAP */
+			struct hci_cp_inquiry cp = {{0x33, 0x8b, 0x9e}, 4, 0};
+			struct hci_cp_le_set_scan_enable le_cp = {0, 0};
+
+			ilp->int_phase *= 2;
+			ilp->int_count = 0;
+			if (ilp->mode == SCAN_LE) {
+				/* cancel LE scan */
+				hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE,
+							sizeof(le_cp), &le_cp);
+				/* start BR scan */
+				cp.num_rsp = (u8) ilp->int_phase;
+				hci_send_cmd(hdev, HCI_OP_INQUIRY,
+							sizeof(cp), &cp);
+				ilp->mode = SCAN_BR;
+				del_timer_sync(&ilp->le_timer);
+			}
+		}
+
+		if (hdev)
+			hci_dev_put(hdev);
+	}
+
+	return 0;
  }

-int mgmt_remote_name(u16 index, bdaddr_t *bdaddr, u8 *name)
+
+int mgmt_remote_name(u16 index, bdaddr_t *bdaddr, u8 status, u8 *name)
  {
  	struct mgmt_ev_remote_name ev;

  	memset(&ev, 0, sizeof(ev));

  	bacpy(&ev.bdaddr, bdaddr);
+	ev.status = status;
  	memcpy(ev.name, name, HCI_MAX_NAME_LENGTH);

  	return mgmt_event(MGMT_EV_REMOTE_NAME, index, &ev, sizeof(ev), NULL);
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 94e94ca..b882783 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -23,13 +23,27 @@
  #include <net/bluetooth/bluetooth.h>
  #include <net/bluetooth/hci_core.h>
  #include <net/bluetooth/l2cap.h>
+#include <net/bluetooth/mgmt.h>
  #include <net/bluetooth/smp.h>
  #include <linux/crypto.h>
  #include <linux/scatterlist.h>
  #include <crypto/b128ops.h>
+#include <asm/unaligned.h>

  #define SMP_TIMEOUT 30000 /* 30 seconds */

+#define SMP_MIN_CONN_INTERVAL	40	/* 50ms (40 * 1.25ms) */
+#define SMP_MAX_CONN_INTERVAL	56	/* 70ms (56 * 1.25ms) */
+#define SMP_MAX_CONN_LATENCY	0	/* 0ms (0 * 1.25ms) */
+#define SMP_SUPERVISION_TIMEOUT	500	/* 5 seconds (500 * 10ms) */
+
+#ifndef FALSE
+#define FALSE 0
+#define TRUE (!FALSE)
+#endif
+
+static int smp_distribute_keys(struct l2cap_conn *conn, __u8 force);
+
  static inline void swap128(u8 src[16], u8 dst[16])
  {
  	int i;
@@ -183,9 +197,27 @@ static void smp_send_cmd(struct l2cap_conn *conn, 
u8 code, u16 len, void *data)

  	skb->priority = HCI_PRIO_MAX;
  	hci_send_acl(conn->hchan, skb, 0);
+}
+
+static __u8 authreq_to_seclevel(__u8 authreq)
+{
+	if (authreq & SMP_AUTH_MITM)
+		return BT_SECURITY_HIGH;
+	else if (authreq & SMP_AUTH_BONDING)
+		return BT_SECURITY_MEDIUM;
+	else
+		return BT_SECURITY_LOW;
+}
+
+static __u8 seclevel_to_authreq(__u8 level)
+{
+	switch (level) {
+	case BT_SECURITY_HIGH:
+		return SMP_AUTH_MITM | SMP_AUTH_BONDING;

-	mod_timer(&conn->security_timer, jiffies +
-					msecs_to_jiffies(SMP_TIMEOUT));
+	default:
+		return SMP_AUTH_NONE;
+	}
  }

  static void build_pairing_cmd(struct l2cap_conn *conn,
@@ -193,30 +225,40 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
  				struct smp_cmd_pairing *rsp,
  				__u8 authreq)
  {
-	u8 dist_keys;
+	u8 all_keys = 0;
+	u8 dist_keys = 0;

-	dist_keys = 0;
-	if (test_bit(HCI_PAIRABLE, &conn->hcon->hdev->flags)) {
-		dist_keys = SMP_DIST_ENC_KEY;
-		authreq |= SMP_AUTH_BONDING;
-	}
+	dist_keys = SMP_DIST_ENC_KEY;
+	authreq |= SMP_AUTH_BONDING;
+
+	BT_DBG("conn->hcon->io_capability:%d", conn->hcon->io_capability);

  	if (rsp == NULL) {
  		req->io_capability = conn->hcon->io_capability;
  		req->oob_flag = SMP_OOB_NOT_PRESENT;
  		req->max_key_size = SMP_MAX_ENC_KEY_SIZE;
-		req->init_key_dist = dist_keys;
+		req->init_key_dist = all_keys;
  		req->resp_key_dist = dist_keys;
  		req->auth_req = authreq;
+		BT_DBG("SMP_CMD_PAIRING_REQ %d %d %d %d %2.2x %2.2x",
+				req->io_capability, req->oob_flag,
+				req->auth_req, req->max_key_size,
+				req->init_key_dist, req->resp_key_dist);
  		return;
  	}

-	rsp->io_capability = conn->hcon->io_capability;
+	/* Don't request OOB */
  	rsp->oob_flag = SMP_OOB_NOT_PRESENT;
+
+	rsp->io_capability = conn->hcon->io_capability;
  	rsp->max_key_size = SMP_MAX_ENC_KEY_SIZE;
  	rsp->init_key_dist = req->init_key_dist & dist_keys;
  	rsp->resp_key_dist = req->resp_key_dist & dist_keys;
  	rsp->auth_req = authreq;
+	BT_DBG("SMP_CMD_PAIRING_RSP %d %d %d %d %2.2x %2.2x",
+			req->io_capability, req->oob_flag, req->auth_req,
+			req->max_key_size, req->init_key_dist,
+			req->resp_key_dist);
  }

  static u8 check_enc_key_size(struct l2cap_conn *conn, __u8 max_key_size)
@@ -232,162 +274,220 @@ static u8 check_enc_key_size(struct l2cap_conn 
*conn, __u8 max_key_size)
  	return 0;
  }

-static void confirm_work(struct work_struct *work)
+#define JUST_WORKS	SMP_JUST_WORKS
+#define REQ_PASSKEY	SMP_REQ_PASSKEY
+#define CFM_PASSKEY	SMP_CFM_PASSKEY
+#define JUST_CFM	SMP_JUST_CFM
+#define OVERLAP		SMP_OVERLAP
+static const u8	gen_method[5][5] = {
+	{JUST_WORKS,  JUST_CFM,    REQ_PASSKEY, JUST_WORKS, REQ_PASSKEY},
+	{JUST_WORKS,  JUST_CFM,    REQ_PASSKEY, JUST_WORKS, REQ_PASSKEY},
+	{CFM_PASSKEY, CFM_PASSKEY, REQ_PASSKEY, JUST_WORKS, CFM_PASSKEY},
+	{JUST_WORKS,  JUST_CFM,    JUST_WORKS,  JUST_WORKS, JUST_CFM},
+	{CFM_PASSKEY, CFM_PASSKEY, REQ_PASSKEY, JUST_WORKS, OVERLAP}
+};
+
+static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
+						u8 local_io, u8 remote_io)
  {
-	struct smp_chan *smp = container_of(work, struct smp_chan, confirm);
-	struct l2cap_conn *conn = smp->conn;
-	struct crypto_blkcipher *tfm;
-	struct smp_cmd_pairing_confirm cp;
-	int ret;
-	u8 res[16], reason;
-
-	BT_DBG("conn %p", conn);
+	struct hci_conn *hcon = conn->hcon;
+	struct smp_chan *smp = conn->smp_chan;
+	u8 method;
+	u32 passkey = 0;
+	int ret = 0;

-	tfm = crypto_alloc_blkcipher("ecb(aes)", 0, CRYPTO_ALG_ASYNC);
-	if (IS_ERR(tfm)) {
-		reason = SMP_UNSPECIFIED;
-		goto error;
+	/* Initialize key to JUST WORKS */
+	memset(smp->tk, 0, sizeof(smp->tk));
+	smp->smp_tk_valid = FALSE;
+	smp->smp_auth = auth;
+
+	BT_DBG("tk_request: auth:%d lcl:%d rem:%d", auth, local_io, remote_io);
+
+	/* If neither side wants MITM, use JUST WORKS */
+	/* If either side has unknown io_caps, use JUST_WORKS */
+	if (!(auth & SMP_AUTH_MITM) ||
+			local_io > SMP_IO_KEYBOARD_DISPLAY ||
+			remote_io > SMP_IO_KEYBOARD_DISPLAY) {
+		smp->smp_auth &= ~SMP_AUTH_MITM;
+		smp->smp_tk_valid = TRUE;
+		return 0;
  	}

-	smp->tfm = tfm;
+	/* MITM is now officially requested, but not required */
+	/* Determine what we need (if anything) from the agent */
+	method = gen_method[local_io][remote_io];

-	if (conn->hcon->out)
-		ret = smp_c1(tfm, smp->tk, smp->prnd, smp->preq, smp->prsp, 0,
-				conn->src, conn->hcon->dst_type, conn->dst,
-				res);
-	else
-		ret = smp_c1(tfm, smp->tk, smp->prnd, smp->preq, smp->prsp,
-				conn->hcon->dst_type, conn->dst, 0, conn->src,
-				res);
-	if (ret) {
-		reason = SMP_UNSPECIFIED;
-		goto error;
+	if (method == SMP_JUST_WORKS || method == SMP_JUST_CFM)
+		smp->smp_auth &= ~SMP_AUTH_MITM;
+
+	/* Don't bother confirming unbonded JUST_WORKS */
+	if (!(auth & SMP_AUTH_BONDING) && method == SMP_JUST_CFM) {
+		smp->smp_tk_valid = TRUE;
+		return 0;
+	} else if (method == SMP_JUST_WORKS) {
+		smp->smp_tk_valid = TRUE;
+		return 0;
+	} else if (method == SMP_OVERLAP) {
+		if (hcon->link_mode & HCI_LM_MASTER)
+			method = SMP_CFM_PASSKEY;
+		else
+			method = SMP_REQ_PASSKEY;
  	}

-	swap128(res, cp.confirm_val);
-	smp_send_cmd(smp->conn, SMP_CMD_PAIRING_CONFIRM, sizeof(cp), &cp);
+	if (method == SMP_CFM_PASSKEY) {
+		u8 key[16];
+		/* Generate a passkey for display. It is not valid until
+		 * confirmed.
+		 */
+		memset(key, 0, sizeof(key));
+		get_random_bytes(&passkey, sizeof(passkey));
+		passkey %= 1000000;
+		put_unaligned_le32(passkey, key);
+		swap128(key, smp->tk);
+		BT_DBG("PassKey: %d", passkey);
+	}

-	return;
+	hci_dev_lock(hcon->hdev);

-error:
-	smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(reason), &reason);
-	smp_chan_destroy(conn);
+	switch (method) {
+	case SMP_REQ_PASSKEY:
+		ret = mgmt_user_confirm_request(hcon->hdev->id, conn->dst,
+									0, 0);
+		break;
+	case SMP_CFM_PASSKEY:
+	default:
+		ret = mgmt_user_confirm_request(hcon->hdev->id, conn->dst,
+								passkey, 0);
+		break;
+	}
+
+	hci_dev_unlock(hcon->hdev);
+
+	return ret;
  }

-static void random_work(struct work_struct *work)
+static int send_pairing_confirm(struct l2cap_conn *conn)
  {
-	struct smp_chan *smp = container_of(work, struct smp_chan, random);
-	struct l2cap_conn *conn = smp->conn;
-	struct hci_conn *hcon = conn->hcon;
+	struct smp_chan *smp = conn->smp_chan;
  	struct crypto_blkcipher *tfm = smp->tfm;
-	u8 reason, confirm[16], res[16], key[16];
+	struct smp_cmd_pairing_confirm cp;
  	int ret;
+	u8 res[16];

-	if (IS_ERR_OR_NULL(tfm)) {
-		reason = SMP_UNSPECIFIED;
-		goto error;
-	}
-
-	BT_DBG("conn %p %s", conn, conn->hcon->out ? "master" : "slave");
-
-	if (hcon->out)
-		ret = smp_c1(tfm, smp->tk, smp->rrnd, smp->preq, smp->prsp, 0,
-				conn->src, hcon->dst_type, conn->dst,
+	if (conn->hcon->out)
+		ret = smp_c1(tfm, smp->tk, smp->prnd, smp->preq, smp->prsp, 0,
+				conn->src, conn->hcon->dst_type, conn->dst,
  				res);
  	else
-		ret = smp_c1(tfm, smp->tk, smp->rrnd, smp->preq, smp->prsp,
-				hcon->dst_type, conn->dst, 0, conn->src,
+		ret = smp_c1(tfm, smp->tk, smp->prnd, smp->preq, smp->prsp,
+				conn->hcon->dst_type, conn->dst, 0, conn->src,
  				res);
-	if (ret) {
-		reason = SMP_UNSPECIFIED;
-		goto error;
-	}
-
-	swap128(res, confirm);
-
-	if (memcmp(smp->pcnf, confirm, sizeof(smp->pcnf)) != 0) {
-		BT_ERR("Pairing failed (confirmation values mismatch)");
-		reason = SMP_CONFIRM_FAILED;
-		goto error;
-	}

-	if (hcon->out) {
-		u8 stk[16], rand[8];
-		__le16 ediv;
-
-		memset(rand, 0, sizeof(rand));
-		ediv = 0;
-
-		smp_s1(tfm, smp->tk, smp->rrnd, smp->prnd, key);
-		swap128(key, stk);
-
-		memset(stk + smp->smp_key_size, 0,
-				SMP_MAX_ENC_KEY_SIZE - smp->smp_key_size);
-
-		if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend)) {
-			reason = SMP_UNSPECIFIED;
-			goto error;
-		}
-
-		hci_le_start_enc(hcon, ediv, rand, stk);
-		hcon->enc_key_size = smp->smp_key_size;
-	} else {
-		u8 stk[16], r[16], rand[8];
-		__le16 ediv;
-
-		memset(rand, 0, sizeof(rand));
-		ediv = 0;
-
-		swap128(smp->prnd, r);
-		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(r), r);
-
-		smp_s1(tfm, smp->tk, smp->prnd, smp->rrnd, key);
-		swap128(key, stk);
+	if (ret)
+		return SMP_CONFIRM_FAILED;

-		memset(stk + smp->smp_key_size, 0,
-				SMP_MAX_ENC_KEY_SIZE - smp->smp_key_size);
+	swap128(res, cp.confirm_val);

-		hci_add_ltk(hcon->hdev, 0, conn->dst, smp->smp_key_size,
-							ediv, rand, stk);
-	}
+	smp->smp_cfm_pending = FALSE;

-	return;
+	smp_send_cmd(conn, SMP_CMD_PAIRING_CONFIRM, sizeof(cp), &cp);

-error:
-	smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(reason), &reason);
-	smp_chan_destroy(conn);
+	return 0;
  }

  static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
  {
  	struct smp_chan *smp;
+	struct crypto_blkcipher *tfm;
+
+	if (conn->smp_chan)
+		return conn->smp_chan;

  	smp = kzalloc(sizeof(struct smp_chan), GFP_ATOMIC);
  	if (!smp)
  		return NULL;
+
+	tfm = crypto_alloc_blkcipher("ecb(aes)", 0, CRYPTO_ALG_ASYNC);
+	if (!tfm || IS_ERR(tfm)) {
+		kfree(smp);
+		return NULL;
+	}

-	INIT_WORK(&smp->confirm, confirm_work);
-	INIT_WORK(&smp->random, random_work);
-
+	smp->tfm = tfm;
  	smp->conn = conn;
  	conn->smp_chan = smp;
-
+
  	hci_conn_hold(conn->hcon);
-
+
  	return smp;
  }

  void smp_chan_destroy(struct l2cap_conn *conn)
  {
-	kfree(conn->smp_chan);
+	struct smp_chan *smp = conn->smp_chan;
+
+	if (smp && !IS_ERR(smp->tfm))
+		crypto_free_blkcipher(smp->tfm);
+
+	kfree(smp);
+	conn->smp_chan = NULL;
  	hci_conn_put(conn->hcon);
  }

+int smp_user_confirm_reply(struct hci_conn *hcon, u16 mgmt_op, void *cp)
+{
+	struct mgmt_cp_user_passkey_reply *psk_reply = cp;
+	struct l2cap_conn *conn = hcon->smp_conn;
+	struct smp_chan *smp = conn->smp_chan;
+	u8 key[16];
+	u8 reason = 0;
+	int ret = 0;
+
+	BT_DBG("");
+
+	smp->smp_tk_valid = TRUE;
+
+	switch (mgmt_op) {
+	case MGMT_OP_USER_CONFIRM_NEG_REPLY:
+		reason = SMP_CONFIRM_FAILED;
+		break;
+	case MGMT_OP_USER_CONFIRM_REPLY:
+		break;
+	case MGMT_OP_USER_PASSKEY_REPLY:
+		memset(key, 0, sizeof(key));
+		BT_DBG("PassKey: %d", psk_reply->passkey);
+		put_unaligned_le32(psk_reply->passkey, key);
+		swap128(key, smp->tk);
+		break;
+	default:
+		reason = SMP_CONFIRM_FAILED;
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	if (reason) {
+		BT_DBG("smp_send_cmd: SMP_CMD_PAIRING_FAIL");
+		smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(reason),
+								&reason);
+		clear_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend);
+		mgmt_auth_failed(hcon->hdev->id, conn->dst, reason);
+		del_timer(&conn->security_timer);
+		if (smp)
+			smp_chan_destroy(conn);
+	} else if (smp->smp_cfm_pending) {
+		BT_DBG("send_pairing_confirm");
+		ret = send_pairing_confirm(conn);
+	}
+
+	return ret;
+}
+
  static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff 
*skb)
  {
  	struct smp_cmd_pairing rsp, *req = (void *) skb->data;
  	struct smp_chan *smp;
  	u8 key_size;
+	u8 auth = SMP_AUTH_NONE;
  	int ret;

  	BT_DBG("conn %p", conn);
@@ -401,26 +501,35 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn 
*conn, struct sk_buff *skb)
  	memcpy(&smp->preq[1], req, sizeof(*req));
  	skb_pull(skb, sizeof(*req));

-	if (req->oob_flag)
-		return SMP_OOB_NOT_AVAIL;
+	/* We didn't start the pairing, so match remote */
+	if (req->auth_req & SMP_AUTH_BONDING)
+		auth = req->auth_req;

-	/* We didn't start the pairing, so no requirements */
-	build_pairing_cmd(conn, req, &rsp, SMP_AUTH_NONE);
+	build_pairing_cmd(conn, req, &rsp, auth);

  	key_size = min(req->max_key_size, rsp.max_key_size);
  	if (check_enc_key_size(conn, key_size))
  		return SMP_ENC_KEY_SIZE;

-	/* Just works */
-	memset(smp->tk, 0, sizeof(smp->tk));
-
  	ret = smp_rand(smp->prnd);
  	if (ret)
  		return SMP_UNSPECIFIED;

+	/* Request setup of TK */
+	ret = tk_request(conn, req->oob_flag, auth, rsp.io_capability,
+							req->io_capability);
+	if (ret)
+		return SMP_UNSPECIFIED;
+
+	smp->prsp[0] = SMP_CMD_PAIRING_RSP;
+	memcpy(&smp->prsp[1], &rsp, sizeof(rsp));
+
  	smp->prsp[0] = SMP_CMD_PAIRING_RSP;
  	memcpy(&smp->prsp[1], &rsp, sizeof(rsp));

+	mod_timer(&conn->security_timer,
+			jiffies + msecs_to_jiffies(SMP_TIMEOUT));
+
  	smp_send_cmd(conn, SMP_CMD_PAIRING_RSP, sizeof(rsp), &rsp);

  	return 0;
@@ -430,8 +539,7 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn 
*conn, struct sk_buff *skb)
  {
  	struct smp_cmd_pairing *req, *rsp = (void *) skb->data;
  	struct smp_chan *smp = conn->smp_chan;
-	struct hci_dev *hdev = conn->hcon->hdev;
-	u8 key_size;
+	u8 key_size, auth = SMP_AUTH_NONE;
  	int ret;

  	BT_DBG("conn %p", conn);
@@ -444,20 +552,33 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn 
*conn, struct sk_buff *skb)
  	if (check_enc_key_size(conn, key_size))
  		return SMP_ENC_KEY_SIZE;

-	if (rsp->oob_flag)
-		return SMP_OOB_NOT_AVAIL;
-
-	/* Just works */
-	memset(smp->tk, 0, sizeof(smp->tk));
+	smp->prsp[0] = SMP_CMD_PAIRING_RSP;
+	memcpy(&smp->prsp[1], rsp, sizeof(*rsp));

  	ret = smp_rand(smp->prnd);
  	if (ret)
  		return SMP_UNSPECIFIED;

-	smp->prsp[0] = SMP_CMD_PAIRING_RSP;
-	memcpy(&smp->prsp[1], rsp, sizeof(*rsp));
+	if ((req->auth_req & SMP_AUTH_BONDING) &&
+			(rsp->auth_req & SMP_AUTH_BONDING))
+		auth = SMP_AUTH_BONDING;
+
+	auth |= (req->auth_req | rsp->auth_req) & SMP_AUTH_MITM;
+
+	ret = tk_request(conn, req->oob_flag, auth, rsp->io_capability,
+							req->io_capability);
+	if (ret)
+		return SMP_UNSPECIFIED;
+
+	smp->smp_cfm_pending = TRUE;

-	queue_work(hdev->workqueue, &smp->confirm);
+	/* Can't compose response until we have been confirmed */
+	if (!smp->smp_tk_valid)
+		return 0;
+
+	ret = send_pairing_confirm(conn);
+	if (ret)
+		return SMP_CONFIRM_FAILED;

  	return 0;
  }
@@ -465,7 +586,7 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn 
*conn, struct sk_buff *skb)
  static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct 
sk_buff *skb)
  {
  	struct smp_chan *smp = conn->smp_chan;
-	struct hci_dev *hdev = conn->hcon->hdev;
+	int ret;

  	BT_DBG("conn %p %s", conn, conn->hcon->out ? "master" : "slave");

@@ -478,69 +599,154 @@ static u8 smp_cmd_pairing_confirm(struct 
l2cap_conn *conn, struct sk_buff *skb)
  		swap128(smp->prnd, random);
  		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(random),
  								random);
-	} else {
-		queue_work(hdev->workqueue, &smp->confirm);
-	}
+	} else if (smp->smp_tk_valid) {
+		ret = send_pairing_confirm(conn);
+
+		if (ret)
+			return SMP_CONFIRM_FAILED;
+	} else
+		smp->smp_cfm_pending = TRUE;
+
+
+	mod_timer(&conn->security_timer,
+			jiffies + msecs_to_jiffies(SMP_TIMEOUT));

  	return 0;
  }

  static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct 
sk_buff *skb)
  {
+	struct hci_conn *hcon = conn->hcon;
  	struct smp_chan *smp = conn->smp_chan;
-	struct hci_dev *hdev = conn->hcon->hdev;
+	struct crypto_blkcipher *tfm = smp->tfm;
+	int ret;
+	u8 key[16], res[16], random[16], confirm[16];
+	u8 stk[16], rand[8];
+	__le16 ediv;

-	BT_DBG("conn %p", conn);

-	swap128(skb->data, smp->rrnd);
-	skb_pull(skb, sizeof(smp->rrnd));
+	swap128(skb->data, random);
+	skb_pull(skb, sizeof(random));
+
+	if (hcon->out)
+		ret = smp_c1(tfm, smp->tk, random, smp->preq, smp->prsp, 0,
+				conn->src, hcon->dst_type, conn->dst,
+				res);
+	else
+		ret = smp_c1(tfm, smp->tk, random, smp->preq, smp->prsp,
+				hcon->dst_type, conn->dst, 0, conn->src,
+				res);
+	if (ret)
+		return SMP_UNSPECIFIED;
+
+	BT_DBG("conn %p %s", conn, hcon->out ? "master" : "slave");

-	queue_work(hdev->workqueue, &smp->random);
+	swap128(res, confirm);
+
+	if (memcmp(smp->pcnf, confirm, sizeof(smp->pcnf)) != 0) {
+		BT_ERR("Pairing failed (confirmation values mismatch)");
+		return SMP_CONFIRM_FAILED;
+	}
+
+	memset(rand, 0, sizeof(rand));
+	ediv = 0;
+
+	if (hcon->out) {
+		smp_s1(tfm, smp->tk, random, smp->prnd, key);
+		swap128(key, stk);
+
+		memset(stk + smp->smp_key_size, 0,
+				SMP_MAX_ENC_KEY_SIZE - smp->smp_key_size);
+
+		hci_le_start_enc(hcon, ediv, rand, stk);
+		hcon->enc_key_size = smp->smp_key_size;
+	} else {
+		u8 r[16];
+
+		swap128(smp->prnd, r);
+		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(r), r);
+
+		smp_s1(tfm, smp->tk, smp->prnd, random, key);
+		swap128(key, stk);
+
+		memset(stk + smp->smp_key_size, 0,
+				SMP_MAX_ENC_KEY_SIZE - smp->smp_key_size);
+
+		hci_add_ltk(hcon->hdev, 0, conn->dst, hcon->dst_type,
+			smp->smp_key_size, smp->smp_auth, ediv, rand, stk);
+	}

  	return 0;
  }

-static u8 smp_ltk_encrypt(struct l2cap_conn *conn)
+static int smp_encrypt_link(struct l2cap_conn *conn, struct link_key *key)
  {
-	struct link_key *key;
+	struct smp_chan *smp = conn->smp_chan;
  	struct key_master_id *master;
-	struct hci_conn *hcon = conn->hcon;
+	u8 sec_level;
+	u8 zerobuf[8];

-	key = hci_find_link_key_type(hcon->hdev, conn->dst,
-						HCI_LK_SMP_LTK);
-	if (!key)
-		return 0;
+	if (!conn->hcon || !key || !key->data)
+		return -EINVAL;

-	if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND,
-					&hcon->pend))
-		return 1;
+	memset(zerobuf, 0, sizeof(zerobuf));

  	master = (void *) key->data;
-	hci_le_start_enc(hcon, master->ediv, master->rand,
-						key->val);
-	hcon->enc_key_size = key->pin_len;

-	return 1;
+	if (!master->ediv && !memcmp(master->rand, zerobuf, sizeof(zerobuf)))
+		return -EINVAL;
+
+	conn->hcon->enc_key_size = key->pin_len;
+	smp->smp_sec_req = TRUE;
+	sec_level = authreq_to_seclevel(key->auth);
+
+	BT_DBG("cur %d, req: %d", conn->hcon->sec_level, sec_level);
+
+	if (sec_level > conn->hcon->sec_level)
+		conn->hcon->pending_sec_level = sec_level;
+

+	if (!(conn->hcon->link_mode & HCI_LM_ENCRYPT))
+		hci_conn_hold(conn->hcon);
+
+	hci_le_start_enc(conn->hcon, master->ediv, master->rand, key->val);
+
+	return 0;
  }
+
  static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff 
*skb)
  {
-	struct smp_cmd_security_req *rp = (void *) skb->data;
-	struct smp_cmd_pairing cp;
  	struct hci_conn *hcon = conn->hcon;
  	struct smp_chan *smp;
+	struct smp_cmd_security_req *rp = (void *) skb->data;
+	struct smp_cmd_pairing cp;
+	struct link_key *key;

  	BT_DBG("conn %p", conn);

-	hcon->pending_sec_level = BT_SECURITY_MEDIUM;
-
-	if (smp_ltk_encrypt(conn))
+	if (test_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend))
  		return 0;

-	if (test_and_set_bit(HCI_CONN_LE_SMP_PEND, &hcon->pend))
+	key = hci_find_link_key_type(hcon->hdev, conn->dst, KEY_TYPE_LTK);
+	if (key && ((key->auth & SMP_AUTH_MITM) ||
+					!(rp->auth_req & SMP_AUTH_MITM))) {
+
+		if (smp_encrypt_link(conn, key) < 0)
+			goto invalid_key;
+
  		return 0;
+	}

+invalid_key:
  	smp = smp_chan_create(conn);
+	if (!smp)
+		return SMP_CMD_NOTSUPP;
+
+	smp->smp_sec_req = FALSE;
+
+	/* Switch to Pairing Connection Parameters */
+	hci_le_conn_update(hcon, SMP_MIN_CONN_INTERVAL, SMP_MAX_CONN_INTERVAL,
+			SMP_MAX_CONN_LATENCY, SMP_SUPERVISION_TIMEOUT);

  	skb_pull(skb, sizeof(*rp));

@@ -552,6 +758,13 @@ static u8 smp_cmd_security_req(struct l2cap_conn 
*conn, struct sk_buff *skb)

  	smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);

+	mod_timer(&conn->security_timer,
+			jiffies + msecs_to_jiffies(SMP_TIMEOUT));
+
+	set_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend);
+
+	hci_conn_hold(hcon);
+
  	return 0;
  }

@@ -559,6 +772,7 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 
sec_level)
  {
  	struct hci_conn *hcon = conn->hcon;
  	struct smp_chan *smp = conn->smp_chan;
+	u8 authreq;

  	BT_DBG("conn %p hcon %p level 0x%2.2x", conn, hcon, sec_level);

@@ -571,22 +785,48 @@ int smp_conn_security(struct l2cap_conn *conn, 
__u8 sec_level)
  	if (hcon->sec_level >= sec_level)
  		return 1;

-	if (hcon->link_mode & HCI_LM_MASTER)
-		if (smp_ltk_encrypt(conn))
-			goto done;
-
  	if (test_and_set_bit(HCI_CONN_LE_SMP_PEND, &hcon->pend))
  		return 0;

+	if (hcon->sec_level >= sec_level)
+		return 1;
+
+	authreq = seclevel_to_authreq(sec_level);
+
  	smp = smp_chan_create(conn);
+	hcon->smp_conn = conn;
+	hcon->pending_sec_level = sec_level;
+
+	if ((hcon->link_mode & HCI_LM_MASTER) && !smp->smp_sec_req) {
+		struct link_key *key;
+
+		key = hci_find_link_key_type(hcon->hdev, conn->dst,
+							KEY_TYPE_LTK);
+
+		if (smp_encrypt_link(conn, key) == 0)
+			goto done;
+	}
+
+	smp->smp_sec_req = FALSE;
+
+	if (!smp)
+		return 1;

  	if (hcon->link_mode & HCI_LM_MASTER) {
  		struct smp_cmd_pairing cp;

-		build_pairing_cmd(conn, &cp, NULL, SMP_AUTH_NONE);
+		/* Switch to Pairing Connection Parameters */
+		hci_le_conn_update(hcon, SMP_MIN_CONN_INTERVAL,
+				SMP_MAX_CONN_INTERVAL, SMP_MAX_CONN_LATENCY,
+				SMP_SUPERVISION_TIMEOUT);
+
+		build_pairing_cmd(conn, &cp, NULL, authreq);
  		smp->preq[0] = SMP_CMD_PAIRING_REQ;
  		memcpy(&smp->preq[1], &cp, sizeof(cp));

+		mod_timer(&conn->security_timer,
+				jiffies + msecs_to_jiffies(SMP_TIMEOUT));
+
  		smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
  	} else {
  		struct smp_cmd_security_req cp;
@@ -595,7 +835,7 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 
sec_level)
  	}

  done:
-	hcon->pending_sec_level = sec_level;
+	set_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend);

  	return 0;
  }
@@ -616,29 +856,45 @@ static int smp_cmd_master_ident(struct l2cap_conn 
*conn, struct sk_buff *skb)
  {
  	struct smp_cmd_master_ident *rp = (void *) skb->data;
  	struct smp_chan *smp = conn->smp_chan;
+	struct smp_cmd_pairing *paircmd = (void *) &smp->prsp[1];
+	u8 *keydist;

  	skb_pull(skb, sizeof(*rp));

-	hci_add_ltk(conn->hcon->hdev, 1, conn->src, smp->smp_key_size,
-						rp->ediv, rp->rand, smp->tk);
+	hci_add_ltk(conn->hcon->hdev, 1, conn->dst, conn->hcon->dst_type,
+			smp->smp_key_size, smp->smp_auth, rp->ediv,
+			rp->rand, smp->tk);
+
+	if (conn->hcon->out)
+		keydist = &paircmd->resp_key_dist;
+	else
+		keydist = &paircmd->init_key_dist;
+
+	BT_DBG("keydist 0x%x", *keydist);

-	smp_distribute_keys(conn, 1);
+	*keydist &= ~SMP_DIST_ENC_KEY;
+	if (conn->hcon->out) {
+		if (!(*keydist))
+			smp_distribute_keys(conn, 1);
+	}

  	return 0;
  }

  int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
  {
+	struct hci_conn *hcon = conn->hcon;
  	__u8 code = skb->data[0];
  	__u8 reason;
  	int err = 0;

-	if (!lmp_host_le_capable(conn->hcon->hdev)) {
+	if (!lmp_host_le_capable(hcon->hdev)) {
  		err = -ENOTSUPP;
  		reason = SMP_PAIRING_NOTSUPP;
  		goto done;
  	}

+	hcon->smp_conn = conn;
  	skb_pull(skb, sizeof(code));

  	switch (code) {
@@ -649,6 +905,11 @@ int smp_sig_channel(struct l2cap_conn *conn, struct 
sk_buff *skb)
  	case SMP_CMD_PAIRING_FAIL:
  		reason = 0;
  		err = -EPERM;
+		clear_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend);
+		mgmt_auth_failed(hcon->hdev->id, conn->dst, skb->data[0]);
+		del_timer(&conn->security_timer);
+		if (conn->smp_chan)
+			smp_chan_destroy(conn);
  		break;

  	case SMP_CMD_PAIRING_RSP:
@@ -691,15 +952,21 @@ int smp_sig_channel(struct l2cap_conn *conn, 
struct sk_buff *skb)
  	}

  done:
-	if (reason)
+	if (reason) {
  		smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(reason),
  								&reason);
+		clear_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend);
+		mgmt_auth_failed(hcon->hdev->id, conn->dst, reason);
+		del_timer(&conn->security_timer);
+		if (conn->smp_chan)
+			smp_chan_destroy(conn);
+	}

  	kfree_skb(skb);
  	return err;
  }

-int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
+static int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
  {
  	struct smp_cmd_pairing *req, *rsp;
  	struct smp_chan *smp = conn->smp_chan;
@@ -740,8 +1007,9 @@ int smp_distribute_keys(struct l2cap_conn *conn, 
__u8 force)

  		smp_send_cmd(conn, SMP_CMD_ENCRYPT_INFO, sizeof(enc), &enc);

-		hci_add_ltk(conn->hcon->hdev, 1, conn->dst, smp->smp_key_size,
-						ediv, ident.rand, enc.ltk);
+		hci_add_ltk(conn->hcon->hdev, 1, conn->dst,
+				conn->hcon->dst_type, smp->smp_key_size,
+				smp->smp_auth, ediv, ident.rand, enc.ltk);

  		ident.ediv = cpu_to_le16(ediv);

@@ -780,11 +1048,46 @@ int smp_distribute_keys(struct l2cap_conn *conn, 
__u8 force)
  		*keydist &= ~SMP_DIST_SIGN;
  	}

-	if (conn->hcon->out || force) {
-		clear_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->pend);
+	if (conn->hcon->out || rsp->resp_key_dist) {
+		if (conn->hcon->disconn_cfm_cb)
+			conn->hcon->disconn_cfm_cb(conn->hcon, 0);
+
+		clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->hcon->pend);
  		del_timer(&conn->security_timer);
  		smp_chan_destroy(conn);
  	}

  	return 0;
  }
+
+int smp_link_encrypt_cmplt(struct l2cap_conn *conn, u8 status, u8 encrypt)
+{
+	struct hci_conn *hcon = conn->hcon;
+	struct smp_chan *smp = conn->smp_chan;
+
+	BT_DBG("smp: %d %d %d", status, encrypt, smp->smp_sec_req);
+
+	clear_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend);
+
+	if (!status && encrypt && !smp->smp_sec_req)
+		smp_distribute_keys(conn, 0);
+
+	/* Fall back to Pairing request if failed a Link Security request */
+	else if (smp->smp_sec_req  && (status || !encrypt))
+		smp_conn_security(conn, hcon->sec_level);
+	else
+		smp_chan_destroy(conn);
+
+	return 0;
+}
+
+void smp_timeout(struct l2cap_conn *conn)
+{
+	u8 reason = SMP_UNSPECIFIED;
+
+	BT_DBG("%p", conn);
+
+	smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(reason), &reason);
+	clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->hcon->pend);
+	mgmt_auth_failed(conn->hcon->hdev->id, conn->dst, SMP_UNSPECIFIED);
+}
-- 
1.7.7.1
-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
