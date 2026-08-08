Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F87B2877DA
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 10:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786183350; cv=none; b=Kwsr5WsYir7gcYmolgQEVNJujepX0x7hWaumNB/3CWw5zExgi5dBi+IHLOVH2hWwd3Q8x6GgVh0uuB7mram5vVjP64fNoiSrESY6UC+yaWf7rhZhaZUHv2J2wjWhIJKlY9RYhH1rr01Aiyxh/LW8GOUwJKTxWd3YZACp9SUsNqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786183350; c=relaxed/simple;
	bh=fG0DnoFzMp2lY0xo06RxsVXbA4ij9U8h27LuMWe84Zk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rY8bHNr6gjtj1t03Z2wsy1ls2m5AXqgk8rE9oTbQM6gaaAMYI8YLBxgcbIcRPr/zJvEiXJkfy4XHSzZyJASMeGvRLAuBNYvcezvByr/YUBEbE21LjU+ovtfwx7MFufZAGM3ib28VbxwCwIp3+6M4VcURv1emKvhBYWinOaVOo8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUFqk3wu; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUFqk3wu"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cedda2ce6fso3356985ad.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 08 Aug 2026 03:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786183349; x=1786788149; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hH4qxZsLbjxw8onW9zmlxa4pwUamwYx0jPXQSiwXH+c=;
        b=BUFqk3wuLahwZt4Cumaq2AW4vD6RloTLSjl/Z6ksROS5fmuv7V4aaYTvPWWyt965da
         j0co1WIrYQweFAmey8SiHlW6yqHj16khN74QFaLjujtOksk6eKwSEIv6PL7uQfq4BNFW
         u/IkYTcAOhTHmARrIaeVQP0FY/IVZetWgIk4erJAMIvSJjRWpwV8M2Vk4Med0IT3IQNe
         WofV6rPixQ2afSxzhxhZZv8vtn3uEigpgqeY8rknxF8L3xD7GZRoag9CCG9dKb5CXN19
         eldU76Pj1WIpoIZo1TnLH8YVxuEkoys+Cqhu21po8d71XDRiqZPWfwC5n5XH9JxNIsVt
         2elw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786183349; x=1786788149;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hH4qxZsLbjxw8onW9zmlxa4pwUamwYx0jPXQSiwXH+c=;
        b=ZryCATQHg6gHYqKVA2ABUlmx36Y1mZRV6FDYcvBf33Crm0lyUlggQVhq8b3VDaHaXB
         denod4qTOWNXJjqVHdAFoZpemM8l1wtTwzi8giWqGKgbS74LtNp0VMKFGdiRPoohV6CW
         c5KIYyltX49y1Urii60h6NDKir/BF/mifgjUfqnQ8cEPG+WTRfouv47Rmd1DWDQOpIiF
         5gNTosXgkE0Nx5VpUnxQYI9t+OmyZQ8gz3YM0SCgMTT9T/A89tTNIeu62UK/gfaaDGq7
         hxKXE0kDiJLUuH99vp749JyEjkjO8HQRDGuHXoeK8s5zHI1og/D7a8DQiE+jk4Q5jz2L
         8Skw==
X-Gm-Message-State: AOJu0YxunAhwTj8L9gBZTiT2vATLQAbanjdDCMtV309QQM/XpeAa9kqJ
	acGFv1+z4kjAyLukgpQIwsMwCvreP8QwwArhe0i22zx2p41obeA97aI9ojIIhw==
X-Gm-Gg: AR+sD11+bjydGqK3xKpmMj8ruD5IO9yXXnS6UHK7vwhqVYIVp5eDqMYMPThooEaGqrS
	ZwMTBRfiji/11LNf6aArYhAbwQDrKiM5suwS7knklAqEPZTaaN6b+F60thu3lKRsOHpLsQe08Pm
	Csq+/txS/ENeFWQrDipxIzlG4dRbwZnwhha0+3aeBE3WMVyAD9OLE5Ysxd+HxVoxrNKf+5wos/B
	hbB7g/EVOhyRVeKp8vK6AIS4BcuPc0VpuKYeYRDqlyoN6TaHvRzRExK4AIE7+6H3AvubTxe0TdA
	TcKTAp8y1Vsly4mQCbU4zS/68A6kKKhYcX3iG3egCDIPPVaF7Im+ef5m5MCVp22RHjkWtl7vpbR
	C+MUu9cAAak7yVJUYi/BjNw0oo6M9tGcO0RiADCpnY4rtooI2Uszodg0LjekHHkOhgwTFR3SkXp
	P9n+SomusHV5vzKwnB3VP+f0MXXYJrmmnW7n8KNWQD0zzJBCwz9zGEThnGIGJDwl+9/Evgjw==
X-Received: by 2002:a17:903:1b66:b0:2c9:e9db:8167 with SMTP id d9443c01a7336-2d0ca7125c0mr370254115ad.7.1786183348566;
        Sat, 08 Aug 2026 03:02:28 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.194.212])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bebee8d0sm16934101eec.24.2026.08.08.03.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 03:02:28 -0700 (PDT)
Message-ID: <6a76feb4.f06f4994.311f07.6c9e@mx.google.com>
Date: Sat, 08 Aug 2026 03:02:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2009177144932197649=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [v2] Bluetooth: L2CAP: fix race l2cap_sock_cleanup_listen() vs. put_chan
In-Reply-To: <95cf567c0e78b0ded9a555da052b4ea9b91aacce.1786179819.git.pav@iki.fi>
References: <95cf567c0e78b0ded9a555da052b4ea9b91aacce.1786179819.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2009177144932197649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1142603

---Test result---

Test Summary:
CheckPatch                    PASS      0.84 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      27.63 seconds
CheckAllWarning               PASS      30.05 seconds
CheckSparse                   PASS      28.66 seconds
BuildKernel32                 PASS      26.42 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      500.74 seconds
TestRunner_l2cap-tester       PASS      63.91 seconds
IncrementalBuild              PASS      26.20 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/559

---
Regards,
Linux Bluetooth


--===============2009177144932197649==--
