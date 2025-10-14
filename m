Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20281E990E
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 03:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760411064; cv=none; b=g5Enbgt55fZf5yHDReHo5813g8dVV9hRxMkQconwkDX1gMGnlZ6NU/Wh87Vz+TIMULMKlXb9EVyNRUTI7xo2BYEXWIGJpyNjSdUd/lpz59YsluYqGAWFS7lHDrQPLMve++ro1NtBElsH2WTNl3wRZ0Q2hnlc1wBZQev5SyTsSsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760411064; c=relaxed/simple;
	bh=2DAU6WIK3hO/JxBlh/PKXRp0ab/A7tZtWDMFJg0s6h8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lOUugi/McS+dkXh7EbHiE0QtkYGbZ40QZybcUfODiVE43vArLJAf82xxjJ5vvVryp5BQmgNiqO8I0T848qQC0qU3QOuSwehNKS67f30WcSgeclxYNMpbwm3gEZPAS5rnEQky0w//fQLKjQ4w49pRCOA/7Qe07jugUAbwDmQhajc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hfl4ywII; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hfl4ywII"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b4ee87cc81eso4249499a12.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 20:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760411062; x=1761015862; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oZqXcxgFS16BzmaauEMENefcauY22++kQDRW2uwYufE=;
        b=Hfl4ywIIfYwKjoMSLyVZ3tQCnQBGhTmrJABw3tylzuEqJlzOfCopDIP1W7Ukx2re8o
         FFka6z/90F8Y+V5p+eyA2+vglPLykXnq4ILYTktx/YGDjbbXU72uNTvE4YUp0JSQl1s+
         wDH8kZ327Mbs+s4R3BAvatbo8cbGn9wT87YCH2/wwEm15nLQInVBnyJSPO6+BQE30NvY
         Oo1uOScqEZ2w2wsPW+nrUA4nC42dZaYVBzC7+MAtOdomSVXiy9wFSdpv1Jbdv+qDRS2d
         reQwDcoha8/mSEUPywGifBdnK4ZMcodjq2Ealzz530j5Ym5uEW7QhjYLiRzC3e7Dy29W
         Vz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760411062; x=1761015862;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oZqXcxgFS16BzmaauEMENefcauY22++kQDRW2uwYufE=;
        b=RLtBn/o57Fw4Rxh5E+WxPZGVi1FNhGRRPyxkM9kd+YzoeFFKnB55fPO9MZyjYsMzAW
         B1z7ZI+v1khB3svcCnbsUeSACU8OOZXT9HOZhCIM8yH7Fnro2SP0rSbdzwEJH15bfiVU
         5SYRVivw2LlzCpfVjPRgQVudLuU+fLCgMj5TbssPmijWPvPPVDXr6jKzTKhFyR+TqYGi
         gm9wUVW+yEhUflZB9bLZbupAMpJhi89OTSR/B2NdHdKUngJTBD0zdmWqFbLJT4jx/f43
         dka2EFdlIsataP8wCdiY6bORFWCtn2cESmCe/M2dXB7Eb0BLHsbuoF/4Gw1TcV//DDde
         R4mQ==
X-Gm-Message-State: AOJu0Yzo3pegu9Xxb2KvJ/64+AqSUEBefFzc3du8zn1zl3Y0KGSzZ6b9
	MNBENjz6a37SLP+W8l2UjCfIDyeMva/KtBTCOaEy6Lnt1f8NIqvXXK2fsUk8sg==
X-Gm-Gg: ASbGncsuL7dHF1cZVpem22WbzDG32fMc9MbB31xaM2UYrJ0q0HfwLQ7PtQHUFktvtW2
	Cz/ZmjJ28dQrMZJ3dD7ZToplEs1ZTMMvPmu7IEvd/mpzRbHW+BZKGj9DHzpV7adCjIh83e3bYFQ
	89aO4Lucc+aCZOdfxmZH5poL0EXfKJR/nx/6P8CkN/QCVZLXLqWU9tSBkFX82Gk6/X9cN+I35rB
	16pl3Qkty/gKoIubhbiBwhSUb0I3NaWlaRXrPf2ZJ5aVkM5GFF4d72kkmrDnjosgNJk8GhiH5Dw
	zXBsKHvAYtMukylAFqz8jE0gBjfSWHvGV3ZyyGrg15FXO8N1j3dDsFSWCPaOf9mg/Lq4ZuuBvw4
	1kUbZ5P9gSffcIzbbde/aN1+AB+6Q+OnVAa3LIRx9wlmEtTixJ37JAnKE
X-Google-Smtp-Source: AGHT+IEUekNAOf55T9UZMwnvi/tcPXzjgHNGIO0WRMh8k7McSL7j+qCCBrcpVsUTjupE7BcKlO2sZw==
X-Received: by 2002:a17:903:a8b:b0:265:89c:251b with SMTP id d9443c01a7336-290273ef081mr315866675ad.29.1760411061750;
        Mon, 13 Oct 2025 20:04:21 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.50.39])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e43d60sm148110575ad.58.2025.10.13.20.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 20:04:20 -0700 (PDT)
Message-ID: <68edbdb4.170a0220.1246f3.27bb@mx.google.com>
Date: Mon, 13 Oct 2025 20:04:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6228928476240682374=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v4,1/8] Bluetooth: HCI: Add initial support for PAST
In-Reply-To: <20251014013308.174151-1-luiz.dentz@gmail.com>
References: <20251014013308.174151-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6228928476240682374==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1011023

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.30 seconds
SubjectPrefix                 PASS      0.59 seconds
BuildKernel                   PASS      24.18 seconds
CheckAllWarning               PASS      26.90 seconds
CheckSparse                   WARNING   31.11 seconds
BuildKernel32                 PASS      24.83 seconds
TestRunnerSetup               PASS      483.43 seconds
TestRunner_l2cap-tester       PASS      23.87 seconds
TestRunner_iso-tester         PASS      69.46 seconds
TestRunner_bnep-tester        PASS      6.10 seconds
TestRunner_mgmt-tester        FAIL      113.29 seconds
TestRunner_rfcomm-tester      PASS      9.16 seconds
TestRunner_sco-tester         PASS      14.40 seconds
TestRunner_ioctl-tester       PASS      9.98 seconds
TestRunner_mesh-tester        FAIL      11.34 seconds
TestRunner_smp-tester         PASS      8.49 seconds
TestRunner_userchan-tester    PASS      6.32 seconds
IncrementalBuild              PENDING   0.59 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.105 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.196 seconds
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.168 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.908 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6228928476240682374==--
