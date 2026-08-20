Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3917379C4F
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787238913; cv=none; b=IMEl7kAG8tFnneNRejyX0JedPcwRW0nDUfaVvNGdX2MaQTUkh324A1WGmOx3G9Pi2OwLi5FOrWAIvnzXtF0oVRZ+fsZR6dB/rQTmGevdG50ho37bxMpTbjqV+nuk+O4koY3PfTHe7IDCg2jPUIrPQh0ESOR5oE/SZ3HL85yCoOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787238913; c=relaxed/simple;
	bh=D5jlOgHnizjW8CS9+V8tO317u/wHbeZXctdyVGkagd4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oyhCqDjTqg8M5IXyXZivFmoOrcmg5QofrOo6Rukv1HW9bceEeAIcitOYE38Q8zvbbZiU7ZsXM+pZrvHRw6BUlI/Nxot5Bl3txPQL6GhvBkLmMjOi8QrpQxuBrkonTImxFYoQJrmE9g880FoPIowaq99VIWV9Dmuk4KFmzsrotEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeQj1U7G; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeQj1U7G"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cace91f112so23470165ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 08:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787238911; x=1787843711; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hMYegZYOv6YO2WEaA1KC4H+hZaeWGLCfkyJxgfztx08=;
        b=HeQj1U7G2ZDgvC5unqaXXo/TU6WcfYDkHI6R08nCVSKq9Cnq0ntqPlDPRnnpuKDfmo
         2KsSoVus1IBTNKaSVivziL0YNG1NiOQ0loLKSfo8UoIALijBYYBQZh1ACZWnjTdfgZ/B
         d6PZ5YHWvZuTwwt5ba17++FjPdabBhww7EtXZHi2HF4MThWzd7JSjBJ5WBDcdgd8oQ4z
         C1qT/NHUur2jnCaY0LZpAl06SwmNwp5UViPNSqsjiUovlvGpgCbXzMkoTmLkP1FAJWYk
         P3DccDoMNnbAyL/DMrTWjrw+X6hJx11u6qlaP6372L1moQBhRSvuRrlIidSDGZgRnBlC
         bhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787238911; x=1787843711;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hMYegZYOv6YO2WEaA1KC4H+hZaeWGLCfkyJxgfztx08=;
        b=Y8cZOInndtdEFe7laMbe72UjekChMwro/amifQWN97f0z+qpCRmOw/Xj9Um8SqrYKi
         Kb5G/bhTbSpb2UeiRMGrM2jJftZOGq++DOMGhUDmU8oNGQy8UB/3dYJpFBh/Zf7w7Ixr
         XptouuJpJsGDUojF0GWPO0uAMhq2V13/IOt7bhWou8JCRzOgcB11Sig2o3eQbJAE2YsO
         ayF6bB1NvY3qgbC9X3r/w8FWy5K0Lyzw1iDyAm0tPsMPG0C2ZYx+9GCNGQyL0bsAn2wW
         R5skMMedCEh5Lv+XGfXKrUV1/aajWVooVdkwasjkyAr56aFGsQ3lsUDYLrxpdl9uhtFq
         LvCg==
X-Gm-Message-State: AFuF++kKSDIKiF/pa4y18oDrRisxLyppDncnoKTt2yKlBiI/N53/vn/Q
	HzZPeOZCOkbv/DX385WmqeSDqy0KTGtSe3wayvJCYPPC8ouy3hcUtOLe+SR7WEnX
X-Gm-Gg: AR+sD11iL1X1oYSRUl4larojBG7B9W3IieSH9Q1aKBjatasF9JTqbuCRvaozw+f3yql
	ZRa6epbBC3pu7j/5DeNBRR1XDOHPRGS4WuFtoBipYL0JRMupFjns5ensmm5DAog1FxWQwgWIifI
	+jl7AEOvUSgUA4P9URoe4tdM++pYidUU7M/+d+rCQXp+m8HLoyjMJFnz04fMluSchiFIW1vdnbR
	xJbWp6OJAorVUmauwCJev364abx1PoYTTZpjazGfNwHjXmyE1kxp8Re/gqmssgSCNRfQAkIYlm8
	QtNMiPnnCx5MYCKlKURWDQAueVqYd5Wm2wGuNi1I6pS25WF1PMRt8ahpZmL8AvXtFHRgm9Fqu9u
	lJQJznATnkjlC0tb/MMzFJPfVtixp+dQX2e9QKvk/J8plrAPNACilakHT15VUrvtfKF+b16GBdB
	1QY40/hISqzluymonEORxppeQOBpGHta3jIw/MwGa2qK+qzBQY2cpvRlHY4v65Zl7ZHw==
X-Received: by 2002:a17:902:f651:b0:2d5:3f5f:e645 with SMTP id d9443c01a7336-2d601862caemr273799015ad.12.1787238911027;
        Thu, 20 Aug 2026 08:15:11 -0700 (PDT)
Received: from [172.17.0.2] ([20.83.228.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62d555b2esm8840175ad.11.2026.08.20.08.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 08:15:10 -0700 (PDT)
Message-ID: <6a8719fe.91b0c015.36883d.4945@mx.google.com>
Date: Thu, 20 Aug 2026 08:15:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8694222673339276148=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, lidaoxun25@mails.ucas.ac.cn
Subject: RE: [RFC,bluetooth-next] Bluetooth: hci_event: Use General Bonding for ATS2851
In-Reply-To: <20260820140547.1148128-1-lidaoxun25@mails.ucas.ac.cn>
References: <20260820140547.1148128-1-lidaoxun25@mails.ucas.ac.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8694222673339276148==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1149156

---Test result---

Test Summary:
CheckPatch                    PASS      0.97 seconds
VerifyFixes                   PASS      0.06 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.19 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      27.00 seconds
CheckAllWarning               PASS      30.33 seconds
CheckSparse                   PASS      28.45 seconds
BuildKernel32                 PASS      26.13 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      497.49 seconds
TestRunner_l2cap-tester       PASS      71.44 seconds
TestRunner_iso-tester         PASS      76.86 seconds
TestRunner_bnep-tester        PASS      19.02 seconds
TestRunner_mgmt-tester        FAIL      218.98 seconds
TestRunner_rfcomm-tester      PASS      25.82 seconds
TestRunner_sco-tester         PASS      31.22 seconds
TestRunner_ioctl-tester       PASS      26.29 seconds
TestRunner_mesh-tester        FAIL      25.85 seconds
TestRunner_smp-tester         PASS      23.70 seconds
TestRunner_userchan-tester    PASS      20.16 seconds
TestRunner_6lowpan-tester     PASS      23.52 seconds
IncrementalBuild              PASS      25.87 seconds

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
Read Exp Feature - Success                           Failed       0.240 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.284 seconds
Mesh - Send cancel - 2                               Timed out    1.987 seconds


https://github.com/bluez/bluetooth-next/pull/624

---
Regards,
Linux Bluetooth


--===============8694222673339276148==--
