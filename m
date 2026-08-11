Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9152C0F6D
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 09:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440176; cv=none; b=NzNbC52zQebt68G7ntCu/p/G0FxenMyBN+MOFnqJhDy9UtVGXABxQ91/auKFrcWxbxicKLyZuHAmhay1Dkv8fyxIQIAWdVCpSu0CeQ4op7AMDqVaA3G1luprOMh2Mh88cXMXTdwYJEzeQCRjm4RoZfv6FU21TcnNXC8qqJSFqEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440176; c=relaxed/simple;
	bh=tHkZ7ctNVUNB4j4gPxkv5TdBS4nEnWQseI2hIfvKHxo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MNl2iFjWzvwRiXtoLMMDpVnldcAEmoG29V4c/Iked1WZlPFSLPAqLWsluga7vdgew+OF9P+Zx5jotNtnj3SVjQiW2ONXorVOuVVLrUyCUynvAziQssTSTeZtAVhdfWV3MDdKYA2mebd6PTwX8iDAWMVUpgb81f4uvUS7eTLav/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKedG5UM; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKedG5UM"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92ed3993c1eso140202385a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 02:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786440174; x=1787044974; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=byljGCvmHXc/L+0sMI3YIOpVrcYI/SFoGVBmhwHMZyg=;
        b=PKedG5UMHKh8C8o9wPqP6C9aRG87KXmCHO/o2L5fMpHsnkIW6nFtSN0B5/QVmkaTb8
         0QmzqqUnbbYs71N2E0VPUOUlc+FhGPIPekX1KTJ6fm5RgPjENld8RAm1HzcJMunHGbXP
         XnoloUi9mSEVBRDjVdIulzqK1peSgXSOU7/JVCwmsx50jJk2NESkflDICoTFwJwiCsx1
         +5Aw5tYZcJGLmMxaXP/XZp7pTtcB1UWdR/JR5BzmFmm7Mnz5J98FrtE1QaAyZulSDl3s
         dwea4zwDf3kAAgDwdEGPoHwiurYXEt+/uZhADDBKnaLspDgSTBK5pZ09waUI31FBr3KF
         XlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786440174; x=1787044974;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=byljGCvmHXc/L+0sMI3YIOpVrcYI/SFoGVBmhwHMZyg=;
        b=SuHt5tzCNfYCO7CiUK4tfSQQf+GqI/Sr4CxVTKmrZsoGL5uvsDSfkd9awJcgBz5IOc
         BENbJWd+Bpnao6lNgxaa/k3ZmlbHCxZuqMR4Lgjd6szhK8i1pfruvuMy7Vupj6oVc/YZ
         g6ql3hSeAHfqW6BkKMH2AtDRUF/RPQaxyb8QRmMKfcLd1A2qNn5ltoZG2IvO/2sTEAGx
         ZZVIXXDeDSQKGaoz6cOQicLlxxQlschPpUUyA/ohST7j2KOIMXS1pjINDWa5wJ4Khbm0
         TdSpFq/JzaHt/6KPSS9g8zwQKW7tymM5UYfhg344OGqzVgZi2QhvN7rF6I7ibZAXiCF8
         K29Q==
X-Gm-Message-State: AOJu0YzkGumsrAzhOL+87qi2/dEE575OIqbfRwuwE4/dMW5UOOLjcnr0
	0DvjZL1ASrfy9unTqnuPKlBVhJqji1YJUElZpybe0IINp+mVuENWedRoOkJALA==
X-Gm-Gg: AR+sD13oyowQZemd4fOxy9BZxj9QTnJlNyCGDClRVQoC6QD37B1h4NCpDr6sNEgP3ZH
	ntfP07sab0HrGVK/rrAh1aAjb0CHI30waJQGXg0MQx2rE9uBnn0XrV7ex89YjBsTyfnw/W7RYQf
	i0DQ8rC6yrvZnBkUn+PmvPYmFee/zHvd5OAeK2vybPEo8is8+GRJ8RnmuF7DsOYrV0fKyHkQ50H
	IrkrWAoURxz9bYwyihgEVivyCt4NwUlhCbLjNxuy5MFkK5+tIOl+hw33A2XuvRy3MEBS+XwRLLF
	QIq9AI+YbiTtkKZvQzm7zaJQmhN351AXtocZ6iHtJWh+g/0DjURpLXNAxDYies2t8+0S15NKke5
	Ji3EGpcQYiy0AU7tgF/CY/EVqXXN6ozPdxyOLPtw4ZKXvIgim7KraYLZ11m+DQlscyHod3I2Cgy
	QLLM0KtuEOQE8TuBVdctaKxB8DnOc/U1BvCxTiDW0uMUD06Sfmdd2AbguizDI1xpWYoL3SaBIFe
	k4=
X-Received: by 2002:a05:620a:31a6:b0:933:4b51:d348 with SMTP id af79cd13be357-936a8f95507mr129872885a.39.1786440174195;
        Tue, 11 Aug 2026 02:22:54 -0700 (PDT)
Received: from [172.17.0.2] ([172.172.157.211])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936a85e8ecbsm70155385a.37.2026.08.11.02.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 02:22:53 -0700 (PDT)
Message-ID: <6a7ae9ed.9e118ab0.227f96.1808@mx.google.com>
Date: Tue, 11 Aug 2026 02:22:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9049652258658101237=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, johannes.goede@oss.qualcomm.com
Subject: RE: [1/2] Bluetooth: hci_sync: Clear HCI_CMD_PENDING when dropping the last request
In-Reply-To: <20260811083730.71393-1-johannes.goede@oss.qualcomm.com>
References: <20260811083730.71393-1-johannes.goede@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9049652258658101237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1143947

---Test result---

Test Summary:
CheckPatch                    PASS      1.86 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.67 seconds
SubjectPrefix                 PASS      0.26 seconds
BuildKernel                   PASS      28.31 seconds
CheckAllWarning               PASS      30.35 seconds
CheckSparse                   PASS      28.39 seconds
BuildKernel32                 PASS      29.13 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      503.14 seconds
TestRunner_l2cap-tester       PASS      64.96 seconds
TestRunner_iso-tester         PASS      81.82 seconds
TestRunner_bnep-tester        PASS      19.39 seconds
TestRunner_mgmt-tester        FAIL      226.68 seconds
TestRunner_rfcomm-tester      PASS      26.62 seconds
TestRunner_sco-tester         PASS      32.84 seconds
TestRunner_ioctl-tester       PASS      27.17 seconds
TestRunner_mesh-tester        FAIL      26.97 seconds
TestRunner_smp-tester         PASS      24.42 seconds
TestRunner_userchan-tester    PASS      20.61 seconds
TestRunner_6lowpan-tester     PASS      24.04 seconds
IncrementalBuild              PASS      29.81 seconds

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
Mesh - Send cancel - 1                               Timed out    2.102 seconds
Mesh - Send cancel - 2                               Timed out    1.984 seconds


https://github.com/bluez/bluetooth-next/pull/569

---
Regards,
Linux Bluetooth


--===============9049652258658101237==--
