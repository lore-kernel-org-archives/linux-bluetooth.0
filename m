Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4376C39B97B
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 04:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785386409; cv=none; b=EpOj0a4ABPSEonptkEjdJ8E7bhrvRKk8+v8G/OExaA0QS7Des34+wBkeI8r/JunE4ShIHapqfSH/Vy7Xve/fQC0h3HhARcQUWaiRrswOmU+aDLyOS+/vQuIhzeZVTruLmBqzE9eSk0/7eTyOKJhhpTaqzp0vnAfXfxE99tGY42I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785386409; c=relaxed/simple;
	bh=YAEgAyeuWLq5m9njI5OgeADsCcVBrzO+N8Wvzw460us=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EVi6YkuLrF2pGhA8y2O4njnZhrjS4xFERfrcXPSHBxdFVWrN/WGmTlanHt5Ru31ZCewa+fSDMsdVj76ZU1a/rRjlU89U+oiOru2DAIA+c3HFpzFImWzl0sn9JOtZqMC63YNdtHsB4vi9o/2z9vcCne2yNk6MSlM3ZXN0UhfCfrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAdgcKsT; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAdgcKsT"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso1648291a91.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 21:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785386407; x=1785991207; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=W6ALtVB56LrBCTVOXzvwMEAX2GOtBLqwwmxwfNCeZuQ=;
        b=aAdgcKsT7ezizRR+nPh3rtXzrBaCN7s2TBNzBIBoPXhPYLAsoEw8GHHikWo9aV62Ud
         ItvWMqbc/K7lsBxxZEmjszxaxHSzcG1zZaEoyzHrPXeYIQj8uTAo5SasEa2feJZP4ZNR
         YCv235fEGIcboHrfmPgeP2QXUw1VUradrq7qSMqFrg5GbDFaft2Y3t2SGBVoBoluXWiS
         rZ3E4KfduSx3lTsmqYc6oY3GUZ5Z18B3FNPuyb1IPs+oBp51GM2qwduIf8oASayMhX48
         Bq7AZP8D8W5azyPQNA+7f1vj858VWmS3JsPNZwMEDSGCO5op0YJXZnj+RHgQ2J0c9rwF
         MCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785386407; x=1785991207;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=W6ALtVB56LrBCTVOXzvwMEAX2GOtBLqwwmxwfNCeZuQ=;
        b=BBmcmsCJoLwVAqSW5luo2Jq/8+/yJSJ4uN0lT97HJn54Lr0BiYOzbJDuR+LoBASXlY
         W/LO2tAlH4g4x0KnIC3XiT0Dvo83FisJj7aKsvEeVc1J3uzlbGcA1GdLpfjV6rsa7Sfk
         jX7q5IfHMvnw3fuG8uzD4UksCFnXwi/PMo7aMegYoanMfrGU2N7LrIqd+DkfEb1wvoy2
         pL8+Og1D/U4ERqlgnUkjlIL8DUr6bD/bqH9PfVL8hyZAsttVd94J7bNSgCLzbmXj6hUz
         KyIqidsixxemTMpvWyO3tNcCI6ny/JaiXTB9efE3nzy6HfKJDGeRQ+uOM71hX1+yVmcL
         3PAg==
X-Gm-Message-State: AOJu0YzfRwM8ZsuXTwkbNIB7025y6FDiNDc5KQspyy+5tW3MIqU9kvas
	JQqI2GLUZhUQX2LhYQIUwDQcP86AWy8l0lxXTxjgiF0VxhcfRFgxwadlloPx+g==
X-Gm-Gg: AR+sD11SKuUv/LJ7ywDHwQdykTCjUYThFXcTkTZXnS+ewi8BX1zD/VxrDXFsCvhElAA
	U7Ow1mMD+xvP33yRfye+p2N0mw3KP/U20i4j7gKeGPJJyugP/yf/aNzoXyM+3x7Ip1QfIlc4LAn
	teik7QUs2JK8SWYAH3nagSwrZ94IXVTPJ6aKNF8jbUOJZhzbyvE5VITq43HNdGDEdybrC8V2uyP
	Ll1gg1Iw/hUTZxBjdprJ58JD4HPFenJ8gjI9f+F/GaVCXgqkFnaPNvi4800yP/dP/h8b+XS/Z6G
	O1JSFySgnaZofvTeTGW0tSKhctUzkjPtCJ0b18N9a0VQL11SyN7yFZFIalPwNIZCC5MZW3PMRrD
	fTZToRODc4OZQWZrnVUF91CCnfaxGMGUddC5a2URs1N9PWhku2hbPHkSa6tt1mLR1qh8iZYL/4k
	exeGLPPteDrk4Z3ncRS4byW7EqP08nTEdTCiVjDc0VphMloeJHpHezygGnf49Sk1IybGOyEtNbz
	rmL
X-Received: by 2002:a17:90a:d605:b0:37f:9ce1:cda8 with SMTP id 98e67ed59e1d1-38f9c04cb5cmr959266a91.30.1785386407482;
        Wed, 29 Jul 2026 21:40:07 -0700 (PDT)
Received: from [172.17.0.2] ([52.225.96.33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e7273cd9esm16371040c88.13.2026.07.29.21.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 21:40:07 -0700 (PDT)
Message-ID: <6a6ad5a7.0f490953.243528.740b@mx.google.com>
Date: Wed, 29 Jul 2026 21:40:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6025602961703197235=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sammiee5311@gmail.com
Subject: RE: [v2] Bluetooth: virtio_bt: avoid OOB read of build info string
In-Reply-To: <20260730015728.2798952-1-sammiee5311@gmail.com>
References: <20260730015728.2798952-1-sammiee5311@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6025602961703197235==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1137030

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      27.24 seconds
CheckAllWarning               PASS      30.16 seconds
CheckSparse                   PASS      28.12 seconds
BuildKernel32                 PASS      26.44 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      501.00 seconds
IncrementalBuild              PASS      25.65 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/512

---
Regards,
Linux Bluetooth


--===============6025602961703197235==--
