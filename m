Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1613C1D73
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Aug 2026 21:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785618596; cv=none; b=C+nHTbpwNznLlV8g0c5p4eP9CgZCp0xsR3fDycrQtxWFCUsZhHpKFT9xmt4eLVKTeE5jsXEHvL9yvzqFN3URlExl0C+aA5MYxFlF+Z9Ja3XJ6RRzKtBir0WhSbCpYOmXAR8VgpxNdm24kff5dJjlqeJ2lGf1NCaLl1tCxV9rRPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785618596; c=relaxed/simple;
	bh=wP5e8OBC3e5XIFWIK4/+/6DenC4iA1kZeZ7hSa3KjxU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oYrxMNoE05oIXkzqdSOmC7PFYa7jyBgUdmLm9uQHMBzbKoHjxBTVK7bgjpWeXvS8oFOymQumF2OqMHj1P8FtXO2HMj3MgddJ27EVBvn8QPLutyGDo3xr917GdZiuLm74PKRq8iQMb4mxolRDUEaTGQb4BHTtflnktaDVOsGXwDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGXjJT6j; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGXjJT6j"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84a2c90e383so2153004b3a.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Aug 2026 14:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785618595; x=1786223395; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wP5e8OBC3e5XIFWIK4/+/6DenC4iA1kZeZ7hSa3KjxU=;
        b=QGXjJT6j07jcp0AiuYhSz4Jd/vSnYHahz8b4bPtIBCrDay4UgQ5pUhqdNnhhki8LrY
         s7dwtNsraW9PBQW7E/HUs3H79OEmN0y8DT1FJOxzrqgpqcQtoFUWxYVaWgvpiCEVo8SV
         ZE/1Rm/ZfrFC4TBZmtDF35ganf55ZuM2Bk43jDgYfax0mJ2R7rd+yGFS+sjEnP3aUqHz
         Yzaqq040cJMSII/si5K2jYU71DsMo9mObcpcXj1kkE7CTjcfK845vOvYvRohYBj1WXH+
         fgYvTeZQMSmuflbkVkHA937YvaWGVn76QGFgh2YbHFaAY4ExJp5y1IGGIvfiFuy4hdz+
         zZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785618595; x=1786223395;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wP5e8OBC3e5XIFWIK4/+/6DenC4iA1kZeZ7hSa3KjxU=;
        b=SMCr7LgEDQR/X2LYPKMH58djoq69HU5r7WBSAQ++R3ES1diDWbpi9gyIVLFPcYpmRY
         gpJEAqkBgXDvFIy82DFv1IfZJE2C2S1VVfcounxWzxBNG45P8474qouMEAhetSrh4TJu
         2DY8zJ5vsN06gcZTN8GxuoqREuYAEI+bAF76QHiGaHo7Yqwjw3Qzq3dT2F/nJ23yGEVC
         USIzop05heKCUFrPDZiYhqPjQKm1EWC40UqnzcnHK6nECqoSJRQgoUxrNy6EMCIFN1eE
         pcaW6tvj/PpDkvzuWcLmpw7736o/gq9ES6dBFz/JgqrikBlQjCd5OZZHlV44869hg/Ip
         iZZg==
X-Gm-Message-State: AOJu0YzppctBz2hw0h/kKVVUVuNMNoMZvPqoVwQejcIM3cXZe/H/I1j/
	xPcQVhidqQs9g2Kj+LhfP7qcpGmtxPYIPOxJJgRAQ4HLazZrU7NKUHxEHygmjupf
X-Gm-Gg: AR+sD1336j22fXmWT0We4pOI+3I5SDnIbqMO+FPj9HCVtufXLcjwaknodKzO0Krzdmc
	XD3pTwx0bKOO0CdN6KzFnRM6vuAXDyDP/g72D52zXHi0o2Joej+QdS2fVLA8YUhXJmickaal1Ao
	vkLsGaOQo2xF3p2Udd/bLIUmwb3OQa4HxXUN13hienvs5dCul4C2a7MY9cJbfE4B0XVdEnJ1asl
	eaxZqTwak2YQ4HN1AX4+zaXVkSWe3grDqZoYaCJuQgiJN1PeFS54HN2766bPred+o9w3VvIxjvf
	nWXGzuR+ggIy62KL1nvi9b+RNt+Y+x3bECPmNb8OsING4+clijWpM3upBwnimeZE6s1Dg4mnFc/
	wk5dnbqVlAnv9JWNlmF47AUmFSznGdsY01yiRD0fBzf8VuMjYoK3aLHVWwWfxVxm8/zdnyXWGqz
	MwJOptxg2x1z9H7V5HIdEaHKVCVHmvXD7ZyACi9fJM1fCc8Vs2cp0mqCi+s18y7krzf6Mgkl8HD
	00Q
X-Received: by 2002:a05:6a00:10cb:b0:84b:e69f:1b3f with SMTP id d2e1a72fcca58-84ee4812230mr3578812b3a.8.1785618594974;
        Sat, 01 Aug 2026 14:09:54 -0700 (PDT)
Received: from [172.17.0.2] ([4.246.71.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbd35a4esm1946396b3a.10.2026.08.01.14.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 14:09:54 -0700 (PDT)
Message-ID: <6a6e60a2.433f7c1d.319d3a.dcdd@mx.google.com>
Date: Sat, 01 Aug 2026 14:09:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5669557506813607333=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shahbazovelman97@gmail.com
Subject: RE: [SECURITY,REPORT] Out-of-Bounds Read (CWE-125) in BlueZ AVRCP Browsing Profile leading to DoS / Memory Leak
In-Reply-To: <CADE-WFfZvGe+khqhxRtdGQOzSZVp4ZXoFoAFNvahsjS_obu7DQ@mail.gmail.com>
References: <CADE-WFfZvGe+khqhxRtdGQOzSZVp4ZXoFoAFNvahsjS_obu7DQ@mail.gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5669557506813607333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: corrupt patch at line 4
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5669557506813607333==--
