Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE97215F5C
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Oct 2025 22:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759702688; cv=pass; b=gnkRekYuedBqBURnpgQD4EdjOSZhrX9gaWphabyu4HtLVHy51yt7HFiY+3E4QOa6ncT1R5qjZYpLK4zOkeuOu1+TkbwDnzLWBF0PlMFolVY5qlOT4ivmZaYIbhG6T0O23/4joWNOeW1oX2PnYLZWjSO+qbxYm930wN/OCaqdYQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759702688; c=relaxed/simple;
	bh=hVIBeBvWoxIRhyRFcmrSF7uZYKZqjDHWzZ7Huy2OnvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cl393/3Fn+ur5z6F2N2DLHojSl725eWgwa/y3JJH/uRomDKZKYocTXlAjNWox+T/DdswhC9NOvvWvKgH22DULZALOUIQl7uO/JSOfLTmnO0QtKFY4SaoMJI9Tzbpvz2X6982f/4GFNPkXcOBaO6qMKstELj9gFVe+aQ5TS5qIWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=UgkuGza4; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="UgkuGza4"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cfxc05njczyfw;
	Mon,  6 Oct 2025 01:17:52 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1759702673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3owxUhlMIn4gfalbEjTYR3Dto2U/j5B2h3G5RpnjDSs=;
	b=UgkuGza4C4uQfQ5emEPuOhPJaWc+nvnxc8KYJqE7LIkshouwKsOl7Nst1A329NrdODC7ou
	A6PxZLIk8/qmKRUyAaBQ3bYm4tPDByoODKVTvrii/2v3t3YBXydspb6PlrgDLs3HY2DQQY
	YuB1wWrVCOFR5+bTBAMLyS1aqe9oG5c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1759702673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3owxUhlMIn4gfalbEjTYR3Dto2U/j5B2h3G5RpnjDSs=;
	b=FOxT0csQDEdn7favdG8WWO7GmpjrOdYNPFiG+k0WXrncRv4lW1+0NOHn/0anyT22rtWwGK
	pdJu1M9uzB7H22iuRX4S6VNmkWng0JHlFiPp0szydGOKsO/h1xIAijEYVxiz9l5oKUOkAm
	39wQl0OUydeLeKs46Gv+sb8FLGXphHc=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1759702673; a=rsa-sha256; cv=none;
	b=DDhnIduHPi1kAKsYpctQtKmrFtc2PvcBOtQLJTNaTWJH25qOAtopNH1M9FbB24E8v0iWFE
	zPNTgKtp4GXa3tc/xiiSXZaHtCff9v3md8dZsGtf4AaZ7P6AU+CfcmsQdkA8ZwjkBSPAIJ
	1JGRh2JeEqvcuzS1YXCD02LmbXTI92g=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/4] bthost: handle L2CAP_DISCONN_RSP and remove l2cap_conns
Date: Mon,  6 Oct 2025 01:17:39 +0300
Message-ID: <8c38a793c1016bbf49d90b89cf4df2fc8b6419a8.1759702519.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1759702519.git.pav@iki.fi>
References: <cover.1759702519.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle L2CAP disconnection response. On receiving disconnection request
or response, remove the associated connection.

Change disconnect handler signature to take also the handle and CID.
---
 emulator/bthost.c    | 61 +++++++++++++++++++++++++++++++++++++++++++-
 emulator/bthost.h    |  6 ++++-
 tools/l2cap-tester.c |  3 ++-
 3 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index c85f751cc..93023331e 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -403,6 +403,25 @@ static struct l2conn *bthost_add_l2cap_conn(struct bthost *bthost,
 	return l2conn;
 }
 
