Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B622459FF
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 18:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749578647; cv=none; b=U/yDrZYLTCyH0aNSmot6OIOniew/cOdnV0pTK/+V0yDbfhveguqDJ1s+RjlE7p9pE2IUQEpx+B78Bq3Gz0pvHDwlg8BzGuuX/yaurz4VJE3FaBWnRo4xypPiqzFSjMaFUbkc3yaJNKWNm52P9l4vXcQGyKt6XWdl98DZbCD4tVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749578647; c=relaxed/simple;
	bh=SzNn8zG+bxhuyV+RzxqWWCfrkQ7KgggvOg/hOlgo29I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCcOyMA+LVNZqnXVbAWlNoIi+JjJMkgeLg99ex2FYu+qsqGzDjn+IsOgrF1M8CdIQ0QL3PLN+oxXtAfQIVtwwEX2efw8bw6La52wCfmbB7AEMHjXnGb1xxCCDb5/n3RxJwJW1VlYFbzqqLU5y7/Ayt0xSsaqg0Qqn2d7FH0Fxrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lePJURAV; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lePJURAV"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a56cc0def0so100823401cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 11:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749578643; x=1750183443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qeYpqFkfIWAwTWvqquxhqRpcwbFb58aZJXhj7ZwoGgc=;
        b=lePJURAVoZ/aXhUzAyAtU+3hYvSCwnlZ77Q56MoFpHSMm5KifBOrmBM2ZRCfI+wFCr
         LboE+qxIKGj7M7IlWQZGZdGLRySrFYl9RChs8dQ7zBMe6bj7Gzf5Z8jsxVYZeplerBJJ
         nai+3n1JpUMta0XJZQ5gM8SPxNvBjcKTgBbcmpumFJ9ogK81cQ7SXm9O7GamaMVgZ6dH
         I+Pr7PB0MiYfh6+WmqfOCjwI7ZgHSD81Yru+Zr76evKNRu/GvkM1Va6p2sTY4yhZgESp
         7cYakOO4kiQs5PgKDxZwHjv5Q+W8FZoVd7Uu4okYaXwy/dftMOB49ot88MHiznOi40XA
         9K9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749578643; x=1750183443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qeYpqFkfIWAwTWvqquxhqRpcwbFb58aZJXhj7ZwoGgc=;
        b=IxDYDmSTeLY+1wOb2UEwpe8+i5fW6NHtoNtcQwy0ShuiBQ73EeSDwIKbsuC0l7lc7U
         J0zCBJoJ5D+wcPjbXZfNFRck/KJGKl95A8akROBCa6v28qEYSfX3uj6JVfptE0s21bRt
         TkBqou2y/8o+Dg2DneTD37nITBuQDA6C17RAbOI7AvxPVJV/tP2aWeWvjHoLqlNHrnWT
         AssreKbTDG4+7BDuOxQqfOl2q3qtOH4+77iyF/yWw0QTE+Wl37QbSWjkfb6x39/4qghH
         LunPQg80lye9xx10NKyY2RYxF3mTxboRF939ZAHZ6wIz3Xx2anox+hutIumAnQ+yYr6/
         rhLA==
X-Gm-Message-State: AOJu0Ywvl2liUBCxbHh0LbXGpx43Jz7xjR2OFpYLvPo445iGF8U4hczJ
	MN3I7L5CwJWfIeoDgjT93FeOEHmRCcGM1sOSZh6WavfXeEBundsq49/XqzRnEw==
