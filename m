Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7871E56C633
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 16:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883555; cv=none; b=B6i4YiEXkHMSDwi5nmFL4qd7vACLScj6bptJoClDzR/9PZ9ZoJ7/ltT+CNiFX/41tfBZKRSjt/RBwJIcMjlwfORdk5mV6Oe+D54+AH7ffIcoMF5ntNJqkhtlH7IEMLdxJJ0Fs9ImwGsNrtcw3eSJ8coHYKY+jOT7/zhpPP6VEyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883555; c=relaxed/simple;
	bh=edyP/ao0kAHJA2yddC5OSRQO2nXCnKooMu5bakC/Sl8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qpsIlzWh7zckG504nHgH6Vr0BldZHd0l/6VmMUT1+3947/Oi3hoHpmC9Eq9w4ssieNt/h7aOw4m2ogJjGBneDre+XYuKxxOocdyi3yzqhCIWVe+8nIzFqF2qnQRG4BA6g38riCfyjh26aJ/oMvP3szL4FbhWO6PrguChPfvOYQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGmJESgi; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGmJESgi"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-91058dd77a2so1558656d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2026 09:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788883552; x=1789488352; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+I4W2sAiPfxyUG89R5DPRhMfheAw3B+txqZ1DjgV6Pg=;
        b=SGmJESgi+KD90xs6/ntCLDrkGZffyNwa+LjZ1ebcvooe0VxV1uqK2Hox/ujI1/TUxB
         bzcVtmWMk+5c5IKLoqPIoBfju7WdTIwqay/XppC1/F8fazYsUn702t8v6+UIkk3hns0j
         o3LWrV/nW6KfqR2tmj1Gyylu7kfq0af49sJKO6caoSCpmr47Ync+5NtcdF9hz/VAvTpW
         58NSf1sB40xIqsLiQelMEqf6DEuJku2sbAg8e9J1E+J96MFT8uFqJuR7xyeCvp/FI/zf
         +dSQ5kTvcSqobY/QsNrhEbPo3g1RlUxTc6il6SMtQrZnAivAWoaSHI4290khRlaqRKca
         /LZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788883552; x=1789488352;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+I4W2sAiPfxyUG89R5DPRhMfheAw3B+txqZ1DjgV6Pg=;
        b=GKn9Eh2ZN27jpZrqmIuXghRflAJnjxTaEUiD0qzoqFADMFad+qY9/Cj4AyX8Vak99I
         iVPpHUguUoQBRlIJGNdvF92UWic5/b4KY77UQNjGOeeliWJUsJQMTFvjmuy2OySvAUvB
         h8vAZSOxOw/f4MDToXySCs1gZ3fT9fAsbtEYLVmkh1fS+yXHN32Ue3hzKeLditswGYBM
         yJMeNbhH96ihqeAuUKpzXZcFrMxwIbiOfXPWNG3wa/+vU0c/AVT16ouhV+v9uEsE5YvV
         xram/bXPMzTtZ34P34wrlZQ/mmca8oL+XZR1YrBXgrdQH0qIR4fjpYPyzdMv3XYnHmVC
         HzNA==
X-Gm-Message-State: AFuF++mle93DX1t/7LPiB/oD/VpqF74+iDzEbdC4malQuQFeLcLZflGv
	n7WNCnMhwPHNagn0M3mrqVoUzk+b/xHQ+2TOGwOfCqe0lgkH0/k6EhsrWu9sLA==
X-Gm-Gg: AYBFou0rqCNTe6AZ1m3zsTAyoFXXql/7qsgEt2Z7A/zqkLUs7JMKPVA7kjJl3pTGxuC
	CNiTBXeAZwXGfP2StKNClUAiob797ceXaG+AJ5xsISmhNK2BVhuMEMzE27+nsii1dYV13DZyLgV
	HJJ3fz1b+McWaDC4X4OFZOU1F+1cz85JxQw9sB/IftZZx80n2uxkYUhSj91areQ077QAY3Hn52u
	2JzmwgBC0G8/PHK9ymb9zgsJ34O+1FJs9Tln4phf4hZvP24hJFPg0Ggb557smovRCLsqHaQaJDp
	Clg6Kj2/NEX8TKehpBIingtcIVYh1CXuEngrgX/2WnqVEa7cEL8t4mXCdF6LSC0b7VffIQLkvTr
	MlKgehYa+kwy1Y3XIiijLAT3bEEwsw6dGxKTtUu8+lOWX2PYFysLtLYyr4ngA60pvMCw6oA1L2C
	AXlHv+AjFb3j6TcgyYO+oHkTrlf7UOFMutVuFX1uzdk0nbxHtDYPCBeT0q9XcAcs1b2vg0R0mlr
	uhNt/s=
X-Received: by 2002:a05:6214:19ed:b0:90e:9460:1c04 with SMTP id 6a1803df08f44-9106b420805mr6314486d6.28.1788883552093;
        Tue, 08 Sep 2026 09:05:52 -0700 (PDT)
Received: from [172.17.0.2] ([48.217.251.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9104fc73ea5sm72100276d6.39.2026.09.08.09.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 09:05:50 -0700 (PDT)
Message-ID: <6aa0325e.fa3dc74f.16cb9d.1d1b@mx.google.com>
Date: Tue, 08 Sep 2026 09:05:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2666368847529567567=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, radek@podgorny.cz
Subject: RE: Bluetooth: keep dst_type with dst when reusing an LE connection
In-Reply-To: <20260908012048.3681904-1-radek@podgorny.cz>
References: <20260908012048.3681904-1-radek@podgorny.cz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2666368847529567567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1160053/

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      29.20 seconds
CheckAllWarning               PASS      32.20 seconds
CheckSparse                   PASS      30.40 seconds
BuildKernel32                 PASS      27.77 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      526.26 seconds
TestRunner_l2cap-tester       PASS      70.07 seconds
TestRunner_iso-tester         PASS      106.21 seconds
TestRunner_bnep-tester        PASS      20.56 seconds
TestRunner_mgmt-tester        FAIL      236.58 seconds
TestRunner_rfcomm-tester      PASS      27.26 seconds
TestRunner_sco-tester         PASS      34.15 seconds
TestRunner_ioctl-tester       PASS      27.81 seconds
TestRunner_mesh-tester        FAIL      26.95 seconds
TestRunner_smp-tester         PASS      24.61 seconds
TestRunner_userchan-tester    PASS      21.29 seconds
TestRunner_6lowpan-tester     PASS      24.19 seconds
IncrementalBuild              PASS      27.23 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: keep dst_type with dst when reusing an LE connection

8: B3 Line contains hard tab characters (\t): "	if (conn) {"
9: B3 Line contains hard tab characters (\t): "		bacpy(&conn->dst, dst);"
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
Read Exp Feature - Success                           Failed       0.280 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.457 seconds
Mesh - Send cancel - 2                               Timed out    1.988 seconds


https://github.com/bluez/bluetooth-next/pull/716

---
Regards,
Linux Bluetooth


--===============2666368847529567567==--
