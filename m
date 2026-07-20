Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C282E43DA5C
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784565536; cv=none; b=bdkHeqklT6F0/ilA18jQ3bnCeStkhdQJG0kaXpKRS/fcvCjYxa4gRGopXb4MXZ9qchYxI1DVIG5IYOdFOkyJr6f4zvoFz9F3APaMlRYFiwIyLIq9VI1ZlbvmIu94ZeozYKO2B9dVmwzdLUx63T31I7C6knC80jz24BMAqysOfq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784565536; c=relaxed/simple;
	bh=OHvkcqLXNx8WwTuG8Ovtk5cZLh1BNzbnRg3Ja9vO+oU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GwkzlZW0PezBMtuGVSjjLb/npbAoifoi9BZ0kSVvVwYzOKslg+MHc3gr4ZX+BIECl0sv3KUVc+Ey2vtEDCH+LOKvo1RRjV6QStVsc16935HJRJkGgG0z1pfj0DCu238RqL/SUOj8ROdi8YYZtc11ci3C0lRxbovpsLs6xuIvSfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h75Tw8Da; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h75Tw8Da"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cf452def93so15869215ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 09:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784565534; x=1785170334; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=m/ATW6X1gVnIGGGXkBO6eQMCGqCMy99IDGti5Cjf29c=;
        b=h75Tw8Da4FWBfVXM8ofqXCYuWQ4XzCTEnRJekdZbcCIcUaOW/470cYks41PIc/inse
         vQF66wybaEJbxMTywRxpOBRUmcryWi67qchhCvBhVaVrGS0BwNONhroG0SR2sBfwZhfQ
         xo5CgYzLEZHdsBMk4oZBM89svinYPXXEHWjE6J8ZnRgJLQv1MJ0kdKwogNd/r8XHznII
         UjEGAWSXMGtO44g2VlNvwPsy1XDBEFV4lBlmmsgZxhyy39baJsa7mCOvqgpONynydzju
         LqdvgOjf/RVsfuZwlf6dR2oaUnG1FXA6AVAHzD0EaedlmxEExwuCxoPeksTYqNyzT+dz
         Ovug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784565534; x=1785170334;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m/ATW6X1gVnIGGGXkBO6eQMCGqCMy99IDGti5Cjf29c=;
        b=mY7f9X2bWM6bwhJMU+tyoCknZ5ir0Q6Uz51SpEzU7pylE4NgJrFpdt88jnjNpEtd0u
         /ENokc1UWv07Fz+OTZ3FplfLbmkU+JhOy5WbR4WvLlW4WgeyKlLrsBZZAg9MvsTF9JOT
         ZU7VBPRiRKWQqQTOv0GYqc2LdjqHYDpS/B4H9U66NVjSkodbdJpVeR6Dgms7fE9rQyFT
         wAmu2ZrNrZM9ziF6bnnrtgd9eTYpcDa7AKgb6wRVc2h929z0sxKUjTuvy4yBLmJCjfDp
         kFL038EFUyhXfcTvqWykCjvBm9nhkWJD0OoGJuvrSlUmQTOXN3t6axcYA/wuf7CSTMSo
         GXTQ==
X-Gm-Message-State: AOJu0YyMW+qffeOdnD7yJOoGshHT8ezE+ybNyeaRLWX/IEh16lBtvDOV
	eFg8rBjQGV9gFFIUqof2iPVo8mrA0JbYnuftV/cMieMhcMMFjtGV15sYdkHOHg==
X-Gm-Gg: AR+sD123rORl/3BMUjaX9Pkcnqj9TCuVAmMBV+krYRDNxVExxRfrSE2Zrl2tTXL+UdU
	FhEbnEjKimkSQLODxNseKxzVZOT/5g44E6EIUYmwhuzQ83ZyWTHuN1aOdEerjgbcnqvjblGIYo2
	GSfhK5kwlr+4h7gSge7iQnPdLEreoklATfEsSCvZAManWOojDVYcoVPi5KLEBBDwyxzIxAj8YtM
	r5sobFYwQrcGkge+k2Gs8KIyWaRffuiEHSH0v6qCn1vO5WPZas7xIHSEk472ZLNEYnhUxw0zlzw
	1QthT2pV9VcJoJWTlDT+igNKklcPPxG0CwuobTg4FhdndaWcxHbiuMf7KoF4Tw7Jc0xKQqAFVWk
	FwIxnCaa3sNEyy9C3evI2KyKUXpTOCdaS30WdCg1QJ0yAnZuDVrx98RFQF5Q0DNcB1Mh1m0zTMI
	T8+RFdQIya
X-Received: by 2002:a17:902:f683:b0:2cc:db7a:251 with SMTP id d9443c01a7336-2cf1f2561eemr196468925ad.2.1784565534021;
        Mon, 20 Jul 2026 09:38:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.77.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20bf96sm37683343eec.28.2026.07.20.09.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 09:38:53 -0700 (PDT)
Message-ID: <6a5e4f1d.160324b0.1f653e.a3fc@mx.google.com>
Date: Mon, 20 Jul 2026 09:38:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6949216581899346262=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: ISO: clear iso_data always when detaching conn from hcon
In-Reply-To: <f3d8d52dcb2a5464393623a56369ea244c144460.1784559155.git.pav@iki.fi>
References: <f3d8d52dcb2a5464393623a56369ea244c144460.1784559155.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6949216581899346262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1130974

---Test result---

Test Summary:
CheckPatch                    PASS      0.56 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      25.05 seconds
CheckAllWarning               PASS      27.99 seconds
CheckSparse                   PASS      26.38 seconds
BuildKernel32                 PASS      24.53 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      461.83 seconds
TestRunner_iso-tester         FAIL      98.86 seconds
IncrementalBuild              PASS      23.07 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 141, Passed: 134 (95.0%), Failed: 7, Not Run: 0

Failed Test Cases
ISO Disconnect - Success                             Timed out    2.623 seconds
ISO Reconnect - Success                              Timed out    1.990 seconds
ISO Reconnect Send and Receive #16 - Success         Timed out    1.998 seconds
ISO Reconnect AC 6(i) - Success                      Timed out    2.307 seconds
ISO Reconnect AC 6(ii) - Success                     Timed out    1.999 seconds
ISO Broadcaster Reconnect - Success                  Timed out    2.731 seconds
ISO Broadcaster Receiver Defer Reconnect - Success   Timed out    2.326 seconds


https://github.com/bluez/bluetooth-next/pull/462

---
Regards,
Linux Bluetooth


--===============6949216581899346262==--
