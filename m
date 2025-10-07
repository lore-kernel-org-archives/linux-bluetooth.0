Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C9E258CE1
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Oct 2025 22:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759876338; cv=none; b=DPGXFEyDvjNZFhVkPlrEs50eVa9tSZybEjUoDEJ4+PWcdBAWJiRxkHx3KCmQ3oSFu1xPT1VqJz25BAp2XY3XFX5PBMEqMMag3JXaxMgs1+mlZyUZ54a6UuafadLhOf7XUIUmxv7FrF6asp0KHbZvLuaJ0so+boIiNQzbK1BMteo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759876338; c=relaxed/simple;
	bh=lsok/8KmZBgF0dw5Yl1xOX+s4JzkjAEprYY8Y95b488=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iT9rKeXBie+CbUNjnWTkHi7SDf/hfteG1LTKMVhQUavndS5CVjBDk12djWie/jaMS7bau4oddqnIMKgM64FZCOPO6u81I51/ftcbKic05tBDFwzrtQrusEun4nRD4M2dbQLYaBUus/+t2Vt7WKU6R0kffWpfqX5w97EA1Cgxq2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UG8zAm6b; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UG8zAm6b"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-8e3eaa30c71so5959878241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Oct 2025 15:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759876335; x=1760481135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cf/5N7MvG0TaupiLGrvYcfetIObFMFl1TqpscpKNMNY=;
        b=UG8zAm6b9gYcIXGNqHBGt1Ye3EnUgtdme9KlsjlajWNPz/05vJ4fBizxRpqhZDl8R7
         LHw9WILSJddXL7SAhppRXRXenbNc4mqsTRtDi+Sgv/FWN9HoniaMSWhgprILWNXo/3ew
         uXkoFOQntJXmS5ehbI+LEtd78AmEv0FNwporkeu7RGW+/to9AR2juOGnev4ZARBWAaM1
         89GKlpaGC/paM8yjo0+fVLYib5xK9rsh0QxjDjd5WBfrha+q7xtec36gHuAViplWyvF+
         oHnShttlMznEyIh0E+9ycaltgemTQi/lnpS5ea4Ir2VH61E8dU7bWwDcPCrokcnyFZxj
         DaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759876335; x=1760481135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cf/5N7MvG0TaupiLGrvYcfetIObFMFl1TqpscpKNMNY=;
        b=RSftf0APO+Og/iwb/hPaXfQH3X/Lf4QzGe2KeKJ8NvUnK6sQZQuNtFzk1LkDCLMzKm
         lA31NBOzNU1jrHDfx1/CG3IsF46HoU6FU6kopmsfj08Q/t9RPT9JO4Jvaxy584512Ddx
         xqfV74dMNUnrLU6Z4tFhNhABpGwN/IKAjgoS5zkSpF/AS8IZPr49cHsjIlha3u8l6WSZ
         9Ap34yR+dFqJvCDTCjsx7ctw/IwDA4NWb56TR86z6319WIpSFWy0wu5VSqjPnMlC+JGZ
         gZvkkI3jaTLZZb1Ko/SSob6kZODG/uQVWKGFSSWXP44RxHDoItHK7eZw4lGZFri0VLgu
         kIww==
X-Gm-Message-State: AOJu0YxnzlLBhzy/1pzVci8adyQ60vJNte/tKMXpjB9gYKM4qSve0Bt4
	+eIvmiTfLJzr7DY6z8f7UMQrDGBX19fUT77rMLV/q8pW1WNKDypqjvDssroJFo1k
X-Gm-Gg: ASbGncvc4EqAEcHWM7+Wgbs0pnoRvcv53KkqMHIO0ukZmLBnV75QP9r/HkzujPd/C1p
	aJlkp/SJzK6yG9LkksVaQinQ+TLKhGpOu85vUK3vfix6V6hIUMINhFPe1dzsP3pjvwBIA6miKB2
	gJCHPbkumYbeR0LVKv9TDmYceRrXghRLknhJ212NuWSUuti1lsic9N12E4vTSgTyDI3T6IAk00u
	7NmCzLPMHCb+Hrqy1Y12NyBqNrMRDdqkbY6QjltSnIs6OPWoJaSLb99B9u9Xztqn3rJM24YFREk
	YnKY2yfOXr+8lrwijU2y43ezJxsIXBpK3W+GeqDAFH6zR/eLZN7r9MAye+XUDO6bUTM362NIcCi
	inFRaIuo0FJzc0H5lU/IC5iLnL8PzhQxwJWvVsZDznjaqGAn1t0V8b7lDFb3INZq3blnRWQ2QeF
	q2RrQa5XE2TOrsAvu6Lbf2E/4H
X-Google-Smtp-Source: AGHT+IFghZhaF6dvNB8IIeQP/wz1zoPcqudkzlA9dpZ3oGLMNEGxgNxwfiZ6+/0VUFeb2Zs/UoEZSA==
X-Received: by 2002:a05:6102:32c1:b0:52d:110:a920 with SMTP id ada2fe7eead31-5d5e2394649mr548178137.33.1759876335156;
        Tue, 07 Oct 2025 15:32:15 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-92eb4da21c3sm3859567241.7.2025.10.07.15.32.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 15:32:13 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 4/8] Bluetooth: HCI: Always use the identity address when initializing a connection
Date: Tue,  7 Oct 2025 18:31:51 -0400
Message-ID: <20251007223155.1539954-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007223155.1539954-1-luiz.dentz@gmail.com>
References: <20251007223155.1539954-1-luiz.dentz@gmail.com>
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
index d40817e5ac07..a0ad136b2108 100644
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
index a3aef80e6a97..d6162a95048e 100644
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

