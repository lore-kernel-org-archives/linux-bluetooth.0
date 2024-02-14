Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4175D8ED
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 15:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925006; cv=none; b=eYuTDI9LYmk13EhEDNR9V9dLohQjEomeAMZPzNRR8CCSn5Uyepxlhg9BErh78MYpKIKznjCFGdHLnwzxwcEYlBaZZRwO7mlfR0c45yj1oJln6QOF/cTaSM9vnXv0th9ux32WyZi2XcjKQZfqDH1bWAGmlfedSxnzbOR75i9PTfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925006; c=relaxed/simple;
	bh=aRkHKEcAFeT9VZmuYNbHE72gVcrqZ2Po13oZiqW1KJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Crg5MgsnViB3nXidikh5SA5zHHudJoVQVofwtoGVDPCwtxa4BZOTgAkcISGtkNJjYPepWEpFuu+CocXH1+uHX0U2GoW+avnLWEl2yCy+t9Ncr+6n+5QTD0Kvcwz+NMqcYCTh0cqyWYKtVWHftU0BSxThE0QpQUUi9nDodkB/wcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codecoup.pl; spf=pass smtp.mailfrom=codecoup.pl; dkim=pass (2048-bit key) header.d=codecoup-pl.20230601.gappssmtp.com header.i=@codecoup-pl.20230601.gappssmtp.com header.b=25OCEJHR; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codecoup.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codecoup.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20230601.gappssmtp.com header.i=@codecoup-pl.20230601.gappssmtp.com header.b="25OCEJHR"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3d5e77cfbeso91415466b.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 07:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20230601.gappssmtp.com; s=20230601; t=1707925002; x=1708529802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hy8f5Uy+HjI1YVXQ9/qbplqtMtG6O7A68qRY7uwU1Mw=;
        b=25OCEJHRlKQ8idd7Weaz46GdxXBbsMwHd6oOsmNTPIWmkCibfCfmd3qPEo92BdytL4
         opfa3UosM8Iyx5csgi05CsEuHdtnshiTcqJQNBnJf3ih1ozHAiZ4ZQ4+e8TBMzWB0z5G
         7MytR6p+i6/jU3lMFrBU0bcpFMm6L+ei2IFh1fXxH3Hw40ZTeqEOFwG0xpXPefs1EEmE
         kgA4Zoczm1EhY6FJJ514gY/QqMC6Xozt0jSv1sc8vd+805O0symkrwCXcOnLNB2Q983q
         x4bSPo/q9bs4ATG7oVoe22BVZRoZ2z8OYx+suKYLJVba0yyOj94n3P1fE/K9D46b+ML2
         7HVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707925002; x=1708529802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hy8f5Uy+HjI1YVXQ9/qbplqtMtG6O7A68qRY7uwU1Mw=;
        b=xGaA4OUlTC5UbIYqj5LhnkN8jQGttnCWr46Aslaa52F1xbRlEp7z6qpkYUpxdzKiL3
         cs3ju0PeuqMoIO50LiwF6/G+4MlYPDu8Uea2WCXf7kL3e2/SHoBHgqGHKbrqzWSMnCnx
         ab+mMwvrcmeQ2azp7ReYhpE4nxSUhyW7N84gIjEG96kHWPpgfFhGAY/7s+2XaHPY5MRE
         ykSsl+7rQvdx92kaeGFl4n8UOYqZJU22jlbtWJq1KWxUnA+95lz67NDPRCq1/hVH22gS
         fInuLc1sWnx3Qi2CbqZMew1WYWVHxFsfq1KZtI6RdrpfMUsYeLogjiEwu/dzoffK7vtf
         0XTA==
X-Gm-Message-State: AOJu0YwjT+h9Zpckp1PgBlT0YmdqBe8OI+SzdpMeNsGG63MzU5sxIkaE
	mdzPplYWrZ7dn3ScWi0FI3mTFfUyWyztzTBN30SXCDpE0wJJbRhJZNYsXt8eZsf0JgbNkIJ2OjZ
	s
X-Google-Smtp-Source: AGHT+IEIY6nbLxO70t1kifurfsUcyX2nu3RuUeQzc3FcWSUU7kbqL6MrwMPWcKK0sbQHrURATg/EeA==
X-Received: by 2002:a17:906:2485:b0:a3c:ce03:5d45 with SMTP id e5-20020a170906248500b00a3cce035d45mr2209903ejb.11.1707925001846;
        Wed, 14 Feb 2024 07:36:41 -0800 (PST)
Received: from ix.. ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id wp14-20020a170907060e00b00a3d36da3a57sm858872ejb.7.2024.02.14.07.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 07:36:41 -0800 (PST)
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH 1/2] build: Fix typo in external-plugins configure option
Date: Wed, 14 Feb 2024 16:36:34 +0100
Message-ID: <20240214153635.156548-1-szymon.janc@codecoup.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was causing build errors as macros were also generated with typo.
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 05c76dddb..70e9d4be8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -364,7 +364,7 @@ AC_ARG_ENABLE(deprecated, AS_HELP_STRING([--enable-deprecated],
 					[enable_deprecated=${enableval}])
 AM_CONDITIONAL(DEPRECATED, test "${enable_deprecated}" = "yes")
 
-AC_ARG_ENABLE(external-plugsin, AS_HELP_STRING([--enable-external-plugins],
+AC_ARG_ENABLE(external-plugins, AS_HELP_STRING([--enable-external-plugins],
 			[enable support for external plugins]),
 					[enable_external_plugins=${enableval}])
 AM_CONDITIONAL(EXTERNAL_PLUGINS, test "${enable_external_plugins}" = "yes")
-- 
2.43.0

