Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792866385;
	b=qzTVjX+fneu9mP5kc5k8EUa8MmgXR5gqTJjz16RUJRbEuuVBuWtCRUz2HGsgtM8DkiX7
	 70e+o7QXFYmRtuovbYjDtgpZ+yBCD43hn68I4kfgurRV0kDUnW8zouD9lsnqQAaEUeQTn
	 OoIvWsp9OfiVhhJTzPpV6L26mQBg0exljXNYJvcB+W7yWeMeyMxyjexnemQPyBk8T2iwH
	 W2Am0FmMQoy68NMiHMnUj7IRByS4nC+0eSafRdoyKme2aBxL1mYD9UMSw+ppvgQ9QgsOL
	 aQ842i6M8BBEu2GaioWFLT44U1o3/N1fPOtCd5310OnhOFklP92KqrlFnGddVRIQ5Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792866385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=3/QFuS7QveGHoVYXWhGkX3GwHULF8L90WiL3J2DZIBk=;
	b=rFIpkScmabwSh59Wun7Mj/7N4jDko9dv+Th7voedium30JQ8JVt0jvPfCFfLYQp5pKqi
	 dX9xM3K4kO/3Gq1T0PgE5huvBXenbTO9lVprM6bfnd6lUUdeLMv7VgjXzSorY2e4A6jx6
	 /sFCT4oakFtg5qF/OwP1SnPPWHaXfP+rkDqrAUnS58M8ZFq3AacjkNtHb4KgWa2kEz15b
	 pwuK6Iyg3coWOOF1POJZ6mFNVLzlPMFGigkbpT0rrWYq4zSr+ZlS/yLm3UbO+kLJdgk3X
	 r/B8kY83JeFavb4LqgqPU4gK4dvyaKoB7zQ1Ehc+diQiJgdksCNn741itTFrxnEsdkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jYE5ROyz;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467FD606A31B
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 18:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 467FD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jYE5ROyz
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-533861a59b8so20581791cf.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 11:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792866384; x=1793471184; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3/QFuS7QveGHoVYXWhGkX3GwHULF8L90WiL3J2DZIBk=;
        b=jYE5ROyzHUGOOQIzELiGxW8HyGoXa3UvDU7dPnZaIyyGiJox4B8zxKPKN8VfDjAB08
         z3maOpYwvkSQgpv7yNRSEUw7VnWSMCGzpBKffD5Uia7mCZsLKcnxxuGf8VIveRJhu5Ih
         BDMQ+6G+3+jDfAqOH0EqVCtR8Qc5YHTUybkkZ9K4VdW2i3P9UERSx3FivWOVe575iU2Z
         pi3t8IKNt/bWM6avjxYroZi1pwAqZNvszbHbtrdqamO6ZCvKyhyseiJMer+AlZI3EgH+
         pZXJkq/NQ9PqesrePcwPUQCrsBMmgypdVNPEThNHfS/IHHNALqbPyMG3LfN6EsZ2OPda
         RGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792866384; x=1793471184;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3/QFuS7QveGHoVYXWhGkX3GwHULF8L90WiL3J2DZIBk=;
        b=CDNys9sbBlAnQ2GG6A0LjaMwLkiCLiZJqgF1Y8OLrKLo7mQW8Hwqdljl7diZ20cgOt
         nIf5tNPd/EHesF/wVmc6dMF8E06C6jK6eGGA5L4MFFWNdB6AP9edDstMwZ1lmES0Sd7H
         wMnbe2K9tOm6NupBNOinSjPGL+fAEfoZ8y4IZFLDsYYlaKR3bS/Zn/tPYvBnfbG+/9Ri
         I2hYW74VXn3vtvtTR9N0XN1BWCUMuMJfvk6A8PnG3Sc0Pu4yiy9MgBqyTOKI/+vwuTYx
         ZbPkSYcUFZd9ouip46ynjeVCT5LUkBNN20T3zjAMAWg7w4H3MbyOytrGbYiqO5Kw5E6z
         zCaQ==
