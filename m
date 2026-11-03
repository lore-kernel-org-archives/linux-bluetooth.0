Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744370;
	b=sZqv/7GtNFnkZhNAW6Fv/PEj0pQ3GbpdH6frGu7fh+pfCAfK5noP4EDH57PvKEaDmxRv
	 IxVP/qmxoh45R0tZKVVKydTobqYU06pEUK/ayP4W5wFMfnUXJz69JvlQDqmjo30dZ6mZh
	 1ph0d68PX041SkDbXf23RgLhlRQmNEF9sYPaCMtachbTpC7jk4WRx0zrf5in1zBCmInU9
	 MCjBgN17JbF4tL4dyu3GKw+JG9ULAGpokViE/xAD0s/fa+M/JG8dm7ruYv0TcIg+Y1pH3
	 4J8hPvqgQoqF4+/M0dK10iY0KDQ0oR/fbdD0yGskkeHyG8TrkG7GJSlbKt6S5cDjFhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744370;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=l7FzdOhTrJCzgyJAhYL47PPlx5NxgRpqOegT8c6z9Lg=;
	b=v7bWLbRlNXJYrxlEkBKE+NMhpla5DW0UVJbGa+Cngg84qOZAXpzvneUOlkYlmgjaP5qO
	 DtI56Hisdhsp7R49dv/mxw6pp+YE9AkIVn/3R4El2D45yAfMYted0PVbdWZjRPpm1KwiC
	 BIkYl8GgPdQfAgan4qn2tG4gU3+OD2ZL0z+jgq9ib46pZIGY6NFL1Fezx/2L2449oyX2B
	 Wvs714g0+MUhrft74eHGq/ZyfSoEvjPG7GRfus5K0RjDuddvWCtfay6+nzsV1ikRx12CC
	 9uNc0HpP7JUur3sH77N+4R/jeJux4AbBLf2egRx75lTWjBzmgXP5ePX/BYsLu5cy2Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZBW5j7mg;
	arc=none smtp.remote-ip=209.85.217.53
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A31606A32F
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 22:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56A31606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZBW5j7mg
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7cc0e865dd1so10669137.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 14:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744369; x=1794349169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=l7FzdOhTrJCzgyJAhYL47PPlx5NxgRpqOegT8c6z9Lg=;
        b=ZBW5j7mgijwg2+OsxRIOmlh1wZ90tGC16dPPNSGQTSjwjKzLG9tz2bx8Tl2gkyW2k2
         aWfpNjh5XqVoOQwV4/LsT7rziy5Ysf/y6SjP+ftXVMy/gs/dK6qs8pmEirJav7jw686G
         BhUE3xaTYhOGKa+SWHr4hDvYGkkYq7yGZbmfVdNddFRlBFU9YKhddP8nfBKnrpsARbK/
         md2LFtJjSfz+/TENqrADeFP8XiyFZR5HXzBBZuS0kTwB0HxYTqU8qMr2WrCMjCHCZ16d
         lQWMq8Ri+BX+MbTK1dVzjLMyMmfLtceqWFLOgDxmh+am+dZaymeG+06U2auUkj5yzzTk
         Gsog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744369; x=1794349169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=l7FzdOhTrJCzgyJAhYL47PPlx5NxgRpqOegT8c6z9Lg=;
        b=hxwr0wIZfzfewBgcXQflgQjeOVuHRh2AkoK3AYiA+p45oB0IiZV5k3IC3o8DCl70Y0
         qwRQADhXAdabL6tq9Td69NLvzc9Op35JvOYicEKbsZLme702R93oj8IFUbnrAnHaCVaL
         vx5s4WhHhkFBSxHuF0HU47th2GTRQxlDOzr19fhxkBEMWCveFhXvBlO8sHHsu4rIS1FN
         7Qpt2z9gmjAQN4llxMidvJWmp247/Cl3LHANsCAJ+GiGG566NWdJLRLlZm4A2ztqf3WZ
         AglkvD6vGWfS8tsR/HJuM4yURmt5S6M/3VUmtCKyFPy++qYKyPK1wWCOVP3XLqzI6Oh1
         OVpw==
X-Gm-Message-State: APuU4Z8ztyX0zf48oUicyyrlkpjG438WMQ76Ucc5sSsxQb/W8H4HmtOk
	hAjqZrUgawoH0eOATw04HkYboNq5Hy+lRftRIWm7FJd74Q6KSZIxgjQQ2+OuxQ==
