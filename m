Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E322D47E4
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 20:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755722491; cv=none; b=DaCyN3zapwXgjtlmjVJWOP+BA5eEk0MBI6c7bc0ypFuCi0yjRKu2/9Bc6L6iE2QmrPsbt6Aim2Y1hnWb5dz1qcl2/42LlApwyi13BWIAWB+r8vNg4BlcpfnsroNTRV99L0RkPjg9Px8LwrEJcuaYO3NZKSQhotPocq40nvg+010=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755722491; c=relaxed/simple;
	bh=QgIaskGhuz2Eq2QDtJoJlz9jcPEL8rm+wC/ml4BUReU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=eCZ5PH0c8Xm7htStU7mUrYok/pQvcDzSpMGoLGYlAvD9ydp5HkWY15sI8fVken5PIDKOJG1aUJjh9DkTXypW9voifXMrAgYzRGz6XMWblFExOlgu0zTY5WOKopjjmi7PG80DMv4/gqLpeYB71papsoUdQ4bAb4EJsn4XgldNNXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xrlg/TmI; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xrlg/TmI"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-53b173ac313so118667e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 13:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755722488; x=1756327288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2iuq/Ry6lYWGwEAqKZ1U79Uua8leXgfGXhmfMk+c3WE=;
        b=Xrlg/TmIuS5+gNSHDy0W4w/zkIhewktDoaUEoUJjPI0PZfLlL75fwYK9PolPRRSRmQ
         EpC34h6NQizQsK3wG+339B/XesOhdF9Zs+P2V/FGX6apIFV+yycX14jiFRN7IvRQtnJO
         vJ3K+JIcpqO73emzq3Rhl/4P8vByNibJCc+jY6EfK3mO9nmswjr9NOpKpj0tSL+YYLQN
         1yCfLWzn+MOdi6AuB0VixCK7x50sDKIHwGqcQa02MA91jJiEWDv/nQqspLeDoGmFFWqB
         aPBQUWbAjh/J3k97dDa2RnSJoJj7UHBzu4ih4xQ4AKWnOIsJAaG45jPaLQ7GRIIy6KdN
         8IIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755722488; x=1756327288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2iuq/Ry6lYWGwEAqKZ1U79Uua8leXgfGXhmfMk+c3WE=;
        b=B4CV/dpFeO3MXWXY9HwVbjw9MbPaBmzlaPm4I9h0D4S2fyVhP4e1Joylvk1gTwtrW6
         nK7p9FCBrAo/dSW24VCGiu7f7Ktir5xE2UdOm/jePOaailVFQAxyd905Y3KWbwWiQ7YP
         hsUAv9qJ1jLig4Iuvtg2Mekl3iUh6v+/1ENd3PIcfC638nzR033/CbHHs8QAogzk2rQQ
         3U+v+2Uu8yp6tZ7GqiS7zjTV4moGpBlhkibv0Z29JtXm7BuD6/hIWB4xhhjhn6XnmByQ
         7QgLGmxuWl2ob+HK7SqBUi4GXVAthaK0X6tL7b82kg8v18gUURHNder45PO/pkF/5Lkj
         dZyg==
X-Gm-Message-State: AOJu0YzB1tsUtM7ouTVSpgPsf19xbseP8vgD07ixk1lVgnJJFgDZdFY9
	NlCSIk1LJYmYb0RAEezL0IyvMGuvhlq/rcWpDYpaTEDtDUa00dlqkXkWqYDKEQ==
X-Gm-Gg: ASbGncvdw9kgP9Kw4hZCWPjQu4Tot+D0+2QJiclQ9XOOw/pTsZOvfhmG8Onwmd5Gjxp
	RBNnZOYOEjdY51/iftFRe3DhZXN5g/yr77n1W5mY+VIzrF6kTerkZ8SSh24LswnWl19Y73mSMBW
	VvBWFlXErTt11YxKV5zkUbUcmbbe2HAAc5T5Uxv5otIGBFnL+7hW+3z656QEfD9Of5cs0ItD71p
	Eqr4hmubjt7Ud1FxO7n4pkRyInlfFVP+RG0H62LE7R1qemtd7UkjgbzxKsZ3h3ERdom9lEAyDMT
	i7L1gOMtccJhlkW892pPDqTkUtZjp2yYf7SRJH9Oo10c2n8drGs+ojtIA7bvG0M7e2phzQasV3s
	08zwKP9EtxRltXGapV+g0ih36IFamJuTtsiNxIHmDJbhh+3BocO+2D2twoew6t+y0
X-Google-Smtp-Source: AGHT+IGYsvEe23yXK6eoOLE10d9gt98oxMKPKok4Jb3D0HnIF69EXVJZa9yRiWQyH21z+r2NPJArXw==
X-Received: by 2002:a05:6122:c8b:b0:53c:6d68:1ccd with SMTP id 71dfb90a1353d-53c6d69c850mr1614196e0c.15.1755722488368;
        Wed, 20 Aug 2025 13:41:28 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53b2bed9fd5sm3358051e0c.18.2025.08.20.13.41.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 13:41:27 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] adapter: Fix setting index in MGMT_OP_SET_EXP_FEATURE with debug_uuid
Date: Wed, 20 Aug 2025 16:41:16 -0400
Message-ID: <20250820204117.1905780-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Experimental debug feature requires use of MGMT_INDEX_NONE since it is
not an adapter specific feature.
---
 src/adapter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index b771cf66ade3..549a6c0b8324 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -10019,7 +10019,7 @@ static void exp_debug_func(struct btd_adapter *adapter, uint8_t action)
 	cp.action = action;
 
 	if (exp_mgmt_send(adapter, MGMT_OP_SET_EXP_FEATURE,
-			adapter->dev_id, sizeof(cp), &cp,
+			MGMT_INDEX_NONE, sizeof(cp), &cp,
 			set_exp_debug_complete))
 		return;
 
-- 
2.50.1

