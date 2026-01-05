Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7103265CA2
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 21:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767647433; cv=none; b=HGieh+hkAFRR9PyKewg/gtDck0Bvr+2Df+fL87eOnR8OpzmpATQTvGNf041Mf+UUkgBxvSSHoivKxg9uOptUEaHHyxQZVu2nSKWhK5IVj8bYZzCFc9MYWY6eOVz/xKVDKFvesBQxSYNi9snx4oNiwO84eB/w1WwwhnhVAxvDrhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767647433; c=relaxed/simple;
	bh=/EpN5WhhN1zn11n7KlLoBf3y4Yxks9HQpAXkPz+vfNo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JvsEWL1ZwwYmtZRyOwY10PNsvVwRaR7Z5ZV/98d5cFE9r2nWLLSryo1g3RaH6L41ovkHnM/824UBYXJ+MleyGj08vOiRcfVt9T6BgwvteVQwI6UBlx/rreN4VLrBWPYNpn2HEq9cb5plC/8VkEIOJOlOpOnJcv5xBPkbtRnsOdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JueLRgA5; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JueLRgA5"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-56021b53e9eso126769e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Jan 2026 13:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767647430; x=1768252230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OuPgbd/HaiDOoCP4LAbXpPDwxfa0Gj8Vh+Ied/1wYqg=;
        b=JueLRgA53leecK957KBnshpJgXLRjJSpqXKcxuFAhz9NCpRICZEkS8tvinnQLPtInm
         hGg8k4bq0OJv7Ep44v0OIePbMvF6uQPObuJvydyyoAsyE93y+8J5K7X9n+0EkSkgVmOw
         PIc83SjbiXvrmAWBpW89fk5FR0ZJ0Zft7bFOya77UMJohaw4+yEzgWExeQg9O4LH8m9f
         TUqfnotJ0td/97LRineMzbWZROA/aw7GbbgbYaDBJhoB+D/oGYKHG0/7dM1d7HFhbFGu
         k1XOQljdkOmsK2WXAI+pi9N4lxN7xm89cZidR0L3rdtq2QOTH/ewI2loUFquEYO/kLGZ
         Tixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767647430; x=1768252230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OuPgbd/HaiDOoCP4LAbXpPDwxfa0Gj8Vh+Ied/1wYqg=;
        b=I4+5WWoIjRrJous67TtcgZfmkeK5jFQ+kxunMG7B0753rmWP7gWXJraHSeddhKtVUP
         QjxY+eJndTVcQUjenO6NK2Atll7aqlNIDHp4+cBsINPECprlQzTmFDBmu2l9M5NvNYbz
         63GI6Q5wqie0M2AzPIlEvzOaLtXTAn1a5OGbdV67ffTpoFCb+m1anVSSDV38v2sIojHe
         1NdWqhNjf8enER86E1CFbxISjgytkXQxtIvw/a5FslVsi+U1F7zuj1cBFEmI2RbNHFc7
         529+O4lXu9qkx4czBPZLRXXQTAnZVGhyAti91dVjZVBgLSUinquaev10R5URmRb9D03V
         kKtw==
X-Gm-Message-State: AOJu0YwQs2jfTgTwSp/y2MVciq2WPJ+yf1by2JNuHs/aG43iiUTxOCOo
	gJlT1yHJt5SFRNRKIIXL2oWsmhhA0kPsZUGLxTSHXS7kSbXX/lk76Z1qg3jWzVvc
X-Gm-Gg: AY/fxX6CiXMTeJKB/AETC+URHm6hq+ShA1SEWJytrMWK4RkPrjRaGQZkJu5AnPcgcR9
	3UaJwoelayPE0taBqbfGWSxUDVjZVyXK5xvRRC3FFTiLANnBMaoOscaPuphrI3Wwm6G7nueb0qk
	5fqjfjsD4X6E+gKIGcECEkgxEdawHTiH1XT0Ga1D9OQmeWpIB1Q7eVYgYrG6nW/F8E7s4ILk4FG
	zcsdOqn4blVnULEw28KShH4PiKvjXOkLGtk6L9GpQzODCb6B7NviAH8Ih1jNJo/0WxMMfHj5kPs
	oLpoovlF0OXRxz6X+6FpnxHqxcPUkrovYC5FfnuJNo71J4YwTN72l7dLBUtxp+libCOqzdlqL1N
	iCfh5GSbS44zKoLnOoucSFHulGOznPbISI+83XizptmFvcE/DhElrrTxYADUCHL6psXeu2ffx5h
	TNnzH5QvYp8yEfLlrpOS7mFPQF0ADJXTJNzcYvXXbofGvQ2zaQe/fH4wmNm8c+sVHntJL6kwwoD
	JLvRQ==
