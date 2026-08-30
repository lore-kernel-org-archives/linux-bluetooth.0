Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E433C73E1
	for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788109922; cv=pass; b=Firjvw1KOt/sSbi5HP8BdX7U/i1CPXG7QnRvkmrFjM4BhmC13/QN8lXmBp8dJXqLTJBMnPW/jjPotqVVFjcF3JqoxwjO901P6i/vsBCQYJ5svOvPsq41m/3b7NzkmFFnvKEySi7gBuh/VysDr93Cbrt4on7GbClFO0mJq+WUQJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788109922; c=relaxed/simple;
	bh=RT2cxwvE62ii5DYpMlJW0o0rOjRdZafcAVN1wRjxHwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=csLiwWYzvCu0noALifC3x1Wdyk/dyCztan9q232dQXepO3VVNAlKd1yeVd3AaL97qCqxFWVO0+cDjE/i7XHArK5mB689wVsCmLVifPLpKpv4FMOFG1dk+KA6jaTJola+Bb8MQ+DDx+5BEHGNgkeYE1f/VGA27lPWPjq6JD1cpXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=fItNOJhq; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="fItNOJhq"
Received: from monolith.lan (unknown [IPv6:2a02:6ea0:1508:6::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hXzF35n6vzyZF;
	Sun, 30 Aug 2026 20:11:51 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788109911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qaVE/XGSPHDmtNEv6WJTkcr4cqDhCjB32eLHquSWgGc=;
	b=fItNOJhqLrsnTDqcLNOAOGSDAQLmT1HZNo6ppOxMnOxS12d6L/EgPhJmBtx/4634R0jBP5
	BACCGAtzbtMMpbEhKyGZkPZR9/9e2Tw/TvmS0T7qp9+fmixHj7/jFZmkldM6U1ucqFhOTb
	d5UDNi1G00PTo86193NERs0Esdx6QnE=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788109911;
	b=UATGo3Zx5OcNJbapLLJHSVfHUi7mLDnunc7V/ROntNGRzwFe6DXJCXoWMZpDFJgpaUd0gk
	MuqBNz662mobP4rcH2DUzXtK+g+Rog4CtcWliAmZSUVhwM7Ou+gfZQBjhUjH8fZVlDm6/l
	MFH8LLnj3lsdkrWD5bHoERwsBisaqzI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788109911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qaVE/XGSPHDmtNEv6WJTkcr4cqDhCjB32eLHquSWgGc=;
	b=SbBa6D6h2CPF3yhHJWAUBmKiEj6PF7dk5KfLUxu/QncC65wY61J39I0ZYo2sHyoJezIwKP
	7X0yUy9ymLyus4DsOFCg7dcHSN283yvwSeA9ICDhzQw5WTjUOv+yq6OneeGiyduvCFWIhJ
	Q2vbObKxu2NiyoSBNczcfgJ0djR3Jas=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/2] emulator: bthost: add function for sending raw L2CAP sig commands
Date: Sun, 30 Aug 2026 20:11:45 +0300
Message-ID: <66d2971217dc632b10049fef7a5e9e735715bca2.1788109841.git.pav@iki.fi>
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

