Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B5F3EEAF8
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 10:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784976611; cv=none; b=rCe2hxSmT99O5r9KHvt22XUaxvF3rMVCprPf6CS20Qxi4zZfbkDJUjhWfU5YgXOzpKXKIKOnlrlmpUcgy5OkJ5NTT457i/SgCXbAF5dw4f8fvtUvb1W7cIZ2Tz0x2GRP9o8vK4lMdPpoqLF1MTk8smC/zyJwIcpwgrPReqNRkJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784976611; c=relaxed/simple;
	bh=tbsVzt0E77O+88XkGYrGyolgvIIcE75zsyx7QX9LX9I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XRkxy+muEHmsfpSBTmjluNTY0pYtf1PhOQlTm1Xy4tmZJwpiJFHRWIGcOuUDsgZOXk0t2HL0BBUYZ//fr0f8BAU8h80aCXUrUPZrqpBg8vMQh63CC7SKgYSs9ZAhN9ceCAAc0NI3XleDNetBFJpQEL5mq4jue3jTSiv1dti89BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ak53AD9g; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ak53AD9g"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51bfa429aa6so19856791cf.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 03:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784976607; x=1785581407; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QbE2/GK7AMJAmyw+IPG805M1/iVts6tJo/TBPmOmzEM=;
        b=ak53AD9gXdl3B0tSLwLPTKySZnbrWQyKXaZBloEc5MXJBB7SqsW705YX97dtUD6482
         y5Cjggf0/oApAb/qRL9Sy+IQvSplC7dNCTKAtNohjzNgzjt+HlJM0p1sV+bfJ675O8xZ
         mLryL90v1gnPJpqtgAK2bqk2I5XWu41yoYaK3Bac13+PD4c4gCldO38R9JjUstIOxEay
         efHXf8yi+hbRw+2O65JktW11pMoJLj7tki0KrzUpGcPRlX84mz7zH+GHvhTryOn8SkQG
         MY6NT+HAm8Ch7sK+O+bDsBfK38GjiMVLRIhaVp2pWEKva8DbQCoX738174BU5bu5vluA
         G1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784976607; x=1785581407;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QbE2/GK7AMJAmyw+IPG805M1/iVts6tJo/TBPmOmzEM=;
        b=UcmWZF+mqMYS2VGyor9kr4FINCci7yGiSJ+D1zodYhiw5xb90gB6xlYs1YX39sAIDF
         EMqhsDh1RGVKv+hsjqkUhWyGQiO3whK0Y7NAWZN47t3LqYR3bjK4nf1HLSveCGH4zeMQ
         b8hKaVdhpwmZcA+iitWZoDymuYJRUY8thMkysWQSlt2XOZZec48chUb0qOEq7D8Rf/hM
         CyXdefMmPbUEqDx2qFIRtS2P4nRPPHSbnrzjKoKHUAG57UkB6K3sBbX0lI80PysHez90
         I4IrTx63bY/5VEkopAr3+qlxGgcmr+rAScVsIYi246qPxyxGFEX3yWjBWTleKgqOEGBL
         9sNQ==
X-Gm-Message-State: AOJu0YwH60HvMyoEhbNoNZiLoAaQV4VJurjAlIN+mvp9EV2FPadqZ591
	Sf0gkG9Vqyupa79dEWEOaXJkISP33TWcv/YooTXW+04Ka62kWZJTWXCJQi3MRA==
X-Gm-Gg: AR+sD12ei32tQa0oCaoMoratQy/ncs+cGuBgjDHxWF2b0Z9GW+v2cwwdKHHOlJIaZ0+
	ku9OYT6lmYXwr8itOGowDmmAcDixXccSEO12mLBwO4XqUGn3zO6uvciugvGIkLiDESx/0LHpZS2
	+lYGVPpf3pVeJvs9xGMGEodmseEP/Yhb58/ZbNHdIHOGXiE6Os7lPj8D8joeps/UXsLdr8ouZal
	r4y0FdVOyRKKosd7lQFs8CJZC4Ps+0VhCLdMpItPIVr550qDjUepT1IyHNCgCpkHYCpaqL3OIv4
	VrSlov+rPzHdShIgQFJFVQWnJcvC3Eejw+lliKJVtjre8zkslie709f+MX8kevdf5lZtyKGvgET
	cpnl/aLvTQbeGlqi7eQGxfhoEpArHZnTvK39hY1r1Q34O2rg/l1gXUrMvEE9Aq0rN/tLi+6VXDI
	Mjf2tG9NU=
X-Received: by 2002:a05:622a:314:b0:517:c65c:4987 with SMTP id d75a77b69052e-5295d37817emr40557331cf.22.1784976607367;
        Sat, 25 Jul 2026 03:50:07 -0700 (PDT)
Received: from [172.17.0.2] ([48.214.55.34])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529a29ff66fsm16902341cf.25.2026.07.25.03.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 03:50:07 -0700 (PDT)
Message-ID: <6a6494df.e54e182e.2a1320.446a@mx.google.com>
Date: Sat, 25 Jul 2026 03:50:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2136005376158405905=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: hci_sync: add conditional locking annotations
In-Reply-To: <528c354dca68f05cfd17df7c80f8b04419c0fb74.1784973709.git.pav@iki.fi>
References: <528c354dca68f05cfd17df7c80f8b04419c0fb74.1784973709.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2136005376158405905==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1134346

---Test result---

Test Summary:
CheckPatch                    PASS      0.75 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.64 seconds
CheckAllWarning               PASS      27.99 seconds
CheckSparse                   PASS      26.86 seconds
BuildKernel32                 PASS      25.05 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      463.95 seconds
TestRunner_l2cap-tester       PASS      61.12 seconds
TestRunner_iso-tester         FAIL      88.17 seconds
TestRunner_bnep-tester        PASS      19.14 seconds
TestRunner_mgmt-tester        FAIL      224.05 seconds
TestRunner_rfcomm-tester      PASS      26.54 seconds
TestRunner_sco-tester         PASS      32.40 seconds
TestRunner_ioctl-tester       PASS      27.39 seconds
TestRunner_mesh-tester        FAIL      27.09 seconds
TestRunner_smp-tester         PASS      24.68 seconds
TestRunner_userchan-tester    PASS      20.87 seconds
TestRunner_6lowpan-tester     PASS      24.96 seconds
IncrementalBuild              PASS      25.50 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 141, Passed: 134 (95.0%), Failed: 7, Not Run: 0

Failed Test Cases
ISO Disconnect - Success                             Timed out    2.272 seconds
ISO Reconnect - Success                              Timed out    1.992 seconds
ISO Reconnect Send and Receive #16 - Success         Timed out    1.998 seconds
ISO Reconnect AC 6(i) - Success                      Timed out    2.408 seconds
ISO Reconnect AC 6(ii) - Success                     Timed out    1.995 seconds
ISO Broadcaster Reconnect - Success                  Timed out    1.937 seconds
ISO Broadcaster Receiver Defer Reconnect - Success   Timed out    2.361 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 487 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.260 seconds
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.404 seconds
LL Privacy - Unpair 1                                Timed out    1.904 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.913 seconds
Mesh - Send cancel - 2                               Timed out    1.985 seconds


https://github.com/bluez/bluetooth-next/pull/494

---
Regards,
Linux Bluetooth


--===============2136005376158405905==--
