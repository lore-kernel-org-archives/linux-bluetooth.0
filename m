Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E05A1F5821
	for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 19:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788119931; cv=pass; b=hrDqfO4vDFbFiiOpFdK+UUkOsU31z8otyynIo5entSzHs+GQkEtcta/BaWfSF7juqVwlOMIp+ZgHy0BF8bSsHqJ2UUH3bLonp7/Ybyo/tpAbw62ooZ8wDXS+booQTM77u+5rXATeQNVTZzkmeRYgz3yXCXj8oAWFaulsbcqljiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788119931; c=relaxed/simple;
	bh=5CbJwnx0CCfJRugRqyeb/2pYUjXFLpS0Wq9vjFQXthg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q9L+olOxvQTaDDQOp/kugPUPgngarF0qbq8fzIDI0urtEAdavNW4K0vBWX+JoamflK679aaku0ueKqNqghX0BYAlsr+tOhFeuZwfKQ2pZtCTFKsqodMbglQx06wuTwB7g62AVolPaZ20kj8Wu6dDy8yFHvdA+Ex1UieyIebqEbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=pSb55cog; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="pSb55cog"
Received: from monolith.lan (unknown [IPv6:2a02:6ea0:1508:6::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hY2xZ3CgCzyVm;
	Sun, 30 Aug 2026 22:58:42 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788119922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d5oa4dZUkC3HKCldBnEAdXLgTYHKmOlTqsTuE6yMuyY=;
	b=pSb55cogpypTO+ztGqk7XOvqowzPMqiaYfTl3IIKZoFxBYKvfsxOl0HjgHdVUTZj0nVYhA
	pLt+cFdbRvqNjvGQskaDNxQhopRNTKW0neMM25j6DS5Olyw0/V95hotCD6zq8kNEVtXVX8
	o/O3Y0C54LwRDtBW5APX0fNENDr17bQ=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788119922;
	b=qbj1B6zo4+OK26TJ/vmnuCQ2a0neEQV9+1DhQr8K2tzB9HkVrMVnlm2dxPPH8bZebdF9mH
	RNBeLzS50jnpv1rsuEzLXZu54stDdxourtp5bJc3kdFAs2NIJ0tZdsqpu2ckAQ3DopICpd
	j9YZCVj1KJOZs/nqeYP2yhp61iazJu8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788119922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d5oa4dZUkC3HKCldBnEAdXLgTYHKmOlTqsTuE6yMuyY=;
	b=uoOV3bFaa9ru08ZTBEMbERE868ob2t0XmUCwI/3j5l48T7f4mTwJZJ6gF/xCBMwxudRer+
	YxOvD8BszEWd/PhIiipgx8sOB1P1V7Z1ZTbpmpRUZeJSsFW9e2rZnJ/Bm2gWAagtjazcLp
	Jt8FEeWNkwBuIspBeNXtI0R4zhHSQrk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 1/3] emulator: bthost: add function for sending raw L2CAP sig commands
Date: Sun, 30 Aug 2026 22:57:22 +0300
Message-ID: <66d2971217dc632b10049fef7a5e9e735715bca2.1788119838.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bthost_l2cap_sig_raw() that tests can use to send raw L2CAP
signaling commands.
---

Notes:
    v2:
    - no changes

 emulator/bthost.c | 13 +++++++++++++
 emulator/bthost.h |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 46c6a52f5..b3d48ffb3 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -811,6 +811,19 @@ static uint8_t l2cap_sig_send(struct bthost *bthost, struct btconn *conn,
 	return ident;
 }
 
+uint8_t bthost_l2cap_sig_raw(struct bthost *bthost, uint16_t handle,
+					uint8_t code, uint8_t ident,
+					const void *data, uint16_t len)
+{
+	struct btconn *conn;
+
+	conn = bthost_find_conn(bthost, handle);
+	if (!conn)
+		return 0;
+
+	return l2cap_sig_send(bthost, conn, code, ident, data, len);
+}
+
 void bthost_add_cid_hook(struct bthost *bthost, uint16_t handle, uint16_t cid,
 				bthost_cid_hook_func_t func, void *user_data)
 {
diff --git a/emulator/bthost.h b/emulator/bthost.h
index e104e68af..ed924eb99 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -126,6 +126,10 @@ bool bthost_l2cap_req(struct bthost *bthost, uint16_t handle, uint8_t req,
 				const void *data, uint16_t len,
 				bthost_l2cap_rsp_cb cb, void *user_data);
 
+uint8_t bthost_l2cap_sig_raw(struct bthost *bthost, uint16_t handle,
+						uint8_t req, uint8_t ident,
+						const void *data, uint16_t len);
+
 void bthost_write_scan_enable(struct bthost *bthost, uint8_t scan);
 
 void bthost_set_adv_data(struct bthost *bthost, const uint8_t *data,
-- 
2.55.0

