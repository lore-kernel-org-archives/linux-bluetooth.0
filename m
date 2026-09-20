Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882B23E2771
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2026 07:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789890305; cv=none; b=SdiU8JwOgxCWd/wsFzu/XJ1PFvWrQZB9VCtobL7vntbLn8lz8KvActF6kfwy2IK9gj7WS5F+MN4xMc/wnFYykevP+IHtMoSAvdSG8ehCTWAzLr8LFo3josy6OLikQFMLZ3vK7WQnTLGnp7t0Uu4FdRykOl6bEAREZ086CxMXfJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789890305; c=relaxed/simple;
	bh=QjvBRdGqEc7aZ3+RdS0aNYOFsHaagB62HOrv+GSwBfg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CHAmBIhs3eL9JKAxFsND3CAb3vTMhtvHorhEzdIbRJRlt792yBrFxILwvsTR32UETyB49neYNS41AagLxu+MrVJDjIdBts7AGHFKLrLI3besLnuCRPSQsKm3K8kMYJTs1QN113DVNBrnLydcNosxRS4+3MLJ92yzJIrY1Ovvmgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gg4AqktR; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gg4AqktR"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-46dae65dc5cso1032883fac.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2026 00:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789890302; x=1790495102; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=O/bhDnnu1bpg3Q2esPQsgp9Nhh3CunXEjdC3m5O8DY8=;
        b=gg4AqktRZLIG+BSAvMnmHqTJaQYqYAKem4FLfEvtKgNvn/m3uJn+T2u0+8bhOMdoCy
         v4v2mH2kouwY2+cQ/7L6/qUzkOIDInaWu5I0Q0uYd5rcvnhsvOdtB37bpF0PfoDPiUSv
         VY/BiW+vSY5IxMDatypNW7pets8gg2OF8/v5nNDzFMgCPR2nY3o+hzErpofKxcC1Uy9z
         bK1SiCp0Mr0cESQPhga4jUgQCddZEIuUxNnzuaDs4C+2FfkBed7PigSdaWVaLVVGOLhn
         8XLP+93NHZaI7rmjbT0985hF/QdGoKIRc3C/Wxf2d8ebsIuqrQULhxdckYBRZBWoe8zw
         FhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789890302; x=1790495102;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=O/bhDnnu1bpg3Q2esPQsgp9Nhh3CunXEjdC3m5O8DY8=;
        b=k4ogCFZlmn189KCi6UOV9PxNXeGRFFfD+sQEmBFzwztUVvPhmaLDqJ9t0nDsarXRXS
         2eHLUx1TjxOPD9VcXH4I2Bab/i4fXP7RiSGdteu5LWdVw7G3/LeQwGcMBQOZMpckRjRl
         azGFEAO2+YdWLoKxRCJfvuPFGUb8O7eeUhQFEznriUbH5Bd8n/fEbzAIqtL2+1vchOZP
         pwdKVrYbo9dT9JVTzcXYg4/Zj0+Krj3P0D+Y6StXGYzklPWLJqSTDxtbppUrezwySXBs
         R9orCdaEnIjMBKutg4VYQd7Uhp1Nx9PUWGVfXKXiIl5k6IiwvasT0WXUexW5fhdo3II+
         2AyA==
X-Gm-Message-State: AFuF++lLpBPwTHvJPuZAjrtL4LsdhuSJ8wSP1scZpWlAhGySoHvSzgzZ
	3CvBXrBUTtfSN3OzNiRAXcki4KUSI03Tt7RnoVA+5QTj9ExI6HZ3+pmWkItfWnEb
X-Gm-Gg: AYBFou0WmnXtgwl6gd0zfkD2jZ4Uja9D/fAok1akXHWDpcy/4qzWEbYZMPKKl7AV6UO
	g+Ula5+33JGbmzKi3oXBQTerTns3tYIwVWj8HM6uiwWrhB0K+BA1zIkEVb4oXsXxyuzOyfN0cuP
	nb44a9NbdGkXepzJdsy3/9Mg/mnkYwWlF14sEIH0Fn5/bONlM5IdVngPa3ii5f3/fAGUkMb4bh9
	yEhyQ4WnhqgAjijXbrW7IexsaiwtdJuPU7Pds9t/68K7W2VEF9i4MWe/dlV0IXDEv3vDi06vuS/
	A+jLUNwSjAGIV831qQ86sxnlPh/aGME4Ec6xHC5R+Zk/WSKa2F1MgcZXBQ9vacUmoWM5v0AkZ3l
	9epPVRolhW60PzTJ8AjYIVWu89Z5suWM01R/9X1m3t3gbDbqR7uhzP7a+bkH3YzIkZ4vp04+gvm
	+6Ai9J5oUq7DwLfiF7yPF8lnwHG2g5VJDwLX1r4OZ2WFljG23F3lEWkvIfo3wEPf3j+xj2QcmSS
	0qoEnazA2f0faRgaQ==
X-Received: by 2002:a05:6820:151f:b0:6be:1c91:ca1c with SMTP id 006d021491bc7-6ca9a547b84mr6727669eaf.11.1789890302281;
        Sun, 20 Sep 2026 00:45:02 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.134.226])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6cd35712c0csm5333917eaf.11.2026.09.20.00.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 00:45:01 -0700 (PDT)
Message-ID: <6aaf8efd.0c0d0188.18e251.f7c1@mx.google.com>
Date: Sun, 20 Sep 2026 00:45:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8853559124693609916=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, peng.fan@oss.nxp.com
Subject: RE: Bluetooth: use assign_bit() where applicable
In-Reply-To: <20260920022610.3145618-1-peng.fan@oss.nxp.com>
References: <20260920022610.3145618-1-peng.fan@oss.nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8853559124693609916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1169531/

---Test result---

Test Summary:
CheckPatch                    PASS      1.83 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      29.31 seconds
CheckAllWarning               PASS      43.45 seconds
CheckSparse                   WARNING   35.70 seconds
BuildKernel32                 PASS      29.14 seconds
CheckKernelLLVM               PASS      33.13 seconds
TestRunnerSetup               PASS      795.36 seconds
TestRunner_l2cap-tester       PASS      16.61 seconds
TestRunner_iso-tester         PASS      28.88 seconds
TestRunner_bnep-tester        PASS      3.13 seconds
TestRunner_mgmt-tester        FAIL      61.30 seconds
TestRunner_rfcomm-tester      PASS      4.49 seconds
TestRunner_sco-tester         PASS      8.00 seconds
TestRunner_ioctl-tester       PASS      4.66 seconds
TestRunner_mesh-tester        FAIL      7.82 seconds
TestRunner_smp-tester         PASS      4.31 seconds
TestRunner_userchan-tester    PASS      3.63 seconds
TestRunner_6lowpan-tester     PASS      4.39 seconds
IncrementalBuild              PASS      27.08 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:151:35: warning: array of flexible structures
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.021 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.401 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds


https://github.com/bluez/bluetooth-next/pull/803

---
Regards,
Linux Bluetooth


--===============8853559124693609916==--
