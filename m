Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8D22236F0
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2026 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783867299; cv=none; b=mP2ctN0Bhix8GA+NzzJ9x6p/HS0ICH8gxcNEvOqF8gc7oCkQLyJgXLVjQNJOjx5vjQ9KVp79FBUhIbIlXgs3Pi13IR42N82Ej1eb1YP+PPrlCraQ8X3qPbtiHeb+fOBm/z6p4mh61mUnzybl3U68M1b0jxC1zsijQ2UzAXIlgxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783867299; c=relaxed/simple;
	bh=3mcKw3KKMRjfrUa+vWDpmk/DNDvHYzK/GuRU4JpVnlo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WI6YBDmDT03oB5L5SW+py6mfwvG1yEf8P6uYuzywkrv0exzt1Y//9lzapUbKhWq43hXQTDuBNCQ+fheqYxfv7xLiQc/zmhvMWyHs7jA2AVLheXjySl3ZLp+AXXmSmObCAJHds5rUncUzTCcbFefxjNSMouK4e3Jzdgak2bpKZGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUAzCvyP; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUAzCvyP"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e67555e24so129199385a.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2026 07:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783867297; x=1784472097; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MeQOF5Nbz2CfTSGHY5PIRWpL+cFFyij3V6SntD/sGuQ=;
        b=iUAzCvyPyWbH8Jb+glL7lHTtKl+lm4Tz5wguo2GmWVUPsyxa8slu28s3ffZprHnyCe
         tWjLQ9+9PRr5VNm+QqJQROaHDx+WsXWwLRkkt7+1fj4rPTm7eIDFM3HoyYtd962OlsO9
         p931ms5gn1dMfsOS2iiS42HXMrRFOU7X0Rew9FBaHs7Qqy9QnjlXuBgGBrwEMUt7GbiI
         RfGnZR1sJ9wso9isXCI1gw77Nd4C2B08iiiZS/9sZFap4TH/GzwCWvo9KqXhWdxVGB/s
         +p8tG13KpxJ8AkiskJh9T++WPSkHgJ385cviQcs/1fLc3hKJkALyZkPQn/3QjiH9dEPS
         6itQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783867297; x=1784472097;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MeQOF5Nbz2CfTSGHY5PIRWpL+cFFyij3V6SntD/sGuQ=;
        b=SZ/Spgy9SF9lcb5SKdlKKELn4O16rQhSHcA5opRHijJsw/+XMEzcv6Mi3qi1uP0iVG
         F4xC8EgQFxaqcbBzBPoYqEYE1fBQgnEDMKYGnB6oGebkIC17d6NNorSVxYYXe1Baortc
         ZBO1eE3OUitK4hH/qONp90TUNviB9zv3MMM8HDcPNKJP0cxxJCMxzqNPSKKDsRVmiuev
         m3fsr/KmjsYRMQ72uWLkYfltGA/wzuXvt5vTAGAzUNuRgALDBzdsOkRV0q4BdrzQ3vA7
         4IeOaryvtiEkvNBY2c7UAN/Z6mjV3Rb69i41M0PrNDepWxiVbTZos+LkDI0l7YcKHDeN
         YMkA==
X-Gm-Message-State: AOJu0Ywxb2XVUmC45gI8I1/o6LlbSbiUNQXoynd0aXqoRBLB+k7fc62C
	M3tOTkoCkDasidNNIkyR3S6ZO2nmT7ImuLNsbhiOhKhVkH/rx25lnhAGs/lKmw==
