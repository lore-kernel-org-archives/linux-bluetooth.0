Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793647697;
	b=FImrFk7NKJGpMqbMHJ5g/dpSG8vOlo624VS+gROv8hnGjq6wyoi+n993mFCMWt66DQ3l
	 8ELl3icG8NsoWWNwg4ic3H5/ggQJWvYXTVc7zMG+ahqxdy0kqC9YptGUf9t/PCJpTdtp/
	 0JPB+tvgkfSxD5cTRLcVHUKZqWDlV0Nl+y2TvXQkFK7mBhwH636ajo5jI2xWlMqde/voO
	 67Mn5E2D4yIK0EpS9JELTSKZ3jt2c1KDFuFWqK+ZaR1CzJL2hDwis7v15utEciXgaYAXT
	 13NvNcPHsWoW/fAFz0xV1yxoiBIdJ0S1S4EBc8HHAQNsij4TmNS759gRHH1KAGXGobg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793647697;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=mbW3ugpA7tQkjI+EmNrCJojYdQol4sZfMzkenfVx1Ic=;
	b=knFGwMltvRf/k+3GEsqa6VvhBvwoCt6/PZ26/oAxciDHGkVh06Jda8itxprKMc+p504C
	 MXzzylwyNogYOqlrItf+51L8v5tldg6e/w9s48EsPrRq16wqdVsAALColRav7zyCRUpfw
	 BSIZI6o5558nNE64mUPwHC8hGqFIIyOdNXZq4R5HKD2nk0hpIR5ODSG8tWL7XXUPyZPYI
	 59MqPH/rXk3Jt47sGrx138Kt+6Cb4GYdVfAVwZF3+4W7YMPkjxeJ6iq63EX8QK/hDCjIb
	 DqFDQVfV4vZdfRoT4MqvcpDZL3qDmQkBtjxcYIgFK3nC5aOEvVwVuebpq0m3i8r+Qqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EXIrfoOR;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E242A606A32E
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 19:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E242A606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EXIrfoOR
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1ae18eb9b69so2351875c88.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 11:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793647696; x=1794252496; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mbW3ugpA7tQkjI+EmNrCJojYdQol4sZfMzkenfVx1Ic=;
        b=EXIrfoORB8SLYE6k+S/EB80FDvv+k4yAzWDiqkaKy173jrF+CB0lYAExiZoWhg2mwX
         +WXUaIjYV3ehX0Y+0CTl273HN7/1c79MeA2oo3UAHf33o+UuZtgE3Fw03WA9mI0i3ndo
         bq4ZRLF4TyDAQcea4pA3MBVS0F0Aj0c6Ujbohv18lqPeEI150h/csO8/6vjX7jJdDF19
         vPwlw1tw1GJPMR7w73FzCAFmrIM2yhdpht8qCZ2EQTdfz49ju4zYHnaDLZFdVSEbZONb
         vbuBfs7kehplbCYvY0PVMWgk+giH0ycAqGXMn2GdlII3nQfIRhsVFj60Vl0R46OoWqJO
         1wnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793647696; x=1794252496;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mbW3ugpA7tQkjI+EmNrCJojYdQol4sZfMzkenfVx1Ic=;
        b=zDO0XVaQ3FOWEB9YJdNbKo+L6rEEv/l+ULaRAul9MLkLW0ETLCU1/lA97rdnafEcK8
         qcERgkHISeU3V8+knWtbPmHHBJEwuo4g5au1dL+chme82OIhCDFJO7EhSq1oHI2yTC+S
         xSoGRyj58+t+Pvb82HjurGAfgVbZMM3iQX2HBy0rlThA2s765JWd0MAT9GPMYvKmJnI4
         il6cr6i3dv7eFenDjh1AtfbXNZZRZ0hlP64FQ32bNGDFfduV0A2X3XQJ67o+ukMkO1vM
         LFbtbkNDzrrhMO9uCfBkL+ElB7DTV9atIblrcVPQSoe7yi68jnJuPpw7ObwLE/Lwok4u
         ZiWw==
X-Gm-Message-State: AFq9FYLhu8Ock6qKTtz6NnE6QkAo2hQhcr8LP5kEtnLzsiEzXne2nUDT
	nntyfNYmUaXoHxhWPTTvp6UsHja+5SGemjZtafJP1+0dF4n3mMxERbaCe0KSkw==
X-Gm-Gg: AYBFou3gZOoRUSVRqKIY4gCs3kBRU7z4Btz+wHykyLMH5521QUUQUMsxhZyqioOl5HV
	ISGeWsaNfbZTizoO6Hd64cwb3eFHXPcrcP1RYV4vdQ5bME77WvByKbXFaxJkhbVHU2O3mMdF7Y2
	LdztF3Cf53N+jtUrOtHYKDWC4ECaFgy+PBcUsVThrabIWBUQb5dJHLiwnOMhJk6/zvTBRjVClah
	H4H7+XA3umWpkw5DJ8XjkUxNevplDdWkyP98zGiZwXF0xxYofwtBJbHXgIpRccVuvzjpWBvzuHh
	DOCLXXiIFpb+Bf9neRP2I1AUm0EZKXGE2oGhshMaL6AAThsN5Sv1LQUVOhcEuPdyQOAd66gOsT3
	fPw8jbzoaIzaGWHgw6xupak1vH9kBaTUtv0O5opcAvx1s7dfjlmbA5pput7bHeEpDrZnVQkkHaF
	zhvCiewv+dtaVTD+suMjgWi60+naWO6Zf8Y9TyNbhnmW38V7TOd/FwS94w0kn1UVZ4G/fcU62LJ
	ABoVW+65LgrSYxpFgCVoHtFvfod0NY0G2eTa2ImHc+L9EY0a0WemsF7iAFY0Q==
X-Received: by 2002:a05:7022:3f0a:b0:1ac:2f6d:e1c6 with SMTP id a92af1059eb24-1ac56c9fffamr17948624c88.6.1793647695745;
        Mon, 02 Nov 2026 11:28:15 -0800 (PST)
Received: from [172.17.0.2] ([20.169.94.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4294419dsm37991243eec.18.2026.11.02.11.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:28:15 -0800 (PST)
Message-ID: <6ae8e44f.dd4e4b81.375968.1bee@mx.google.com>
Date: Mon, 02 Nov 2026 11:28:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1966698193282895102=="
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
To: linux-bluetooth@vger.kernel.org, 25031212351@stu.xidian.edu.cn
Subject: RE: [v2] Bluetooth: btusb: fix use-after-free in force_poll_sync
In-Reply-To: <20261102113654.8724-1-25031212351@stu.xidian.edu.cn>
References: <20261102113654.8724-1-25031212351@stu.xidian.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1966698193282895102==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1198760/

---Test result---

Test Summary:
CheckPatch                    PASS      13.19 seconds
VerifyFixes                   PASS      0.31 seconds
VerifySignedoff               PASS      8.47 seconds
GitLint                       PASS      2.31 seconds
SubjectPrefix                 PASS      0.72 seconds
BuildKernel                   PASS      25.98 seconds
CheckAllWarning               PASS      28.67 seconds
CheckSparse                   PASS      31.22 seconds
BuildKernel32                 PASS      26.11 seconds
CheckKernelLLVM               PASS      26.06 seconds
TestRunnerSetup               PASS      567.13 seconds
IncrementalBuild              PASS      25.56 seconds



https://github.com/bluez/bluetooth-next/pull/1040

---
Regards,
Linux Bluetooth


--===============1966698193282895102==--
