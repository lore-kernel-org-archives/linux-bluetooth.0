Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037B42620D2
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Aug 2025 21:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755294270; cv=none; b=VbfBgpVm9UfuLOB91coG6AT2TshQGFlQ8oeF0VF8tinEc9XPBhn08vJK0bLHWiNrWVCqhkEnabInF4wNoztu43HSuPLNpczIxd0QTR4DkSjLaJqYC6AD4+rrAXnKLfKP8BGV5p4PluD3NQUwTCZda+XK4BM62IqUDlBp/ohHZlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755294270; c=relaxed/simple;
	bh=FCgRyf7fkhSIt/PnukmzqPe9gvPIlqdHmLp/dYwAd5I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eyRdUiUY1/PmS2ja4pXhqGz9ta8bL6di5UTqQFHifKAhWVF5ypA8s48ej/q51WiXswvpIpgarAzVYUGgHQco5q1npKehyHRhFLQaHqPBCdISMWuo374J94N9PPvqUkHFpMB4MGEzv1ujWeE76aqP5IpSBwvozhqJeBa3Q6D0qTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4WqKRO8; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4WqKRO8"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-53b17558b2fso1652790e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Aug 2025 14:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755294267; x=1755899067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+9QP8Eav9QJZ2JhPx2wUEwF70ZrCpU7aUVJOj8yl00=;
        b=i4WqKRO8ZibK8e5WOMQMhoMj415g8+hYyCHFnhZ8x2nMOBiCSCe2Ql4efehgDR/DPg
         ty3FJJnWih93xxO/J7lI+kiqf8tRzwzvAzMdAE2gw6zgwRHqD2nm7GQ7ZWctzOL3EaJf
         kWR3lAOk73oLJtwZfQNVEyx2fFEl8ha3sbPQxl81xcP/acxz27IK6BLIbW50ZVE5vnxt
         cvKVuwjzGn3wg39RNtf35QnOSD4g4vcMYwQrQMlRlVtpTFQG2aTM2Lj/lZNitdEXzdSH
         UMSPw/MZ68Kx0J6EpLx1nyqqYqs0/t838n/Nbvl3U3aqgIsQjDewcACWkNfYQQE5kqAS
         r/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755294267; x=1755899067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+9QP8Eav9QJZ2JhPx2wUEwF70ZrCpU7aUVJOj8yl00=;
        b=MoSt0xuKs0osIrbhHB26I+xO3zX6PZDIDSq/THoWnsSlS0gZJIr6jCCJlhZ/JIJaZJ
         1s6tfk9VXfOoTGoLNOni15nSJBTiLM/fsvnxVkPMqHwFbUNaH2uApkoOFHmUKFyNsLZm
         3t5lbt/t94UyvU4GZuWN2YdjA6vh8f2leLJew9bxSjuXGC5sncTBqb1I60Rb+KuFjj2R
         31b6Z6YvtNo7g17CpWRq6ZvXcog9chEIH48pJIfk/iux1Iu6ymFsXGo1l1GNyX9OaWyv
         UXYdg0OKmc5WZb2ISb+j9r+M0Wsa9y7pJww8B++d/FB8ivWobyavM/XaaZqK5NEBz7IN
         a67g==
X-Gm-Message-State: AOJu0Yz8RHA5M2Nnh737NFUGnKx8nFD+N0Sm0h2Q0vILvyaTvxGlMEEA
	zWQ5JOtFm4vRxd4kFiQJSPhzQOjJKDQshGuV6g2L4zs21+4pIb18h+S6zere0emp
X-Gm-Gg: ASbGncszNVW1IToTH2AYUDqEjIUgzlhTJppM9BDV2/bOsp+oYEPzyGiZ9XLbgBhxi7U
	LK1m6h8dBihzMxZ46EAJFbnJnqF8RDigZNYRMPqb6Q7qTHTxtmiahve0ZbUrfcmWu/xFaDh+9ya
	HdC78cd05fc5otwS4/7nEOZdYO5qghxiUZUArogK8vjC1oAGwKJsbP9S++oRnQ8cwukYo0fbLr0
	RUZRPTEINvdWjEsQ7xj0R4DXYFucAh/NOMgKqqbmq4wXXgW+FDsfQPMdfj2v/Jtmz7E7GHtIHT1
	bVi7utWS92pbdXYzwafUvPRcL/5xgM8yT9VANo3S7LU9/SJQbofYsLV3gn6z8rDnPZbSiCmtqdt
	V2pErhbrw62fHcIxEjj86fTw9rjL9CAawsIJErbYJ6y3kOZSgLm/YMMRJoIyYOiyeuh2KyH/jk9
	Q=
