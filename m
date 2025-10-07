Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537142E093E
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Oct 2025 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759848593; cv=none; b=P86nk2UxhWgvyAmjlPZ/OF4soGGrcQfRfhOeAt5o7jJ6OadMlcZazGjNnkWUFcmOTHonx4nOgMAZ16Gd92povn2gtj+OrRptjh67yrIgexPYfRVOCbM9IIYrKPIwT7LZO5vNvH1rJckJ3O+cbEogFZnh2B4RjGTi99tgIw/ofns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759848593; c=relaxed/simple;
	bh=em72GBZ9B9fgzuzmFMSUemqXMsOXxM47u0RyLVWpda8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibRJpvtAsAa9DAEAY9Cc09/BdENSZAieFc5B8NyM1CK0PpjzWds/Kqr+XJsHvGINMQkVQQLPfh0nAvbMHwiu3A/YgUVsDHDRTqU2Hc2BvJA+rx7S1/jXjaFHchqRTWPlPEq8RX8cQCnp+0rmXKDOEB2ZZQEdb6E5qtFEYMI8Zmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJTp9TSt; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJTp9TSt"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-554a627a257so505977e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Oct 2025 07:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759848589; x=1760453389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jMKU29f+BPJY+GGpOcKT46vnVoRx9HHGgycxJmZFv50=;
        b=ZJTp9TSteSaeTgZdoTOJU62qOlVLZurmx6jJgVXp38fzoXyMorUAlBVVNcXeEHsDvY
         vtu+WpTGcPihDJV+rn6u/hKQwRCPf2eWOTw04hzKDpr3eClf9EJCIFrAUuCa+Vk7m1Kd
         mdh9fuqe5HCrqEH0khGRAVSzB9/nGp5cbdTOB53agUI4Z81dXO4WYLtwThSwAHODw/8e
         O9dvb7cFkb+53y/QgoKyxTgn5eH08y+79mAF3fHCYvCneWieLSVgX9mNhR3N0KU2Mq5z
         6CbPfTz5p1SJ0+fwOYZYbIKXLx70UcXPsUQNKkOIeCAMwb3sVdRLhPJWPiiNpDf+cGyd
         o4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759848589; x=1760453389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMKU29f+BPJY+GGpOcKT46vnVoRx9HHGgycxJmZFv50=;
        b=dIpAg48etAQxF2qDTnD3ccPePKKNXDmIexA7Xaclbm0xrGxFV/cMcn1zzp1vWFoEGO
         YtVCoR0edXwt879wOLjfu0Rli8cCDVrNKiieWzWbXi52Dbe7P8pzkNr4ZcoHbD1WIoFH
         px/sVREzSCcZJ8a//XHb8+bbF5s8CjtfHbakEq1HQYTEUugACLza20vCFc1gqfz2J0zQ
         ntdbPgtZtTUS1gxTR8Ad8r8cSBmwhbzCbyLxCV/Vi2a3Pq6uAvjgSOq1Sut2OPAau7OB
         JX/kGMCb3ImsOac9qmwVjmpML9y9NpddtTAhqEea5OHpk0ShXUi5GSaPN18YA2BXC00f
         hOfg==
X-Gm-Message-State: AOJu0Yw7qmZwNHJ+14LBuCxSGPbBao+E9ptcskvkh//eAh8cbv+IYLpY
	gmcKditSRDTJdKhppKsGbiCjZ/oGs/GiiByBoXkdlIRbUHJv+VMurVicJGuUFw==
X-Gm-Gg: ASbGncts1VjdpN+lxmGTjYvnq3XByGzI5q9CD28JUlLh3tKqFro61w3JMO0Kp98Nm1e
	FIoIDDobioNYtX1EwqR6BxtjQ3SwtBnK2bYpgorXHmBEx6To48IyP9CSldASoeqIcyPdYDavRUW
	qknM2PmXfT5O2FGeduakqAlWbCyiGbW1BEBlr8qar7DkaaYHnP+9vTtblkbr+ADi3dYkgUJ0tvG
	bBfoogKNYaLNOMUHkEnMxxLm+cTcu/tkHu1RUv6bWzvSKnLwgZoGyy6lOn5/rjwDIOUAe8Ffd0r
	kXTF37A87rU4WDavKrw1WYNzeEauEywfxrkDoaAAUUwd4Yyvc9AwPAydC4v83Re4132/6ZHyXWs
	3IhSHtfDpizfAkFzGFmGTpilX1Kiur/cOBI9+Q3HpPjVvYHlpuMQtA+N/rG8geEDEcKtGaRDJI6
	jmGsIL5+8pwXLlJg==
