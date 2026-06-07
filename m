Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF0F2D9EC4
	for <linux-bluetooth@vger.kernel.org>; Sun,  7 Jun 2026 06:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780814404; cv=none; b=K0Y0wAZbOWh/i/sOhZygAntDKNL4Js4Vq+fthj15ZrvNlF8ix6PAdliQFZe3LDkbR8Eo5V2U3YaHJooN0jhcquxN3lMU/R8/f2jXp2zwznIp4XzkF5S4ZwmUqHemQ4UHQ4SmhEDPMQXxtkRHI3HucDm1PnsH/TaSc6K/LEvTJdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780814404; c=relaxed/simple;
	bh=bX6MqqQ/773549x+eYNY93ePOEVta4vOkuk/IpYO9zM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kLSbkLgpzlLhWp2mzev2sEKZc8bARWuIptbGamoPV9Avk4Qqus3SIF8/+sKQ7yHm2Taqthb9Mm0N+Yvmq2moiTGHkbv0fspPZLIKb3iJ2qs4dIsPFn0YX4OpHweMAYeNH7B/hL1Rn30UvyrfNyGcjjAZzbsTsximFDoRx+bwtFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8j93LSb; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8j93LSb"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-137eb0d76beso2446447c88.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 06 Jun 2026 23:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780814402; x=1781419202; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zEC80Xaw5hivsHqhLswrQ6D8YHtkNNzIMqk/pAaqrTw=;
        b=M8j93LSbC5LSuBuI7vbyJHCe7tD6voeCyo8Kmi10KR1Y9b/LocIFrn33W1+LCbrnxX
         uLhbc8cTtnLIjCYTo9p/BxrrJ6ARIY9rd754cfv3T7tBeH+VU3GwfT85Xy9Um7lGS53x
         vUWM6CgIDgNl2bhMLYPewUWMXSiGgPXmcJzYup7Fbm1io5R8c81zMaC9FfY2OJhTtSr+
         zS0BQ+XvGdvXbLmwzRQhQ+Imc3yNCN+9fFZkm8WpRJVlKTfB88ezJCbJPm/UN7UFfbVT
         0olktyMtAWG36i01vVwealtLfaSAy7WrrtqDe8dBeMrKTA2i3WBJ9Qbxi0tCbdYZYLg3
         QciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780814402; x=1781419202;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEC80Xaw5hivsHqhLswrQ6D8YHtkNNzIMqk/pAaqrTw=;
        b=oaQ/BxEM3fVat2xMTz0ZtUTDPaXCNqHTheY34ZU3uEBqa2v46+rP/p0+gdE5aVhov4
         eu8FVgKrvNoOPeXuMVQmCznzcyViZQHfcTxDUMmTDDC52bB5PFZPelhyyxcS0l1uM2Qo
         R/ByI6sZ/AaUaWAmSMPkcOEcaB5A6PZUVAyEBfC30l/ojxl6kjwC3yXtCbFsIAH/PR6K
         Z0mVkQUtIR/PqmuTZtv9FtTm0mjd0N9WThJDqjQcrANgJplclMV1JCwU7ao4wR3S3lwE
         +rOskKBh1PRql8WDupUu6FuEyeE4VeTHM6jUvgg5cPp/liT4xPVo2fL02mXv2nP+A+TS
         ZLoQ==
X-Gm-Message-State: AOJu0YwQU0FDgTDsULBnZPF0W7yRyvMvxBlKjYo8BDaHj5qysqwzQed1
	+YySB7c2aakhBoJAGHy4LFe7jCqah6Z1lwegDJcgzAA+pUgT+IfCaMCQAiF7EQ==
X-Gm-Gg: Acq92OH6eMTHLFo1Y+gjuzs3GjAmTWmPKkP6buJjFXjEzoc/gzkixy3BUS6gYGJSUpw
	4mN/7fbGj6JKWX0JFVDJcJ39eRyN7jbdvfwxkHgRIfblWclfTzp2CxlqSteFCXPOODPYaLKX7pT
	yw/KMCrHHIphszyyt63e474WH+UJSGsV1jyduxuuD9GI3IXvW4GpDtnBigOdxoocKE02KwmfAgu
	csMvuisgFptGGIyX32Qk441F3eOoGako2yBMTWqKD/zsFvf5ccxoA4aLoAS6nHz4IlE9gYwAKfN
	Yh5W/BjG7ttjj/K/pZzIJ+DbGfYC0HglzEP77REnaeP+vDXCRcqX1NaMl1A8QOuWk2CA1OknIpJ
	x04m6BdrExRWErVXrbWxDm9WknMoZTwIcRFu2WHYuuUZDSx/9kCL1KJxzGPv5hZZPWv5QVj5Pmc
	YVbBncVPGfCssNfgIHCCoDfOlVrGNZo8sVDYDjW7PObxA=
X-Received: by 2002:a05:7301:52c3:b0:2f0:ee2:f6c6 with SMTP id 5a478bee46e88-3078011f9d4mr3203673eec.19.1780814402157;
        Sat, 06 Jun 2026 23:40:02 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.173.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dea8e76sm12410506eec.18.2026.06.06.23.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 23:40:01 -0700 (PDT)
Message-ID: <6a251241.d68db960.2a81fb.21f2@mx.google.com>
Date: Sat, 06 Jun 2026 23:40:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6166005337832899076=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: Load IOSF debug regs by controller variant
In-Reply-To: <20260607062117.110893-1-kiran.k@intel.com>
References: <20260607062117.110893-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6166005337832899076==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1107196

---Test result---

Test Summary:
CheckPatch                    PASS      0.99 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      26.37 seconds
CheckAllWarning               PASS      28.88 seconds
CheckSparse                   PASS      27.39 seconds
BuildKernel32                 PASS      25.69 seconds
TestRunnerSetup               PASS      572.88 seconds
IncrementalBuild              PASS      24.74 seconds



https://github.com/bluez/bluetooth-next/pull/291

---
Regards,
Linux Bluetooth


--===============6166005337832899076==--