X-Gm-Gg: AfdE7cmV3cazJMnB3DhNKnHY7FVxxpE7q83aZF4Rkq6KLLMgRtoPiTJ9Urhi0aUcbiz
	6sNibwv/R9ULdKh1MBCN9AFMaDz23vLTTm+ERsh29+q1QkgOvk0XySyPLBtDH37nJCiZPSmeosZ
	GV1qO8FooH3cf7nAsPB/DVtglX96fohJP9Sxl3m0hTAmRtNplW6Wa+zO0+OqgxwQkMUB7bYXsG+
	4cZVeWU19kmLrdkLEcsY/zoj+iFgd+lsVKhbGPVGQpTei7+1YggNrdYGTX9aTTQz2z58UsxmmVY
	37KwxnnmmezynFbicm5jt72p9cr07pbQtm4D/qHs12NeMddpH1jKV8xJ06NG/rZXTX83feaggZ1
	p0Hl3PyR9HHRKLdjfcRKFhnXWmNdQsR8WrKWft+rRQCUobMJ+tgX0YdgGVgV92r1gZBOLq5snM3
	ZX2+ywB3JwtZ4O2J+ESg==
X-Received: by 2002:a05:620a:444e:b0:92e:c118:18cd with SMTP id af79cd13be357-92ef2cd6b43mr587584185a.88.1783867296752;
        Sun, 12 Jul 2026 07:41:36 -0700 (PDT)
Received: from [172.17.0.2] ([48.214.53.82])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cf7ab2sm815941585a.30.2026.07.12.07.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 07:41:36 -0700 (PDT)
Message-ID: <6a53a7a0.dab7d853.28539d.7fe6@mx.google.com>
Date: Sun, 12 Jul 2026 07:41:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7052370188909911619=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [1/2] Bluetooth: L2CAP: avoid maybe-return-locked and add locking annotations
In-Reply-To: <9a718ecfbeb46077d8100dcb687e1ab6073986f6.1783860121.git.pav@iki.fi>
References: <9a718ecfbeb46077d8100dcb687e1ab6073986f6.1783860121.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7052370188909911619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1126083

---Test result---

Test Summary:
CheckPatch                    PASS      1.84 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      0.67 seconds
SubjectPrefix                 PASS      0.26 seconds
BuildKernel                   PASS      25.93 seconds
CheckAllWarning               PASS      28.09 seconds
CheckSparse                   PASS      26.96 seconds
BuildKernel32                 PASS      25.12 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      464.52 seconds
TestRunner_l2cap-tester       FAIL      59.28 seconds
TestRunner_iso-tester         PASS      85.82 seconds
TestRunner_bnep-tester        PASS      19.07 seconds
TestRunner_mgmt-tester        FAIL      213.90 seconds
TestRunner_rfcomm-tester      PASS      26.06 seconds
TestRunner_sco-tester         PASS      32.35 seconds
TestRunner_ioctl-tester       PASS      26.44 seconds
TestRunner_mesh-tester        FAIL      26.05 seconds
TestRunner_smp-tester         PASS      23.08 seconds
TestRunner_userchan-tester    PASS      19.71 seconds
TestRunner_6lowpan-tester     PASS      22.91 seconds
IncrementalBuild              PASS      25.30 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[1/2] Bluetooth: L2CAP: avoid maybe-return-locked and add locking annotations

16: B2 Line has trailing whitespace: "    "
20: B2 Line has trailing whitespace: "    "
21: B1 Line exceeds max length (154>80): "    net/bluetooth/smp.c:589:2: warning: calling function 'l2cap_chan_send' requires holding mutex 'conn->smp->lock' exclusively [-Wthread-safety-analysis]"
25: B1 Line exceeds max length (153>80): "    net/bluetooth/6lowpan.c:455:8: warning: calling function 'l2cap_chan_send' requires holding mutex 'chan->lock' exclusively [-Wthread-safety-analysis]"
28: B2 Line has trailing whitespace: "    "
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
L2CAP BR/EDR Server - Set PHY 2M                     Failed       0.252 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.244 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.622 seconds
Mesh - Send cancel - 2                               Timed out    1.989 seconds


https://github.com/bluez/bluetooth-next/pull/426

---
Regards,
Linux Bluetooth


--===============7052370188909911619==--
