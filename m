Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806FA3328FB
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763389538; cv=none; b=Shqew64WOXCYBVDlH8UG7QXrLwLW6QNrW+2eF4rVYtaC/NHUAcDBzriy2bD87eVDq0j6ztrMgTO/pekim11pRX/fTqmGiqc8rrHAqne7VYb3qer4pWJarRUG4z50yna48GbwhM32eEfb88zg7k4l9ex+5WgcIMsqzsipyN0o7ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763389538; c=relaxed/simple;
	bh=SxBMNtub3oMvAFvqhAikUCC8Gxu+ijKljBWk8XZC4L0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e59TCd22vsNUh3qQanutdCJOw8Q+jk7pdN1U9ouubY3UXCPjF6jqhFiVsaT+y+8D7WbNF3nHNdfg1X2cTRTAKfnfclngsGYobUi1UWRvChy5MNRgDix6MqcwxmtSLyE9F60ahBzPH6ZsjwJRgaHcV8psdDrIBwjg0084aYX3Y4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlG9YXEc; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlG9YXEc"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5dfa9e34adbso3208053137.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 06:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763389534; x=1763994334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hFF28o44sXUxdh0+S2J3c2O+FUBVizxNpfZeMSMDKVQ=;
        b=JlG9YXEc2dUkSS0fV7aJtF0pV/AuCgxZo7n8cL8kRZC4D3y17t5io1uLH//zGLXrfS
         m9zI5Ugug5ORJ36ygZkdccadloa4pKFoAY6Eg0JhlQub6WvnUkc+VO0LoIszBcrjw/eZ
         qTQ6RhdJXepiLn09IvhKPKI1AbiTyPy+YqI24hhRhcu7oFH/COf4fgR3hjB/zmA6iRgP
         HsHj3Suf8B//wBKHKswJV05kIQZyLP+R5pcuqVhcyz9XYZznUguiH9zoe9/jKK8xS3TB
         F+CF4eUbRJI6MqiwfupD+kix//qho6pOPjAdlQdz/BFc4Y6YwFRtMNuTxWLD1vL6vkHe
         L//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763389534; x=1763994334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hFF28o44sXUxdh0+S2J3c2O+FUBVizxNpfZeMSMDKVQ=;
        b=m4lBgVh96eFpVLWeKU32ADSWEaUuwwoNiNp5OGHqTMQ3Um36tK4yKprYlShX7hoo8T
         FDMjCfCXk96kpY1WUGNvAkXXvcwO/hRM95jb74EgYdCO1roT9bzIhXc5dRcrFyht6KM1
         JMG57SanH0DtassjiGxD9IRhDxGWHBvF7E4V1y8PmY0zf4wp9Fbz6e/fRNNQ3+xT6JmQ
         fsRAxeus/OzXX+/+baVQhX74kEk37b2htxa4CvyaGzwjzgqq0WQ0id+aPcEs5DjOeO34
         3lCb8B+fRgjepTOW2HEDC+IwFeIwMU18mEk1DtGq0/g10khOhU2l47q5lHj7l+UDWf97
         8gVg==
X-Gm-Message-State: AOJu0YzkvNff6Nsrdw1m7DzaKLI3/RX6wHdxBaIymsn+L0ky3w9ltIbq
	rZ6+PqKO5XWEfWxo3Z0KbPTBIaJBtC0DCVhbValmoJHGJcIUgzY7Oh8kCvxTSVhj
X-Gm-Gg: ASbGncuCfZFEwoKDxh/QOca+ABfeCI3SZ42bYncEuyPD5uRAh/BHEmW0kLKVyL/1dCP
	dawXciCobIviWw4N2N0Jf+VYCCAJ/KcbEfAeFVcNDne/cjfemJzJxWRZ6P/Y1pTWPyYRVR7+7rd
	j9nVitJ4FBPcd9+OekzP0Q+TE5CGmuejxarwO0ufGLz2+yVN9tygAPbwKH3YkfUSC1MnCQINiPv
	sWnwYDOsQ+FaLqNlm/wSh0zc6BbRb0oQAVofjL9FfdjfIBNpjDLcTfTtEk1zR8mHdI7WXmKLzUX
	rfbmKwkKQSayXk5wIK/QymQn1uq1TTj3KiAGWm0q8lHWVY8KVptmPXEvBFYRtOggTIryH7HLlf4
	WI1gkhGgDmkVxYOiZ8Nb2iqngx6DPHACk6eHesidXqdp4dapa9eqgKlf9LR30JB3ohngMoTsNpl
	C87N8sCWJjmsq6UQ==
