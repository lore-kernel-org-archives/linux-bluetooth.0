Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF881327FD
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 20:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712349643; cv=none; b=KfvN3EX4H8Y04/aS5xoOR7/VA+rCRv0Mjor9xO3eh1/TY2ZlXjDec5z6OYt8RiDsexJZpvjhr4EQUyMTOORWEo2X+XQlhKhx9d8U9j8jCFM7nFZoOUCjw73MovgyRexRhUb+pvwNjT6gHUqqGw+gIeqlL4jHfyv1UaGiYflRAtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712349643; c=relaxed/simple;
	bh=IhblGxMd9yJqKopJFSk1GfqO4DJF6Fs3dsULEDraGCE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NdRAOeyQ1RxRrotXuAayhj4TG+QnAMHydHspaeWCGn+EIzEG9/fjT963eiApHfKZzpYfNliZv0KAC/qOwV2rRvrUpje0RwW47buSqOpIrlydu8nX55cwVWw4Ao3M9PO0exE4w0+R/6lstBLzbrTfAj8/RuE9mkroCXAP2t8+2LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKUU1wlj; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKUU1wlj"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-479dd0261c8so456666137.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Apr 2024 13:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712349639; x=1712954439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=M1Blhnk+L1PUl6YPM7Nsr/j9YTx6eTBK+O3njw4NuFw=;
        b=ZKUU1wljambLv/yenE8aPuNQYBIQuAWFEbgU7eU7FJLJ8FvsRtI9C8Fh0Y0nsXzWnz
         2QiRyk5tZ8gr9Lp11fmqTDIDF/0csvTVfyL6oR26ASw03vD82kC5pGoj2Oy8WfMqXHEZ
         ojzrs3te85wwgEwUYY6vv1QIZ8xOLs3SEBnyF2+1T0kZsl1FCKPURboGNMWmGcfXPbKr
         n1Rha0f7PKzLPkA3Ly2lu6zwUNxTD6Fu8PSvmtwfSkTJBItT0a8OUL5rwntLq7iZzWUN
         DuzN9BMCij6s0+1Pwb4Qxop9e6/TnU5JRv5IeHzyxTa8V0p8tpeG5FBj/GCi39XPk3+u
         kKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712349640; x=1712954440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M1Blhnk+L1PUl6YPM7Nsr/j9YTx6eTBK+O3njw4NuFw=;
        b=YQPni6p8qQpvk2+z5oa5eIT8bXKihX5oItoGMvSbvIHc2V3m9vk1xQerYfrB8ziKXi
         DcEU5l/lz2kk8sQqMTsVeQNN47srOqr5vzHwksm2lL6iSJ0pk+rAR8bQ+Jieb+np0/Mr
         zbPcNzrky5x8Uh1UayOAUFMGqFH9or4eoqOE0gyHNqhH2P4IL7kwpyg0YArsDFNiqk96
         0WrZGCENgIGCD+q4FpyWBSzYbpK9vZUgE9rvrST+/kTshYc7kGg/N7BipwOqvy4gDB6w
         geydfsNNU1OSgzW86QZ4sa/aNKzZtKhnPFCWUQzNejMaPLLUpGwRRjyIt6Q5zb3TbBNC
         0VSw==
X-Gm-Message-State: AOJu0YxiR8rhq1i5E5dSpoZ5sTvmaPgPDCeJb9vOa0w15wc/jVHvI16e
	03leH7gq3e52Nk1N+tabYIlVxQOs5d4/Q8pv5Ay/WJ4kTZ+OdhDBqvTHAMHb
X-Google-Smtp-Source: AGHT+IEm8inMhP3VNfdswbarehZIkDLpMbLzHLYEE3UBZ81B7EauU5kjOA9JD0dVduDh/fV8CZ2l0Q==
X-Received: by 2002:a05:6102:358e:b0:479:e7bc:86d2 with SMTP id h14-20020a056102358e00b00479e7bc86d2mr542995vsu.3.1712349639562;
        Fri, 05 Apr 2024 13:40:39 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id l3-20020ab07183000000b007e3a8a03f4bsm290902uao.26.2024.04.05.13.40.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 13:40:38 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_sync: Use advertised PHYs on hci_le_ext_create_conn_sync
