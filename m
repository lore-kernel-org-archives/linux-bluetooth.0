Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4087125CC7A
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Dec 2025 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765018906; cv=pass; b=K04eQCetAnVx72zB3V5wp/kegvolw2TLRVmPc+qYheFPUUIydTDicHziV2t1/BJ9cSPjVisVDTtNRvjCdBnke8V2tSU8Yy9EwV1eQ71R7pDwCo6Vz7ESELh03rC8Dbzb7Vnd5Y9uspsLmuaFhAgoqPBh4EgmGC7RgOC5coQel/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765018906; c=relaxed/simple;
	bh=5JO8vcYC9Bb4jXen9IsZ0KBW4P/P+Sb3f0AbV1HAdq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OSj4jzIyoJch6lW4Vxv1yG4Fy+toVIWthBrsnS35nqsywyxTIRlccWN65IS/oIEeSLQJRi9OM3afAh1aOGSHgX83VvNqAlA2/PCUAEOaP1lmGIubG7c7kvWYvF21PU8vRgF05Hi8Mn40Rlze0dohkb5yvP7QhmNqXUsWDdG+gA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=qAbAlt0I; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="qAbAlt0I"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dNlg52WyNz104d;
	Sat,  6 Dec 2025 13:01:37 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765018897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=265wfzgJtF+o7JSrBQWynLAIHglSjsYDTaiV93JSybY=;
	b=qAbAlt0IyOJIR25LZMnkDg/gJxVLELHQ1IOIpSvUuUrmof0FTe9oq/0d7HlLShYlbADv+C
	FSw9ShY9gDYn2Kc2TjJR4rMVZ548Y4Ya420e13ULnK33BTiukhU2FynEsdnPgoK/KhGmtZ
	m7rarTQmkF/6adcnz21N1q0b9L32HQI=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765018897;
	b=ZsllzxAE3xqJoq16DH3fCCXgEm80b+jIvR3FTzbTzHSrKKs9wGJK7aWqTTOa2Fzqr3iEEH
	DUiEa+29stZslIZTpzTTbUKSkpD+XjOiluJYxKwTyAnjWDHheXGMKSrRSD9K6aBOQykrY3
	LX1mKRYXUU051Ia6Jl1qTpI1Cjoaqko=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765018897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=265wfzgJtF+o7JSrBQWynLAIHglSjsYDTaiV93JSybY=;
	b=Yo0xPf45gEp1OB3YWnCkrjjjdGrlMuyYW1cdIqNA3LQqAgobp3hx0GdvlRpkiSo5bQ2gt2
	34hb0vH2r/mKk1pqP5uzo1jO4hrlf9kaS7yCF7xpVObeuCCJc6APqEH2UDM9NepTG3JQjQ
	236smGY+zd7pxYwIEZAkLlBGO07bLd8=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 05/11] shared/tmap: deactivate service if setting Role to 0
Date: Sat,  6 Dec 2025 13:01:21 +0200
Message-ID: <0702d014ec1227714a423e7eaf27c5f98ac33b35.1765018766.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765018766.git.pav@iki.fi>
References: <cover.1765018766.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Deactivate TMAS if roles are removed.

Also add NULL checks to the set() routine for convenience.
---
 src/shared/tmap.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/src/shared/tmap.c b/src/shared/tmap.c
index 6fc96cd89..27e08d74a 100644
--- a/src/shared/tmap.c
+++ b/src/shared/tmap.c
@@ -292,11 +292,17 @@ struct bt_tmap *bt_tmap_add_db(struct gatt_db *db)
 
 void bt_tmap_set_role(struct bt_tmap *tmap, uint16_t role)
 {
-	if (tmap->client)
+	if (!tmap || tmap->client)
 		return;
 
-	tmap->db.role_value = role & BT_TMAP_ROLE_MASK;
+	role &= BT_TMAP_ROLE_MASK;
+	if (role == tmap->db.role_value)
+		return;
 
-	/* Expose value only when first set. Role does not have Notify. */
-	gatt_db_service_set_active(tmap->db.service, true);
+	DBG(tmap, "set role 0x%02x", role);
+
+	tmap->db.role_value = role;
+
+	/* Expose when first set and present. Role does not have Notify. */
+	gatt_db_service_set_active(tmap->db.service, role != 0);
 }
-- 
2.51.1

