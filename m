Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA702D7DE9
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 20:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766004756; cv=none; b=KxArpIH5KMdParUTX7dzaGRsY2OyM3gOjogGBBtMBTNGTYdNimsTcyhjfHNz9cFJT6PrR7ObEUngyftDRu8vWQ3rYFxGhAH4uLbFGQFJ+fkua6YV7JyJc+qfGkn+dQAUuqxPi2OqUNOJUyChf8c1iUkFi0v3XieAjPQ4/jAhDyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766004756; c=relaxed/simple;
	bh=nmHTGT7wgiWkeK3iASAusQLN4cPVhGW68iXAwY8voms=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=m0r65reWF5sXLZHuXHiiNL64cn9QM9i5p+Uq3ijhEcoCJh2PehlX8p1Lv8Jy7GBHV0NOyPOoJcJSY3MhvnbqXmndRNtg2Cg1QVoetEm+TOP+vRP5gwg58zY+P/Sqcgr0lB8p4dZjbgSbazvgppB4qwr8HtnwN4vHNKEiYXG0c8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRWkfIW3; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRWkfIW3"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-93723104137so1715886241.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 12:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766004751; x=1766609551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4PTFoyFF/M5GR0QszsRS48PZt5T3l0epveEyhR2iaqI=;
        b=ZRWkfIW3m1gfd0BCZUOrDily2E1xnuLL172M3AYPaKm1hg/gfsFpKw0phmTsuRW7ZJ
         XnJUL/RwLeVLumNzi3whUWItHuvlIK/acPNe93dl8EwQPQl8OgspgUKP3diZoC6AJbFK
         65lnjd938hPm0plxTnUhv/iZG/hMKwDgp73N2oUwWwN0cDpVJioCW0sfAyg1Ddy6qziE
         z7nlTAC45Pe7G5qPYo1/6Ul7hlPpiWB+CdK2Ys8Rw7BvgK0MVVbP+2PxKWoMVEtoV7yA
         rg7wBB4LBecdL/r9zNHmfegoXULSqduKKms6PxS7Xi/yIFUbJrRWZcNoo4+qIDQiNIxG
         nG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766004751; x=1766609551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4PTFoyFF/M5GR0QszsRS48PZt5T3l0epveEyhR2iaqI=;
        b=sf4QnbqyeNPaKpb+bLRwmpEyo0PY7f4tcoZ8bihhVR0WXiDweXB/YYmRQcBJ9pQqld
         4Imzj2zM3YB/0RzdOJMqhgVZeBsjaEh7dj2XKPf8BAZ4bRnw95XR7uOvw+nOeDNUPhCr
         nEEt40W7mjf9Jg8wJMe0ITy3TJg8p7fGGJedmIIUGMMrndZQZ6jV8jintLRd2f/mTWdL
         0Qg2RuNqxq7LGamkIojcWOTr2UsqUIflqo4/SIXOcsV/dFwpabgu0eaPPxbQvznCfSJI
         G7jaL8bsQc9BiW5sXCP5sPxAQfXUVaAwvXaqcPRQmVHaOZWAZixEpooHjjgpxVx+ah2h
         07Dg==
X-Gm-Message-State: AOJu0Yz0eCLEulxvM9jbdhKrmZ30wINDXQZYnYf3xdexwC4HjTw3mzta
	0cjWnN1nZCvd06JQWTgVJ5gXowKqc650LzDDlkfAjRUrS8/C58I82P6GtgbqZWPo
X-Gm-Gg: AY/fxX5GLyIh5kh9jOze4dNhz7B3aw8H0asA9CvVc7l6mkbnntdYsn7uvVnYDhbxdaW
	AlZHPobJYpsOk7y3lPbtjGI5H504bnkzLnzHpp3OIjimGt9OxSgxfVZvLSekOvXExHjigN/55G9
	pu2NwgGrUZ+SjzdydUYYZzmEr+Ok7K+hcL8ls6b/M+fKPNw4r2e1AwXI6f7hezRMolMiifLvxRa
	w7NZDKhUpiLMpnlr5Hjn2v1rYN4zOVmFrdDieWaxo0p2TegzqjES8a8yLKcSzfCGyzYjkiqhmY4
	wffo7Zlx7SdBMzN2Hh3pGHeOYSefylu+dBMScbmI9a5hy5Ticxg+nbjMWwYFBXs5cVL4LttuRlN
	UqLCjPvuiStApQ+Ibf4jJ6Vf1Czn3ORAoqlIKWbmH5VvzksHTURYCqjNRA5uwWrEf8dOFOmL4QC
	iJUX4M0tQzCkdWyQ==
