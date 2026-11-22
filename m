Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795387610;
	b=zSmy6eRlkz1bvS0bZltd+rayBcdqbCk3gbiHztyB+cq33cjnPpiKSMuzwEpVh3U0wCLQ
	 HXg2GZ/w8Ojk2NnKUfwZNNPs9PC1e40BFs+wrDR0RnBeifTJw5A4KZR1j5i3gxXRaPP2j
	 43EUNkHrNQNHuXxwVsymGfP25qygi0MiqdZ8RlJHkrp8aKG0I9my/SFxPPRkmHCxxvA53
	 ajeU7TTBi3/Cq+oVnBtmBl6Y4xTfR0IZ6un1sIdawTJ3N+P2IvVNnuA+ZiuEgYyls+nEs
	 Xwww71cz7BrVY+ggjYLJ25hSyd8RrIynALiclZ5kAet6aEVZgWuKrnO6QNyIc1h6SUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795387610;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=OjD5qtLepVVICxScwfKgZwTCDrzsgq3GTdgwl56nzks=;
	b=GXSx1T4L3tbjpHcyk5vfIfJbCXhB1m/pvN2jyJ2O1VBzPg30oG1IDJ85YhsEcNEfsbjh
	 xlPL8rhRaw4nDIAKW6VRFq1e2WuL1e9eXldmZCpxVUVw2Guaxg5nQnz5ebleBu+GORYbC
	 5Z4L/9Uf7BO6rVM1KNQaidgYskSIr1pJvCvAloQmoS2sD0/Yx585iA+n4wK9D+Sw7v9I+
	 H6SVw2Ow78e3ce0y2t5iOiTm7tFrEdtGpZ3/ysLvNVI0cmasR0SMecnKzgyGnfHELNuA5
	 puaS3bOqiQ7KDCUKW+1Ca8tkmkSH6FLXYj25MDzM7wHHqtcGwDIAgnmpuUSL6qqm4zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x27d4y4U;
	arc=none smtp.remote-ip=209.85.167.178
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0402606A31D
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 22:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0402606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x27d4y4U
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-53ec92375d2so1736540b6e.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 14:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795387609; x=1795992409; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OjD5qtLepVVICxScwfKgZwTCDrzsgq3GTdgwl56nzks=;
        b=x27d4y4UMSamUuNlxtH7TpQETfXEs4yOb5rGg2b/mcMUowxmbWdSWlN/reQeDPSUN9
         tH9bl6AYuaFZR2vwRnLbYWi354OafNHkZcO+9bi8UhFjIzP8QcC94vZJ79QLmNmURmFf
         m2c+21g7e7jcJfFSVd4ra5QDjmsZqRDDhO1ANrpgCpHjw6h5VY+3CXgMRmmW8NCw6L9w
         lWMFnPTCEHk7Q4xX9Uja3/70ZCfhaEyHTZ/qEcLjffwgDMXl24QVwW0KUm6EU17JzeKv
         78QbPGrm0RlndrgKfFVjsYcuzq62ffx3o5c7WuBoXzd0daZj549LACjR255/eOZkOMa7
         xSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795387609; x=1795992409;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OjD5qtLepVVICxScwfKgZwTCDrzsgq3GTdgwl56nzks=;
        b=HUFQSrEwwOJ6YcLRLCir0zj9DRloS0JEgUBiLv/1/KbgUxYcS0YklEUWt6UibDxE1M
         EGN/vWHMkhsMIClY5zzr6BWYAxLCLIuoeziBMnezphTtd01+dxkm9lhT9GGkrOmTZusO
         qh1lA1k+z7RSv6tM6lSYC6ITRPhkjQGQp5USxgLi+RilAFr14cFRZ3eta7EfvcLxa2zc
         zO9LjHqg5GTQ/xPP6foVjG6ECG0vyq6D7fiZGJVUwVOQXU2b6ELlzdGzRpJJCQx1wkRw
         zxGIRUiJacopSiZRlENc2bamOUElOaDUiLDxN+xwEK0zGq61RVT2PhRLMNwNx4Lvhi2q
         +a/g==
X-Gm-Message-State: APuU4Z+xRfjO3XqoyZIObUUOUHbNGGKWU7pMMhkt5j3D10JhC8CBci76
	dUYk1LRBdffGvVvt+mkpTW9mljjoaLUjiQ13rrQ1JnumLeiSSQqS0XJvREtnTA+a
X-Gm-Gg: AZFdTZcDpJN641+r6QF3j8O3PgOrqphzUWXof0DoGP6srRid4KmsZEPQTJLM2Gsq2T6
	FicytbYoZAP3DhL+6Icfs+ZLRGLF47HC6fibU0o3XF6yQWQcxj2d3nYIEw5LkZHnDmbIUZKc6mS
	9WqjzY5Xfj8tBcJ8bfv1l/zG2TpgxlmhYqN3smZlPLvqj10e8WoRYSaSfrJy+SdUU0Dccn5e4l1
	tw4+CJCv5T0kfs9tTT82q+bUQqRDhdu5ftdRnSO6oFpgXBprm4DBfjsxEa/x6wU9pUWfBFryyHL
	bxyO8u0idyRb5YjZfovuYpnYLsDz9sd5Jbf5ui4l2S+aVoswuEWZhs1CcDSbLZjsvtUEa/oPc0U
	qnilCKQxK/jecMCeu49VO/uMvTiKQYTYYyJfmNHD0tKGjYRSmPxCOV8iHH0tLZG+xyT8yJcLGv7
	9J7fpkOrTGSdqG8XxzWyvnceZcy2TGqP3aOevNv6yxJAT/9+eUqFgAZcp2+/yaIu3y8811Y44wA
	j28aBwdEKM0AxgYv3euZi59gQMiM0XkndKiW1eLNROlqYwA3QG/1ReuS/Spgt0=
X-Received: by 2002:a05:6808:190b:b0:540:5827:6d8a with SMTP id 5614622812f47-57a0dd3f659mr10096153b6e.66.1795387608641;
        Sun, 22 Nov 2026 14:46:48 -0800 (PST)
Received: from [172.17.0.2] ([40.86.18.128])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a350548ffsm7027077b6e.11.2026.11.22.14.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 14:46:48 -0800 (PST)
Message-ID: <6b0370d8.fa8e1b74.325e02.5e65@mx.google.com>
Date: Sun, 22 Nov 2026 14:46:48 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3763476285798311166=="
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
Subject: RE: Bluetooth: ISO: Don't drop the hold of a closed BIS socket twice
In-Reply-To: <20261122201416.2856484-1-simon.mikuda@streamunlimited.com>
References: <20261122201416.2856484-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3763476285798311166==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218954/

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      24.14 seconds
CheckAllWarning               PASS      27.11 seconds
CheckSparse                   PASS      29.06 seconds
BuildKernel32                 PASS      23.46 seconds
CheckKernelLLVM               PASS      24.45 seconds
TestRunnerSetup               PASS      557.51 seconds
TestRunner_iso-tester         PASS      14.10 seconds
IncrementalBuild              PASS      23.61 seconds



https://github.com/bluez/bluetooth-next/pull/1199

---
Regards,
Linux Bluetooth


--===============3763476285798311166==--
