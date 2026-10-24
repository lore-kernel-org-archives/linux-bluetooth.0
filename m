Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792843427;
	b=wS2xQvchDCTPeXWPlq0D1BXIRg+FrgrMd7WK4ZiNwMlEwuCB4CtszTV6ub1WonNKdvtD
	 eHbmC3odSs4AOtegBUDZtMeSSWQRmbiw/w93OmQ6Q+8enOaiE9l8Aqiofi77KmfnT6J0H
	 7aKAMchq7fNwba0DJa/EzC9B0lZclCmfK75S4L1BSvuzOAo8A7rwNu+ecAaHdQXfeRQ8/
	 qYF4k6Ve79u/mqhodN8gn8FvEjoVqoeUr46n4VxDhYn65tJYz+BfhHeWoMGu/HK1mgFu0
	 5RQxjsN7sa1E96bX9wfZRac5zzZIIMl7nSYxaT8QlK2fGSErebrD1L8ctR89wJmNAug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792843427;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=sg5tREh2Vwe7XTtQmHKYDma78BbrXkEhskM0FGD6SFc=;
	b=OleJ9IMTnoqEZHNWPzaqtbfoZX8/S++e4lmUOJ0uhDRKEs0gYnwdkC1OYn3q0XYs1ZMI
	 ozIg2TiEztZIiF4E/rMyOktdPVgRrAY8q8fNhIR62Ts36ncIWxYCm7qqxlUVSpQluccFU
	 QDcM8Svda20oIdPfzIUnbKmDTvxVTOMSvlc+2x7vQFi3LlO/7htpwBQV4WPcUTZTZLkc3
	 7ZEH/9GCmog2WVjVDjrHGWxf4r7+37ghjmzydO6ICcK6QfXi5w7vNUj8p6PbQE7EBHiCu
	 cyHldn5dmokRbGT6maEHag+gyHRhGSTed3iY/UJrO7Y2vtHSj6sfsWiwHn7G9+xVPIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LC1HtF55;
	arc=none smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5DE606A326
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 12:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A5DE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LC1HtF55
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93e635220b4so145654585a.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 05:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792843426; x=1793448226; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sg5tREh2Vwe7XTtQmHKYDma78BbrXkEhskM0FGD6SFc=;
        b=LC1HtF55JoLD49a1U9lb6IuaBZU8pMAfiBPP1eXaGUJ5v4/b/gLpi7n0QnYWRTp3TA
         Jr8tgsQsteGwJnFVcbQ6X8+9gYzQ954o68qw+jyQiSAANKzgwB9A9oLMmtr/N0YxpKvA
         WTz7Pisayg7HnXJJi7ECMGpOBEHY5yZSx/4c25zkGHgUOCztsMXG5DrM5/T2DGjY9thE
         woYhLGHxcw54TUVeV+TSeUFbOuDz0N65oi0O9NvztFFnPZRiBm43owoQJ+iHmcbCKrEN
         xJKEtXH9rfM7It7nptg2CukcCnR2ayA5twsDFAvM8eMJNviclUuaEcesVSYPGKjP+aOY
         tDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792843426; x=1793448226;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sg5tREh2Vwe7XTtQmHKYDma78BbrXkEhskM0FGD6SFc=;
        b=dl+NJNehUwPEMWb1LagAHotR5gqGQI10LCAiY9NxnD1hgYLhcBk+WGXpq+VKwnzRmf
         uBBxQp7EzQsnTZ4m2GrTCYBGo5Ia4+BhG8C5WxMI5ZNC+LS4WOxVIaH5I5jC/53MBHwx
         o58474Vk87xKDVDXhUhdnkW/Y1702cmhOd+XhxVDRpGD9e01VpxKtw025Sk/i+be+UAK
         rBrzlGJObuw5dRNN3X9ZBRvvGE++I9XUrDvid02FZg8COQRx9CP53FfOGN9FIhRTmREu
         SxPw3/cqvPPbGNQ5/LBx9y435E56ALXP5eXYy7WJcF76nxpb4Ve9cElnUIBTrMLgZqGH
         b9FA==
