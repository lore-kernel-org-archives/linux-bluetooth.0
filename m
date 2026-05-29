Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16CB1A682A
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 15:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067384; cv=none; b=lcXu4/yTQa3taD1nnhYqnimzTH5HKkXtuvC4mJLlwQELHKPg+scHNjznzYcRnYjz6FHSxqqKnpzWJIWrUt9X9voOwlI0dDZhRCrFrBYRKKdrlfp+0qhzOxYajdPAiJbsN6I3DR4iZZOlDm3wTEvfXXZf2mgnukOIdVrid8qbaD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067384; c=relaxed/simple;
	bh=SbA2WFqJOEdpKUZ8BDFHrTsLIlIESR/mF6TQqWPxW70=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UWipiC5Fge8JCCzqKUu9EvCTE9kwLPlkKgcq9PW5lK/L6/inMbOd8AjW1ltmFtwR+x+8GZMVqXOLp0PulJiEkLCa3xna3sE40B0x4OX5/zH4/5E8mZX50zHHuAB5+ANFYUDE4Q5kztaRfDZg65uFL56QKw5jUDV3/V1EhcGFgLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byBDNoia; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byBDNoia"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-304d8e3bb72so735784eec.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 08:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780067382; x=1780672182; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=un0zrJvwAjzv6mTP4OTCf0d3SXq+cFirgM2akr8kliM=;
        b=byBDNoiaRpFMOjTmq6J3Ju1TYxYCUEeFtubwnd0TpxXWpWMarGQ/cDcKFTk8x2aocj
         MpqzojFBstayL6sums/IcHyjFO7DOwKCGyscwfmDuDFPmDjUS7FqijqT/Su8pEvuXboz
         jNTRVxBzJchpvoCuRGJSk55DI0pBENWY2xuXzeOYzcoVXZTR+bNLemBBJJH8C6TfEK13
         MhSvnYfMulErnOQ/ZmDvDP89hpHC6C54cSgt3ufQ3BYTUMiFXO/pJBIlEL34xhGrdIhL
         siABHlGbL/0tFtOPNLlvbQHlYE0puAuzONts2xAuTrjcuxkef3R4cwQH+j1MuW1VA4Fz
         fFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067382; x=1780672182;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=un0zrJvwAjzv6mTP4OTCf0d3SXq+cFirgM2akr8kliM=;
        b=F3QtHyHJ+98qMcCrGkQ1oGZx4sx1+MH48lM5FAhVAxZfwqBaQ83JJSwIzPHVhW1LHi
         o8UrXwqemUnZ3GU56n6KhzeqmzepBmzpeORcq9gdjnGuojLpVAk0juzZt0h3GHwwqzco
         Fs3GqNyr12jnZLX4W6DA+T8Gdl2WuXJuhew6+hynFHwu9JHv6LCJPAzwgJejHGnZQP39
         UYo0njxyRRRFQ8eIrZ6hWRTFB397gu18LhckaSv44XsOT1INzyCI0MtbsfUSdrCjE85o
         QYJqiKf/oQi3PbNmcVmRE1UcAE4iuA/CcEx1fkZVlppPEomKH5X4GfgD0+FkWGJ/F06e
         l6nw==
X-Gm-Message-State: AOJu0YxwDoYeU93gmAaStsXkAhKIVUG4JKD3QEyTxYgy6sXTP+iJXm1g
	Vf+AfVU8ZkkNwKURLEcQBl4kcenmX2KYuINWT63JCnUrBst7mMZ7+4oKcpDktg==
X-Gm-Gg: Acq92OEEqNLdTU06m+qcf1ATiPYkMh9KQSPTThvFjVFQvgAzIXONfvIqcJ58TuSLuKJ
	jjvQi2wkA4kk/TvRGnyEFxAGlQkddk+QhA0nGXMRflXMCMyRoUxP3ymgY+8dZqR/WQf4y5Enawu
	291D1VOjCXA61nEogzZpxR/ExRt/bdZg/6swUs2YFq/bTkOq2j4pzCup4JpRMUiGZSogwPXzPTJ
	blU/OTaVzXhbc5layBSuh0mKAyqgY/dxHVrFo4jyrAP3PKhDbOkA7XQSUkqxtWCjaa+x8p+9Ba8
	uswVc/awbjdNrMxuTq529LSpI1CIGdI9r5eFfI856MSjR4HGOPBd5yNs4qC8oxPoSRZPr8FTUTK
	u61Xoy44H1SM1EdI1H4pxH7W16zZbBwY6xx27vTzWADt4PA6AqxMW1qcAas2STo2wIn0AAn63vS
	F+Ey2KqcSwnwEmfjor49LH33Ac8MVAiqfMRp+CfGKQAkM=
X-Received: by 2002:a05:7300:8607:b0:2d9:ad46:4a92 with SMTP id 5a478bee46e88-304fa59be0amr135752eec.13.1780067381850;
        Fri, 29 May 2026 08:09:41 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.158.212])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ee0dd6fdsm1356435eec.23.2026.05.29.08.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:09:41 -0700 (PDT)
Message-ID: <6a19ac35.70920dee.344c65.4c77@mx.google.com>
Date: Fri, 29 May 2026 08:09:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5374557052695149827=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, n05ec@lzu.edu.cn
Subject: RE: [1/1] Bluetooth: hci_codec: validate capability record length
In-Reply-To: <4927cae4fe043f3e2aa80f4ee6bed05e4fb5a6d4.1779633761.git.xuyq21@lenovo.com>
References: <4927cae4fe043f3e2aa80f4ee6bed05e4fb5a6d4.1779633761.git.xuyq21@lenovo.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5374557052695149827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1102899

---Test result---

Test Summary:
CheckPatch                    FAIL      0.60 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.47 seconds
BuildKernel                   PASS      26.89 seconds
CheckAllWarning               PASS      28.89 seconds
CheckSparse                   PASS      27.74 seconds
BuildKernel32                 PASS      25.94 seconds
TestRunnerSetup               PASS      574.02 seconds
TestRunner_l2cap-tester       PASS      60.78 seconds
TestRunner_iso-tester         PASS      80.04 seconds
TestRunner_bnep-tester        PASS      19.62 seconds
TestRunner_mgmt-tester        FAIL      221.48 seconds
TestRunner_rfcomm-tester      PASS      25.72 seconds
TestRunner_sco-tester         PASS      33.76 seconds
TestRunner_ioctl-tester       PASS      26.62 seconds
TestRunner_mesh-tester        FAIL      26.89 seconds
TestRunner_smp-tester         PASS      24.22 seconds
TestRunner_userchan-tester    PASS      21.02 seconds
TestRunner_6lowpan-tester     PASS      24.16 seconds
IncrementalBuild              PASS      25.60 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[1/1] Bluetooth: hci_codec: validate capability record length
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#89: 
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#90: 
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#91: 
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:GPT-5.4

total: 0 errors, 3 warnings, 0 checks, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14601083.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


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
Mesh - Send cancel - 1                               Timed out    2.550 seconds
Mesh - Send cancel - 2                               Timed out    1.993 seconds


https://github.com/bluez/bluetooth-next/pull/255

---
Regards,
Linux Bluetooth


--===============5374557052695149827==--