X-Gm-Gg: ASbGncujO9nLBY/5QbQJQNl9NUp8HIaY4dxch8bV2DZk7nFOExzEo0sfowsQFNQ2bCp
	s9FmEpTGlwMxeRZvk+thaU05DCy6RwpAhGKSxYh7pmF4fh4tlA+MkXi4zdTdCnsj3xQypa3UGMb
	6WIsJxY+fshVZY3tAcPVqkY2qWwFv0JaFD+Lde28c1uRxc85iOCP0sgU6kLz8DtfiaJoxgpEJOo
	LLoPYiE+1lbVljNTF2m9y6Pz/2FSlA4BqFzo8JIMSNOmhuAkHoKd6D1N3pkaIfYX2jzDr6G4aw9
	rjrirzjma2UngdAO5DSgGD9MaxopjvjzjlvDNTNeVNKwGLJAE0JtB51OmHYHepT2RISqGK7Kk9I
	tZubRa+hV4OQc4MMXjoWN8R5tLcHcXws=
X-Google-Smtp-Source: AGHT+IFAOqViCRDYAqOmqFoM4RyTbTolXJKKzeOEcCJuu715L2cHHv6hkudNVntziXhLYTAkUfhQtg==
X-Received: by 2002:a05:620a:294a:b0:7c5:5a51:d2d1 with SMTP id af79cd13be357-7d3a89d81fdmr46986885a.55.1749578643292;
        Tue, 10 Jun 2025 11:04:03 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87eeaf9612asm1593777241.30.2025.06.10.11.04.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 11:04:02 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 2/2] Bluetooth: ISO: Fix not using bc_sid as advertisement SID
Date: Tue, 10 Jun 2025 14:03:59 -0400
Message-ID: <20250610180359.1133739-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610180359.1133739-1-luiz.dentz@gmail.com>
References: <20250610180359.1133739-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Currently bc_sid is being ignore when acting as Broadcast Source role,
so this fix it by passing the bc_sid and then use it when programming
the PA:

< HCI Command: LE Set Exte.. (0x08|0x0036) plen 25
        Handle: 0x01
        Properties: 0x0000
        Min advertising interval: 140.000 msec (0x00e0)
        Max advertising interval: 140.000 msec (0x00e0)
        Channel map: 37, 38, 39 (0x07)
        Own address type: Random (0x01)
        Peer address type: Public (0x00)
        Peer address: 00:00:00:00:00:00 (OUI 00-00-00)
        Filter policy: Allow Scan Request from Any, Allow Connect Request from Any (0x00)
        TX power: Host has no preference (0x7f)
        Primary PHY: LE 1M (0x01)
        Secondary max skip: 0x00
        Secondary PHY: LE 2M (0x02)
        SID: 0x01
        Scan request notifications: Disabled (0x00)

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  9 ++++++---
 include/net/bluetooth/hci_sync.h |  4 ++--
 net/bluetooth/hci_conn.c         | 31 ++++++++++++++++++++++++-------
 net/bluetooth/hci_core.c         | 16 +++++++++++++++-
 net/bluetooth/hci_sync.c         | 20 +++++++++++++++++---
 net/bluetooth/iso.c              | 12 ++++++++----
 6 files changed, 72 insertions(+), 20 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f7b1a9eb9543..a760f05fa3fb 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -242,6 +242,7 @@ struct adv_info {
 	__u8	mesh;
 	__u8	instance;
 	__u8	handle;
+	__u8	sid;
 	__u32	flags;
 	__u16	timeout;
 	__u16	remaining_time;
@@ -1551,13 +1552,14 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 				 u16 timeout);
 struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
 			      __u8 dst_type, struct bt_iso_qos *qos);
-struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst,
+struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __u8 sid,
 			      struct bt_iso_qos *qos,
 			      __u8 base_len, __u8 *base);
 struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
 				 __u8 dst_type, struct bt_iso_qos *qos);
 struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
-				 __u8 dst_type, struct bt_iso_qos *qos,
+				 __u8 dst_type, __u8 sid,
+				 struct bt_iso_qos *qos,
 				 __u8 data_len, __u8 *data);
 struct hci_conn *hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst,
 		       __u8 dst_type, __u8 sid, struct bt_iso_qos *qos);
