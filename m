Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57412101DB
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 16:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712246510; cv=none; b=ukyxpsXqcXZiN1ztCUwkChGTMDoGNqlEcVzDAgCbl5Dm4hSSKuVeXJg83Sb7YO3ggymFxGcFtU2+KAaG4KmympL7X2TBX1vMsdduS99bPqdVUBzSwKw2RAjkDUzcFhImJpKXKJC7yQlZFzKesogNk4q8eLqfH9m51jrOs07nQKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712246510; c=relaxed/simple;
	bh=IhblGxMd9yJqKopJFSk1GfqO4DJF6Fs3dsULEDraGCE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZxkTuJCq+5YH6F1IywyvFfco8bwPXi03brXAgMvoOYVOsUn9vq0wol9l/dngIUjCtiVtTZvh8HZxyXpL41Z3OBLiij3O4nZepOGc0pNGiJ7a4ZO/rrZyZwjqBaUn71ZcVRuxDqDrbsBkdiWGRb0Z15xaheGMsQCdkPnwepBZtyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SI35XcLJ; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SI35XcLJ"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4785c788ba6so425102137.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Apr 2024 09:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712246506; x=1712851306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=M1Blhnk+L1PUl6YPM7Nsr/j9YTx6eTBK+O3njw4NuFw=;
        b=SI35XcLJSL2mU9wEu2etIzwjwSw6UlpdUpUMceX3dhHVwVFWx8yuvceoAntX25ScbN
         0j+mtTIu8/SQVhusFODClXF2+AhfBW7hkRCPzzpNXRyZjHM2J4LjQuRa4ezmcn6ySNbZ
         MiGKG2KHn8MPyYLXVUu/VbSTEkz7LnETL2OMo6o3PMJfsqxctu+m4AqVYaakS4oHdRQm
         +R1O236Bp+57sWLZCPHQicQ+mDvOYtJym9aLS4Lt3FBfI0jj/Ngc4XMxk9FjXxkoX7Zs
         Xj6CZ2fleXviq0ihfwifyhI352EnzjcixsRIPHS7EIGh4V2tvghVWZ9SNEism8t/9ZdY
         crAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712246506; x=1712851306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M1Blhnk+L1PUl6YPM7Nsr/j9YTx6eTBK+O3njw4NuFw=;
        b=fC7pYVqx2AY6gZa6HibhoOwNJd6HHv1MvKqYoYYOT8gmxJdcuqvPYgO68nhF0hyXNU
         tQVWUm40U8ITfutQTUA+jdMNFl2TQpS5DiVJY/DNr/EGzCuXIjUMNU3fQb1gPrVeiYVH
         i46ApY+0U/XZfqD7SWrAtKzSvBnJMaFJx0hmnaZaD7lcgvX6at/9pdND++K/LDhEAs7V
         pVI/q5OQDnxjHFYMs3qWIq1mgjQ4LtazVwWYzIzX9drWk8/XacHeyyyLImddaMTEYH1m
         Dwh9D8rQEAdiZ0mLEPWuX4Ou8MXoURwiMCo4eArK2Z3DJK1HbpB9sWQO/4W7kVQbUPB2
         Btug==
X-Gm-Message-State: AOJu0Yy5ccj72aEvRuEX1r1YAJSla87QI++WvfZoE/Zu4qhIgpwf+T0I
	R6SoKBg8KqxMLA6vBxeAeDd2yR7J9UZ55kHbmlEqxfdbMr1+KBPV61sH4NX8
X-Google-Smtp-Source: AGHT+IFfE7WgkTJTG5heIdP6lcUTO4URMMeoJmK4mYlnn7SHpNs2NglC4g6kFRld9Iq7PKbyjh1ccg==
X-Received: by 2002:a05:6102:e0e:b0:478:3f57:966d with SMTP id o14-20020a0561020e0e00b004783f57966dmr289507vst.26.1712246506020;
        Thu, 04 Apr 2024 09:01:46 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id y21-20020a67ebd5000000b0047691506a4fsm1584328vso.13.2024.04.04.09.01.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 09:01:45 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_sync: Use advertised PHYs on hci_le_ext_create_conn_sync
Date: Thu,  4 Apr 2024 12:01:44 -0400
Message-ID: <20240404160144.3193698-1-luiz.dentz@gmail.com>
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

