Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3261DF73C
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Aug 2025 20:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550096; cv=none; b=j/5KycC3pI1u1rnmy4j7RWliKU9BrvtzQrcqblrGWHnd9pNTjjbh3gAlj8C9C4/ictIpUeZiOGCu/HmkzCuOJKT0F6FsVhiu4YtGUnDz7IPe0gb0LuIs3mNOSgD2W2LBaE9enzBmD5lyvsOPC3rNfWKGMligF7B0uDX368w6rYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550096; c=relaxed/simple;
	bh=2PU6vXv3otiaDrIZYmP9n8SHX4iQhsxYi7w5BfMDx9Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qHvY4J20oLMnBLwOzw7Lm8aU4l0QayKOJkzvSnNfvSwG/3ybVTV16DjFhlm212o6NpmkXJCtj3pAJSMyi/MzzuVAZqGuYWhnQ15Wkf4xtIyjMA4abgyz2ddwHKT74zy42KXhr4BD8tOlNPLZF5nJSu56ou9UNBo/PsDfh6ASKDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erTxGig3; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erTxGig3"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-53b1719b717so3947126e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Aug 2025 13:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755550092; x=1756154892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LmSFhtkjn050aL3wt4l2QCFwoYpvsEdCYa0KpbEoHWA=;
        b=erTxGig35b7nsMhBgfWDaIlpWzdg2iLeYIdxp8s0Q9D+tQeed+bgfEA4uH5KtkqRWw
         hG07Q94QGoakL4HncctJeBSIZZ0kK/kEAVneBaLzqacIgyG9lWvPDhf8fD5cRhV4+WP+
         tIoGgIBMMXkcjfpaDBdtHUMjgo++RMd0Rd52AGj4k/HZI9omzGtVKjvABCOR/NODnVmf
         XcF5ZdrqxYRXa3nlA2CXKK7IoJSmmL0F1Fjs5BDQB8ZkexOTWCudwYIQmGl9TPSE1S5Q
         lW6tAEbDxTqPTk3oLJuxTETtQW+wtMIAWDei335TjFboJScnLdSTVVvB1GBRdkk4/zwe
         Go/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755550092; x=1756154892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmSFhtkjn050aL3wt4l2QCFwoYpvsEdCYa0KpbEoHWA=;
        b=RY5WlFgAtx8yPC1wUNo0HZZ067y+mgiijpxWNWEfQIwXFRHRXHDOUGdPULm6qdLSUJ
         gya9yXFcYkvU5YOgg5ZZn0dhVxROJdvRw9RuwM1neFWlKUJEGD0H1Q/64oTeuVKHH+y3
         Ws9pKGteUdUwwwhM5dn5JEAluYLrAwnbW6sZsYbTTRN756C6vp8bwVLL1l0U9qMOdtRy
         7vwtvjZebaJeJ4RoJylXhUOAVSFZoFCrS9eCzynCrzu1G++atPGV3u06hJnuMdj5Vt02
         iM7ZraT+s8A9cmELI5Lts1ekfBHD24yMebzBXc6fS6verCOtpbR+XJ5vDwCia0r9Fe2F
         kBpg==
X-Gm-Message-State: AOJu0YzyPQUnaVM1riTTHEHfgwKsL5+ZR3kMXfHXS07qCeo9mwXIyu9g
	Az/JSet8ZKWu3elUznE3EfCRs+e3NNtELQAfnHJMspqUg/OMTG25qh6vMMmdTAXs
X-Gm-Gg: ASbGncvLTcNgZ2p/vL1sH0nlIkUr6V6PK44ehKZ3nWH9z22ztrCdxHdfsFh2iXGONdX
	Hx+wzR/bxrui9bi69R7Gsrgx/wYrYRPEzKHTyh/OfkjPRfF5k+TX7SwW0UrfR+7eCzLck/HMm5N
	S7qL2rBJFVyyUqrOCAt9wIJvbZvAXf4R/AomBXSswJmLfI9r8uLzp7YFhN3TphIAWcRBu0CJL0N
	rxeB7zVpf+lQaaoaO1xiANZAgpTpaXbHIY7MKV6BPKTkuxc3ylSAq25R9IAKBasZf0QpxHyQIcJ
	UI65AfRhqE+c5B3kJACG7LyVVO0DRtnpuY7q3QzXlfDn3Qpq8qz97/sNsNGtjeBEIOPWqP4CsZV
	/hi5xlUMyA7nXsbny6E8u/zL4I2H6VPJiMGgvooXVNF0+c62EjB+3Og0Bi/k6VhqeLOPuOGw/CA
	A=