X-Google-Smtp-Source: AGHT+IGVHVgW1so6Mse5EnUmqEm3ujzgPig185I6NHOZ2hRN4Kinbckw9HziM+l33gQPwI2pjJAwYg==
X-Received: by 2002:a05:6102:5106:b0:5db:e851:938e with SMTP id ada2fe7eead31-5e8276d6791mr6207287137.10.1766004750599;
        Wed, 17 Dec 2025 12:52:30 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94331440b54sm110395241.14.2025.12.17.12.52.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 12:52:29 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: L2CAP: Add support for setting BT_PHY
Date: Wed, 17 Dec 2025 15:52:21 -0500
Message-ID: <20251217205221.285777-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables client to use setsockopt(BT_PHY) to set the connection
packet type/PHY:

Example setting BT_PHY_BR_1M_1SLOT:

< HCI Command: Change Conne.. (0x01|0x000f) plen 4
        Handle: 1 Address: 00:AA:01:01:00:00 (Intel Corporation)
        Packet type: 0x331e
          2-DH1 may not be used
          3-DH1 may not be used
          DM1 may be used
          DH1 may be used
          2-DH3 may not be used
          3-DH3 may not be used
          2-DH5 may not be used
          3-DH5 may not be used
> HCI Event: Command Status (0x0f) plen 4
      Change Connection Packet Type (0x01|0x000f) ncmd 1
        Status: Success (0x00)
> HCI Event: Connection Packet Typ.. (0x1d) plen 5
        Status: Success (0x00)
        Handle: 1 Address: 00:AA:01:01:00:00 (Intel Corporation)
        Packet type: 0x331e
          2-DH1 may not be used
          3-DH1 may not be used
          DM1 may be used
          DH1 may be used
          2-DH3 may not be used
          3-DH3 may not be used
          2-DH5 may not be used

Example setting BT_PHY_LE_1M_TX and BT_PHY_LE_1M_RX:

< HCI Command: LE Set PHY (0x08|0x0032) plen 7
        Handle: 1 Address: 00:AA:01:01:00:00 (Intel Corporation)
        All PHYs preference: 0x00
        TX PHYs preference: 0x01
          LE 1M
        RX PHYs preference: 0x01
          LE 1M
        PHY options preference: Reserved (0x0000)
