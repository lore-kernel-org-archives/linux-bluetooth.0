Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792668223;
	b=q7ekG9B1BcAlUp1ZHt6tKR88mKgxxuUH5p0YEtfNUUxgvqb8kvh8qy0HC3YoJ/oOVZbp
	 3plq/TIGqM3b2Nxoj7oY5qFBvvNGYZ4pospAlGpsPKRRAcbylepEDUlTEkYR06aobgD+Y
	 l9mn32sM9FztpvQGYYG1zWObTZv85BC1PQYPPPDaNboBDdFunVPaEiZQuGCqmVqFSYGk7
	 7WnoVaQCh5zIgKXKE3/s8l8H/3DwDmppTGsnhpwdOj5e9yJU8cFtCvn1Er0HgkolAA1Cc
	 KRdCOGuPWpHqaa0ZzO3Gy97xLuJvrEDtYKLZcgfY8NhvG7HS7jETomrWYYwtd1CxaNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792668223;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=p65Y+9b8qoQ+4M4E7XwaboV920b4LzBGlcfS0J3Gqis=;
	b=2rGypXseY+k8f3pXEJ+o7dBAqfd7S0Sjaa4v9+R5mJ0ga7v4tbkg9PRLB4psVppUqdTo
	 wAhmaSBoVTOxSD5Pi9N4QduJBSoVgejHz6NrZsQvs/LsAh4i4TyWd2eKc1y4le2RwYmcR
	 9oXnjN8KiIGUq/A+FY//uYZ92y8tdn6oluCl2dxevkXU2ops/9i4rDAjd98c6PVbhAJyS
	 nHbmafznZBABJPeIo7kn5tgwJoCAcSa0OZoKKGOBinKI+B7yR5UoVn6q37d/rgMl6l0hp
	 SqbiqfirtmDZFMhCsp5Ug4uyPJuUN1QDxVFBPAZGL4X5gMFaQT6kcnn3Ilt+8COb5yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZiV+FcvN;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE1E606A31A
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 11:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BE1E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZiV+FcvN
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso1703757f8f.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 04:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792668221; x=1793273021; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=p65Y+9b8qoQ+4M4E7XwaboV920b4LzBGlcfS0J3Gqis=;
        b=ZiV+FcvNRppWp/uxDEOcBwitaRcALq2hgWK5vru4WVLWiVHNxXl026JfxhFMsQjWhv
         PU8cv/SZs0ZSjzF49LmWrqOeCuqwAYjjtvlNuZRTyGyywYmQnkRGia3CirkKWVR4BQY0
         hZnpH1rKv7JBmN10sCrAe72D8L6BZxNvwFiSBIS/OvWg+gswQiiCaW15TDIfkZQ000cF
         jtmpQQ5tAuWG8psryNLAPawye8NR5xsuHoWOPytxvaY5Zfg6cXKJ1/pwmgn/hZsrBeL9
         +K8oSRMExttKvXk4cJUEzwPl0zyj6QPPXy9HPJWXEb+cWRA5SFXWysIYNAC6o6PJTpCL
         Jzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792668221; x=1793273021;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p65Y+9b8qoQ+4M4E7XwaboV920b4LzBGlcfS0J3Gqis=;
        b=kRPw7XXpch/1TgkmvO/FS7vSTerTrp6q5UMT2hZi+Rz7ZPU9TRVMFCxGzrEZjvLGog
         BbO/V1wALVcMlN7z+NlaH4WOYkyfscl6UALQDf/nPPbwl69bcPQsi43LXK0j6oCUnmMa
         S1wXsNGiUzQB3xwLv1QcHUSDs4ZlF4wi3YhgffMMGRTdWSpZokGV4FvPnwfrrM3uwJYf
         AG8/+3J7CFX2sjE6h+cVjfHF2MIabgKUel/m4uTU+1EjNvMVJmBSUral/tItX130ZoHU
         hg4ErkHR0yWprgAxctalisAiiYP8BSMnvXAoFAwHGjTKxMH2BhBExV3aMSKb6U3r9E2N
         0bwA==
