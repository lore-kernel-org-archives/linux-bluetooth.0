Received: from mail-vs2-f39.google.com (mail-vs2-f39.google.com [74.125.227.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0D334B40F
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 20:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790628465; cv=none; b=nhnl1luhdckzIqzzHXk+phe3yKgYYhaR8o6R96fGCPRggewmxarFAiYR5Ik9fpcHVQvmSWP2yKIurxMoVRLVUugjlsEo+164utwIC1TG407Y5jMpRRNqBaIn68ycSTyXe8NI7QzCnPq1HYLuAZdzFbJ5rCMmWXz7RuI4hAwkfOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790628465; c=relaxed/simple;
	bh=dnajHyyb8fiYqXsMyxgA3dVA2G3fKeEKCCJcBPF60yQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=g6QWIjfaat6SiGzrHte5SoNF/aEA3zgGZABO8weYREVkOJ5Rn3gTsFG2EDI5I6a/4iFTNcjnuZCe2KlrFIL0SD9nDN2C/j9P10ZQXNPjbs8rjThznbkervfNFZAAKbwSa6jdR3Qk9q1cqs9aFoAREj4Y4ySsEdN3f/5jUUNWnK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQk4TKJg; arc=none smtp.client-ip=74.125.227.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQk4TKJg"
Received: by mail-vs2-f39.google.com with SMTP id 71dfb90a1353d-5ccec25014eso1343060e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 13:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790628461; x=1791233261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FxJggxLRKObaVOkjkP6Ym8uXC3szzigdHftIJ80FIac=;
        b=EQk4TKJg4/OwZVmnfNvNCBGTXdn3+bAkv0hTm2iRyhKx7cHsl8FESFvBGug7Y4tmh7
         Ag4UzhZsiDdluWDBz+FsoMsUTKNHvK86TSVb6mx5EGLdOGf9oK2slPUf155yyAidqIRp
         rAPE1sVU0hxTSXUx6Hh0IvmjHwjIH0YRVO0ZgFeKMwAh0/LdRMBfHL98HM/pYvp0w9DA
         MYqOBmtKmKu7QvcWIrj3MfPiM++zV+dVUQuAXu/zF/XjTbs/qCCw1dj/8dv/M5n/2OzZ
         11Z0SDn7aQJQZZ65AVyg4zkV1kmc0t5E2ob6IeO5Kb8NHjuD1awZGoJadPa5YXKAdZGY
         wObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790628461; x=1791233261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FxJggxLRKObaVOkjkP6Ym8uXC3szzigdHftIJ80FIac=;
        b=XMHmE7w3ZTfYc6YnYtR0PtwV63PB4VAcXXuJ8kiK/NAvmK3nakdGbwox+McV/qR3uI
         5N0f9+r4g/Cngz05d1EmJ4lzOBUrMPqlqo/9caANlmWD+L2hRXv0bC1hQOFsaW6T1Xcx
         XQqLzcCraXMb+hVudSv+AhX6wp5mfAQIR+Jf+WWFsARdfoLYtfTOvRVH1GZjzCTrXRk2
         tpu1KJSVzj/XH4y4Tt+Yf9zsdVu90MY6KiQlw4tvg6oJV6F272c2OBx7RxNhErkxZx8A
         Qh7cTmmMPQELyce9ExEJf5t4YofDy9T9bw7x2TZ76TxRpuc5Aq9Nu1p8D0HBdJmcjsiX
         YlGw==
X-Gm-Message-State: AFq9FYKSwJdqS8o2KrGoSWJytnhvSuWjGAySLxESK1O/nWMV02pcBBf3
	a1YyrxeiMVOwMVncTTGl2TFlEp+NLwW2gj/a0FJaAK1Gbktk8f15EcBdXx2EuFnMlCE=
X-Gm-Gg: AYBFou2aFstI9eG/Hqop0jwH09+G2AznTkwEOxMp3cmk52rIaaW8wgAU7AJPmqFjt4B
	uxF80lCC03AdBZycmItzS+vXFY5xOFDaiglb/NjGWPt7FLvce8DQRruOkgaq2t6jj1YPYSFfcIL
	FG/QnhjUDd5HuREgafom6JegZHrjQ7G+GwAA4i/jTbywmwJLcRJHZcOBXo2Xrklk4UywXxEp1bj
	4NeHhMwQJFYQU5wvoVlcvQqmG527G1dvhxcWUN3a82HWLGLt5UqUqy5YGcWByrTQ7anft56Kkkz
	xeucS2siYWpygmDRwoweoYqZwzFnFOymhY48ahOD/kP1Dw0HvSJ5EGquFVj2wrBDhnP1TtwzOYw
	aLFO/n+gRGZHckS7+4ja3pCYV5t3GCiCfotUxNf/i0K0JscqCq7WFtJ/zSYPFM9jVrm9L5PLlHS
	pxJmMmVqaT0gakuWbs8TjaadevqdjUoYAxiqqT2ZMjj3v6ZkKex6MOk5BVfmSBAISb88p9wFC6J
	Lwrve6fqDG3uFgpmfneV1xfXSAa0eEk+8GX166aa5llqTSQZYfp8TIK38LykrpE
X-Received: by 2002:a05:6102:4b10:b0:7a8:15ba:c509 with SMTP id ada2fe7eead31-7af1c99c07dmr4618947137.1.1790628461392;
        Mon, 28 Sep 2026 13:47:41 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cde587a790sm10296980e0c.9.2026.09.28.13.47.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:47:40 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] build: Fix coverage target failing with stale .gcda files
Date: Mon, 28 Sep 2026 16:47:30 -0400
Message-ID: <20260928204732.1265535-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Coverage data from a previous build is not overwritten by 'make check'
for binaries that are not run by it, causing geninfo to fail with a
stamp mismatch once the objects are rebuilt. Zero the counters before
running the tests and mark the targets as phony since coverage/ is also
the output directory.

Assisted-by: Claude:claude-opus-5.5
---
 Makefile.am | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 53a3a15c3f8b..24760ab08687 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -999,7 +999,11 @@ if COVERAGE
 	@lcov --directory $(top_builddir) --zerocounters
 	$(RM) -r coverage $(top_builddir)/coverage.info
 
-coverage: check
+.PHONY: coverage clean-coverage
+
+coverage:
+	@lcov --directory $(top_builddir) --zerocounters
+	$(AM_V_at)$(MAKE) $(AM_MAKEFLAGS) check
 	@lcov --compat-libtool --directory $(top_builddir) --capture \
 				--output-file $(top_builddir)/coverage.info
 	$(AM_V_at)$(MKDIR_P) coverage
-- 
2.55.0