X-Gm-Gg: AYBFou0/RhSncDEXDMuOrVxrK0yvmey6EYovvDqAvHc3Q5fmVPhdZmnojzwsowv5fiv
	9CjyOu18/jkxbXuPTrESobpjh5GRWzd5wVqRYb6bLbnx1WsVLHuZcZWAQkjqXg2xcB2h/h7Giap
	khVcNWPvbwnrgftO1ar9mDgI87Q0O3T4EZ2WEjSMqcy7k7OquYnAzJnbIDJ9erA2BIUkc9CETyt
	9Kjx77UyPfuh7RBMZkfbIE5VHXdAlW3BGum78FHWgBl1TfylzItYiJNq2kEoPO9wT7I1TetVW/c
	0B4vP1KWkBa3X/GHSNCyKggRMlO1tpWMhVLv/7w/WOtunArLXajxkt5pakPzsWUBngAoWzcxrs/
	CCJgu6MuhuAe2x2VlLg6duRFYkJNSQzjjcQFKBFJNW2JmqNKNmMfbq1fkh8/SDtW7tvndB4HKtB
	B4RroXFvirdEoEkEKmQi6SfdPaX5yjOqBMhuemsgNE/GWRA0/4pMX1qPLaq5TunCP9jhRyuoa1q
	zNRqEd90Bq4AkFMZOwmSUeGzbQM25lSoy/s0NRcaEBhPyTHCDUk5RGvahvgOdPZfyGOg1cQCbYl
	7V+v4B2uXtIWDeiancQTNUsHRUXCjPLoD3iiekAMAkg4KrrsB5MnGu7vqNmOfzGRXVBNs7TfMJp
	hdod44EGD2D56maeP1meTEOSVk0jTvTRY3nhn++Zxck8vlPDwWuMzjQMKwqiu/7b0Xn+2/Zdl49
	+J8Za9exn/ZnWOC7gkq4Z7QrJk
X-Received: by 2002:a05:6102:50a5:b0:7c8:4efe:5243 with SMTP id ada2fe7eead31-7d072c0ccc7mr5664258137.14.1793744369054;
        Tue, 03 Nov 2026 14:19:29 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fef4ed3sm306572137.11.2026.11.03.14.19.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:19:28 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 3/6] Bluetooth: Add initial support for EKS
Date: Tue,  3 Nov 2026 17:19:18 -0500
Message-ID: <20261103221921.4071765-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103221921.4071765-1-luiz.dentz@gmail.com>
References: <20261103221921.4071765-1-luiz.dentz@gmail.com>
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
   which picks the version the controller supports.
 - Encryption Change v3 and Encryption Key Refresh Complete v2, enabled
   through Event Mask Page 2, which report the MIC length and whether
   the key schedule is in use. The encryption change and key refresh
   handling is moved to helpers shared by every version of the events.
 - eks_capable() for the Encryption Key Schedule feature bit.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h      |  30 +++++++
 include/net/bluetooth/hci_core.h |   4 +-
 include/net/bluetooth/hci_sync.h |   3 +
 net/bluetooth/hci_conn.c         |  18 ----
 net/bluetooth/hci_event.c        | 149 +++++++++++++++++++++----------
 net/bluetooth/hci_sync.c         |  85 ++++++++++++++++++
 net/bluetooth/smp.c              |   7 +-
 7 files changed, 228 insertions(+), 68 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 525344702c87..e9bbd687b12e 100644
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
@@ -3040,6 +3050,26 @@ struct hci_ev_sync_train_complete {
 
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
index f6e2a414bf2a..60318740ec99 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2181,6 +2181,8 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 	((conn)->le_tx_def_phys & HCI_LE_SET_PHY_HDT)
 #define hdt_rx_capable(conn) \
 	((conn)->le_rx_def_phys & HCI_LE_SET_PHY_HDT)
+#define eks_capable(dev) \
+	(le_feature(dev, 1, 1) & HCI_LE_EKS_FEATURE)
 
 /* Channel sounding support */
 #define le_cs_capable(dev) \
@@ -2628,8 +2630,6 @@ void mgmt_conn_subrate_notify(struct hci_dev *hdev, struct hci_conn *conn,
 int hci_abort_conn(struct hci_conn *conn, u8 reason);
 void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
 		      u16 to_multiplier);
-void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
-		      __u8 ltk[16], __u8 key_size);
 
 void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			       u8 *bdaddr_type);
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index ca21fe81a06e..4b5baee9ce11 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -197,3 +197,6 @@ int hci_le_set_phy(struct hci_conn *conn, u8 tx_phys, u8 rx_phys, u16 phy_opts);
 int hci_le_set_cig_params_sync(struct hci_dev *hdev, u8 cig_id);
 int hci_le_create_big_sync(struct hci_conn *conn, struct bt_iso_qos_v2 *qos,
 			   u8 num_bis);