X-Google-Smtp-Source: AGHT+IEMguousXtBVVgCgrFi9ZH07wrTXFD3e7Y3z0NZ7ls4vXjVUEhWhvk4pgMQe7lq16Wb2AdXhA==
X-Received: by 2002:a05:6122:c90:b0:534:69b3:a230 with SMTP id 71dfb90a1353d-53b353a8668mr336711e0c.11.1755294267158;
        Fri, 15 Aug 2025 14:44:27 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53b2beff1c1sm472053e0c.24.2025.08.15.14.44.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 14:44:25 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 6/6] Bluetooth: hci: Add hci_conn_set_state
Date: Fri, 15 Aug 2025 17:44:05 -0400
Message-ID: <20250815214406.514260-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815214406.514260-1-luiz.dentz@gmail.com>
References: <20250815214406.514260-1-luiz.dentz@gmail.com>
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
index 6906af7a8f24..1f1e12d329b1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1701,6 +1701,14 @@ static inline struct hci_dev *hci_dev_hold(struct hci_dev *d)
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
@@ -2130,7 +2138,7 @@ static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status)
 
 	if (conn->state == BT_CONFIG) {
 		if (!status)
-			conn->state = BT_CONNECTED;
+			hci_conn_set_state(conn, BT_CONNECTED);
 
 		hci_connect_cfm(conn, status);
 		hci_conn_drop(conn);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 2cafdc2d6f2b..53ff7eda082c 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -206,7 +206,7 @@ static void hci_add_sco(struct hci_conn *conn, __u16 handle)
 
 	bt_dev_dbg(hdev, "hcon %p", conn);
 
-	conn->state = BT_CONNECT;
+	hci_conn_set_state(conn, BT_CONNECT);
 	conn->out = true;
 
 	conn->attempt++;
@@ -298,7 +298,7 @@ static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
 
 	configure_datapath_sync(hdev, &conn->codec);
 
-	conn->state = BT_CONNECT;
+	hci_conn_set_state(conn, BT_CONNECT);
 	conn->out = true;
 
 	conn->attempt++;
@@ -415,7 +415,7 @@ static bool hci_setup_sync_conn(struct hci_conn *conn, __u16 handle)
 
 	bt_dev_dbg(hdev, "hcon %p", conn);
 
-	conn->state = BT_CONNECT;
+	hci_conn_set_state(conn, BT_CONNECT);
 	conn->out = true;
 
 	conn->attempt++;
@@ -1288,7 +1288,7 @@ void hci_conn_failed(struct hci_conn *conn, u8 status)
 	test_and_clear_bit(HCI_CONN_BIG_SYNC_FAILED, &conn->flags);
 	test_and_clear_bit(HCI_CONN_PA_SYNC_FAILED, &conn->flags);
 
-	conn->state = BT_CLOSED;
+	hci_conn_set_state(conn, BT_CLOSED);
 	hci_connect_cfm(conn, status);
 	hci_conn_del(conn);
 }
@@ -1559,7 +1559,7 @@ static struct hci_conn *hci_add_bis(struct hci_dev *hdev, bdaddr_t *dst,
 	if (IS_ERR(conn))
 		return conn;
 
-	conn->state = BT_CONNECT;
+	hci_conn_set_state(conn, BT_CONNECT);
 	conn->sid = sid;
 
 	hci_conn_hold(conn);
@@ -1609,7 +1609,7 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
 		return ERR_PTR(-EBUSY);
 	}
 
-	conn->state = BT_CONNECT;
+	hci_conn_set_state(conn, BT_CONNECT);
 	set_bit(HCI_CONN_SCANNING, &conn->flags);
 	conn->dst_type = dst_type;
 	conn->sec_level = BT_SECURITY_LOW;
@@ -2105,7 +2105,7 @@ struct hci_conn *hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst,
 	conn->iso_qos = *qos;
 	conn->dst_type = dst_type;
 	conn->sid = sid;
