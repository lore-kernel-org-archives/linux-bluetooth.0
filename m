Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2662D3A93
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 04:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784002049; cv=none; b=BfXMUX80lK8Sh8UWmbtZV0Mgf3e3W3sTYhnlXumLa076Y418B8ksgsCEkq6mlbRJEpKL3co2BAHdn/cCJeSarroRc3adFnlE0lzOGGsFBD6C0xawT07xvWPX5vusD/RrI4ik1SsDEc0poK1HT4nANrzXCf+MnydYa/Vt0+yhcZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784002049; c=relaxed/simple;
	bh=oNk9xbyCrQ3ccuoQt8tYZ8efmSZc36+RGHYr2TzWXD0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Xq/8V5BHbIlFQXm4QFtSp//5OG46sQnJG31qGv9zgR1uIe7f/tKGjvxpCstp6iDofCx5HDOCE2bflHeqXbkbGdNwlWTOGTtJ64G9e+UrAqn1grTwN/CEKXxwGXmEdGkYePK8hjCfHtOyP28LoR4CTUxGiVH1yinfPkq9grG1Nys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATLfSGut; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATLfSGut"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c0006ea8eso26849701cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 21:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784002047; x=1784606847; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S2oi5aWCWjWKYisBmO06/mKr1NDVCeTSVnjKWV1nb2c=;
        b=ATLfSGutaMeaymKnP3nPRD0JFAY3O8wTmmPspfLrlBBHp4a+awYRo9KJlNPDJX03Zn
         034nxby4X+zS2OQn5IAz1GqofBVU9BfSEyQRyD52AorucmTkQ+3mLjM/BjiwLvf5mFIt
         NIKYgp6AyfljkhrzIouj5oh2nEsJlRD+QL6+1OD9D38cbF9GLUm0S9yGSbuAfzKckq2B
         2clC3OJYqzHxlob8LelS85nnjFK3RXnhUYh+rYqfEPN6mI6pffSLGlJCWJoPDwFLo2H9
         /ih5NyCiigTB3yvO0XqqagKdL2aEi9E4eHK64JPwXVG5ytC/YPjhaP+UmvVh/X9xxg9B
         fPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784002047; x=1784606847;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S2oi5aWCWjWKYisBmO06/mKr1NDVCeTSVnjKWV1nb2c=;
        b=FSM8wwsVlzHPTn8yBsI3j0ypTXb5KwjPNlmQKLKEPgfdYz466AevuyNCN8OwiOfd2T
         l7w70axoEVOx2pkLL4VHlha1GaKy64b+APg/Eh1qlpF2wOWYXbSWbrUteBo2APX7bMt+
         m05V9CMkcuw/YZC6QOXsiAoGs5QRRt/7+KrcWJjN37i7rQCilTRAmccRGdyUGNmrK1ou
         zwUf9f4WfNGZHeCglsNXrzWkVNmSnCuvtJ+sef4V7q+ts2IkR9bifqGbG1keahVrJsf6
         hyviYCgeVuIWB+ob0Jwr6CuiXeQwYk5dCZzygZDssSrtYrPaY4wzHqrzjue/7TozgVis
         7Z+A==
X-Gm-Message-State: AOJu0YzU5oDxeTRI+lfcGf0s/MZYekQLl+w95aIpU/Tfb2CVCMiDPgz4
	uQvlLP7Clu3E3kSKctYiDEQS+o9TiI/ESdYu/rKDCYEQ6b685utSy5r6AcefXg==
X-Gm-Gg: AfdE7cnrx0BDr+LScRZj5DSJnLEO1zLAuQS6RQbiRpGlR/JM3x1gJH7CSGuKzscv7sl
	l8DzW2rRkZXeNNTsPSz2BaLFPwTImOfOdmRSWhVLRZquBs9wZcKuyIb6PpydttZp7T2gHQdrYlE
	musySyA4GPbDPFwMQ2iZ20ZYYHsarcFxk11zRMBbvNV9iy/3fQW63stpwGAwgj3ZFL/foc3gX86
	dHuceH0gKirENy9essPFzHSovoGVc0+ZlGiVaUH4C5lgzY8IPuBaddcxJ4QbaGEsq3fyT+txs9b
	WVM+tjiql98zF95FSzxg6ng1sD4JMHxA9xKJxTfuii2s0t3Sqnlui/XPkSvvvfY2PPiI4l8CaPs
	EZY++BHDeP4+nCzmKbYT+ywWtWZCLCEyb0koLUGMdmV6Wnvh5ax+5wHdMPWcBrxx+pm78zc+Rx4
	rd4CSXcrFTa9qDVfGK8Q==
X-Received: by 2002:a05:620a:2549:b0:91c:d0b6:13f5 with SMTP id af79cd13be357-92ef2b9683fmr1164106085a.19.1784002047217;
        Mon, 13 Jul 2026 21:07:27 -0700 (PDT)
Received: from [172.17.0.2] ([20.62.255.19])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d61fb9sm1272972885a.41.2026.07.13.21.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 21:07:26 -0700 (PDT)
Message-ID: <6a55b5fe.28258500.1e9681.a46b@mx.google.com>
Date: Mon, 13 Jul 2026 21:07:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4850113061811967373=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ameenaladdin@gmail.com
Subject: RE: [v2,1/2] Bluetooth: btintel: Fix spurious error on FW download error recovery
In-Reply-To: <20260714031005.230895-1-ameenaladdin@gmail.com>
References: <20260714031005.230895-1-ameenaladdin@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4850113061811967373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1127044

---Test result---

Test Summary:
CheckPatch                    PASS      1.98 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.66 seconds
SubjectPrefix                 PASS      0.26 seconds
BuildKernel                   PASS      27.14 seconds
CheckAllWarning               PASS      29.69 seconds
CheckSparse                   PASS      28.86 seconds
BuildKernel32                 PASS      26.47 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      505.27 seconds
TestRunner_l2cap-tester       PASS      59.79 seconds
TestRunner_iso-tester         PASS      79.40 seconds
TestRunner_bnep-tester        PASS      19.40 seconds
TestRunner_mgmt-tester        FAIL      215.28 seconds
TestRunner_rfcomm-tester      PASS      26.08 seconds
TestRunner_sco-tester         PASS      31.19 seconds
TestRunner_ioctl-tester       PASS      26.21 seconds
TestRunner_mesh-tester        FAIL      25.93 seconds
TestRunner_smp-tester         PASS      23.56 seconds
TestRunner_userchan-tester    PASS      20.31 seconds
TestRunner_6lowpan-tester     PASS      23.19 seconds
IncrementalBuild              PASS      29.35 seconds

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
Read Exp Feature - Success                           Failed       0.245 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.180 seconds
Mesh - Send cancel - 2                               Timed out    1.983 seconds


https://github.com/bluez/bluetooth-next/pull/435

---
Regards,
Linux Bluetooth


--===============4850113061811967373==--
