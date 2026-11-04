Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810594;
	b=3/tC45BwJlYkHqWDTbj217Dga7+OTsENgQLT4shVLKZcQpSlgl9SOwBSrTcZZEOpLrid
	 svrnd+AbfW2S2y+63atLFEfdQ2E3Otq6IremsXnuoeC0954BzZ8VcdCQ1fNhqFhY3FDKC
	 5TPEMOp1q/yftVYh72HpwCM0PSJPjO8mbUK+pYzNzRINEL/QbHOdizmIEAvpfWCME9Lwc
	 l2AifM5AWWTTxQgUV9Jvl9HxAe5AKUgkzWKihEzU8uR+tgJekLqJaalUrKvpUCjO2c31X
	 TP7Q6LiDN1NQXdEQ+2t4QXsCM2gnab/VoePUKw9fFxDjivdVfMee8YMU9SsVFEu4dmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=vpdHoNGHL9F3t/XZiXuBwKgTTiZKMwqmh/NQEvfBu0s=;
	b=4hOioI5tFYeURh1wXfzvKCnrMTeDNL9zF6M7UI09DDrXGdvVBhtLvxV6VSmCefp7YKxN
	 S/2Nt6OXctr5eCMjx47PM1BR+sv7QdnUwMqfuFUaicigEvYUz12pQDgYLAWjRXuk+aGsc
	 ExtYEd0+GR9Thce7KBL8yXlggmabk4BiZLZXudvpvf44dc9SBmudupwt2Uz4Qov9lZ5QX
	 6F2czBdf4nqNvAauQ3+R3Olg+dV0sfugl9PGh33z3ADBnIaRuQ/DHkI7SnFL9qpRr0add
	 IFzWiykixXUW5J97TXzAQS3f3oByNn8ryDsox3AAXkR76jPzxTQxe+wIxcQ2xEqxrdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XsYYkYc6;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617B4606A328
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 16:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 617B4606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XsYYkYc6
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93e7ad9f78dso107563985a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 08:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793810593; x=1794415393; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vpdHoNGHL9F3t/XZiXuBwKgTTiZKMwqmh/NQEvfBu0s=;
        b=XsYYkYc6kq749GLgh/GS7n8ycPLWy8lMx1NWbuvq0/vmaX+fgZzm6YHR3nTNLeZBvV
         aFC5+DyH8zr+AwsEBlQMZWILwAAiEVaEt/d54Euheu0POEZWUdh+tRIntVmhfAmEY4RA
         OHupt+TC6hje/j6dLo7wOXJGTEeQj8JN/Jiv0+IF1fnDwXcxJZDYMIp2Rwnvj6i18lPt
         evGenyKUfzFYS9Hec7M1CiEpkawGVLoYxo7OFSMw6A55/MTQQ5Atphb73ZnkevVrJIVA
         JtaWWhv26PtSohXI2IsQIRUU+pBi0TiFWN8i83sUr/1rLrRx7DrHwjGmhyynkWdlsX7Y
         jXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793810593; x=1794415393;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vpdHoNGHL9F3t/XZiXuBwKgTTiZKMwqmh/NQEvfBu0s=;
        b=dVXZRi3wz3x4xWVb+yLo6LgNhZx97/OD1R4RtF0QKDXvAjYjx9a/2awj0ZUqJkO8E7
         qvl01rUtGKAIisxLuIQXm1NfK+dHnafbHJQeYaUhlt3sboclSriZ5NHWhNC85yrNGT+R
         lpm5rBsxLjVpd9yrexrEZy1wi9sVOXO9HhPB4etAatVf/4eGAtmh7OxWxCEOVfp+9YHd
         TYsZVcr+/OzF4ILmUE6RYAStU4nrBSVdY5QCHmbsdIyE6aBPphLZMGCG2oKzbDXRAs2m
         rW4cFihv0AdFafjjXY2H7zxkVNyFz5rPdWOUtbmOesXZxdAThJ9jsNkczoUB8qSEU/T/
         0uCA==
X-Gm-Message-State: APuU4Z8ikEEJ0lScPv5ISbVX5Fqd/AmH59TNuTqDFMiePnnGGuquEacQ
	MZUz3cHg06Fn/8vryHNxiiXb+3+WsfjuNyCWC5kUKrU0tXT5Vh6OvCp5fRGFFwxT
X-Gm-Gg: AYBFou34UI6isn+9/bWvbYr6czabKUAoGPg2qMNmbRb4l+njJwbXK7hqGw7AJSw0hjH
	F5+cINefOuWMTMJB5mN7uqyGphBg5u2myC5dBdexrGDV/FzvszIbCtnaTm30jIl7B4X3vs6dp2R
	vSl45FOzvgFrr9w2SvE6ErUWZc8XXQs9YX/mYYRqBV9VnR5cxbXSk+JZcgEaaYObOmbe+KeOSvZ
	ZD1n33WdPus6n5HNlNHEDuIB5jM9O6OAePmND7cG0pViLY0PUOBzHwvGUNZ91kK7TDGuaOOGuIs
	bGWdSHzHOJgzGth23WZVeTum1pAS+Q3yxXyDWC6WfRoI+qfwm3VJyXgz8dzWWdyO4lVeGZ2ruCR
	xcdKHf/YZCNVVGKTWTgyMUXPejrLi3TMt/Ju1kLFQ+ENyelRxEPG0epuzhKzzqKcyp4pxF2GGwT
	N4CoyJ92mOWokNhHfNaZW55wuVPau++pRrb0uDUp0DhGQLd2wDAO6NmoOIWkboWsBTn9+iylDYZ
	E+W9PatFr1rcbWUoX09fM4n+OCihTo3oM4F/ycYpxlPCW86WqESbCJExHwKqYs=
X-Received: by 2002:a05:620a:29ca:b0:93e:c12c:f13e with SMTP id af79cd13be357-944217f9b72mr2623896785a.72.1793810593046;
        Wed, 04 Nov 2026 08:43:13 -0800 (PST)
Received: from [172.17.0.2] ([4.236.174.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d484499esm242807885a.26.2026.11.04.08.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:43:11 -0800 (PST)
Message-ID: <6aeb609f.1ef1dc9a.2bbb4c.3c9c@mx.google.com>
Date: Wed, 04 Nov 2026 08:43:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3392701896800202348=="
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
To: linux-bluetooth@vger.kernel.org, aluvala.sai.teja@intel.com
Subject: RE: Bluetooth: btintel_pcie: debug INI rework and fatal error injection
In-Reply-To: <20261104122508.241477-2-aluvala.sai.teja@intel.com>
References: <20261104122508.241477-2-aluvala.sai.teja@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3392701896800202348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1201763/

---Test result---

Test Summary:
CheckPatch                    PASS      31.22 seconds
VerifyFixes                   PASS      0.64 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.69 seconds
SubjectPrefix                 PASS      1.95 seconds
BuildKernel                   PASS      31.78 seconds
CheckAllWarning               PASS      36.21 seconds
CheckSparse                   PASS      38.65 seconds
BuildKernel32                 PASS      36.83 seconds
CheckKernelLLVM               PASS      36.38 seconds
TestRunnerSetup               PASS      764.41 seconds
IncrementalBuild              PASS      33.86 seconds



https://github.com/bluez/bluetooth-next/pull/1064

---
Regards,
Linux Bluetooth


--===============3392701896800202348==--
