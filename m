Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795113122;
	b=yJ3sXesAsgsnYIDfNK6iCYq+kLPwbSk/W6bN80O7rj7Xn2jxveXlBPxPJKgz+xZf1KJu
	 YnWjIjbtg4GWbmG9W6CzGkvnlQvNHMpKB2I4YryzoUEEyv4BCAMBM/5URWXM5y9fXRDFy
	 VYiJB5JUeX+8riXmRyXaVXgEG4Nt565nDiRbYwImIRUf/7y57bPgDDQ7ughT+e6HQKSbk
	 hdtGGaOt+qmdMhkR4f/UOrXcwuJYnCK6LU8PrffpKA3bDWdxGwuM837z4sUBfTGem8v2H
	 J/E4iZ4n/Y0tU4xYjznMjk5lGsUUCrYGIbN035P8DIL00n6S+lSHId3Y8i5C6taaDiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795113122;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=qnw3QIjN+vcr1P91c/j1FhVioFeN0e/1Xf7Gnp/a6hQ=;
	b=Z2nPRrMClXXtK9E8p7KmbleM+YRA+i7xTkA0ShsHj3O1fIbB3MJZT2x8HXFWGHgKr6b1
	 3H9P+rWzue29lN8zYHg1dEXi2/wl3+gQ9lO0D6xC2+jNLetqEkHCz0jiCMG5NzSJhHaQi
	 NwCdiT2fYNiC2klZbgWkiNgyI1Kkd20hzlO+bbWcyDBZhPfp09OqqHLuHfS2kgIOJQXRT
	 rl8h5tnc6KJzzyreTXTFwUneVUATc4z9phgegCSmkNeZ2jOGR/oIKsd+Jkhaa8ZXzPjRz
	 KLYivfuGkN+op7BGHKyNdNPJ3aMprV9xR7pTbXPGJCLkhhlSTtre0rR4ApR4ApHa9+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bDa0LVui;
	arc=none smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1452860A260F
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 18:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1452860A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bDa0LVui
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5eaaa9b1591so2140120e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 10:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795113120; x=1795717920; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qnw3QIjN+vcr1P91c/j1FhVioFeN0e/1Xf7Gnp/a6hQ=;
        b=bDa0LVui5Bm0/D/2A+Uiq9pl7mw9+bXY0iqnVqrRdWoi0oygpkDcSy17PuJjP63xJZ
         VYQxJIYss6apUMwvaitmF8jbw7M47S0ROK+AEgoq03uRH5fGpjeYLw4LYElJc28086GV
         h/mqaa2VYKAsrE5NSQgKxcI+DcyA6XTed/BP6ZaW/m8GotDGdkx1ruhrwPq7E6aetfW6
         uVRMN/URrEbiaUOGccbHzktfU3y8HiZHLO6u9hPxuKkFW6/HmY2clQhiuY41T0+V79xv
         VIdV9DD17ux0pj6DPsFiG8h/YQwtkAftllNKKs7icuDALWdESqaQegiNwKqI8KWDCq4L
         WNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795113120; x=1795717920;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qnw3QIjN+vcr1P91c/j1FhVioFeN0e/1Xf7Gnp/a6hQ=;
        b=DsqTu1FxoyyM+lw9D3Jtaeo3bJLbS1g8NTKghpQFCoHaKFN14KLqA0Hujb/enKdqke
         jfb6hI2xLz4s1zOAEXIuPS0xPtTgP/GTzDzU6N1nT9OKo5MnoH1OrcHKik8KUfhl5/Pi
         JX0pHNHFAvGPj0usjaGMOqdXLXHf7RRtIgmydbaI4TycUJifjnotjOFjXiKY9LG764ds
         xKEAF6bOiT3ezWb5Ens/R8qvJbLud1Q5AZ4ez7j7MH9XFlgVTWIs5BXnZefwqozR1fvQ
         dxTWWBvRVt1HeydyzRIG6zXEGmwtzKm2l5sEdsh2IFLWs1XnAd4LwZIZV668eLcvKaq7
         Ve0w==
