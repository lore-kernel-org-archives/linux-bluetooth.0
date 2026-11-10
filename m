Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309751;
	b=C6CBWmR5wc0f+OYFHH/vzWt7W9xUJvtWMuMLjYgmszp3GfYf2pahwWPpJn+A9SiI0yus
	 VGE17TaxiIEyY19HIHFti9dvBvA8vPHvsNYVsosMiNJmEfJQPVOsflCFkJf4oHQSc1+Gw
	 JA/38n6lVQnZGb5eR/8SZNsvVd5hshZuiwkwxXlTVIAgGgvS2Y2W/1XejW2V+g6GnUl+t
	 /nBBXyFbnzLNe1QC58qI840pJDXTJNl5zCDm+RVkPQdLVI+ba2zcHq0tUHrzmVmpNyMda
	 /vYntdaR3LiyUe9wAluFFXz3SAAvsNxNAv11yFrfbZ6jk4dCRlie0Z6UFrGeGqkz5zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=ak3ttcnXSUtxOxUlgLbvTcZ6tTGduHpzO/PNhxH3h6U=;
	b=QCELhNeEPCgQAONVpB6fVz7YxZL403Ee+OfWACLCAkqnMSqxcFtRyrGakJOGPTso0D76
	 I6vcw9DZRA9h+CWXH87p6o/UIERW+CoWIhV9uJBG1ViRkv2h1BRtaEyqh1kpcboXfEYn9
	 Av20fM+Gl3JbGoxHt8UJsrM1K0xYYWiFrl5W2eZOccZzVZADPGCek4OX6E/VDxu7v4mQ1
	 m6vW2PjJ2CPBTLT9wEcTMqJXASMuocf9Zn3nlvDLCu8AtXT5gruaTArkX5a00bxEYXt7/
	 TIsT0mQSPFE4BFlZfL+KVRHB2APLfJtTQ05QqkXr3W4NJwrzHNjfguoYsmr3456ui/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="SmSlS0D/";
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7640E606A332
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 11:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7640E606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SmSlS0D/
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1438d9363fbso1101933c88.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 03:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794309750; x=1794914550; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ak3ttcnXSUtxOxUlgLbvTcZ6tTGduHpzO/PNhxH3h6U=;
        b=SmSlS0D/IgUZ/0X9GwLAKsimx3hrQSg8QRonXScuoySxeXY0tPNlR+nEyMnUq7/L6l
         b4Y4i3jc3Rcllg5wPQC4sU3tBli+JEaeGKxlisD2K7S6gGpagrhzB5OeGpK7rYroGZJ6
         vbYR4UppP0pfO9lvDqp4y6LyGOoE77iC94CWnA44+FziCOowHBLJS5P+PWGUkJQGRMkp
         UXy3eZeC6aRcE4giGfw7BqQnIi6mKKnmQrWXW6Ufmz7zisuANc/g9W2DfEWih1K/S3FC
         80KeJq6GGG7kZF8o0onF5YiQuSGEiGwYQpHkcOU6Q58RdULKbJixjLfmAmzsShAp8EjE
         9bpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794309750; x=1794914550;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ak3ttcnXSUtxOxUlgLbvTcZ6tTGduHpzO/PNhxH3h6U=;
        b=bGsGXB6u2atnEwGo1tsjMicUp43TLKbz6HepwyDnbz6SxtVtz3c2bxM1J/LK+y4fNS
         Bu9Ok0Q/Od55Hijr98dKBpSGfm4BJA+QZNI4vqFjXTJJ/LbbAMZSUQYmGOh0BJZxIsGw
         W8mW1u3WMbhwCjwrqhXfRK0I04KyEmFfeTDnth8H/KXLoXi+DB+uGlYxMrXQxBGbez9Z
         r6rFDAf2vLm+IjqjzC+GB9PHUdaoiFlHq6sDDNKRyn9/L9JE0OHQQM5DrS4Ru+rFIR2v
         z2Y1M/WTkrV18kP05sZh3bStSfnC/Vh7/lFnThTf+McuIKAskJcFOED0Rn6NJoB+SlPM
         1UaQ==
X-Gm-Message-State: APuU4Z8dNjPfOimpc5HnPBaQVr4bNEQpxSAOuDTArErfO9ZYPyMZBF8g
	MeXjS6xOntM5hure0/xmig6NyJAQkmKgYkT/VvghN9w2mKUUIsPMUEsltM7f+g==
X-Gm-Gg: AYBFou2QnIik4NwEUwfOHJTpbK4jJ2Rv19hdsL5MzrzTXBm+wPuByrFY+hLqPhe4Lj6
	3WExIVqD3VNegT4VPu+3CPRgyJR/zeLk42miaOWjKLyEEczeGa62mRyOiLD0NOBa6aCvd8zYclD
	NlK1TaqoWm5jnFq7P/+9Fq+c1Pi/pWujhau/TQksMLft9lBbHfxByR20NTHOgr5wFrokSQ91RmE
	EWZ8dfhtu9OdUztb/p/qmhPLFTh+oonzcOAAhGoBnXgK1IjJV735LxLJKz8hjUcrcYTyV3q8Zeq
	zN/Wvn/h4k547/06r2se0/PhmoyKrDBqvTrhzCeoysCSB0HemDdDyIpwNL18SnJMSTQhW4YM+q3
	XZ9yqm5zoSYZpbn+M6fQFX4keZIjIfn3zlR7IN9KMag2syPMP6vxQNMCCp+y5WxZnSCeE6ozhF7
	WpuEjQeWlRAhB5Po+HbuOWal1jRyP6CKa6hYMEgIvAv2/sl7mTqGgf9rVm07+6teA0EbL21oFn6
	Uas27MnCa0f9YibrlRi8Zypy2eJQDWwfIg3cqTW01erizNw4u58LCbQ0XGDJcU=
X-Received: by 2002:a05:7022:408c:b0:184:ae11:51c8 with SMTP id a92af1059eb24-1b3b5e5d8e0mr2807621c88.23.1794309750312;
        Tue, 10 Nov 2026 03:22:30 -0800 (PST)
Received: from [172.17.0.2] ([52.161.51.158])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b85d22sm6671785c88.19.2026.11.10.03.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:22:29 -0800 (PST)
Message-ID: <6af2fe75.5583eaaa.e1f6e.82a1@mx.google.com>
Date: Tue, 10 Nov 2026 03:22:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1105016280044784195=="
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
To: linux-bluetooth@vger.kernel.org, mhun512@gmail.com
Subject: RE: Bluetooth: btsdio: disable the TX work on removal
In-Reply-To: <20261110042959.56583-1-mhun512@gmail.com>
References: <20261110042959.56583-1-mhun512@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1105016280044784195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1206717/

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      29.57 seconds
CheckAllWarning               PASS      33.28 seconds
CheckSparse                   PASS      36.01 seconds
BuildKernel32                 PASS      29.34 seconds
CheckKernelLLVM               PASS      32.41 seconds
TestRunnerSetup               PASS      693.33 seconds
IncrementalBuild              PASS      27.35 seconds



https://github.com/bluez/bluetooth-next/pull/1099

---
Regards,
Linux Bluetooth


--===============1105016280044784195==--
