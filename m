Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB39434D393
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 17:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521197; cv=none; b=QZ8RjehL4Z4iDHflPOrCwXNQbnbKMYiZEZJ7ImjSYIuNz1gj6gwDqE8PUQXo3oHMaoN3aMhDNxb4LEy8oJBwgtTXRaRyC+WF5w4udQAOBPn0BLY/lr/7nL49YtUrkzpnXeqMSgUy1WWmAkYZOFCuiYl2XtgDuLOnzhUEvjh+Ijc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521197; c=relaxed/simple;
	bh=ovXr+6sxYeMEpCTtHn7L/b6JHB1FSSOMciED12Xosvg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=okgek5QAzCr8f9cVYQNFqHF1BwVdPR7M5TG2Umf+Zckih5etHdDR2n2vIQBqYzTHJAxKumqsVTlcyND8polEfQav8k3lfRcECxJs3JacxzazE3Z5JFaodM7LaiJi1kdhfauCb2RHennTC+NcUcfKTfO4PasslP4IyxX4NoTEajU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P76QoBmh; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P76QoBmh"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c70378ddaafso659904a12.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 09:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771521195; x=1772125995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jler9eAcfNnsrMpyyoJoP7qdaGNuUrFvk9+cWB5kmEM=;
        b=P76QoBmhO76IXp32j+2gyRFsCKuPbBY6qiVYRPZb2BmZOkqcExVfbd4jptI3rez81E
         PZts4yZNkoBjWKAE6338i+gUE115nMTN4RxdAAhJquRS/IKmxbBnYilzx8W9yVA9plfk
         9vPqx6pJTgdk1dqZd3JDP8g4mO0fXbnc6Cpl3y3E7suDl9BDLi7BavjSLF1162tTzRUX
         Kwi0Maakn/Bxge3b0dXjdMB6awWb7NnMLAMBTSorSuMR7FsDRra+nWx00MdY2wfLlQWb
         XmUwwQRvZEgzSa2C3HXTNtmR1DVR2Ye2WZX4CuFs/UVL2MXgJfzUWcV8+cXW1dhWBp/u
         iGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771521195; x=1772125995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jler9eAcfNnsrMpyyoJoP7qdaGNuUrFvk9+cWB5kmEM=;
        b=bLJpOmHPnCcgFFWJ5SdImRT7uAXe7wlzMAPz6rAGUh4uCp9IP19AtQWB0yllW4Dp1o
         P08Ufa30PRqfMlnmkun79KnfNQEbIQbK8KfZr/1We+KDTQuNSTR/Hn/n+hepyUhyhkZv
         6EOMe1Km94m5EDSrdeDFa3Gqk7jzUs1I8T6GZuC997rtT/QncDp9gZzx11+7bYCP1fGC
         fcqOz7CJ773JdA8gKG10wqZAGP2sJ1Owvl/CkHIavalhKrhTH+kPT+GK+gB6SLJmfziJ
         6JnEWpAARMATr9SGbHXg2JQQPgXDp66vEXrK/qmZyk1ahi6uZPtXNncZjhKE+cD/nx0O
         WPCg==
X-Forwarded-Encrypted: i=1; AJvYcCXJkmLlDoavh/FlDF0v0PgUY0Jh9ZmTzBQtCER1PRofy+954HfcM1S8otwp5aNBG0ffA1ru7zSddxGCrMBANK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvT7VcYGe9/GSpoPjC5JNsPUtMfG2RSNT1N1AzCTkoVvGvnp/s
	/QCvKBuUxZJ6I1BP7SQ/SaZlU559yY7EWTnPoV9wCtDC91y4n+hPZNoe
X-Gm-Gg: AZuq6aIV9B9IN7w1i5KhuQ8+XQSDgvxwdCTVgu0i1HolbKRshOAxiSQO4vT20cz+KGd
	gmwRWJ4tdlsaS7dli5F/pOS62N63KGdhjy59RLddPpxKbGZQqiRmujWhdvWCC/i0dqj1LGXTxXa
	ImfvDX4MWBUvpsAXubJEn08NWnvS1y9RVt8t+yoRUtolVumywtQ0OYqe4lzyhBI79HyZfbDnuqA
	5L4R3PTtLBLk/8KGY8kGFhgsg6f9jmKftIQLEljrd7dIeDTIPtSUWtoDtbOoCexM2m063wop66o
	rB9raNnpQ3TfQ0W6gJD4HP4CBUP8SQhmtA95JYQ3oBXkYCUfkPdFH4UYIplkeM7MmzgV+nKPUaD
	NJLh5avKW7Oy1qnLZTPvmqhQJtPl3SkuhLSeQDer/3mRaPoLEgAwI+YLwNZDvyBoIUecnIfz4J6
	bcDOpC6vaoJBpnSo/FiMOJahIVpoCXd8LVzJ/YN35trPZJ8kzaqQ==
X-Received: by 2002:a05:6a21:103:b0:394:5c08:7fb1 with SMTP id adf61e73a8af0-39483aae871mr19808016637.72.1771521195247;
        Thu, 19 Feb 2026 09:13:15 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.236.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e532fa2e5sm15895002a12.26.2026.02.19.09.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 09:13:14 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	Julia.Lawall@inria.fr,
	akpm@linux-foundation.org,
	anna-maria@linutronix.de,
	arnd@arndb.de,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	maz@kernel.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	sboyd@kernel.org,
	viresh.kumar@linaro.org,
	zouyipeng@huawei.com,
	aha310510@gmail.com,
	linux-staging@lists.linux.dev
Subject: [PATCH 5.10.y 00/15] timers: Provide timer_shutdown[_sync]()
Date: Fri, 20 Feb 2026 02:12:55 +0900
Message-Id: <20260219171310.118170-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "timers: Provide timer_shutdown[_sync]()" patch series implemented a
useful feature that addresses various bugs caused by attempts to rearm
shutdown timers.

https://lore.kernel.org/all/20221123201306.823305113@linutronix.de/

However, this patch series was not fully backported to versions prior to
6.2, requiring separate patches for older kernels if these bugs were
encountered.

The biggest problem with this is that even if these bugs were discovered
and patched in the upstream kernel, if the maintainer or author didn't
create a separate backport patch for versions prior to 6.2, the bugs would
remain untouched in older kernels.

Therefore, to reduce the hassle of having to write a separate patch, we
should backport the remaining unbackported commits from the
"timers: Provide timer_shutdown[_sync]()" patch series to versions prior
to 6.2.

---
 Documentation/RCU/Design/Requirements/Requirements.rst      |   2 +-
 Documentation/core-api/local_ops.rst                        |   2 +-
 Documentation/kernel-hacking/locking.rst                    |  17 ++---
 Documentation/timers/hrtimers.rst                           |   2 +-
 Documentation/translations/it_IT/kernel-hacking/locking.rst |  14 ++---
 arch/arm/mach-spear/time.c                                  |   8 +--
 drivers/bluetooth/hci_qca.c                                 |  10 ++-
 drivers/char/tpm/tpm-dev-common.c                           |   4 +-
 drivers/clocksource/arm_arch_timer.c                        |  12 ++--
 drivers/clocksource/timer-sp804.c                           |   6 +-
 drivers/staging/wlan-ng/hfa384x_usb.c                       |   4 +-
 drivers/staging/wlan-ng/prism2usb.c                         |   6 +-
 include/linux/timer.h                                       |  17 ++++-
 kernel/time/timer.c                                         | 316 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
 net/sunrpc/xprt.c                                           |   2 +-
 15 files changed, 322 insertions(+), 100 deletions(-)
