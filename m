Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793830409;
	b=JaQHW1kI+aWbUDQV+qJhxCD9eZHr10N347N7I8N7+m4FY5uwlS8XvNt/wY73OttfIIfg
	 yq+A1DmNRet+R4jfRUgAkmK7ZwA0YY49RUdhjn3JEh6QPCbDRPiusdjd24HYK7M1jrFtT
	 MRf3dj0aVInOsDyVO1ljO3ASktxfKhI3rhDkrk5ZLv/mh5jmW2555lphdp1Wuo5MyYZhK
	 NXXkb6F0VUQgJKE3J5lG+txuHwMPIZz1lwL8Rl1nTMhst88/sFV4M1hVgP9/9OuxDDGdM
	 h37wPNAZDQem8kb5bkp1bmk3zPJ93lI9LLlJ8hGdCUyhZJ/F6s/GUm4O8KzL6M/vUWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793830409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=M4/2khlb3boI3qQvgnElFh99b0pJnKKAcyn2Vd/34b4=;
	b=lq9jIBk000HHEYq2i2R8+d8sFshaf6oDPPXg/OYsvNH655NjyMt9NSfZzpf4x4vXgK8W
	 VTvxQP5KNSDio6TLIZLVQP3qPtpoq3GL7AXP2ZmLZJr1estwayt3hKsVQ6r4eUuDxEGKT
	 ORbeCW3QKhblcpasazEO2buXavIJklfggoeztxLcZ3KoNxQwLaSnCnEsaQuler0KxbbfL
	 eFpMYPhgohJqqqtTyuwbcgkQ4sUw574rkePBzXkQQS89TmtmNarypXnOwxb2MDi/XK1kx
	 w6FSJlPvUwLBns2VkxK9kEmrLjfVUS6jWaYXnOmFfIvy3X+cL5V3y+YmIgTLtNAvI1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aZZnUIlV;
	arc=none smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8236070319
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 22:13:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D8236070319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aZZnUIlV
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5eab93a9862so302941e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 14:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793830407; x=1794435207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=M4/2khlb3boI3qQvgnElFh99b0pJnKKAcyn2Vd/34b4=;
        b=aZZnUIlV4bHCZJpZIHe2VUFJDwJtmGfvMdjOm49xwFWnJuOMAZtXcbQyQ+L9OVtF2z
         cSSEtgYX7ct+A6MktWZ3lpI1OYk+KzBGrUg6jBXbGKMg1mx3cSoHIJSQvaLVb3GyQHZI
         q9MD5FbTh30AW/ZYA8U28gI2pA9+Le6pra31riQEiYTtGerd0We47T4I96i2J+5mlZ5g
         UkRrUR2429yVhcb5D/nAg29klcXTCXQ2EbROiPH/vMfAjB3J2CiwDyZ++k2SzXUuVnXW
         dwlwNsWoQGhdewYOYlfFD6xRgwV7XIDUvdXbWSNnDjoOLH/KNMBDeBxIv/LTpm1cRopH
         PIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793830407; x=1794435207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=M4/2khlb3boI3qQvgnElFh99b0pJnKKAcyn2Vd/34b4=;
        b=TXjZkcBPkpBzHkG9dmVdzm3K1uDtYZpHdWoq+e6ZCTQvQzibeBOwBu37rYNmS1rP1S
         CgOMUFHOXm5vYa/nPfnvWlEGmeeERAffoC/uyTPhq3mtzxbzcuUgsdqsu5eoNXsR5xMJ
         gMB1c612lBvRm5+Pux7SqYmzj4lVjUP/y5emcOR9TSCcC4gmHjFb5iTYRM/WkBtkUA6l
         Y17OQ+XDOC+ufb2eYiqUkChUjV+T4uZbpgHVpAguEErH99wSYdZHK6XbeTUBtBAZMVAJ
         5FQAbLnSeODSZWKmtbTEO0D7i90v40jvV6PdHTYtGCZX7TPFrn+9+lsYfPv7Wn30G1Gs
         KkzQ==
