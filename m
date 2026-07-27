Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C3C1ACEDE
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785177923; cv=none; b=lmAJxcRNqFP2L7IdCTsaYaFRJFfbP4hFdGdJnaVrO1DcFEluBZPLIsZAWqzD5dAsPVFOJEzaPEwDgIJtDCKYnd//GxgfathtTPNcSuGH0OSAqqi0KE45arGkNrgg9w2vSqSfnwb86A1kHnYWIto5h4gLoiYcOIXQCl0kF9jNPJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785177923; c=relaxed/simple;
	bh=5jEDYcktoAfnEtDPuVWJJxJqaePyALP2A1YKt7hJ724=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oDtPF+dL8tQddukcqYVICAH9CGWOgji0V7mwAIU6vWV4pgmM05DhuojZvUCDy1vutBIUdRzTE1IpjXpkp4Za13KgOrvZq0e4gaXtpjN3132w+8kv35HoF0/evvFIfQTH5is8+wO/+rayXg2nzR/V4sMQUzB4KpAarpTSapnulWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qzLHir8x; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzLHir8x"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-526f963372aso21203961cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 11:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785177921; x=1785782721; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4OTWk+RqaSjZ9RoL26+Wl12au7I4aYQEVQ0N+2fllPQ=;
        b=qzLHir8x+yPCrJEl/xEDwXTbiW3uUn7SXuSsJHQ+5nRk1QPKRPc+MzQQSqAfOwFQak
         hwGOgSYmA7KL2TP4rK/cNoX3bCjuRfrF/HxV8xXfoU76p/qrUpjOj95QOV4PgNhB13/t
         hKTQLQPq0iH1zygNDqOtLghPtadcJVGXaJXA+Th9TFSipp8g5AkjLuAzIy5ZmK6CTZs1
         3qc3ub77iUO4teBJfusd2oWzF4z9WhDMOXy8+iZ0shH+oA/0/+cGIhQH8pgYSTZxbqcQ
         joxFDLqA8BD0muq3DQdAA3oiquwAwKt1p8POjMoqvRse2S/cLaJqcLgfHTygc54WY65n
         OJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785177921; x=1785782721;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4OTWk+RqaSjZ9RoL26+Wl12au7I4aYQEVQ0N+2fllPQ=;
        b=IorwXWx4TouexMR5pd5ZIdDejapwn5vpuXo4whhkzLHMpwTpPZZeGcwcCem86Yp54Z
         e+O8Vp8OwXCNo2ArfqOSz0MRZKeMvzXuAjc4+ct9m8jWGarzP14aQcX8zraZkpbTBKxS
         QAeaafCLp5wc3SX5XJMkbkBYva8scVL6ursEg5euTlfx+zUWJ9nDT9xySwRZz5lSWpLW
         JUMKNlJgLFi8Oy+wIRGe2xb/Ds6gkSZ/m/jcmjA3gUeClKtRVje3auxl15SrqPjMzgzW
         VClUuqVEqFhGqeefSfGWYrgLI3bRVnQtEdZOs0Jdr+jfmY5MF80v4++sgSL1EuQftSJf
         TuHQ==
X-Gm-Message-State: AOJu0YzmBVF8Qxi+1GtHWcpHeySJWFubv600eVvOJM9cM/qMqb+Ixl0m
	1tSRl1Z2MVRlZyVyA3L31M5b/LbbgotVp6rHwm19Pie1P+QK7USUD6lwB1crlg==
X-Gm-Gg: AR+sD13nYVl0XXU9JyVhRWpxagaiflshTkxL0/1XWE2eAvpJIUDWIdbRe0E9QlucwVT
	EXnz0LvVPbIV2hIA7+4I1i2ylTfeHz43jRdOX5miQVftgyrWtHDwn9nVgnolG03R0CjZi57Ca6Y
	s+RgtJjigPFFakxxcsmLI1XFjwuw5xiqzIzgYaxHvczFPzoFL47e0vCwb1O8at4UMZzFTXJEa9a
	29SlfdhZl+jPjuKuvcy+gw7C6JpDv0jrC+C5odKLlE8YNPawYNSxAYTn4OR5sHHUHzlDO1FghGe
	BwSMdXiwDQEx9cOZOGNHPHlUYBLhlwTd9WytSmeF9C3OS+eVi9va+PMqKi7sf8l/pEMoNyl/x39
	+S1xP+rwOo6r36A9nobIb2WV/G55bYYTuceTm/ei1tJawFUjcA2NiwkdvAFQIR6K31POlybc24x
	ITSnQfgw3wozU=
X-Received: by 2002:ac8:5845:0:b0:517:642c:8196 with SMTP id d75a77b69052e-529a8314fb1mr98190771cf.12.1785177920823;
        Mon, 27 Jul 2026 11:45:20 -0700 (PDT)
Received: from [172.17.0.2] ([145.132.101.187])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907e85241dbsm71096056d6.5.2026.07.27.11.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 11:45:20 -0700 (PDT)
Message-ID: <6a67a740.c2d14791.32ae87.089d@mx.google.com>
Date: Mon, 27 Jul 2026 11:45:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4428811579025573649=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, enjou1224z@gmail.com
Subject: RE: Bluetooth: msft: fix vendor event use-after-free during open
In-Reply-To: <0e31ed963082a6fdabbbb10b913d35d6be5e7a19.1784880004.git.edragain@163.com>
References: <0e31ed963082a6fdabbbb10b913d35d6be5e7a19.1784880004.git.edragain@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4428811579025573649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1135312

---Test result---

Test Summary:
CheckPatch                    FAIL      0.78 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.31 seconds
CheckAllWarning               PASS      28.26 seconds
CheckSparse                   PASS      27.48 seconds
BuildKernel32                 PASS      24.73 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      464.65 seconds
TestRunner_l2cap-tester       PASS      59.11 seconds
TestRunner_iso-tester         FAIL      93.02 seconds
TestRunner_bnep-tester        PASS      19.13 seconds
TestRunner_mgmt-tester        FAIL      224.78 seconds
TestRunner_rfcomm-tester      PASS      25.80 seconds
TestRunner_sco-tester         PASS      30.98 seconds
TestRunner_ioctl-tester       PASS      26.46 seconds
TestRunner_mesh-tester        FAIL      25.97 seconds
TestRunner_smp-tester         PASS      23.00 seconds
TestRunner_userchan-tester    PASS      20.50 seconds
TestRunner_6lowpan-tester     PASS      23.69 seconds
IncrementalBuild              PASS      25.21 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[1/1] Bluetooth: msft: fix vendor event use-after-free during open
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#134: 
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:GPT-5.4

total: 0 errors, 1 warnings, 0 checks, 139 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14713461.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


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
ISO Disconnect - Success                             Timed out    1.848 seconds
ISO Reconnect - Success                              Timed out    1.990 seconds
ISO Reconnect Send and Receive #16 - Success         Timed out    1.994 seconds
ISO Reconnect AC 6(i) - Success                      Timed out    2.655 seconds
ISO Reconnect AC 6(ii) - Success                     Timed out    2.006 seconds
ISO Broadcaster Reconnect - Success                  Timed out    1.949 seconds
ISO Broadcaster Receiver Defer Reconnect - Success   Timed out    2.410 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.249 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.804 seconds
Mesh - Send cancel - 2                               Timed out    1.987 seconds


https://github.com/bluez/bluetooth-next/pull/501

---
Regards,
Linux Bluetooth


--===============4428811579025573649==--
