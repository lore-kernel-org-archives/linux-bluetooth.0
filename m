Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9962211A28
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Aug 2025 18:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754679058; cv=pass; b=e6QBN3AwcM6G7om7NS/a+YYMeEf+bPuGrihRMJM4l2Bqk9cCT4DnkBNYfceS1qnA0KgWptKhC0MjyRm3TsE0AgbLujlgltoaQzYJ/NODp3DDqtDQplEUUn1MTXejrebZUmqkRYryySJoq7oMMvsywnVw0an+z/RAoLYMxUTvnr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754679058; c=relaxed/simple;
	bh=5KHYf20CrmEqwvdwtD7v+knIIX4wCVRTh37VdqEx68k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KIoyKXrYo2LAuJLfRkuwbVeW8akWi9pz+VpiN7VKPziZOlL4kafSXuxVNTZ+/aM1wHykECceKS/xWwMCDLoEe9S4Bqj153F+mHPFdQowWHkLuPM0OO/GLM+xpZy9qUIqrySZFZaB5MRLCetY7yqEzKjGfOjbDBzMS84h9GWGi4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=krvtxQFE; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="krvtxQFE"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bzClx52rKz49Q4P;
	Fri,  8 Aug 2025 21:50:53 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1754679053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zbACq2fjJE/sRmid8b0H+bbuayIVlUhiCxuq41Jov1E=;
	b=krvtxQFE9meXInrPfIT5k+/5jy/98YpX02JCkj7YOdSoeIKjRVsYfB35qoj/1dcLcG9yLV
	bUkNqu8D1GBNpL/kdtUciYDmnshnP20zvADZ1HqvtF12f2IhahBH/v1+EJXr9zvZbMzHdd
	ou4ENwlLWEkKhx/3GJUrx8yNTdN5d/b2u7Nf9Y9MjlY36bINDx+v5QUXjJnIrVusC4yr1Z
	nxwQu1OPND4kpF7hu89pncljD0sUpt49lxS+8FeWZbBKoPjDeXQDs5ACBC+6yYQH0d0E0q
	ozlb0btGF/sV0Qm31x77LPfg8h9EK1gtzgu2a72Pg5lYnogoOKo7GY1BHPA0Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1754679053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zbACq2fjJE/sRmid8b0H+bbuayIVlUhiCxuq41Jov1E=;
	b=QjgKsuUrV37rd8h4RwtiT+vs3HJj4uKxGbtJfWUNJyYr181bwhrdc9g9HZ/9ka2/bAp7mv
	N06dKmnNw9kBVcR1ztFEc3zx3wRtoOsDjnxghZr6HAkajYANwNVcEmSfjBKArK2q8MGKhu
	tf79XbvzpCoYpIu2jrxeX9xUkV3WT0p0u1HC5IzNHi+HKn4CTpCCYlYvfMiiUXFZUDKkd1
	+pygY2Kre+tJ5deS+wCcH/YyM8JmPY4h3gWeKFK6HCNPoo6I35tkE4P6NAakjzu5uOcPdV
	ErbUDgx4MYwCTVkJ6E9xjCQh++/Lhg27FtkuaNsH6Jwgo2WQjr2wyM8lnvBLqA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1754679053; a=rsa-sha256;
	cv=none;
	b=TaFO0dFGQYataA8ltUUmTE0DuuGYfHtQ3/aqxEpMGN7UjBG7wckUM+Ro5dRf/3ABu5bNtp
	tCzE/fDvXsnwycHwjDb4aH4YJDMQyVvF4FZ9im8qcDcQeT0SqpHF6qrkvO1/Tv2VMofQXX
	PQUDjTI6+KiQHga32Xg/H861/92SaEKKibQlec6jFUUUK6Z6uvrwl0X1seXSviZaV85NFt
	FnFayyBqtxTWijpyfx3NUr5a7jnHBx7BX2MIx0hh7qF6B5SVLI1WrUv82BlTWKA+QviM5I
	x2jJQGdokqnz42Ua5+Tu0Ns2lxkpTx2riGarqlbTQ/EiURLbNUkneiqYxLcY7Q==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 3/7] shared/bap: use correct parser for Config Codec message
Date: Fri,  8 Aug 2025 21:50:35 +0300
Message-ID: <e036e06b83066af362ea76d38797659590aad5db.1754678883.git.pav@iki.fi>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754678883.git.pav@iki.fi>
References: <cover.1754678883.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ASCS Config Codec gets Codec_Specific_Configuration, not
Codec_Specific_Capabilities so use the correct parser.

Fixes spurious 'invalid size' printed in debug logs.
---
 src/shared/bap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 8c186e6f1..c27e675ff 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -3093,7 +3093,7 @@ static uint8_t ep_config(struct bt_bap_endpoint *ep, struct bt_bap *bap,
 	cc.iov_base = util_iov_pull_mem(iov, req->cc_len);
 	cc.iov_len = req->cc_len;
 
-	if (!bt_bap_debug_caps(cc.iov_base, cc.iov_len, bap->debug_func,
+	if (!bt_bap_debug_config(cc.iov_base, cc.iov_len, bap->debug_func,
 						bap->debug_data)) {
 		ascs_ase_rsp_add(rsp, req->ase,
 				BT_ASCS_RSP_CONF_INVALID,
-- 
2.50.1