X-Gm-Message-State: APuU4Z8ToEiGGbL+uTifdvQBXpYpwRwshO6Vg3DkbGIkp6orjtdrFOzq
	R8dKGuti5/RzZFaGsRto6gjN5WO5D48rIC11S+hYX4U5ejKRmupCCCepnACZYQ==
X-Gm-Gg: AYBFou2hEDbV8vOcO9yb2ML29loHHsgjhx2jM2+D06gQUOte3cAogzpnpqYkC2h+GMq
	Z1GxJIs7PubXwQnWClzINUrAbcPiko+bvVrTdCy1+NaDelFbZ47+//WVYq3tGtci9qWZWW+Squo
	MTA5vEtSBqK34lDAF9ZbbHOobiUQF8HLUgorVuG9GTESQowSwigGuXrmO8OuuNUDFmLdoz5ZI15
	ioFEBGITlPmEEYYcWmtFBo6yf/q3qWF6+B5jzFbIMalwWYMdd0dcxkxRbEG0OyJFWNmG6iwl9Kw
	xHqPwD1lhhR6z1NMZHNatB7a+v2oCw/zkI/kPbQ6yHUOpByeAwnn5cJlm5Ui0q86XkRoi3y9uX5
	hJ1k2V7rV2DPfY7H2FwIkD+8LI7aOw0OGiRHaHdzjSVNyL6pF5dPzwpzf5ilDTcS5axK06P+EXc
	V//H8ZPPo9Gyd1Ppcah6yb4BxSIi1OYKsyPMKM0Os5wCjidCUrMDJUGrGaKef5ta0LlLBM5sElw
	uPIUBu3olAsoa/gRokL3n4WnbREUz6JOMZOMdXzwS/BVJ9Tw4c7yiD7tv3GAEMCjVf2q4xFydSh
	IbO7ZHvSyZ7un65+T0NsANJ/7dJYgpI2rSyqG9woet+jqGLts6VFksrX2s5Zh4bhcz+7kiInXvd
	ZrC+E4dof7T3Y3qYjzN0mX172wuHKE+4DGY5hjx2+h9cEHUG9g25A3mjAZtDYZPSnvz49y+jmsv
	jnx3//2bI6pry9HTH1MZNm+gD0
X-Received: by 2002:a05:6102:5814:b0:7a7:19aa:f0d4 with SMTP id ada2fe7eead31-7d0728b62a9mr5881068137.33.1793830407032;
        Wed, 04 Nov 2026 14:13:27 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998da178b59sm2934001241.12.2026.11.04.14.13.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:13:26 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/6] Bluetooth: Add initial support for EKS
Date: Wed,  4 Nov 2026 17:13:18 -0500
Message-ID: <20261104221321.1200529-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104221321.1200529-1-luiz.dentz@gmail.com>
References: <20261104221321.1200529-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add support for Encryption Key Schedule (EKS) introduced in Bluetooth
7.0:

 - LE Enable Encryption v2, which replaces LE Start Encryption on EKS
   capable controllers and carries the MIC length to use on the LE HDT
   PHY. SMP now starts encryption through hci_le_enable_encrypt(),
   which picks the version the controller supports, outside of the RCU
   read-side section since queueing the command may sleep. If it can't
   be queued SMP fails the pairing or doesn't consider the encryption
   started. A Command Status error disconnects the link as it does for
   LE Start Encryption.
 - Encryption Change v3 and Encryption Key Refresh Complete v2, enabled
   through Event Mask Page 2, which report the MIC length and whether
   the key schedule is in use. The encryption change and key refresh
   handling is moved to helpers shared by every version of the events.
 - eks_capable() for the Encryption Key Schedule feature bit.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h      |  30 +++++
 include/net/bluetooth/hci_core.h |   4 +-
 include/net/bluetooth/hci_sync.h |   3 +
 net/bluetooth/hci_conn.c         |  18 ---
 net/bluetooth/hci_event.c        | 185 +++++++++++++++++++++++--------
 net/bluetooth/hci_sync.c         |  98 ++++++++++++++++
 net/bluetooth/smp.c              |  54 ++++++---
 7 files changed, 312 insertions(+), 80 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 00f90e24581c..41bd2482614e 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2564,6 +2564,16 @@ struct hci_rp_le_read_def_data_len_v2 {
 	__le16	tx_time;
 } __packed;
 
