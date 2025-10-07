Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CEB258CFA
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Oct 2025 22:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759877930; cv=none; b=LtEGFgUpKypbVNPY5uX2E3qd20Ycaw5D/MvGk78vWUZDAtLjRpNbTT3A0JVpy3yYufS06s621JOKpKbsllZ5CbU/xRilCmumbSc0ikVi64g/iCRLtQ01Xhy+k0TI6AEXNOIEkx59xbYvsr2+Ai0GKVD0kiN1HKkxy53C0ilOzUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759877930; c=relaxed/simple;
	bh=UPwKEKKsOnJp065WN6kx15ZJxbUpeEBnmO43kHgbZNY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=L/H1FXaiRbtTScsIrd+Q39sAAVotmsJ+b4sVZ35WvlbZbMT8hZoH+TQ6AOE6JZLN321sYRMlHNT2CIrhJGOtSZ13cTIAhrL4PkUeqhvR9HePHBq/4dulCyuE6ze+4z3ewnxQdBkPaBfNWICi7wOnLfnGiJQ1hhUcypehch2wtvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvxbKI4+; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvxbKI4+"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b523fb676efso5716395a12.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Oct 2025 15:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759877927; x=1760482727; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9/NhFPPEeQyBv7keJSdVZsqZCARih2S9EemGv7oo3hc=;
        b=SvxbKI4+qqvH7ToWp1sqQqcS59XXf40ZES5PbsxBUlEc2NMC0FctLKgPy/M7IdiYhM
         2e+N9IyJK0MDIThFHDJ/FEJlSHgqZZxXSEceyHKSGbbKn/w08GuhdbI/ktaGPR4WUxvB
         V+alvM2qkuhP6rmmlgF/Rrkbbgvo/p4FvrA8Ym2m2ScwbvWHu/qBcjIJH9ScoliHqy1e
         4CKYOTSgJHqybnGqywIjycnqFz8qs03rbnqjrIYEPZ7NbWCRwYfReNw4MOMVFadPjany
         /I6azcVyKlmbCYvaPf0F39pACcyt2i1w2bxVeeomP3NPjbVt9jNfb1kRI01u1FEi6JV0
         srOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759877927; x=1760482727;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9/NhFPPEeQyBv7keJSdVZsqZCARih2S9EemGv7oo3hc=;
        b=VJ1RcaUJT3LwJWvjk+h3hctVobrXboF49NvAC1JVqLY4GnOihLs2CLOQscfEASeoL+
         pTrTQTperVNsgKD2bDM13CqXU/WmRsajU4Gn3MHz5oxj3sYmbeJK9v+C4gIB+X5xAhen
         qmGkiLWNKDUx/6LF/UQEIGHnLlwUw91bambzCeyZTMHIIyYrTQGyhavxf9PbGrj8QKf2
         K//VRM4beqb0J/j1cr+6JS4nFdYSQuzM/q/aDL4AiVSjDu5vbPDGhZfpKlMhV8dJDeeR
         KTSj8M4yjhJFFhrowQeaRot1Ylr0wLCSbtBd3otwxKukBIj026IKpw5nvbe5UJ6EE8Rc
         28TA==
X-Gm-Message-State: AOJu0YxLCCM3rPMpW1x4ENTVcNL1brcGx6htv30kOdWzN+awwHInkpNO
	VXItEbc7yLYJuUe05TpUFnh/XZAv8vgHmBavKGNoT8SQQ5jSoQ10pPru6cAX4g==