+static void btconn_detach_l2cap_conn(struct btconn *conn, struct l2conn *l2conn)
+{
+	struct l2conn *c;
+
+	if (conn->l2conns == l2conn) {
+		conn->l2conns = l2conn->next;
+		l2conn->next = NULL;
+		return;
+	}
+
+	for (c = conn->l2conns; c != NULL; c = c->next) {
+		if (c->next == l2conn) {
+			c->next = l2conn->next;
+			l2conn->next = NULL;
+			return;
+		}
+	}
+}
+
 static struct rcconn *bthost_add_rfcomm_conn(struct bthost *bthost,
 						struct btconn *conn,
 						struct l2conn *l2conn,
@@ -2142,11 +2161,41 @@ static bool l2cap_disconn_req(struct bthost *bthost, struct btconn *conn,
 	if (!l2conn)
 		return true;
 
+	btconn_detach_l2cap_conn(conn, l2conn);
+
 	cb_data = bthost_find_l2cap_cb_by_psm(bthost, l2conn->psm);
 
 	if (cb_data && cb_data->disconn_func)
-		cb_data->disconn_func(cb_data->user_data);
+		cb_data->disconn_func(conn->handle, l2conn->dcid,
+							cb_data->user_data);
 
+	l2conn_free(l2conn);
+	return true;
+}
+
+static bool l2cap_disconn_rsp(struct bthost *bthost, struct btconn *conn,
+				uint8_t ident, const void *data, uint16_t len)
+{
+	const struct bt_l2cap_pdu_disconn_rsp *rsp = data;
+	struct l2cap_conn_cb_data *cb_data;
+	struct l2conn *l2conn;
+
+	if (len < sizeof(*rsp))
+		return false;
+
+	l2conn = btconn_find_l2cap_conn_by_scid(conn, rsp->dcid);
+	if (!l2conn)
+		return true;
+
+	btconn_detach_l2cap_conn(conn, l2conn);
+
+	cb_data = bthost_find_l2cap_cb_by_psm(bthost, l2conn->psm);
+
+	if (cb_data && cb_data->disconn_func)
+		cb_data->disconn_func(conn->handle, l2conn->dcid,
+							cb_data->user_data);
+
+	l2conn_free(l2conn);
 	return true;
 }
 
@@ -2302,6 +2351,11 @@ static void l2cap_sig(struct bthost *bthost, struct btconn *conn,
 						data + sizeof(*hdr), hdr_len);
 		break;
 
+	case BT_L2CAP_PDU_DISCONN_RSP:
+		ret = l2cap_disconn_rsp(bthost, conn, hdr->ident,
+						data + sizeof(*hdr), hdr_len);
+		break;
+
 	case BT_L2CAP_PDU_INFO_REQ:
 		ret = l2cap_info_req(bthost, conn, hdr->ident,
 						data + sizeof(*hdr), hdr_len);
@@ -2536,6 +2590,11 @@ static void l2cap_le_sig(struct bthost *bthost, struct btconn *conn,
 						data + sizeof(*hdr), hdr_len);
 		break;
 
+	case BT_L2CAP_PDU_DISCONN_RSP:
+		ret = l2cap_disconn_rsp(bthost, conn, hdr->ident,
+						data + sizeof(*hdr), hdr_len);
+		break;
+
 	case BT_L2CAP_PDU_CONN_PARAM_REQ:
 		ret = l2cap_conn_param_req(bthost, conn, hdr->ident,
 						data + sizeof(*hdr), hdr_len);
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 743615838..d60111d25 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -99,6 +99,9 @@ void bthost_send_iso(struct bthost *bthost, uint16_t handle, bool ts,
 			uint16_t sn, uint32_t timestamp, uint8_t pkt_status,
 			const struct iovec *iov, int iovcnt);
 
+void bthost_disconnect_cid(struct bthost *bthost, uint16_t handle,
+								uint16_t cid);
+
 typedef void (*bthost_l2cap_rsp_cb) (uint8_t code, const void *data,
 						uint16_t len, void *user_data);
 
@@ -145,7 +148,8 @@ void bthost_le_start_encrypt(struct bthost *bthost, uint16_t handle,
 							const uint8_t ltk[16]);
 typedef void (*bthost_l2cap_connect_cb) (uint16_t handle, uint16_t cid,
 							void *user_data);
-typedef void (*bthost_l2cap_disconnect_cb) (void *user_data);
+typedef void (*bthost_l2cap_disconnect_cb) (uint16_t handle, uint16_t cid,
+							void *user_data);
 
 void bthost_add_l2cap_server(struct bthost *bthost, uint16_t psm,
 				bthost_l2cap_connect_cb func,
diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 208772527..a9ab8b051 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -1726,7 +1726,8 @@ static void client_l2cap_connect_cb(uint16_t handle, uint16_t cid,
 	data->handle = handle;
 }
 
-static void client_l2cap_disconnect_cb(void *user_data)
+static void client_l2cap_disconnect_cb(uint16_t handle, uint16_t cid,
+							void *user_data)
 {
 	struct test_data *data = user_data;
 
-- 
2.51.0

