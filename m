Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33A13D891D
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427828; cv=none; b=OERk6i89Ku/5eeDmqjvZep7j1vkxfpTxKB8Vd4JV8wG6TGmKQf+HcNzoFexLpcMB3FtXHJ0ERPXeqI1HS2Zfb9tUkCFqCx62raaDMO6Rcvlnf+daCjSai84SG323RmI1PqMvOiQE4Kc/GK/PSEYLQAuNrNfabjn2hlux4QA0Zmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427828; c=relaxed/simple;
	bh=qa8MyWuOwiuUYF4R+ZTvYh7o3lxwqv8og5eZS7nri10=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kKmdlHS48f469Iih+Y60oharb5/I2L2PcnbXZISpdg5IhauMdiIIoyLPnSOawbI9gmMhMIZWa0SaVEvExUdl1iVadcKgK04eA7qmK2tEdNB5V3N/8harWUI+lqIKsHReZCPOTQ+rv8nLrH2AYcCXszeBi7BG/bAYX6wDJuzzjoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZaIOtjd8; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaIOtjd8"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8eeadbc5e21so29315586d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2026 05:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783427825; x=1784032625; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NSdwmFDGNddva299YtKbNZeegt0T0aLnucGkgsmcitU=;
        b=ZaIOtjd8E+jrQGNYdAcIlWa+HV/BqQnRCL/CMvQTMf+wUwN7FcBCxtHDyFu9RjUsT/
         LeC8WYQ1rRc+qXRKulu+U1tHziqYdROExNwvMGX+X50oiNc9YOE6+1H4yqpOnPnonrf0
         3PEHpfVjW19g7VMkXCTCEA7YwREQlollmYsBNkdVB7gguEQYGUrwhmtaNcYeFBsNYPkp
         OdwAwO854OW21tK4Qh7KxyMsN8UewYq9agJP4qtVs3kZbtLF543s9CFfOh2JQyHekKYh
         wLnUspw0H5A0MVEbH+VY4XP3iJWnttTRDD7rD6FQDFn0nkC4JsG9XWu6Agn+/xOpcxy7
         7+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783427825; x=1784032625;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NSdwmFDGNddva299YtKbNZeegt0T0aLnucGkgsmcitU=;
        b=jv3FfVUE2dPqzmuuWsxLdN5bKPn2MnyfixUPWROqXyY5LagtZTWOy0LCWMchi60kn9
         9OGkma4+ZqLBjQM27ev6NAJ2nkqv/F6MOjNBYYezVVG/rVMfI2+IYKBKnK2cehsMIA0I
         5zUexQ9kb7LlOld30Ri+kK4X0lyKqPZuC/xthwtOZ0mdMWrG7kpcla1OLUCQMzuXZegP
         uEkrIJ9XPbv6MwimIcexFktKF2sfsFUdWHqXnTckuIRIDYrfZ2kONrHNozt1IB9rzASy
         gp/I4rqKRlJRkaCpqDS/JrIPq87j+R3Kh4ZvN6La7ZyqjcK6+KanApMQq3JvH6aoAayE
         hjYA==
X-Gm-Message-State: AOJu0YzrVN3N2iJkw4g82HK9eiDKD4QMIFgx/tGOdzptwElxZLHwp3X1
	/mEdh9JowrPgp/KxanTFBCEf72iH7NYxo3siz/SIiKXqaVTQMo6j1/zGRa5gyg==
X-Gm-Gg: AfdE7cmCEIV983gD2eTIYt51+ryWpyEsK+5d76tU4qOyh4EjMSrKpoyJWRgQ5zv2tUr
	06BYal1YrD3nQZLegvKVuXB2D0rTd/q0U5ZEL31FqAeYsaYIwOhZP3edGyW/G1eWiCwZy3ebBbx
	XpQj8Nv/VDG0ZT0IYzDiS2wY1RuW7vRELgK4dtaW5NVVWPJ2u6EcjTHpxW3bp8kc5NwcuR/gnsB
	TB6j40668M9vo1BNoqJtMgcSKB35WvSs4i36j3ZkbxJpTirUw2x5CyGrTswbRpSUThorMWoBMXm
	65ITYnJsNCA4X3iYYeEAlW1E41GKzVtFs4yphZOsox/pNYsj+WpgRDQd6LFj8a1DQagkL5jX4o9
	A3Ti2mjOOCVc5mnkhVNvJHSk6JliopP7HlUYhwspU2H1bH9+DxfItbPtYLhcaqxdVdJMosBkFM8
	Nr2owDlfrbV3D+m8/qymbV
X-Received: by 2002:a05:6214:e49:b0:8ef:ddf7:3135 with SMTP id 6a1803df08f44-8fcb50df029mr58174016d6.38.1783427825473;
        Tue, 07 Jul 2026 05:37:05 -0700 (PDT)
Received: from [172.17.0.2] ([52.186.174.153])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f471de93a1sm156426566d6.34.2026.07.07.05.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 05:37:05 -0700 (PDT)
Message-ID: <6a4cf2f1.d0999061.39a55a.8f0a@mx.google.com>
Date: Tue, 07 Jul 2026 05:37:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9212537470192736398=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, xiuzhuo.shang@oss.qualcomm.com
Subject: RE: [v1] Bluetooth: MGMT: Fix discovery state race against cmd_sync worker
In-Reply-To: <20260707093426.372897-1-xiuzhuo.shang@oss.qualcomm.com>
References: <20260707093426.372897-1-xiuzhuo.shang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9212537470192736398==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1122959

---Test result---

Test Summary:
CheckPatch                    PASS      1.25 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      27.05 seconds
CheckAllWarning               PASS      29.58 seconds
CheckSparse                   PASS      28.81 seconds
BuildKernel32                 PASS      26.80 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      499.12 seconds
TestRunner_mgmt-tester        FAIL      219.48 seconds
TestRunner_mesh-tester        FAIL      24.52 seconds
IncrementalBuild              PASS      29.02 seconds

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
Read Exp Feature - Success                           Failed       0.247 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.436 seconds
Mesh - Send cancel - 2                               Failed       0.316 seconds


https://github.com/bluez/bluetooth-next/pull/407

---
Regards,
Linux Bluetooth


--===============9212537470192736398==--