X-Google-Smtp-Source: AGHT+IFKzw6T+ik1k+rs40lUbgPD55K/vpycYlJiISa4swmfEuLrNyAjFTJpSleAUk7a2ls3n2/MnA==
X-Received: by 2002:a05:6122:d29:b0:554:afe3:1fb1 with SMTP id 71dfb90a1353d-554afe32079mr1026990e0c.14.1759848589335;
        Tue, 07 Oct 2025 07:49:49 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5523ce64af0sm3731864e0c.8.2025.10.07.07.49.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 07:49:47 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/7] Bluetooth: HCI: Always use the identity address when initializing a connection
Date: Tue,  7 Oct 2025 10:49:27 -0400
Message-ID: <20251007144930.1378274-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007144930.1378274-1-luiz.dentz@gmail.com>
References: <20251007144930.1378274-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes sure hci_conn is initialized with the identity address if
a matching IRK exists which avoids the trouble of having to do it at
multiple places which seems to be missing (e.g. CIS, BIS and PA).

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  4 +--
 net/bluetooth/hci_conn.c         | 43 ++++++++++++++++++++------------
 net/bluetooth/hci_event.c        | 20 +++++++--------
 net/bluetooth/hci_sync.c         |  2 +-
 4 files changed, 40 insertions(+), 29 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2a765a0521b4..c1889e1aa477 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1563,9 +1563,9 @@ int hci_le_create_cis_pending(struct hci_dev *hdev);
 int hci_conn_check_create_cis(struct hci_conn *conn);
 
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
-			      u8 role, u16 handle);
+			      u8 dst_type, u8 role, u16 handle);
 struct hci_conn *hci_conn_add_unset(struct hci_dev *hdev, int type,
-				    bdaddr_t *dst, u8 role);
+				    bdaddr_t *dst, u8 dst_type, u8 role);
 void hci_conn_del(struct hci_conn *conn);
 void hci_conn_hash_flush(struct hci_dev *hdev);
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 111f0e37b672..88485b6aeedc 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -911,10 +911,12 @@ static int hci_conn_hash_alloc_unset(struct hci_dev *hdev)
 			       U16_MAX, GFP_ATOMIC);
 }
 
-static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
+static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type,
+				       bdaddr_t *dst, u8 dst_type,
 				       u8 role, u16 handle)
 {
 	struct hci_conn *conn;
+	struct smp_irk *irk = NULL;
 
 	switch (type) {
 	case ACL_LINK:
@@ -926,12 +928,14 @@ static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t
 	case PA_LINK:
 		if (!hdev->iso_mtu)
 			return ERR_PTR(-ECONNREFUSED);
+		irk = hci_get_irk(hdev, dst, dst_type);
 		break;
 	case LE_LINK:
 		if (hdev->le_mtu && hdev->le_mtu < HCI_MIN_LE_MTU)
 			return ERR_PTR(-ECONNREFUSED);
 		if (!hdev->le_mtu && hdev->acl_mtu < HCI_MIN_LE_MTU)
 			return ERR_PTR(-ECONNREFUSED);
+		irk = hci_get_irk(hdev, dst, dst_type);
 		break;
 	case SCO_LINK:
 	case ESCO_LINK:
@@ -949,7 +953,15 @@ static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t
 	if (!conn)
 		return ERR_PTR(-ENOMEM);
 
-	bacpy(&conn->dst, dst);
+	/* If and IRK exists use its identity address */
+	if (!irk) {
+		bacpy(&conn->dst, dst);
+		conn->dst_type = dst_type;
+	} else {
+		bacpy(&conn->dst, &irk->bdaddr);
+		conn->dst_type = irk->addr_type;
+	}
+
 	bacpy(&conn->src, &hdev->bdaddr);
 	conn->handle = handle;
 	conn->hdev  = hdev;
@@ -1047,7 +1059,7 @@ static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t
 }
 
 struct hci_conn *hci_conn_add_unset(struct hci_dev *hdev, int type,
-				    bdaddr_t *dst, u8 role)
+				    bdaddr_t *dst, u8 dst_type, u8 role)
 {
 	int handle;
 
@@ -1057,16 +1069,16 @@ struct hci_conn *hci_conn_add_unset(struct hci_dev *hdev, int type,
 	if (unlikely(handle < 0))
 		return ERR_PTR(-ECONNREFUSED);
 
-	return __hci_conn_add(hdev, type, dst, role, handle);
+	return __hci_conn_add(hdev, type, dst, dst_type, role, handle);
 }
 
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
-			      u8 role, u16 handle)
+			      u8 dst_type, u8 role, u16 handle)
 {
 	if (handle > HCI_CONN_HANDLE_MAX)
 		return ERR_PTR(-EINVAL);
 
-	return __hci_conn_add(hdev, type, dst, role, handle);
+	return __hci_conn_add(hdev, type, dst, dst_type, role, handle);
 }
 
 static void hci_conn_cleanup_child(struct hci_conn *conn, u8 reason)
