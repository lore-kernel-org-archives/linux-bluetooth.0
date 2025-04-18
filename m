Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6526C2868B
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Apr 2025 21:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745010612; cv=none; b=QKU4ub7ma8DaY8OD6un4Nkq62Y/pLp6Ma+jRCYXEn26EUVe3g4y+VDvGOLQG7+2NeYLoFIsr9gD4edvexjxyBPaTFGhd2C0Zbn1JFHdFhxUnvBDoTXmnlS3rpVCYC/paxgRl1Jqm162OkWL9ksSrs9fv+YVH/ZirSQWLHQOLx48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745010612; c=relaxed/simple;
	bh=207amQEoabngfSRxBlxgRwnh57fcKBRcJO/EipxXDZ0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qbNlzK3UCu2xnyA7i6KMxcImPYRVI0i7Si+JxJfuumQF39GiDwGmT1HFSfOmSSxVvMpW+qAnQq2pedCkQdsMtv5F2SckbGLDCEf5u2RdHQn3KXUR6FfW6Ku3NksZbTZjunTEE3KaSxYB7ABh1mO5ex5crqTyfNZ+DCQDQ/mz3Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qutp5FuK; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qutp5FuK"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86dddba7e0eso862097241.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Apr 2025 14:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745010609; x=1745615409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=e2WKQyvt1FpuWtr2FS4XAZSIkBKks0mvpixIdUlo5T8=;
        b=Qutp5FuK1fIUsAnT6unLXmMcdX4MHXOZS9ct1v+wYrUg/VylfDP/Gd1ikScwVLBhaX
         6cRXXj+YIg4w3KyS4EEeCAx3u9uxjXZJ05cULhMw8e6AGlnVtXMgrIl54SxvrIchvp41
         UA+OBCf7G2K8HSZDtyDLmpR4ux3lmfzvgD6UREzxB5EcJHFf7z11o0cSCtVXxP5UjsH6
         OkRGYrVILS4C/8iutwQeydEyhFwaRGOJxXbiFXiq63aNRDdA/M8JexKKArIWyq8THvip
         OsqCOK79bxhQwceEn2WIpXhvmeJz10Vka+1FySX4AJGPUaL/ItbYTmIW4VZ7A2vZHP7A
         2D/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745010609; x=1745615409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e2WKQyvt1FpuWtr2FS4XAZSIkBKks0mvpixIdUlo5T8=;
        b=FWW2vUxsFHr7vlsaKZwwKWE04i+UbcdtE/BPHrGZUv1rBlDppWUDSGUQ3j9/R0W5nO
         6JIzR5KAAXyeMx7vBOaNVg/yvu/t2FYrOebiDI1apYxLlJG512RFwbsQH2UJ61GBhUAS
         M1dKRMAXdhn8ZAhYOQDD1aQhMx/1yJxRRSRCy0Cmx70fNJinRgtezecJ8h1anCuthfou
         vc3AsBE5tHwevzN/duUexyDzcJ3kZVjRSYAv95HaX253rcvqdoZ0y85Wdvs7SqrMEDrK
         OeLQrIcJrMpbnVAhzZ40F4a1beO25Qf1Fug7UjF1h3dqqVPTYEkmPIKMqzZORT5R2QQi
         PWkg==
X-Gm-Message-State: AOJu0YzMWCuANcZOl43fGOz/B62cfJn7MaCV3HZGwC3ODvEzvvI0Fg52
	mO+pGV4DvEvXLLe6LAvDf2XCTx+CUfFbixeM+J6uUCgB7SU2R3OduLREGgEE
X-Gm-Gg: ASbGncvPCK5PpBZQym5Lmwsxuz6MvrK7oOcnBHpxxHSSM8pmtGRprwVt/3JHEpzcw1B
	ZcvY186uc1PyC1wIKj2l0GRyFn43S0/V+fkhz9dJo7Ujpiq/F7drk/9wEN7TgWUGM2QjAOtgFdC
	n6Fh/RoDqcDg64idvxwRx08MAWAduA9tRQakR+U/n/Mymbm4kIHfyZ31pUJ5TDa4irfUhgK3ISJ
	7vk1kHtufJm6gkREaYe08naKeZPvbRnCGkMbfSLiOzE0gt4PpV0Oa7h7CQG9Q8QVHXeEjCWoK3/
	WwV0FQIvPVvGMvnSXNObGuQdKLW0Aj0n/vNvv6ZlWsoQ6L1K+j/yA7qApeRI3RDXEXTyq9uguPN
	Jvo2r1rOqPA==
X-Google-Smtp-Source: AGHT+IE8ka3OpQfNrrxZcrjBVwOmwkZDKQkSBGf6uXOCgRcgf75ypBnDbJQR/6jiV3u3dY2SWtPqnQ==
X-Received: by 2002:a05:6102:53ce:b0:4c1:9d9b:54b8 with SMTP id ada2fe7eead31-4cb800d7eb9mr3039546137.2.1745010609557;
        Fri, 18 Apr 2025 14:10:09 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87764651980sm602740241.1.2025.04.18.14.10.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 14:10:08 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] workflows: Add stale action
Date: Fri, 18 Apr 2025 17:10:06 -0400
Message-ID: <20250418211006.304767-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds stale action to which marks github issues as stale after 30
days of inactivity, after an issue is marked as stale if it remais
stale for another 5 days then it is marked as closed.
---
 .github/workflows/stale.yml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 .github/workflows/stale.yml

diff --git a/.github/workflows/stale.yml b/.github/workflows/stale.yml
new file mode 100644
index 000000000000..c6d6134d9d00
--- /dev/null
+++ b/.github/workflows/stale.yml
@@ -0,0 +1,14 @@
+name: 'Close stale issues and PRs'
+on:
+  schedule:
+    - cron: '30 1 * * *'
+
+jobs:
+  stale:
+    runs-on: ubuntu-latest
+    steps:
+      - uses: actions/stale@v9
+        with:
+          stale-issue-message: 'This issue is stale because it has been open 30 days with no activity. Remove stale label or comment or this will be closed in 5 days.'
+          days-before-stale: 30
+          days-before-close: 5
-- 
2.49.0

