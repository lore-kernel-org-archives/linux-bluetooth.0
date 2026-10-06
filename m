Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03623E40F0
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 08:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791275477; cv=none; b=XXfcbc4yz4rd6n6jGzJ8uLQzXUC5CO3wLN7fVYnoHOGtnIv+yOoIeUhaXEAFCbXm41lz4LBqE8QCUmEnvcsLSZqBaxaG5C1RJhXHcROybuB0DQWxtxWyv0W27Ghk+Gcx60GCTatVo+r52s7Kj7wVvVy+sFInVKXCpqJ+ygPLd4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791275477; c=relaxed/simple;
	bh=XeqzEpeucedmqh1S5QPhFpPZBMNiv/63YEwoFjBEAaY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jjUf5fJP8LvP3yVH1p7eh2iZY1t/SpBGGA+6NIhyfSPoJrgAMh+Ytj6lMYjPbYtrtRYKm7LBR885y4XMbiJeaDi/aciNT6g5xffcLlgjq25rtQlEwgalHyo2LxpMFk6BrI71VVX0SKWufZn7pAGyvL5+vNd1U47hDZDr9ccdV1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMHxvqWj; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMHxvqWj"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93e706a6ba9so34418885a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2026 01:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791275471; x=1791880271; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fZqzC+ulRsT6AW9o1KFt8hF/I1ZDnGemx5wyIi8PyHk=;
        b=iMHxvqWja/gadJNc6H2vhrP2bmvOoynA7hyIQP7T0vsxbj71QGzoJFAC5fKoGhBbku
         b/x5F+Xd7NmleeYfUIRckj9wLQUzYMScLLi9mTD90tYRx05nWoxBXajBwy02qbV+33gE
         9BxoVn8y9Hy6uzcMlmXCbVfNLfeYGaz6LbUcc46CvBVXESeHv1wr4v36qV6V16Ls1dny
         r0zN53HOG4/M8s4UMjymL657LwTsvouJtr8135FbtOdED+GLCLjxVmoujIR2ieK86+4E
         VV1DDM8q5wfoYC2ECDZIKVieFcftIwp0ROeDc0cCh8nyNiuMEVAU75Rp1lI7w7j8dnBJ
         DrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791275471; x=1791880271;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fZqzC+ulRsT6AW9o1KFt8hF/I1ZDnGemx5wyIi8PyHk=;
        b=hOtQ98A87kmDFxjkrASyOJ5/n4MP654V45Unntuhc0Hqci3/vcUnag1oXeJ7p6XPK2
         MfaHry82qtWKEJTt2ESl0YVO11wrfU6Tw0K4IyzWudg8jV75dxrRj5glAwvfG8Ke0Sv1
         5jtbWEVwBaV47z4jVZsl2op5YVUEpbd8KatJcas9lWbpHUh3Ce2xmTYB0AegcDPOHHNp
         YkJHUFPbwpaZXBk3IHeKC1lYvHwoOk+qTK1dSYwJ7EtseI3K5ttaRJqOYvNqfBEinD98
         FHqG4i2wmprDJDpEtjpqcvkOSVGBjHvA/gAyGhLHrh6hNDssQevA/Pyt/t/I7Emq5WpZ
         N4SQ==
X-Gm-Message-State: AFuF++m+szZ1OvZuCM1LVk9eDzeQdlD+JZWPngo02dtBddfybLlAh1+D
	LEbd083E3NG/2eCeFN+PAqggENWL8we+Sy87NDdTuRns2eiGzJFABZeTnetJjD+s/QM=
