Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525123A6B8D
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 12:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788267289; cv=none; b=iJYreZEd0GfARk6ZHiPtUjmWR49Hng3WTdgYFZJj5Wwu9FUE+hubJMoLrQcw1LmIM2GtbzoFw3q0A05KwtP3NiegbnmKftjwaAe3szy0GbBdSSDB89ndUKtlfKm72oIUVS6ogNoPEWVpxNay888svfldeAAPfDXK0a/fyzZoimA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788267289; c=relaxed/simple;
	bh=7OD9UTSufxzXmXr4V/CK4jU4k/phHl5KBJ9uyG4PqfQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qt2xtoOoHNqepg/0qk32ffXWI+u3dZL37WUa4dY+dkLOy0Y+363Pf3NSH5FBVaunMnMwpNOFFbQdWA2kxbZiQFg96t7+Oag3+X3ED4xZ7yVevhoJotKV/oZ6kd/OCj9lrlP2uqYLYMjNGE4Ig8/Xk0fL0KDfTr1dYy5ipdJJ/qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KFDCS21D; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KFDCS21D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788267286;
	bh=7OD9UTSufxzXmXr4V/CK4jU4k/phHl5KBJ9uyG4PqfQ=;
	h=From:To:Subject:Date:From;
	b=KFDCS21DMeNj19JXqUwWb7ljd2NAez2fxMtlr9qb5k7AR1D1j7NAOQIQsIgl//2yx
	 jmqqyusinDEAZIUz55IRHC7pASflEBBy++bbz1k633mqv+rh9tTVX/LTtKxfNQ/t8K
	 YNlPFdMzcKmmDfkGRwSHPP8HRIYnlpTeWBMfspKCuwNskCmZdJ12FproHlaezbe4mi
	 wmeCp37RYwLlx/dbSJxGfF4nVV3nWVWTp0qVWMLaNGUqEWprwfTz2TqccLqcV1SqbE
	 irIZfGYt6qZuNtF5XYtAAYyl33mxopeIOoALVjBp9krMfBAIbMB7WHgJrtv3DT0yKA
	 0q1mgRKCRNmoQ==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3FE1017E006A
	for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2026 14:54:46 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] client/btpclient: Improve GATT read
Date: Tue,  1 Sep 2026 14:54:40 +0200
Message-ID: <20260901125440.355578-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

BAP/UCL/CGITT/* tests request to read the different Sink/Source
Audio Stream Endpoint characteristics.
The first ReadValue call triggers read of the other characteristics
and PTS, which tracks the read requests, may disconnect before the
following explicit ReadValue has been replied.

First try to read the characteristic value from the proxy cache
before calling ReadValue explicitly.
---
 client/btpclient/gatt.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/client/btpclient/gatt.c b/client/btpclient/gatt.c
index d384b9c74..bd9145173 100644
--- a/client/btpclient/gatt.c
+++ b/client/btpclient/gatt.c
@@ -376,6 +376,7 @@ static void btp_gatt_read(uint8_t index, const void *param,
 	uint8_t status = BTP_ERROR_FAIL;
 	bool prop;
 	struct gatt_attribute *characteristic;
+	struct l_dbus_message_iter iter;
 
 	if (!adapter) {
 		status = BTP_ERROR_INVALID_INDEX;
@@ -399,6 +400,30 @@ static void btp_gatt_read(uint8_t index, const void *param,
 	if (!characteristic)
 		goto failed;
 
+	/* First try to read the property value from the proxy cache */
+	if (l_dbus_proxy_get_property(characteristic->proxy, "Value", "ay",
+								&iter)) {
+		uint8_t *data;
+		uint32_t n;
+
+		if (l_dbus_message_iter_get_fixed_array(&iter, &data, &n) &&
+								n > 0) {
+			struct btp_gatt_read_rp *rp;
+
+			rp = malloc(sizeof(struct btp_gatt_read_rp) + n);
+			rp->response = 0;
+			rp->len = n;
+			memcpy(rp->data, data, n);
+
+			btp_send(btp, BTP_GATT_SERVICE, BTP_OP_GATT_READ,
+				adapter->index,
+				sizeof(struct btp_gatt_read_rp) + n, rp);
+
+			free(rp);
+			return;
+		}
+	}
+
 	l_dbus_proxy_method_call(characteristic->proxy, "ReadValue",
 					gatt_read_setup, gatt_read_reply,
 					adapter, NULL);
-- 
2.43.0

