Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0863314BF
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 18:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781720271; cv=none; b=AaM86YpFV7Ym2OYVXTBUAAup14eSNqN9yONZh2zFoJknBkvU0C8GRoE5zz1rVI3VVI6a3i8xQalwMa24ZhU2S7/CYDngZadYGhuL5x+YnfmCcs+xvRlhH59XZbP/9aR5StaGzp4RFwlcXXwyullDQajNjvSKIxiwtF/03MPNvEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781720271; c=relaxed/simple;
	bh=h1tjnrpXglG5TSzqofzlEueANOzWH90KvnJCT21m/zk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iDI7W6a+7siHX5u3gJtBltr4W7Gth192NcPRC3CF1eAXke3GX+gKXNl3OPauNJMn9p6doOuKQrKvOMERy7CopMKMbUEVYWi8d1LffE6KNUxnkKPcZN2wZy990bBiviuPXU2LIolRDRkBZ18SLLPOJKJp9cdDXU/xshWo64HgE44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j82jqKO+; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j82jqKO+"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1397ad67f5eso179477c88.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 11:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781720268; x=1782325068; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ccjrIg5MCLGWZfbwCfAhweuD4y2fw8nXYI37Byir2To=;
        b=j82jqKO+zZ5kT6f6OXZkbrE6omFIEZlgqusbMhd6KbwJyVrZ16wNiJeuifdpWtF1/7
         glVHBvzrrKdi3v9rSmi8wWuMJBZ0OSL+P+p6Z7YvBRmrrYssC9Dsb7Uy117B0rvFsK8z
         amru5WbTyCb5+4nC9Pkzf2ZdKj4NIlIGxZMrIu4TZmHyx5W3/y81Zn7IIYh2ElZi25GR
         d/C8R6d9zHDlVVAONy7h8OCxN+HbcgEXDk9HeQtS5MU+AXUNRQLL7QQ3RSUUDeRx2f0y
         0rmHRh+QKSA2YWeCpLpsRHZYAharbR7EHV+CoB9sE1Em6MC3PLEe4gh1VJvhsXZu0FMR
         3VvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781720268; x=1782325068;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccjrIg5MCLGWZfbwCfAhweuD4y2fw8nXYI37Byir2To=;
        b=VrC6uRhH/jysxdRbQwA5iBnVUMwgHcYfUn5GAW7p32EIkWIms/OERmITAxobsSNHHe
         wvQjTi+uUneHWrOctntixrgmvPZ1E+4LFES83Bb72B103iGjaUbmYCi4FjEAwAuXAJzR
         nljJr1+gI1LaKPf6f7WaYPhNLmS/rThiyfIZyg1CWHe4e/nUpGRrSKxuXQgraEfmP2al
         hbuNFzer45ZxfKbg7f07xYwb+bDfnHFvpsclgG6wBPP4SEfbwmhdIeNbuc3dSQqHy4z2
         Zw0o1oa7Z0H/3m2JQZ9BOfdhaJnlrVHLQYWTK3IgJVKrCcOBy99wtlrkTXpN3eIrUoNv
         6DhQ==
X-Gm-Message-State: AOJu0YzFWNPMCk6Dbgwj38OZ+R7poNKSD3xQ14hWlQkxWkgviHUsZ/JO
	oZr58TnabFnV7mphXaNE6vNovc6rJUJpGGx00lgEDsHpqHmfGYZjROi6SqMe7A==
X-Gm-Gg: Acq92OHWVKxcM0i777MIWTIT/RiCGQdIz4EYwTeYgjM6HD13IVwSS/FUsnVo9A2iii1
	T9XCUkq1ehw1FZKftkT9CtGyhgeh2+AdGK/+t7WvRhw2pLnC/2SE/KjcuktHKaGseA0RXJn+xU2
	7YPRbIsO5/xcbhZ6xV18+arIl0uiAeJ7uzG3mrkyDydCkF1kekJdAhLPJ2lWe+PwRoW0ycUu0g1
	E+yUBOaNxTtUSsakpFxEtM2+f9OrQioW96Y/Ajnwh3ONfM88G6LpWdaymYrzD1lCBS1p/9d2rwW
	qlY34qB+liAZtjXqNSXY/ynD5h4jeM/HuN/Dw82xkJ2ZSdpL49PkzcLikV+SYRRkGtc5/8Wdqi1
	Gia8uiUjw9l4IgNYULhVZ8XIH2QKu5IbxudIRYssJEs22s20gN5/BGU5egh1zfGhDZzEavO7b6G
	joefrQ6W8CWImaYnB5Ac9vlg==
X-Received: by 2002:a05:7022:2206:b0:139:7a48:fcb5 with SMTP id a92af1059eb24-1398f6fb2ebmr2561469c88.34.1781720267573;
        Wed, 17 Jun 2026 11:17:47 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.220.217])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b8f9889sm16307969c88.3.2026.06.17.11.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 11:17:47 -0700 (PDT)
Message-ID: <6a32e4cb.f8b79514.3938f4.8209@mx.google.com>
Date: Wed, 17 Jun 2026 11:17:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3101640927152736658=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dmantipov@yandex.ru
Subject: RE: Bluetooth: simplify force_no_mitm_write() with kstrtobool_from_user()
In-Reply-To: <20260617153019.981515-1-dmantipov@yandex.ru>
References: <20260617153019.981515-1-dmantipov@yandex.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3101640927152736658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1113029

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      26.57 seconds
CheckAllWarning               PASS      29.13 seconds
CheckSparse                   PASS      27.78 seconds
BuildKernel32                 PASS      25.66 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      572.07 seconds
TestRunner_l2cap-tester       FAIL      57.71 seconds
TestRunner_iso-tester         PASS      80.47 seconds
TestRunner_bnep-tester        PASS      18.93 seconds
TestRunner_mgmt-tester        FAIL      207.33 seconds
TestRunner_rfcomm-tester      PASS      25.14 seconds
TestRunner_sco-tester         PASS      32.73 seconds
TestRunner_ioctl-tester       PASS      26.21 seconds
TestRunner_mesh-tester        FAIL      25.95 seconds
TestRunner_smp-tester         PASS      23.16 seconds
TestRunner_userchan-tester    PASS      19.99 seconds
TestRunner_6lowpan-tester     PASS      22.39 seconds
IncrementalBuild              PASS      24.67 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 3M                     Failed       0.250 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.238 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.487 seconds
Mesh - Send cancel - 2                               Timed out    1.989 seconds


https://github.com/bluez/bluetooth-next/pull/326

---
Regards,
Linux Bluetooth


--===============3101640927152736658==--