> HCI Event: Command Status (0x0f) plen 4
      LE Set PHY (0x08|0x0032) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 6
      LE PHY Update Complete (0x0c)
        Status: Success (0x00)
        Handle: 1 Address: 00:AA:01:01:00:00 (Intel Corporation)
        TX PHY: LE 1M (0x01)
        RX PHY: LE 1M (0x01)

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/bluetooth.h |  39 ++++++-----
 include/net/bluetooth/hci.h       |   9 +++
 include/net/bluetooth/hci_core.h  |   1 +
 include/net/bluetooth/hci_sync.h  |   3 +
 net/bluetooth/hci_conn.c          | 106 ++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c         |  26 ++++++++
 net/bluetooth/hci_sync.c          |  72 ++++++++++++++++++++
 net/bluetooth/l2cap_sock.c        |  20 +++++-
 8 files changed, 260 insertions(+), 16 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index d46ed9011ee5..89a60919050b 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -130,21 +130,30 @@ struct bt_voice {
 #define BT_RCVMTU		13
 #define BT_PHY			14
 
-#define BT_PHY_BR_1M_1SLOT	0x00000001
-#define BT_PHY_BR_1M_3SLOT	0x00000002
-#define BT_PHY_BR_1M_5SLOT	0x00000004
-#define BT_PHY_EDR_2M_1SLOT	0x00000008
-#define BT_PHY_EDR_2M_3SLOT	0x00000010
-#define BT_PHY_EDR_2M_5SLOT	0x00000020
-#define BT_PHY_EDR_3M_1SLOT	0x00000040
-#define BT_PHY_EDR_3M_3SLOT	0x00000080
-#define BT_PHY_EDR_3M_5SLOT	0x00000100
-#define BT_PHY_LE_1M_TX		0x00000200
-#define BT_PHY_LE_1M_RX		0x00000400
-#define BT_PHY_LE_2M_TX		0x00000800
-#define BT_PHY_LE_2M_RX		0x00001000
-#define BT_PHY_LE_CODED_TX	0x00002000
-#define BT_PHY_LE_CODED_RX	0x00004000
+#define BT_PHY_BR_1M_1SLOT	BIT(0)
+#define BT_PHY_BR_1M_3SLOT	BIT(1)
+#define BT_PHY_BR_1M_5SLOT	BIT(2)
+#define BT_PHY_EDR_2M_1SLOT	BIT(3)
+#define BT_PHY_EDR_2M_3SLOT	BIT(4)
+#define BT_PHY_EDR_2M_5SLOT	BIT(5)
+#define BT_PHY_EDR_3M_1SLOT	BIT(6)
+#define BT_PHY_EDR_3M_3SLOT	BIT(7)
+#define BT_PHY_EDR_3M_5SLOT	BIT(8)
+#define BT_PHY_LE_1M_TX		BIT(9)
+#define BT_PHY_LE_1M_RX		BIT(10)
+#define BT_PHY_LE_2M_TX		BIT(11)
+#define BT_PHY_LE_2M_RX		BIT(12)
+#define BT_PHY_LE_CODED_TX	BIT(13)
+#define BT_PHY_LE_CODED_RX	BIT(14)
+
+#define BT_PHY_BREDR_MASK	(BT_PHY_BR_1M_1SLOT | BT_PHY_BR_1M_3SLOT | \
+				 BT_PHY_BR_1M_5SLOT | BT_PHY_EDR_2M_1SLOT | \
+				 BT_PHY_EDR_2M_3SLOT | BT_PHY_EDR_2M_5SLOT | \
+				 BT_PHY_EDR_3M_1SLOT | BT_PHY_EDR_3M_3SLOT | \
+				 BT_PHY_EDR_3M_5SLOT)
+#define BT_PHY_LE_MASK		(BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX | \
+				 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX | \
+				 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX)
 
 #define BT_MODE			15
 
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index a27cd3626b87..a2beda3b0071 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1883,6 +1883,15 @@ struct hci_cp_le_set_default_phy {
 #define HCI_LE_SET_PHY_2M		0x02
 #define HCI_LE_SET_PHY_CODED		0x04
 
+#define HCI_OP_LE_SET_PHY		0x2032
+struct hci_cp_le_set_phy {
+	__le16  handle;
+	__u8    all_phys;
+	__u8    tx_phys;
+	__u8    rx_phys;
+	__le16   phy_opts;
+} __packed;
+
 #define HCI_OP_LE_SET_EXT_SCAN_PARAMS   0x2041
 struct hci_cp_le_set_ext_scan_params {
 	__u8    own_addr_type;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8aadf4cdead2..71bbaa7dc790 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2336,6 +2336,7 @@ void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
 void *hci_recv_event_data(struct hci_dev *hdev, __u8 event);
 
 u32 hci_conn_get_phy(struct hci_conn *conn);
+int hci_conn_set_phy(struct hci_conn *conn, u32 phys);
 
 /* ----- HCI Sockets ----- */
 void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb);
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 56076bbc981d..73e494b2591d 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -191,3 +191,6 @@ int hci_connect_big_sync(struct hci_dev *hdev, struct hci_conn *conn);
 int hci_past_sync(struct hci_conn *conn, struct hci_conn *le);
 
 int hci_le_read_remote_features(struct hci_conn *conn);
+
+int hci_acl_change_pkt_type(struct hci_conn *conn, u16 pkt_type);
+int hci_le_set_phy(struct hci_conn *conn, u8 tx_phys, u8 rx_phys);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 5a4374ccf8e8..b4813caf3340 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2957,6 +2957,112 @@ u32 hci_conn_get_phy(struct hci_conn *conn)
 	return phys;
 }
 
