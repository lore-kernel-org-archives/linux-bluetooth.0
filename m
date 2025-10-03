Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EA033E1
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Oct 2025 15:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759505680; cv=none; b=gfyW3OtaFUfpAXwJlNWYF0rs75zrQM0GA0hEws5TXMWsf0qv76KwhX0PLnjDzUsDg53DDbnpBgTWA/rWly7NGp9Duj99PrTN3Xe/iK3Ud3WO2BEIxShLmSqB37t5VFA+MpkJfL/UTwZFg7pQy1ryMyfpzT/efD1nwCcJZzyv1+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759505680; c=relaxed/simple;
	bh=SIg0rr7qDPq7SPesLWuZiUrtZm5K/Fzjc85w8/EyqHo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=owpHb0YZmCnu+RRY5hDXS5JtWwqoulna68MwIt8649JWE3b3U+zi6HfmGy/VYSxqxMy4FjHyTNY0TQknmzbIjspeADQyuX6JKYBEM+XRguVysoP6gBbTbY1LQ3Tp4dVZ9UG911QXeA4iFkO0cjZXi+vO3j/K9E2D/Z/AecZbg3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjopRsVb; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjopRsVb"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-54a86cc950dso427992e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Oct 2025 08:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759505674; x=1760110474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tHBvGIoAj5TFs/PgBRgLUR4Cqowd5PhtF4geXnM7ts8=;
        b=BjopRsVbNj8uAGRZaHFDAoXKaTymir0DIFRKfpduyhllqoW5uvgRTxO5+zKahej0M9
         3qGFTPeHHIoDmAkQ3qxW8iqTa1L1xAjdHBoomDN4MC2f1RudHdFNu0UozprT3nnhPRe3
         Xe2fB8YaIcB/jkb+SOx4iwGy8ZGnASUFoUR+iKnP7gEIo0ngiTUhJCphBqpdBRl2zOn8
         kfBtF3gu9q5qBN+fSraghsMHW3VA6n9XQVV/cMBTax7n1/4D7edQR2cmBH3vf74poDq7
         pYh0qLgS2O7TOkndY1VW4C2d993mNXNUSALmnlpyz6f/D6CMzq3WsHmwPkkSPuUwqPmx
         rh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759505674; x=1760110474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tHBvGIoAj5TFs/PgBRgLUR4Cqowd5PhtF4geXnM7ts8=;
        b=mCK86AUIzke8Ek+K3l2T9w1hozWoFopyLKKNdS1gGX9zIDBdYXl5n9X6fIIYGKWoQG
         /2XGO0d1vxwZ50ey1RVVmrkMgiS0/ZDH9+1tvkRlXnErI/gmqq48rgcH22/iCFtSc1SW
         OVymqHi6CksoZVpArV1ub+8OI21YBdSqb6/Z/mRVZp+pzDBZC3akxwNkRlFrExLVAWVs
         k2BTyfobSMyB7/A5O18oxH6YkxUwxPUAV1ZL8a5xsIboN9M4LfjRVh21ExP5cDQ6qhNB
         PKN7fCxWP5/g4wakgx3a4SpMQoZgu/GEacgE4IGVEg++h3ac4N9c7im0IsnMQK1DHiEM
         LsAA==
X-Gm-Message-State: AOJu0YxbxDn4JqOJKDhqWrzAssbUh0qa3j3Zw0UgD+jPHIHiWJ2XEVob
	JWs2Gbejz0KEXy8sa4VWG//4R+61a57muU+UIm5/lZqozu5Ni2Tv8Lq168Up6VSO