X-Gm-Message-State: APuU4Z/IdffPadQYIxE0WdSIYG7lubHYZKnuLJQLLW1p/5y2UGF+KCsm
	0p0Nxbcb4SjFtlZm/r6gXPxNFVEMvEG5iZThSa8UJFfreFAKsg/egvDfIFJ6Jw==
X-Gm-Gg: AYBFou0VxOIOTzFzBVbdGIiQCYOrgZAFNgFSdsAVPtocI9C7Ffyh5JeGXrug6Xa/LFM
	IDEocNsnn4vJzxQnL195OkSXsvHIKXidp9YCKeTBl+mTywVXIlTcfytjdC0dAudVvStzQirY5KO
	8WaM2VSqFW1XclgtdVK8YZkw05bnmIezudIzLiLhRGplni9C5enkEr1I/HDRfjFx/f4uAsezUDV
	kKwp536+sf5Ot3x9lLkHt/Sey+vtSaNpHGdQrIw1/oCosFU20qfAaMZjYaZkSOqG/QsUk90LpxX
	pPOqNcLpXWV8CHmVEswUHh507oAk97CW5VMlKrAqzbN+RABCsjkYHbeCPhY6zbAmruz//aX++UF
	rbeSmmb7WP9jywBkU6k8cxzIGfRsmR08iobe3YjzDtQJOgFVwdsP6dhOBRMS8xcQJCIIIhFV8lG
	nJ00mMK4KacAU4drWn2s7WwDsdnkmlPQTFZ0wKnMfJFeul/0QdFklugh+xsuEhmE6oAbspKz2dm
	w52lyYHdkmHZm7oXQDAbgByKXkfywWrQLAjdXVpKIcdyhra6bHxz3iL25Ia06c=
X-Received: by 2002:a05:6122:4d08:b0:5ea:a1ad:6376 with SMTP id 71dfb90a1353d-5ee8adf13e9mr457039e0c.1.1795113120016;
        Thu, 19 Nov 2026 10:32:00 -0800 (PST)
Received: from [172.17.0.2] ([20.109.39.209])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349e602asm4937116d6.24.2026.11.19.10.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 10:31:59 -0800 (PST)
Message-ID: <6aff409f.b3f5340a.30e815.e879@mx.google.com>
Date: Thu, 19 Nov 2026 10:31:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4237603514255037114=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: [bluez] tools/test-runner: Fix TESTHOME parsing for short paths
In-Reply-To: <20261119-fix_test_runner-v1-1-ddad300e86ed@oss.qualcomm.com>
References: <20261119-fix_test_runner-v1-1-ddad300e86ed@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4237603514255037114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1216093/

---Test result---

Test Summary:
CheckPatch                    PASS      0.47 seconds
GitLint                       FAIL      0.33 seconds
BuildEll                      PASS      16.29 seconds
BluezMake                     PASS      234.11 seconds
CheckSmatch                   PASS      238.04 seconds
bluezmakeextell               PASS      76.95 seconds
TestFunctional                PASS      1030.11 seconds
IncrementalBuild              PASS      238.70 seconds
ScanBuild                     WARNING   856.96 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[bluez] tools/test-runner: Fix TESTHOME parsing for short paths

20: B2 Line has trailing whitespace: "--  "
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
tools/btgatt-server.c:1204:2: warning: Value stored to 'argv' is never read [deadcode.DeadStores]
tools/btgatt-client.c:1822:2: warning: Value stored to 'argv' is never read [deadcode.DeadStores]
 1204 |         argv -= optind;
 1822 |         argv += optind;
      |         ^       ~~~~~~
      |         ^       ~~~~~~
1 warning generated.



https://github.com/bluez/bluez/pull/2851

---
Regards,
Linux Bluetooth


--===============4237603514255037114==--
