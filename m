Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA221340416
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 18:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787337489; cv=none; b=DKOqultR/mxj+OHtBeQw8TW7lgRUbhDVs2jZ0B3pa34G153GXLxtZYmbirBRQeY6uEjb6HytrYvD/tGTZ12zT+I2UAHYR+ernR7qjW8AAVibhAR46bd98/ZRaFnlk56GmGHpme1YezY8wr3Ffgdd+UP24V9cez5d7IuSYTeKQjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787337489; c=relaxed/simple;
	bh=fZ3Kul4SRJUlqg0Vnx8qlYeib4MeyfpJE8kkCgliA8k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uPHf+ZQy5nOd/YWKurZEoZXtU1EQ78Qmdx4nWRKWPcbPPK8cYvTfqT8PHFKSLSggpfs1PfqoGtnrIfkcM04zLeNjJkDEb4LFVV35pIB6aT6ZOWbdbz6y2Fqb4qvWCGfbbAsmIkxFBJ1mvGrjK9mcskuzQWAOU8SkSoSelJ9wkSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4bCmSHQ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4bCmSHQ"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2caced6038eso14018865ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 11:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787337486; x=1787942286; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=C3Y1oP0iF2Y4m8r8bYV0SYeAXGixnPQFHalRZkTIoGA=;
        b=M4bCmSHQlwaN3nh879cMhqevv4qtI478sEdrpU6UWHrr0ROEa7MHMaxvtnA85adWSE
         umVK8mBUz5mhCbEM/Pi9l5gScgZJBHwGvblZlDYFIrLvWf+TgaT3sDgExBQyLzNtAWOq
         pigXj7hPxhvslUnkOhSzK1aMAmymjBLc9M/3WD42DS+Bg7SPFy9/yQc4iksYDKZf11mN
         3oSqUoL5FQ5lVoev8isFGWCntLUdXGiXHz5FFaB1D5nJKzwqU6sqtlBrl/HlqHq8oUSQ
         6TyAEJ1PTVL2takcR45jI+LxcCJ5QVlypDx1p8A+BTsnpM6CPmeDgZj8LLDoQvpamr66
         Ov3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787337486; x=1787942286;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C3Y1oP0iF2Y4m8r8bYV0SYeAXGixnPQFHalRZkTIoGA=;
        b=SasQyrUwYCHI/0PnDVrxmf/Xxix3yj9Gr4zorseIYNXDAwR0mCKqNseFkwGr/DPvZc
         tnF/2NAZJ1o5TS9Y5yuxkjcE0DjfyY67ju1AtlSExLOzCH0gHq0W8OumWa+TO9+8ViWN
         /6BsRtPaw7x0+vsYByvHZtV/xUHxQUcykQu9aQwXdhywxFtpgLkNrNSfje+AyMo2kD6m
         v+EAgerThNw7HmRgUjbdoMGyTAM5t3vhMq6vSjVjCz74Kwir/NPWZMEXwFsu0M4ffCJS
         HlZk9jneAlrbhc4TgyIJB6V3vrVfR6rNAqKc0vDGKeAPOq06w+ycp+GOvzJxTTHRAfL8
         X/QQ==
X-Gm-Message-State: AFuF++lqGRYL1V4LyeLaAVfSoBqPp6v18YV75LVwURsNzPNnaQ5tx0Bz
	TphOGmbMGlDJUtgFW+5TrGh+WSf5TNJkG+3SK0Gvl09v7nm8ab0daQcOi9mLlWZA
X-Gm-Gg: AR+sD13MVDKNCk4XOFmN7V3yNE2sKBYyf5j/DGy4XLWp9Y2oHzxV4yWO/Jdhp3Y577J
	darWNCtwaCBHktQg+GNUTL3yDZAV7VNWQiZCfbVMXrMnspVWSD/g/AiXUSecABG8StUmI4Mg1j+
	w5xENm2HFF/dNPcGB1rTQDLILqVBEUBxeRI50ujGJVqfYLey7hfldSmj1suyAccqX96R51nqDo2
	yNVWRIgnxNjnBdIkL7C7FymcWIVAyuNE886hoCup3GqHvL+7bLgO1tSNOvG/t+nJq2T58aN894B
	PE3LLYmGshkcjmzmGT+6AWpEnPlDvuXTwfxxKXqwHOhmCdTZzCSshv7wku6DN2jMu1heZpiqBYW
	LWWm6ZtZu9jdFDsGjQ7iF3wb0vddzQBP0c5Xzjdk0iwH6krTaPc2u11GtdnUappjCgpYuUGFHp+
	zai5MTTwlbbWlz1Tl2k6MLnvZqzX4+l9fpuqJx1grOVO0MsVNKHRYWAGcAq9dL/CMuoUI=
X-Received: by 2002:a17:902:f688:b0:2cf:6e5d:23e9 with SMTP id d9443c01a7336-2d61a1aabd6mr179056315ad.14.1787337486462;
        Fri, 21 Aug 2026 11:38:06 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.75.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef77be3sm28253133eec.10.2026.08.21.11.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 11:38:05 -0700 (PDT)
Message-ID: <6a889b0d.4540bc7d.3bf7e7.f51d@mx.google.com>
Date: Fri, 21 Aug 2026 11:38:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2835209370095795871=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nicoyip.dev@gmail.com
Subject: RE: Bluetooth: L2CAP: Fix reject-list lookup UAF
In-Reply-To: <20260821174022.3033729-1-nicoyip.dev@gmail.com>
References: <20260821174022.3033729-1-nicoyip.dev@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2835209370095795871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1149958

---Test result---

Test Summary:
CheckPatch                    PASS      0.84 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      28.21 seconds
CheckAllWarning               PASS      28.59 seconds
CheckSparse                   PASS      27.68 seconds
BuildKernel32                 PASS      25.19 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      465.05 seconds
TestRunner_l2cap-tester       PASS      63.78 seconds
TestRunner_iso-tester         PASS      97.09 seconds
TestRunner_bnep-tester        PASS      19.26 seconds
TestRunner_mgmt-tester        FAIL      217.23 seconds
TestRunner_rfcomm-tester      PASS      25.70 seconds
TestRunner_sco-tester         PASS      30.93 seconds
TestRunner_ioctl-tester       PASS      26.87 seconds
TestRunner_mesh-tester        FAIL      26.18 seconds
TestRunner_smp-tester         PASS      23.07 seconds
TestRunner_userchan-tester    PASS      20.08 seconds
TestRunner_6lowpan-tester     PASS      23.00 seconds
IncrementalBuild              PASS      24.27 seconds

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
Read Exp Feature - Success                           Failed       0.244 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.656 seconds
Mesh - Send cancel - 2                               Timed out    1.988 seconds


https://github.com/bluez/bluetooth-next/pull/630

---
Regards,
Linux Bluetooth


--===============2835209370095795871==--