+#define HCI_OP_LE_ENABLE_ENCRYPT_V2		0x20af
+struct hci_cp_le_enable_encrypt_v2 {
+	__le16  handle;
+	__le64  rand;
+	__le16  ediv;
+	__u8    ltk[16];
+	__u8    mic_len;
+	__u8    encryption;
+} __packed;
+
 #define HCI_OP_LE_READ_MAX_DATA_LEN_V2		0x20b0
 struct hci_cp_le_read_max_data_len_v2 {
 	__u8    phy;
@@ -3034,6 +3044,26 @@ struct hci_ev_sync_train_complete {
 
 #define HCI_EV_PERIPHERAL_PAGE_RESP_TIMEOUT	0x54
 
+#define HCI_EVT_KEY_REFRESH_COMPLETE_V2		0x5b
+struct hci_evt_key_refresh_complete_v2 {
+	__u8    status;
+	__le16  handle;
+	__u8    mic_len;
+	__u8    eks_mode;
+	__u8    eks_debug;
+} __packed;
+
+#define HCI_EVT_ENCRYPT_CHANGE_V3		0x5a
+struct hci_evt_encrypt_change_v3 {
+	__u8    status;
+	__le16  handle;
+	__u8    mode;
+	__u8    key_size;
+	__u8    mic_len;
+	__u8    eks_mode;
+	__u8    eks_debug;
+} __packed;
+
 #define HCI_EV_LE_CONN_COMPLETE		0x01
 struct hci_ev_le_conn_complete {
 	__u8     status;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index dd4c846343d6..09a603dc43e0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2176,6 +2176,8 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 	(le_feature(dev, 1, 2) & HCI_LE_HDT_7_5_TX_FEATURE)
 #define hdt_pf1_capable(dev) \
 	(le_feature(dev, 1, 2) & HCI_LE_HDT_PF_1)
+#define eks_capable(dev) \
+	(le_feature(dev, 1, 1) & HCI_LE_EKS_FEATURE)
 
 /* Channel sounding support */
 #define le_cs_capable(dev) \
@@ -2623,8 +2625,6 @@ void mgmt_conn_subrate_notify(struct hci_dev *hdev, struct hci_conn *conn,
 int hci_abort_conn(struct hci_conn *conn, u8 reason);
 void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
 		      u16 to_multiplier);
-void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
-		      __u8 ltk[16], __u8 key_size);
 
 void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			       u8 *bdaddr_type);
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index aa12250eca52..ab880384614a 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -197,3 +197,6 @@ int hci_le_set_phy(struct hci_conn *conn, u8 tx_phys, u8 rx_phys, u16 phy_opts);
 int hci_le_set_cig_params_sync(struct hci_dev *hdev, u8 cig_id);
 int hci_le_create_big_sync(struct hci_conn *conn, struct bt_iso_qos_ext *qos,
 			   u8 num_bis);
+
+int hci_le_enable_encrypt(struct hci_conn *conn, __le16 ediv, __le64 rand,
+			  __u8 ltk[16], __u8 key_size);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index f5fbdcc7b45a..b175538bfbcd 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -598,24 +598,6 @@ void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
 	}
 }
 