+static u16 bt_phy_pkt_type(struct hci_conn *conn, u32 phys)
+{
+	u16 pkt_type = conn->pkt_type;
+
+	if (phys & BT_PHY_BR_1M_3SLOT)
+		pkt_type |= HCI_DM3 | HCI_DH3;
+	else
+		pkt_type &= ~(HCI_DM3 | HCI_DH3);
+
+	if (phys & BT_PHY_BR_1M_5SLOT)
+		pkt_type |= HCI_DM5 | HCI_DH5;
+	else
+		pkt_type &= ~(HCI_DM5 | HCI_DH5);
+
+	if (phys & BT_PHY_EDR_2M_1SLOT)
+		pkt_type &= ~HCI_2DH1;
+	else
+		pkt_type |= HCI_2DH1;
+
+	if (phys & BT_PHY_EDR_2M_3SLOT)
+		pkt_type &= ~HCI_2DH3;
+	else
+		pkt_type |= HCI_2DH3;
+
+	if (phys & BT_PHY_EDR_2M_5SLOT)
+		pkt_type &= ~HCI_2DH5;
+	else
+		pkt_type |= HCI_2DH5;
+
+	if (phys & BT_PHY_EDR_3M_1SLOT)
+		pkt_type &= ~HCI_3DH1;
+	else
+		pkt_type |= HCI_3DH1;
+
+	if (phys & BT_PHY_EDR_3M_3SLOT)
+		pkt_type &= ~HCI_3DH3;
+	else
+		pkt_type |= HCI_3DH3;
+
+	if (phys & BT_PHY_EDR_3M_5SLOT)
+		pkt_type &= ~HCI_3DH5;
+	else
+		pkt_type |= HCI_3DH5;
+
+	return pkt_type;
+}
+
+static int bt_phy_le_phy(u32 phys, u8 *tx_phys, u8 *rx_phys)
+{
+	if (!tx_phys || !rx_phys)
+		return -EINVAL;
+
+	*tx_phys = 0;
+	*rx_phys = 0;
+
+	if (phys & BT_PHY_LE_1M_TX)
+		*tx_phys |= HCI_LE_SET_PHY_1M;
+
+	if (phys & BT_PHY_LE_1M_RX)
+		*rx_phys |= HCI_LE_SET_PHY_1M;
+
+	if (phys & BT_PHY_LE_2M_TX)
+		*tx_phys |= HCI_LE_SET_PHY_2M;
+
+	if (phys & BT_PHY_LE_2M_RX)
+		*rx_phys |= HCI_LE_SET_PHY_2M;
+
+	if (phys & BT_PHY_LE_CODED_TX)
+		*tx_phys |= HCI_LE_SET_PHY_CODED;
+
+	if (phys & BT_PHY_LE_CODED_RX)
+		*rx_phys |= HCI_LE_SET_PHY_CODED;
+
+	return 0;
+}
+
+int hci_conn_set_phy(struct hci_conn *conn, u32 phys)
+{
+	struct hci_dev *hdev = conn->hdev;
+	u8 tx_phys, rx_phys;
+
+	switch (conn->type) {
+	case SCO_LINK:
+	case ESCO_LINK:
+		return -EINVAL;
+	case ACL_LINK:
+		/* Only allow setting BR/EDR PHYs if link type is ACL */
+		if (phys & ~BT_PHY_BREDR_MASK)
+			return -EINVAL;
+
+		return hci_acl_change_pkt_type(conn,
+					       bt_phy_pkt_type(conn, phys));
+	case LE_LINK:
+		/* Only allow setting LE PHYs if link type is LE */
+		if (phys & ~BT_PHY_LE_MASK)
+			return -EINVAL;
+
+		if (bt_phy_le_phy(phys, &tx_phys, &rx_phys))
+			return -EINVAL;
+
+		return hci_le_set_phy(conn, tx_phys, rx_phys);
+	default:
+		return -EINVAL;
+	}
+}
+
 static int abort_conn_sync(struct hci_dev *hdev, void *data)
 {
 	struct hci_conn *conn = data;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 58075bf72055..467710a42d45 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2869,6 +2869,31 @@ static void hci_cs_le_ext_create_conn(struct hci_dev *hdev, u8 status)
 	hci_dev_unlock(hdev);
 }
 
