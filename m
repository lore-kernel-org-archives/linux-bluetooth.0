Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D5C3BA25F
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787151056; cv=none; b=M4KdVZ+bmdJy9J9dpg7nXOtIs6DVbWCmtiP2SOLpLvjk/0Sz0iLr2o39LXOxEGStQKj6P5wasn8e8BxhjyOP4q83e21QMcnGZs0GTCNN8rk+2LDY1kK+AnlFtagn3+wPspaeUB3kzwgguV6ipnQDHdvpKFDfUcGuWnZCUciH9G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787151056; c=relaxed/simple;
	bh=PAtip0icsG04ct5twASOAmZxO2lttQWVyMJaFBwxkxU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Jqgmqv87tzlAUvARmFsDiRPbYLBBXgrW6iRYl4tT++NTGz/SuN+kdhFjV8yK4CadJ9GNnjVP+JIdhaPWlftqsXeU2OEsErbsEGVSZnsStfZu/y90sCMBH8iyrAlBBpH5kVSl5NZRgJx0oQQ02J9TZOnAvT9DbpGxLpVoC0015Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qQp/kl3i; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQp/kl3i"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6b136c28c46so808384eaf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 07:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787151054; x=1787755854; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CRntI7BEkIs5R8nwt8FY2dPApwj2bHZllX9zUoYLaTw=;
        b=qQp/kl3iU9Gj1TXMed2TZxiLowAlYVkXTKKEu/TQ5eobALYR5HRlOpt5Li99wPVyB+
         RKK3UlGBY9zqLCwUj8lKW/iFvgi6eLqjgOox66mM7XFi3ypIkMOT8DQ3xVBvVGHw26G8
         vn90f2aHUS3lxMPphDgIJ21rbiqbFzaD1Y+u3U8uDmQ1pPAuOZvr3QPjvoAvjOeBs7gG
         19bkfV4q5x5hASAa7d0/YOFIAXbgbMEuJsWvGbczQok+K0Q2Dz6QgtpbV5oFTd6bR2k1
         1vW2a34+gz7nWAjcU03ElMSCqgau7oQk2kd2mk5ELFR5cTCaspjYEXgr0ERbyZqofUy+
         h3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787151054; x=1787755854;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CRntI7BEkIs5R8nwt8FY2dPApwj2bHZllX9zUoYLaTw=;
        b=fGcF9//5YPeSttC8HEoSCX5FsX04LlnqYHvXobrmV8jrFbuDsyRpd6nlpHHRkgRN9U
         Y/c3O+c70DYS39nPxyD9DRJGeUERvQT2FiCL17cEPBK8irw1cUHiVqaCD6+9ZIllK5aS
         Zkw2sEZ+yj8431UwOFr7VzI+TVSPYoF6X6Wvs4fdRzpihQVSJt3GxhM6tmf0u5hfrGK1
         z7CGJiwNfZMwwUHifq7X9mZZRCdCMPERradKnZCAyaEPOU/YJs7WqEMqY01ow03y9yxy
         yD/kxXdwY10f4tWHeJ8ACkQBJP8znfLO3S0rCquvRl+APbx2Y/uxieWkEihmw2RQB6ZK
         cC9A==
X-Gm-Message-State: AOJu0Yw7/sOOHPOV2w7yGEjMxQ7VJ8uwE5VxNn4piptwtK1Sp12wlK3w
	5XMxvQjqLdm4aIVeSWO6LsBu3hoUxIDZhTKVpsISfvBvCOfNObEtv88alAb8+q2F
X-Gm-Gg: AR+sD10AmiU45IAI790c+7xXrbjhRUU/xs+lFDJWtq+4WNe+5me4MS3318UdAiW64An
	A6pLDR7/uLfOp3xNOeP5bKHOkqvbFWM9x+JBH8qxFQjvsGjze9HMVjXxm81D4xGtiHqha1RCfyE
	X4zw6A50k+p2Umx6MQtJjp/aRy1G8pVvdjmEaChVcYjr8ERJiJWSFWjsMQeubkeQFN2JsdW1jAk
	PPvyngGpzhQEIsmhm4blsu0BARwOGIql85AUtjdupOpO6i5hhKGLcK3VpspZKeu8raew/Zed7xx
	+0OqS8r/V7B+vbinmv2UAPCanrCSXOA7tlyCvE4fKG4U9lNeV0cQubyM31IbDUt79IX05X6TLvP
	TydNBwthD24Tb2dA+E2KSsVxsRty5slWvAKe/HJ+RTnNTPUV6UWREPyxI6eqQMY4BgaeCno0o10
	Ul8g7QNWd4SMMBR3Mxe4Ujsc/iGG7tc+/HMhDcOt4j3Ci5XCtFjMmS7sGaqPsKNZpxLRk=
X-Received: by 2002:a05:6820:1509:b0:6b1:3db9:b758 with SMTP id 006d021491bc7-6b13db9b83cmr4479126eaf.9.1787151054003;
        Wed, 19 Aug 2026 07:50:54 -0700 (PDT)
Received: from [172.17.0.2] ([52.190.138.44])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b13cf0673esm2337048eaf.13.2026.08.19.07.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 07:50:53 -0700 (PDT)
Message-ID: <6a85c2cd.92f6587b.23a616.9de9@mx.google.com>
Date: Wed, 19 Aug 2026 07:50:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8502583888522254483=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, xin.chen2@oss.qualcomm.com
Subject: RE: [v1] Bluetooth: hci_core: use skb_get() instead of skb_clone() for req_skb
In-Reply-To: <20260819135321.1444185-1-xin.chen2@oss.qualcomm.com>
References: <20260819135321.1444185-1-xin.chen2@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8502583888522254483==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1148507

---Test result---

Test Summary:
CheckPatch                    FAIL      0.57 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      27.49 seconds
CheckAllWarning               PASS      36.45 seconds
CheckSparse                   PASS      28.82 seconds
BuildKernel32                 PASS      30.75 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      502.50 seconds
TestRunner_l2cap-tester       PASS      65.62 seconds
TestRunner_iso-tester         PASS      92.86 seconds
TestRunner_bnep-tester        PASS      23.15 seconds
TestRunner_mgmt-tester        FAIL      219.44 seconds
TestRunner_rfcomm-tester      PASS      25.53 seconds
TestRunner_sco-tester         PASS      31.94 seconds
TestRunner_ioctl-tester       PASS      26.49 seconds
TestRunner_mesh-tester        FAIL      25.87 seconds
TestRunner_smp-tester         PASS      24.03 seconds
TestRunner_userchan-tester    PASS      20.04 seconds
TestRunner_6lowpan-tester     PASS      23.09 seconds
IncrementalBuild              PASS      25.15 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v1] Bluetooth: hci_core: use skb_get() instead of skb_clone() for req_skb
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#158: 
[1] https://lore.kernel.org/all/20250430111617.1151390-1-quic_cxin@quicinc.com/

total: 0 errors, 1 warnings, 0 checks, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14757472.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


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
Read Exp Feature - Success                           Failed       0.249 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.238 seconds
Mesh - Send cancel - 2                               Timed out    1.986 seconds


https://github.com/bluez/bluetooth-next/pull/618

---
Regards,
Linux Bluetooth


--===============8502583888522254483==--
