Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE2B23AD
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Oct 2025 22:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759702687; cv=pass; b=bhiBSFm4J6PotOVKSUy7KnosWpfNrl2ZRI+qLRM+fUZbblezw2tGHBath1uRyYghHTZixwEa48Q+99U3vC2Mz6RaEgU3P29n1u2jUSUP1npxWl679JcguKUK5hDsY2QGxCANF61AORBHLAtVeOPqYpcrFa7KtiPiebHs1fVJIkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759702687; c=relaxed/simple;
	bh=8ogof8PWNCLR9gHa6iWbBUIHLKcaMR34i0XA6wXhqOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmGTdX9hUhuldPQYhIlatgPkkqzHMuSVvcwFYNm8azLUM2WQNAT6z+hmHjPQ8dCX0MUudSibtpwJuiMo3xujd2MjyAUtMq9dOM/uIPy7GDfWIC8QdqoGS7INZWaLT9omGwRy7ZV2zhT/TGOWAmJDWBowF0/6F5/2DHEohkCwu4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=JFVrS4rX; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="JFVrS4rX"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cfxc544hczyj9;
	Mon,  6 Oct 2025 01:17:57 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1759702677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GxWGpbwR0mtsnY8fRbHEz0rp7rcb4611gBGy1fLDyN8=;
	b=JFVrS4rXPb0LFsbKbfNgA4D6nSeWJdXMEJy9CzFaF3VuMC393xnUXBcb6nzTC72aA5TowL
	6fkXg8XW2JhlQXkKQlSzFKZBa3AjgxSmnED4KHKicxvoMxBd2EFaHBUqajyIWc/U4wZzzj
	clPQI/9rlAY9dGQ9W+042oBD1xYEJXg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1759702677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GxWGpbwR0mtsnY8fRbHEz0rp7rcb4611gBGy1fLDyN8=;
	b=aB7eKgu4I4Fw084wlR7JlH8IJYOCNuoQQtcrVLEBekVFaMW4LTfg/MV/Ppsaz1VSoLtiYe
	5VPQHTExuoU5sjMCM2Y3qXxmOIg0e+LMuYWrm66UHoU3X9u31XOQYbFbXD/Xj8KntPg62K
	nRkQeM0EVimATxUMp5ILp3nEHRs/dvU=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1759702677; a=rsa-sha256; cv=none;
	b=KoZShW1rOWq0/dFXPVvkr7SqYJ4/gXSImSpggnWjOSjtLlc2VuK6HuedlDVLoNZcMtZ2rj
	rsFKRdgusgxW5G/siNJfkJW5R0k+G3DT2tqeEqTwq4lh8zBKyY9Qe0LkFO9ZN8QV4Ka31L
	y8y1p6E9k1fp7HSXf37/OR8WV4g2xU0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/4] bthost: handle L2CAP_FLOW_CONTROL_CREDIT_IND
Date: Mon,  6 Oct 2025 01:17:40 +0300
Message-ID: <061a61187f3dbd1d1c2f31cc5a73e0f40f6a95ea.1759702519.git.pav@iki.fi>
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

Parse L2CAP_FLOW_CONTROL_CREDIT_IND and track credits, instead of
sending reject response.  Nothing is done with the credit counts
currently.
---
 emulator/bthost.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 93023331e..b00f8f2b6 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -184,6 +184,8 @@ struct l2conn {
 	uint16_t scid;
 	uint16_t dcid;
 	uint16_t psm;
+	uint16_t rx_credits;
+	uint16_t tx_credits;
 	enum l2cap_mode mode;
 	uint16_t data_len;
 	uint16_t recv_len;
@@ -2459,6 +2461,8 @@ static bool l2cap_le_conn_req(struct bthost *bthost, struct btconn *conn,
 							le16_to_cpu(req->scid),
 							le16_to_cpu(psm));
 		l2conn->mode = L2CAP_MODE_LE_CRED;
+		l2conn->rx_credits = le16_to_cpu(rsp.credits);
+		l2conn->tx_credits = le16_to_cpu(req->credits);
 
 		if (cb_data && l2conn->psm == cb_data->psm && cb_data->func)
 			cb_data->func(conn->handle, l2conn->dcid,
@@ -2476,10 +2480,13 @@ static bool l2cap_le_conn_rsp(struct bthost *bthost, struct btconn *conn,
 
 	if (len < sizeof(*rsp))
 		return false;
+
 	/* TODO add L2CAP connection before with proper PSM */
 	l2conn = bthost_add_l2cap_conn(bthost, conn, 0,
 						le16_to_cpu(rsp->dcid), 0);
 	l2conn->mode = L2CAP_MODE_LE_CRED;
+	l2conn->rx_credits = 1;
+	l2conn->tx_credits = le16_to_cpu(rsp->credits);
 
 	return true;
 }
@@ -2544,12 +2551,32 @@ static bool l2cap_ecred_conn_rsp(struct bthost *bthost, struct btconn *conn,
 		l2conn = bthost_add_l2cap_conn(bthost, conn, 0,
 				      le16_to_cpu(rsp->scid[i]), 0);
 		l2conn->mode = L2CAP_MODE_LE_ENH_CRED;
+		l2conn->tx_credits = rsp->pdu->credits;
+		l2conn->rx_credits = 1;
 	}
 
 
 	return true;
 }
 
+static bool l2cap_le_flowctl_creds(struct bthost *bthost, struct btconn *conn,
+				uint8_t ident, const void *data, uint16_t len)
+{
+	const struct bt_l2cap_pdu_le_flowctl_creds *ind = data;
+	struct l2conn *l2conn;
+
+	if (len < sizeof(*ind))
+		return false;
+
+	l2conn = btconn_find_l2cap_conn_by_dcid(conn, ind->cid);
+	if (!l2conn)
+		return true;
+
+	l2conn->tx_credits += ind->credits;
+
+	return true;
+}
+
 static bool l2cap_le_rsp(uint8_t code)
 {
 	switch (code) {
@@ -2624,6 +2651,11 @@ static void l2cap_le_sig(struct bthost *bthost, struct btconn *conn,
 						data + sizeof(*hdr), hdr_len);
 		break;
 
+	case BT_L2CAP_PDU_LE_FLOWCTL_CREDS:
+		ret = l2cap_le_flowctl_creds(bthost, conn, hdr->ident,
+						data + sizeof(*hdr), hdr_len);
+		break;
+
 	default:
 		bthost_debug(bthost, "Unknown L2CAP code 0x%02x", hdr->code);
 		ret = false;
-- 
2.51.0

