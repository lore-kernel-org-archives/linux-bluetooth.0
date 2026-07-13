Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23BF4192E5
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 13:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948314; cv=none; b=S2Vla/6q1W0vo5/BzmLZ9qf4OHZ1SJvXcFa0Ckr4vbkjToXsZI28Hf8WgcpxGlsMpJZMOHIasOoQsHN2e8Z7FPTJlb8Grtme+iMulfb0pQ1MDuT+cBSyeeJ+HWViCOJyHClGLlbYoWxJxaie8ufUmTSXzMgT33ORDDftl9LfqXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948314; c=relaxed/simple;
	bh=MECoRKzXYMOnWzyBntgAjLehLJ9FnD/10992gUFcJas=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZU8+83lsCzP2Z3eftduuBxO7IlBKN0BjQWP9YUQHmNlKHBK1D9HMH+98DrSM8xtscwbtsn7Isu4+PKoLBI4MUK1N4EZHuCTNW36idyQCXbOH2D2P0kvoZ8wLwgt6najGpd9TCEnsRHNc23VEX66b/zxqACZbUV1774D2WLPoq4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGxSl+fJ; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGxSl+fJ"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c1372f84dso22112761cf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 06:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783948312; x=1784553112; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=psfLuqkGR6g92CRTnTbBDYuEK6gypbVEcJsfhlpwID0=;
        b=ZGxSl+fJcOgzcnX8Rg87blzKAUWqyF+CLtA5D/rPjNMx2IRli2nbXdYf/ulU+KuLRI
         mMREXD9ge+HHt3fHCkoC+OZrdzxI8cy58DCIyjta3hF5wTUV0OHbOJ5ltNY+/4/DXhXw
         j1RNJ9MpYQUI5efAw2RxWFFwnXEL8ykOBFhbr4D/QF+nWf3LuCDe8AD5vwnr+fN7KluC
         LWtc6wg6Xu0aNUL+X9T0hzOwnN5g4BUBuWbSmoQ3MBrJldtgarQSPR8qNDpk8+lV7kKK
         cPeq2OU0iDJp4zBmegAUpnaIaIk8d4gpbuqdsQ2BtdYsFSh2SP1PVMKhJ0tkc5Uoce7b
         FX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783948312; x=1784553112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=psfLuqkGR6g92CRTnTbBDYuEK6gypbVEcJsfhlpwID0=;
        b=g37QOCZHMMxNvvDLGZyTW1Mj6vRp2lrz8JM4lqKPq8skqactnmbqoCc0V0HJo4ym5Z
         m1eMFzX8SaQCOYaDE7qjxaS2QiP8w8BItORx/fBBPAe++oT4209ISHwBLS189uQPbyZI
         Q2JPYoZzm88FDHR++2atDgcU7OSmP6OxUWWFIEGiM9qj4Naz+WlUH527n5qzUL1FeErd
         2IUUSswSxuyZl2Ik+HkdP5Z4k/1QSF07RJkBkqGx/wGXg+FZK00KkU8ZeoaarTJvEIcp
         /wj0Kg4exzo2YElkX5mYgelxWbTCREq+ZpQ7d4hmR7/dUaEKw2wISKoG6LUOK1h22A2F
         +8qg==
X-Gm-Message-State: AOJu0Yxa7wgL75Y56jsVwxtI6ZWybiDpuzmT3XvNvlS9dyemAs4SVTBY
	bi2qvTBh6phqoPfggjDpdVvvbEICnqd3NKYWpCu3QwA6gT+NQVw+U0/kzZtkiA==
X-Gm-Gg: AfdE7cmgjZKid1JMiVcPa+tzaDc08e6qoBeEOqx6usHw6wCDDQopbPruDXtuUyD87eu
	nrTt6GFPrpilJ9t5ovu6iuLNSVkseKP8kO+5bEU9vSsOSZzFAS9jeMaJwfxxNpbhZ1kOzJ/HOeg
	PDV+6nPwV5euxkdbIYPxZJi5cFBhGmPocuBXoNtu1RgtN+DWcfuaxImqwVofVen6eLFsQ+QCnQE
	if3T4DqMe/bDbnGYVxshmTk+kUOyuF6+h0oREXkyUgcqquoowDZvBKPQusEOTsHU+Pl7NgkkFmM
	QZpfg3sBPlAmZ0qnz7ug03YXG301drZaagyMba98c024phPvRUdOTfkFv10Ma7mxTSxCona6/oK
	Hxz+4poDJk6zZJ0BL+A/KorO7bP5GjQ8Fbdwh8G6KWK73UadJjZ0TEVQMGU2pt+H52W4vVhXXsB
	nVygeWhKXVN6KnxMmvEJPu
X-Received: by 2002:ac8:5705:0:b0:51b:efbb:fbf with SMTP id d75a77b69052e-51cbf16f51dmr85351061cf.18.1783948311521;
        Mon, 13 Jul 2026 06:11:51 -0700 (PDT)
Received: from [172.17.0.2] ([172.172.119.99])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caaf621e6sm80187571cf.24.2026.07.13.06.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:11:51 -0700 (PDT)
Message-ID: <6a54e417.043ad0dd.13e2bf.3ef4@mx.google.com>
Date: Mon, 13 Jul 2026 06:11:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7280104866314249567=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: Bluetooth: btusb: Preparation for upcoming Qualcomm QCC2072 support
In-Reply-To: <20260713-btusb_prep_qcc2072-v2-1-bbcb651285f2@oss.qualcomm.com>
References: <20260713-btusb_prep_qcc2072-v2-1-bbcb651285f2@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7280104866314249567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1126612

---Test result---

Test Summary:
CheckPatch                    PASS      4.00 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      2.22 seconds
SubjectPrefix                 PASS      0.65 seconds
BuildKernel                   PASS      25.07 seconds
CheckAllWarning               PASS      28.29 seconds
CheckSparse                   PASS      27.40 seconds
BuildKernel32                 PASS      24.96 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      459.28 seconds
TestRunner_l2cap-tester       PASS      57.49 seconds
TestRunner_iso-tester         PASS      94.91 seconds
TestRunner_bnep-tester        PASS      20.86 seconds
TestRunner_mgmt-tester        FAIL      221.58 seconds
TestRunner_rfcomm-tester      PASS      26.04 seconds
TestRunner_sco-tester         PASS      32.42 seconds
TestRunner_ioctl-tester       PASS      25.98 seconds
TestRunner_mesh-tester        FAIL      25.96 seconds
TestRunner_smp-tester         PASS      23.13 seconds
TestRunner_userchan-tester    PASS      20.10 seconds
TestRunner_6lowpan-tester     PASS      22.83 seconds
IncrementalBuild              PASS      48.79 seconds

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
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.239 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.605 seconds
Mesh - Send cancel - 2                               Timed out    1.987 seconds


https://github.com/bluez/bluetooth-next/pull/430

---
Regards,
Linux Bluetooth


--===============7280104866314249567==--
