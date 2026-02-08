Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564CA33BBB8
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Feb 2026 08:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770538627; cv=none; b=YBNhWW0xETwxYZrDIxBCnSdNAz4Hx1trZpVSxon71ngXLBwZlUM4YJRmyfbdYrnxnPKd9hmn/v7DVHu0mK/EaB7/Vfd4Dso9TlGML5DZypHgZovvLZ7/+Qfs3UlcBod5vBWdkf2EJ8gaLpYyahxk6Iif1xur92fSX3fm9pUo7Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770538627; c=relaxed/simple;
	bh=F9bNjK+pzEpZsGayI6GYJIczHINzrgN7fQGyUMcEuz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qes8CrRbkgDU5CgvIgbfuYh26P3mUlV21ss4efqoW2G2+HqhFj8lhnpaJKB0DzuYEBqQPr3uVFX92fOdqsyLapr78ZoDbGWGao77kcEAPoi83Tt85b7iwKgtLHsZV6WL5ReDdYI35OHDcnGAExcq6m2OglgDyNkELTP55Ako4rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jr66b2QE; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jr66b2QE"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64acd19e1dfso1744246d50.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Feb 2026 00:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770538626; x=1771143426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oS/b5/sslw48AcYmgWpe60xwd/fLzbiXHPdcLj7bmSM=;
        b=Jr66b2QE9Q+b0K1jgBEBa49a/gSvLj8y9Su/1JPEb3kSZlK9pKoaPqI+GbrLp4t5/t
         4Jkde4qghtlixpuxLkMgDuMJ0wUrVw8K+mtFlpOoj2fKcv/roYucsEqc7HJwsq9c6vUQ
         oztKNQ06OLL3n31CfleN5fiODbtVKVjm3oGIBEaYOEnFgNP4cFkEMgZNsRviEv03eFmf
         q4PRUtaxoJbjWCS1wzpjROKCDMq5U4WaL+3hc9qiDD255Xz39YaU4cAMJ3VacZ/9llJf
         G7LHHHDDgNUoC51d5fpmNHrb18ms+OQh2ccCoLQlk68CPQ13HTKapH21rq2rDfGmDboT
         cd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770538626; x=1771143426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oS/b5/sslw48AcYmgWpe60xwd/fLzbiXHPdcLj7bmSM=;
        b=Hxr/OReuo1lmRuFu9nz+nq+ylkh7lwQTJE1FtoA0tsQl0jQPVuEOLMqoXGyEbXRfZt
         NUYUPUlWNDU1Hte8GUQbMz2MKT5+cfyozxXkwz396ZJ48A7b25ubndD1mYMeO5J2Csk+
         CmOjDPAWHAkp3FtYcj4lSTK1BNUQHuM81q2b1jWq3l84mQEEWaPaK2wGvdoeEg/WiKM0
         ucpmk/QmWb7dRFLVhqr3k5i/Hp1oca3V8QhjkJ36u6fnUehL/pD1nNUiz/Amf7oIq2NR
         9f/JEfQLQq7OVw6W7vOslx+2kQQKeCGmxErbu3m6iASYJiK1YgW9p8XNwpiRUbMcc14L
         WjwQ==
X-Gm-Message-State: AOJu0YySpx3mxBj9bIqgz6SDXT32cI7xHMj7bWCsycFJQPBDmm5hEkzj
	OnQZdRbxNusTWkZ6M5hjQPaTDKMmLf5NfHWueq4y+girXMDd8xf5Xu2vwvQJwA==
X-Gm-Gg: AZuq6aLPoTzYlWfg2jVBIvjzJTVSMbc2FDNJ+sbf5a4I4YoJLmhzA5uW6E4VWDGCYyg
	GRk2408RPxti//v3pJpAA0yHZaIAaCDpFdbuctFIAvM0+A1R32XgHt0khd9N1tr9FPo+sd6zJOd
	uh3cqzK0SdmaBynMmptTLj/zXJgcHNI/FHBmG6M2dQvvrDL4WyzX4MnVTmSiGG3qR3z5G+Q/c8n
	Q0fHwns+0NowSn+n6s6s7tTRpaR2ekGuXFDAg37+c4z+t6JwxkHtOCEXqFYE0n0sFG3TZeUgtdL
	+b3jZiBECjdADjPIt1PeGj+t45FMJ4dgtu2e8YJQtvmMsQn85BIWUtGO1hwBZVo89bwBbPuR4xa
	F0nbpJAbVH4+W1oewvAj3PEpZZwCpKG9C4AmRRfaKCgdDDQGZR1grAHWziuIDps0TaKxnKkhxdK
	lEqoYo21JUW8Aifiop+ap7ER1MEqKJ5wqTMqhtgDDTZZGPue2nOrl8E0U366vSBih0p+/8
X-Received: by 2002:a05:690e:e8c:b0:64a:d8a7:10a3 with SMTP id 956f58d0204a3-64ad8a71280mr2445654d50.91.1770538626217;
        Sun, 08 Feb 2026 00:17:06 -0800 (PST)
Received: from binary.. ([177.39.58.68])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64ad8a12432sm3521745d50.21.2026.02.08.00.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 00:17:05 -0800 (PST)
From: Maiquel Paiva <maiquelpaiva@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	gregkh@linuxfoundation.org,
	marcel@holtmann.org,
	Maiquel Paiva <maiquelpaiva@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 1/2] Bluetooth: mgmt: Fix heap overflow in mgmt_mesh_add
Date: Sun,  8 Feb 2026 08:15:58 +0000
Message-ID: <20260208081559.44983-2-maiquelpaiva@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260208081559.44983-1-maiquelpaiva@gmail.com>
References: <20260208081559.44983-1-maiquelpaiva@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a check for the user-provided length in mgmt_mesh_add() against
the size of the param buffer. This prevents a heap buffer overflow
if the user provides a length larger than the destination buffer.

Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Cc: stable@vger.kernel.org
Signed-off-by: Maiquel Paiva <maiquelpaiva@gmail.com>
---
 net/bluetooth/mgmt_util.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
index aa7b5585cb26..bdce52363332 100644
--- a/net/bluetooth/mgmt_util.c
+++ b/net/bluetooth/mgmt_util.c
@@ -413,6 +413,9 @@ struct mgmt_mesh_tx *mgmt_mesh_add(struct sock *sk, struct hci_dev *hdev,
 {
 	struct mgmt_mesh_tx *mesh_tx;
 
+	if (len > sizeof(mesh_tx->param))
+			return NULL;
+
 	mesh_tx = kzalloc(sizeof(*mesh_tx), GFP_KERNEL);
 	if (!mesh_tx)
 		return NULL;
-- 
2.43.0