X-Google-Smtp-Source: AGHT+IGLL4R39P7eW/v63oG9YLEEHe7VaOQzomt9hxTT1st9LX1jE8NW8cV02qfOW8F53utV4LKSgw==
X-Received: by 2002:a05:6122:2204:b0:530:7ab8:49ab with SMTP id 71dfb90a1353d-53b5cedf94amr101676e0c.0.1755550091542;
        Mon, 18 Aug 2025 13:48:11 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53b2bd553casm2101079e0c.2.2025.08.18.13.48.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 13:48:10 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 6/8] Bluetooth: hci: Add hci_conn_set_state
Date: Mon, 18 Aug 2025 16:47:51 -0400
Message-ID: <20250818204753.1203949-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818204753.1203949-1-luiz.dentz@gmail.com>
References: <20250818204753.1203949-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds hci_conn_set_state which prints the state transition of
hci_conn and replaces the direct setting of hci_conn->state.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h | 10 +++++++-
 net/bluetooth/hci_conn.c         | 20 +++++++--------
 net/bluetooth/hci_event.c        | 44 ++++++++++++++++----------------
 net/bluetooth/hci_sync.c         |  6 ++---
 net/bluetooth/iso.c              |  2 +-
 net/bluetooth/sco.c              |  2 +-
 6 files changed, 46 insertions(+), 38 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 66523b74f828..2d082c72937f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1704,6 +1704,14 @@ static inline struct hci_dev *hci_dev_hold(struct hci_dev *d)
 #define to_hci_dev(d) container_of(d, struct hci_dev, dev)
 #define to_hci_conn(c) container_of(c, struct hci_conn, dev)
 
+#define hci_conn_set_state(c, s) \
+	do { \
+		bt_dev_dbg((c)->hdev, "hcon %p handle 0x%04x state %s -> %s", \
+			   (c), (c)->handle, state_to_string((c)->state), \
+			   state_to_string(s)); \
+		(c)->state = s; \
+	} while (0)
+
 static inline void *hci_get_drvdata(struct hci_dev *hdev)
 {
 	return dev_get_drvdata(&hdev->dev);
@@ -2133,7 +2141,7 @@ static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status)
 
 	if (conn->state == BT_CONFIG) {
 		if (!status)
-			conn->state = BT_CONNECTED;
+			hci_conn_set_state(conn, BT_CONNECTED);
 
 		hci_connect_cfm(conn, status);
 		hci_conn_drop(conn);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 9b23865244b4..0bb7142bcac5 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -204,7 +204,7 @@ static void hci_add_sco(struct hci_conn *conn, __u16 handle)
 
 	bt_dev_dbg(hdev, "hcon %p", conn);
 
-	conn->state = BT_CONNECT;
+	hci_conn_set_state(conn, BT_CONNECT);
 	conn->out = true;
 
 	conn->attempt++;
@@ -296,7 +296,7 @@ static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
 
 	configure_datapath_sync(hdev, &conn->codec);
 
-	conn->state = BT_CONNECT;
+	hci_conn_set_state(conn, BT_CONNECT);
 	conn->out = true;
 
 	conn->attempt++;
@@ -413,7 +413,7 @@ static bool hci_setup_sync_conn(struct hci_conn *conn, __u16 handle)
 
 	bt_dev_dbg(hdev, "hcon %p", conn);
 
-	conn->state = BT_CONNECT;
+	hci_conn_set_state(conn, BT_CONNECT);
 	conn->out = true;
 
 	conn->attempt++;
@@ -1311,7 +1311,7 @@ void hci_conn_failed(struct hci_conn *conn, u8 status)
 	test_and_clear_bit(HCI_CONN_BIG_SYNC_FAILED, &conn->flags);
 	test_and_clear_bit(HCI_CONN_PA_SYNC_FAILED, &conn->flags);
 
-	conn->state = BT_CLOSED;
+	hci_conn_set_state(conn, BT_CLOSED);
 	hci_connect_cfm(conn, status);
 	hci_conn_del(conn);
 }
