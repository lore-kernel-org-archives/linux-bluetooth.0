Received: from mail-dy2-f36.google.com (mail-dy2-f36.google.com [74.125.229.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42B2426429
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 10:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790332665; cv=none; b=Tz2UgcdsTVsD22tcyoIM+npdre+PqegoFB00Sa+Fb0mqyGXbdSr4VobVVWWxI+thmZ/luwTURnv90COhNWyOcFbxN/U/JBRDYO8kyoB2VYkufpGOsXIyUT/vqX9HEtLydy78HWRrLt4Rq7vjG8WmAeS6J/vMnx7J/CTh0BnC8JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790332665; c=relaxed/simple;
	bh=xLp+aqvCstuJOViWWw849CP06ppbKOcTfp6QTn/dSb8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iRSqpvr6qwySCX5tE0kxfy44+uU76poySX9SS9Wldw1fg5pSfdKgHAmQL3pFYUJPVSDCgiwdW0talF8ELIqkfHj5nOrvqB5sHrqRt4K1oCcCyxmSjekSP9U8svkyKWP4DBGavMVnxkQxabVtcWMmDB+c/gJhm+Ar5UIlLsi7BPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvEKfuiO; arc=none smtp.client-ip=74.125.229.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvEKfuiO"
Received: by mail-dy2-f36.google.com with SMTP id 5a478bee46e88-328664c2da6so446762eec.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 03:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790332663; x=1790937463; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HUXGlfBMszig84KhYGCxFk7u7jKO5Uc68ttZyiJ3lGM=;
        b=SvEKfuiOmxEgXtL1r24IHqm/hZLmwXzEFDaNgxm68iNRx8N+VjCh9R/znuEopCA4w3
         jJUcrqshOCQO20QAczxLjlm/v2QnmSjt8qPOww9CtOhYQMGFyQD2aKaB6WOLL0GZjymg
         DllKiWqYtDGbEX5T6T0aKE3ZE2H3YkwVbjHlaqr6BPOKTod2gScPPIEPotJetN+dUH6V
         VRdGA9FPcnTrGVYcEV/z10ZF7dnvVnA0M/iQ9ObQJM7iAmPmBOdv2dHz9KIcQvDmb1Mw
         JdbHUn/kRF1o+bDIbitGy1QKn8EzEb6zLaiyzzfAeT8ocyqr6fQ4FNNZQhP5J/MSuwu7
         /GjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790332663; x=1790937463;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HUXGlfBMszig84KhYGCxFk7u7jKO5Uc68ttZyiJ3lGM=;
        b=vMeKzahxIvJ/sRd/jCpLDCtDjwBUUdEGE1+bK1+HdtuElD2K84TAuthNs5Amfty+Hn
         XfibZSEVGQFCeLtqAPjGvreHhvzpX5Q9hGNSHOea1Iz403jBwmcWJX95rgjbHGnI7qDD
         cqcTK31yIDWQEmiWfcQnElpuuIrEyqzkDgJakDr1Uy4nwNlsD5NAuwvs0bmozjqlQye3
         d4yeGHkVGuntd9APEuuyXVXrUyVc1AcAmp2ONUHAc5qDshFRhJbUOrr0FG3d0jwHPRwa
         wOdtff1HC2rfXQpJPTG8YX5evFia2ExG0nuQHYM0oojnRdEMQOc8zzuI+1EoDejG/OMV
         I0ZQ==
X-Gm-Message-State: AFuF++kZoxcbuSZKnHAFzkrUPepMjoR29ZZ/6PrIJJdcrYi1G2x7HCS3
	GlgNRE0rbNPAIeSTITmg5BglBzreWfvcWkEV1giVV9oWGKZZqs7WDsIYoSBCxSJc
X-Gm-Gg: AYBFou2KKk59BI0l/RHnDU1QDG3Wb5NGf/IdK5FP0+w27D6ZY/MtPbsyTuFhcuQVnMW
	LrNjhqz5TST1jhlGY4NqGfVOY2qjat+I9xmbxvBws1yZLuYW0NJCWSSE3Fd7rjOQE0H9gn8YJ2y
	Mm5J0A8q8JFJV9uXV+hLPlU+gLMSft6VzoaeRs/du7DtBswZ10wReB83DsoY3t4PdU/ofecX4Lt
	aWIy2zb5z+/EzdpNbT3gjE5HlWDbX9qPXruJ6UmSVJe4gLjjLOopRmaIORCrHupAt5XREae7ngk
	pr3mun97AW8dwoCRvcxHy6DxhvsZB/gbs9qLryDfTC4qdqCWl//l0DqC8iE9Upl6/ztOLJYmK1b
	asM1ikem/0nKR3wvmXy49w9IGviMK1xpkkM9y85TY3VI1E/8jlaGKNX8qRQPLLGRIsYnEICUzio
	FlWLqhhttdC2unvO6GOFnb7d5XqX+BUaIOq/FPvpbS0mdmXW92REIZj1diAel7+b9jO0ZVSXWcU
	E3J4l3h7OeYU+s=
X-Received: by 2002:a05:7300:1698:b0:33c:20d5:b7e1 with SMTP id 5a478bee46e88-34006678286mr4604601eec.33.1790332661934;
        Fri, 25 Sep 2026 03:37:41 -0700 (PDT)
Received: from [172.17.0.2] ([134.33.77.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144757263sm5422461eec.12.2026.09.25.03.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 03:37:41 -0700 (PDT)
Message-ID: <6ab64ef5.f1ca736d.ef258.94ce@mx.google.com>
Date: Fri, 25 Sep 2026 03:37:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0365509019163387351=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yepuri.siddu@oss.qualcomm.com
Subject: RE: Bluetooth: hci_qca: Add WCN clock enable/disable support for Shikra
In-Reply-To: <20260925-bt-wcn-clk-enable-v1-1-30bee88c4de4@oss.qualcomm.com>
References: <20260925-bt-wcn-clk-enable-v1-1-30bee88c4de4@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0365509019163387351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1173556/

---Test result---

Test Summary:
CheckPatch                    PASS      1.21 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.55 seconds
SubjectPrefix                 FAIL      0.18 seconds
BuildKernel                   PASS      21.60 seconds
CheckAllWarning               PASS      25.10 seconds
CheckSparse                   PASS      27.97 seconds
BuildKernel32                 PASS      23.10 seconds
CheckKernelLLVM               PASS      24.61 seconds
TestRunnerSetup               PASS      583.29 seconds
TestRunner_l2cap-tester       PASS      18.41 seconds
TestRunner_iso-tester         PASS      29.72 seconds
TestRunner_bnep-tester        PASS      2.87 seconds
TestRunner_mgmt-tester        PASS      56.98 seconds
TestRunner_rfcomm-tester      PASS      4.41 seconds
TestRunner_sco-tester         PASS      7.12 seconds
TestRunner_ioctl-tester       PASS      4.24 seconds
TestRunner_mesh-tester        FAIL      7.66 seconds
TestRunner_smp-tester         PASS      7.08 seconds
TestRunner_userchan-tester    PASS      2.95 seconds
TestRunner_6lowpan-tester     PASS      4.03 seconds
IncrementalBuild              PASS      23.71 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.619 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds


https://github.com/bluez/bluetooth-next/pull/818

---
Regards,
Linux Bluetooth


--===============0365509019163387351==--
