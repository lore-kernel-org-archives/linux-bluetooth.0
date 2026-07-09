Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FC83A7F4F
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 05:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575269; cv=none; b=R9o5rLvDH/kz6B6gkgwKKk/Uj4SaU6RY57hZF+NQTivy7UIKRhP5I9bA7IzfRpMNOwH5Q6GaIrJNCCsPyfKs5ApvMZbiKOJ8/5mqbgT8kPIEzwEPC3vPotUv4FPdtpKheREeuiSCKyBMN38a4QvRyZox+H2r6QrBONULXKOtkHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575269; c=relaxed/simple;
	bh=zMAvy43H77BZSbx2jm/2EGs02juX1oeQpUl21ekSnOo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kOqnizl0CHmcgK0QF3acWLg4DP0+EP4qSxLQGyj+xLYKmcdpHlD8EW7vGyVpU2HoHWkskMMr+Zr5YeRvjQJfcauc/o/pL2IEMrXLk1ONa2BFL3AXwjjkcLPZVsGcZnRxPhkBT8zqRMl7AvB832zQzgxjwzIawzUL3Ok3TgN0QMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9QekzH3; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9QekzH3"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so1426355a91.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jul 2026 22:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783575267; x=1784180067; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aL6cc71q82heaCJwmZt3ctPYwv5aODxT1gapvWXDZPY=;
        b=g9QekzH313+IwI18hN2fet3tIR8ulY4h03EBe+shM54CkH8J5ZN9TLNwPlACIUUzy+
         7S76sGIuXICHoUFlYJvmxiy0rRUfvHHU7QZZJLzr4ikQL2KUQ3TICK+Mmg/1bVcO5LhY
         eFiejeshDOFE97xqGbOeVxrJM6cfepppWssqae6G3Xsx75v83WVX+MFDfXhMtlcRuaie
         VMGOwyqlvO4zAuqVE6dsvRGMl3kHOPK76kVPyCG+8UbuPF4jxrUqOrQlu0+fnPVGsT3/
         HL936NuPaYfvUoe4UWxyKSnyY6WezAOEIF2wSYBR57EJ5xLq9yrchfQFsscuDeK1Lzpr
         o3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783575267; x=1784180067;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aL6cc71q82heaCJwmZt3ctPYwv5aODxT1gapvWXDZPY=;
        b=do7qlrV7ULPYNVaYbhOVkXNm0eA794XrZ2tu35E8KkkjrjoL434poWIAM9GfhEeF3q
         MSSH5wfthEolcAwEa+2yW4B4qU1eHAW6Iq3tezw+55XlLzNe/6+G0ip0egBJAfHG3rB+
         arWy1YJ03KpHk5qrgMvKhPl3b8YOy+8oWyPcVsMEzh1ZIy48rTkLB3kUpHooHe3VKrKF
         HjfqqSIPfgFVsSM+mU2osZLx6CSiUZeWYKez62DADBziYywJO6puZ00UGf8PYPiy0uZI
         6HYoFoxoz+g6KlkpcexFhMQckxfgWZaAGiFiObllGQzmWLjHL38X3MIvjoKDy9zW/1s4
         ZHHQ==
X-Gm-Message-State: AOJu0YxA3lqLxAkkbg1xu/rcnWaa29QqG7LZOh+6sOmMKGWzojrx6qPh
	q5GpetLRD7hbjjAtdsoVrFtwvzA3r4x5MgLSo45AlkYluLfpsXDmeEZKvlK/RA==
X-Gm-Gg: AfdE7cmxKx7m9MlidxGd3TP3bRJIHSC7FrACf2I/AzWSpqpn9vYPo4gdvXz32kGcmYb
	ID6GFFwIUWYizbGw3TZfmvBbe6lD+obnkdL9EwkV+uGVlOvdbS98XOAzv6q0woaahwpcZZDE2LQ
	vgyE7tHlr6UacyNlVpHFSR9PVcSchvWSZGBkJzEPBm80nl0HLv3bb5Zgy/z3XUhHyQ//Ll3fp0C
	dhgkbA2L9pRBkeJqOW8DMPirw7MhYNDiaOOgNCxZkFgXTZdX3BoywJ6sDwayDlXFv103X9lEQm+
	x/LZ8jwk7vgbrirIFWJlKvyTyvGPKICT9UshrGlH4LFa2RqF8s0dXDGVjx4k9pZptinhF047mCJ
	GmXitD5GRkXpli6CkC6KY89czg9x+lvszTVnKNItJH8VwloreTeEuWardp7f02xdzfoifcnxvAP
	y0Z/4HiiMfM22fDQT0oAg=
X-Received: by 2002:a17:90b:5845:b0:36d:ae6a:22fe with SMTP id 98e67ed59e1d1-389415eed39mr5542135a91.16.1783575267384;
        Wed, 08 Jul 2026 22:34:27 -0700 (PDT)
Received: from [172.17.0.2] ([20.163.39.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174accae5sm40530263eec.29.2026.07.08.22.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 22:34:26 -0700 (PDT)
Message-ID: <6a4f32e2.da8bafd3.14cd50.8b15@mx.google.com>
Date: Wed, 08 Jul 2026 22:34:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4543865420299954962=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, winter91@foxmail.com
Subject: RE: Bluetooth: virtio_bt: fix memory leak in virtbt_probe
In-Reply-To: <tencent_EC14979976A7BBA1E2B79B3F5116F7C30C07@qq.com>
References: <tencent_EC14979976A7BBA1E2B79B3F5116F7C30C07@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4543865420299954962==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1124217

---Test result---

Test Summary:
CheckPatch                    PASS      0.43 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.19 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      15.57 seconds
CheckAllWarning               PASS      17.02 seconds
CheckSparse                   PASS      16.10 seconds
BuildKernel32                 PASS      14.94 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      277.51 seconds
IncrementalBuild              PASS      15.00 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/412

---
Regards,
Linux Bluetooth


--===============4543865420299954962==--