X-Google-Smtp-Source: AGHT+IFvRz23WeLuWp8leaqcY2C+JFvGi/SUMqu37MqE3M08lm8wgT66rY3v7ET5u92f0gevmIx3eA==
X-Received: by 2002:a05:6122:54c:b0:54a:9e02:f9c2 with SMTP id 71dfb90a1353d-5633949353emr247129e0c.6.1767647430211;
        Mon, 05 Jan 2026 13:10:30 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5633a414155sm113871e0c.15.2026.01.05.13.10.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 13:10:29 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Fix using PHYs bitfields as PHY value
Date: Mon,  5 Jan 2026 16:10:19 -0500
Message-ID: <20260105211019.3098952-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This renames the PHY fields in bt_iso_io_qos to PHYs (plural) since it
represents a bitfield where multiple PHYs can be set and make the same
change also to HCI_OP_LE_SET_CIG_PARAMS since both c_phy and p_phy
fields are bitfields.

This also fixes the assumption that hci_evt_le_cis_established PHYs
fields are compatible with bt_iso_io_qos, they are not, the fields in
hci_evt_le_cis_established represent just a single PHY value so they
need to be converted to bitfield when set in bt_iso_io_qos.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/bluetooth.h |  8 +++----
 include/net/bluetooth/hci.h       |  6 +++---
 net/bluetooth/hci_conn.c          | 35 ++++++++++++++++---------------
 net/bluetooth/hci_event.c         | 23 ++++++++++++++++----
 net/bluetooth/hci_sync.c          |  6 +++---
 net/bluetooth/iso.c               | 10 ++++-----
 6 files changed, 52 insertions(+), 36 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 89a60919050b..69eed69f7f26 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -182,7 +182,7 @@ struct bt_iso_io_qos {
 	__u32 interval;
 	__u16 latency;
 	__u16 sdu;
-	__u8  phy;
+	__u8  phys;
 	__u8  rtn;
 };
 
@@ -221,9 +221,9 @@ struct bt_iso_qos {
 	};
 };
 
-#define BT_ISO_PHY_1M		0x01
-#define BT_ISO_PHY_2M		0x02
-#define BT_ISO_PHY_CODED	0x04
+#define BT_ISO_PHY_1M		BIT(0)
+#define BT_ISO_PHY_2M		BIT(1)
+#define BT_ISO_PHY_CODED	BIT(2)
 #define BT_ISO_PHY_ANY		(BT_ISO_PHY_1M | BT_ISO_PHY_2M | \
 				 BT_ISO_PHY_CODED)
 
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index db76c2d1eeaa..89ad9470fa71 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1891,7 +1891,7 @@ struct hci_cp_le_set_phy {
 	__u8    all_phys;
 	__u8    tx_phys;
 	__u8    rx_phys;
-	__le16   phy_opts;
+	__le16  phy_opts;
 } __packed;
 
 #define HCI_OP_LE_SET_EXT_SCAN_PARAMS   0x2041
@@ -2147,8 +2147,8 @@ struct hci_cis_params {
 	__u8    cis_id;
 	__le16  c_sdu;
 	__le16  p_sdu;
-	__u8    c_phy;
-	__u8    p_phy;
+	__u8    c_phys;
+	__u8    p_phys;
 	__u8    c_rtn;
 	__u8    p_rtn;
 } __packed;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 1a4b6badf2b3..0795818963a5 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1825,7 +1825,7 @@ static int hci_le_create_big(struct hci_conn *conn, struct bt_iso_qos *qos)
 	cp.bis.sdu = cpu_to_le16(qos->bcast.out.sdu);
 	cp.bis.latency =  cpu_to_le16(qos->bcast.out.latency);
 	cp.bis.rtn  = qos->bcast.out.rtn;
-	cp.bis.phy  = qos->bcast.out.phy;
+	cp.bis.phy  = qos->bcast.out.phys;
 	cp.bis.packing = qos->bcast.packing;
 	cp.bis.framing = qos->bcast.framing;
 	cp.bis.encryption = qos->bcast.encryption;
@@ -1875,10 +1875,10 @@ static int set_cig_params_sync(struct hci_dev *hdev, void *data)
 		cis->cis_id = cis_id;
 		cis->c_sdu  = cpu_to_le16(conn->iso_qos.ucast.out.sdu);
 		cis->p_sdu  = cpu_to_le16(conn->iso_qos.ucast.in.sdu);
