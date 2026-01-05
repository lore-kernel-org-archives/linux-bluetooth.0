Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46072737EB
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 20:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767645879; cv=none; b=R9Smd+4b3o5oL8FhxfBe2dKWD2Qp1GS5kIPzJWjycXB+NWACL1cZuCk8ftPYijiXkdyoN1hbiwCCP9r7+TNh/N0Sskzpmd6RuRGmtV8IAvyP7PNRZRO4QRPMY4elCy4G4BbsRVEQ4uAKpvSN0b8FHegE7UR/JJOY/eWC2GPbq4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767645879; c=relaxed/simple;
	bh=PZiuIZaNeVLbsSobN0esnaPFTqwG7Bu6GAQxnR0V7to=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=oaNzcuYMTlFiQZvsOcbULuLYZoBxKeOCnpudwJGr5k6bLrEGmPEcOQABIkrFE0syvu5pB+mysyFXW+0DGBi5s99FOLebrnENJFU7kewhoBhKA3gl2gUm1X6vu4fRlztJb5qO2mKyE+zf8OaRsa9G4USFnJGhjFjvxyi/O7I/UXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7KrTNjW; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7KrTNjW"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5597330a34fso216690e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Jan 2026 12:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767645876; x=1768250676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RfrEjrHfpB4Wu1oMdwsyFbuqzphovEBKdvU8L1SQw4M=;
        b=Q7KrTNjW2u+IEqeBVENo4Tg9E+1E6/N/8iQnwvHCMRd7IQcXAJ1lu/aMkTnKSqLeVB
         8kKlPObF3GE/dWtT2+kT/dskAuLFeVUjssRGv5j27veMg0fMJaR7A0L1007idnJTM7zo
         0X2uAmnMLNSTtlwRRPVxcHolBtMyj391zPsLX5VjAjyO1hwUOVgo+TDYpQmX9wzApGy7
         7W34iV/O1MYWgNUkg1xsFWEVqlYHTqYO8Y+9yyxm1CwIplLd9CpeKRJy9gY+6WTrv1aT
         Nq9OF+kum9JWQyivBuouPDDc3HfyDpGO1f0ep5BQq7AcgvcI9PlxJyUxgjYSWD9FcML5
         9JVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767645876; x=1768250676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RfrEjrHfpB4Wu1oMdwsyFbuqzphovEBKdvU8L1SQw4M=;
        b=Swa/rp7je29GUvw3nN1CRYkMLX++6wSTzPhrS+k/d8yVVMMK0kBZgGYTHofuMcjTyY
         7NyBj38n0q+mPUyUxVZcRgxj5+wbAhngzeMyXvSgZUsSWv3ONUAuFVSXlMCnQ8pDouf/
         N7lAeWNb2xtfINLrRxc4vj4fB35xeKZxmWjixv7oQnpi2skxJpr9JmZczzHEOBzv0oFj
         lNm6iJzZEFXuqIeNDd+VRNhmLj5HLi8S9MdwQ3VwOul9UeR8bHQcFxCjP83TUr7npjiC
         3LEd/zRL1SDWVolGEQDWVT7oWQIXBmrz3DYFCPImIbHBRBzDbJGiHmuYHJ2RaX7ToRiX
         5bLw==
X-Gm-Message-State: AOJu0YwjJNnfiAwlzjt7KyyB9/hQjgxmEQ6r2UwAx3nw+EcxaKOgVicz
	RlIlBUspT/OfJqyt3OxhQAhw74tk5Yn7ZaL9WIjasJKID7DN4qj2luAhGte4zUfP