+
+int hci_le_enable_encrypt(struct hci_conn *conn, __le16 ediv, __le64 rand,
+			  __u8 ltk[16], __u8 key_size);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 8524fca9f273..90aed3b75634 100644
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
index 7b1c2ce58d73..896a2ebd806d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3725,22 +3725,12 @@ static void hci_remote_name_evt(struct hci_dev *hdev, void *data,
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
@@ -3750,7 +3740,7 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 			if (conn->key_type == HCI_LK_AUTH_COMBINATION_P256)
 				set_bit(HCI_CONN_FIPS, conn->flags);
 
-			if ((conn->type == ACL_LINK && ev->encrypt == 0x02) ||
+			if ((conn->type == ACL_LINK && encrypt == 0x02) ||
 			    conn->type == LE_LINK)
 				set_bit(HCI_CONN_AES_CCM, conn->flags);
 
@@ -3781,7 +3771,7 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 	/* We should disregard the current RPA and generate a new one
 	 * whenever the encryption procedure fails.
 	 */
-	if (ev->status && conn->type == LE_LINK) {
+	if (status && conn->type == LE_LINK) {
 		hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
 		hci_adv_instances_set_rpa_expired(hdev, true);
 	}
@@ -3790,23 +3780,23 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 
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
@@ -3816,7 +3806,7 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 			goto notify;
 		}
 
-		goto unlock;
+		return;
 	}
 
 	/* We skip the WRITE_AUTH_PAYLOAD_TIMEOUT for ATS2851 based controllers
@@ -3846,7 +3836,44 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
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
@@ -5546,28 +5573,15 @@ static void hci_extended_inquiry_result_evt(struct hci_dev *hdev, void *edata,
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
 
@@ -5578,25 +5592,64 @@ static void hci_key_refresh_complete_evt(struct hci_dev *hdev, void *data,
 
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
@@ -8409,6 +8462,12 @@ static const struct hci_ev {
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
index f5ee261af67a..1c52b914c236 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5177,6 +5177,13 @@ static int hci_set_event_mask_page_2_sync(struct hci_dev *hdev)
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
@@ -8424,6 +8431,7 @@ static int hci_le_set_cig_params_v2_sync(struct hci_dev *hdev, u8 cig_id)
 				   qos->ucast.in.rates;
 		cis->p_hdt_rates = qos->ucast.in.rates ? qos->ucast.in.rates :
 				   qos->ucast.out.rates;
+		cis->mic_len = 0x02; /* Always prefer 128 bits? */
 
 		/* If HDT PHY is set but rates are not set then enable all HDT
 		 * supported rates.
@@ -8597,3 +8605,80 @@ int hci_le_create_big_sync(struct hci_conn *conn, struct bt_iso_qos_v2 *qos,
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
+				    __le64 rand, __u8 ltk[16])
+{
+	struct hci_dev *hdev = conn->hdev;
+	struct hci_cp_le_enable_encrypt_v2 *cp;
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
+	if (ltk) {
+		memcpy(cp->ltk, ltk, sizeof(cp->ltk));
+		cp->encryption = 0x00; /* Use LTK provided in LTK field */
+	} else {
+		cp->encryption = 0x01; /* Use opportunistic with EKS */
+	}
+
+	return hci_cmd_sync_queue_once(hdev, hci_le_enable_encrypt_v2_sync, cp,
+				       le_enable_encrypt_complete);
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
+
+	/* Check if EKS and HCI_OP_LE_ENABLE_ENCRYPT_V2 are supported */
+	if (eks_capable(hdev) && (hdev->commands[50] & BIT(4)))
+		return hci_le_enable_encrypt_v2(conn, ediv, rand, ltk);
+
+	bt_dev_dbg(hdev, "hcon %p", conn);
+
+	cp = kmalloc_obj(*cp);
+	if (!cp)
+		return -ENOMEM;
+
+	cp->handle = cpu_to_le16(conn->handle);
+	cp->rand = rand;
+	cp->ediv = ediv;
+	memcpy(cp->ltk, ltk, key_size);
+
+	return hci_cmd_sync_queue_once(hdev, hci_le_enable_encrypt_sync, cp,
+				       le_enable_encrypt_complete);
+}
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index b7015e37e1f1..0dc236cd4d1c 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -987,7 +987,7 @@ static u8 smp_random(struct smp_chan *smp)
 		if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, hcon->flags))
 			return SMP_UNSPECIFIED;
 
-		hci_le_start_enc(hcon, ediv, rand, stk, smp->enc_key_size);
+		hci_le_enable_encrypt(hcon, ediv, rand, stk, smp->enc_key_size);
 		hcon->enc_key_size = smp->enc_key_size;
 		set_bit(HCI_CONN_STK_ENCRYPT, hcon->flags);
 	} else {
@@ -2224,7 +2224,8 @@ static bool smp_ltk_encrypt(struct l2cap_conn *conn, u8 sec_level)
 	if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, hcon->flags))
 		goto unlock;
 
-	hci_le_start_enc(hcon, key->ediv, key->rand, key->val, key->enc_size);
+	hci_le_enable_encrypt(hcon, key->ediv, key->rand, key->val,
+			      key->enc_size);
 	hcon->enc_key_size = key->enc_size;
 
 	/* We never store STKs for initiator role, so clear this flag */
@@ -2927,7 +2928,7 @@ static int smp_cmd_dhkey_check(struct l2cap_conn *conn, struct sk_buff *skb)
 	sc_add_ltk(smp);
 
 	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
-		hci_le_start_enc(hcon, 0, 0, smp->tk, smp->enc_key_size);
+		hci_le_enable_encrypt(hcon, 0, 0, smp->tk, smp->enc_key_size);
 		hcon->enc_key_size = smp->enc_key_size;
 	}
 
-- 
2.56.0

