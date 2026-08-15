Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CB51D5160
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 00:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786752910; cv=none; b=NjSCp2oPjbeZzur/v3zQgrupyIgzflHxkTHzBmcd4CcciEB55yr02OKiGuV9KW4YKLRoIc6woS4vW7bg825TC9IfYzi7ri3WieYgdK1/bZiHf/o0O95Rkke5Hnb6NP6zXOMmqGAKsVOqNj6PCpLm4YfMmWMeLAd2gn0DIg9zbWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786752910; c=relaxed/simple;
	bh=pTK0thiejVnBSpKk8SDCcXV8NIFEPgPXQi2TsxR8p9M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XBs0OG2yU+4+6WJzdFfWrbxy9lqZ4/SPbg/rpaTSrIzokQVyoOfVFfQRmxSrMzK7sW6eD9NsydG9vHlbIEBBXXN9IZyglIVG29H9eCDdjjt06VeS4ktBTPzNCl3gYCKpvHhL62UbCmjVyhxBx/mkD/QyeFCzFdlc5niKMSfyeGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGdYlM1l; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGdYlM1l"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e65e18969so101011885a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 17:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786752907; x=1787357707; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eyYsYMOSRgrOYg5Ny/8Cp4onuWGgmPevz9yZU2I078E=;
        b=ZGdYlM1lKW/a+icvW5NU8IFsCjtwYDuZaJcu/McR3BpJtD6ddWpwAH7zacjZ7WRn6k
         fXE4HMMYmiczK+fb3q2yeghm3NFi79rhga/LjX+9imRvOvoU2UNP+mEKGi1FCBr53mv3
         +kfJ/qMEoP9gzJ+CL3yQzIs93OZd9l9qjVU2SC/VnenPLAqedKqZ5npYhCGTG6oCB0mM
         9aRl5Z1suTDMDtzkg1MRzVcHxOzeBIjHPJ1wVBp9RLtxMQF/KHLx27WYbciiMe+BBbfE
         +YtGBoM5TysXKkjiwGQV37sRELvpBXkLh5SkH8sK96+uHGvD/0vVAyzivY3dE5O4EZHT
         u5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786752907; x=1787357707;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eyYsYMOSRgrOYg5Ny/8Cp4onuWGgmPevz9yZU2I078E=;
        b=r88XGQRZcssY8jXHFf99+gYI9Ix+icMtojLmzGbmPA19bQyJK5FipU/roqtLCu3gVD
         3cdfVsRpzcDzlT6DPo/wNqGrRDbyBJuMLaHkASF21hbuzc89hkILIrTO1SsEEoYWF9d7
         DYTRmral285NDJ5OLvBWxz2751NLEf5o4P+WBRWbu8vHUacoKhXcruo0qvFjBH8RxWKz
         7R1z3VWGHk9xi7JTGHxbSPIXds0SGducpUcW5vXlxkarouTejG1UmgKpo4eC/g5+U9Cp
         be2j5IJuWHcLE+MzXp1D7q3xLgYde6XfWkAdKO62nVqTTSkihPiZmLJIcU6UkmZAPuPU
         BcIg==
X-Gm-Message-State: AOJu0Yx29MA4BGcZGO6lwqgNuQvE8MnmBUOTHb5e5s0HhPyuYSn61uiY
	ZZAFmRviOFNlFBAotzhXdb5hn64q3/EyZo0JvBq650NVFid6TkZUNjWUU6oJEQ==
X-Gm-Gg: AR+sD13FYq/AHfcmX6B9mEthFooKsYxduoyyEap6g+So9W/OE17ggL4BOUTMGnY10wn
	lvYV8LvXQV+nSD9kGnrFsTkeTBgmGLL9JTqL6roHBObiQnO8KDmO6bAGpMskBlVRYCv2e07NOQ/
	b8yX+bSxBLG04owykT8fBVfcwXHSeklWizQOo6etk8Ml93a2mOO7DHw4jqTALWcXa1JeqYEsBhV
	JDjcS4zfUwMEyIHWlBUtEV/a2OnvxgkUUpKB+uACCBv1STMRO3l/uYIQXw7MbLldUAeGHAi9g3s
	tstlpYVCPnPEbVlpPZctHLZx4t4godUSMz/GJL/33D1C8ezpOsKQo9+cGfs2qEAOOimVv3MqCtz
	S07cFCTRwgY6NIO5+OLr4Cfq8mFX49Qbd5T5hv+fg1bXXXzIKDXCYHKYoCxsqll1+9Vu5yveNje
	O97MHWh9yKWW4H/5rFTE2+7qS6+cLAGA05UvI63A6oqLX5MTmqetESGMfs7L0jXOMyCdki
X-Received: by 2002:a05:620a:4611:b0:915:29cd:306c with SMTP id af79cd13be357-936c06436ddmr1638285385a.9.1786752907448;
        Fri, 14 Aug 2026 17:15:07 -0700 (PDT)
Received: from [172.17.0.2] ([20.106.198.161])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936cdf55e41sm392523285a.2.2026.08.14.17.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 17:15:06 -0700 (PDT)
Message-ID: <6a7faf8a.3f8fff0e.fa932.d06e@mx.google.com>
Date: Fri, 14 Aug 2026 17:15:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5086639371670651696=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, tristmd@gmail.com
Subject: RE: Bluetooth: cancel devcoredump work during device teardown
In-Reply-To: <20260814231248.3096377-1-tristmd@gmail.com>
References: <20260814231248.3096377-1-tristmd@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5086639371670651696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1146338

---Test result---

Test Summary:
CheckPatch                    PASS      0.96 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.38 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.69 seconds
CheckAllWarning               PASS      29.23 seconds
CheckSparse                   PASS      27.66 seconds
BuildKernel32                 PASS      25.10 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      480.86 seconds
TestRunner_l2cap-tester       PASS      71.48 seconds
TestRunner_iso-tester         PASS      99.99 seconds
TestRunner_bnep-tester        PASS      19.79 seconds
TestRunner_mgmt-tester        FAIL      223.16 seconds
TestRunner_rfcomm-tester      PASS      26.10 seconds
TestRunner_sco-tester         PASS      32.03 seconds
TestRunner_ioctl-tester       PASS      27.21 seconds
TestRunner_mesh-tester        FAIL      27.50 seconds
TestRunner_smp-tester         PASS      24.00 seconds
TestRunner_userchan-tester    PASS      20.60 seconds
TestRunner_6lowpan-tester     PASS      24.45 seconds
IncrementalBuild              PASS      24.51 seconds

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
Read Exp Feature - Success                           Failed       0.252 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.704 seconds
Mesh - Send cancel - 2                               Timed out    1.980 seconds


https://github.com/bluez/bluetooth-next/pull/585

---
Regards,
Linux Bluetooth


--===============5086639371670651696==--
