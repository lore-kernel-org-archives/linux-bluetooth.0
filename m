Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914F41531E3
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 07:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730445602; cv=none; b=Zo0UEPw7NjAl+XgdRWL99AR9jIAXKqHbS0dtUylQMo1KfywTZzAvxxsRGOnZUSBZ/YesuYzZDHumSB3vxFXCCUxiIIpKML/MxrNuNWcxysKMzYfZhgvAWJJ9ZhcF+QljFlL72dG8+pZoPfFQXruLsA3JOLBXOO85xT3mm2/7Sp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730445602; c=relaxed/simple;
	bh=0sp4nnWT2z0EGC+tm9qIRolkfOnvNYOdIswZ3IMeTbQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Fd/0SZg/mJ4gyFosCm/1dCbWPaMgAQj/zjqoDxkr2ekRikSe7c6PjdOlIf88ebBie5qCQ2ZEqpSZEF0zUUaAn2Ral1iPaWHM8tB467iDdK4htajBmmtEgSvhOz82/sE1iRGVw1uFehjzA4+C9yRNK6/s07sjVJ7krpqwDKgMgXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--howardchung.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A+KFELI3; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--howardchung.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A+KFELI3"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3497c8eb0so22948297b3.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Nov 2024 00:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730445599; x=1731050399; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=98vUBPXsrM1q9ndKg9WjYLEgprci7OjqQjAo2hYSXmI=;
        b=A+KFELI3iAJkxgv6r2HCJqX2TfN+EMxXnSOhAONuixReTtJqewWRPx8jpHdB+IUK6h
         MsDuWEQm3RCfyg10y8wQMiDuKv3SyGPCRq/6v3qF3V72gxlCenyTIuCBeNYf12qaOCFB
         u5m3ib0L5FNEFW2aT78W2Pu7d0b06BR8ny7jehW1IBdgCcD2hltSaMfOSNciYTi9Wl4n
         gq6vJtA+DsjcGiLQXgc4rOP9TO1Nyfcig7FeH1Rwi3y1iDgsAV75my9SpDQ6/72DDojD
         YS64nJ+IvYrZcqL8SBzDhvgAkvaNT5EdH2KRdcQuzYIYib6KsK6wV7skg06DZLsUvyMg
         a1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730445599; x=1731050399;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=98vUBPXsrM1q9ndKg9WjYLEgprci7OjqQjAo2hYSXmI=;
        b=YJDVIExPGBbbvkgxStmfddqWM9lVkwyACItK3cVgGkgUOyCvfV7IWrCLCs4ahmpqsB
         UXvfjBL+ihOhX62NEfu4+dX9nFt2vwo1B6YgAUx/mnTNbhjlS/zA6IHfe1eDq6n4Q4ms
         fJJkiX2lAulqF3bLeOcTR+XySvOOckgsLHe31KUJldk16wfEv95+yWClFkXaz+a/V2gl
         yeslIsKFrcw1a7B17GklzfRo6BUbDgTzzVMWbcJ4yVUerd3ukjXhHGpVGHy6pemmm/IQ
         CvryitZwgEpBPn2J+2hDFzX1JPw55IzyGu8wga22jkYxY500gfm/IlK6PPlwNlzIdYzi
         RVQw==
X-Gm-Message-State: AOJu0YyltNxKzcmbYPuHxHmPz7ycQDy7JdzVGT8LUVrml621Wufx8yCA
	HymnulkeKxJlWcAQ0DFjUVZrmXDLici5zE67rsI57UXS5rnHXptTWRwqLabu3VnH7GBIOfSFgkB
	CKlS/YBf0u9us5Rm/TdJkiFcD9UteIIw4/3u4WQ9jKq2NkUDafPQYczliMhlVubQWG+RFZib7vb
	QpELd7JD82rCDGxBQypGHHpuUmX0ZjNx5uiLqm+Ybl6IjBPAyHDIMRxos/aDkW9oE4oXoJqGQ=
X-Google-Smtp-Source: AGHT+IHt5sTRH00PPUKi6Oul+WuKOhVGDi+mDHDYu1zmHopgRiywnYVYWXl0eO/iDf3BLWx+NYHeiA7gqTaq40/ieQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:17:5b55:2633:e9da:b2ac])
 (user=howardchung job=sendgmr) by 2002:a05:690c:200f:b0:6e2:ac0a:8982 with
 SMTP id 00721157ae682-6ea6413e043mr373317b3.0.1730445599497; Fri, 01 Nov 2024
 00:19:59 -0700 (PDT)
Date: Fri,  1 Nov 2024 15:19:39 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101151939.Bluez.v3.1.Ia122d85386d6c2fc69f5b3d7ea7a7169f73756e4@changeid>
Subject: [Bluez PATCH v3] textfile: Fix possible bad memory access in find_key
From: Howard Chung <howardchung@google.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: Yun-Hao Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Yun-Hao Chung <howardchung@google.com>

If the searched key is a prefix of the first key in the textfile,
the code will assume it's not the first line which is wrong.

The issue can be reproduced by a fuzzer. More context can be found in
https://issues.oss-fuzz.com/issues/42515619

To reproduce the issue, please kindly follow the instructions in
https://google.github.io/oss-fuzz/advanced-topics/reproducing/

Stack trace:
    #0 0x55e1c450e7ce in find_key /src/bluez/src/textfile.c:133:9
    #1 0x55e1c450e7ce in write_key /src/bluez/src/textfile.c:244:8
    #2 0x55e1c450dc33 in LLVMFuzzerTestOneInput /src/fuzz_textfile.c:61:3
    (...trace in fuzzer)
---
This is reproduced by https://issues.oss-fuzz.com/issues/42515619

Changes in v3:
- Add fuzzer url to the commit message

Changes in v2:
- Add stack trace in commit message

 src/textfile.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/textfile.c b/src/textfile.c
index 313098f38..8188d2ebe 100644
--- a/src/textfile.c
+++ b/src/textfile.c
@@ -127,10 +127,10 @@ static inline char *find_key(char *map, size_t size, const char *key, size_t len
 	while (ptrlen > len + 1) {
 		int cmp = (icase) ? strncasecmp(ptr, key, len) : strncmp(ptr, key, len);
 		if (cmp == 0) {
-			if (ptr == map && *(ptr + len) == ' ')
-				return ptr;
-
-			if ((*(ptr - 1) == '\r' || *(ptr - 1) == '\n') &&
+			if (ptr == map) {
+				if (*(ptr + len) == ' ')
+					return ptr;
+			} else if ((*(ptr - 1) == '\r' || *(ptr - 1) == '\n') &&
 							*(ptr + len) == ' ')
 				return ptr;
 		}
-- 
2.47.0.163.g1226f6d8fa-goog

