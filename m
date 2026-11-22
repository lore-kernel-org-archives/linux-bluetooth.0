Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795368569;
	b=jq2nLreoPGEpCqVr0OTPMd4h4goOu3K/+Ow/5Py+HjoEtGK+bqgevrzzJvRwP62zeHF5
	 InW0uSmIwG5ur2RLgG3kRz72tDRiRLq0cLo5oSwLOiZbAwhxtXghfpO0aiHXpUFwRsn2x
	 pm1E1SnfvUVhCTDYRndgXFzaMQTB4YZqFzW5qVvVJFCOB5keAmSK6vdr+u+7qd/K1PO5/
	 lcZwhSd5WNWs5caqrmfzVyNCIl2skeWbYrAn6l0uZKa975Xb8FH7UOphvk9+7zAbk8jV5
	 cL3InV6D3HSWPjv2s0Ms+WyikwL7Db4W7pGRyQ2bzs8HT4M6zBW0u8WzG6SXTKKtgeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795368569;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=GxwJPWB1Dh4sNMvfFTOa8bgqhz0ibHsPnhnkFFF7WGE=;
	b=qxot7T1GEqrJaGgxR5MumsnJ3etkOrgQbVcDtRdY3e9Y4yc3X3QmK31kUdThXgO0nItE
	 lYKkjzDBTcZzdjuoi2ELRDXqmQr5JNcz+fj8qxuTERsE5qYmHolXnixPFBkJI7vHGYP5j
	 cHE6ApjXzmqttTUTpNnXr2QSHcT+n97jb+Syda8GvALjioerr++K1Pga9KE1Z3CIohX4Q
	 NizCKqvKbK4/xkRQF21d4sikwX9Xn1j9jEhDaiALT8CrJfQTCgUo/jjsSej+6fqHqIl5K
	 HAPw2Js5ahb1ARh0dywq6k9KIGzAeZ2KubOGVvbh9WAn6qNqwJiaGkal0K8KZU0iWUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EkZeOm7s;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B91A606A320
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 17:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B91A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EkZeOm7s
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5569551d19dso38838871cf.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 09:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795368567; x=1795973367; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GxwJPWB1Dh4sNMvfFTOa8bgqhz0ibHsPnhnkFFF7WGE=;
        b=EkZeOm7sM4AqcZibN8cw/Aut6ujZukztTluNGLeS8qY2Y/Snoa2AahaK4eL60PhLGF
         udwh1jKTN4zaKQa8w2fw3PVMkPFxAH5iGAmM8Ith8SQkeIACALS7/xypZEyCZuU12AGD
         x9+Gg7VWS3+3Mr5KYMHH+rktT+mcEyDDUu22r7/aGlTUhnXmSCb9mIIEmZbtVU0tXe3V
         Nv2ceH9HQrOQDnGcMdhTKikBOf29LkRel2WwB2A0fLBBDsHWgbkzfl+oDYYfn/r79eJM
         kJHNAKYJchgsi2wFOv2m46rAeu3NF6OB8J6HtIysz7IFCL5uOfDwjaHCYvufANCRnZC0
         Y+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795368567; x=1795973367;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GxwJPWB1Dh4sNMvfFTOa8bgqhz0ibHsPnhnkFFF7WGE=;
        b=iSuDOAaA9dTOva6hJRQPGIsVxBsoDSXYWsZoo+UDSIpN1CgTDF4WrBNeywAGUhbQOu
         g9dLrDYWIrMUbI9NKaJRsLaVgZKOo2R2bffYMP4m6pVhDvnZmxghO9YGBkcwjwThzzI8
         xCpWhi298aragI5EaoK/wNGcqPHqEO+RvQq3x/5syoCQQlvzu3aWpp3m+h0wuFNjJDT1
         aj5TnEPUlD6S7OyeWDtoiyE+pgk3WqRD9nAawI95DX22JZfyX4v3VzU/0Q4NHFXA9+Rf
         U7jvXwfsBNgaN5xEZ6FJeNH5wv8t/LYREbnriY+W/YND0oUV3T5QmJ/kS7nRg1g3xAD8
         dzJA==
X-Gm-Message-State: APuU4Z9zSjF0n2hVY9ST+1ilt9D4yVJQnoWxnGNW6XZ/5nQq2X0fsChv
	M4RpHgrAEfokmP/ib7NO0mbyHr3fV+AUFIjM4GCnmtQRJcJlnsh35TLCEROueQ==
X-Gm-Gg: AZFdTZfINl/ZAz8cANCDdDcSGiJ6WMiTp7HpJTSL3ntm9EADarP9Gi1U8iW62xEz/xE
	NSPkRwEBG0H2XSkaOiYxMEieYpKqnqLhxqazai8T1qZXTwT4Cpf04wasG28gDy5IQ1lpq8oVHAb
	BK6kd0Lwe/FAPvDX2ohhCqMm/fri05izERNzwtv3RJn+o2m6kkKl87VaJCdxDGkl8k1e0wiaeaa
	WohohdXiCS4qAy2hZsGj+mYFkKJfV508aorsfx0+wVv1fQUlggEFujwcWGhpoO5Dru5gGdR9YYX
	zMYSmGkv1mwYAYW36PszHFNX4I6XMrU8NOqnj6ZuO0v9GXLCOUb+ZsVyM4q9y6EKiLIhisEF17I
	NxHZ68vTMC0BQNqOw2eJvY9GL2tEKoSTn2glX2omHVWEbnw/wqliI23GhO4wu4nFE1UsuhhOljp
	ERtPDt6YZnAAfkeiSWW8RMuWC3kRDN8QWC2vXMkQTYPDnxRPXijw1dGACyx99lBsRWaGZ/dm91d
	WJV/9Ug01XG28BYHHvbgl30+AFTLmXrV4JhjbdOH62YIhOlkfghVbFO7g6Diwnf
X-Received: by 2002:a05:622a:181a:b0:535:70b3:fa08 with SMTP id d75a77b69052e-55d76a7cb43mr154034541cf.36.1795368567545;
        Sun, 22 Nov 2026 09:29:27 -0800 (PST)
Received: from [172.17.0.2] ([20.220.110.147])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7882e32dsm78665721cf.13.2026.11.22.09.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 09:29:27 -0800 (PST)
Message-ID: <6b032677.17e05534.2fcc9c.f6a3@mx.google.com>
Date: Sun, 22 Nov 2026 09:29:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1012186822177981840=="
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
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: Bluetooth: SMP: Pair without bonding when not bondable
In-Reply-To: <20261122153136.1522998-1-simon.mikuda@streamunlimited.com>
References: <20261122153136.1522998-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1012186822177981840==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218698/

---Test result---

Test Summary:
CheckPatch                    PASS      0.79 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.36 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      30.76 seconds
CheckAllWarning               PASS      35.10 seconds
CheckSparse                   PASS      36.91 seconds
BuildKernel32                 PASS      30.52 seconds
CheckKernelLLVM               PASS      33.19 seconds
TestRunnerSetup               PASS      739.46 seconds
TestRunner_smp-tester         PASS      5.42 seconds
IncrementalBuild              PASS      28.58 seconds



https://github.com/bluez/bluetooth-next/pull/1182

---
Regards,
Linux Bluetooth


--===============1012186822177981840==--
