Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB425B21A
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 22:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771367428; cv=none; b=QaMF9oM4hen1iZWs61HdL/H7ytjzAXC1HsVCAwHWSuG2KPCFyJHFIzCtgGW67/lKTbJOChH8x60obBhnPmLDC0BTh4n2w04WHq1Gb7tiULRQUrZO1LmvIKKRId2eG4HIOaN980a/m7konePRnAzs755yMqtOkAxUIp7LYJBCjlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771367428; c=relaxed/simple;
	bh=50vrMMSSnfq6LSizEz2+AVK9XeggZQ3UgsBe+vkvQr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cIIAqQ8CYFtXRIxZTNhbcWG2AGR0HkEmK10uo3SyiE/5+4bru0ACylfutEMwboh9J9yyZy7WjwK55lPfB1/i6EqeAMWl3i+kuZ2MWu9k+e0ieH+pSUT+3TneHMpS+F9f56H6uigP3rpZrVQjwag91GmlIhRFQyP+pf5LJvHNyw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=belunktum.dk; spf=pass smtp.mailfrom=belunktum.dk; dkim=pass (2048-bit key) header.d=belunktum-dk.20230601.gappssmtp.com header.i=@belunktum-dk.20230601.gappssmtp.com header.b=SIro84Qa; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=belunktum.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=belunktum.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=belunktum-dk.20230601.gappssmtp.com header.i=@belunktum-dk.20230601.gappssmtp.com header.b="SIro84Qa"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-386714da2a2so38931841fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 14:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=belunktum-dk.20230601.gappssmtp.com; s=20230601; t=1771367423; x=1771972223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xBB9Ot5U+S6u5qIoBQ++y/b4gm/8fRaOsbLrfjkQx/k=;
        b=SIro84Qat+Llqsk+iTUSJK+ELBcYVbzoQY1YRehEA3xxpYv7uBmfPDdMN8qaVaiBsn
         ymk1Bq62FaF2DhdyBHiABt0NOlegydDOREOBq0QOoICopu2A6/QxoKUUL0yRDY1xOKOA
         Jwo7Ud8vH2mcbEBDHHqoS8kv12zPdW+YH1aFZbd6fBWXGC83Yba7U7OQfTSeLWvro0H1
         K/fl9K/r76Dycvd8kJhVhDCEpoV3RLn+z9mxV/JOLwdsqTDUeMVUuFocEC7XuhVbiPnU
         WHlQqG/y1mLODQQFX7U+vRlG5Yv943ZeOalHfJ+em3hTBUtIIeMn7Uo5jJWi5vHdpNVv
         WaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771367423; x=1771972223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBB9Ot5U+S6u5qIoBQ++y/b4gm/8fRaOsbLrfjkQx/k=;
        b=VH14nkmUnND2Huuilvdc/MoH74hQP9cdSa4sC0Murp9oEJc94vcvE6pw4qxe30oDX1
         9h9aEykv8uws6sgrzuRVYYn2rXzvflmHPSt6E+mqejQoQlQabHSUDEBV+F3JK858mWh8
         E704O1+qk4Ws4w/IgIFDNc2iOd2Z91xe1GOImey1ZSpfZyIwMu8pzBnwA4OYF6JrMcNl
         tK+9c6gfCzYty+iQejzMi9Z1knosrOMmUynEFWQMydYHaXz3WtcqPGP71DfykFmgm+sI
         Y3J5/iDlpgE3cjmuHENbv9l+mB2dLFNGLgl2xsilctEmI3sZjeVd7yCmMmsMilyCiXdQ
         u6vg==
X-Gm-Message-State: AOJu0YwamQ5Pt2Tdzv2/2cRKlU/p7zlUv83dFQ0RXd+DZJCNQNt4tVZ3
	ovuHNOXEAjQ+lF4rm2IARv3jcdOiHE05KBPe7MQCdwHV5mZu825LQS+hgnVRe510cyEdDxFdkY4
	524dhvuc=
X-Gm-Gg: AZuq6aKE+fTxvwIsFE4RUG9ZAOcUoRHIIYel+X2B6CUbE04Sh5E2FYAgwJVsWKzd0n2
	PzMY3H6OmndZ5x6km7ZzNy27RKHA5F4XE/aEMdC7KZbTOeOZ6F/nakHsRiLauIrmb9BzZUfQFuq
	o3pNozo5Yzt/jvGu98cJcLFxJqB21YNhSP/xGVU+RB9Uw7N8+kkXcdpLj5SIP9B3o2KyXfOqiti
	cYGck0WFKZNeeps4hMCqLAFqAI9EAfUbjeVAN8jMoSPbjykz9RX4MbDLHSH5BbpjiJyv5hw3ItR
	w9EwlEvb2uXnuDsE1Q2Z0LqQAavLXaMbhRz9bQG8VzaCoXcK9K8J24YZ4mas3KwZUNlgrhH5JW+
	BwwrzuIaHJoogaCDPTbrQlpGMZ6u4PAO6E3RaoMkWXa1zMMyLJB0BxvWirQiEqQ2ENQT9yDIdS6
	hDOE96lrYrUcocwPAA4AKC5S5kXUs4uWIbQnVWP6sgZV0zTIEgxEX9c6lyejQWWuYHi4iOVWlyS
	9GoxPvZWfIOoHpIToeht1777OQG7ld1lxc=
X-Received: by 2002:a05:651c:41d6:b0:383:213c:fc41 with SMTP id 38308e7fff4ca-3881b8b4321mr39321971fa.7.1771367422676;
        Tue, 17 Feb 2026 14:30:22 -0800 (PST)
Received: from localhost.localdomain (2a06.4004.2134.0000.f86b.13ff.fe7b.2b85.static6.kviknet.net. [2a06:4004:2134:0:f86b:13ff:fe7b:2b85])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3870691bc28sm34052091fa.40.2026.02.17.14.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 14:30:21 -0800 (PST)
From: Lars Christensen <larsch@belunktum.dk>
To: linux-bluetooth@vger.kernel.org
Cc: Lars Christensen <larsch@belunktum.dk>
Subject: [PATCH BlueZ] shared/shell: Fix bt_shell_printf in non-interactive mode
Date: Tue, 17 Feb 2026 23:29:54 +0100
Message-ID: <20260217222954.432676-1-larsch@belunktum.dk>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e73bf582d ("shared/shell: Don't init input for
non-interactive shells") stopped creating input objects for
non-interactive shells to avoid reading from stdin. However, this
caused bt_shell_printf to stop working because it checks if the
inputs queue is empty and returns early without printing anything.

Fix this by moving the empty inputs check to after the
non-interactive mode check, so that non-interactive mode can print
using vprintf even when no inputs are registered.

This fixes command-line invocations like 'bluetoothctl devices
Paired' which would execute but produce no output.

Fixes: https://github.com/bluez/bluez/issues/1896
---
 src/shared/shell.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index f014d8f7c..61b003819 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -711,9 +711,6 @@ void bt_shell_printf(const char *fmt, ...)
 	char *saved_line;
 	int saved_point;
 
-	if (queue_isempty(data.inputs))
-		return;
-
 	if (data.mode == MODE_NON_INTERACTIVE) {
 		va_start(args, fmt);
 		vprintf(fmt, args);
@@ -721,6 +718,9 @@ void bt_shell_printf(const char *fmt, ...)
 		return;
 	}
 
+	if (queue_isempty(data.inputs))
+		return;
+
 	save_input = !RL_ISSTATE(RL_STATE_DONE);
 
 	if (save_input) {
-- 
2.53.0

