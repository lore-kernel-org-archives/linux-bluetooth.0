Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793239745;
	b=ezYq4jCzR8mEtCYanynLJKk7reD3PCbtEWIpzKU466BmakKmGUELzA8Bjd/nZMnmp1OZ
	 B3Q24Ca/Nc20ryzkIn1fvrQdFHeUmOEAWJvAF0yzYssW51Qy+gsounWQ+RrBHEcp6584X
	 nfXAepHDWcHlZ+Z4+NyoLKar+CZ6A4wvngrxgBCTorp8kYBqXEnWhBKN86FhWvr14SFez
	 ZxTDCuGoHyh5CPw669JRUS18SUkaaxb05gx2HWtPftT2f52nBK5Ss+wIY1fIimzvjnXv9
	 O2wqjOa/qHZy/jXgrUT0eBkQiKY9RgB681LgP0SP1ocOeE3ZE3od3gy4ss71E5BTEnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793239745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=kVBLT5Fg0T0c4qi3E+jKgRBVNFTJ7tgJe5U8okxEXy8=;
	b=TBkz1JNnRg5N2VlvhqPRLz4YGNJ2736vUHXDvVwgRdsIdoPte1HvS+qIkbUovJN/fzNk
	 EbGWwkjkrDUhxge2v19glWicY/C1iJa1p12XIvJ0lJyOE0jjb4DX8EoGM1aFi4iTavSmO
	 0FvIBK4dhiFytZPyta2mERe3C9nYZLyd8uYjqUktF361OFvIpCYRUmvMz7wXT9RY8R+yj
	 o9fiyOLGa59gqOC7T2HETInD2mIaGgiaQM7Dua2blPNpwutgYrizuFoHCHKvp3cHg3Pb5
	 xp+eZ3JcK1kVsFFYBQuqqvB3X5sjU5CZj5UZC6xR/719DdZKpFhydfL/kKkj1W8eevA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AlcRMtjH;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7667D606A31A
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 02:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7667D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AlcRMtjH
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93f269e335eso182493485a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 19:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793239744; x=1793844544; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kVBLT5Fg0T0c4qi3E+jKgRBVNFTJ7tgJe5U8okxEXy8=;
        b=AlcRMtjH1nIcIOnJrwKLxIsnjfV+bevB/KdMpjPo2glZqppq3P394v/YbL3L0ckEgJ
         UEysUSSnAgbJXf4GD7F9CuVRgFQS/oqeRVTOYS2eXilwbClIWk5meEzpOLefUVuAIozJ
         Pe8d9QRLyXCey1xHFleVa5HNA4RFyRGHEuulVwPuxu8VG3vEMQbqCgTLAJmK/mxhnrtJ
         UE4z7kC2OImxKwV9ZH/USOOwFsgxk/IVYTCaaTW/7GXHMLBs9iIhQzHy5PHEqSTbJWwU
         AcUusILxDhRBSoJNrtCPKHL60t/ACFoq37mTHxXrVue4X+e5dcw/okR5JzLSXVyE2o4E
         vwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793239744; x=1793844544;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kVBLT5Fg0T0c4qi3E+jKgRBVNFTJ7tgJe5U8okxEXy8=;
        b=2SrcHsaUU1j3oCjSu9K0NdpZzxl+KLjYEKETe7fCV3Dt1v8bjkHn2HWYV+fUyHy2CD
         9qUhRjSWTckHtvS1C4o3SZ7lIUGCna+wme7T3L0zK+xsBkiUtoE6RgRBR4fGgqfvCdla
         LXngOlNQosE/gCDIaBuhZ4RdP5MSjJFMUwyqSXceqo2aX7SKfCqEd4kYm5L3/3cDwuCn
         ZtjYPuq7egIIQYNzbIsX0P4C5/2/lIvWdWN82gUU2oJK0r7myLJhwYO1Bc87xZoyIJJD
         6Z/NmnuzW5p75NiVgAu0KhU5GXIjcSQV+o00flQS75+dKby7v/UmL6UpR4O9UywWz84H
         vD5w==
X-Gm-Message-State: AFq9FYJHOxVPeiBp0BMPdx5LXWTtZSoW1dta0+Mn2XRoDFd8RRO/DwjJ
	rCYZ4c9kBaCqF3YMElycfoscMMJ1fRr7kcuET03XRHbn8tZO+Gzu3UsC0J6pJA==
X-Gm-Gg: AYBFou0Xz/oLMX+6t+UBwwb+uacK9hjuDRDB4+83NPzW88qWJ7cwVkzasX2nZwHBtK9
	sFYsofzW6aAECn3yo/9U7WPXwevYiduISf/iXxKLKaSkYdkMctMNCMICctX1pazfiHsVe0N6Kr9
	qzBG6LYjkPm8PUGo/oYJFswizdzpixUwqHCV1AJP+EknoeustwH9UP5wWIp1bIoXyFpLJCsQd93
	2GN2YDXhgEI8T69qg5jc6ZO6n0l1xUi5Bh87+NJjH+R0XXQLOGsDHrgB6hrphHDNjhe3Rm3xsLY
	qEkk16+rJWKg8yB48KHaQ0A9EahOsi1UXO4RYYmKo/IFNsLNo+0CycNDnsBhaGdfDnwI99HuqIc
	UaP/JF/Q1bQFFPYrWrKUJHEz7ztMPJWeADcSTIeqYdwakrPkehqI5Vl5f71qdV4A3sHYJnT7ALa
	fyo3FJEu0WBGsZI7x3WeK7PIHcs1vPhwN4ynIhAn3vTwNg/rbuQI8CbyZadeRIMHmSeTwX1eVBf
	SjBMHr0gmHdzIJVlMTWSRlEGHNR5W8w4nnfjRFWwECNcSlPHCGBzcO8A0IIddNV4g==
X-Received: by 2002:a05:620a:1995:b0:93b:bc51:b40 with SMTP id af79cd13be357-94408942f92mr696952785a.2.1793239744403;
        Wed, 28 Oct 2026 19:09:04 -0700 (PDT)
Received: from [172.17.0.2] ([172.172.157.210])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f066731esm1418778285a.9.2026.10.28.19.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 19:09:03 -0700 (PDT)
Message-ID: <6ae2aabf.4001fe38.91ec2.951e@mx.google.com>
Date: Wed, 28 Oct 2026 19:09:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4619273366652969840=="
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
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: Bluetooth: btusb: UB500 MTU-only revision
In-Reply-To: <20261029001349.1031535-2-cochcoder@proton.me>
References: <20261029001349.1031535-2-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4619273366652969840==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1195798/

---Test result---

Test Summary:
CheckPatch                    PASS      0.84 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.36 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      34.07 seconds
CheckAllWarning               PASS      38.94 seconds
CheckSparse                   PASS      41.12 seconds
BuildKernel32                 PASS      33.93 seconds
CheckKernelLLVM               PASS      37.64 seconds
TestRunnerSetup               PASS      773.60 seconds
IncrementalBuild              PASS      31.00 seconds



https://github.com/bluez/bluetooth-next/pull/1019

---
Regards,
Linux Bluetooth


--===============4619273366652969840==--