X-Gm-Message-State: AFq9FYL+y8ChWYLaCkVamOBNxtpWMvZ7F+43Q2PQstfkqVwFlDgXkgW6
	wTBWlf9NLVlGYuSAbRN+z45KXdsaziH4hxGaCrA7qkOrx8ml1uUbU53i+DO3Yw==
X-Gm-Gg: AYBFou2iRuedaCwWSqoCb36Dv4gPwRamVowwwRpwoffM4IDX1QSzEMuWTIeDVo3X81C
	SfoXJY3NumnAzgEQhAlpihL8lfWYupfoHfA47r3wHKjufHpuIpWJr0GgWiCb0zfOWbBHd0/8J9F
	M0yG9n9d8BkGMG3hTLFhV9gal1eeRHs8tfhjsSlwg5eTH9jg0DeI+/4msLHwBU2YnDWdFmrdYgO
	nP3EEpJpkBxudBT9YKKII8YoabhDvV6K0PFA8mDu8tsbpUdBBQVtnIea4XZTCeJrzd4v4Yg9N4y
	2SdX3IL1+XdDaSHxMm6S1H1XmzpxfaBheRYPKTnmO0EJTQkw19zZLG+POJ+aRwXpHNOaL/EwJp0
	T/Os6UoWWEY4r1sqWoNM/ZWojU/9SkEQPJUqiOuGwefATDNUanSsSJHoZ8oCrgsPlTsFwwh58wW
	yJh8hMhKr9Fjv1IykebKrjT0ikOvBx/Su/qKIVdmLYuIdO8+3+e+2SLMHJEX92lqZ9jTwUKgCsg
	FzQGSzHsso6gpR1Y8akVeOiYt4XfNuw7ZRHQcnN/9J4tBHQBMi6TXXck5a9SmfD
X-Received: by 2002:a05:620a:4043:b0:93e:c12c:fbbe with SMTP id af79cd13be357-940ef9559b3mr244110085a.75.1792843426050;
        Sat, 24 Oct 2026 05:03:46 -0700 (PDT)
Received: from [172.17.0.2] ([48.217.140.100])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f078a762sm163863785a.30.2026.10.24.05.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 05:03:44 -0700 (PDT)
Message-ID: <6adc9ea0.e20a777d.8d4ed.ceac@mx.google.com>
Date: Sat, 24 Oct 2026 05:03:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7545975644771806326=="
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
To: linux-bluetooth@vger.kernel.org, turbine.bmw@gmail.com
Subject: RE: Bluetooth: SMP: distribute the identity address when bonding
In-Reply-To: <20261024112435.247650-2-turbine.bmw@gmail.com>
References: <20261024112435.247650-2-turbine.bmw@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7545975644771806326==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1192641/

---Test result---

Test Summary:
CheckPatch                    PASS      1.29 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.63 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      22.03 seconds
CheckAllWarning               PASS      25.38 seconds
CheckSparse                   PASS      27.72 seconds
BuildKernel32                 PASS      22.40 seconds
CheckKernelLLVM               PASS      24.82 seconds
TestRunnerSetup               PASS      517.74 seconds
TestRunner_smp-tester         FAIL      6.94 seconds
IncrementalBuild              PASS      34.11 seconds

Details
##############################
Test: TestRunner_smp-tester - FAIL
Desc: Run smp-tester with test-runner
Output:
Total: 8, Passed: 4 (50.0%), Failed: 4, Not Run: 0

Failed Test Cases
SMP Client - Basic Request 1                         Failed       0.018 seconds
SMP Client - Basic Request 2                         Failed       0.017 seconds
SMP Client - SC Request 1                            Failed       0.021 seconds
SMP Client - SC Request 2                            Failed       0.018 seconds


https://github.com/bluez/bluetooth-next/pull/995

---
Regards,
Linux Bluetooth


--===============7545975644771806326==--
