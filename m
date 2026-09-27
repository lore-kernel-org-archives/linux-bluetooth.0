Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61283CF047
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Sep 2026 23:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790551597; cv=none; b=OWzmYC7HMSBfZe8JB6EHknuUamgB7j960SY9/uj6CDdccI/hdAgkClr/dK+W30BoS+sVf/opIAwwDjQo+HsXSpDdULE8R7a/Iy4TVl1IeRhtgh+PSOp0ZeDBJRnJja2T4YcbSnIxWik83ipREY2Cc0J47ydk1ePmjMEQ/oqQ2FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790551597; c=relaxed/simple;
	bh=mvc0nXbFDdhfgcuP3jgNOzL4bk/CZA7m3dftdLK4sv8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=s8VVJ3w5riGKtDmQnN2WtYWSqf4i30a1c/B32vPfgib+5OfzVt8fECzzQaCfmApiBPcy7CW35WLd7BzawJgUDYXFTHb/670zsagsiuhM0iNa6KXlygvrQlEM8JR2hWlXzdZDjk4JEdXzwmK+yR0cgO0jcJ7ySAiJZRzcf/9qaFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgTJf5ue; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgTJf5ue"
Received: by mail-qk2-f41.google.com with SMTP id af79cd13be357-93bfa7b2093so286523885a.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Sep 2026 16:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790551595; x=1791156395; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=N5nFYZo33AbgN4SgjZC6hGkfnHV1uYYnz4sNDrVbFbk=;
        b=hgTJf5ueZqpiL/Yqc++sqpCPbKQyZVwzGgB8ZTkTqKHt8jVPaQW3F1ZvlehV8QTttW
         lFCuj3eOLpGH71OaDCUzZWDFW8S+7DMRUPBtQHU+k5XkQKLcyNe7IhcSnRNOi7MH6ERj
         6BYB0tprZLgaY3L1QXo3RnTkO9k/FoZSs2S/DcQxVh03pQTwlMs6+M0gC7vmlIGBuS/0
         uC0dZat7bwQF8Nt5HPUzsYr3Dstw5rT3ZT+8ptDxBx7G3a2wCD7qk57vPCHmaYqhLMp0
         OEXPnnwww99ugfJFw7V2dtxkk7lENdA/XyW6ngbqWatVlTXQzx5MmRbpUFKbAbHfsLuw
         AWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790551595; x=1791156395;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N5nFYZo33AbgN4SgjZC6hGkfnHV1uYYnz4sNDrVbFbk=;
        b=0qKdoDQsicjAweTAh4XA8m+hEQouldzyh2AqLBZGnn0/RXKBUh1ALwUbFYcHiDDqiu
         lUHBpEtCydSkJtLG6o720WrWMghs2avmw9BMK0XfZb5B/6bJar5r58bydKmtJd+Pttd+
         T6o63Lj8+AApzW1/kgHn2X1yrR9+e2AoeKIyrmEHf4+O36hZQX9qOSzdQX19eRyYh2HC
         yyWPfHDES9vA5iotMzdSaN6WJ/2+bZxMame7zoxLMkVrZYLqw8C787E26lHAh7zm5F0s
         7pcBJqEe4G5gGAW/OCXNKFTHK/krrLSm3zmV3qI5dWmY+3YIql/8WRMUJdf1KuoSE8yH
         N7ng==
X-Gm-Message-State: AFuF++kLwf1r12K532Mu9Vva9+Z+J8+5kTDBP+HNRLYvh9AEyVBmSE8m
	1YsaQBAQ/r6mLI5w7M9hycwIvbf+0rossAG/kDsogzj7mMCFyP68k331jJZ7PQ==
X-Gm-Gg: AYBFou0XkGFyPbgy+xSDn2RFZhYITXXZ4tCK/DCymfgAuZ6ibHmOTnVOLHA7C4BtMcV
	zpWtMa9UrBQDLHNE/gy/LkMQHv6mClPFPdD7m0gwabXVxspfPcT/mP9zdwwa8hXZOUUwdmozLcq
	jW74r7XBL6+HyO4V85flHe1/DRYuXLQJs7uOy80inK8l9hFnMZatcn0E1oHxMBOdmaRA0FvkaPV
	6MDofRgTjk+w4iMC/Jp1X9Qiz0QeQnWLlduMMLIKn56slU0auK0Qjz3/WoiYWI85fuFUnadlLap
	ZxC+x0UArSPh+AAyHZBb5DH4fC1AknoyumRgMYtf3Sp9hwL1fCEoXtenf2D+UzTxhnXvMuOsji4
	tpw6v/WlRTfFkcI7Qk8CyEfdOr0mifwpIlhV/fP9O9qzpbZyCLwR+0B+Z8EmS+Mtbfn8ENSnwFO
	tOEbo9Qa0LK/uro1d9x1v/+s4286AD3r1la/3WuNqKYnl5Z6nDpsbtV5Xs28qVAK9Ts/uqZ044W
	md3TA==
X-Received: by 2002:a05:620a:c41:b0:93b:c537:fdb8 with SMTP id af79cd13be357-93c43c2f594mr1706343385a.6.1790551594708;
        Sun, 27 Sep 2026 16:26:34 -0700 (PDT)
Received: from [172.17.0.2] ([20.115.94.230])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c8146a237sm8178485a.36.2026.09.27.16.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 16:26:33 -0700 (PDT)
Message-ID: <6ab9a629.23e3e633.f64ee.2913@mx.google.com>
Date: Sun, 27 Sep 2026 16:26:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2576990320671873406=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nicoyip.dev@gmail.com
Subject: RE: Bluetooth: hci_core: Serialize fragmented ISO packet queueing
In-Reply-To: <20260926172935.2423925-1-nicoyip.dev@gmail.com>
References: <20260926172935.2423925-1-nicoyip.dev@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2576990320671873406==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1174572/

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      30.02 seconds
CheckAllWarning               PASS      33.78 seconds
CheckSparse                   PASS      35.76 seconds
BuildKernel32                 PASS      28.90 seconds
CheckKernelLLVM               PASS      32.81 seconds
TestRunnerSetup               PASS      790.39 seconds
TestRunner_l2cap-tester       PASS      16.60 seconds
TestRunner_iso-tester         PASS      30.86 seconds
TestRunner_bnep-tester        PASS      3.14 seconds
TestRunner_mgmt-tester        PASS      61.02 seconds
TestRunner_rfcomm-tester      PASS      4.49 seconds
TestRunner_sco-tester         PASS      7.64 seconds
TestRunner_ioctl-tester       PASS      4.66 seconds
TestRunner_mesh-tester        FAIL      7.85 seconds
TestRunner_smp-tester         PASS      4.32 seconds
TestRunner_userchan-tester    PASS      3.22 seconds
TestRunner_6lowpan-tester     PASS      4.39 seconds
IncrementalBuild              PASS      27.08 seconds

Details
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.422 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds


https://github.com/bluez/bluetooth-next/pull/826

---
Regards,
Linux Bluetooth


--===============2576990320671873406==--
