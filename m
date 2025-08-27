Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68523322753
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310769; cv=none; b=DxthInP3EJZYIdKXrSgF67EGzZIeAbBtcxfztBHbqC6BcuaRvfGw76yitConyf1uU7DTH2DTLnye6xlLyJCbm6gZMx8YdIzBE8RMOVP6/n7iC3DsZahUN4kWaWskQtIXmjTakI2gEp9AgwWFJ0Hv5y2o68NgU9QkEYWCCvHxNfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310769; c=relaxed/simple;
	bh=15FrH2Q0ILNwLPbpKIVgrMOQ8Ld0eWxtKpvtEMZgcdM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BLm84iG0cVRcM5Zx4RljysSZoGyQsBTMgo6TjIjwMg6QHZSTA3QK9GcjcossZP2eYs3R/DCrTzLZ9idhe+yfTELp7HXbWe2ZhivphTluaPo5rsQda/uKX5wLHhlSTzdhAdlLoS1kYilH1vt7YjS9Hqw4OQWn4eCrEiG0n5ilxho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJ0aQDRT; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJ0aQDRT"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-540548a3f76so11199e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 09:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756310766; x=1756915566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=g/wt08ZkqsLQM7Be6+p6QIFldAWcTRADuzpHzUQFcOk=;
        b=JJ0aQDRTIJ+xjvn2IP8zWunO8+Mbdfwc1T6l4ZpbDNH0Fp6NSIbDXIxuqbFjfTyjy6
         1H82KnBknlRzxRSPgmmx1N+fSIcB8ZJoOmnTbv6KjZuUSMHZJg61iDivhegHdkdEUUPF
         I5JIeuO9CkTfxHsbP9xs7dT3dgD4geTYDKCnTTmyRvxm8bqhmnyf7qJ7zbUx0yNUl0Gm
         pJhpmNOHFDlP83emBy5Xu1xDl8LK3Q6v33MClyEATZWWBVf2W2GsudkA11U7mMsnAE2r
         3RoEpb/PTt2c/XUfZVTD4c1skCbSsJcvyYZ9PGR1YsrfNZmzSrP7Dv3mX3vUqpMvwsvN
         nwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756310766; x=1756915566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g/wt08ZkqsLQM7Be6+p6QIFldAWcTRADuzpHzUQFcOk=;
        b=qILNiDoWGnPtCSJrpG4lWrTJXOCunJlLaSeJ/QkqsHuyIqtXwlyDOQQB/3/Rwts3+D
         fBnhs5q3sKq9HNLAzZqLh9VO0ZO8033tIRoniwJMVYk2WTBmQ2zobXSV+hk20jX02Zi8
         l7/REdQxm0PYrlrZs/iBWKpDJb/z3gi9p9RqPHu99PJTTmVN/BF9tq02SKFxNaM+PUa7
         aokjupZfJ8FVlp6ncVgr8PE7A95JcoT+bOMLfb+Djdkh7EAMnbarZpzdWYVEK/Og+Zrb
         SgsjSc0mNGHNoZdM+AWS9D7O8CH5hV0JvSVdbd7Inbc6LI/NKvqMPgKe89pJbpTTXNuB
         JlgQ==
X-Gm-Message-State: AOJu0YxUQzGMddHIoTHIluFrR4hUBJ8lqtJr9RJtoLh/NjjHdLGXddYo
	eka6KrMdQ5Cz2eR0fKNL0J7weUThToGcVc6jQDNmBksWCb7hZe1gjL/1pJ9GRa3H
X-Gm-Gg: ASbGncuEvyu3xtUo76abXKdEdo0mL6Vjrq7KmJHaQjtUdghq2EsvJdN5+51sE4D7gmi
	3o0WYiqQZgRx/R+MWtMbqX+EU8x8w8HJkaSamZzvPejtrT9kguq+VbZVxzhZj0fuODAKQIM3INl
	rEsaHbr69QdBcSQBb/7nV2V1FoG5TzFzEvdoh+wJN+XPv3aYioPfB0dgDFese8f204zCOtmPY+y
	3McC0aqt4y4C5FAPcsh/Yi/5Wpcwiz3Y3aQGenDYEhYWEyBPD8STMBKbCvw7rMp5PZ6AnyXhitR
	ICYTPL63oZFHTuDCYR1+4/7v/SSqn/yDl03tf6VXca9nB588pwo7Njfg7iA+4/+ivCFb6Kaxg5S
	Aji+vUv2aN1PZ+BJeAOtcKd6VpoFBNjjfyWJlkMwrHBTUtbMkqjP0tUAZ7ZJ5fMgGKJPJzH/LUK
	5LM5Fbx/7TYxMFKR5PbhOmcOkuL5XyyOahqu6RM7U=
X-Google-Smtp-Source: AGHT+IE9P4+tZg9RTxfckhGB3XNfxY2+TM5zo571OhyJapP77JD39KfNWXQfqeQ3yu2zzHucyd19Qw==
X-Received: by 2002:a05:6122:1350:b0:530:7e05:2029 with SMTP id 71dfb90a1353d-5438f39e4f5mr2195503e0c.6.1756310766237;
        Wed, 27 Aug 2025 09:06:06 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5442e4c4e3csm1060135e0c.14.2025.08.27.09.06.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 09:06:05 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 1/3] Bluetooth: Add function and line information to bt_dbg
Date: Wed, 27 Aug 2025 12:05:53 -0400
Message-ID: <20250827160555.1446966-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When enabling debug via CONFIG_BT_FEATURE_DEBUG include function and
line information by default otherwise it is hard to make any sense of
which function the logs comes from.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/bluetooth.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index e5751f3070b8..d46ed9011ee5 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -272,7 +272,8 @@ void bt_err_ratelimited(const char *fmt, ...);
 #define BT_ERR(fmt, ...)	bt_err(fmt "\n", ##__VA_ARGS__)
 
 #if IS_ENABLED(CONFIG_BT_FEATURE_DEBUG)
-#define BT_DBG(fmt, ...)	bt_dbg(fmt "\n", ##__VA_ARGS__)
+#define BT_DBG(fmt, ...) \
+	bt_dbg("%s:%d: " fmt "\n", __func__, __LINE__, ##__VA_ARGS__)
 #else
 #define BT_DBG(fmt, ...)	pr_debug(fmt "\n", ##__VA_ARGS__)
 #endif
-- 
2.50.1