-		cis->c_phy  = qos->ucast.out.phy ? qos->ucast.out.phy :
-			      qos->ucast.in.phy;
-		cis->p_phy  = qos->ucast.in.phy ? qos->ucast.in.phy :
-			      qos->ucast.out.phy;
+		cis->c_phys = qos->ucast.out.phys ? qos->ucast.out.phys :
+			      qos->ucast.in.phys;
+		cis->p_phys = qos->ucast.in.phys ? qos->ucast.in.phys :
+			      qos->ucast.out.phys;
 		cis->c_rtn  = qos->ucast.out.rtn;
 		cis->p_rtn  = qos->ucast.in.rtn;
 	}
@@ -1980,8 +1980,8 @@ struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
 		return cis;
 
 	/* Update LINK PHYs according to QoS preference */
-	cis->le_tx_phy = qos->ucast.out.phy;
-	cis->le_rx_phy = qos->ucast.in.phy;
+	cis->le_tx_phy = qos->ucast.out.phys;
+	cis->le_rx_phy = qos->ucast.in.phys;
 
 	/* If output interval is not set use the input interval as it cannot be
 	 * 0x000000.
@@ -2096,15 +2096,15 @@ int hci_le_create_cis_pending(struct hci_dev *hdev)
 }
 
 static void hci_iso_qos_setup(struct hci_dev *hdev, struct hci_conn *conn,
-			      struct bt_iso_io_qos *qos, __u8 phy)
+			      struct bt_iso_io_qos *qos, __u8 phys)
 {
 	/* Only set MTU if PHY is enabled */
-	if (!qos->sdu && qos->phy)
+	if (!qos->sdu && qos->phys)
 		qos->sdu = conn->mtu;
 
 	/* Use the same PHY as ACL if set to any */
-	if (qos->phy == BT_ISO_PHY_ANY)
-		qos->phy = phy;
+	if (qos->phys == BT_ISO_PHY_ANY)
+		qos->phys = phys;
 
 	/* Use LE ACL connection interval if not set */
 	if (!qos->interval)
@@ -2124,7 +2124,7 @@ static int create_big_sync(struct hci_dev *hdev, void *data)
 	u32 flags = 0;
 	int err;
 
-	if (qos->bcast.out.phy == 0x02)
+	if (qos->bcast.out.phys == BIT(1))
 		flags |= MGMT_ADV_FLAG_SEC_2M;
 
 	/* Align intervals */
@@ -2233,8 +2233,7 @@ struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __u8 sid,
 		return conn;
 
 	/* Update LINK PHYs according to QoS preference */
-	conn->le_tx_phy = qos->bcast.out.phy;
-	conn->le_tx_phy = qos->bcast.out.phy;
+	conn->le_tx_def_phys = qos->bcast.out.phys;
 
 	/* Add Basic Announcement into Peridic Adv Data if BASE is set */
 	if (base_len && base) {
@@ -2243,7 +2242,7 @@ struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __u8 sid,
 	}
 
 	hci_iso_qos_setup(hdev, conn, &qos->bcast.out,
-			  conn->le_tx_phy ? conn->le_tx_phy :
+			  conn->le_tx_def_phys ? conn->le_tx_def_phys :
 			  hdev->le_tx_def_phys);
 
 	conn->iso_qos = *qos;
