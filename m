Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71B934E75A
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 10:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784023646; cv=none; b=qJJO4hgWwL68/1UfoRiEzesGGJWCUNcRbS2oh8MYhiHLhnC0tF1LP0qQdTo4zr1bRPveKx04F3759SCH5FIIEvSm2mo6R0hdike+rkmhRWkdLEmlFIvFOqtzoLRieNqfk3MN9wXToqhWyW6MjH9/5LvaSv9yT1PiLtbDM+7sBY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784023646; c=relaxed/simple;
	bh=RnLp1KZMsTQ99k8hlzIls3pNdUzpcb0Zdb1M/unmB4g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OYqY1WAVc5jHzV2TmvptZvviJglM8hL9lV4H9sJTKRFDkepNDPBt3rpA+LtAmwkQxcj+YSLlU0miqNtWDt8vP87qS6+xUDcNT9QGxOHdqN8c2JTe9HsKNO7E5t8OHJKib/e0Pm9dZmI9SjOCz/7P3KWMAtcMYWIwvR94bXccsxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEesEXP8; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEesEXP8"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92c7a0a701aso269005385a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 03:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784023643; x=1784628443; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XPe1O+fGxUsllgQyc4V7YYpUealxB94H7Pamua2DZY4=;
        b=IEesEXP86XcuSEfZIigpY0zIEwnRnkYrh1UYaynhoubjTZ38XEGyCel4//ajJ6nNHw
         bapUNFO1zn3L27Dwkf/i/C5Qy7NFmJef5wZoX2waMVIgCewwfeUM76EoMJIONcfVuMEv
         IaouyZYSH7h05wwdVQ7rxLG1HRUbrHwsHX8d6NfiZ0pwNyQbZe10DRuEtFWptwi/dbbV
         9v7EppzPSQ3q6Ch1vPwilgn4Wf0/xzvqJqx2Ie6ERiahgHkoysU5LHWjg1yck6wvRlwD
         RtIYkBwGQdvNU2eiQCX9b9+kbOcP/K0S9pxxw/XX2Jd5nmtnPlUj8VL0D8ktxxr4Getw
         XjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784023643; x=1784628443;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XPe1O+fGxUsllgQyc4V7YYpUealxB94H7Pamua2DZY4=;
        b=WkIlRBTGqEDVCiIfbzo/OYWb/U7oA1YmnKfYkh0k5A7FC5j0oqAttqDlnmk5IRq55N
         DEhXzVC8ylNUESFDao+OQqG5Os5biGPUHZF0TUv+SQLiQI2oPCCQYWwIygmnuqBFybzo
         tw2dUqsU6wPN0Xz/lliqL9vuhpcjtcOh/IWK8dnKXnGjiVVdZKd4PiCHhBdhv2bLQWSp
         Dk3A1tsc19HNp2/AjneHorrmvyjyTK59iHJqXr77RHFvzq7aPN+7EoEBPBLOerjElaK9
         9kPpshkKalA2CJ1S+zu4O31E35XFv3XV/oNdcPX2Wnj705i9yHKZJ7bEW1xjwPYBom7c
         Dozg==
X-Gm-Message-State: AOJu0Yylku9cZTQA9Gsti8CYldE6KQYJqN5VLfkDjDgd1lhITe70MaP7
	tdlt9MCBNMQ7C3OvHeYr3rGa9oXDqmInOyxqAl435fnsF1ZFSG5LZxEdMnpWWQ==
X-Gm-Gg: AfdE7cmS5Znx+8hcDL6nV1qKo6JyCSqZEo1bjiy1/lLI/FQstNSdyOzFGHo5ObF2WWY
	kwllO3AjPS+3QkjBpPLxW04ccl5u1O3DrHrzFnFn+AR2Vn4yJ6AXr6XliUbdOfW9Be6ouOg1xaV
	iQW5D5gsBV72ZMHoZCwyKZqSUn7bpRl3c+gr7juFtVN+1Z4IEOFEXLD29egv9HW9/GPyi+IKyC9
	iWCHbKl6a+OQiftzzsqTwFq2RwhV/MusRnp5v5uRjf4uaP/KXHoUW3YJ2ONeh6wLILkkCQToozX
	hSTBeiODtL+FMEl00r0n1rdr2NXMC+3EPALF0B7f4hmaC1xmrbstDb+l/hMWC7kpLpYsiR8lB5x
	hYobkKT/NgryTCOIGqNz9X3Xpw8XWKyi0EgvyECWgUOnGLCQqBhcfY4urkmMR8JxZF0I+iQcgTt
	hj1SSnTpInih6YnoVdpULz