@@ -1582,7 +1582,7 @@ static struct hci_conn *hci_add_bis(struct hci_dev *hdev, bdaddr_t *dst,
 	if (IS_ERR(conn))
 		return conn;
 
-	conn->state = BT_CONNECT;
+	hci_conn_set_state(conn, BT_CONNECT);
 	conn->sid = sid;
 	conn->conn_timeout = timeout;
 
@@ -1633,7 +1633,7 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
 		return ERR_PTR(-EBUSY);
 	}
 
-	conn->state = BT_CONNECT;
+	hci_conn_set_state(conn, BT_CONNECT);
 	set_bit(HCI_CONN_SCANNING, &conn->flags);
 	conn->dst_type = dst_type;
 	conn->sec_level = BT_SECURITY_LOW;
@@ -2131,7 +2131,7 @@ struct hci_conn *hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst,
 	conn->iso_qos = *qos;
 	conn->dst_type = dst_type;
 	conn->sid = sid;
-	conn->state = BT_LISTEN;
+	hci_conn_set_state(conn, BT_LISTEN);
 	conn->conn_timeout = msecs_to_jiffies(qos->bcast.sync_timeout * 10);
 
 	hci_conn_hold(conn);
@@ -2193,7 +2193,7 @@ struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __u8 sid,
 					      HCI_ROLE_MASTER);
 	if (conn) {
 		memcpy(qos, &conn->iso_qos, sizeof(*qos));
-		conn->state = BT_CONNECTED;
+		hci_conn_set_state(conn, BT_CONNECTED);
 		return conn;
 	}
 
@@ -2221,7 +2221,7 @@ struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __u8 sid,
 			  hdev->le_tx_def_phys);
 
 	conn->iso_qos = *qos;