@@ -1398,14 +1410,13 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	if (conn) {
 		bacpy(&conn->dst, dst);
 	} else {
-		conn = hci_conn_add_unset(hdev, LE_LINK, dst, role);
+		conn = hci_conn_add_unset(hdev, LE_LINK, dst, dst_type, role);
 		if (IS_ERR(conn))
 			return conn;
 		hci_conn_hold(conn);
 		conn->pending_sec_level = sec_level;
 	}
 
-	conn->dst_type = dst_type;
 	conn->sec_level = BT_SECURITY_LOW;
 	conn->conn_timeout = conn_timeout;
 	conn->le_adv_phy = phy;
@@ -1575,7 +1586,7 @@ static struct hci_conn *hci_add_bis(struct hci_dev *hdev, bdaddr_t *dst,
 		     memcmp(conn->le_per_adv_data, base, base_len)))
 		return ERR_PTR(-EADDRINUSE);
 
-	conn = hci_conn_add_unset(hdev, BIS_LINK, dst, HCI_ROLE_MASTER);
+	conn = hci_conn_add_unset(hdev, BIS_LINK, dst, 0, HCI_ROLE_MASTER);
 	if (IS_ERR(conn))
 		return conn;
 
@@ -1621,7 +1632,8 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
 
 	BT_DBG("requesting refresh of dst_addr");
 
-	conn = hci_conn_add_unset(hdev, LE_LINK, dst, HCI_ROLE_MASTER);
+	conn = hci_conn_add_unset(hdev, LE_LINK, dst, dst_type,
+				  HCI_ROLE_MASTER);
 	if (IS_ERR(conn))
 		return conn;
 
@@ -1632,7 +1644,6 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
 
 	conn->state = BT_CONNECT;
 	set_bit(HCI_CONN_SCANNING, &conn->flags);
-	conn->dst_type = dst_type;
 	conn->sec_level = BT_SECURITY_LOW;
 	conn->pending_sec_level = sec_level;
 	conn->conn_timeout = conn_timeout;
@@ -1669,7 +1680,8 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 
 	acl = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
 	if (!acl) {
-		acl = hci_conn_add_unset(hdev, ACL_LINK, dst, HCI_ROLE_MASTER);
+		acl = hci_conn_add_unset(hdev, ACL_LINK, dst, 0,
+					 HCI_ROLE_MASTER);
 		if (IS_ERR(acl))
 			return acl;
 	}