X-Gm-Gg: ASbGncvAM9i9C6OywhVY6YFYLhscYTifccUtECB0PJgZHzpm7R3tLowqcvStIgVLSjj
	t3bnvYebKdc29teETw7I/JsaAJhf+A7u9YNmquOBUSOxpBvBy1aOW8k55tXV8hCRyxLo43aLQqw
	prz3Av2V6XaPLOAX/Lv9aySm9Q6BO825A4CTNcZLazrTuE/gkTeM1RSWBZFjXij2aL86i5NDYzd
	u8tvCBr7OZd20dvaG3sO6OZwboHTZEXnZvMg7Gc/kvHJYT3e12X+0yCCIyF1Njc4+a3REkn0cD7
	dLu6qxDySckvQlnPFp+cSVKZLBa35pLW9BqGOt+/DG+jW9Y2fN6Nz+QqOoSj5ZhDHA7lc6lWDx7
	yZQk63hZ3ijtCGeyYWG1Psxgp7HCRKOs/X/Wu+q0S6LA67p0WeGRJ/TwcJ6b5yBN1U7RlDC4dwc
	MaEEO0pnYv4dJ+vQ==
X-Google-Smtp-Source: AGHT+IE4iE1/o0KAAFxwTe0+6U/GZlQJ1UztKqiN0fGTFWkvMhnX9xMv7SulCCXziVmqlQyen+jRpA==
X-Received: by 2002:a05:6122:c95:b0:54b:c31b:9380 with SMTP id 71dfb90a1353d-5524ea12174mr1339501e0c.10.1759505673897;
        Fri, 03 Oct 2025 08:34:33 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-92eb67dec87sm994090241.11.2025.10.03.08.34.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 08:34:33 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 1/5] Bluetooth: HCI: Add initial support for PAST
