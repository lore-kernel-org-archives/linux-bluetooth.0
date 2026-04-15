Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82181EB5E3
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776277347; cv=none; b=b8LmwJiDrTGpCXtns5Yj/t8JJRMdb5pcUuI7sg35SPUWCe+l1kitKCtbPuJL9KHi1YjpbCS7ZyKdAPnHBhJxgo5otgL9/Ofl20ifr7u/ZiJSoEiotF18FwGB2M+FG565x3So+t04V1irJ/brmWsH5iXFCio4anG5fLH5zPerC9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776277347; c=relaxed/simple;
	bh=S+9HFrwLlmepBIC70p0gBR1t3tDX5gfp2DVSBvnx85Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9kfgTbXHLCUSaYP/tvgaVFOLTe/kdVRyIEeQmu159bTKBkP1ei+eawD/eEsI8J2cvyLAFeg6ByVmSgA+IYZ1sjvs9b6SJ6gWSfLL+YRI8xCS5kO+Rga+5ZUuXpyvRz2a1cyu76A7Ng1652/CW3/2pRxGEq0M9yHypzGTRnf430=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzyvZXH0; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzyvZXH0"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-6137374b106so314376137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 11:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776277343; x=1776882143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9VzBYTa0U450LJvpklHr5OCVSzdp6jaguTVgHi3b43I=;
        b=JzyvZXH07UYY58duRHpiPhIEfyN/lGJFe3+J+as06ZnXFOvdv7XcXlYd8Mq/nFNWGP
         yOi0UoxhNOk/hHcADh8ogqLbQCs6Mxj62Czl/cJqCjTuy+o/4ykfP1Z+KvU2GtbvVhWE
         AW6f+95frTIEBDzNroWDnZmEuV2lj/ardtkdaAirt9sSHK6YbbGblp57WB2LQ30B41SO
         SJL/MX/cSMA8GXCFt6if91cD06LAMyN+RKiBcT0oM0ZRQCCWYxk5P+eRp+VZj8ir48X5
         mb5MAMJQqLN6j8lVrK1dpVfCgr/6zeK/UfOl9lqvllbQnHPn3nA6B6X4XD34MWs1fFj8
         YNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776277343; x=1776882143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9VzBYTa0U450LJvpklHr5OCVSzdp6jaguTVgHi3b43I=;
        b=sMNWJRGI3L2+xGFjd6KgYG04DBxFYiaWReoDRDf7qFNsSoo70sp634flBS+nV+6Twq
         4kTaWfTYUrJW33XevAnPeQXpAQQRV1v84UV8K9ZCLyR8s+sXGseNp19QEJJbqUozA8xa
         mVK/fVJOvwWqr5jEdHUkUE9Ng1X6UwMuDGU3ydlpSkIt2omuCS5mNPY0z56bWsHT++59
         55nCdE0Za2/RwUFOD8K5fJstzln6UAkpm4QTPnTYP/4Of7OyJcr4QPY5JZ57F+QffXBM
         8dDpibuC1dM0fhCY743qDXTAwHVu9HhKjPJNVYMKf2tDu0n4tEvUKhutI33+C04Rf65b
         iTcA==
X-Gm-Message-State: AOJu0YzhVmtxEu4Kn+yeXB5uST8NfOKb80s4hltTxY5NBBsW+yp/m9NU
	dslkMvoV4zbvsbZNgOoA4LMVusdQy8vcOooXnyE5+Y4HsdJQ5e67gyD7NDTN0lnMPls=
X-Gm-Gg: AeBDiesWlq1sJ1D03WUFr+3qvdev89egmMu6gsrrrW4xfSGyRgtYHC45XATEl0or/vw
	D9clQpssUrkrqG9ZIZR//blR/OxIEx8hUbv1wGbP6H4M44ElbbEvLuKoZHx5BLzGYXOvsrmIgRM
	xjST6XXWZrBw+JekujHQ6MHxPZLpSVH02t/AHxw6xJwciTDULfjOOr47C+N4oA+4olcROhPlSXS
	aYGmYjbQMZ59Uyn0WnUs89UEMo9BLIdEfkHl2gnWkGYxB26MCBMivVIum9tNu6CdePTiDd1yU53
	wnYWpQwhJSExhsW5YgY/9+OFpvXtzKguOtnOC9HNWhzmMgqYPcZcNldEUFtIvwPded1QtfRsCNA
	JZVcuF7hw7tFPW9giMGGN1C5jAAIjOW0ct3E/+cZQ1MeuQHgznlY4MbrNSVXqOjGoMBUXzPch76
	Ut0ioM7psV0eHP4M3t5tGKe6RFYmD3kha25YsLt5GWcs+MlZcib43RtMfrXo6Rn8Q9ICAEXrM+p
	6nl9SN/Dh2xF7tvc8UN5PYlM6Pz8Hz5WXCIma4=
X-Received: by 2002:a05:6102:5045:b0:607:9b5f:1df9 with SMTP id ada2fe7eead31-60a0197f6f9mr11589831137.32.1776277343465;
        Wed, 15 Apr 2026 11:22:23 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-612cf10e76csm1219063137.8.2026.04.15.11.22.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:22:23 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/3] github: Add btsnoop-analyzer slash command workflow
Date: Wed, 15 Apr 2026 14:22:09 -0400
Message-ID: <20260415182210.514686-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415182210.514686-1-luiz.dentz@gmail.com>
References: <20260415182210.514686-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add caller workflow for the btsnoop-analyzer reusable workflow,
enabling trace analysis from any issue comment.
---
 .github/workflows/btsnoop-analyze.yml | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 .github/workflows/btsnoop-analyze.yml

diff --git a/.github/workflows/btsnoop-analyze.yml b/.github/workflows/btsnoop-analyze.yml
new file mode 100644
index 000000000000..484288c0d9b6
--- /dev/null
+++ b/.github/workflows/btsnoop-analyze.yml
@@ -0,0 +1,13 @@
+name: Analyze on mention
+
+on:
+  issue_comment:
+    types: [created]
+
+jobs:
+  analyze:
+    if: >-
+      github.event.issue.pull_request == null &&
+      contains(github.event.comment.body, '/analyze')
+    uses: Vudentz/btsnoop-analyzer/.github/workflows/analyze-on-mention.yml@master
+    secrets: inherit
-- 
2.53.0