@@ -1832,6 +1834,7 @@ int hci_remove_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
 
 void hci_adv_instances_clear(struct hci_dev *hdev);
 struct adv_info *hci_find_adv_instance(struct hci_dev *hdev, u8 instance);
+struct adv_info *hci_find_adv_sid(struct hci_dev *hdev, u8 sid);
 struct adv_info *hci_get_next_instance(struct hci_dev *hdev, u8 instance);
 struct adv_info *hci_add_adv_instance(struct hci_dev *hdev, u8 instance,
 				      u32 flags, u16 adv_data_len, u8 *adv_data,
@@ -1839,7 +1842,7 @@ struct adv_info *hci_add_adv_instance(struct hci_dev *hdev, u8 instance,
 				      u16 timeout, u16 duration, s8 tx_power,
 				      u32 min_interval, u32 max_interval,
 				      u8 mesh_handle);
-struct adv_info *hci_add_per_instance(struct hci_dev *hdev, u8 instance,
+struct adv_info *hci_add_per_instance(struct hci_dev *hdev, u8 instance, u8 sid,
 				      u32 flags, u8 data_len, u8 *data,
 				      u32 min_interval, u32 max_interval);
 int hci_set_adv_instance_data(struct hci_dev *hdev, u8 instance,
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 72558c826aa1..5224f57f6af2 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -115,8 +115,8 @@ int hci_enable_ext_advertising_sync(struct hci_dev *hdev, u8 instance);
 int hci_enable_advertising_sync(struct hci_dev *hdev);
 int hci_enable_advertising(struct hci_dev *hdev);
 
-int hci_start_per_adv_sync(struct hci_dev *hdev, u8 instance, u8 data_len,
-			   u8 *data, u32 flags, u16 min_interval,
+int hci_start_per_adv_sync(struct hci_dev *hdev, u8 instance, u8 sid,
+			   u8 data_len, u8 *data, u32 flags, u16 min_interval,
 			   u16 max_interval, u16 sync_interval);
 
 int hci_disable_per_advertising_sync(struct hci_dev *hdev, u8 instance);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 99efeed6a766..4f379184df5b 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1501,8 +1501,8 @@ static int qos_set_bis(struct hci_dev *hdev, struct bt_iso_qos *qos)
 
 /* This function requires the caller holds hdev->lock */
 static struct hci_conn *hci_add_bis(struct hci_dev *hdev, bdaddr_t *dst,
-				    struct bt_iso_qos *qos, __u8 base_len,
-				    __u8 *base)
+				    __u8 sid, struct bt_iso_qos *qos,
+				    __u8 base_len, __u8 *base)
 {
 	struct hci_conn *conn;
 	int err;
@@ -1543,6 +1543,7 @@ static struct hci_conn *hci_add_bis(struct hci_dev *hdev, bdaddr_t *dst,
 		return conn;
 
 	conn->state = BT_CONNECT;
+	conn->sid = sid;
 
 	hci_conn_hold(conn);
 	return conn;
@@ -2062,7 +2063,8 @@ static int create_big_sync(struct hci_dev *hdev, void *data)
 	if (qos->bcast.bis)
 		sync_interval = interval * 4;
 
-	err = hci_start_per_adv_sync(hdev, qos->bcast.bis, conn->le_per_adv_data_len,
+	err = hci_start_per_adv_sync(hdev, qos->bcast.bis, conn->sid,
+				     conn->le_per_adv_data_len,
 				     conn->le_per_adv_data, flags, interval,
 				     interval, sync_interval);
 	if (err)
@@ -2134,7 +2136,7 @@ static void create_big_complete(struct hci_dev *hdev, void *data, int err)
 	}
 }
 
-struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst,
+struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __u8 sid,
 			      struct bt_iso_qos *qos,
 			      __u8 base_len, __u8 *base)
 {
@@ -2156,7 +2158,7 @@ struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst,
 						   base, base_len);
 
 	/* We need hci_conn object using the BDADDR_ANY as dst */
-	conn = hci_add_bis(hdev, dst, qos, base_len, eir);
+	conn = hci_add_bis(hdev, dst, sid, qos, base_len, eir);
 	if (IS_ERR(conn))
 		return conn;
 
@@ -2207,20 +2209,35 @@ static void bis_mark_per_adv(struct hci_conn *conn, void *data)
 }
 
 struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
-				 __u8 dst_type, struct bt_iso_qos *qos,
+				 __u8 dst_type, __u8 sid,
+				 struct bt_iso_qos *qos,
 				 __u8 base_len, __u8 *base)
 {
 	struct hci_conn *conn;
 	int err;
 	struct iso_list_data data;
 
-	conn = hci_bind_bis(hdev, dst, qos, base_len, base);
+	conn = hci_bind_bis(hdev, dst, sid, qos, base_len, base);
 	if (IS_ERR(conn))
 		return conn;
 
 	if (conn->state == BT_CONNECTED)
 		return conn;
 
+	/* Check if SID needs to be allocated then search for the first
+	 * available.
+	 */
+	if (conn->sid == HCI_SID_INVALID) {
+		u8 sid;
+
+		for (sid = 0; sid <= 0x0f; sid++) {
+			if (!hci_find_adv_sid(hdev, sid)) {
+				conn->sid = sid;
+				break;
+			}
+		}
+	}
+
 	data.big = qos->bcast.big;
 	data.bis = qos->bcast.bis;
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 487c045a7ba8..07a8b4281a39 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1584,6 +1584,19 @@ struct adv_info *hci_find_adv_instance(struct hci_dev *hdev, u8 instance)
 	return NULL;
 }
 
+/* This function requires the caller holds hdev->lock */
+struct adv_info *hci_find_adv_sid(struct hci_dev *hdev, u8 sid)
+{
+	struct adv_info *adv;
+
+	list_for_each_entry(adv, &hdev->adv_instances, list) {
+		if (adv->sid == sid)
+			return adv;
+	}
+
+	return NULL;
+}
+
 /* This function requires the caller holds hdev->lock */
 struct adv_info *hci_get_next_instance(struct hci_dev *hdev, u8 instance)
 {
@@ -1736,7 +1749,7 @@ struct adv_info *hci_add_adv_instance(struct hci_dev *hdev, u8 instance,
 }
 
 /* This function requires the caller holds hdev->lock */
-struct adv_info *hci_add_per_instance(struct hci_dev *hdev, u8 instance,
+struct adv_info *hci_add_per_instance(struct hci_dev *hdev, u8 instance, u8 sid,
 				      u32 flags, u8 data_len, u8 *data,
 				      u32 min_interval, u32 max_interval)
 {
@@ -1748,6 +1761,7 @@ struct adv_info *hci_add_per_instance(struct hci_dev *hdev, u8 instance,
 	if (IS_ERR(adv))
 		return adv;
 
+	adv->sid = sid;
 	adv->periodic = true;
 	adv->per_adv_data_len = data_len;
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 83de3847c8ea..6687f2a4d1eb 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1261,10 +1261,12 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 		hci_cpu_to_le24(adv->min_interval, cp.min_interval);
 		hci_cpu_to_le24(adv->max_interval, cp.max_interval);
 		cp.tx_power = adv->tx_power;
+		cp.sid = adv->sid;
 	} else {
 		hci_cpu_to_le24(hdev->le_adv_min_interval, cp.min_interval);
 		hci_cpu_to_le24(hdev->le_adv_max_interval, cp.max_interval);
 		cp.tx_power = HCI_ADV_TX_POWER_NO_PREFERENCE;
+		cp.sid = 0x00;
 	}
 
 	secondary_adv = (flags & MGMT_ADV_FLAG_SEC_MASK);
@@ -1594,8 +1596,8 @@ static int hci_adv_bcast_annoucement(struct hci_dev *hdev, struct adv_info *adv)
 	return hci_update_adv_data_sync(hdev, adv->instance);
 }
 
-int hci_start_per_adv_sync(struct hci_dev *hdev, u8 instance, u8 data_len,
-			   u8 *data, u32 flags, u16 min_interval,
+int hci_start_per_adv_sync(struct hci_dev *hdev, u8 instance, u8 sid,
+			   u8 data_len, u8 *data, u32 flags, u16 min_interval,
 			   u16 max_interval, u16 sync_interval)
 {
 	struct adv_info *adv = NULL;
@@ -1607,6 +1609,18 @@ int hci_start_per_adv_sync(struct hci_dev *hdev, u8 instance, u8 data_len,
 	if (instance) {
 		adv = hci_find_adv_instance(hdev, instance);
 		if (adv) {
+			if (sid != HCI_SID_INVALID && adv->sid != sid) {
+				/* If the SID don't match attempt to find by
+				 * SID.
+				 */
+				adv = hci_find_adv_sid(hdev, sid);
+				if (!adv) {
+					bt_dev_err(hdev,
+						   "Unable to find adv_info");
+					return -EINVAL;
+				}
+			}
+
 			/* Turn it into periodic advertising */
 			adv->periodic = true;
 			adv->per_adv_data_len = data_len;
@@ -1615,7 +1629,7 @@ int hci_start_per_adv_sync(struct hci_dev *hdev, u8 instance, u8 data_len,
 			adv->flags = flags;
 		} else if (!adv) {
 			/* Create an instance if that could not be found */
-			adv = hci_add_per_instance(hdev, instance, flags,
+			adv = hci_add_per_instance(hdev, instance, sid, flags,
 						   data_len, data,
 						   sync_interval,
 						   sync_interval);
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index affa2077e3a2..3c2c98eecc62 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -336,7 +336,7 @@ static int iso_connect_bis(struct sock *sk)
 	struct hci_dev  *hdev;
 	int err;
 
-	BT_DBG("%pMR", &iso_pi(sk)->src);
+	BT_DBG("%pMR (SID 0x%2.2x)", &iso_pi(sk)->src, iso_pi(sk)->bc_sid);
 
 	hdev = hci_get_route(&iso_pi(sk)->dst, &iso_pi(sk)->src,
 			     iso_pi(sk)->src_type);
@@ -365,7 +365,7 @@ static int iso_connect_bis(struct sock *sk)
 
 	/* Just bind if DEFER_SETUP has been set */
 	if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
-		hcon = hci_bind_bis(hdev, &iso_pi(sk)->dst,
+		hcon = hci_bind_bis(hdev, &iso_pi(sk)->dst, iso_pi(sk)->bc_sid,
 				    &iso_pi(sk)->qos, iso_pi(sk)->base_len,
 				    iso_pi(sk)->base);
 		if (IS_ERR(hcon)) {
@@ -375,12 +375,16 @@ static int iso_connect_bis(struct sock *sk)
 	} else {
 		hcon = hci_connect_bis(hdev, &iso_pi(sk)->dst,
 				       le_addr_type(iso_pi(sk)->dst_type),
-				       &iso_pi(sk)->qos, iso_pi(sk)->base_len,
-				       iso_pi(sk)->base);
+				       iso_pi(sk)->bc_sid, &iso_pi(sk)->qos,
+				       iso_pi(sk)->base_len, iso_pi(sk)->base);
 		if (IS_ERR(hcon)) {
 			err = PTR_ERR(hcon);
 			goto unlock;
 		}
+
+		/* Update SID if it was not set */
+		if (iso_pi(sk)->bc_sid == HCI_SID_INVALID)
+			iso_pi(sk)->bc_sid = hcon->sid;
 	}
 
 	conn = iso_conn_add(hcon);
-- 
2.49.0

