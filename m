Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793647935;
	b=X7+anHsnAeOU+TAC/3BglFnMRu7B+QdXSS9HwvASPCCUrKpGSKo9BaogXL+T4VMbyWir
	 +/CJslKVdfuxms3PNde3lXfqQwzdjeHJA1pUJQ9k6tkN8cJWF9O8+b3Ryzhy0xpK38DeR
	 CeqrJpWJ+Lg579eHGOjnGENQB6ac89gZP65XHWCYHq8CdwNKFv3Ebk1sG4qxAXZhGHUS1
	 hbuCzR7Z5vxDjgbEo64zj7PJQAE+a8EiRliwjbfFIIuZ2k+dF6Rg2WMc65e+f48YbTPER
	 UyPv2XJl6VwUY0EYsyorXAH8uc8jaP2KNPinOUTaAjH53QiJgh3c7w707qiIUQagQjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793647935;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=YGwlkVyxqN2DewpBQsmqc2K3nqNtnhDhc6YalGn5Jd8=;
	b=bwPkOtRr+fg5SJ2kR/IzIKgSASy+a+O2yGxXIC9B4/9eRd1vjl4sJwcIdisDnK/vEtov
	 Dv4eSxN6cEsoLjPrBI/tN1++8oRDPNvOuq1ACtVzMPa25dXBoolHY/fIEE1eM/iYDaotm
	 BizmzcqF8f72LGRI8+1u50ZH8mY0MSpGbU94fU5525fB5I0kk5SimYuOhjCC8m+79qLES
	 ceOT0nJ0CKrGAN/7aAyPXqpdDaKnIuhp1nSpU3nP0JBRjswIT3usJTVg5lexOQFZPrtfi
	 arJQtkbdy5TEzarZXZY9KeFfybdBxXOxSOMGf8eygESYLB75gR/eO2QB62phNvv2v4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="mn/3lV1O";
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C8F606A33D
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 19:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5C8F606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mn/3lV1O
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91c763de878so24451946d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 11:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793647934; x=1794252734; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YGwlkVyxqN2DewpBQsmqc2K3nqNtnhDhc6YalGn5Jd8=;
        b=mn/3lV1OzXiuZcqTKSS2n+hOLK0ZGlS5M87WrTxaySmeIFs11eG9Jj3uggqNkOzN2/
         rZre9J2x7XGUU2HXcrtT20sICYhkL4rianWN0Vrkg/lCai7qKUqVo5w4pY1YcgDFn1Kr
         eZm2ZmhTfxxfBzIBM9DWHceIJOIA+7Ahg+5XP2KIGjwEzD9hsYabViGkhduWLeSgnRxn
         4S6de/SP6zKpnDhidycpvp+eFvcPTl2VH7G+2jCg/HjDI45BaVXp/nYJbTa7Ucg9m8NG
         RqcQa+8khb1olXTxOVOG30t7tcPqcx5lBuC2iJnPxcxBXTGlLHt2yN6mbn2+htoswdhS
         aebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793647934; x=1794252734;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YGwlkVyxqN2DewpBQsmqc2K3nqNtnhDhc6YalGn5Jd8=;
        b=Jxb66dDgPUvHHEztybuHjnsLPfIHxdoSDH14e+aYrL1agk4PRxKW+/rzg03WRcDzgq
         JcM6QfbK8eNPBUNqi1KQz7MsT8393c3Ji7iA82XT1Sk38hhg5fYFh1Bf3vliea8mP51w
         4S+X07Ec8bQh1tX/WMkUWf67AedfGX4cb265a10bWWu6ardAQpsyNJovw+uxC7qhj3sH
         2Gny4Immkv+qGoy5bapJ7TAeguXwuAb6irLHQ7Z4JVpRX7vgOQyFLjhXKD/YO9ujbMeI
         zaqUTvJ8Ske/ZeuMnr1a/IADR2dL0zs+SALJc2AZNECdpS54e8NTNj5+pqd2QO6+ur9E
         XYpA==
X-Gm-Message-State: AFq9FYJBy6dZKixHG9aiCddpFbel298WVJ6LFQdP5uTcKq6Kcn6QacIa
	m2RxxfXs6TdNRWlzXKBVbIsbe7meiVHemJ+CBTs6uF6aFIAcaA72TVUZdGAtJg==
X-Gm-Gg: AYBFou347h2f3PSua6HAkj4va/Ew/BsaPJFxgHr+I8vTNcc0f1C5/IYmfiTjn0jJYJO
	/7xbrMbCNHzc5+go7pm5j4wDTkVrKIyffBDxDf5jDIO6bj6nExOHvdzPvkwnkfEVv/CQznt9+Jz
	60fJSbQy3ic/9nSpDAd+ULYMryzJjJLsMdiXs8O74rxHNMEXUo5wB1u45Td6eIm+fkQMnOXxBuu
	1+NL2bSFr6kGR5wzAyDr9ExUg7kblMNEcv9wolTiEyq9B9dVMRL3Nubig9ky87er3i1+MZtSgnX
	9fluKrCvPd199Di1kzqPBexUMRzZwUQbGpPFIx0ZZskG8WUH2d4DVLVVoxWnBPLHQp7Hxr9IRWv
	PzZeU1ph6JJfiRmPF3j+awovn+IB5ILMDFXxwD6QbxZIclLr3bNV5FYFe4LI+NIcrdbj2/dn/KA
	AxMCweGD+AUomsFhWkQI4XDgN+FiMtvX/gznE+Pg2jKKau/vVdy2hliSCcdH0CSmJt5H1siqmNI
	vkVif9yz35ttzbn07D5+ILfHQhT62j+1kOkCqYZPaFdAb84UTXFh3tPq0g8++GFqNQyeXYqF+yM
	bxvqctk=
X-Received: by 2002:a05:620a:271b:b0:93c:2c15:e513 with SMTP id af79cd13be357-9442178a95emr1768741385a.63.1793647933803;
        Mon, 02 Nov 2026 11:32:13 -0800 (PST)
Received: from [172.17.0.2] ([68.154.54.96])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9442586685esm909163985a.23.2026.11.02.11.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:32:13 -0800 (PST)
Message-ID: <6ae8e53d.6e3f852a.19d8d8.ec0a@mx.google.com>
Date: Mon, 02 Nov 2026 11:32:13 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1186623859546771327=="
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
To: linux-bluetooth@vger.kernel.org, amisiurov@cloudlinux.com
Subject: RE: [6.1.y] Bluetooth: ISO: drop unbalanced sock_put() in iso_conn_ready()
In-Reply-To: <20261102123418.363320-1-amisiurov@cloudlinux.com>
References: <20261102123418.363320-1-amisiurov@cloudlinux.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1186623859546771327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1198824/

---Test result---

Test Summary:
CheckPatch                    PASS      0.79 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.40 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      30.09 seconds
CheckAllWarning               PASS      34.29 seconds
CheckSparse                   PASS      36.95 seconds
BuildKernel32                 PASS      30.17 seconds
CheckKernelLLVM               PASS      31.51 seconds
TestRunnerSetup               PASS      694.21 seconds
TestRunner_iso-tester         PASS      11.54 seconds
IncrementalBuild              PASS      28.16 seconds



https://github.com/bluez/bluetooth-next/pull/1042

---
Regards,
Linux Bluetooth


--===============1186623859546771327==--