-	conn->state = BT_BOUND;
+	hci_conn_set_state(conn, BT_BOUND);
 
 	/* Link BISes together */
 	parent = hci_conn_hash_lookup_big(hdev,
@@ -2602,7 +2602,7 @@ void hci_conn_hash_flush(struct hci_dev *hdev)
 	while ((conn = list_first_entry_or_null(head,
 						struct hci_conn,
 						list)) != NULL) {
-		conn->state = BT_CLOSED;
+		hci_conn_set_state(conn, BT_CLOSED);
 		hci_disconn_cfm(conn, HCI_ERROR_LOCAL_HOST_TERM);
 		hci_conn_del(conn);
 	}
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6e0c095ef244..c2b3069525c0 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2256,7 +2256,7 @@ static void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
 
 	if (status) {
 		if (conn && conn->state == BT_CONNECT) {
-			conn->state = BT_CLOSED;
+			hci_conn_set_state(conn, BT_CLOSED);
 			hci_connect_cfm(conn, status);
 			hci_conn_del(conn);
 		}
@@ -2299,7 +2299,7 @@ static void hci_cs_add_sco(struct hci_dev *hdev, __u8 status)
 		link = list_first_entry_or_null(&acl->link_list,
 						struct hci_link, list);
 		if (link && link->conn) {
-			link->conn->state = BT_CLOSED;
+			hci_conn_set_state(link->conn, BT_CLOSED);
 
 			hci_connect_cfm(link->conn, status);
 			hci_conn_del(link->conn);
@@ -2582,7 +2582,7 @@ static void hci_setup_sync_conn_status(struct hci_dev *hdev, __u16 handle,
 		link = list_first_entry_or_null(&acl->link_list,
 						struct hci_link, list);
 		if (link && link->conn) {
-			link->conn->state = BT_CLOSED;
+			hci_conn_set_state(link->conn, BT_CLOSED);
 
 			hci_connect_cfm(link->conn, status);
 			hci_conn_del(link->conn);
@@ -3138,7 +3138,7 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 			goto done;
 
 		if (conn->type == ACL_LINK) {
-			conn->state = BT_CONFIG;
+			hci_conn_set_state(conn, BT_CONFIG);
 			hci_conn_hold(conn);
 
 			if (!conn->out && !hci_conn_ssp_enabled(conn) &&
@@ -3147,7 +3147,7 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 			else
 				conn->disc_timeout = HCI_DISCONN_TIMEOUT;
 		} else
-			conn->state = BT_CONNECTED;
+			hci_conn_set_state(conn, BT_CONNECTED);
 
 		hci_debugfs_create_conn(conn);
 		hci_conn_add_sysfs(conn);
@@ -3294,7 +3294,7 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
 	if (ev->link_type == ACL_LINK ||
 	    (!(flags & HCI_PROTO_DEFER) && !lmp_esco_capable(hdev))) {
 		struct hci_cp_accept_conn_req cp;
-		conn->state = BT_CONNECT;
+		hci_conn_set_state(conn, BT_CONNECT);
 
 		bacpy(&cp.bdaddr, &ev->bdaddr);
 
@@ -3306,7 +3306,7 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
 		hci_send_cmd(hdev, HCI_OP_ACCEPT_CONN_REQ, sizeof(cp), &cp);
 	} else if (!(flags & HCI_PROTO_DEFER)) {
 		struct hci_cp_accept_sync_conn_req cp;
-		conn->state = BT_CONNECT;
+		hci_conn_set_state(conn, BT_CONNECT);
 
 		bacpy(&cp.bdaddr, &ev->bdaddr);
 		cp.pkt_type = cpu_to_le16(conn->pkt_type);
@@ -3320,7 +3320,7 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
 		hci_send_cmd(hdev, HCI_OP_ACCEPT_SYNC_CONN_REQ, sizeof(cp),
 			     &cp);
 	} else {
-		conn->state = BT_CONNECT2;
+		hci_conn_set_state(conn, BT_CONNECT2);
 		hci_connect_cfm(conn, 0);
 	}
 
@@ -3368,7 +3368,7 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	conn->state = BT_CLOSED;
+	hci_conn_set_state(conn, BT_CLOSED);
 
 	mgmt_connected = test_and_clear_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags);
 
@@ -3472,7 +3472,7 @@ static void hci_auth_complete_evt(struct hci_dev *hdev, void *data,
 			hci_send_cmd(hdev, HCI_OP_SET_CONN_ENCRYPT, sizeof(cp),
 				     &cp);
 		} else {
-			conn->state = BT_CONNECTED;
+			hci_conn_set_state(conn, BT_CONNECTED);
 			hci_connect_cfm(conn, ev->status);
 			hci_conn_drop(conn);
 		}
@@ -3708,7 +3708,7 @@ static void hci_remote_features_evt(struct hci_dev *hdev, void *data,
 	}
 
 	if (!hci_outgoing_auth_needed(hdev, conn)) {
-		conn->state = BT_CONNECTED;
+		hci_conn_set_state(conn, BT_CONNECTED);
 		hci_connect_cfm(conn, ev->status);
 		hci_conn_drop(conn);
 	}
@@ -4249,7 +4249,7 @@ static void hci_cs_le_create_cis(struct hci_dev *hdev, u8 status)
 			if (test_and_clear_bit(HCI_CONN_CREATE_CIS,
 					       &conn->flags))
 				pending = true;
-			conn->state = BT_CLOSED;
+			hci_conn_set_state(conn, BT_CLOSED);
 			hci_connect_cfm(conn, status);
 			hci_conn_del(conn);
 		}
@@ -4879,7 +4879,7 @@ static void hci_remote_ext_features_evt(struct hci_dev *hdev, void *data,
 	}
 
 	if (!hci_outgoing_auth_needed(hdev, conn)) {
-		conn->state = BT_CONNECTED;
+		hci_conn_set_state(conn, BT_CONNECTED);
 		hci_connect_cfm(conn, ev->status);
 		hci_conn_drop(conn);
 	}
@@ -4946,7 +4946,7 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev, void *data,
 	case 0x00:
 		status = hci_conn_set_handle(conn, __le16_to_cpu(ev->handle));
 		if (status) {
-			conn->state = BT_CLOSED;
+			hci_conn_set_state(conn, BT_CLOSED);
 			break;
 		}
 
@@ -4974,7 +4974,7 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev, void *data,
 		fallthrough;
 
 	default:
-		conn->state = BT_CLOSED;
+		hci_conn_set_state(conn, BT_CLOSED);
 		break;
 	}
 
@@ -5107,7 +5107,7 @@ static void hci_key_refresh_complete_evt(struct hci_dev *hdev, void *data,
 
 	if (conn->state == BT_CONFIG) {
 		if (!ev->status)
-			conn->state = BT_CONNECTED;
+			hci_conn_set_state(conn, BT_CONNECTED);
 
 		hci_connect_cfm(conn, ev->status);
 		hci_conn_drop(conn);
@@ -5706,7 +5706,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	mgmt_device_connected(hdev, conn, NULL, 0);
 
 	conn->sec_level = BT_SECURITY_LOW;
-	conn->state = BT_CONFIG;
+	hci_conn_set_state(conn, BT_CONFIG);
 
 	/* Store current advertising instance as connection advertising instance
 	 * when software rotation is in use so it can be re-enabled when
@@ -5742,7 +5742,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 
 		hci_conn_hold(conn);
 	} else {
-		conn->state = BT_CONNECTED;
+		hci_conn_set_state(conn, BT_CONNECTED);
 		hci_connect_cfm(conn, status);
 	}
 
@@ -6475,7 +6475,7 @@ static void hci_le_remote_feat_complete_evt(struct hci_dev *hdev, void *data,
 			else
 				status = ev->status;
 
-			conn->state = BT_CONNECTED;
+			hci_conn_set_state(conn, BT_CONNECTED);
 			hci_connect_cfm(conn, status);
 			hci_conn_drop(conn);
 		}
@@ -6759,14 +6759,14 @@ static void hci_le_cis_established_evt(struct hci_dev *hdev, void *data,
 	}
 
 	if (!ev->status) {
-		conn->state = BT_CONNECTED;
+		hci_conn_set_state(conn, BT_CONNECTED);
 		hci_debugfs_create_conn(conn);
 		hci_conn_add_sysfs(conn);
 		hci_iso_setup_path(conn);
 		goto unlock;
 	}
 
-	conn->state = BT_CLOSED;
+	hci_conn_set_state(conn, BT_CLOSED);
 	hci_connect_cfm(conn, ev->status);
 	hci_conn_del(conn);
 
@@ -6884,7 +6884,7 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 					__le16_to_cpu(ev->bis_handle[i++])))
 			continue;
 
-		conn->state = BT_CONNECTED;
+		hci_conn_set_state(conn, BT_CONNECTED);
 		set_bit(HCI_CONN_BIG_CREATED, &conn->flags);
 		hci_debugfs_create_conn(conn);
 		hci_conn_add_sysfs(conn);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 46c20476dae5..5faee247920e 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5682,7 +5682,7 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 	 * safely.
 	 */
 	if (disconnect) {
-		conn->state = BT_CLOSED;
+		hci_conn_set_state(conn, BT_CLOSED);
 		hci_disconn_cfm(conn, reason);
 		hci_conn_del(conn);
 	} else {
@@ -6518,7 +6518,7 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 	bt_dev_dbg(hdev, "conn %p", conn);
 
 	clear_bit(HCI_CONN_SCANNING, &conn->flags);
-	conn->state = BT_CONNECT;
+	hci_conn_set_state(conn, BT_CONNECT);
 
 	/* If requested to connect as peripheral use directed advertising */
 	if (conn->role == HCI_ROLE_SLAVE) {
@@ -6858,7 +6858,7 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 			bt_dev_warn(hdev, "Failed to cancel inquiry %d", err);
 	}
 
-	conn->state = BT_CONNECT;
+	hci_conn_set_state(conn, BT_CONNECT);
 	conn->out = true;
 	conn->role = HCI_ROLE_MASTER;
 
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 5c68c0ea7d97..8d2127c15b2d 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1462,7 +1462,7 @@ static void iso_conn_defer_accept(struct hci_conn *conn)
 
 	BT_DBG("conn %p", conn);
 
-	conn->state = BT_CONFIG;
+	hci_conn_set_state(conn, BT_CONFIG);
 
 	cp.handle = cpu_to_le16(conn->handle);
 
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index d382d980fd9a..dc079d1b03f2 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -830,7 +830,7 @@ static void sco_conn_defer_accept(struct hci_conn *conn, u16 setting)
 
 	BT_DBG("conn %p", conn);
 
-	conn->state = BT_CONFIG;
+	hci_conn_set_state(conn, BT_CONFIG);
 
 	if (!lmp_esco_capable(hdev)) {
 		struct hci_cp_accept_conn_req cp;
-- 
2.50.1