X-Forwarded-Encrypted: i=1; AKwUvBzlZEI57pNmXD/oABe9P2Q3GigXAUhIZBYMPOkDC15WNYJg9wbeaag/ZgqJT0eqiR71j7xG+u1mQXvs3qRmnHk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKnu+JUud35RH5GpFIAh22MtOPtWfBezRNX0hPW3R/JLh2zJ8Oz
	T6znW0mS8ZdIj+b0rXkE/Wd0ZIOx33ZAN2UN458tWGJX3OUJS3MPIM9llyTEqam1+40=
X-Gm-Gg: AYBFou179Zu+YayZIXlMBiSh1vFk1syAgXAjYeUNqmO3slWD1GFLKcljuWHX9eSd7GK
	Hkpt9qppeMsg3tAPfrIR6/lqmM5hor2whDQjBMuisCbRTOjcqwd9BxgEVoX1tBfxCTJVvlTcO2a
	T78VRDcoMfG5REXw1bna3UQfCV1TCX9D4e2N6Mbb/3w2FusCCihs6ZAoj3TxrGohqApl7Hn25c7
	8NaLnl1U7lnEHBwIJWxoWjepMepcdJrx5L42iXYIdkRgAVBuB9+DGcyhqmYXfVi8JA25T6Ahl9G
	lXqQQM2VeFiePG2hOKQdyUmG14MgbCavlauMXr/R2zDPSGhc+FBkCA/KyZIHA5MZInFjYHDsbv0
	GhAAJ9ElUOMyHtDkHsqfFzMZAMYWySEIf6MWIUuUMtSPf72EPIl27LnQxjiM0QLRu5sBrCNBe86
	pFeDZ0D/OghKLu5870y2li/Y87NaEaenSRJtYGLMI2ZJkDVKfMY/TSLxEPLXxR1ybZSR8YLIENS
	8C/D+nVpCrXaR1GpmUmgsnneyX7YX/B04bPGK/f5aAsW+y33uXp9C/GvQERXp7YTrVkkD6EDUza
	3JgTe8MGYYaYJ91BnDv6jpIN1KbyqqK7phv/YmxlqKGpJ5oxEEE67gfiUMTTFsNPYvzY7vZ4
X-Received: by 2002:a05:6000:290f:b0:48e:eb:56d8 with SMTP id ffacd0b85a97d-48e264a5996mr10513562f8f.12.1792668220778;
        Thu, 22 Oct 2026 04:23:40 -0700 (PDT)
Received: from [10.0.1.185] (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e258420fasm12354692f8f.50.2026.10.22.04.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 04:23:40 -0700 (PDT)
Message-ID: <c0938cf3-3166-438c-b4e3-942e44ccaabc@gmail.com>
Date: Thu, 22 Oct 2026 13:23:40 +0200
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug 222177] New: Bluetooth AX201 device does not work on Debian
 13 on Kernel 6.12.114, works on 6.12.113
To: bugzilla-daemon@kernel.org, linux-bluetooth@vger.kernel.org
References: <bug-222177-62941@https.bugzilla.kernel.org/>
Content-Language: en-US
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
In-Reply-To: <bug-222177-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/21/26 17:34, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=222177
> 
>             Bug ID: 222177
>            Summary: Bluetooth AX201 device does not work on Debian 13 on
>                     Kernel 6.12.114, works on 6.12.113
>            Product: Drivers
>            Version: 2.5
>           Hardware: Intel
>                 OS: Linux
>             Status: NEW
>           Severity: normal
>           Priority: P3
>          Component: Bluetooth
>           Assignee: linux-bluetooth@vger.kernel.org
>           Reporter: kalamlacki@gmail.com
>         Regression: No
> 
> After compiling Kernel 6.12.114 bluetooth device is not working in blueman app
> on Debian 13, it works correctly on Kernel 6.12.113.
> 
> My adapter is:
> 
> 00:14.3 Network controller: Intel Corporation Wi-Fi 6 AX201 (rev 20)
> Bus 001 Device 004: ID 8087:0026 Intel Corp. AX201 Bluetooth
> 

The regression is caused by a missing backport: 6.12.114 picked up "Bluetooth:
L2CAP: convert to getsockopt_iter" but not its prerequisite "net: call
getsockopt_iter if available" (upstream 5bd0dec150f5), so getsockopt() on
L2CAP sockets fails with EOPNOTSUPP and bluetoothd cannot register the adapter.
See
https://lore.kernel.org/stable/20261022111535.528099-1-ghidoliemanuele@gmail.com/.

If someone can test it, a Tested-by in reply to the patch would help.

Emanuele
