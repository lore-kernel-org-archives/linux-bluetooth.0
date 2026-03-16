Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1713D391832
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Mar 2026 20:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773693812; cv=none; b=BmwfBRn7QBwvywVDMzcerTpnpW2e2ic8DBYci2ZD2bOZ54/aC3M5MC+3yjIUPHZjHUx12YsDBA8kK3NGv9Nob6lcUttF+rcQYpYhEoIc4k7d2lXi/s++T8CsE/TIrOZLVUnshYJbtv8JniUfNjE3STbi64TeWGuyyETCfleNlEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773693812; c=relaxed/simple;
	bh=DJLzU/pGMwoEbqUum+MGltORK6KC/sWNCbjFpxXpGwA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gcPcd4vO5Q1rF6FJZVqhug57vwKhGVF08pGoSTjo+bqciCGCKp4hA25eOvnoB6MfEvJ3hn67cQq58Ka4zZJicIl48ywsErDVeFNnQ/Uxi/emIGiZWrSuhb1wMSZgtyAhOk+HBxA7BOrveIn0VCV8U9e7QCM/pbpsV2SowOBt/zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axNDcub7; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axNDcub7"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-56b67a6eebaso723595e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Mar 2026 13:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773693810; x=1774298610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=l1ebsmADwvxZif+iyaGr9Z3qMzt05XQ6E7XoH1a8GNM=;
        b=axNDcub7xXJrGPD4wsje8Lhy047C/suSzRCVQdFjlX5aOIV7lg8lcbrjY3W3gjuFdN
         pnbBYzpHuslGOhTJXA8rik1ixYmr0KNCKCcAJfbPGbpRuWxbfSro8L3LAq/31P26jRJ8
         JIytbIZBDV08WsHbx/A5fsOaqgiDYC0gXWjxgNygJC9WjcD6bKC+VLEau6nPT46JSFsb
         FYX52fBhwvn/jWOx0tFktMhKMtI+uVLtv3+K4Tv0hTsvjE0gXCsTBdUSHR8KpqHB1im0
         WS5L7SSINEgeaBYlLaKlge0qV+iJTrYGr04OXXz4EWm0arPocuA1iS6F/KJmkm+y4Z+i
         MeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773693810; x=1774298610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1ebsmADwvxZif+iyaGr9Z3qMzt05XQ6E7XoH1a8GNM=;
        b=UxtAfl+GQGomqHub9jy6TIgOUSucpYpjduyjxePrElKqAga1mNo3oXqkhQD74Y+0R5
         xky26xz+9yH2CGjbxLJeZKJHfzf/RhVnASeCmInP3nMv7G5oRRhpaWwG8W/MBl79e8DA
         GrWDkYUqCVrpaq0Tu8djN3ACfemL+t5wr7IP3f4tvDeZP3a1Nt0fJs/XtwZAkvDGxpLN
         DHl0fAokfXMvHGFx3+sdMfGk+Yo8LMbeOlAnyZSGYCEcVVZE4M37dkyrbnWQxBD3AG9b
         N9P4oxRtMZ+psfqq0ZeqD7XmcDVpk9Liw2GVVcpuhkeWCDZ6RTNqL3JrE3bdxpXS5Ftp
         gGEw==
X-Gm-Message-State: AOJu0YxlWydybsE9rcGtx2wim3rl2mIBdutiWpF1DdDuJ+HZzyB8fZKt
	VmqyBfScjjqUwVZyJfoh9+BW3qNgHHvwQxPwpvE5IdNw+KYUAU88uVMXU7AHzH7I
X-Gm-Gg: ATEYQzy1fmtPeRDcFrt3A8js9z3O0ziVUuuzwBS8oFsmMLX+u3Nqf4dM1WDvLh4ZBq/
	cfathwBYRFwihIZsbJrCpYNXjAfZqTdlETTS3JB92x0YZUxrg+ByWbHdnGeU2tHGoKNjFhvCJzD
	VJRUU3QWXNkS4IMAJKrTq43qDCCmIqfC1t6haBwldaelTHt4o0yBWLiA2WcvjXtosG8E5O0F0Gn
	GJO9lE7ruTQcC+sOzwxkDIIMXSi5FiwQix6oNiJptQHtlA3kPYvej/mrh2kk/PCd1RoqRan+Dxx
	+Rt5r/cbXj0wGSJmftF2kjm/R2z6XWlykoBPnAK//HU2ef84IQda4GWyit3M/vOX6sBYz+iHLDm
	m9FBQxpzmjIpNKPg9y5pKn4PhsBUPvAEGp00Oho9K4Dnhek4RsTFe3Bv2YEpfTathESE3St0RE8
	K3iteLFQHYyrtZ2gfOU2rRALVoo0SU+fLauNhKEMR7xaGUJJQbhlLTnDI7O5St+zp7IDgm/7JuP
	hQsbQcNgWrVTvU/KA==
X-Received: by 2002:a05:6122:2a4b:b0:566:24fc:9501 with SMTP id 71dfb90a1353d-56b6291453dmr6226321e0c.6.1773693809840;
        Mon, 16 Mar 2026 13:43:29 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b8cbb4835sm1661253e0c.0.2026.03.16.13.43.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 13:43:29 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/ad: Fix not checking length on ad_replace_name
Date: Mon, 16 Mar 2026 16:43:20 -0400
Message-ID: <20260316204320.57220-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

iov may carry move then HCI_MAX_NAME_LENGTH in which case it is
truncated so it doesn't overflow utf8_name.
---
 src/shared/ad.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/shared/ad.c b/src/shared/ad.c
index ac238014bcea..b1d1b84611aa 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -278,7 +278,8 @@ static bool ad_replace_name(struct bt_ad *ad, struct iovec *iov)
 	char utf8_name[HCI_MAX_NAME_LENGTH + 2];
 
 	memset(utf8_name, 0, sizeof(utf8_name));
-	strncpy(utf8_name, (const char *)iov->iov_base, iov->iov_len);
+	strncpy(utf8_name, (const char *)iov->iov_base,
+			MIN(iov->iov_len, HCI_MAX_NAME_LENGTH));
 
 	if (strisutf8(utf8_name, iov->iov_len))
 		goto done;
-- 
2.53.0

