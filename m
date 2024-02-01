Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E460E85268
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Feb 2024 19:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706814610; cv=none; b=oyahPC3mwmA0IAHr6qikkFLrlOk4TALEeVfKxHqSwja+WXOB/s89v4nnSyxDM6uwj0rRK3794cqaQBnaGL3Aa2q913Sci2sEeTEKbZU6d04Tq1E92eCHFk98f4yD3ALUpgwnAEzn58Mrhqgqh72VVyjjFsi/zaPRxKfjQxZn5Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706814610; c=relaxed/simple;
	bh=dOOpHAPXm8BsA8Z11Lydd2TjPtVhfXvcQFXbe/GdLVY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RuLJ9OvEJMtbPsvn1csnfIEj/gsUZLauosrJWcJZm+aokbQvWxqMGpYGB519+4UW3RGakIWlJwZE5bY4sz0fIopGlCGP9YmYqzEfQGi11LNuXGeArrFXE1YUnj1VoR4+ZRy4557vFryYXhs009aiungT8C8Kt4LdSxrGbJWju6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8n314In; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8n314In"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7d2e21181c1so649049241.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Feb 2024 11:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706814607; x=1707419407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=85jg8ARE52zUhjrDENCBAFvfpYN6H2nEwrS36GRf8bc=;
        b=g8n314InFAkzbjPMCcgRO3dNmErwc3IP+kn6HIViwnbh2rMTg3bVG92QEdZkcSCCgZ
         q497a4PBUCwX+Z4Nbw/YvtsMVEbWwdSIAaKt10QXJpLqikQ4TBUhQH1YFTdVf4cRiUe0
         eaJ5KZAsYYShOr9jiwuTe1qUWtgKTLZ8o9VhnScDblRLqDYrYFPtbiG1kReYGorEPhW0
         HzfwGpRkWSU+Oi96jEky6dfOb2qYJN86X3UHCu3hzlijHFW9dwIo6EBc9c71t5D6w8PZ
         d+KQow6SwN442BGzHHmy/g7ss8Mw8scrIXtwoNpOJREhXJCdtFPyZ1p5lxHSsEDmgRT0
         vw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706814607; x=1707419407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85jg8ARE52zUhjrDENCBAFvfpYN6H2nEwrS36GRf8bc=;
        b=Vj0B1w3J6NR6WDJO4y0O6rNZa6+khXaaAi2p9aOFAnegA67vKJLtrlQs9LP8BNhtnS
         DK6ZPDp1kPzTZ1GHQeZjuZj31OkmiGiEQM5rf47PBwe8g4d8mOWvoGlsMY4sED8tVyhR
         +H9Fbrs8w0j2wkYfsR/4wFeQdvq+mN7kTfMISrsrHDQIFQ3S7ADRzOP9AF55kuDfosa2
         E3WfZcJSsppsUd/N9VrX5FQIX57cIYTH+7L5IjKe4pKNw3Y+Welf91mcw5i659uY2Sw6
         oGZxnjzr7NQz94ZykV0HFhOwSYjCpN68KitXaI9Z8OxFnP9yJyW1axl1ipSfAnmnicsQ
         xK/A==
X-Gm-Message-State: AOJu0YwnsGicso+o2ovg5KoU0k95swFrOAF5amM4vpkl3WfSMi6RP5r1
	TLE+XUF6gnEJ/ARp5e7tMnxAkx8aSA+Vtb766uhRlEamOb1P/YP5VtjbkfZC
X-Google-Smtp-Source: AGHT+IHrSFlgxS55XBfUeqlIxIpqGj/ON72Jud/b4sA2YsN6IYHPCO0PqFtNgEeLfcTkrooEQfXRsA==
X-Received: by 2002:a05:6122:3685:b0:4bd:80b4:12a4 with SMTP id ec5-20020a056122368500b004bd80b412a4mr6734131vkb.10.1706814606641;
        Thu, 01 Feb 2024 11:10:06 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id ee10-20020a056122478a00b004bd3ebac932sm49975vkb.40.2024.02.01.11.10.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 11:10:05 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/5] client/mgmt: Add missing settings strings
Date: Thu,  1 Feb 2024 14:09:52 -0500
Message-ID: <20240201191004.1122047-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds "iso-broadcaster" and "sync-receiver" which were missing.
---
 client/mgmt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/client/mgmt.c b/client/mgmt.c
index 62167727c1c0..44bf4d2019ea 100644
--- a/client/mgmt.c
+++ b/client/mgmt.c
@@ -359,6 +359,8 @@ static const char *settings_str[] = {
 				"wide-band-speech",
 				"cis-central",
 				"cis-peripheral",
+				"iso-broadcaster",
+				"sync-receiver"
 };
 
 static const char *settings2str(uint32_t settings)
-- 
2.43.0