X-Gm-Gg: AYBFou0k/iCtQXXJipD9weM0D8BxIgQ+17MoZ18QIY0clP7u1Ryt/zOV14JrZ3sIdIw
	IPx3IYga9t8wnDDRpgm/8KK16HdknW6EIjRHVPWMkNHzuwfEwYA/AkId34FzYvMumY86iZfbAFq
	AMwF0ikcDCM9i2gCH+RWIMepACi/wmtYJ9IMJa2gwG+euIGrkF3yPO3mBzaVDkVoXiHxjr/XfkW
	NbIjx5ER/4NAZxMXpjijgETj1h2+CEoyJhXZnc7TgAkjtRf3seNQdHP+c7aOkCxy/o6X7d17XHe
	Jx9SnhhVu/cuqkseT7nq4Gl13lNvP+XaxNmUxQfVw9nPpJNeOU6KYdCrW4PnCKo9TLPUkRroQsb
	yF/Ej/QEF9hMG8Oj+xw+wSP58Xoy4XAFmimTAF+18GJjj62pjABxgXPqdGWxaX5aB/ikoVQY/5t
	lPxHfF5ynf6EPCPGLW4ihs+VGDmEuKRulI5MFM4VtHEIRZJcx3mcJxJujdHE12YLSxFpX/VTkmO
	qMrMl1a
X-Received: by 2002:a05:620a:410c:b0:937:27fb:96f8 with SMTP id af79cd13be357-93e8f4f6504mr130990785a.41.1791275470686;
        Tue, 06 Oct 2026 01:31:10 -0700 (PDT)
Received: from [172.17.0.2] ([172.203.206.169])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0c074desm107704936d6.38.2026.10.06.01.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 01:31:10 -0700 (PDT)
Message-ID: <6ac4b1ce.24b1303d.3a6c0e.16a9@mx.google.com>
Date: Tue, 06 Oct 2026 01:31:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0059894916171211637=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: 6LoWPAN: Use RCU-safe device list removal
In-Reply-To: <pm-bluetooth-objects-candidate-0231-v5-32295fa35099b0d50b92@gmail.com>
References: <pm-bluetooth-objects-candidate-0231-v5-32295fa35099b0d50b92@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0059894916171211637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1180108/

---Test result---

Test Summary:
CheckPatch                    PASS      1.25 seconds
VerifyFixes                   PASS      8.66 seconds
VerifySignedoff               PASS      1.08 seconds
GitLint                       FAIL      0.39 seconds
SubjectPrefix                 PASS      0.16 seconds
BuildKernel                   PASS      22.21 seconds
CheckAllWarning               PASS      26.22 seconds
CheckSparse                   PASS      27.78 seconds
BuildKernel32                 PASS      24.03 seconds
CheckKernelLLVM               PASS      25.08 seconds
TestRunnerSetup               PASS      583.13 seconds
TestRunner_6lowpan-tester     PASS      7.05 seconds
IncrementalBuild              PASS      23.35 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: 6LoWPAN: Use RCU-safe device list removal