Date: Fri,  5 Apr 2024 16:40:33 -0400
Message-ID: <20240405204037.3451091-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The extended advertising reports do report the PHYs so this store then
in hci_conn so it can be later used in hci_le_ext_create_conn_sync to
narrow the PHYs to be scanned since the controller will also perform a
scan having a smaller set of PHYs shall reduce the time it takes to
find and connect peers.

Fixes: 288c90224eec ("Bluetooth: Enable all supported LE PHY by default")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  4 +++-
 net/bluetooth/hci_conn.c         |  6 ++++--
 net/bluetooth/hci_event.c        | 20 ++++++++++++--------
 net/bluetooth/hci_sync.c         |  9 ++++++---
 net/bluetooth/l2cap_core.c       |  2 +-
 5 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index fd6fd4029452..f0e1f1ae39c5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -744,6 +744,8 @@ struct hci_conn {
 	__u8		le_per_adv_data[HCI_MAX_PER_AD_TOT_LEN];
 	__u16		le_per_adv_data_len;
 	__u16		le_per_adv_data_offset;
+	__u8		le_adv_phy;
+	__u8		le_adv_sec_phy;
 	__u8		le_tx_phy;
 	__u8		le_rx_phy;
 	__s8		rssi;
@@ -1519,7 +1521,7 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
 				     enum conn_reasons conn_reason);
 struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 				u8 dst_type, bool dst_resolved, u8 sec_level,
-				u16 conn_timeout, u8 role);
+				u16 conn_timeout, u8 role, u8 phy, u8 sec_phy);
 void hci_connect_le_scan_cleanup(struct hci_conn *conn, u8 status);
 struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 				 u8 sec_level, u8 auth_type,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index ce94ffaf06d4..a3b226255eb9 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1266,7 +1266,7 @@ u8 hci_conn_set_handle(struct hci_conn *conn, u16 handle)
 
 struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 				u8 dst_type, bool dst_resolved, u8 sec_level,
