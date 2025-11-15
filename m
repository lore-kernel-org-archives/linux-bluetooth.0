Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA98E2877F7
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763211522; cv=pass; b=Pm5ypm6pbbe9SZpn022V4lxd5+6zQXrYgg2cG5M05HfzlT9aZXR1F9vvfCA+iG2QaQZLvmDJ27FuqwP9RQJCfDJv2fVXfE/PKKp6Ybbvu+AapksGyQMKzi3UxbHaOCXTB8mXjCT7BJA1/FF/s6sJBII4dc4ukesBTgkP65bABkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763211522; c=relaxed/simple;
	bh=wk1YolPK7suRZAtUoQ0/nv0EKAUskSvQJEMJklA2tvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X83PWImoIUSJMUApXNK8qJ7KJix1r8cci8t7vCR39A+2TLDGV1uzsTWN1ziGlC6bkqxHQUv12aYz/npZFCrXv/Gco94yh37nmCnwyNbSRFIB4rTnejrIwdcZFQA8cSO6Oewt6Coq5M9Cf0V5we1jgJHEIURF0iYACfJhQk1BBto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=W4icVbat; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="W4icVbat"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d7vFn2Gn6zyY5;
	Sat, 15 Nov 2025 14:58:37 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1763211517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N55plHzk44byXiHSHlKy3TTS3zY+QiMoyP2nc4YVomM=;
	b=W4icVbateFKPhfbgOm8nmzHqVwbmNBUzdinZC/VuLuSLT9JIBkfzzJ4Ybk/iIiXPffLkkr
	smwe/d+ELlF7aJ2xdPOnIaGZhVnDhQ1ATSmH3shFEIb5Id163ELnCuiDQlHPQBAtFnHLXY
	7uFubUjAE2JkO2yK9Uv4W5CZgfKlZOo=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1763211517;
	b=p8bgsLktLC9VjZKzK6dvZJKPO5octFunQJiWlxbOWWKvckFvhzP5SnVXGZ11FcW0W5Lx6o
	SoaG2FsFiR1w+p+b66qNzxPbpCSQQW1aOEyHGvuYKWEybrwl5qZBucBwaIXsF5Vzi5Lhst
	SOBe+sUUlSICg38LY3Cv94di0XnwdQU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1763211517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N55plHzk44byXiHSHlKy3TTS3zY+QiMoyP2nc4YVomM=;
	b=JKs3nHtGaR1zHMUcqnjlOmo1O60ctS5OVXw2z30/iajKLN0FcDs/NQ7yIWH3DJh5ioGtG8
	gSyzVyPxiDNQgZXisEVczGhDE1WxJysqlWc3az1vVbTSFs7r3i8OMHPxK8wtIGn/3KNeZ0
	tbqRWNCrBzmlqsGRuF4GC8K+lTzMCe4=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v4 2/6] shared/bap: fix packet length comparison to ATT MTU in bap_queue_req()
Date: Sat, 15 Nov 2025 14:58:29 +0200
Message-ID: <8566b3528865d389dd8dbebf84dc164782fd774d.1763211509.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <69ef74b5d531804f4f793f42032da508d1497d1b.1763211509.git.pav@iki.fi>
References: <69ef74b5d531804f4f793f42032da508d1497d1b.1763211509.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bap_queue_req() forgot to account for ATT command headers when comparing
to MTU, and fail to send if packet too big. Fix the MTU comparison.
---

Notes:
    v4:
    - no change
    
    v3:
    - new patch, bug discovered in test

 src/shared/bap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index b779f6716..27321a3d1 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1730,7 +1730,7 @@ static bool bap_queue_req(struct bt_bap *bap, struct bt_bap_req *req)
 	struct queue *queue;
 	struct bt_att *att = bt_bap_get_att(bap);
 	uint16_t mtu = bt_att_get_mtu(att);
-	uint16_t len = 2 + bap_req_len(req);
+	uint16_t len = 3 + 2 + bap_req_len(req);
 
 	if (len > mtu) {
 		DBG(bap, "Unable to queue request: req len %u > %u mtu", len,
-- 
2.51.1

