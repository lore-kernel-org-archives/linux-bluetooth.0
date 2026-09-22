Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D9353A39B
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 11:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075591; cv=none; b=iwibcheV9K10jbxqsKSdXnHm/du38mp+3+b4LbP7x6qvTk6S6EJrox5ivEKLlXC2kOxPpXl6eIJoWKXdY8z69RXYUFBFeSLVJzGDpdros5M/KB/LdjElNhwQkbeRwnPK20GpMVSFdFAaxJHqJZ8ikLbjqwUqpxPJmj8MUdzYhwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075591; c=relaxed/simple;
	bh=YarAgSzbQBFHY4pvPWJvbL8oSNuMC2avIErjfbUPn9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M5rAX7i7M8xKtD9d6Vbo740flErZae2OnLKVGb79vF+OcqSC6xlwHO1tUYqSc7EesZU1JMo0bMjBBruff/HNM0og4bRE5PvErFPrcodYi3W5TOpsRXXcbvnjMz5DoX5UiKpzDu1BE71lNqpDifcOmACh+DO29/U8aS8JGfrL+3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=j1DVUvCB; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="j1DVUvCB"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-484366874b0so2375315f8f.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 04:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1790075586; x=1790680386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lprtwYZdjmFdJ+qLKMQGuhKHtCw975QMwQvc5NC/bxw=;
        b=j1DVUvCBfregD7JDnHjxRjUJCmQ7+U2ocqrhdp/rRQli+2GwSaWyGJ9kDllF13OSsv
         o4bacVz349F+zlh+wLUs0RdrgnzZ7foQdsX0S3QHNu6wOW3e/+TZoetdZFCe1NuxGPJt
         oBLZGe6ZQp4KnP0HW+qWz1jT6QD7XcHwgVL2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790075586; x=1790680386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lprtwYZdjmFdJ+qLKMQGuhKHtCw975QMwQvc5NC/bxw=;
        b=PnuicFMKpOTxbzBuEWS+yQhhqDBloSBxHw4BGnCPbEqgznnYsryuZJt7FRuqIiaZhW
         jJAwCCDsVVqRGh6t1qfQytCFLXibTcWZiuVgFJm/RCAFLBOsMDijBTHuN3nT+H9FuFrn
         9froN+h6vzV0Yo7rTYLP1q5ECmVsjDVXTNhRszGmTyKAital5guvmrVJFvbuemHlNcor
         0Qt5v6npwjlxlmjoVsiDSdPl56DaZ5QHbIhGl7iKv9XrNqJznKFgu5RdakW13eLe+WyQ
         yo7ULYAVuIE4kOLUg2uQeqUpaHEYlS/LKh6yl2xuBLzvKGti/ob+2hKWRpgOjd5cDumE
         kthA==
X-Gm-Message-State: AFuF++kp6brBzr6OR26wRm3TlEQXig5iwByAa1YuX8X13CYlNp2OKe/N
	otkPtKXmeGTPsigZRsDOOCQyi4Hq713IGGTeyCLDM7/3vc4P/tcekqO5vWVripD19Vm5kp5KFph
	FSy0=
X-Gm-Gg: AYBFou0Ts822iP3DW3CuglU65601uVZ5rS5q12hBpF89B4BTHf59eaDt9F6tGp7fL0Y
	Hd9H4jnerIWbC3smybojcy1xViFw79gI5n3udH9+GbJRF9JXfxolGuopYWcX6iXpMEKME2MDiSC
	cPyPX/29jX7gIOUK5JMFCu9saFAVwdp6KCit5DrT3RJoFm9g0m4YxwfxKjvaFxUONpEcZqxiM1B
	3Vk5hNhfRjKcmNW7ywuT3SRQswH7WxGTVsHfBb4cBoUF8nULpxtwESnONg1wnwSr38cBqn6iOG1
	RgZ0n1lqSg6dIf7l1HomY8fgLkW/mzIdcUGUclKW3VbQxn8AZBfHMT9xLvdzP4+VCIABHcDDA0Y
	vlClVIx7dx25prM1Yqx3sE/PbgN7xJKrmT78VtkDbOP87GjZ0sUFRdckHFL6z5xX5cXzrIERuND
	Gq4LRGjEDQyYIVlbpufNDOwmvYBtyVrf06vPEu4snNfqv32MwdTUX8qh/BAB8BS1i5T0jWui6WW
	jfha4jDtLjzVAW+BxDeaoZZf6ymvFAh33JkRNlerHM1Ar8Y0FFd
X-Received: by 2002:a05:6000:2483:b0:487:27f6:a4ce with SMTP id ffacd0b85a97d-48727f6a68bmr15365085f8f.30.1790075586332;
        Tue, 22 Sep 2026 04:13:06 -0700 (PDT)
Received: from great-eastern2.home (public-gprs180755.centertel.pl. [46.134.45.84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488627929a4sm3458323f8f.35.2026.09.22.04.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 04:13:05 -0700 (PDT)
From: Michal Dzik <michal.dzik@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michal Dzik <michal.dzik@streamunlimited.com>
Subject: [PATCH BlueZ] adapter: remove bondable mode hijacking when setting IO capabilities
Date: Tue, 22 Sep 2026 13:12:49 +0200
Message-ID: <20260922111249.415422-1-michal.dzik@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setting IO capabilities could implicitly toggle bondable mode on or off.
This behavior was introduced by "core: Add AlwaysPairable to main.conf"
and creates unwanted side effects for external pairing handling,
specifically glitches in the Pairable property during BlueZ startup.
The unnecessary setting of MGMT_OP_SET_BONDABLE has no basis in the
Bluetooth specification and should be removed.
---
 src/adapter.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 33e1ff07a..a1f3d058d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -9514,14 +9514,8 @@ int adapter_set_io_capability(struct btd_adapter *adapter,
 
 	if (!btd_opts.pairable) {
 		if (io_cap == MGMT_IO_CAPABILITY_INVALID) {
-			if (adapter->current_settings & MGMT_SETTING_BONDABLE)
-				set_mode(adapter, MGMT_OP_SET_BONDABLE, 0x00);
-
 			return 0;
 		}
-
-		if (!(adapter->current_settings & MGMT_SETTING_BONDABLE))
-			set_mode(adapter, MGMT_OP_SET_BONDABLE, 0x01);
 	} else if (io_cap == MGMT_IO_CAPABILITY_INVALID)
 		io_cap = MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT;
 
-- 
2.43.0