X-Gm-Message-State: AFq9FYIjoYS9DHXeI19O4g2aL8xgsUB5PKeonOV/dbr4817NJqtorda/
	6OvfikTOI3L4UzDXt4qUkyhUpAAjIO5JBkGqMjh57xVBQD9CSp5Ls8s2tMXYlw==
X-Gm-Gg: AYBFou2HT8nUegVFRHdmFnsjbKKJioxEtfUDOW7ZS+VU8HbyaGnNOxxkFqP+jX3DYof
	VpCQ2f/c+WSTHB2awqcVmQDC0ozmFHUbJzzPWIpzNazUYBHOgjm6AoGQ1jkGSbzC8M7N1Xb8qN8
	Q3zFs+f76h+hT1VROnO4CpGMJE/i810XQW8Ur9JCKCteClY+a1Rr6e/Vg16S3MRCPdiY241ri0r
	ocjs/N7+FljTvn1wZoc6hWya14ce/pKimBq6bopmUdtm4sHGIUOW1JD3pCoQ0cdPLCA2NyYwZ/X
	3NNjvllue22dWqPGSGDPTv7wHfEaSFqhodtrGHNHWq6akeL2nDLN7H+2BGM3qFUNCZ65bXA8sKR
	lsIOgyLdZYf5CY9juuBeu9FmnR125EeWwLWrbPCBCtnujpTl8y6tK7RVc5gCJi5NA6y7gLlwd9g
	q2N2uHny6ZAT2smZjoZlFEchl7UYbGo+VFBCA0jApAaSCcJIxq5y3mN/Jz6GYcH1jhUiG9DAbaS
	bQJgMqyxK3Ug1sdAit01PZlukiDtM6j7swqL/NfT+i7mgeGkzdTuPBHDwXyzh+Y
X-Received: by 2002:a05:620a:294b:b0:936:e18d:763d with SMTP id af79cd13be357-940ef7b25c9mr375648585a.8.1792866384195;
        Sat, 24 Oct 2026 11:26:24 -0700 (PDT)
Received: from [172.17.0.2] ([20.106.191.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f067c879sm236622885a.16.2026.10.24.11.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 11:26:23 -0700 (PDT)
Message-ID: <6adcf84f.e947ddf1.19353.b634@mx.google.com>
Date: Sat, 24 Oct 2026 11:26:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4505164426751669105=="
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
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: hci_conn: Initialize the device before hash insertion
In-Reply-To: <pm-bluetooth-objects-candidate-0086-v6-dcaf08c3bc9952d7022d@gmail.com>
References: <pm-bluetooth-objects-candidate-0086-v6-dcaf08c3bc9952d7022d@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4505164426751669105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1192696/

---Test result---

Test Summary:
CheckPatch                    PASS      0.81 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      29.46 seconds
CheckAllWarning               PASS      33.35 seconds
CheckSparse                   PASS      36.23 seconds
BuildKernel32                 PASS      29.49 seconds
CheckKernelLLVM               PASS      36.08 seconds
TestRunnerSetup               PASS      725.14 seconds
TestRunner_l2cap-tester       PASS      12.86 seconds
TestRunner_iso-tester         PASS      10.89 seconds
TestRunner_bnep-tester        PASS      3.17 seconds
TestRunner_mgmt-tester        PASS      87.83 seconds
TestRunner_rfcomm-tester      PASS      5.18 seconds
TestRunner_sco-tester         PASS      5.66 seconds
TestRunner_ioctl-tester       PASS      4.69 seconds
TestRunner_mesh-tester        PASS      5.67 seconds
TestRunner_smp-tester         PASS      4.36 seconds
TestRunner_userchan-tester    PASS      3.20 seconds
TestRunner_6lowpan-tester     PASS      4.44 seconds
IncrementalBuild              PASS      27.75 seconds



https://github.com/bluez/bluetooth-next/pull/997

---
Regards,
Linux Bluetooth


--===============4505164426751669105==--