X-Google-Smtp-Source: AGHT+IGn5HfdsxipVhfYz6rOK8FGR6bF6HIGtKDx53uaeepr50SbzCJI97GlfuMavUJjOmDOG1g1BA==
X-Received: by 2002:a05:6102:8019:b0:5db:d487:2ef8 with SMTP id ada2fe7eead31-5dfc5b72543mr4827083137.20.1763389534072;
        Mon, 17 Nov 2025 06:25:34 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b0f32efe1sm4310413e0c.2.2025.11.17.06.25.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 06:25:31 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: HCI: Add support for LL Extended Feature Set
Date: Mon, 17 Nov 2025 09:25:21 -0500
Message-ID: <20251117142521.3804561-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for emulating LL Extended Feature Set introduced in 6.0
that adds the following:

Commands:

 - HCI_LE_Read_All_Local_Supported_­Features(0x2087)(Feature:47,1)
 - HCI_LE_Read_All_Remote_Features(0x2088)(Feature:47,2)

Events:

 - HCI_LE_Read_All_Remote_Features_Complete(0x2b)(Mask bit:42)

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h      |  23 ++++++
 include/net/bluetooth/hci_core.h |   5 +-
 include/net/bluetooth/hci_sync.h |   2 +
 net/bluetooth/hci_event.c        | 125 ++++++++++++++++++++++++-------
 net/bluetooth/hci_sync.c         | 102 ++++++++++++++++++++++++-
 5 files changed, 227 insertions(+), 30 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5170f0df3f59..caa21fc19c95 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -653,6 +653,7 @@ enum {
 #define HCI_LE_CIS_PERIPHERAL		0x20
 #define HCI_LE_ISO_BROADCASTER		0x40
 #define HCI_LE_ISO_SYNC_RECEIVER	0x80
+#define HCI_LE_LL_EXT_FEATURE		0x80
 
 /* Connection modes */
 #define HCI_CM_ACTIVE	0x0000
@@ -2255,6 +2256,19 @@ struct hci_cp_le_set_host_feature {
 	__u8     bit_value;
 } __packed;
 
+#define HCI_OP_LE_READ_ALL_LOCAL_FEATURES	0x2087
+struct hci_rp_le_read_all_local_features {
+	__u8    status;
+	__u8    page;
+	__u8    features[248];
+} __packed;
+
+#define HCI_OP_LE_READ_ALL_REMOTE_FEATURES	0x2088
+struct hci_cp_le_read_all_remote_features {
+	__le16	 handle;
+	__u8	 pages;
+} __packed;
+
 /* ---- HCI Events ---- */
 struct hci_ev_status {
 	__u8    status;
@@ -2937,6 +2951,15 @@ struct hci_evt_le_big_info_adv_report {
 	__u8    encryption;
 } __packed;
 
+#define HCI_EVT_LE_ALL_REMOTE_FEATURES_COMPLETE 0x2b
+struct hci_evt_le_read_all_remote_features_complete {
+	__u8    status;
+	__le16  handle;
+	__u8    max_pages;
+	__u8    valid_pages;
+	__u8    features[248];
+} __packed;
+
 #define HCI_EV_VENDOR			0xff
 
 /* Internal events generated by Bluetooth stack */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9efdefed33c0..28f948e1051a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -378,7 +378,7 @@ struct hci_dev {
 	__u8		minor_class;
 	__u8		max_page;
 	__u8		features[HCI_MAX_PAGES][8];
-	__u8		le_features[8];
+	__u8		le_features[248];
 	__u8		le_accept_list_size;
 	__u8		le_resolv_list_size;
 	__u8		le_num_of_adv_sets;
@@ -702,6 +702,7 @@ struct hci_conn {
 	__u8		attempt;
 	__u8		dev_class[3];
 	__u8		features[HCI_MAX_PAGES][8];
+	__u8		le_features[248];
 	__u16		pkt_type;
 	__u16		link_policy;
 	__u8		key_type;
@@ -2059,6 +2060,8 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 	(le_enabled(dev) && past_receiver_capable(dev))
 #define past_enabled(dev) \
 	(past_sender_enabled(dev) || past_receiver_enabled(dev))
+#define ll_ext_feature_capable(dev) \
+	((dev)->le_features[7] & HCI_LE_LL_EXT_FEATURE)
 
 #define mws_transport_config_capable(dev) (((dev)->commands[30] & 0x08) && \
 	(!hci_test_quirk((dev), HCI_QUIRK_BROKEN_MWS_TRANSPORT_CONFIG)))
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 3133f40fa9f9..56076bbc981d 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -189,3 +189,5 @@ int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn *conn,
 int hci_connect_pa_sync(struct hci_dev *hdev, struct hci_conn *conn);
 int hci_connect_big_sync(struct hci_dev *hdev, struct hci_conn *conn);
 int hci_past_sync(struct hci_conn *conn, struct hci_conn *le);
+
+int hci_le_read_remote_features(struct hci_conn *conn);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7c4ca14f13e5..a9868f17ef40 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2886,12 +2886,8 @@ static void hci_cs_le_read_remote_features(struct hci_dev *hdev, u8 status)
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(cp->handle));
-	if (conn) {
-		if (conn->state == BT_CONFIG) {
-			hci_connect_cfm(conn, status);
-			hci_conn_drop(conn);
-		}
-	}
+	if (conn && conn->state == BT_CONFIG)
+		hci_connect_cfm(conn, status);
 
 	hci_dev_unlock(hdev);
 }
@@ -3915,11 +3911,49 @@ static u8 hci_cc_le_setup_iso_path(struct hci_dev *hdev, void *data,
 	return rp->status;
 }
 
+static u8 hci_cc_le_read_all_local_features(struct hci_dev *hdev, void *data,
+					    struct sk_buff *skb)
+{
+	struct hci_rp_le_read_all_local_features *rp = data;
+
+	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
+
+	if (rp->status)
+		return rp->status;
+
+	memcpy(hdev->le_features, rp->features, 248);
+
+	return rp->status;
+}
+
 static void hci_cs_le_create_big(struct hci_dev *hdev, u8 status)
 {
 	bt_dev_dbg(hdev, "status 0x%2.2x", status);
 }
 
+static void hci_cs_le_read_all_remote_features(struct hci_dev *hdev, u8 status)
+{
+	struct hci_cp_le_read_remote_features *cp;
+	struct hci_conn *conn;
+
+	bt_dev_dbg(hdev, "status 0x%2.2x", status);
+
+	if (!status)
+		return;
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_READ_ALL_REMOTE_FEATURES);
+	if (!cp)
+		return;
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(cp->handle));
+	if (conn && conn->state == BT_CONFIG)
+		hci_connect_cfm(conn, status);
+
+	hci_dev_unlock(hdev);
+}
+
 static u8 hci_cc_set_per_adv_param(struct hci_dev *hdev, void *data,
 				   struct sk_buff *skb)
 {
@@ -4171,6 +4205,9 @@ static const struct hci_cc {
 		  sizeof(struct hci_rp_le_set_cig_params), HCI_MAX_EVENT_SIZE),
 	HCI_CC(HCI_OP_LE_SETUP_ISO_PATH, hci_cc_le_setup_iso_path,
 	       sizeof(struct hci_rp_le_setup_iso_path)),
+	HCI_CC(HCI_OP_LE_READ_ALL_LOCAL_FEATURES,
+	       hci_cc_le_read_all_local_features,
+	       sizeof(struct hci_rp_le_read_all_local_features)),
 };
 
 static u8 hci_cc_func(struct hci_dev *hdev, const struct hci_cc *cc,
@@ -4325,6 +4362,8 @@ static const struct hci_cs {
 	HCI_CS(HCI_OP_LE_EXT_CREATE_CONN, hci_cs_le_ext_create_conn),
 	HCI_CS(HCI_OP_LE_CREATE_CIS, hci_cs_le_create_cis),
 	HCI_CS(HCI_OP_LE_CREATE_BIG, hci_cs_le_create_big),
+	HCI_CS(HCI_OP_LE_READ_ALL_REMOTE_FEATURES,
+	       hci_cs_le_read_all_remote_features),
 };
 
 static void hci_cmd_status_evt(struct hci_dev *hdev, void *data,
@@ -5645,6 +5684,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	struct hci_conn *conn;
 	struct smp_irk *irk;
 	u8 addr_type;
+	int err;
 
 	hci_dev_lock(hdev);
 
@@ -5775,26 +5815,8 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	hci_debugfs_create_conn(conn);
 	hci_conn_add_sysfs(conn);
 
-	/* The remote features procedure is defined for central
-	 * role only. So only in case of an initiated connection
-	 * request the remote features.
-	 *
-	 * If the local controller supports peripheral-initiated features
-	 * exchange, then requesting the remote features in peripheral
-	 * role is possible. Otherwise just transition into the
-	 * connected state without requesting the remote features.
-	 */
-	if (conn->out ||
-	    (hdev->le_features[0] & HCI_LE_PERIPHERAL_FEATURES)) {
-		struct hci_cp_le_read_remote_features cp;
-
-		cp.handle = __cpu_to_le16(conn->handle);
-
-		hci_send_cmd(hdev, HCI_OP_LE_READ_REMOTE_FEATURES,
-			     sizeof(cp), &cp);
-
-		hci_conn_hold(conn);
-	} else {
+	err = hci_le_read_remote_features(conn);
+	if (err) {
 		conn->state = BT_CONNECTED;
 		hci_connect_cfm(conn, status);
 	}
@@ -6608,7 +6630,6 @@ static void hci_le_remote_feat_complete_evt(struct hci_dev *hdev, void *data,
 
 			conn->state = BT_CONNECTED;
 			hci_connect_cfm(conn, status);
-			hci_conn_drop(conn);
 		}
 	}
 
@@ -7186,6 +7207,50 @@ static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev, void *data,
 	hci_dev_unlock(hdev);
 }
 
+static void hci_le_read_all_remote_features_evt(struct hci_dev *hdev,
+						void *data, struct sk_buff *skb)
+{
+	struct hci_evt_le_read_all_remote_features_complete *ev = data;
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
+	if (!ev->status)
+		memcpy(conn->le_features, ev->features, 248);
+
+	if (conn->state == BT_CONFIG) {
+		__u8 status;
+
+		/* If the local controller supports peripheral-initiated
+		 * features exchange, but the remote controller does
+		 * not, then it is possible that the error code 0x1a
+		 * for unsupported remote feature gets returned.
+		 *
+		 * In this specific case, allow the connection to
+		 * transition into connected state and mark it as
+		 * successful.
+		 */
+		if (!conn->out &&
+		    ev->status == HCI_ERROR_UNSUPPORTED_REMOTE_FEATURE &&
+		    (hdev->le_features[0] & HCI_LE_PERIPHERAL_FEATURES))
+			status = 0x00;
+		else
+			status = ev->status;
+
+		conn->state = BT_CONNECTED;
+		hci_connect_cfm(conn, status);
+	}
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
 #define HCI_LE_EV_VL(_op, _func, _min_len, _max_len) \
 [_op] = { \
 	.func = _func, \
@@ -7291,6 +7356,12 @@ static const struct hci_le_ev {
 		     hci_le_big_info_adv_report_evt,
 		     sizeof(struct hci_evt_le_big_info_adv_report),
 		     HCI_MAX_EVENT_SIZE),
+	/* [0x2b = HCI_EVT_LE_ALL_REMOTE_FEATURES_COMPLETE] */
+	HCI_LE_EV_VL(HCI_EVT_LE_ALL_REMOTE_FEATURES_COMPLETE,
+		     hci_le_read_all_remote_features_evt,
+		     sizeof(struct
+			    hci_evt_le_read_all_remote_features_complete),
+		     HCI_MAX_EVENT_SIZE),
 };
 
 static void hci_le_meta_evt(struct hci_dev *hdev, void *data,
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a36d2414a3ca..a9f5b1a68356 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4011,8 +4011,19 @@ static int hci_le_read_buffer_size_sync(struct hci_dev *hdev)
 /* Read LE Local Supported Features */
 static int hci_le_read_local_features_sync(struct hci_dev *hdev)
 {
-	return __hci_cmd_sync_status(hdev, HCI_OP_LE_READ_LOCAL_FEATURES,
-				     0, NULL, HCI_CMD_TIMEOUT);
+	int err;
+
+	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_READ_LOCAL_FEATURES,
+				    0, NULL, HCI_CMD_TIMEOUT);
+	if (err)
+		return err;
+
+	if (ll_ext_feature_capable(hdev) && hdev->commands[47] & BIT(2))
+		return __hci_cmd_sync_status(hdev,
+					     HCI_OP_LE_READ_ALL_LOCAL_FEATURES,
+					     0, NULL, HCI_CMD_TIMEOUT);
+
+	return err;
 }
 
 /* Read LE Supported States */
@@ -7320,3 +7331,90 @@ int hci_past_sync(struct hci_conn *conn, struct hci_conn *le)
 
 	return err;
 }
+
+static void le_read_features_complete(struct hci_dev *hdev, void *data, int err)
+{
+	struct hci_conn *conn = data;
+
+	bt_dev_dbg(hdev, "err %d", err);
+
+	if (err == -ECANCELED)
+		return;
+
+	hci_conn_drop(conn);
+}
+
+static int hci_le_read_all_remote_features_sync(struct hci_dev *hdev,
+						void *data)
+{
+	struct hci_conn *conn = data;
+	struct hci_cp_le_read_all_remote_features cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.handle = cpu_to_le16(conn->handle);
+	cp.pages = 10; /* Attempt to read all pages */
+
+	/* Wait for HCI_EVT_LE_ALL_REMOTE_FEATURES_COMPLETE event otherwise
+	 * hci_conn_drop may run prematurely causing a disconnection.
+	 */
+	return __hci_cmd_sync_status_sk(hdev,
+					HCI_OP_LE_READ_ALL_REMOTE_FEATURES,
+					sizeof(cp), &cp,
+					HCI_EVT_LE_ALL_REMOTE_FEATURES_COMPLETE,
+					HCI_CMD_TIMEOUT, NULL);
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_READ_ALL_REMOTE_FEATURES,
+				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+}
+
+static int hci_le_read_remote_features_sync(struct hci_dev *hdev, void *data)
+{
+	struct hci_conn *conn = data;
+	struct hci_cp_le_read_remote_features cp;
+
+	if (!hci_conn_valid(hdev, conn))
+		return -ECANCELED;
+
+	/* Check if LL Extended Feature Set is supported and
+	 * HCI_OP_LE_READ_ALL_REMOTE_FEATURES is supported then use that to read
+	 * all features.
+	 */
+	if (ll_ext_feature_capable(hdev) && hdev->commands[47] & BIT(3))
+		return hci_le_read_all_remote_features_sync(hdev, data);
+
+	memset(&cp, 0, sizeof(cp));
+	cp.handle = cpu_to_le16(conn->handle);
+
+	/* Wait for HCI_EV_LE_REMOTE_FEAT_COMPLETE event otherwise
+	 * hci_conn_drop may run prematurely causing a disconnection.
+	 */
+	return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_READ_REMOTE_FEATURES,
+					sizeof(cp), &cp,
+					HCI_EV_LE_REMOTE_FEAT_COMPLETE,
+					HCI_CMD_TIMEOUT, NULL);
+}
+
+int hci_le_read_remote_features(struct hci_conn *conn)
+{
+	struct hci_dev *hdev = conn->hdev;
+	int err;
+
+	/* The remote features procedure is defined for central
+	 * role only. So only in case of an initiated connection
+	 * request the remote features.
+	 *
+	 * If the local controller supports peripheral-initiated features
+	 * exchange, then requesting the remote features in peripheral
+	 * role is possible. Otherwise just transition into the
+	 * connected state without requesting the remote features.
+	 */
+	if (conn->out || (hdev->le_features[0] & HCI_LE_PERIPHERAL_FEATURES))
+		err = hci_cmd_sync_queue_once(hdev,
+					      hci_le_read_remote_features_sync,
+					      hci_conn_hold(conn),
+					      le_read_features_complete);
+	else
+		err = -EOPNOTSUPP;
+
+	return err;
+}
-- 
2.51.1