+static void hci_cs_le_set_phy(struct hci_dev *hdev, u8 status)
+{
+	struct hci_cp_le_set_phy *cp;
+	struct hci_conn *conn;
+
+	bt_dev_dbg(hdev, "status 0x%2.2x", status);
+
+	if (status)
+		return;
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_PHY);
+	if (!cp)
+		return;
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(cp->handle));
+	if (conn) {
+		conn->le_tx_def_phys = cp->tx_phys;
+		conn->le_rx_def_phys = cp->rx_phys;
+	}
+
+	hci_dev_unlock(hdev);
+}
+
 static void hci_cs_le_read_remote_features(struct hci_dev *hdev, u8 status)
 {
 	struct hci_cp_le_read_remote_features *cp;
@@ -4359,6 +4384,7 @@ static const struct hci_cs {
 	HCI_CS(HCI_OP_LE_CREATE_CONN, hci_cs_le_create_conn),
 	HCI_CS(HCI_OP_LE_READ_REMOTE_FEATURES, hci_cs_le_read_remote_features),
 	HCI_CS(HCI_OP_LE_START_ENC, hci_cs_le_start_enc),
+	HCI_CS(HCI_OP_LE_SET_PHY, hci_cs_le_set_phy),
 	HCI_CS(HCI_OP_LE_EXT_CREATE_CONN, hci_cs_le_ext_create_conn),
 	HCI_CS(HCI_OP_LE_CREATE_CIS, hci_cs_le_create_cis),
 	HCI_CS(HCI_OP_LE_CREATE_BIG, hci_cs_le_create_big),
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a9f5b1a68356..654137bf4713 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7418,3 +7418,75 @@ int hci_le_read_remote_features(struct hci_conn *conn)
 
 	return err;
 }
+
+static void pkt_type_changed(struct hci_dev *hdev, void *data, int err)
+{
+	struct hci_cp_change_conn_ptype *cp = data;
+
+	bt_dev_dbg(hdev, "err %d", err);
+
+	kfree(cp);
+}
+
+static int hci_change_conn_ptype_sync(struct hci_dev *hdev, void *data)
+{
+	struct hci_cp_change_conn_ptype *cp = data;
+
+	return __hci_cmd_sync_status_sk(hdev, HCI_OP_CHANGE_CONN_PTYPE,
+					sizeof(*cp), cp,
+					HCI_EV_PKT_TYPE_CHANGE,
+					HCI_CMD_TIMEOUT, NULL);
+}
+
+int hci_acl_change_pkt_type(struct hci_conn *conn, u16 pkt_type)
+{
+	struct hci_dev *hdev = conn->hdev;
+	struct hci_cp_change_conn_ptype *cp;
+
+	cp = kmalloc(sizeof(*cp), GFP_KERNEL);
+	if (!cp)
+		return -ENOMEM;
+
+	cp->handle = cpu_to_le16(conn->handle);
+	cp->pkt_type = cpu_to_le16(pkt_type);
+
+	return hci_cmd_sync_queue_once(hdev, hci_change_conn_ptype_sync, cp,
+				       pkt_type_changed);
+}
+
+static void le_phy_update_complete(struct hci_dev *hdev, void *data, int err)
+{
+	struct hci_cp_le_set_phy *cp = data;
+
+	bt_dev_dbg(hdev, "err %d", err);
+
+	kfree(cp);
+}
+
+static int hci_le_set_phy_sync(struct hci_dev *hdev, void *data)
+{
+	struct hci_cp_le_set_phy *cp = data;
+
+	return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_SET_PHY,
+					sizeof(*cp), cp,
+					HCI_EV_LE_PHY_UPDATE_COMPLETE,
+					HCI_CMD_TIMEOUT, NULL);
+}
+
+int hci_le_set_phy(struct hci_conn *conn, u8 tx_phys, u8 rx_phys)
+{
+	struct hci_dev *hdev = conn->hdev;
+	struct hci_cp_le_set_phy *cp;
+
+	cp = kmalloc(sizeof(*cp), GFP_KERNEL);
+	if (!cp)
+		return -ENOMEM;
+
+	memset(cp, 0, sizeof(*cp));
+	cp->handle = cpu_to_le16(conn->handle);
+	cp->tx_phys = tx_phys;
+	cp->rx_phys = rx_phys;
+
+	return hci_cmd_sync_queue_once(hdev, hci_le_set_phy_sync, cp,
+				       le_phy_update_complete);
+}
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 9ee189c815d4..3ba3ce7eaa98 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -885,7 +885,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 	struct bt_power pwr;
 	struct l2cap_conn *conn;
 	int err = 0;
-	u32 opt;
+	u32 opt, phys;
 	u16 mtu;
 	u8 mode;
 
@@ -1059,6 +1059,24 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		break;
 
+	case BT_PHY:
+		if (sk->sk_state != BT_CONNECTED) {
+			err = -ENOTCONN;
+			break;
+		}
+
+		err = copy_safe_from_sockptr(&phys, sizeof(phys), optval,
+					     optlen);
+		if (err)
+			break;
+
+		if (!chan->conn)
+			break;
+
+		conn = chan->conn;
+		err = hci_conn_set_phy(conn->hcon, phys);
+		break;
+
 	case BT_MODE:
 		if (!enable_ecred) {
 			err = -ENOPROTOOPT;
-- 
2.52.0

