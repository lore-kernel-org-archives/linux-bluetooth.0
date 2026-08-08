Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5EB3A0B3F
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786211106; cv=none; b=DoFoazxHfL87c9Z5lZBmw8LKJ1Q6JDLpi21HORDfq6eOWYQ1yVhyFc6WSRy8vP4pwiEnyAphF1mayvHg+G6Z1hktsxxwqQSNSTkfD1CU4V9r/kZ4KJfOodQXb39BUubnRf94ZGEXXL/P2x3S6ENAKg479KNX8IPzP1KawIBo+Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786211106; c=relaxed/simple;
	bh=o0VdURqgX69SkDttsm2dHz8Tz5PSm5wK3zgybV8yBeU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RHguOI/Or/XFEAO7rxcu3Rf8B+vhw6yb/BMl9l3HDRVg02F5MGzE8kAzGlEDYetynUjhMS20pJXxczo4P8/VKwZzSWwSWjhacmRIXv9VnHuPks1PYsYikNHS6XRHZYlwoI5JiBht37YIJIku31JBECkTg65x3EFvjByq55CGPQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+amICwu; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+amICwu"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso367082a91.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 08 Aug 2026 10:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786211104; x=1786815904; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qs0EjSRFr2xxXqINM1RVama5B1i5NV6uYC89OBLk5zE=;
        b=a+amICwunFFtUcELmVLuWWJEE2s6hwJCwHenPA3PHdy1aEy3zqOf0lcCUq6QZ2/E/G
         +nVUtlqsjgGC+SF4yVkKxQzasEcKtK4C3/jBOcstWocL96kObWS09v7o9CjrQ8WARMlK
         8vrTb38NWEXEiW6tToTIlOz3mkYNtRWv0I7fhize6C5661iacJVKYd+Hvtns1zFZVERP
         46k9PpoKjoVW8yMXsUlD55w9XpOJHgUQdUJR7+8nmVOWgbcNCNmpMqD8PYuWtTh5RvqM
         4bLaVicEnUpGKfvFX3UU2ga9ndfevFvdBcnFZdgTM5s9XX7ze0EcF3Fuzxp/0Vd7WvGc
         XUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786211104; x=1786815904;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qs0EjSRFr2xxXqINM1RVama5B1i5NV6uYC89OBLk5zE=;
        b=Pv+7FklS0DczYS+VCwEseOmzUc62p7ZoSVbIej4zrHPDw50r/HiJxCCXnkZnFQ+/yn
         yzbjMuioIcwE1MWg05RtOeAemRddHBpfezlEvTAKtxOrRykJJMgBSfQkkv/NIPEqKWwx
         +fX/w70U5qPnoD1eCMQiVCLurAN1uv/XjLtm1TFzOE4hcZ6XilaSS695BYQZHmVqpNsH
         LYGs6f7rtZ9PZqQmlksUlN70zwe4AoesoS2TlggWte1Vo6hDACRvY7XEwfoVSsQ0yXZ+
         y1gLOwObWbCoBKYg+wqh9Yc7YTzg85Q749dJr2WesTXi4X0JQbfaBmiawSt6w+aG0FJ0
         9sJw==
X-Gm-Message-State: AOJu0YyvkKlFzzo6wc63pgF5T8th6qOQHfV6f6+5NhAdmtEZ/GFoWtaM
	4IT68shY0QHp/VyswLWC6GVxmSgm0WVYfTVvYmvlBR5rP7hRsv3l064vnxr6tQ==
X-Gm-Gg: AR+sD13Hps+O0z5z3JFbpacv/669e6JSOLUfkV4IV78MlVq608b/NpjFqMd1sJLJDWO
	EoJuUoKaI/X5KZox/jm+IfyF0XoBND4gBau2tY5fec6ZwjCFAt6ZeeKHRRsdW0DRMktpBc5NOOh
	ljq7RXQksZm3lOTu/5IPQrLkxOroY9v195NN03JPLznDHwbWPGT2DMW5+dKGJEZ3lzWLaRnoff2
	S/YKqHjntu7wIP2HkCkY9RFA9B3GXNkrmRGmqpgPskuwMPdmy8a9wSS6rU4yyKZZHdGQgsHbSet
	cMqHDJ58lpHl2e1JUR0+z4NOZA+WFqAg6Uga5BMuNm4wBb9Ms0LyNZZ2OGQfvGN6+80Wk+FBqXd
	YDJj+7a/SxlsUHMQtnfghXUh6VssaR+6u4Q3jkLRP9TIINQXHf99SzCKRDCqe6VGPvpJldjtLBg
	1Xq/HeFT8XmmMMbObU+7TGBlHBn9hwHM/Z/I9t28/tbT7U/eAS06fmDcaTMjyHMgL9ftw=
X-Received: by 2002:a17:90b:3b89:b0:38e:59c2:cbc5 with SMTP id 98e67ed59e1d1-3909d9030a6mr16653899a91.18.1786211104376;
        Sat, 08 Aug 2026 10:45:04 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.133.115])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085f2cb6bsm8981911a91.9.2026.08.08.10.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 10:45:03 -0700 (PDT)
Message-ID: <6a776b1f.b90955fd.80845.de3c@mx.google.com>
Date: Sat, 08 Aug 2026 10:45:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0218031539180136580=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pashpakovskii@salutedevices.com
Subject: RE: [v2] Bluetooth: mgmt: fix 'hdev->discovery.uuids' NULL dereference
In-Reply-To: <20260808163128.288740-1-pashpakovskii@salutedevices.com>
References: <20260808163128.288740-1-pashpakovskii@salutedevices.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0218031539180136580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1142733

---Test result---

Test Summary:
CheckPatch                    PASS      2.04 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.21 seconds
BuildKernel                   PASS      27.64 seconds
CheckAllWarning               PASS      30.52 seconds
CheckSparse                   PASS      28.61 seconds
BuildKernel32                 PASS      26.36 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      504.75 seconds
TestRunner_l2cap-tester       PASS      62.71 seconds
TestRunner_iso-tester         PASS      99.05 seconds
TestRunner_bnep-tester        PASS      19.37 seconds
TestRunner_mgmt-tester        FAIL      230.60 seconds
TestRunner_rfcomm-tester      PASS      26.37 seconds
TestRunner_sco-tester         PASS      32.61 seconds
TestRunner_ioctl-tester       PASS      27.46 seconds
TestRunner_mesh-tester        FAIL      27.18 seconds
TestRunner_smp-tester         PASS      24.76 seconds
TestRunner_userchan-tester    PASS      21.08 seconds
TestRunner_6lowpan-tester     PASS      23.60 seconds
IncrementalBuild              PASS      25.98 seconds

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
Read Exp Feature - Success                           Failed       0.272 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.444 seconds
Mesh - Send cancel - 2                               Timed out    1.984 seconds


https://github.com/bluez/bluetooth-next/pull/560

---
Regards,
Linux Bluetooth


--===============0218031539180136580==--
