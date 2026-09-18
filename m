Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550884B404D
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742701; cv=none; b=A1FVY0uLV6fV+Nl8ESildJLzaBb8CcKitwFIcCm7wDEFcyBhttz07yP5023SkHr8nW1w/JJL5MNUXYwW+oYU/z0mzpDW+9d+i5Y90S/OrCMmHSRxXkGzxIvlrpXGcO3Rs7i3274+1/SFc2yXNPOcEjBfMMVlimvJu8w90ddc1ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742701; c=relaxed/simple;
	bh=oyrPGjJqY4vrWfpkJ3Xm5qxR592VZs7XJR9N35j3tz4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hEbxvLSaEkPp5QAFO7KJUlUOIIYASDhKGHtE225v5WTHO11H6kkJtGopsxunrgmtENc6vgBPrbcE045qD3eX3LuiLXjNUSrm8ACXYa/ElRLULZ1Xyh8wYH6nqSvnXyADCJjwZyp5MpFAqDaJixHodbbjoFx8W0rEQNYmvJHKCgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxstWlGd; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxstWlGd"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c3b639adbcso672580b6e.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 07:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789742699; x=1790347499; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VQLxUrtcAM/7CGZVqCE7Md2Kj7WyTya6jEfn//04PfQ=;
        b=KxstWlGdtBv1tylBHFpF5idSBIqje7Fzacf3WPN1f6Qxztq+uk4U8bfSfV+o8Y8c/c
         S5FeAvUG9R0Wi+7bCxT/6sS6kahDJQWQkXq1blqZRNCLACTQMoHmkwobYQc03iWyhkD5
         hLs9Sx5Q17ntuCzBPW3axD1hVoP77WAcCh5NBUhJ9vyybWtU/DFPOiptlovtH9zamwcT
         o8VgI6z/aUQhzOaSTkjhS3jUCRupxAgmB39JWXWskX31IPfdFDHYQeoyc+/sPyXhvRrY
         BFy3JanDJJ5uQSpBbyjWg5JezF68n2Gm9zmVFzipqxXQq8+1cxA8b9lRNLa0kuInKhuz
         VEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789742699; x=1790347499;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VQLxUrtcAM/7CGZVqCE7Md2Kj7WyTya6jEfn//04PfQ=;
        b=b5OhIi7gAnOsj/var6WQ76un866qzMXVCSwebVs4NaShB3eKGaRsBEKOEgsHtV7dE8
         d7srcnmaZyziSV1ZZxCnQYLraI/iGDimbG1rFJRacUiRunn8YJjZ7vDFnRXuKQcHzzGo
         Ly2gvEASjin4HrYcf9l5YzpuX1Scw9qipOjpoFGK766h2ns3RqopAvMwf5gUfcXJ/otf
         zzq2o+7hbEeHTl3NZLdQeZZyNk7L+Ci28aUaai8xPKG78MOROQrU37CUeGHiCE/wki0e
         WrfYGi5UsasXTRa0wxab9jlZAnxbtJDFfnK76qoiJsxES0yWq4rnQRjSttSoQ6I3nIR+
         IIqQ==
X-Gm-Message-State: AFuF++k5O8Bx2oQTnUCiFc4EaHcaAI3LRGDu8xPT918xOVQIKSoO3DGk
	CQp+0ti+iiqWS9/0QDzLfIC7EkmPO5BerhtJyvkCrjEnjNy6l/OUt5EwCujvlg==
X-Gm-Gg: AYBFou2KSLzxfrfinMOdeDwDhSinpj71kqgmLGM8XNfq7m11WzGIOwpRPWmVNtkkMoG
	3/GCttMZwfKy3rCfaosm/Dxnl/Bo3dW3BvKIRmx0FjhzFkF+no/pqGMUxUH+1SeoYzW2xkFQoKw
	EZR3iHTD/V7+L5TAYru8fnI0sbNXlPRghv0IpgBdM0OYeZMQicvuGa/gKogw8t0kgh9YDOSFmql
	sUJgf5FpY00YexFmoziSWL/xbXuJtRaIF5bpLP6zdPoxRJ9y7Vi45N3zf1EWHUo6HjkzAbNEX88
	Xa+951mJ3ApSN3WS+64mVQso0bhNSC8DbkhG6DT/PlF2wpNLCItMOCH3lE0SG2b0ekh2AfdP2la
	tcxJliqspROF9ILSGvYJO7IJko/FhyXgTL6QMidZdimI9raC9Pkne6dd0PEZg99w53SHsyrmik9
	xtfN3uOjCyOXn0d5Am8ltCC629RBIHX7vWub6sEop9FbnNYo07TL5xL10JTnoLzHFZ5U1iI3Y04
	8mTn/Q=
X-Received: by 2002:a05:6808:c29b:b0:4c1:e5cf:da40 with SMTP id 5614622812f47-4ccf729fdaamr3608270b6e.12.1789742699189;
        Fri, 18 Sep 2026 07:44:59 -0700 (PDT)
Received: from [172.17.0.2] ([135.119.38.220])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4cd6ab7d9d3sm1232676b6e.18.2026.09.18.07.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:44:57 -0700 (PDT)
Message-ID: <6aad4e69.2fe18630.2e9149.8b3f@mx.google.com>
Date: Fri, 18 Sep 2026 07:44:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7075868224179722675=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, valentin.kindschi@fiveco.ch
Subject: RE: [v5,1/2] Bluetooth: hci_sync: re-enable legacy advertising on resume
In-Reply-To: <20260918110358.3863635-1-valentin.kindschi@fiveco.ch>
References: <20260918110358.3863635-1-valentin.kindschi@fiveco.ch>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7075868224179722675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1168573/

---Test result---

Test Summary:
CheckPatch                    PASS      1.23 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       FAIL      0.57 seconds
SubjectPrefix                 PASS      0.21 seconds
BuildKernel                   PASS      25.25 seconds
CheckAllWarning               PASS      31.29 seconds
CheckSparse                   PASS      30.37 seconds
BuildKernel32                 PASS      25.23 seconds
CheckKernelLLVM               PASS      29.88 seconds
TestRunnerSetup               PASS      621.61 seconds
TestRunner_l2cap-tester       FAIL      17.20 seconds
TestRunner_iso-tester         PASS      25.84 seconds
TestRunner_bnep-tester        PASS      2.82 seconds
TestRunner_mgmt-tester        FAIL      57.60 seconds
TestRunner_rfcomm-tester      PASS      4.05 seconds
TestRunner_sco-tester         PASS      7.19 seconds
TestRunner_ioctl-tester       PASS      5.64 seconds
TestRunner_mesh-tester        FAIL      9.10 seconds
TestRunner_smp-tester         PASS      4.01 seconds
TestRunner_userchan-tester    PASS      3.61 seconds
TestRunner_6lowpan-tester     PASS      13.41 seconds
IncrementalBuild              PASS      29.35 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v5,2/2] Bluetooth: hci_sync: pause advertising for the scan address update

82: B1 Line exceeds max length (101>80): "Cc: stable@vger.kernel.org # depends on "Bluetooth: hci_sync: re-enable legacy advertising on resume""
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 111, Passed: 109 (98.2%), Failed: 2, Not Run: 0

Failed Test Cases
L2CAP LE Client, Direct Advertising - Success        Failed       2.018 seconds
L2CAP Ext-Flowctl Client, Direct Advertising - Success Failed       2.046 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.019 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.601 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds


https://github.com/bluez/bluetooth-next/pull/792

---
Regards,
Linux Bluetooth


--===============7075868224179722675==--