-				u16 conn_timeout, u8 role)
+				u16 conn_timeout, u8 role, u8 phy, u8 sec_phy)
 {
 	struct hci_conn *conn;
 	struct smp_irk *irk;
@@ -1329,6 +1329,8 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	conn->dst_type = dst_type;
 	conn->sec_level = BT_SECURITY_LOW;
 	conn->conn_timeout = conn_timeout;
+	conn->le_adv_phy = phy;
+	conn->le_adv_sec_phy = sec_phy;
 
 	err = hci_connect_le_sync(hdev, conn);
 	if (err) {
@@ -2276,7 +2278,7 @@ struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
 		le = hci_connect_le(hdev, dst, dst_type, false,
 				    BT_SECURITY_LOW,
 				    HCI_LE_CONN_TIMEOUT,
-				    HCI_ROLE_SLAVE);
+				    HCI_ROLE_SLAVE, 0, 0);
 	else
 		le = hci_connect_le_scan(hdev, dst, dst_type,
 					 BT_SECURITY_LOW,
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 868ffccff773..539bbbe26176 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6046,7 +6046,7 @@ static void hci_le_conn_update_complete_evt(struct hci_dev *hdev, void *data,
 static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
 					      bdaddr_t *addr,
 					      u8 addr_type, bool addr_resolved,
-					      u8 adv_type)
+					      u8 adv_type, u8 phy, u8 sec_phy)
 {
 	struct hci_conn *conn;
 	struct hci_conn_params *params;
@@ -6101,7 +6101,7 @@ static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
 
 	conn = hci_connect_le(hdev, addr, addr_type, addr_resolved,
 			      BT_SECURITY_LOW, hdev->def_le_autoconnect_timeout,
-			      HCI_ROLE_MASTER);
+			      HCI_ROLE_MASTER, phy, sec_phy);
 	if (!IS_ERR(conn)) {
 		/* If HCI_AUTO_CONN_EXPLICIT is set, conn is already owned
 		 * by higher layer that tried to connect, if no then
@@ -6136,8 +6136,9 @@ static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
 
 static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 			       u8 bdaddr_type, bdaddr_t *direct_addr,
-			       u8 direct_addr_type, s8 rssi, u8 *data, u8 len,
-			       bool ext_adv, bool ctl_time, u64 instant)
+			       u8 direct_addr_type, u8 phy, u8 sec_phy, s8 rssi,
+			       u8 *data, u8 len, bool ext_adv, bool ctl_time,
+			       u64 instant)
 {
 	struct discovery_state *d = &hdev->discovery;
 	struct smp_irk *irk;
@@ -6225,7 +6226,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	 * for advertising reports) and is already verified to be RPA above.
 	 */
 	conn = check_pending_le_conn(hdev, bdaddr, bdaddr_type, bdaddr_resolved,
-				     type);
+				     type, phy, sec_phy);
 	if (!ext_adv && conn && type == LE_ADV_IND &&
 	    len <= max_adv_len(hdev)) {
 		/* Store report for later inclusion by
@@ -6371,7 +6372,8 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, void *data,
 		if (info->length <= max_adv_len(hdev)) {
 			rssi = info->data[info->length];
 			process_adv_report(hdev, info->type, &info->bdaddr,
-					   info->bdaddr_type, NULL, 0, rssi,
+					   info->bdaddr_type, NULL, 0,
+					   HCI_ADV_PHY_1M, 0, rssi,
 					   info->data, info->length, false,
 					   false, instant);
 		} else {
@@ -6456,6 +6458,8 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, void *data,
 		if (legacy_evt_type != LE_ADV_INVALID) {
 			process_adv_report(hdev, legacy_evt_type, &info->bdaddr,
 					   info->bdaddr_type, NULL, 0,
+					   info->primary_phy,
+					   info->secondary_phy,
 					   info->rssi, info->data, info->length,
 					   !(evt_type & LE_EXT_ADV_LEGACY_PDU),
 					   false, instant);
@@ -6761,8 +6765,8 @@ static void hci_le_direct_adv_report_evt(struct hci_dev *hdev, void *data,
 
 		process_adv_report(hdev, info->type, &info->bdaddr,
 				   info->bdaddr_type, &info->direct_addr,
-				   info->direct_addr_type, info->rssi, NULL, 0,
-				   false, false, instant);
+				   info->direct_addr_type, HCI_ADV_PHY_1M, 0,
+				   info->rssi, NULL, 0, false, false, instant);
 	}
 
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index c5d8799046cc..4c707eb64e6f 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6346,7 +6346,8 @@ static int hci_le_ext_create_conn_sync(struct hci_dev *hdev,
 
 	plen = sizeof(*cp);
 
-	if (scan_1m(hdev)) {
+	if (scan_1m(hdev) && (conn->le_adv_phy == HCI_ADV_PHY_1M ||
+			      conn->le_adv_sec_phy == HCI_ADV_PHY_1M)) {
 		cp->phys |= LE_SCAN_PHY_1M;
 		set_ext_conn_params(conn, p);
 
@@ -6354,7 +6355,8 @@ static int hci_le_ext_create_conn_sync(struct hci_dev *hdev,
 		plen += sizeof(*p);
 	}
 
-	if (scan_2m(hdev)) {
+	if (scan_2m(hdev) && (conn->le_adv_phy == HCI_ADV_PHY_2M ||
+			      conn->le_adv_sec_phy == HCI_ADV_PHY_2M)) {
 		cp->phys |= LE_SCAN_PHY_2M;
 		set_ext_conn_params(conn, p);
 
@@ -6362,7 +6364,8 @@ static int hci_le_ext_create_conn_sync(struct hci_dev *hdev,
 		plen += sizeof(*p);
 	}
 
-	if (scan_coded(hdev)) {
+	if (scan_coded(hdev) && (conn->le_adv_phy == HCI_ADV_PHY_CODED ||
+				 conn->le_adv_sec_phy == HCI_ADV_PHY_CODED)) {
 		cp->phys |= LE_SCAN_PHY_CODED;
 		set_ext_conn_params(conn, p);
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index cf3b8e9b7b3b..3e5d2d8a2a66 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7028,7 +7028,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
 			hcon = hci_connect_le(hdev, dst, dst_type, false,
 					      chan->sec_level, timeout,
-					      HCI_ROLE_SLAVE);
+					      HCI_ROLE_SLAVE, 0, 0);
 		else
 			hcon = hci_connect_le_scan(hdev, dst, dst_type,
 						   chan->sec_level, timeout,
-- 
2.44.0

