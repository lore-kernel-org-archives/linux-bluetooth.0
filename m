Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D5A1E04B5
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Feb 2025 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739187006; cv=none; b=uUyFdoJU+ql5NXAXpSJz1JO4hAjZm8nLNbFE2RA0CECPXH0TI1X3psZGhqgTuXzsC+2ZqxVYmBCX4jeR35un6J53gB105IqB6nKUulgPVdD4WLsSSG1x0FYiP/DS1TYJIv973J8YKdboy6AzmKTNOyHxakV/ZGGLApaw2mv98j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739187006; c=relaxed/simple;
	bh=m+sJpQGy7VGURdSSGRGGe4pQFVSPDLOoGIMi+FU6V58=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jrBHIABZzdYLcvVgMy4hRAy3vATcHNhG4RslJ9ZEhRnYjgN+uSfjj8M9gC2pLE1YBvu3h4GD1juVAkHwdLEO5w2yzJRlGGm65wxhFaTOc2nspP+1qSyw2fDjsEDtXUBmB/1eTVtoGeVJ+yxRikP2m0Jr/FWehV4YrhqqSWH+7fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRFPMMZ/; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRFPMMZ/"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c050c6e201so169197085a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Feb 2025 03:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739187003; x=1739791803; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VgLDl8SUWTBmhh29zOdN1gp0Zu3BPGkSjqBFWScfem4=;
        b=BRFPMMZ/oKWabToFdcde1xVGxcYOg1KHF5mLP0xkbucKYW/yJGet1MIZeDits7UyBo
         4+saHfz99S3z7iU7/4jADlD8fFYRUPDjzUh56bbtS4Bp3RNhIShUh4/sokYw+UBXpD4v
         C8+OUZ4Jxzc8qs4h6pTv3hB7uBzlqVV7eO2IdCfDJp34x94vLD4tG+TwFO926Kclo8qw
         VAvFmIvVY4lZ/NsXiUHHhNXH0twsNdq8EKBD45k3fpq1WoPULN4FjhH54QWtVNyHmpKa
         Oy1gBB3qlMZkFI4+y3CVwgW3LkLcA4s5owx6Skvkb/euV1jnjXdoiYpeoJ9ixfHtxOdp
         dE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739187003; x=1739791803;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VgLDl8SUWTBmhh29zOdN1gp0Zu3BPGkSjqBFWScfem4=;
        b=MVYB2uPBtOKOsEQRqfXxxW3t+Z0SHu3UPbtudRjDC53LMAP65QO1fU0SFQrOdC/Khl
         8ZSwlr6cFKzHFKw0FVfxAzGhVV+Pr0fiR02rORo+4DvoPgshMul6B0bFXoHEzTc9Wsul
         433zJmrnIsshCBtYQORk92QWhEZLipmiyS45iq5+G+x7wBc9wi18MFITZi51CKFp9qQz
         BepOFcQpkp6zjuFSgSy9oUbCXk9kFVRUNNv08M15N6v5mDUAhvIemEayd8YZtxs/e8ZD
         LrXNgvhl3/2NF/Zgnu0C+HjWzzx8bZBx1184WnpGYpZn2xLP837hRx/hndo41/QF3z1S
         antA==
X-Gm-Message-State: AOJu0YyS0KMkNZi0Dx7pTl93mM0jHNQ6abFOq3nJCC/clZNdnd/o03wv
	KJWi1d+DNeoTtDfiPgQ2bBnLWmrKgFYUBVXX2RdX3fjbN2I1fAc8lNXboQ66
X-Gm-Gg: ASbGncsfdEuFMHnF5KafuspLQvYhqHP884jM6k3car/w3ujV4LGEsXs0kTS1rtsjQT9
	vWCWPqgikVKe0xOEQrIHIpa27VE0YqWvlz3j9PAt58QNmZyv58QLKFd0b4sSIoK7IlbmXfdZcyq
	tFICh2dP29Xcj1hAX2AguJOh4UHfsUJIiODwGu11T2PW5cmbUJrhiWRW0TgrVr3YNDRD0GOZoty
	fYVcKarkVbNlKXx+UX1fPTUerTY6V1fnHFa1OKevZdCevT/xfK1nP8OXxJ1Db8rtw5kfkJxa5BB
	4uWxC+zoaBF0OGlM7LuYIXw=
X-Google-Smtp-Source: AGHT+IGlOhlOKyyCIvQM+kKfvW6mHLNyGlm11AfUq7bNanoa8KrxHdmKnMg3Q1sMoS+nP9TiMr/ZqA==
X-Received: by 2002:ad4:5fca:0:b0:6d8:a5da:3aba with SMTP id 6a1803df08f44-6e44566e7d3mr206688116d6.20.1739187003010;
        Mon, 10 Feb 2025 03:30:03 -0800 (PST)
Received: from [172.17.0.2] ([172.183.159.78])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43ba36d5csm46067676d6.26.2025.02.10.03.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 03:30:02 -0800 (PST)
Message-ID: <67a9e33a.d40a0220.e65b5.0145@mx.google.com>
Date: Mon, 10 Feb 2025 03:30:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2379238916398756154=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chharry@google.com
Subject: RE: [v3,1/3] Bluetooth: Fix possible race with userspace of sysfs isoc_alt
In-Reply-To: <20250210183224.v3.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
References: <20250210183224.v3.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2379238916398756154==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=932199

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.22 seconds
SubjectPrefix                 PASS      0.30 seconds
BuildKernel                   PASS      24.44 seconds
CheckAllWarning               PASS      27.12 seconds
CheckSparse                   PASS      30.71 seconds
BuildKernel32                 PASS      25.79 seconds
TestRunnerSetup               PASS      429.06 seconds
TestRunner_l2cap-tester       PASS      22.94 seconds
TestRunner_iso-tester         PASS      36.55 seconds
TestRunner_bnep-tester        PASS      5.29 seconds
TestRunner_mgmt-tester        FAIL      117.94 seconds
TestRunner_rfcomm-tester      PASS      7.83 seconds
TestRunner_sco-tester         PASS      9.66 seconds
TestRunner_ioctl-tester       PASS      8.38 seconds
TestRunner_mesh-tester        PASS      6.26 seconds
TestRunner_smp-tester         PASS      7.23 seconds
TestRunner_userchan-tester    PASS      5.25 seconds
IncrementalBuild              PENDING   0.89 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.136 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2379238916398756154==--