X-Gm-Gg: AY/fxX4iJ54EQ4c6LcHsSM6Mepg6Ov8kHDs2O4vyrHvuA4GRL9pajra/IX1qb4BQnaX
	O1o15QLEeDklJ7JejR+6BQQZZySWI9EWCeEpScu2NmdyEeADQIkJx6c5uWHuQxeI8tIgtA/MNp+
	nQ9tcCnYYGeRuzefSH5GOQR7/n7yo+o05+7/YTnRJ2ZfWoBvbu7OmfF6Aqro5DDIkah4jiYb7po
	fCKpa+P/Qauctht+Q5Zvo3tWHVbKEw1h5mBgxORzfRxU11hAdv8FnE+FyTEG6z3uxzyXen6lHR9
	W4QrT/s7glb9G/Te25hbeZ4p5VKPLuvefWNGSV4b0H/8Zm/QIIuj+iX2I4jdcKhMbGnBQ7aGmtz
	W1XmvPI1jf6xMc5Dlf+ePm/mhA1MfWbuZkE9j6ZYYIOSrtjuvls/KfY7p0cs4lp/sfLWAUbWHDj
	FMzhtb322wiCAqfahkLqqzC0QJNAgdTyyDwpYlw4EAkkGBARygexX+3EtdX2Zlj5wKz92lUu1OC
	1MCIw==
X-Google-Smtp-Source: AGHT+IFA8JbJ9njQur+DJg0dJ1yqRQNMEXX9yerjCseeXK4qe/EZ7USSxmCnHWtoLnTAQyb4HHELuA==
X-Received: by 2002:a05:6122:919:b0:559:83be:69c5 with SMTP id 71dfb90a1353d-5633950fde7mr241661e0c.10.1767645876229;
        Mon, 05 Jan 2026 12:44:36 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5633a414155sm94116e0c.15.2026.01.05.12.44.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 12:44:35 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: Fix using PHYs bitfields as PHY value
Date: Mon,  5 Jan 2026 15:44:26 -0500
Message-ID: <20260105204426.3034176-1-luiz.dentz@gmail.com>
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
 include/net/bluetooth/hci.h       |  2 +-
 net/bluetooth/hci_conn.c          | 35 ++++++++++++++++---------------
 net/bluetooth/hci_event.c         |  8 +++----
 net/bluetooth/hci_sync.c          |  6 +++---
 net/bluetooth/iso.c               | 10 ++++-----
 6 files changed, 35 insertions(+), 34 deletions(-)

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
index db76c2d1eeaa..32e75d8eabd3 100644
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
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 1a4b6badf2b3..713e536f7a3f 100644
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
+		cis->c_phy  = qos->ucast.out.phys ? qos->ucast.out.phys :
+			      qos->ucast.in.phys;
+		cis->p_phy  = qos->ucast.in.phys ? qos->ucast.in.phys :
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
index 467710a42d45..6d9a224dfce0 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6928,8 +6928,8 @@ static void hci_le_cis_established_evt(struct hci_dev *hdev, void *data,
 					  1000);
 		qos->ucast.in.sdu = ev->c_bn ? le16_to_cpu(ev->c_mtu) : 0;
 		qos->ucast.out.sdu = ev->p_bn ? le16_to_cpu(ev->p_mtu) : 0;
-		qos->ucast.in.phy = ev->c_phy;
-		qos->ucast.out.phy = ev->p_phy;
+		qos->ucast.in.phys = ev->c_phy;
+		qos->ucast.out.phys = ev->p_phy;
 		break;
 	case HCI_ROLE_MASTER:
 		qos->ucast.in.interval = p_sdu_interval;
@@ -6943,8 +6943,8 @@ static void hci_le_cis_established_evt(struct hci_dev *hdev, void *data,
 					  1000);
 		qos->ucast.out.sdu = ev->c_bn ? le16_to_cpu(ev->c_mtu) : 0;
 		qos->ucast.in.sdu = ev->p_bn ? le16_to_cpu(ev->p_mtu) : 0;
-		qos->ucast.out.phy = ev->c_phy;
-		qos->ucast.in.phy = ev->p_phy;
+		qos->ucast.out.phys = ev->c_phy;
+		qos->ucast.in.phys = ev->p_phy;
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