44: B1 Line exceeds max length (131>80): "    [   45.867526] Oops: general protection fault, probably for non-canonical address 0xfbd59c0000000023: 0000 [#1] SMP KASAN NOPTI"
45: B1 Line exceeds max length (99>80): "    [   45.869489] KASAN: maybe wild-memory-access in range [0xdead000000000118-0xdead00000000011f]"
46: B1 Line exceeds max length (112>80): "    [   45.870981] CPU: 1 UID: 0 PID: 646 Comm: sh Not tainted 7.2.0-rc6-pmb-bt-functional-v1+ #4 PREEMPT(lazy) "
46: B2 Line has trailing whitespace: "    [   45.870981] CPU: 1 UID: 0 PID: 646 Comm: sh Not tainted 7.2.0-rc6-pmb-bt-functional-v1+ #4 PREEMPT(lazy) "
47: B1 Line exceeds max length (134>80): "    [   45.872609] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014"
49: B1 Line exceeds max length (218>80): "    [   45.875067] Code: 48 89 d9 ba 04 00 00 00 4c 89 fe bf a0 06 00 00 e8 2b e8 ad fb e9 56 ff ff ff e8 01 1e c3 fb 49 8d 7f 18 48 89 f8 48 c1 e8 03 <80> 3c 28 00 0f 85 4a 01 00 00 4d 8b 47 18 4c 89 f1 ba 04 00 00 00"
51: B1 Line exceeds max length (84>80): "    [   45.879106] RAX: 1bd5a00000000023 RBX: 0000000000000000 RCX: ffffffff85c1d19f"
52: B1 Line exceeds max length (84>80): "    [   45.880334] RDX: ffff88810dc35700 RSI: 0000000000000000 RDI: dead000000000118"
53: B1 Line exceeds max length (84>80): "    [   45.881455] RBP: dffffc0000000000 R08: 0000000000000001 R09: 0000000000000001"
54: B1 Line exceeds max length (84>80): "    [   45.882546] R10: ffffffff893d3057 R11: ffff88810dc35700 R12: ffff88810a690000"
55: B1 Line exceeds max length (84>80): "    [   45.883839] R13: ffff888115451038 R14: ffff88810a690000 R15: dead000000000100"
56: B1 Line exceeds max length (95>80): "    [   45.885186] FS:  00007fa889bac780(0000) GS:ffff8881fd852000(0000) knlGS:0000000000000000"
58: B1 Line exceeds max length (84>80): "    [   45.887527] CR2: 00007ffe304f2f80 CR3: 0000000104f64005 CR4: 0000000000770ef0"
82: B1 Line exceeds max length (218>80): "    [   45.904359] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff"
83: B1 Line exceeds max length (89>80): "    [   45.906981] RSP: 002b:00007ffd7651b960 EFLAGS: 00000202 ORIG_RAX: 0000000000000001"
84: B1 Line exceeds max length (84>80): "    [   45.908070] RAX: ffffffffffffffda RBX: 00007fa889bac780 RCX: 00007fa889c3e687"
85: B1 Line exceeds max length (84>80): "    [   45.909102] RDX: 000000000000001c RSI: 00005570f25e8d10 RDI: 0000000000000001"
86: B1 Line exceeds max length (84>80): "    [   45.910133] RBP: 00005570f25e8d10 R08: 0000000000000000 R09: 0000000000000000"
87: B1 Line exceeds max length (84>80): "    [   45.911162] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000001"
88: B1 Line exceeds max length (84>80): "    [   45.912190] R13: 000000000000001c R14: 0000000000000000 R15: 00005570f25e8a78"
93: B1 Line exceeds max length (218>80): "    [   45.915436] Code: 48 89 d9 ba 04 00 00 00 4c 89 fe bf a0 06 00 00 e8 2b e8 ad fb e9 56 ff ff ff e8 01 1e c3 fb 49 8d 7f 18 48 89 f8 48 c1 e8 03 <80> 3c 28 00 0f 85 4a 01 00 00 4d 8b 47 18 4c 89 f1 ba 04 00 00 00"
95: B1 Line exceeds max length (84>80): "    [   45.920046] RAX: 1bd5a00000000023 RBX: 0000000000000000 RCX: ffffffff85c1d19f"
96: B1 Line exceeds max length (84>80): "    [   45.921129] RDX: ffff88810dc35700 RSI: 0000000000000000 RDI: dead000000000118"
97: B1 Line exceeds max length (84>80): "    [   45.922553] RBP: dffffc0000000000 R08: 0000000000000001 R09: 0000000000000001"
98: B1 Line exceeds max length (84>80): "    [   45.923653] R10: ffffffff893d3057 R11: ffff88810dc35700 R12: ffff88810a690000"
99: B1 Line exceeds max length (84>80): "    [   45.925119] R13: ffff888115451038 R14: ffff88810a690000 R15: dead000000000100"
100: B1 Line exceeds max length (95>80): "    [   45.926180] FS:  00007fa889bac780(0000) GS:ffff8881fd852000(0000) knlGS:0000000000000000"
102: B1 Line exceeds max length (84>80): "    [   45.928726] CR2: 00007ffe304f2f80 CR3: 0000000104f64005 CR4: 0000000000770ef0"


https://github.com/bluez/bluetooth-next/pull/867

---
Regards,
Linux Bluetooth


--===============0059894916171211637==--