Date: Fri,  3 Oct 2025 11:34:20 -0400
Message-ID: <20251003153424.470938-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds PAST related commands (HCI_OP_LE_PAST,
HCI_OP_LE_PAST_SET_INFO and HCI_OP_LE_PAST_PARAMS) and events
(HCI_EV_LE_PAST_RECEIVED) along with handling of PAST sender and
receiver features bits including new MGMG settings (
HCI_EV_LE_PAST_RECEIVED and MGMT_SETTING_PAST_RECEIVER) which
userspace can use to determine if PAST is supported by the
controller.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h      | 54 ++++++++++++++++++++++
 include/net/bluetooth/hci_core.h | 12 +++++
 include/net/bluetooth/mgmt.h     |  2 +
 net/bluetooth/hci_event.c        | 79 ++++++++++++++++++++++++++++----
 net/bluetooth/hci_sync.c         |  3 ++
 net/bluetooth/iso.c              | 25 ++++++++++
 net/bluetooth/mgmt.c             | 12 +++++
 7 files changed, 177 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 8d0e703bc929..a998f8edbb53 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -647,6 +647,8 @@ enum {
 #define HCI_LE_EXT_ADV			0x10
 #define HCI_LE_PERIODIC_ADV		0x20
 #define HCI_LE_CHAN_SEL_ALG2		0x40
+#define HCI_LE_PAST_SENDER		0x01
+#define HCI_LE_PAST_RECEIVER		0x02
 #define HCI_LE_CIS_CENTRAL		0x10
 #define HCI_LE_CIS_PERIPHERAL		0x20
 #define HCI_LE_ISO_BROADCASTER		0x40
@@ -2068,6 +2070,44 @@ struct hci_cp_le_set_privacy_mode {
 	__u8  mode;
 } __packed;
 
+#define HCI_OP_LE_PAST			0x205a
+struct hci_cp_le_past {
+	__le16 handle;
+	__le16 service_data;
+	__le16 sync_handle;
+} __packed;
+
+struct hci_rp_le_past {
+	__u8   status;
+	__le16 handle;
+} __packed;
+
+#define HCI_OP_LE_PAST_SET_INFO		0x205b
+struct hci_cp_le_past_set_info {
+	__le16 handle;
+	__le16 service_data;
+	__u8   adv_handle;
+} __packed;
+
+struct hci_rp_le_past_set_info {
+	__u8   status;
+	__le16 handle;
+} __packed;
+
+#define HCI_OP_LE_PAST_PARAMS		0x205c
+struct hci_cp_le_past_params {
+	__le16  handle;
+	__u8    mode;
+	__le16  skip;
+	__le16  sync_timeout;
+	__u8    cte_type;
+} __packed;
+
+struct hci_rp_le_past_params {
+	__u8   status;
+	__le16 handle;
+} __packed;
+
 #define HCI_OP_LE_READ_BUFFER_SIZE_V2	0x2060
 struct hci_rp_le_read_buffer_size_v2 {
 	__u8    status;
@@ -2795,6 +2835,20 @@ struct hci_evt_le_ext_adv_set_term {
 	__u8	num_evts;
 } __packed;
 
+#define HCI_EV_LE_PAST_RECEIVED		0x18
+struct hci_ev_le_past_received {
+	__u8   status;
+	__le16 handle;
+	__le16 service_data;
+	__le16 sync_handle;
+	__u8   sid;
+	__u8   bdaddr_type;
+	bdaddr_t  bdaddr;
+	__u8   phy;
+	__le16 interval;
+	__u8   clock_accuracy;
+} __packed;
+
 #define HCI_EVT_LE_CIS_ESTABLISHED	0x19
 struct hci_evt_le_cis_established {
 	__u8  status;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2924c2bf2a98..894e01717b55 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2045,6 +2045,18 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define sync_recv_capable(dev) \
 	((dev)->le_features[3] & HCI_LE_ISO_SYNC_RECEIVER)
 #define sync_recv_enabled(dev) (le_enabled(dev) && sync_recv_capable(dev))
+#define past_sender_capable(dev) \
+	((dev)->le_features[3] & HCI_LE_PAST_SENDER)
+#define past_receiver_capable(dev) \
+	((dev)->le_features[3] & HCI_LE_PAST_RECEIVER)
+#define past_capable(dev) \
+	(past_sender_capable(dev) || past_receiver_capable(dev))
+#define past_sender_enabled(dev) \
+	(le_enabled(dev) && past_sender_capable(dev))
+#define past_receiver_enabled(dev) \
+	(le_enabled(dev) && past_receiver_capable(dev))
+#define past_enabled(dev) \
+	(past_sender_enabled(dev) || past_receiver_enabled(dev))
 
 #define mws_transport_config_capable(dev) (((dev)->commands[30] & 0x08) && \
 	(!hci_test_quirk((dev), HCI_QUIRK_BROKEN_MWS_TRANSPORT_CONFIG)))
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 74edea06985b..bf2b82f111ca 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -119,6 +119,8 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_ISO_BROADCASTER	BIT(20)
 #define MGMT_SETTING_ISO_SYNC_RECEIVER	BIT(21)
 #define MGMT_SETTING_LL_PRIVACY		BIT(22)
+#define MGMT_SETTING_PAST_SENDER	BIT(23)
+#define MGMT_SETTING_PAST_RECEIVER	BIT(24)
 
 #define MGMT_OP_READ_INFO		0x0004
 #define MGMT_READ_INFO_SIZE		0
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1dabf5a7ae18..f1735a7e48a7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5903,6 +5903,71 @@ static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, void *data,
 	hci_dev_unlock(hdev);
 }
 
+static int hci_le_pa_term_sync(struct hci_dev *hdev, __le16 handle)
+{
+	struct hci_cp_le_pa_term_sync cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.handle = handle;
+
+	return hci_send_cmd(hdev, HCI_OP_LE_PA_TERM_SYNC, sizeof(cp), &cp);
+}
+
+static void hci_le_past_received_evt(struct hci_dev *hdev, void *data,
+				     struct sk_buff *skb)
+{
+	struct hci_ev_le_past_received *ev = data;
+	int mask = hdev->link_mode;
+	__u8 flags = 0;
+	struct hci_conn *pa_sync, *conn;
+
+	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
+
+	hci_dev_lock(hdev);
+
+	hci_dev_clear_flag(hdev, HCI_PA_SYNC);
+
+	conn = hci_conn_hash_lookup_create_pa_sync(hdev);
+	if (!conn) {
+		bt_dev_err(hdev,
+			   "Unable to find connection for dst %pMR sid 0x%2.2x",
+			   &ev->bdaddr, ev->sid);
+		goto unlock;
+	}
+
+	conn->sync_handle = le16_to_cpu(ev->sync_handle);
+	conn->sid = HCI_SID_INVALID;
+
+	mask |= hci_proto_connect_ind(hdev, &ev->bdaddr, PA_LINK,
+				      &flags);
+	if (!(mask & HCI_LM_ACCEPT)) {
+		hci_le_pa_term_sync(hdev, ev->sync_handle);
+		goto unlock;
+	}
+
+	if (!(flags & HCI_PROTO_DEFER))
+		goto unlock;
+
+	/* Add connection to indicate PA sync event */
+	pa_sync = hci_conn_add_unset(hdev, PA_LINK, BDADDR_ANY,
+				     HCI_ROLE_SLAVE);
+
+	if (IS_ERR(pa_sync))
+		goto unlock;
+
+	pa_sync->sync_handle = le16_to_cpu(ev->sync_handle);
+
+	if (ev->status) {
+		set_bit(HCI_CONN_PA_SYNC_FAILED, &pa_sync->flags);
+
+		/* Notify iso layer */
+		hci_connect_cfm(pa_sync, ev->status);
+	}
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
 static void hci_le_conn_update_complete_evt(struct hci_dev *hdev, void *data,
 					    struct sk_buff *skb)
 {
@@ -6379,16 +6444,6 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, void *data,
 	hci_dev_unlock(hdev);
 }
 
-static int hci_le_pa_term_sync(struct hci_dev *hdev, __le16 handle)
-{
-	struct hci_cp_le_pa_term_sync cp;
-
-	memset(&cp, 0, sizeof(cp));
-	cp.handle = handle;
-
-	return hci_send_cmd(hdev, HCI_OP_LE_PA_TERM_SYNC, sizeof(cp), &cp);
-}
-
 static void hci_le_pa_sync_established_evt(struct hci_dev *hdev, void *data,
 					   struct sk_buff *skb)
 {
@@ -7180,6 +7235,10 @@ static const struct hci_le_ev {
 	/* [0x12 = HCI_EV_LE_EXT_ADV_SET_TERM] */
 	HCI_LE_EV(HCI_EV_LE_EXT_ADV_SET_TERM, hci_le_ext_adv_term_evt,
 		  sizeof(struct hci_evt_le_ext_adv_set_term)),
+	/* [0x18 = HCI_EVT_LE_PAST_RECEIVED] */
+	HCI_LE_EV(HCI_EV_LE_PAST_RECEIVED,
+		  hci_le_past_received_evt,
+		  sizeof(struct hci_ev_le_past_received)),
 	/* [0x19 = HCI_EVT_LE_CIS_ESTABLISHED] */
 	HCI_LE_EV(HCI_EVT_LE_CIS_ESTABLISHED, hci_le_cis_established_evt,
 		  sizeof(struct hci_evt_le_cis_established)),
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 28ad08cd7d70..277b2c096195 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4393,6 +4393,9 @@ static int hci_le_set_event_mask_sync(struct hci_dev *hdev)
 	if (ext_adv_capable(hdev))
 		events[2] |= 0x02;	/* LE Advertising Set Terminated */
 
+	if (past_receiver_capable(hdev))
+		events[2] |= 0x80;	/* LE PAST Received */
+
 	if (cis_capable(hdev)) {
 		events[3] |= 0x01;	/* LE CIS Established */
 		if (cis_peripheral_capable(hdev))
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 954e1916506b..7f66f287c14e 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -80,6 +80,7 @@ static struct bt_iso_qos default_qos;
 static bool check_ucast_qos(struct bt_iso_qos *qos);
 static bool check_bcast_qos(struct bt_iso_qos *qos);
 static bool iso_match_sid(struct sock *sk, void *data);
+static bool iso_match_sid_past(struct sock *sk, void *data);
 static bool iso_match_sync_handle(struct sock *sk, void *data);
 static bool iso_match_sync_handle_pa_report(struct sock *sk, void *data);
 static void iso_sock_disconn(struct sock *sk);
@@ -2084,6 +2085,16 @@ static bool iso_match_sid(struct sock *sk, void *data)
 	return ev->sid == iso_pi(sk)->bc_sid;
 }
 
+static bool iso_match_sid_past(struct sock *sk, void *data)
+{
+	struct hci_ev_le_past_received *ev = data;
+
+	if (iso_pi(sk)->bc_sid == HCI_SID_INVALID)
+		return true;
+
+	return ev->sid == iso_pi(sk)->bc_sid;
+}
+
 static bool iso_match_sync_handle(struct sock *sk, void *data)
 {
 	struct hci_evt_le_big_info_adv_report *ev = data;
@@ -2103,6 +2114,7 @@ static bool iso_match_sync_handle_pa_report(struct sock *sk, void *data)
 int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 {
 	struct hci_ev_le_pa_sync_established *ev1;
+	struct hci_ev_le_past_received *ev1a;
 	struct hci_evt_le_big_info_adv_report *ev2;
 	struct hci_ev_le_per_adv_report *ev3;
 	struct sock *sk;
@@ -2116,6 +2128,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	 * SID to listen to and once sync is established its handle needs to
 	 * be stored in iso_pi(sk)->sync_handle so it can be matched once
 	 * receiving the BIG Info.
+	 * 1a. HCI_EV_LE_PAST_RECEIVED: alternative to 1.
 	 * 2. HCI_EVT_LE_BIG_INFO_ADV_REPORT: When connect_ind is triggered by a
 	 * a BIG Info it attempts to check if there any listening socket with
 	 * the same sync_handle and if it does then attempt to create a sync.
@@ -2135,6 +2148,18 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 		goto done;
 	}
 
+	ev1a = hci_recv_event_data(hdev, HCI_EV_LE_PAST_RECEIVED);
+	if (ev1a) {
+		sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_LISTEN,
+				  iso_match_sid_past, ev1a);
+		if (sk && !ev1a->status) {
+			iso_pi(sk)->sync_handle = le16_to_cpu(ev1a->sync_handle);
+			iso_pi(sk)->bc_sid = ev1a->sid;
+		}
+
+		goto done;
+	}
+
 	ev2 = hci_recv_event_data(hdev, HCI_EVT_LE_BIG_INFO_ADV_REPORT);
 	if (ev2) {
 		/* Check if BIGInfo report has already been handled */
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a3d16eece0d2..4b7cab707d69 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -852,6 +852,12 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 	if (ll_privacy_capable(hdev))
 		settings |= MGMT_SETTING_LL_PRIVACY;
 
+	if (past_sender_capable(hdev))
+		settings |= MGMT_SETTING_PAST_SENDER;
+
+	if (past_receiver_capable(hdev))
+		settings |= MGMT_SETTING_PAST_RECEIVER;
+
 	settings |= MGMT_SETTING_PHY_CONFIGURATION;
 
 	return settings;
@@ -937,6 +943,12 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (ll_privacy_enabled(hdev))
 		settings |= MGMT_SETTING_LL_PRIVACY;
 
+	if (past_sender_enabled(hdev))
+		settings |= MGMT_SETTING_PAST_SENDER;
+
+	if (past_receiver_enabled(hdev))
+		settings |= MGMT_SETTING_PAST_RECEIVER;
+
 	return settings;
 }
 
-- 
2.51.0