-void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
-		      __u8 ltk[16], __u8 key_size)
-{
-	struct hci_dev *hdev = conn->hdev;
-	struct hci_cp_le_start_enc cp;
-
-	BT_DBG("hcon %p", conn);
-
-	memset(&cp, 0, sizeof(cp));
-
-	cp.handle = cpu_to_le16(conn->handle);
-	cp.rand = rand;
-	cp.ediv = ediv;
-	memcpy(cp.ltk, ltk, key_size);
-
-	hci_send_cmd(hdev, HCI_OP_LE_START_ENC, sizeof(cp), &cp);
-}
-
 /* Device _must_ be locked */
 void hci_sco_setup(struct hci_conn *conn, __u8 status)
 {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1c1c3cb71757..fb30615db02a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3071,6 +3071,41 @@ static void hci_cs_le_start_enc(struct hci_dev *hdev, u8 status)
 	hci_dev_unlock(hdev);
 }
 
+static void hci_cs_le_enable_encrypt_v2(struct hci_dev *hdev, u8 status)
+{
+	struct hci_cp_le_enable_encrypt_v2 *cp;
+	struct hci_conn *conn;
+
+	bt_dev_dbg(hdev, "status 0x%2.2x", status);
+
+	if (!status)
+		return;
+
+	hci_dev_lock(hdev);
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_ENABLE_ENCRYPT_V2);
+	if (!cp)
+		goto unlock;
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(cp->handle));
+	if (!conn)
+		goto unlock;
+
+	clear_bit(HCI_CONN_ENCRYPT_PEND, conn->flags);
+
+	/* An opportunistic encryption that cannot be started just leaves
+	 * the link unencrypted, as it was.
+	 */
+	if (cp->encryption == 0x01 || conn->state != BT_CONNECTED)
+		goto unlock;
+
+	hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
+	hci_conn_drop(conn);
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
 static void hci_cs_switch_role(struct hci_dev *hdev, u8 status)
 {
 	struct hci_cp_switch_role *cp;
@@ -3725,22 +3760,12 @@ static void hci_remote_name_evt(struct hci_dev *hdev, void *data,
 	hci_dev_unlock(hdev);
 }
 
-static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
-				   struct sk_buff *skb)
+static void hci_change_encrypt(struct hci_conn *conn, u8 status, u8 encrypt)
 {
-	struct hci_ev_encrypt_change *ev = data;
-	struct hci_conn *conn;
-
-	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
-
-	hci_dev_lock(hdev);
-
-	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
-	if (!conn)
-		goto unlock;
+	struct hci_dev *hdev = conn->hdev;
 
-	if (!ev->status) {
-		if (ev->encrypt) {
+	if (!status) {
+		if (encrypt) {
 			/* Encryption implies authentication */
 			set_bit(HCI_CONN_AUTH, conn->flags);
 			set_bit(HCI_CONN_ENCRYPT, conn->flags);
@@ -3750,7 +3775,7 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 			if (conn->key_type == HCI_LK_AUTH_COMBINATION_P256)
 				set_bit(HCI_CONN_FIPS, conn->flags);
 
-			if ((conn->type == ACL_LINK && ev->encrypt == 0x02) ||
+			if ((conn->type == ACL_LINK && encrypt == 0x02) ||
 			    conn->type == LE_LINK)
 				set_bit(HCI_CONN_AES_CCM, conn->flags);
 
@@ -3781,7 +3806,7 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 	/* We should disregard the current RPA and generate a new one
 	 * whenever the encryption procedure fails.
 	 */
-	if (ev->status && conn->type == LE_LINK) {
+	if (status && conn->type == LE_LINK) {
 		hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
 		hci_adv_instances_set_rpa_expired(hdev, true);
 	}
@@ -3790,23 +3815,23 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 
 	/* Check link security requirements are met */
 	if (!hci_conn_check_link_mode(conn))
-		ev->status = HCI_ERROR_AUTH_FAILURE;
+		status = HCI_ERROR_AUTH_FAILURE;
 
-	if (ev->status && conn->state == BT_CONNECTED) {
-		if (ev->status == HCI_ERROR_PIN_OR_KEY_MISSING)
+	if (status && conn->state == BT_CONNECTED) {
+		if (status == HCI_ERROR_PIN_OR_KEY_MISSING)
 			set_bit(HCI_CONN_AUTH_FAILURE, conn->flags);
 
 		/* Notify upper layers so they can cleanup before
 		 * disconnecting.
 		 */
-		hci_encrypt_cfm(conn, ev->status);
+		hci_encrypt_cfm(conn, status);
 		hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
 		hci_conn_drop(conn);
-		goto unlock;
+		return;
 	}
 
 	/* Try reading the encryption key size for encrypted ACL links */
-	if (!ev->status && ev->encrypt && conn->type == ACL_LINK) {
+	if (!status && encrypt && conn->type == ACL_LINK) {
 		if (hci_read_enc_key_size(hdev, conn)) {
 			/* Could not even issue the key-size read: report the
 			 * security level now since hci_cc_read_enc_key_size()
@@ -3816,7 +3841,7 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 			goto notify;
 		}
 
-		goto unlock;
+		return;
 	}
 
 	/* We skip the WRITE_AUTH_PAYLOAD_TIMEOUT for ATS2851 based controllers
@@ -3846,7 +3871,44 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 	}
 
 notify:
-	hci_encrypt_cfm(conn, ev->status);
+	hci_encrypt_cfm(conn, status);
+}
+
+static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
+				   struct sk_buff *skb)
+{
+	struct hci_ev_encrypt_change *ev = data;
+	struct hci_conn *conn;
+
+	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
+	if (!conn)
+		goto unlock;
+
+	hci_change_encrypt(conn, ev->status, ev->encrypt);
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
+static void hci_encrypt_change_v3_evt(struct hci_dev *hdev, void *data,
+				      struct sk_buff *skb)
+{
+	struct hci_evt_encrypt_change_v3 *ev = data;
+	struct hci_conn *conn;
+
+	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
+	if (!conn)
+		goto unlock;
+
+	hci_change_encrypt(conn, ev->status, ev->mode);
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -4760,6 +4822,7 @@ static const struct hci_cs {
 	HCI_CS(HCI_OP_LE_CREATE_CONN, hci_cs_le_create_conn),
 	HCI_CS(HCI_OP_LE_READ_REMOTE_FEATURES, hci_cs_le_read_remote_features),
 	HCI_CS(HCI_OP_LE_START_ENC, hci_cs_le_start_enc),
+	HCI_CS(HCI_OP_LE_ENABLE_ENCRYPT_V2, hci_cs_le_enable_encrypt_v2),
 	HCI_CS(HCI_OP_LE_SET_PHY, hci_cs_le_set_phy),
 	HCI_CS(HCI_OP_LE_EXT_CREATE_CONN, hci_cs_le_ext_create_conn),
 	HCI_CS(HCI_OP_LE_CREATE_CIS, hci_cs_le_create_cis),
@@ -5555,28 +5618,15 @@ static void hci_extended_inquiry_result_evt(struct hci_dev *hdev, void *edata,
 	hci_dev_unlock(hdev);
 }
 
-static void hci_key_refresh_complete_evt(struct hci_dev *hdev, void *data,
-					 struct sk_buff *skb)
+static void hci_conn_refresh_key(struct hci_conn *conn, u8 status)
 {
-	struct hci_ev_key_refresh_complete *ev = data;
-	struct hci_conn *conn;
-
-	bt_dev_dbg(hdev, "status 0x%2.2x handle 0x%4.4x", ev->status,
-		   __le16_to_cpu(ev->handle));
-
-	hci_dev_lock(hdev);
-
-	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
-	if (!conn)
-		goto unlock;
-
 	/* For BR/EDR the necessary steps are taken through the
 	 * auth_complete event.
 	 */
 	if (conn->type != LE_LINK)
-		goto unlock;
+		return;
 
-	if (!ev->status) {
+	if (!status) {
 		bool sec_level_changed =
 				conn->sec_level != conn->pending_sec_level;
 
@@ -5587,25 +5637,64 @@ static void hci_key_refresh_complete_evt(struct hci_dev *hdev, void *data,
 
 	clear_bit(HCI_CONN_ENCRYPT_PEND, conn->flags);
 
-	if (ev->status && conn->state == BT_CONNECTED) {
+	if (status && conn->state == BT_CONNECTED) {
 		hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
 		hci_conn_drop(conn);
-		goto unlock;
+		return;
 	}
 
 	if (conn->state == BT_CONFIG) {
-		if (!ev->status)
+		if (!status)
 			conn->state = BT_CONNECTED;
 
-		hci_connect_cfm(conn, ev->status);
+		hci_connect_cfm(conn, status);
 		hci_conn_drop(conn);
 	} else {
-		hci_auth_cfm(conn, ev->status);
+		hci_auth_cfm(conn, status);
 
 		hci_conn_hold(conn);
 		conn->disc_timeout = HCI_DISCONN_TIMEOUT;
 		hci_conn_drop(conn);
 	}
+}
+
+static void hci_key_refresh_complete_evt(struct hci_dev *hdev, void *data,
+					 struct sk_buff *skb)
+{
+	struct hci_ev_key_refresh_complete *ev = data;
+	struct hci_conn *conn;
+
+	bt_dev_dbg(hdev, "status 0x%2.2x handle 0x%4.4x", ev->status,
+		   __le16_to_cpu(ev->handle));
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
+	if (!conn)
+		goto unlock;
+
+	hci_conn_refresh_key(conn, ev->status);
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
+static void hci_key_refresh_complete_v2_evt(struct hci_dev *hdev, void *data,
+					    struct sk_buff *skb)
+{
+	struct hci_evt_key_refresh_complete_v2 *ev = data;
+	struct hci_conn *conn;
+
+	bt_dev_dbg(hdev, "status 0x%2.2x handle 0x%4.4x", ev->status,
+		   __le16_to_cpu(ev->handle));
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
+	if (!conn)
+		goto unlock;
+
+	hci_conn_refresh_key(conn, ev->status);
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -8402,6 +8491,12 @@ static const struct hci_ev {
 	/* [0x3e = HCI_EV_LE_META] */
 	HCI_EV_REQ_VL(HCI_EV_LE_META, hci_le_meta_evt,
 		      sizeof(struct hci_ev_le_meta), HCI_MAX_EVENT_PLEN),
+	/* [0xfb = HCI_EVT_LE_ENCRYPT_KEY_REFRESH_COMPLETE_V2] */
+	HCI_EV(HCI_EVT_KEY_REFRESH_COMPLETE_V2, hci_key_refresh_complete_v2_evt,
+	       sizeof(struct hci_evt_key_refresh_complete_v2)),
+	/* [0xfc = HCI_EVT_LE_ENCRYPT_CHANGE_V3 */
+	HCI_EV(HCI_EVT_ENCRYPT_CHANGE_V3, hci_encrypt_change_v3_evt,
+	       sizeof(struct hci_evt_encrypt_change_v3)),
 	/* [0xff = HCI_EV_VENDOR] */
 	HCI_EV_VL(HCI_EV_VENDOR, hci_vendor_evt, 0, HCI_MAX_EVENT_PLEN),
 };
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index dd764d6a722f..f5083823223c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5180,6 +5180,13 @@ static int hci_set_event_mask_page_2_sync(struct hci_dev *hdev)
 		changed = true;
 	}
 
+	if (eks_capable(hdev)) {
+		/* EKS events */
+		events[3] |= BIT(2);	/* Encrytion Change v3 */
+		events[3] |= BIT(3);	/* Encrytion Key Refresh Complete v2 */
+		changed = true;
+	}
+
 	/* Some Broadcom based controllers indicate support for Set Event
 	 * Mask Page 2 command, but then actually do not support it. Since
 	 * the default value is all bits set to zero, the command is only
@@ -8456,6 +8463,7 @@ static int hci_le_set_cig_params_v2_sync(struct hci_dev *hdev, u8 cig_id)
 			      qos->ucast.out.phys;
 		cis->c_rtn  = qos->ucast.out.rtn;
 		cis->p_rtn  = qos->ucast.in.rtn;
+		cis->mic_len = 0x02; /* Always prefer 128 bits? */
 
 		/* Use the rates of each direction, or all the HDT rates the
 		 * controller supports if none were set.
@@ -8604,3 +8612,93 @@ int hci_le_create_big_sync(struct hci_conn *conn, struct bt_iso_qos_ext *qos,
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_CREATE_BIG,
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
+
+static void le_enable_encrypt_complete(struct hci_dev *hdev, void *data, int err)
+{
+	bt_dev_dbg(hdev, "err %d", err);
+
+	kfree(data);
+}
+
+static int hci_le_enable_encrypt_v2_sync(struct hci_dev *hdev, void *data)
+{
+	struct hci_cp_le_enable_encrypt_v2 *cp = data;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_ENABLE_ENCRYPT_V2,
+				     sizeof(*cp), cp, HCI_CMD_TIMEOUT);
+}
+
+static int hci_le_enable_encrypt_v2(struct hci_conn *conn, __le16 ediv,
+				    __le64 rand, __u8 ltk[16], __u8 key_size)
+{
+	struct hci_dev *hdev = conn->hdev;
+	struct hci_cp_le_enable_encrypt_v2 *cp;
+	int err;
+
+	bt_dev_dbg(hdev, "hcon %p", conn);
+
+	cp = kzalloc_obj(*cp);
+	if (!cp)
+		return -ENOMEM;
+
+	cp->handle = cpu_to_le16(conn->handle);
+	cp->rand = rand;
+	cp->ediv = ediv;
+	cp->mic_len = 0x02; /* Always prefer 128 bits? */
+
+	/* The key is zero padded when shorter than 16 octets */
+	if (ltk) {
+		memcpy(cp->ltk, ltk, key_size);
+		cp->encryption = 0x00; /* Use LTK provided in LTK field */
+	} else {
+		cp->encryption = 0x01; /* Use opportunistic with EKS */
+	}
+
+	err = hci_cmd_sync_queue_once(hdev, hci_le_enable_encrypt_v2_sync, cp,
+				      le_enable_encrypt_complete);
+	if (err)
+		kfree(cp);
+
+	return err;
+}
+
+static int hci_le_enable_encrypt_sync(struct hci_dev *hdev, void *data)
+{
+	struct hci_cp_le_start_enc *cp = data;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_START_ENC,
+					sizeof(*cp), cp,
+					HCI_CMD_TIMEOUT);
+}
+
+int hci_le_enable_encrypt(struct hci_conn *conn, __le16 ediv, __le64 rand,
+			  __u8 ltk[16], __u8 key_size)
+{
+	struct hci_dev *hdev = conn->hdev;
+	struct hci_cp_le_start_enc *cp;
+	int err;
+
+	/* Check if EKS and HCI_OP_LE_ENABLE_ENCRYPT_V2 are supported */
+	if (eks_capable(hdev) && (hdev->commands[50] & BIT(4)))
+		return hci_le_enable_encrypt_v2(conn, ediv, rand, ltk,
+						key_size);
+
+	bt_dev_dbg(hdev, "hcon %p", conn);
+
+	/* The key is zero padded when shorter than 16 octets */
+	cp = kzalloc_obj(*cp);
+	if (!cp)
+		return -ENOMEM;
+
+	cp->handle = cpu_to_le16(conn->handle);
+	cp->rand = rand;
+	cp->ediv = ediv;
+	memcpy(cp->ltk, ltk, key_size);
+
+	err = hci_cmd_sync_queue_once(hdev, hci_le_enable_encrypt_sync, cp,
+				      le_enable_encrypt_complete);
+	if (err)
+		kfree(cp);
+
+	return err;
+}
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index b7015e37e1f1..dce5ad7b3b6b 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -987,7 +987,12 @@ static u8 smp_random(struct smp_chan *smp)
 		if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, hcon->flags))
 			return SMP_UNSPECIFIED;
 
-		hci_le_start_enc(hcon, ediv, rand, stk, smp->enc_key_size);
+		if (hci_le_enable_encrypt(hcon, ediv, rand, stk,
+					  smp->enc_key_size)) {
+			clear_bit(HCI_CONN_ENCRYPT_PEND, hcon->flags);
+			return SMP_UNSPECIFIED;
+		}
+
 		hcon->enc_key_size = smp->enc_key_size;
 		set_bit(HCI_CONN_STK_ENCRYPT, hcon->flags);
 	} else {
@@ -2209,30 +2214,46 @@ static bool smp_ltk_encrypt(struct l2cap_conn *conn, u8 sec_level)
 {
 	struct smp_ltk *key;
 	struct hci_conn *hcon = conn->hcon;
-	bool ret = false;
+	u8 val[16], enc_size;
+	__le64 rand;
+	__le16 ediv;
 
 	rcu_read_lock();
 
 	key = hci_find_ltk(hcon->hdev, &hcon->dst, hcon->dst_type, hcon->role);
-	if (!key)
-		goto unlock;
+	if (!key || smp_ltk_sec_level(key) < sec_level) {
+		rcu_read_unlock();
+		return false;
+	}
 
-	if (smp_ltk_sec_level(key) < sec_level)
-		goto unlock;
+	if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, hcon->flags)) {
+		rcu_read_unlock();
+		return true;
+	}
 
-	ret = true;
-	if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, hcon->flags))
-		goto unlock;
+	/* Starting the encryption may sleep, so take a copy of the key and
+	 * leave the RCU read-side section first.
+	 */
+	memcpy(val, key->val, sizeof(val));
+	enc_size = key->enc_size;
+	rand = key->rand;
+	ediv = key->ediv;
+
+	rcu_read_unlock();
+
+	if (hci_le_enable_encrypt(hcon, ediv, rand, val, enc_size)) {
+		memzero_explicit(val, sizeof(val));
+		clear_bit(HCI_CONN_ENCRYPT_PEND, hcon->flags);
+		return false;
+	}
 
-	hci_le_start_enc(hcon, key->ediv, key->rand, key->val, key->enc_size);
-	hcon->enc_key_size = key->enc_size;
+	hcon->enc_key_size = enc_size;
+	memzero_explicit(val, sizeof(val));
 
 	/* We never store STKs for initiator role, so clear this flag */
 	clear_bit(HCI_CONN_STK_ENCRYPT, hcon->flags);
 
-unlock:
-	rcu_read_unlock();
-	return ret;
+	return true;
 }
 
 bool smp_sufficient_security(struct hci_conn *hcon, u8 sec_level,
@@ -2927,7 +2948,10 @@ static int smp_cmd_dhkey_check(struct l2cap_conn *conn, struct sk_buff *skb)
 	sc_add_ltk(smp);
 
 	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
-		hci_le_start_enc(hcon, 0, 0, smp->tk, smp->enc_key_size);
+		if (hci_le_enable_encrypt(hcon, 0, 0, smp->tk,
+					  smp->enc_key_size))
+			return SMP_UNSPECIFIED;
+
 		hcon->enc_key_size = smp->enc_key_size;
 	}
 
-- 
2.56.0

