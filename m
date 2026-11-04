Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781792;
	b=ZfLK9kIVqXSJAAFSddOClLl0K9aJ6vtoRO1JxFZGN6mCAVRNeY6upor9T8aCCF1tG0qa
	 iKhHPhKRtPqU4BidPtvikr7NjXupFo9q+5gddy1tlRX3YJupuU8h14WmsPh1/mBIzl1uz
	 h/5HyIwjemPfp19tY9IaE25AM1aCOBSaV81jfGKehyDVEsyoVAGS+/gjNCBFf/r565t8O
	 KWjXSuq5zfF2pssIflmzQuByo6BH0qg6xuelFY1+sF0P9O/LDL6hxGBtRUOHISVQpQLLg
	 7A+lRlIZIZkevCuAdBXX/QmviYqyvD6B988RT0H+oG4+NF+Uegw34VrmkFr66lXxBLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781792;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=Xd1Bc1AvIC3edaJ6bn7aJs8c7/qnj2l2dcTLAS+8Msk=;
	b=uUAuXr03S16zcc8V1m23RdhvtMS/0jpvX4TPN61nby/0BKSMChhtOXVNI7OEqeQ4LNwP
	 ObpdtytwCHMBbMHt/96Serd4sfPb/OJRLInZqjMAU9HFtEoqRQM84FbnwNqG/tXISX5jo
	 dZG5iMmgCZiO+N0B6tw1LCiXMIYwtCaASNd8m3qh1oJIQvQGdhPNZpUSH6eo/ciGRdnzy
	 z5zhNU8Eaju68yi+sRDWgoiRnurGOHwEM1uxC0pXydHfifyNlhsopWca4Wci/hp2UGYil
	 4w0n//sta4HeVKKC93Pnho5BGoFN5yYz622Hh66N/E38r+zK6BVArOgXJHmfjgp5qUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vHjwdhlO;
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96DD606A31B
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 08:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E96DD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vHjwdhlO
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6f5a0893610so300270eaf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 00:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793781791; x=1794386591; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Xd1Bc1AvIC3edaJ6bn7aJs8c7/qnj2l2dcTLAS+8Msk=;
        b=vHjwdhlOoVh0tLbCgsb1DJ+z66IBDryLGEBPcAGkdLGfJVYKmTnzrMSVVIO5uqtdP0
         IgaTTYQtpSDrc4M0Snk3NRjV3ZbsF25THWcPela02y1iU3MD065Ad2aQNkW2k3xn14RJ
         4nUMvba5CzoftWKbStu4ndRpUUhfaor0Z/fiP4Jp+8VU7O1xOy1C9S/1AdJis+8czAmz
         q9jd+g32SS40rknEzBVcbvgUduLLH3i7kPnLJbWrTJycFETgCmJX/Bxy71mhks0VfVaD
         lZidtru+q2a07FieRc2lG+5AEYUIYQSJ8Ar1c4e9W3/107KR4L80ltONq+i8iW3LxRiM
         jKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793781791; x=1794386591;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Xd1Bc1AvIC3edaJ6bn7aJs8c7/qnj2l2dcTLAS+8Msk=;
        b=tL0nnXX3BaaV2Q+Vu3hMfDyuSQaXXXuhQ+E3LfoQsOLuYj5Akp3v2I6DJDCWsTmL7U
         uwZMOHhINPv0D5qcag2qdil1b+LPYb4Tu58fhpR9oE1uVZN5Cb53wmQMWaWSyaNyBxD3
         n3PcMj0plBVZHBerLFlaKOnz0po0BF+8vR2y7d9Gk+qohOo3Qb5f9cG5z3vZNmeiyx0T
         cd3WR929VmmGeOJ8OooSn4rs06Q328Mhomveh9EJ/YeTLztTqJULMTs3DOE9U3kIG7k3
         YVLUOnVpN2aqIQBCH7SU0RmmSi5EKXx930iMb6N/NJ+yNuNEc3LNecRSd1Y8QlSVR+5i
         nCKg==
X-Gm-Message-State: APuU4Z8MJaZFXBQli1S/TIV1TrHQcPqAvV3v0Ve0mhicXQhQxsZDfMWB
	ju6YkjirroOqCONZJERkzAhr0OldaWUGI1UFSGyEaa1TMl+tyrkV/Ln7Yztm1Q==
X-Gm-Gg: AYBFou2PLzdE8N9ntp0bEmb2bKK3Kbb84C8ogmvJwRpnULlmrYpZ5f2bOMw4lAv19x5
	b8MQxKdUY5wvFKAL2KvgVML6AFuG2tBbGDxxnDRVUIaZrhERSW/UFf01e9uF99L39lF1WXRxJeQ
	R3StiQ12Zp8rT+byA1uRRlBa59Tn7qHoiuqoaZFtRMbO1aX8ZCpB8yqiVdV0gsPtJiYQdFPsfYI
	zrAJ4O7mzAsLsB5aGSN1oXljujceLwH1LlcvOw4hyyIQt6+KFcF/o2mqSFJTY0bYyNp17ZpwxjG
	usK9xJpsuSm1a6NgainayaxGMrpSBCmfD7uLVi3fpqC82XNE9L2THo2DzIx0ljxa9YRWXqC/OL7
	0HeU6S1Qw+hB04gir69mIuGc2fvCWcComsWV1jerVbo72UIP5L6AaxxMn0kuxT2wkU10gF8EGQX
	IYKItq+MvuhLTqmz2PXbzQYRNDx3lBrNg/BOxvgwA7cFDNy+qMBIDIrskIOgXaKZBVRrJbUf9DF
	W6WKz/AcCsjD4jShRR1gndnEQcCbWVSxNAfETsDetWlXw5QaT4dfE5t5BlwM97u
X-Received: by 2002:a05:6820:1ca5:b0:6fd:e28f:ad38 with SMTP id 006d021491bc7-714f29bce0emr8122432eaf.32.1793781790820;
        Wed, 04 Nov 2026 00:43:10 -0800 (PST)
Received: from [172.17.0.2] ([64.236.142.145])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716c1308c96sm1230324eaf.11.2026.11.04.00.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 00:43:08 -0800 (PST)
Message-ID: <6aeaf01c.87c3a088.228e9e.5317@mx.google.com>
Date: Wed, 04 Nov 2026 00:43:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1444517533916755577=="
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
To: linux-bluetooth@vger.kernel.org, vulab@iscas.ac.cn
Subject: RE: Bluetooth: free the ECDH tfm when a sample fails
In-Reply-To: <20261104025336.1527270-1-vulab@iscas.ac.cn>
References: <20261104025336.1527270-1-vulab@iscas.ac.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1444517533916755577==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1201243/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.71 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      30.44 seconds
CheckAllWarning               PASS      34.64 seconds
CheckSparse                   PASS      37.27 seconds
BuildKernel32                 PASS      30.29 seconds
CheckKernelLLVM               PASS      32.11 seconds
TestRunnerSetup               PASS      733.77 seconds
TestRunner_smp-tester         PASS      5.51 seconds
IncrementalBuild              PASS      28.10 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: free the ECDH tfm when a sample fails
WARNING: Non-standard signature: Assisted-by:
#91: 
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex

ERROR: Unrecognized email address: 'DeepSeek-V4.1-Flash and OpenAI Codex'
#91: 
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex

total: 1 errors, 1 warnings, 0 checks, 37 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14942805.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/1059

---
Regards,
Linux Bluetooth


--===============1444517533916755577==--
