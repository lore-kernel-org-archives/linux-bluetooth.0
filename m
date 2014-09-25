Return-Path: <cyrus@holtmann.org>
From: Gu Chaojie <chao.jie.gu@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gu Chaojie <chao.jie.gu@intel.com>
Subject: [PATCH 4/4] shared/att: provide CSRK related function to upperlayer
Date: Thu, 25 Sep 2014 14:35:31 +0800
Message-Id: <1411626931-8290-5-git-send-email-chao.jie.gu@intel.com>
In-Reply-To: <1411626931-8290-1-git-send-email-chao.jie.gu@intel.com>
References: <1411626931-8290-1-git-send-email-chao.jie.gu@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch add three CSRK related function to upper layer:
Set CSRK into struct bt_att,
Get CSRK from struct bt_att,
Decide CSRK is valid or not.

---
 src/shared/att.c |   61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/att.h |   13 ++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/src/shared/att.c b/src/shared/att.c
index f3f531a..b31eb9e 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -84,6 +84,10 @@ struct bt_att {
 	bool valid_local_csrk;
 	uint8_t local_csrk[16];
 	uint32_t local_sign_cnt;
+
+	bool valid_remote_csrk;
+	uint8_t remote_csrk[16];
+	uint32_t remote_sign_cnt;
 };
 
 enum att_op_type {
@@ -727,6 +731,8 @@ struct bt_att *bt_att_new(int fd)
 
 	att->fd = fd;
 
+	att->local_sign_cnt = 0;
+	att->remote_sign_cnt = 0;
 	att->mtu = BT_ATT_DEFAULT_LE_MTU;
 	att->buf = malloc(att->mtu);
 	if (!att->buf)
@@ -1150,3 +1156,58 @@ bool bt_att_unregister_all(struct bt_att *att)
 
 	return true;
 }
+
+bool bt_att_set_csrk(struct bt_att *att, enum bt_csrk_type type,
+				bool valid_csrk, uint8_t key[16])
+{
+
+	bool local = (type == LOCAL_CSRK);
+
+	if (!att)
+		return false;
+
+	if (local) {
+		att->valid_local_csrk = valid_csrk;
+		memcpy(att->local_csrk, key, 16);
+	} else {
+		att->valid_remote_csrk = valid_csrk;
+		memcpy(att->remote_csrk, key, 16);
+	}
+
+	return true;
+}
+
+bool bt_att_get_csrk(struct bt_att *att, enum bt_csrk_type type,
+				uint8_t key[16], uint32_t *sign_cnt)
+{
+	bool local = (type == LOCAL_CSRK);
+
+	if (!att)
+		return false;
+
+	if (local && att->valid_local_csrk) {
+		memcpy(key, att->local_csrk, 16);
+		*sign_cnt = att->local_sign_cnt;
+	} else if (!local && att->valid_remote_csrk) {
+		memcpy(key, att->remote_csrk, 16);
+		*sign_cnt = att->remote_sign_cnt;
+	} else {
+		return false;
+	}
+
+	return true;
+}
+
+bool bt_att_csrk_is_valid(struct bt_att *att, enum bt_csrk_type type)
+{
+	bool local = (type == LOCAL_CSRK);
+
+	if (!att)
+		return false;
+
+	if (local)
+		return att->valid_local_csrk;
+	else
+		return att->valid_remote_csrk;
+
+}
diff --git a/src/shared/att.h b/src/shared/att.h
index 1063021..9a54f64 100644
--- a/src/shared/att.h
+++ b/src/shared/att.h
@@ -26,6 +26,11 @@
 
 #include "src/shared/att-types.h"
 
+enum bt_csrk_type {
+	LOCAL_CSRK,
+	REMOTE_CSRK,
+};
+
 struct bt_att;
 
 struct bt_att *bt_att_new(int fd);
@@ -76,3 +81,11 @@ unsigned int bt_att_register_disconnect(struct bt_att *att,
 bool bt_att_unregister_disconnect(struct bt_att *att, unsigned int id);
 
 bool bt_att_unregister_all(struct bt_att *att);
+
+bool bt_att_set_csrk(struct bt_att *att, enum bt_csrk_type type,
+				bool valid_csrk, uint8_t key[16]);
+
+bool bt_att_get_csrk(struct bt_att *att, enum bt_csrk_type type,
+				uint8_t key[16], uint32_t *sign_cnt);
+
+bool bt_att_csrk_is_valid(struct bt_att *att, enum bt_csrk_type type);
-- 
1.7.10.4

