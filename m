Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795368032;
	b=JpmpnUmPW7Mq4TQv2ha4PpTdUfjQdbT31DityJwvhNfvEdzsfTHDlXYO2jyDODZv2Khd
	 R1v7BNNkAXCWDqphteS8L8lm3nP3iu8JEGAej8JHB3KO7wYCD+3W3U7CksAi1PDjpPej+
	 /nFr1o8VTDjM1mq51Q42JL9EVe3FV66S9gYTlNCbuhN0AU9xk+avOo618mSR0enkHj4fT
	 uoo+HpXMvpyp8/Q4aPS5Dpn0/k81nqShIzl0RnRDO22c+xi5FgmNwuuSOjba/L23wiSLO
	 UBS9SN8TwkuUzVs2EFTDOkjVxE+5eumqLlnajpI0Vo8JSMGbOyunCYnVRgB43CuOAug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795368032;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=8+J7rdMSXji//61E436ORCD//Cj73cjPADQ5WGCT7U8=;
	b=nIEnBlmXieotM87Xt9LSm7tS3lzLe/9+Ck1zr3N2IVWh+2iZ+1a8UVXaMtOW2dgy8wA8
	 XOjwHZ4h9rsLeeYp0MR50UnpvZvMrCen4eNQp5IFekDRjE498QYbu3VPlHxR4JS/LssBb
	 k6yw0a4Yb8BJkI0KKYC6L23n/I23mwjZmltS37peoLqOrkmKP+JUg7TtjhhymB8tf9Bs5
	 q7sFokQaJhvatpRH9f6cTTOqqizC1A+imDlQDff37uZfRfYxjp7zd/djxonLQb30X2/zC
	 eNHlz4N8CsEGuRnudWT8UihGDPxE2vBqTAcCg62u3E/hB4Dg3ed+oLQQSMDz8GoWqfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LrWizpEB;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B33606A336
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 17:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0B33606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LrWizpEB
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-15ea896ddc8so4201631c88.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 09:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795368031; x=1795972831; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8+J7rdMSXji//61E436ORCD//Cj73cjPADQ5WGCT7U8=;
        b=LrWizpEB5k2o1x3BN3rhpiZ5SsU9qQI3Te4NEq8YT07kyxI9OAI5Q9hvK+wBFuCCRg
         801Q3VN+TRzLcyQ6kje5pxEZpc7son1ap0PXZCTvEr0FI+ti6pHkoESbFpEjB3oBKyMP
         e5tFpv1mK/7L1qvtHjsxCIfho3yK6SXUGDf83pskubpyUtoF7OSQMt7ZHupv7xNwSgqL
         CcVg7hg7HD3jnaE6DnPjQ2Ol3CsLo27lQxBpi+2Cb69TEp1pBpE1XLZA4Z7NyHrPqdHK
         W8N1FAIiOdCZ/jXPnMid+95yMX21ySjlmo8RBhBY8fJbuTnYdJNfOmFSmbg6iip+MpiD
         6gNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795368031; x=1795972831;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8+J7rdMSXji//61E436ORCD//Cj73cjPADQ5WGCT7U8=;
        b=GrNOobMxZ6C2/YUxoB7kNLEhvkfgtND/eqD96prkY3a9zptTW4znFGrLx7Kcrkpw1a
         iMKiArdS3DW5HlqLSPR8gPKje0jGghw49mfagHjg7dWAPeJrpzLN3mvoqEAXAxvFcuiH
         mQuFqDYqas3IRoaKBW7WA0uha12ateiRC997U0xB1phnXFJj63BaTkQRwV5nT6k1bzln
         m3g7vDcGJD7sp1tYrLt80dfGt5tZmqiZeuSZ2Z442B/ERBWeQSmF8q31VY+myTnuVW10
         H/MG+J0H/X7I7kiHVAspv5+zuXDIexYDq23mVv58pCrPU5elPGPQKdEcSLBiIQkgpF+L
         fFYQ==
X-Gm-Message-State: APuU4Z9PsUJCFetIM+WgfC6J1H3XsKvsdldv4ixBq6cfHya9hlFj+6F+
	4edbZ7RBYBRPksFGJaLrYSRN7/RsFqHhyDo298G/l/cL//SwmqWipMW5RJ9L/w==
X-Gm-Gg: AZFdTZcs1TQmPiDHFO93n75D/fxiOJv7cn5wq0xvE2XWf9DibpWsl3V0kaQggzlwoFd
	XQEoFfA70sgt2bPV/F+qGU8Q3f1pVfIkJO5n/aeAKDor8Cifz8WJPvtCqK27uk2FBkiali41iEC
	laHNJafyqJehAzggXMfAFEzdFyLqrpp8whXGab8GPt2Bqz8GmtQHShSnsF2dp2Wwl261eXrbFSM
	Y6EpEAysTKC8AhyIHquIs1DU4lOZTQlqUFVa1owyvPu3kw1dXfzeU44YO3i96VV4xqx3HqAlma9
	4r2aUG26/wONj+lxd9LtKNQQWhUubKN9kIlLDu4CRJOpVl6+RaUws2l3iGsjkMinCVePnwVyJaR
	9dNlo8Z5JBFufyKwJZtOiXx5I67l3ZfRYm6HukHeDAXd63Zmr/e16IO1gmNky6Ggn4IdRO7VGGn
	33lwwHYMF9HnEO+3jxLscE52W3xMJuadW8IsiFN/vuZBWbxqxh0kcJfrLfGWK5yfYNJfb56F3S8
	pnjKySXnt4JcAXyTGp+OhW6qE5ZU5a4EI5TdM5zN7965fQr3gKyiIm2CPzuR9/AS+Y+Ozng8iOe
	XlLMMg==
X-Received: by 2002:a05:7301:6184:20b0:386:b006:c8 with SMTP id 5a478bee46e88-386b0060806mr765526eec.35.1795368030769;
        Sun, 22 Nov 2026 09:20:30 -0800 (PST)
Received: from [172.17.0.2] ([51.57.84.129])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385d2b93dd9sm30198423eec.24.2026.11.22.09.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 09:20:30 -0800 (PST)
Message-ID: <6b03245e.b637b9d2.21af8a.336e@mx.google.com>
Date: Sun, 22 Nov 2026 09:20:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3532768986130600947=="
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
Subject: RE: Bluetooth: L2CAP: Fit an auto-tuned MTU's PDU in one EDR packet
In-Reply-To: <20261122155008.1545777-1-simon.mikuda@streamunlimited.com>
References: <20261122155008.1545777-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3532768986130600947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218718/

---Test result---

Test Summary:
CheckPatch                    PASS      0.55 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      18.91 seconds
CheckAllWarning               PASS      21.67 seconds
CheckSparse                   PASS      22.96 seconds
BuildKernel32                 PASS      18.79 seconds
CheckKernelLLVM               PASS      19.27 seconds
TestRunnerSetup               PASS      429.37 seconds
TestRunner_l2cap-tester       PASS      14.63 seconds
IncrementalBuild              PASS      18.17 seconds



https://github.com/bluez/bluetooth-next/pull/1185

---
Regards,
Linux Bluetooth


--===============3532768986130600947==--