@@ -2363,9 +2362,11 @@ struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
 		return le;
 
 	hci_iso_qos_setup(hdev, le, &qos->ucast.out,
-			  le->le_tx_phy ? le->le_tx_phy : hdev->le_tx_def_phys);
+			  le->le_tx_def_phys ? le->le_tx_def_phys :
+			  hdev->le_tx_def_phys);
 	hci_iso_qos_setup(hdev, le, &qos->ucast.in,
-			  le->le_rx_phy ? le->le_rx_phy : hdev->le_rx_def_phys);
+			  le->le_rx_def_phys ? le->le_rx_def_phys :
+			  hdev->le_rx_def_phys);
 
 	cis = hci_bind_cis(hdev, dst, dst_type, qos, timeout);
 	if (IS_ERR(cis)) {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 467710a42d45..286529d2e554 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6867,6 +6867,21 @@ static void hci_le_phy_update_evt(struct hci_dev *hdev, void *data,
 	hci_dev_unlock(hdev);
 }
 
+/* Convert LE PHY to QoS PHYs */
+static u8 le_phy_qos(u8 phy)
+{
+	switch (phy) {
+	case 0x01:
+		return HCI_LE_SET_PHY_1M;
+	case 0x02:
+		return HCI_LE_SET_PHY_2M;
+	case 0x03:
+		return HCI_LE_SET_PHY_CODED;
+	}
+
+	return 0;
+}
+
 static void hci_le_cis_established_evt(struct hci_dev *hdev, void *data,
 				       struct sk_buff *skb)
 {
@@ -6928,8 +6943,8 @@ static void hci_le_cis_established_evt(struct hci_dev *hdev, void *data,
 					  1000);
 		qos->ucast.in.sdu = ev->c_bn ? le16_to_cpu(ev->c_mtu) : 0;
 		qos->ucast.out.sdu = ev->p_bn ? le16_to_cpu(ev->p_mtu) : 0;
-		qos->ucast.in.phy = ev->c_phy;
-		qos->ucast.out.phy = ev->p_phy;
+		qos->ucast.in.phys = le_phy_qos(ev->c_phy);
+		qos->ucast.out.phys = le_phy_qos(ev->p_phy);
 		break;
 	case HCI_ROLE_MASTER:
 		qos->ucast.in.interval = p_sdu_interval;
@@ -6943,8 +6958,8 @@ static void hci_le_cis_established_evt(struct hci_dev *hdev, void *data,
 					  1000);
 		qos->ucast.out.sdu = ev->c_bn ? le16_to_cpu(ev->c_mtu) : 0;
 		qos->ucast.in.sdu = ev->p_bn ? le16_to_cpu(ev->p_mtu) : 0;
-		qos->ucast.out.phy = ev->c_phy;
-		qos->ucast.in.phy = ev->p_phy;
+		qos->ucast.out.phys = le_phy_qos(ev->c_phy);
+		qos->ucast.in.phys = le_phy_qos(ev->p_phy);
 		break;
 	}
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index ab0b68faa61c..5179ecf3ff63 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2948,8 +2948,8 @@ static int hci_le_set_ext_scan_param_sync(struct hci_dev *hdev, u8 type,
 			if (conn) {
 				struct bt_iso_qos *qos = &conn->iso_qos;
 
-				if (qos->bcast.in.phy & BT_ISO_PHY_1M ||
-				    qos->bcast.in.phy & BT_ISO_PHY_2M) {
+				if (qos->bcast.in.phys & BT_ISO_PHY_1M ||
+				    qos->bcast.in.phys & BT_ISO_PHY_2M) {
 					cp->scanning_phys |= LE_SCAN_PHY_1M;
 					hci_le_scan_phy_params(phy, type,
 							       interval,
@@ -2958,7 +2958,7 @@ static int hci_le_set_ext_scan_param_sync(struct hci_dev *hdev, u8 type,
 					phy++;
 				}
 
-				if (qos->bcast.in.phy & BT_ISO_PHY_CODED) {
+				if (qos->bcast.in.phys & BT_ISO_PHY_CODED) {
 					cp->scanning_phys |= LE_SCAN_PHY_CODED;
 					hci_le_scan_phy_params(phy, type,
 							       interval * 3,
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index e36d24a9098b..1459ab161fd2 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -361,7 +361,7 @@ static int iso_connect_bis(struct sock *sk)
 	}
 
 	/* Fail if out PHYs are marked as disabled */
-	if (!iso_pi(sk)->qos.bcast.out.phy) {
+	if (!iso_pi(sk)->qos.bcast.out.phys) {
 		err = -EINVAL;
 		goto unlock;
 	}
@@ -458,7 +458,7 @@ static int iso_connect_cis(struct sock *sk)
 	}
 
 	/* Fail if either PHYs are marked as disabled */
-	if (!iso_pi(sk)->qos.ucast.in.phy && !iso_pi(sk)->qos.ucast.out.phy) {
+	if (!iso_pi(sk)->qos.ucast.in.phys && !iso_pi(sk)->qos.ucast.out.phys) {
 		err = -EINVAL;
 		goto unlock;
 	}
@@ -894,7 +894,7 @@ static struct proto iso_proto = {
 	.interval	= 10000u, \
 	.latency	= 10u, \
 	.sdu		= 40u, \
-	.phy		= BT_ISO_PHY_2M, \
+	.phys		= BT_ISO_PHY_2M, \
 	.rtn		= 2u, \
 }
 
@@ -1661,7 +1661,7 @@ static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 static bool check_io_qos(struct bt_iso_io_qos *qos)
 {
 	/* If no PHY is enable SDU must be 0 */
-	if (!qos->phy && qos->sdu)
+	if (!qos->phys && qos->sdu)
 		return false;
 
 	if (qos->interval && (qos->interval < 0xff || qos->interval > 0xfffff))
@@ -1670,7 +1670,7 @@ static bool check_io_qos(struct bt_iso_io_qos *qos)
 	if (qos->latency && (qos->latency < 0x05 || qos->latency > 0xfa0))
 		return false;
 
-	if (qos->phy > BT_ISO_PHY_ANY)
+	if (qos->phys > BT_ISO_PHY_ANY)
 		return false;
 
 	return true;
-- 
2.52.0

