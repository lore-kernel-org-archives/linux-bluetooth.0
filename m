Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914817;
	b=wQNJKz6Nym1/2HPPzTGEPvZ2vTDn6eChC3XjF/AlM0T6TmRsH7NC0E3XRDnexkWhYNx1
	 RGyIE7Ip/7xDIT5xao6YtZp0gIpEIdhrP/EFCl+OAiE505QVDEEtpJQGQEoZ6LU4oBDuG
	 F3GY5eRhq7hF2Wz2sDUrE7h+PrPv6NTwiZdSeJAf2SkgEcPjbGT1QVGz7n7EVCWDB9vTT
	 Aznd08To1qz1eTYNWY1U2NM+muceit4icIVHleUEar3Yp/fYmEwdfTceQJw6YbP9lQKIG
	 quZ2F5+33dmRw3RWxMmA9YSfoTSr7ThhAJe58RMhPxellciDFK2xPJRX9z1IW+x5w2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914817;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=b3WVzdcUMTMThjCO+p5/MzRsqIgZsXOXYMxSMNzrMR0=;
	b=KqlOsuDN84nCWZwck8zFkON0DJfAZe1iyZ6aMNYSJv/Zn9+d6JSb1ZXLLXTVRoidXAZE
	 cHc8t1iXZ9AmcFsne9z92aWytaXWHBbYXqv7/zkpqp21YzIkZzCrCum2LvZAeUwMI334T
	 Pb7kVYFv40EMsxprA6N93/yYLtdY4MFyPzQCHKXtbT8Hyq9xD2C/Co4HIy+9Yrek9ZuG+
	 WtIZtyqJlv0LVbcEuuVyHMno3ZW/lFgT98ldrlhrm0+OCqeRR78bQXhYCy2+eiTH6URA1
	 x67TFwJ+PUPCWNriOK+Ab2nXStq5N9qmR2nN3D6Vn8l7xtZi9bz+7TpQJsfaKmKD6hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yu+N3NJk;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3A5606A31C
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 11:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A3A5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yu+N3NJk
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b3bf3bef9aso211692a91.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 03:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794914816; x=1795519616; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b3WVzdcUMTMThjCO+p5/MzRsqIgZsXOXYMxSMNzrMR0=;
        b=yu+N3NJkXaS18srm1SOni4FOwXPlDCa2KgR7dc66DDYogumg56H3l7yHqU2Vw4ehfg
         0DDe6i3SBtxYLgM6lxompYHJJq6IjypZP7T/2MSYhvy/nIZjovGXeoWybLdJdW6aPKXC
         juuHifmJv7HIMCocxXtj3BNNLIDdJ7MdAd09ki+XIzXGYjD05J/cqE3PIZIPSBW/Ahpy
         neWUJmeCxZumlLhCgAucuHEl8D2TfCL4aHMhlB/fYkPV3hQrLaAlrXvn5lrGFusK615M
         WPABLtYPYOQ4CZyu9hgC88mxcDVd8gBsDV6BEg3YWNFa6A7B82HOTNgZ7efuKJbWyRun
         1iOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794914816; x=1795519616;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b3WVzdcUMTMThjCO+p5/MzRsqIgZsXOXYMxSMNzrMR0=;
        b=gALZNrTlRYvCxUBAkEoPcsczF986GJVE8jWcX2yFYsvLJkPngh27wtkGxF3uCqGaCx
         sZkGVn9FaB+ohVnuX0oFX4JBxMOMW6jNYxCBIpjJxc+ZPIcWTf0OU7wMBDpFgvsprCm+
         5yZZirOUgv/3puyLkBzmAVXUD9v2ycoOzqR1rs+VyNFW0g6+tv9eGhN6oC6VHoe9AINJ
         X90QYhBBsdBdQXADB2U3IImOk7IkeKLNORYYmKkol0uCkMTp+C0/1Ytbmtoe9kEghRLJ
         A9a/DsNP0H9riW7GjbYce3MCxaBjMb/LtQ743IDyDzxernNXrKh8aUpDwOuuifzjAUKk
         9duQ==
X-Gm-Message-State: APuU4Z8NnA/3Sxf4kQFJfMuAfuWoYtywGE7hUKrPFMwLiwk4qZ/xGj8+
	Ef4xQVOdtwblgb3owP+ezudMdkJ7Csc2Rja1cHulEYbsnw9AJEwfDTcyM9Jydg==
X-Gm-Gg: AZFdTZeeVDKgTC4ahjSAUwgoqF1ebwDE8yyP67VHoDs13kXcyDV85+jre9oWA4XFGWK
	+MbSgGc25StHTbqHT+7mKexL2wq/YsyWNqjuUmSqi3mQCuGiA9y3uLaZgv6NOeOuL1jbh8lLAue
	3tmte6zktNwcR7hDszyF6v+RHhVXkgWc9N/V5ZoUlK2nLa0O2AZTc478M3lXA1KEwvec85T0mZ/
	bT76ljKe1/UulHyp7/aabE3RmIwHx0DhOYhlL8ChPQBfYNlp2bsqPKx7v2c9b9Hf7XPuldwabIT
	10/AQAxVVVqb3vKqNls9xU9Wdu9/sZstEoYZGZAUQr08x2ST+Sg/BVeaWO5FVKqR16N4i6A00NY
	xcLjEzqaTgCRIVDPyKFtu1goTTXkvjPQllBSU1hY7a9ny4AwzRYYBTraNR6o6nJzfS4hXQ049IS
	QTMgzP9WEDz21LJ4Uz/5hnWjP99KHIk6qGZIqqzmaHOujJANiRWNlagD5XjTIYVfuP2RNG0EOTd
	Pip4rT9ikp53vGucABe5FpvN0LAbjVzvMo+zyb3woWncYx6/RENplM+oYDw3A==
X-Received: by 2002:a17:90a:e187:b0:3ac:9c37:9426 with SMTP id 98e67ed59e1d1-3b1b0ba53d2mr14967043a91.31.1794914816374;
        Tue, 17 Nov 2026 03:26:56 -0800 (PST)
Received: from [172.17.0.2] ([172.179.6.90])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdddc55efefsm4994590a12.6.2026.11.17.03.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 03:26:55 -0800 (PST)
Message-ID: <6afc39ff.9d9b1e56.13df23.345f@mx.google.com>
Date: Tue, 17 Nov 2026 03:26:55 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9186974282505447862=="
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
To: linux-bluetooth@vger.kernel.org, jperlow@gmail.com
Subject: RE: [RESEND] Bluetooth: btbcm: Add entries for BCM4364B3 UART Bluetooth
In-Reply-To: <20261117034947.14803-1-jperlow@gmail.com>
References: <20261117034947.14803-1-jperlow@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9186974282505447862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1213391/

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.06 seconds
GitLint                       PASS      0.19 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      24.78 seconds
CheckAllWarning               PASS      29.23 seconds
CheckSparse                   PASS      30.92 seconds
BuildKernel32                 PASS      24.83 seconds
CheckKernelLLVM               PASS      25.30 seconds
TestRunnerSetup               PASS      576.58 seconds
IncrementalBuild              PASS      24.14 seconds



https://github.com/bluez/bluetooth-next/pull/1143

---
Regards,
Linux Bluetooth


--===============9186974282505447862==--