X-Received: by 2002:a05:620a:2692:b0:915:75ba:1797 with SMTP id af79cd13be357-93083c72f17mr272504685a.29.1784023643379;
        Tue, 14 Jul 2026 03:07:23 -0700 (PDT)
Received: from [172.17.0.2] ([48.217.107.118])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b4a0c0sm1518688385a.6.2026.07.14.03.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 03:07:22 -0700 (PDT)
Message-ID: <6a560a5a.0224be13.2fdf02.64aa@mx.google.com>
Date: Tue, 14 Jul 2026 03:07:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7475628347280757877=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [v2,1/3] Bluetooth: L2CAP: avoid maybe-return-locked in l2cap_get_chan_by_scid/dcid
In-Reply-To: <aaf5b46dd2519f7b3c7e74f9b232be2130ca30db.1784018377.git.pav@iki.fi>
References: <aaf5b46dd2519f7b3c7e74f9b232be2130ca30db.1784018377.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7475628347280757877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1127242

---Test result---

Test Summary:
CheckPatch                    PASS      2.50 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      0.98 seconds
SubjectPrefix                 PASS      0.38 seconds
BuildKernel                   PASS      26.54 seconds
CheckAllWarning               PASS      29.77 seconds
CheckSparse                   PASS      28.12 seconds
BuildKernel32                 PASS      25.77 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      490.90 seconds
TestRunner_l2cap-tester       PASS      58.31 seconds
TestRunner_iso-tester         PASS      82.66 seconds
TestRunner_bnep-tester        PASS      19.01 seconds
TestRunner_mgmt-tester        FAIL      209.45 seconds
TestRunner_rfcomm-tester      PASS      25.01 seconds
TestRunner_sco-tester         PASS      30.43 seconds
TestRunner_ioctl-tester       PASS      25.25 seconds
TestRunner_mesh-tester        FAIL      24.96 seconds
TestRunner_smp-tester         PASS      22.94 seconds
TestRunner_userchan-tester    PASS      19.77 seconds
TestRunner_6lowpan-tester     PASS      22.49 seconds
IncrementalBuild              PASS      33.09 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,1/3] Bluetooth: L2CAP: avoid maybe-return-locked in l2cap_get_chan_by_scid/dcid

1: T1 Title exceeds max length (83>80): "[v2,1/3] Bluetooth: L2CAP: avoid maybe-return-locked in l2cap_get_chan_by_scid/dcid"
[v2,2/3] Bluetooth: L2CAP: add locking annotations for l2cap_chan_lock/unlock

12: B2 Line has trailing whitespace: "    "
15: B2 Line has trailing whitespace: "    "
19: B2 Line has trailing whitespace: "    "
20: B1 Line exceeds max length (154>80): "    net/bluetooth/smp.c:589:2: warning: calling function 'l2cap_chan_send' requires holding mutex 'conn->smp->lock' exclusively [-Wthread-safety-analysis]"
24: B1 Line exceeds max length (153>80): "    net/bluetooth/6lowpan.c:455:8: warning: calling function 'l2cap_chan_send' requires holding mutex 'chan->lock' exclusively [-Wthread-safety-analysis]"
27: B2 Line has trailing whitespace: "    "
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
Read Exp Feature - Success                           Failed       0.231 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.816 seconds
Mesh - Send cancel - 2                               Timed out    1.991 seconds


https://github.com/bluez/bluetooth-next/pull/436

---
Regards,
Linux Bluetooth


--===============7475628347280757877==--
