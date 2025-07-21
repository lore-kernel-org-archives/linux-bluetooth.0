Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5682E2C9D
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 16:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753116402; cv=none; b=g2kGXFn3n8buEQhdr6Tocp7cdzKf0AkMUgpuHh3RUFtdgvFezFrilAkc8KXCAp00e83cSLYLHbf1CBIOrF4FwX0poAgcWFnSHAf1p+FeQM8LGK7hJkrPjtbMHFES38MixcDmg2ZVZfwWXKOj/am0b1QQfI6kuhKsG9f+LTFHFl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753116402; c=relaxed/simple;
	bh=DzunzxZHJB38bLo8uRIX/icOlrYNBNhplBmjRMwErao=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ttb/ZZUm6MS68OgT5dnefkEnno2HwlEDpkXlfLnRd/SK+wAJv+EWjxH9uXX2KVEjC0wOO3lCoZN2TRg8/wBsaIqIBRZd8rnP+Q3m6bJ56kbGe/U/X53NSV/E+4t5gjPas1LPVGWzmtCTy+Nc2lmlRcZd6FUhTywYMCQNMcAgGCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TixcMe1w; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TixcMe1w"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7e169ac6009so469602185a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 09:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753116400; x=1753721200; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WfoXsb1eCgNDvRHAuGs93iHvMM0CUP7Wq6M34kgZQ4w=;
        b=TixcMe1wo9K3b3p+AesZJSMqqocPcFyePiBj1H7rlf49RyEXe3wfKzrRMzgBsdNkZX
         iKSdc0R6L3EE8ZV5R69MpRhjOv1lZymQriloio+MDob8KV9iAMmnZqrtjFaZ40xTurom
         HrAdE+EavIxFKd3p+Zadl8IV5yD7t3HDoqk3hdmIdFPUSxgaq3r9UBPCIcCWSS/lQOtv
         6OlLEz5bqnxZWvhVW9vHdwojRbXfQgE7UvZWBe0qYNztg+hJ9e0SYidlDdT4IlTyVGsX
         JE4uxHvmxwRsshe8E33HXXrthczz8I016DnzjrhxNVBlT/+QB2UakRdsX5kDIvX8RKx6
         84OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753116400; x=1753721200;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WfoXsb1eCgNDvRHAuGs93iHvMM0CUP7Wq6M34kgZQ4w=;
        b=cUW3q2mOmIADDLDwW38O9gpFRv0SWEqSGNadOIZsJWFkTJ/QAnKmFfqCYskymXw/Bn
         Vxz6HgT0UyTq505Baor9668+QwNxA/ZcOfCHVj4KQZGeyjwXwdVYomaT/NX6Z9Iu7/Yb
         bwxwG29A4Y+ZSfDP2DCkFHkDPSJKfCbZjwgxip0q5ybKMO7biQBVYm/5HvOFU8am3g1U
         k1phrQ91hLhRoFHlPCPNliK8qLbbIbNUrxzt/AEXLgAixu+Pm7zTxOQx+ufcCl3kttKf
         6eD5vSI0BINQsBQoo8wpzMef9pl5fQkjU3gSUxVTbArAEdGi+7sPNzOWZPwxMrV+50s4
         ktXg==
X-Gm-Message-State: AOJu0YwB+/JHBHkB7r6SJgkhaeyNuuoHE4qykEKvU0AA3zCQsPNgKq+b
	wi8z1wjOzdCfQ5rHS/N5X2FAEgViYWvgAm1illYYLjvbLJu35nsU9k/ZxkK4/mqd
X-Gm-Gg: ASbGncsAgFcBpxSkXWiZAEJicjbWZlEpX6sfeURVuR4Kxnfav+O10FXz0RcKZeKgxmy
	IktO3/wpLK58fqOrgrKSMPFrDXnV2wAiGY8Qu1ZTauQIvUBNM07BK44R1LWThx9Z2Vi+FNhSxHI
	wolEftv0+hisO96daH2Ggh4E7eAhnzY5TDKVAGq62uKlIPGbbWorUQGIvuLbmFgXbY48hEq4Svw
	di9VjBjdwKhoVRajZKnPEn1fSkJSuyQvNNwkH8Vfv4uT+0+TJBV7pwz99Hc/3jdwhcajAscd51j
	AajciC6XckhGg35YriqAorn9O/bv7ePaidImRc8pUWH2ubNKGmH88DynysJ1JUrfsRHXC3P4wuS
	2wJSw3f86tGVdUOdWwQPnmUYtYwrZ
X-Google-Smtp-Source: AGHT+IGfK9Y8jZrtfhMFP7wCc4eUNcbXwsl1vN+MvIY7ttoMbYmaFhYtWqd8qB1ZANUZygSXCVYEGA==
X-Received: by 2002:a05:620a:3bc3:b0:7e3:4bc8:b910 with SMTP id af79cd13be357-7e34bc8ba38mr1980322885a.35.1753116399762;
        Mon, 21 Jul 2025 09:46:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.213.118])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356b4677csm425860485a.32.2025.07.21.09.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 09:46:39 -0700 (PDT)
Message-ID: <687e6eef.050a0220.176ae8.d122@mx.google.com>
Date: Mon, 21 Jul 2025 09:46:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5669707807456121894=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_fgiancan@quicinc.com
Subject: RE: Keep component `bluetoothd` isolated
In-Reply-To: <20250721152219.517-2-quic_fgiancan@quicinc.com>
References: <20250721152219.517-2-quic_fgiancan@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5669707807456121894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=984366

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.31 seconds
BuildEll                      PASS      20.13 seconds
BluezMake                     PASS      2580.32 seconds
MakeCheck                     PASS      20.57 seconds
MakeDistcheck                 PASS      173.89 seconds
CheckValgrind                 PASS      224.76 seconds
CheckSmatch                   PASS      276.91 seconds
bluezmakeextell               PASS      121.88 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      760.46 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5669707807456121894==--