X-Gm-Gg: ASbGnct3JTBRPJELVeOz4jvPUBJNJMQTJ6uLGA6YLV+dlR/1vqT8fSdsNmHynJ0nsTD
	qG6IcY1Sht7zhPFHalx5z2oah8m+W57zRfxTtNBJVVpLDh5/9t19bITwFp9o5uXy1ruYZHg4sCc
	s6sjfG4Eniwh0q6Vy9OcEjgDbHVFSo5+xYexgAQABdxDjx5nOCAMSIfcl3N0trCwWL3Z6GtAy//
	vivY3TaxGxd4D6PUcYU2yr8q3iwL8FoN8ligQEAVlwtKTjWksmAJf/ur3qGaXlvKU1F55OECm2/
	7VbPy994bL/Gcv+h5pEtKWR4cGTEqNdWRfFgvi29UldjP7hmzmOq8pk+7iJ/o/6CPAzwhxlIQ9i
	rREGvzOmlPHkrLrvm9lea2geHLW2rloN2LtqtcimT/8TuVJGzI0cO6HY=
X-Google-Smtp-Source: AGHT+IGmgKAGV5rbycdFGAhXILkD9MAAoaB5mmAJaDWMpMyJKQ+gxME+xM4eyZKcul9MpoxrK0Efuw==
X-Received: by 2002:a17:903:2305:b0:24f:8286:9e5d with SMTP id d9443c01a7336-290272cf65dmr16793305ad.26.1759877926967;
        Tue, 07 Oct 2025 15:58:46 -0700 (PDT)
Received: from [172.17.0.2] ([172.215.216.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d110ceasm178421585ad.15.2025.10.07.15.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 15:58:46 -0700 (PDT)
Message-ID: <68e59b26.170a0220.3598f1.e4ab@mx.google.com>
Date: Tue, 07 Oct 2025 15:58:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7432106986291334137=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3,1/8] Bluetooth: HCI: Add initial support for PAST
In-Reply-To: <20251007223155.1539954-1-luiz.dentz@gmail.com>
References: <20251007223155.1539954-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7432106986291334137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1009205

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.37 seconds
SubjectPrefix                 PASS      0.58 seconds
BuildKernel                   PASS      24.35 seconds
CheckAllWarning               PASS      27.04 seconds
CheckSparse                   WARNING   31.08 seconds
BuildKernel32                 PASS      24.43 seconds
TestRunnerSetup               PASS      490.77 seconds
TestRunner_l2cap-tester       PASS      24.53 seconds
TestRunner_iso-tester         PASS      70.20 seconds
TestRunner_bnep-tester        PASS      6.15 seconds
TestRunner_mgmt-tester        FAIL      118.58 seconds
TestRunner_rfcomm-tester      PASS      9.45 seconds
TestRunner_sco-tester         PASS      14.59 seconds
TestRunner_ioctl-tester       PASS      10.16 seconds
TestRunner_mesh-tester        FAIL      12.35 seconds
TestRunner_smp-tester         PASS      8.69 seconds
TestRunner_userchan-tester    PASS      6.45 seconds
IncrementalBuild              PENDING   0.67 seconds

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
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_sync.c:7281:19: warning: incorrect type in assignment (different base types)net/bluetooth/hci_sync.c:7281:19:    expected restricted __le16 [addressable] [usertype] handlenet/bluetooth/hci_sync.c:7281:19:    got unsigned short [usertype] handlenet/bluetooth/hci_sync.c:7281:19: warning: incorrect type in assignment (different base types)net/bluetooth/hci_sync.c:7281:19:    expected restricted __le16 [addressable] [usertype] handlenet/bluetooth/hci_sync.c:7281:19:    got unsigned short [usertype] handlenet/bluetooth/hci_sync.c:7281:19: warning: incorrect type in assignment (different base types)net/bluetooth/hci_sync.c:7281:19:    expected restricted __le16 [addressable] [usertype] handlenet/bluetooth/hci_sync.c:7281:19:    got unsigned short [usertype] handlenet/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_sync.c:7281:19: warning: incorrect type in assignment (different base types)net/bluetooth/hci_sync.c:7281:19:    expected restricted __le16 [addressable] [usertype] handlenet/bluetooth/hci_sync.c:7281:19:    got unsigned short [usertype] handle
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.110 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.167 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.703 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7432106986291334137==--
