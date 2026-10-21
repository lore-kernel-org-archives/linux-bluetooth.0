Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792605527;
	b=J8M0LbYytgO96y4WfJ/uhbg4lCDHszuZ5bzBN4IV+esgj81+VmDJqTTOR+j5NaAswyMX
	 +ua7Op8pMzIBXzplLuwj/T6/KGwKvKKsiZ3gB6QT+ujPkSA+y5OuhRb0O5DzKJGUQP6eO
	 h2+fS7UE7IMEYXm0VAtmn61Kb/G2FsUFDhV5w7kJ1Mh5eQpJIATGSh/njii6FjF5wx3QD
	 UDaGkzYDHN1I1IGnnDyGdY4iR2+T7dTgYGvTYSrsEIEM4i2t1myi2Y3Tj4Cq1xJWsSLwi
	 cCbNRpPY4PtmRmTPMli8s3Nzg4BU4dsqkYEEh+ya5dtL4zm1wU9c7AvdkOfrIrmcxlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=+aSowUSR6g6GV1B6PAw6KJxmXWQ+bxDb4tgvHTb4O9I=;
	b=UcUUa1hqRrh/oebA8yQdja4gNuh8u9eOAic4NnqoTTXY4gnAYSkf1bri/f/RsT7Cip5/
	 dXabtursr4yysZcnLUo1bL7rx2F9pBAgGZtYkgVpR27mwBQ3h8lR+796tHa+TZmktkr2Y
	 M2RTEWRhOf0uGFzxv3OC0gGK3qwGCpx3UXAPxhFDGGexmkldx+hk1UPpPmS77ucnfcH5I
	 9q+ZErkFfWOEqza3/mJFbDvcf6XAX70Yo54jqh2dOOLhdup+ITbCZNvCGCa5DVU+6Mise
	 XT+Td5wWwP26+PfzRd/2sKHHvL1BQux3RLn3Bf4v1XRKs7u47OmtcP9sA8lFlmCyiDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Sr5LkR3a;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58575606A319
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 17:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58575606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Sr5LkR3a
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-843a4ca671eso544884a34.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 10:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792605526; x=1793210326; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+aSowUSR6g6GV1B6PAw6KJxmXWQ+bxDb4tgvHTb4O9I=;
        b=Sr5LkR3aEHScBaSVVEFDVgxc9K/+07ushvqGR0+kBFTOurz1gQDIWtmKj666NYthgG
         bsI2mJAEu7UefVdZkjRqZMGUfSUIkfyogm8+jHbNiRqN2oeIkBpbF4P7D/qWt8cBa5ta
         MhHL8WyCMGbnLyjq1N51tPyxpGMLwOXMob8Geh7FFg6EEJE4lAF4msnxmsSyq80JKOOe
         3H7d1YtCEZ3U3FO3h6TKrrrdYb68t1tqJuYeY1lHWx7G14vUrjhSH73WvDn0Cyazu2V4
         wrk2QjHdfI9VYNSRLCwSXs0hDcgHRo1q3a/qDSwiAp4CHIw4i1MCmEKkyxX8A9ZD2Lt2
         MUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792605526; x=1793210326;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+aSowUSR6g6GV1B6PAw6KJxmXWQ+bxDb4tgvHTb4O9I=;
        b=qMo42/aOLKx4jPjPGQluDZlRztxZB7xeqcJGUXMqlVV6TFbfCUzcSma8MTYQluVi0F
         murD06aRRABG/braSTvM21WFmtTCrmiOSNyoVJVy8ndZijtx4VdD3p9i/4huY5Q/glRy
         jIT5ABjXoC0OiTuuEYuzoKMogMfotzm2s3AhebbCQ6AgdFZt1HVCJY2EAKpV0M3wPwFb
         lDvEtzibr8XX/C9erC9hSnfybDBZSyy57L5qyZF1OuAnYsqZjD0yLoD6JM5W6Hi21Nb3
         Ftwlr8YIbKTN4hd9o7AMQRP7jQE4uhyjJcy1tqzbhqoYZPb9s7792RbOQqnk5lYEEUXi
         /VBQ==
X-Gm-Message-State: AFq9FYIP/bfGw2WsAbrjrmlckYH64fQ3nM7NCgNnhtqv1Hq9wMpWsjLg
	sjODPOPTa28BZ0x75UohFwwASgJ2SEXV8FGaVITMuWqkY5YGFdLZUA8jyognew==
X-Gm-Gg: AYBFou10X8yU90ENKidHywpO+X1Xr/ulwieQQdVRL0DORz8v77JRr9iUxs132J8Y8hL
	+suhV3nPs1PqgFyYD5QlKPdTnolk96QUDnnSnBXq1H1vpxcuCPHXvKmkXKtjWxVlITaKO/JA5V5
	O1qER8MbAFwcBW+QHJn5LKvVZTQ9UTffkUhJO+JiV5A64GT84fMhr+KXQrQ32xRMaTet+pFmLUw
	Q5CfLUNNEJREQql2RIxB8jL7BhVAjyRkOVH5rFw8Fj5ZDolFUSHSp7waUeXREtrqnKARTbi69lR
	0p3FrfYu3X54x0VZu2ZohPt+5N/TMg++fArcLXIHxig7G0z/km4V5cIUyyeTyi3xIETtKcOgU6L
	XdW+1jh/OTa3w1AqTS+eqqpnH5F2fErr/neJH3EauLufoyJjODTdchY39T5vxj7jFjHhyM+15B/
	yre5tNK/jN9pLrLlcd2IVnvf7/9g9EEJz2g1Obssni7kFWWlXQTJZ6BbmR5gNMqrIqT7EDNNx8U
	jEUslECIimPz1JmmGBNlNm6y3TfYqAYf+Felwr3kXLXH3eCnynDChE4yEtzb8k=
X-Received: by 2002:a05:6830:438b:b0:81b:bfb5:26cb with SMTP id 46e09a7af769-84d05bbdd1emr2347596a34.3.1792605526302;
        Wed, 21 Oct 2026 10:58:46 -0700 (PDT)
Received: from [172.17.0.2] ([52.173.13.232])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84cbcddcd41sm2891903a34.13.2026.10.21.10.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 10:58:45 -0700 (PDT)
Message-ID: <6ad8fd55.bc6be18c.156bfc.68f7@mx.google.com>
Date: Wed, 21 Oct 2026 10:58:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2494810172810528286=="
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
To: linux-bluetooth@vger.kernel.org, abo@medichon.fr
Subject: RE: Bluetooth: btmtk: remove redundant memory barrier with helper
In-Reply-To: <20261021145112.64213-1-abo@medichon.fr>
References: <20261021145112.64213-1-abo@medichon.fr>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2494810172810528286==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1190579/

---Test result---

Test Summary:
CheckPatch                    PASS      0.53 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      19.92 seconds
CheckAllWarning               PASS      23.68 seconds
CheckSparse                   PASS      24.93 seconds
BuildKernel32                 PASS      21.16 seconds
CheckKernelLLVM               PASS      21.15 seconds
TestRunnerSetup               PASS      469.61 seconds
IncrementalBuild              PASS      19.97 seconds



https://github.com/bluez/bluetooth-next/pull/974

---
Regards,
Linux Bluetooth


--===============2494810172810528286==--
