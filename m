Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795532967;
	b=y2jpPa2akFFhgqsELJlvh8s6JO3dPfTorqM6rb2hStIJ95EmCPgtdNUXdZ5aYbjA3r9U
	 8UtJfjwfbTgBSL9SJP5Ad5nAdFbUAIBm4LJ7pF74L3evvQ7+wBYJAWl2uHMm1cAGqH+64
	 jJCNFSeg5v5GhBUJoGTKehtoNorwdYMMEXdoc2jgdmHSRDikoUyJ24bHfdJ7KVjK9YNsu
	 4RVaIjuuA4QGPjc93bLVp+xprSg46MdV/7+50thRea1qu0YQt3zlHPhhtlSJq1Fct1jMo
	 RUSAHT6RNasCWJUpiWInlDWS1yl35PNMuDTGNqlbZX/aTxPcLF3FwxRkeiYO8ycwdRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795532967;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=N+nvHJY/kEJldzH13QQuYrjp/JUMBFAhbLsoPgo4YvA=;
	b=dSOESXVkfWcrJi3UI/kjn50waB37TJcPxJPiDYU/LwOCmZejCU3zHeNA0s1w4Iy7gdRn
	 6+qfaZXQQe4rGZTU44JYMvwuv8bDYNTlOm+o4al1C9QKscHLdbftBuzwWNwPbg2aNPkzX
	 kzx2pmn8xpYsk0u8VTFIquYQnZistBIbxaPP61crVISbVOtGdEK7VA0rN45L041QY+9Sk
	 Wqu6uotysqRshiIptQNEG8yjrjOvU9AUOyg7pbuZddtv7h4wnNw4wWvWEwVHDcfRTpQdK
	 TAktZ2JC+QwlzZM+horXjfEcTsYeOy7WU9l09pnm6go9HZ8M0SbyqtTArCj8bZ1TIVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=kUcJ2L2D;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D646606A323
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D646606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=kUcJ2L2D
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb77a462c6so42045295e9.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 07:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795532965; x=1796137765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N+nvHJY/kEJldzH13QQuYrjp/JUMBFAhbLsoPgo4YvA=;
        b=kUcJ2L2DL0r1Kh8rCr1tpq0l8DdnVqwjZeeie2oRDR1Yl1Lg9K4UDPSUx/rmCtfdIn
         PyM+y4btyFNE872CMKBBJxN8ITZQKuB5KwtekEb/Oerqj50TrXrKpertY8XJALj3zJ1X
         0+eCZWFsjJ6w3IMCKKdM0SeP3tDiYnjJLDmJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795532965; x=1796137765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N+nvHJY/kEJldzH13QQuYrjp/JUMBFAhbLsoPgo4YvA=;
        b=CKudSO0WirE/pRjAGiOEVwpxK5bhLGXuJgzoxU45iInnZ0c4BhM4U1QdrzNkAfk+TL
         hSBQzwaCOneEpOwsXgT6DgxGfNvtEghZkxQtDtsKRODZh1HTvGsxLbQ/icL36ziJax7V
         F2K5wX1sV3dUtI6U0zlCky/CEIltFq8/Ip+55Q/tqH8o2utah1ziPf09EsCXcWkB7dCo
         GFYKm8QtltT0Ij8+p3UCfBldb/RDX7SB5HLnNu0xSZseWvG2hm5dVoYZMe5td1MoqKHe
         t6Zh/PLWEiEntEGDkIWpNIqmft8xHsdW7Iu2wqLh6wA0sf8ZCvMcWcK3HvTKLaL0/ezr
         MbFQ==
X-Gm-Message-State: APuU4Z8s3dURMjN1mAjxm6SG1MRjukZ24RKNBpj7mQcrY+44F6YxRdFl
	FGgwhtKqthbswbzaxZs/jINoC4phnCzsdwG4B+LNAqGjrJ1wbEr9ZXCNXGVlJUKG2hvm28+U320
	epELS
X-Gm-Gg: AZFdTZe9QO/b9a9kE8S2bQz8ap1mdGucwVTl+glC6NQpNcDiJ3TXbq6sdSKQuI8TMyD
	8Dm/mglMAPDvwzIEWSL7z/rEboXDvpIoFNSYz3cxpIFO/o9H7YRmLwLyYSfKKMOz+47JDjKIbxm
	w4MpJZ1qU/2zHxmXlvJwLkdTTMALEIBNKI+J3x/rGeKTafbhJvMyNTzV2c4u8ffSSYHIcNgC6x3
	2E4A1Q47hpFQwkmt9JqbYDfmpQ+PPhntdPGG+ggPUB8t9tl5F0oD5a0D4ejBSm1QwBtePjR+Tcs
	PuBaQHUhz6mIoPLVIRv61YpOpVXvqfZuJM9X9sLCEMQXAqjx5/Dx2uav3gw1n+3OcYVIMUrBrS8
	kIbT+R8kG8lvXNk/417lsaMXyJ/xv9d1qmKaPftYAXTxXdk9DTnP6ZWm3Nyj8MEaBpeKR8KtK9F
	nBhO9B3CvL5QChRgvdG1lnTjo9Zqac9rV0waKbBx1b9xgQtDR6J9KVQL7TC7U08Q9lUcjT4iVnU
	OLNbpTVFqLojpPpD8j3Ah49jiaWgN2zQb1Xqor2UjQ2pnCiJnpb9RBIsOl+v6tLz77X40dF1uZS
	l6L/6MkswIKQB37A2GqXXzLLi10m1FzfWUHS9S263gF8Q7RfwA==
X-Received: by 2002:a05:600c:6749:b0:4bb:5d38:259f with SMTP id 5b1f17b1804b1-4bb8881099cmr294207535e9.12.1795532965440;
        Tue, 24 Nov 2026 07:09:25 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849e598sm402731955e9.8.2026.11.24.07.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 07:09:25 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v3 2/4] unit/test-bap: Check that a broadcast sink PAC can be removed
Date: Tue, 24 Nov 2026 16:09:20 +0100
Message-ID: <20261124150922.341655-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124150922.341655-1-simon.mikuda@streamunlimited.com>
References: <20261124150922.341655-1-simon.mikuda@streamunlimited.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bt_bap_remove_pac() did not find a broadcast sink PAC, which left the
PAC of an unregistered endpoint in use. Check in the teardown of every
test that registers one that its removal succeeds.

Assisted-by: Claude:claude-opus-5-5
---
 unit/test-bap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index bfe98a885..9508c503e 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -1307,7 +1307,10 @@ static void test_teardown(const void *user_data)
 	bt_bap_remove_pac(data->snk);
 	bt_bap_remove_pac(data->src);
 	bt_bap_remove_pac(data->bsrc);
-	bt_bap_remove_pac(data->bsnk);
+
+	if (data->bsnk)
+		g_assert(bt_bap_remove_pac(data->bsnk));
+
 	gatt_db_unref(data->db);
 	bt_gatt_server_unref(data->server);
 	data->server = NULL;
-- 
2.43.0