@@ -1738,7 +1750,7 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 
 	sco = hci_conn_hash_lookup_ba(hdev, type, dst);
 	if (!sco) {
-		sco = hci_conn_add_unset(hdev, type, dst, HCI_ROLE_MASTER);
+		sco = hci_conn_add_unset(hdev, type, dst, 0, HCI_ROLE_MASTER);
 		if (IS_ERR(sco)) {
 			hci_conn_drop(acl);
 			return sco;
@@ -1930,7 +1942,7 @@ struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
 	cis = hci_conn_hash_lookup_cis(hdev, dst, dst_type, qos->ucast.cig,
 				       qos->ucast.cis);
 	if (!cis) {
-		cis = hci_conn_add_unset(hdev, CIS_LINK, dst,
+		cis = hci_conn_add_unset(hdev, CIS_LINK, dst, dst_type,
 					 HCI_ROLE_MASTER);
 		if (IS_ERR(cis))
 			return cis;
@@ -2121,12 +2133,11 @@ struct hci_conn *hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst,
 
 	bt_dev_dbg(hdev, "dst %pMR type %d sid %d", dst, dst_type, sid);
 
-	conn = hci_conn_add_unset(hdev, PA_LINK, dst, HCI_ROLE_SLAVE);
+	conn = hci_conn_add_unset(hdev, PA_LINK, dst, dst_type, HCI_ROLE_SLAVE);
 	if (IS_ERR(conn))
 		return conn;
 
 	conn->iso_qos = *qos;
-	conn->dst_type = dst_type;
 	conn->sid = sid;
 	conn->state = BT_LISTEN;
 	conn->conn_timeout = msecs_to_jiffies(qos->bcast.sync_timeout * 10);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f1735a7e48a7..ba0a7b41611f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2267,7 +2267,7 @@ static void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
 	} else {
 		if (!conn) {
 			conn = hci_conn_add_unset(hdev, ACL_LINK, &cp->bdaddr,
-						  HCI_ROLE_MASTER);
+						  0, HCI_ROLE_MASTER);
 			if (IS_ERR(conn))
 				bt_dev_err(hdev, "connection err: %ld", PTR_ERR(conn));
 		}
@@ -3123,7 +3123,8 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 						      &ev->bdaddr,
 						      BDADDR_BREDR)) {
 			conn = hci_conn_add_unset(hdev, ev->link_type,
-						  &ev->bdaddr, HCI_ROLE_SLAVE);
+						  &ev->bdaddr, 0,
+						  HCI_ROLE_SLAVE);
 			if (IS_ERR(conn)) {
 				bt_dev_err(hdev, "connection err: %ld", PTR_ERR(conn));
 				goto unlock;
@@ -3299,7 +3300,7 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
 	conn = hci_conn_hash_lookup_ba(hdev, ev->link_type,
 			&ev->bdaddr);
 	if (!conn) {
-		conn = hci_conn_add_unset(hdev, ev->link_type, &ev->bdaddr,
+		conn = hci_conn_add_unset(hdev, ev->link_type, &ev->bdaddr, 0,
 					  HCI_ROLE_SLAVE);
 		if (IS_ERR(conn)) {
 			bt_dev_err(hdev, "connection err: %ld", PTR_ERR(conn));
@@ -5660,14 +5661,13 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 		if (status)
 			goto unlock;
 
-		conn = hci_conn_add_unset(hdev, LE_LINK, bdaddr, role);
+		conn = hci_conn_add_unset(hdev, LE_LINK, bdaddr, bdaddr_type,
+					  role);
 		if (IS_ERR(conn)) {
 			bt_dev_err(hdev, "connection err: %ld", PTR_ERR(conn));
 			goto unlock;
 		}
 
-		conn->dst_type = bdaddr_type;
-
 		/* If we didn't have a hci_conn object previously
 		 * but we're in central role this must be something
 		 * initiated using an accept list. Since accept list based
@@ -5949,7 +5949,7 @@ static void hci_le_past_received_evt(struct hci_dev *hdev, void *data,
 		goto unlock;
 
 	/* Add connection to indicate PA sync event */
-	pa_sync = hci_conn_add_unset(hdev, PA_LINK, BDADDR_ANY,
+	pa_sync = hci_conn_add_unset(hdev, PA_LINK, BDADDR_ANY, 0,
 				     HCI_ROLE_SLAVE);
 
 	if (IS_ERR(pa_sync))
@@ -6482,7 +6482,7 @@ static void hci_le_pa_sync_established_evt(struct hci_dev *hdev, void *data,
 		goto unlock;
 
 	/* Add connection to indicate PA sync event */
-	pa_sync = hci_conn_add_unset(hdev, PA_LINK, BDADDR_ANY,
+	pa_sync = hci_conn_add_unset(hdev, PA_LINK, BDADDR_ANY, 0,
 				     HCI_ROLE_SLAVE);
 
 	if (IS_ERR(pa_sync))
@@ -6923,7 +6923,7 @@ static void hci_le_cis_req_evt(struct hci_dev *hdev, void *data,
 
 	cis = hci_conn_hash_lookup_handle(hdev, cis_handle);
 	if (!cis) {
-		cis = hci_conn_add(hdev, CIS_LINK, &acl->dst,
+		cis = hci_conn_add(hdev, CIS_LINK, &acl->dst, acl->dst_type,
 				   HCI_ROLE_SLAVE, cis_handle);
 		if (IS_ERR(cis)) {
 			hci_le_reject_cis(hdev, ev->cis_handle);
@@ -7040,7 +7040,7 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 				bt_dev_dbg(hdev, "ignore too large handle %u", handle);
 				continue;
 			}
-			bis = hci_conn_add(hdev, BIS_LINK, BDADDR_ANY,
+			bis = hci_conn_add(hdev, BIS_LINK, BDADDR_ANY, 0,
 					   HCI_ROLE_SLAVE, handle);
 			if (IS_ERR(bis))
 				continue;
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 571e07f81523..b5e58cbf0d46 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7013,7 +7013,7 @@ static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
 		goto unlock;
 
 	/* Add connection to indicate PA sync error */
-	pa_sync = hci_conn_add_unset(hdev, PA_LINK, BDADDR_ANY,
+	pa_sync = hci_conn_add_unset(hdev, PA_LINK, BDADDR_ANY, 0,
 				     HCI_ROLE_SLAVE);
 
 	if (IS_ERR(pa_sync))
-- 
2.51.0

