Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153032773C3
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786981739; cv=none; b=Kqsnd0hOehgEplAHQbahfIfc1IvU9idUOpYldP4gKNycSpJ/hJp8H9BJT2ca26u8qf95sdUXmbHjqfdRzbzZP2V0Np+1NzZHSO8UP6ikfRHys5xaqnvOcd9m+5zY5j6T0GfP/e+LCbZl5/jOzrr+FIpyf2VFDy0HfmLt4/5cs+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786981739; c=relaxed/simple;
	bh=POuA5Z3tukynM4bd4/Zr6B2Rkfv7e5AtqlHvWPvIjHg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Rmwb1Cq9h8qKUGSuIEBoGxHxx/snkpByvloHt6SMg3/xUFAPf8He57Z70cauiWvP+FJp1oIjPTU1Cvcjt28UbGVwyB4N+5vZNJGrgVnLtypvcYUg9ui93CNvpLNwODq7rBqJorL+ybURudvGZNbTJHz35b+TueIr1PcafEiVuPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDeXQ3Et; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDeXQ3Et"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e6b5737bb2so4195143a34.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 08:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786981737; x=1787586537; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xZHPXUkbEuWpqp9gbUPTXgX/t3PBDpJC+lK86xezMUM=;
        b=CDeXQ3Et2b3MDD4n/YYbpSu5HbPlXzVUUV0IIGZtif8ATmVxY30fkqXsJ8fX5kCEsL
         N9+DZTjMzj50lauwCMC2L2H0PhnV6RDpmPEvXjCaudSOWERTFcwenKf066qeQX5Xc+D0
         6P/IVEJ7hI4VWzI10L51RAiYVL3NS6OfChDBEZnwem83nslj09WEta6lyjq+5HFG5LWK
         KBtQ79YVUwRwpocgZAD4gMolNDnIq+dlDhQ2MNHH2y46oOjDvaCSkQda6jfqpcbEcelH
         KanuczJ5A/2KzwdFbY/7EJ276W8h3aBNMdkHwW7aIhYl+WR7sV7HcDwWjyUogEV8Gb+u
         6c1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786981737; x=1787586537;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xZHPXUkbEuWpqp9gbUPTXgX/t3PBDpJC+lK86xezMUM=;
        b=N7o0xmOAMola94TBSwu6CEYkUVgGUVCtL76najYpOebpP6qbY5HYXgbpcgW96Wa+jw
         fTFzVtWB6iOX3yqMNQrTwXKdWvuEC5CYHI8X/XAnIMdsOyEAZNh1w+ttQfCEYr4dMLsF
         Lr63Uq9Z6n549X3Nl0RxYJaTLYc1FqJfKMqNjaDgr8EoNRD/oNIXwuLf9SPnFt/TGuqj
         blzgoG61msBbXdura65HXm7xTqHpKRXx8mAkxmYVQD7FS1wQNzpKwXwl8UEO80vf7CFW
         xplkj0JcbrcJ5IjPe+9fVAeX2+gy0pygGcfjx0abeq8sRgtoO1udg8Jb1RUxhLpMdGj2
         oJqg==
X-Gm-Message-State: AOJu0YwjOhC7FPnLzEpN5ru34NUnEOmnn3qMUBz5ME7TcRvitV8fpjJb
	F/8HrwkhJjW5NdSiW/xfZ9727qXiPDWH/zT8XcCJVaFxr9UZs4UgaS7tZBBPgQ==
X-Gm-Gg: AR+sD11qpyk99tiHNVy9f9S/T+9rjpRGSTOpA8LZ5W6oUOifCvkNC89z/11sulGoHi4
	CvyVyZ2O4M7LCwZSAYULJHhbyggYzDaFjqH+ZYqEpCo2lrKdNXAzxDPjy3LGOpK0hu0Ww9Og2FD
	rWVY82jiMuEjQ3nEvFuxd9++HcJ6kDQtmKHxdebNO0n8vnluHwMcMn4i0DA9SdbWoh3Bs5w4Med
	mEIWk30tj5lC+PBD5eU+8YH79z02zy3FPIFxcurb/cs5sacrLjzeePIoL9Q/YO5pHd4i1Wkc3aV
	UpZ/DtI6mCWhfNoVH63JunPPYLAm0TSF6SvQJqcuEVja2IXOhHnIfAB3E0+Gmrri1nt9bnH7qO7
	v61n23guo9F5/TcJ8TuPWNrvjkZRcYQuqs+Ie3RgUuAkn9Sj4Q18nSMwmxn2Z+TjZEcJF00sTIC
	pDTM2+CVwLslJD1z+EKfQi/VxrNtDk3CdFOrMDMhGnmm4MTjvb2Lg3U0Xt3MnODwKckw==
X-Received: by 2002:a05:6830:61c9:b0:7e9:c8e3:4473 with SMTP id 46e09a7af769-7f423f8730amr1381590a34.16.1786981736716;
        Mon, 17 Aug 2026 08:48:56 -0700 (PDT)
Received: from [172.17.0.2] ([52.242.243.3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f41bf2c916sm1880339a34.9.2026.08.17.08.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 08:48:56 -0700 (PDT)
Message-ID: <6a832d68.01061b14.332950.c9b5@mx.google.com>
Date: Mon, 17 Aug 2026 08:48:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2051742340201830502=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, valentin.kindschi@fiveco.ch
Subject: RE: [v2] Bluetooth: hci_sync: pause advertising for the scan address update
In-Reply-To: <20260817150323.520207-1-valentin.kindschi@fiveco.ch>
References: <20260817150323.520207-1-valentin.kindschi@fiveco.ch>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2051742340201830502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1147270

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      26.01 seconds
CheckAllWarning               PASS      28.50 seconds
CheckSparse                   PASS      27.04 seconds
BuildKernel32                 PASS      25.08 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      470.30 seconds
TestRunner_l2cap-tester       PASS      64.83 seconds
TestRunner_iso-tester         PASS      102.25 seconds
TestRunner_bnep-tester        PASS      19.79 seconds
TestRunner_mgmt-tester        FAIL      225.41 seconds
TestRunner_rfcomm-tester      PASS      25.36 seconds
TestRunner_sco-tester         PASS      32.38 seconds
TestRunner_ioctl-tester       PASS      26.29 seconds
TestRunner_mesh-tester        FAIL      26.19 seconds
TestRunner_smp-tester         PASS      23.48 seconds
TestRunner_userchan-tester    PASS      19.88 seconds
TestRunner_6lowpan-tester     PASS      25.75 seconds
IncrementalBuild              PASS      23.75 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.248 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.128 seconds
Mesh - Send cancel - 2                               Timed out    1.984 seconds


https://github.com/bluez/bluetooth-next/pull/601

---
Regards,
Linux Bluetooth


--===============2051742340201830502==--