-	conn->state = BT_LISTEN;
+	hci_conn_set_state(conn, BT_LISTEN);
 	conn->conn_timeout = msecs_to_jiffies(qos->bcast.sync_timeout * 10);
 
 	hci_conn_hold(conn);
@@ -2167,7 +2167,7 @@ struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __u8 sid,
 					      HCI_ROLE_MASTER);
 	if (conn) {
 		memcpy(qos, &conn->iso_qos, sizeof(*qos));
-		conn->state = BT_CONNECTED;
+		hci_conn_set_state(conn, BT_CONNECTED);
 		return conn;
 	}
 
@@ -2195,7 +2195,7 @@ struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __u8 sid,
 			  hdev->le_tx_def_phys);
 
 	conn->iso_qos = *qos;
-	conn->state = BT_BOUND;
+	hci_conn_set_state(conn, BT_BOUND);
 
 	/* Link BISes together */
 	parent = hci_conn_hash_lookup_big(hdev,
@@ -2575,7 +2575,7 @@ void hci_conn_hash_flush(struct hci_dev *hdev)
 	while ((conn = list_first_entry_or_null(head,
 						struct hci_conn,
 						list)) != NULL) {
-		conn->state = BT_CLOSED;
+		hci_conn_set_state(conn, BT_CLOSED);
 		hci_disconn_cfm(conn, HCI_ERROR_LOCAL_HOST_TERM);
 		hci_conn_del(conn);
 	}
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 34b243c26bbd..ea062df6cc8d 100644
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
@@ -4889,7 +4889,7 @@ static void hci_remote_ext_features_evt(struct hci_dev *hdev, void *data,
 	}
 
 	if (!hci_outgoing_auth_needed(hdev, conn)) {
-		conn->state = BT_CONNECTED;
+		hci_conn_set_state(conn, BT_CONNECTED);
 		hci_connect_cfm(conn, ev->status);
 		hci_conn_drop(conn);
 	}
@@ -4956,7 +4956,7 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev, void *data,
 	case 0x00:
 		status = hci_conn_set_handle(conn, __le16_to_cpu(ev->handle));
 		if (status) {
-			conn->state = BT_CLOSED;
+			hci_conn_set_state(conn, BT_CLOSED);
 			break;
 		}
 
@@ -4984,7 +4984,7 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev, void *data,
 		fallthrough;
 
 	default:
-		conn->state = BT_CLOSED;
+		hci_conn_set_state(conn, BT_CLOSED);
 		break;
 	}
 
@@ -5117,7 +5117,7 @@ static void hci_key_refresh_complete_evt(struct hci_dev *hdev, void *data,
 
 	if (conn->state == BT_CONFIG) {
 		if (!ev->status)
-			conn->state = BT_CONNECTED;
+			hci_conn_set_state(conn, BT_CONNECTED);
 
 		hci_connect_cfm(conn, ev->status);
 		hci_conn_drop(conn);
@@ -5716,7 +5716,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	mgmt_device_connected(hdev, conn, NULL, 0);
 
 	conn->sec_level = BT_SECURITY_LOW;
-	conn->state = BT_CONFIG;
+	hci_conn_set_state(conn, BT_CONFIG);
 
 	/* Store current advertising instance as connection advertising instance
 	 * when software rotation is in use so it can be re-enabled when
@@ -5752,7 +5752,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 
 		hci_conn_hold(conn);
 	} else {
-		conn->state = BT_CONNECTED;
+		hci_conn_set_state(conn, BT_CONNECTED);
 		hci_connect_cfm(conn, status);
 	}
 
@@ -6485,7 +6485,7 @@ static void hci_le_remote_feat_complete_evt(struct hci_dev *hdev, void *data,
 			else
 				status = ev->status;
 
-			conn->state = BT_CONNECTED;
+			hci_conn_set_state(conn, BT_CONNECTED);
 			hci_connect_cfm(conn, status);
 			hci_conn_drop(conn);
 		}
@@ -6769,14 +6769,14 @@ static void hci_le_cis_established_evt(struct hci_dev *hdev, void *data,
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
 
@@ -6894,7 +6894,7 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
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
index 5ce823ca3aaf..91233fb50509 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1451,7 +1451,7 @@ static void iso_conn_defer_accept(struct hci_conn *conn)
 
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

