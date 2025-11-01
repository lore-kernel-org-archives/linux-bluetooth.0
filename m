Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D992C3262
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Nov 2025 12:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761999036; cv=pass; b=ndLHiYXJrh4UuUJhl/Om+rDGNGzzKKjB9LN2QXs+VcG6aJH88ADpihLagoa49VPJchYwSb1J23N8AAJkEDXykqHCsHXDKp0OtWYhaka9gzyd+gV8XKjD86CtD7Mp/TB8uxdp+VTTvLd3K1Zol0ebkO8d+CRUvtxL/EPQroHprsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761999036; c=relaxed/simple;
	bh=3pkszyuEAWG+Dw30yl3qxMmSGSgSdczEaEnVWWfqIHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eP2yOe/F2wuOe6XHslpXyj1hgwCitSKtT/pzXrV8VaLwSlIJ6p5YUC4FNK0qJZVGMyXZHBvMSULKXC8QFHAPHt1+SIukp2UnULfzaeYYxrOF4se2j3vetUfjCumH5F3NgqnGtWjC/15ypEdKAKoWe3I6MYpW8LNc0VNaQ5NXa2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=ZFELTwlG; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="ZFELTwlG"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4czGrm1y3jzyxF;
	Sat,  1 Nov 2025 14:10:32 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1761999032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6rynr9I2jrGYgjXhcG40UBJ3IQcI+VAtwlvWx+ENmAQ=;
	b=ZFELTwlGBaQkQxWr1xO0gj8S9BIRTQE0Mwj7XWf+qzT4VXEckypSUdJFCwbaVl36x/JWTc
	07oJlNhRPiKhw4lFVng/WKt/LWHbXoaoHLuW8KB2cQVpmPqIkNltnijsLlu8aFyAXDdrWr
	HIPhu7VK1IuXrHSDCQaV1dukQJCRD2k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1761999032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6rynr9I2jrGYgjXhcG40UBJ3IQcI+VAtwlvWx+ENmAQ=;
	b=NSgV+hUybSwrwFm+QwFsa6W79F7Yn5NHJn/1WEr7/fjGjPz4feq2YmJEtVoTHPoP8ZoRSa
	krQrqg477iSuit5IXz8iSpqoI0g2xKez/lvZaq6JzRyn6RK/Ymc3wVvU00IoKJGQ39Tey6
	O89P/rFBkeoGTg0czb+qdZnWS/xFARQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1761999032; a=rsa-sha256; cv=none;
	b=IxLHQxwZD/I+pHq6GWd7jco6ZOk6dimBk+F2oLBmLKnmozOZTA471x3pXLUsVD090bnMIB
	vvEidDLTmjCwsvxrKulqCZOD/9wAFoAIlUD/nWXuAMkPImCcYCxmiLFnZtAI4LK2WBfEsE
	xNwmUubfQM+l2wtylwTHS1hLvZX+Opo=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/2] 6lowpan-tester: re-enable previously crashing test
Date: Sat,  1 Nov 2025 14:10:12 +0200
Message-ID: <6bf7ab8a1a6ad7f8485d10cc3d19e621adf79365.1761998984.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <2fc1c535e6642706aad81d08bd3f8b14ee4f56c7.1761998984.git.pav@iki.fi>
References: <2fc1c535e6642706aad81d08bd3f8b14ee4f56c7.1761998984.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable test that previously crashed kernel, since there's a patch now:

Client Recv Raw - Success
---
 tools/6lowpan-tester.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/6lowpan-tester.c b/tools/6lowpan-tester.c
index 7fdacefeb..65dba173b 100644
--- a/tools/6lowpan-tester.c
+++ b/tools/6lowpan-tester.c
@@ -337,7 +337,6 @@ static const struct client_data client_recv_raw = {
 	.send_expect_data_len = sizeof(dgram_data) - 1,
 	.sk_type = SOCK_RAW,
 	.disconnect = true,
-	.skip_by_default_reason = "kernel BUG at net/core/skbuff.c:212"
 };
 
 static const uint8_t iphc_dgram_data[64+2] = {
-- 
2.51.1

