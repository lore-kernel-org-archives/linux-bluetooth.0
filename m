Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1F11B3937
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 21:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648430; cv=none; b=PTm0HZkXFcRo1f5FRUCwLg7VgMIk9MUyF0qkWHH1Wi6zSM03VIeIvfueBEnv7eYFJILoCwA6SCCJjWFNZqzrC8sw3b1tyTUs5ym/WPwtZloia+g34BTSEZBfrWQ0xJb4u/vZzWhOKD48VEQ7e3UQwUoFHFcZSp/CgRsIXNsjbUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648430; c=relaxed/simple;
	bh=re7TwLXzr+d1ahwgtZP+0mOSxLxEgU4Y9thAp8kdOW4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hbJJ4vFAOVSGWEmSosdVtQBrvHL8pZZIk3CtVVwDc+akTfCl86bmyqoB0XzVHn7OP8KAyJ61ymjjyuH0lazHuD6xfp3tWt4x1WLHbewLLSAdsdGmZWS/rnrDQQjR7XRNfRQ3SXTT92n3NYgBaW8Pk7/IMCUQV5aiHXcO+RqxwvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKO7Te2z; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKO7Te2z"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-54bbaca0ee5so456991e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 14:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760648427; x=1761253227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=y+1yzAiIaCc5dgA2Oa++Ns8gNBWCHCO4Q6w5ifwLPg0=;
        b=BKO7Te2z5eL17BJMj45SuMTxilFb4DgmxWl5HWnQ2s+qlHJDczpaN1d6mgdWiYPABc
         VuW+tntizUjKOOKFuN7xM0lvAatHSKfJXQgwunqI01nU+AA8QFDZa1YptM9RlHeCxJki
         PhML5vfqRfyitoWNGD4mkWoLnDWd+CYpp61TiBHmAjwGSLZ9yHcd3k8KBYDaQ3ry8u2A
         RDFdwUUq3gI98stAIZeo3gTWIKI50ebYKLOWkRNl+JZXoAhuYaHv2rmmRte73HmI6Qqh
         nCgD3iKjfi5OsTJq0PexepQt9ailVnvD4OgMYjxQLaGQWxVdbJN3B3oOp5EgqvMGwheU
         LFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760648427; x=1761253227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y+1yzAiIaCc5dgA2Oa++Ns8gNBWCHCO4Q6w5ifwLPg0=;
        b=kkcRlV5hZYWiUaxegD+ff4/fB3/GyBWiwseBhEsEVWcpvp59KkJJqL5cssvjMzg6e5
         XJsfs8g4qXq4R7W9g0D4yk3YURiraNBfN7/98v7pQ6JaQtGzHqiDLBEJpzHPWaPhl+Rz
         LKDXN2apM4G2ZMVAON8xGP9S7mrVRC19Joooqnqz8vuHXszjnXSdFHWYwn+nltnDfJGk
         Syzrn0lexxcxoI4GQhAgQzRxrcBY8lrRg2rnLyKXwFHqdMY7JaJ7pwC3LDET5NyR5kZ6
         zKjQF+xYGs6C5xABx7dTLsZDsPDLvEhIA1VRFEHyUfrdrta7d9LzC7ZJsj7qQNGa6g0b
         TLdw==
X-Gm-Message-State: AOJu0YxEaI0dul0Hs+30SE3e1msPAzLCTxFk8gl8MlL6klfWneoRnUVd
	uyekq7EvP9qtsjCblgJ1iPA6pIDZMToMWSmlAQ294Phrq6wqrjIqG6EPnAs6TLSg
X-Gm-Gg: ASbGncuJ78NIRU2qlUzyltZHvnrGgR165LeA6lYiBPfFm0wQMxf3ejcUCURcEGQX3rb
	gozSnrWB4hDhp9uL4tPNCZAM5Kh4btvSvkzaJttvkedER0PZkrSf8seVCNLblOFOdxJomrqYnaS
	9xMPlTfo8K/Zha2UmH3CK+kXf4rl41t5XPI/RKRAF+CRGqQh79wC0/cMsRxWZqoZFhIbgmtg31v
	lCtJOAwojrnl0yJ+NCNEyixnSRvK08kc9KRiBx6uuwxdfY5+LtkWuH27jOmnIr/d84iA1irudO8
	e73/Xm10YomtaYiWnQzAwt9EVHlNKYdGqRe0AazmDZyRYmlTy6NhFWSrkB94zoQlmNfe0ecjiPJ
	ns9muMP5yXt0oUnxmpEwXeI7XJGabUPs+Ql4Xkw5NSOS8qSQgxW8Bu645fIBPPAlyo38I244PF4
	XdOvM=
X-Google-Smtp-Source: AGHT+IHXnpZYH6hdltGWBap1wHMCz23XeiK7sz28iEPN1Sc4gG+X0gNritx7JbeIHtWvWLsgEvKL4Q==
X-Received: by 2002:a05:6122:208d:b0:54a:a1f1:ef42 with SMTP id 71dfb90a1353d-5564ee916d2mr685722e0c.5.1760648427434;
        Thu, 16 Oct 2025 14:00:27 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d80d9bf0sm6590304e0c.18.2025.10.16.14.00.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 14:00:26 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 01/13] bass: Only attach client if initiator
Date: Thu, 16 Oct 2025 17:00:07 -0400
Message-ID: <20251016210019.191878-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes calling to bt_bass_attach conditional to being the initiator
of the connection, otherwise both device may act as both roles which is
not recommended.
---
 profiles/audio/bass.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index d42740ca4afb..e4d343a1fc02 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -1735,7 +1735,11 @@ static int bass_accept(struct btd_service *service)
 		return -EINVAL;
 	}
 
-	if (!bt_bass_attach(data->bass, client)) {
+	/* Only attach client if initiator of the connection otherwise act as
+	 * delegator.
+	 */
+	if (btd_service_is_initiator(service) &&
+			!bt_bass_attach(data->bass, client)) {
 		error("BASS unable to attach");
 		return -EINVAL;
 	}
-- 
2.51.0

