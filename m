Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A55B2D47E1
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 03:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755659509; cv=none; b=XZvq1ptnlpdiKMH/guPCF7DhS5sAEfPDNSH4bI18Cx8gyuaKJF1S2jed4ibzaRc/T9puYzqoE9ltlZmqYb8Bgo4NOG7WRXq79xPzYTb9m3jgKly4EivB296wYDnz7xKwhg6KkTZMOEElZKvx4UgoRgelaSrNQJx/cxT6j4CLzZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755659509; c=relaxed/simple;
	bh=22g3AAiVkapVzuFAyPYC1VF+sVvGyHmrfc6CuS3YGAY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dWfR/ncz/j1VblibmwwgoEYfTT/p3do47hjSYMOLcERnQgLSewLr2FMlU7X8CfVdJodmA6JZ1NuKOis+WdeChH5jmBdT2qzgn1AGxuyuXLNr0blzARjOK1MyvI+dbYgGh5bngNk8HHHBMMJyuNL2hBgTNSknDWYnwGDCDclQeaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6mxbF/4; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6mxbF/4"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3e56fc0f337so3074575ab.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Aug 2025 20:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755659507; x=1756264307; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GxaulEnrI28zBgAuVqKDt5Ut33vo/8a3M+A0qJiK+/U=;
        b=E6mxbF/4alB7OWxhPmTXrl7pg9FLBtQoMVumfpw6Cu70Dy6yyhoh5BVJUoHoD9ZeV1
         dV4l6iobgyZ++rysJwKM+uTYkTGW7miK5o691K2b4NB4j/wESGlqht/lZ+Rwfh87IMAY
         s4ttxCcQwg4ZoND0ptZv5qXrRxQUC01xFa80HgIDQBrjT12LHnPr1ZSeVZXZqlKIH+9i
         +3mKB2ukDccT9VHdT24H5eztSB3HEC5D9V1o4YDI/cUFwvLD2cv6l0WVkvKzc+UXK8u9
         ySzG+zLOz76eRhc6KAp1xuaSODler1+uaIwn8LBgPn4S+tO2fVtPn/6iDRZ0acTnU5aL
         xzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755659507; x=1756264307;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GxaulEnrI28zBgAuVqKDt5Ut33vo/8a3M+A0qJiK+/U=;
        b=aR1sXwObVQkth32wcC66d39QTQOli7FNdwuj2HB07T6KL+ruTfhxHtpiT75GVZ7vUm
         NiKaWQavV19n5QX3dAhYcj2hDGxgSiXih5dDDU81MJ3b7mBKLuu0QsVgTS0Zq2ive9lb
         tKZYxnOS7TstN4+BuvZs/3M73XsZxczcpAcDl1R2iMd+6GdjC3saHen4R8KTx79yIoDq
         1FaPB+ENhxhXBKpB1emCkNuO4SOKkwaYXYNmVHck+mZvvtmmkmNrJhxx+tL+zq7qogtX
         TZPgjQEaq4eWhSJyrmnrzg1sG+/dICQ2HMQbUwDIQtEv3Q5VHe1whxUcUycvxFSVw21z
         /5rA==
X-Gm-Message-State: AOJu0YxPWgMO3e9VPXyLppNUoMcy/9Hhu/hRdIzgdOGpa7h2lLI5GP5p
	loH5APhmgJ6TzQ8MaJS8XrITCEtC1ZBE4j6S+Q6cnCIsKTCIqIctLWtnKhlaBg==
X-Gm-Gg: ASbGncuUORor9XvXE1fcSJ9RMRN+PoWCQoaZHC9H7+v1TEKXWw9ZWW0sFwRMV17ILvf
	r0rAI9WLmxjkzAl/2LxiGylnkagn+bwxH3oW+8iTBv2zqwDceQ5/AhBZeOeLHCb/gksKx6OkaEd
	v63y13zPJlN2DwhH4vGlM0QqIu7O+PHg4gATmXilFujSjI3jAIwodEpgaSqefKMlhWPNZ22U0tV
	EjNsYKXjta87DOlEV9f+2p9C+l37Zifh7XYPR0puP8Acccw9/60NzZ9Foyk2x3qCddKWSdUO4cK
	2bF3xpDYPzzXRdALQkxDTbf7rUIERbvXhSx9dWQAEK3jNvPJuhJ4I35lzmMbQIti+IwuQsV5SaH
	agugF6ksQKyKti11QZp0V14o+PsFm
X-Google-Smtp-Source: AGHT+IEydUprJu64Oy/hxGAkfw1wXbh+9NFHXr53rIGvFK3kYi09T2Z3Ce4jZSnW7KTVSSelN2MZjg==
X-Received: by 2002:a05:6e02:3e91:b0:3e5:4e4f:65dc with SMTP id e9e14a558f8ab-3e67c531fb7mr25649585ab.4.1755659506676;
        Tue, 19 Aug 2025 20:11:46 -0700 (PDT)
Received: from [172.17.0.2] ([132.196.19.21])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e58398cd34sm43691385ab.20.2025.08.19.20.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 20:11:46 -0700 (PDT)
Message-ID: <68a53cf2.050a0220.321117.79ed@mx.google.com>
Date: Tue, 19 Aug 2025 20:11:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7087142225402487270=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: [v2] Bluetooth: hci_event: Disconnect device when BIG sync is lost
In-Reply-To: <20250820-bis_dev_disconnect-v2-1-a0e1436690e2@amlogic.com>
References: <20250820-bis_dev_disconnect-v2-1-a0e1436690e2@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7087142225402487270==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=993280

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      25.63 seconds
CheckAllWarning               PASS      28.49 seconds
CheckSparse                   WARNING   30.37 seconds
BuildKernel32                 PASS      23.93 seconds
TestRunnerSetup               PASS      473.64 seconds
TestRunner_l2cap-tester       PASS      24.56 seconds
TestRunner_iso-tester         PASS      36.43 seconds
TestRunner_bnep-tester        PASS      5.90 seconds
TestRunner_mgmt-tester        FAIL      124.52 seconds
TestRunner_rfcomm-tester      PASS      9.15 seconds
TestRunner_sco-tester         PASS      14.57 seconds
TestRunner_ioctl-tester       PASS      9.90 seconds
TestRunner_mesh-tester        FAIL      11.36 seconds
TestRunner_smp-tester         PASS      8.56 seconds
TestRunner_userchan-tester    PASS      6.18 seconds
IncrementalBuild              PENDING   0.55 seconds

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
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.180 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.196 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7087142225402487270==--
