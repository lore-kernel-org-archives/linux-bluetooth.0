Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BEF9461
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Apr 2025 17:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743528764; cv=none; b=AYwSu++EazMunziE+jk26IEPyppMZt8hATgYPKTDMuOaNN0MGFiAl2vrnnbYUkWR4Cf98sYfpcCPCO4q9JqxfYsL9hIBqg4Qt3jdv6J052AQd1gaVGTOpQ9suPivma/Sg4K3mR9xvn6qamiNzER8xPTs4dDjf3UXeYnGNoL2Yhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743528764; c=relaxed/simple;
	bh=SYnVd6GXckAF3sKZxOwq7EvlHdyOFkSur28pkms3J3g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Jl9pexm895bxV5SPn4YAAfZ0p0xLlPJf+feO8AYKbjhFf5AYhWfHmydjtzrkb3EBb/5rPCLgGbKrjdx8F3iczV7quPY+YnfBGMEtfmeGhi/FTqgIHXYNXzRzYq60SDU6t3jRRL7g159Rar4b6wHn9+jYp7u4YzowF/DDWTymwJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blz0PXZp; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blz0PXZp"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4774d68c670so75824141cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Apr 2025 10:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743528762; x=1744133562; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fz3MNLcJSULF1kC0ZhawmCGCMZUVy6KR/s0/LK+vPfA=;
        b=blz0PXZp6LDs9/WBq90MrMg3Y7MJkAvAqbL/3sBCmPeGS7yZVZ7f+cY5DwGNRRxYrU
         3+gwDrpqICSxNjuGiC0DPsGR7aP96Dc2mDuWiGcKUOD7oZkU+yTXD1papbh2VI/4oC/X
         g0xu9xVWDza9lb6HnDGou3N1aZqTUEvjcA3EMsOBKtgXTP/uwYnunDYqt0ypm8yY/g53
         U0d7wuFMdFwoN34TgQz3zOUMG7g3kvzU7yu7csN7ucU83F4tSnRmvNcg+ySlwu/myKIN
         5qHRFVa4Y8YQsGFLLuDol/mR9O6hXYglVlaz8dp/9xEt6lwcc4CjJdI2/1ccGUgmAJxp
         XvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743528762; x=1744133562;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fz3MNLcJSULF1kC0ZhawmCGCMZUVy6KR/s0/LK+vPfA=;
        b=XuY7TatS4XCzwmnix2YP7LOXtyFf2rCzkiStR/2XUYLcPNGBcHXqqTIfCT24bVGROQ
         7WhAMANY+VemTwiYHoiJ4sprqdzi7VosZ/bYKC8QI+SUPXfn4iL68CWmBpVHG8YIbT8m
         Qev2kpjd0jGZ86dZbwAhg5MvIBGmWeQmj3CXoUJKTOffCP6xN0qOYEbsG5rpB8o584cJ
         Q4sOOgrASk0KDUTlUkVrolIwKyAmKj+DNw+VH97IQOYIjz3Po9xABtvaZP3gJo5NrMYj
         kkubAbD+r61V9BuZPdcGhob9d+gA0QH6rVILQW8WtjDkqMgPR5PcaqTxp4jEwRa/9VwE
         mT5g==
X-Gm-Message-State: AOJu0Yx2+g5HCqO+Zx3IyH3yPX6DEq/0G+ew0Gp4uxhvleaSFgFbc0iY
	0YeF+W0/IK6FITMvqsHQFVc9QqsnBXMHtzjwIZ7Pu3ZI+J4Bh6hUAka7Cw==
X-Gm-Gg: ASbGncuWIKbFyARGSc0QKWkYxXQWdEC0ll0+mXopkUv96UDxThHV4TfIIQNUuSBeaQw
	9Kb5JFf5NM5NFJSZ5tS41LtctWwtN5h4zrKIm3AEmRxuJVNRccuyQjAGUOvKOAdIlFTdwVv3vyq
	CC1zohbdA/LQYZ3fNL1+JSu77SnWDEXlBHOFzqW5M5a6JlmeOcbNaPlUPl6WxnOti8Yx62fCVOi
	hPq1EX0yVcMrmEwdq2krsbCUHM71GdozesEHn1aEbx76DlNpagUhA0+yOpVOMxpEHvqfOC+rkHi
	g74msYwiqzZkeurg//njqHW27v3HKrmg/qLT6plfMhLc0qOsvx4O
X-Google-Smtp-Source: AGHT+IF4RET4nJ53PFwmkbff/38Va7ldNWxOXWRXi3P+du4djkm5BBxZeN0OE8jeIdPHL9uSINp7Aw==
X-Received: by 2002:ac8:57d1:0:b0:472:6aa:d6be with SMTP id d75a77b69052e-477e4b59dc2mr181453171cf.17.1743528761738;
        Tue, 01 Apr 2025 10:32:41 -0700 (PDT)
Received: from [172.17.0.2] ([74.235.134.182])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47782a7fc4dsm70079571cf.40.2025.04.01.10.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 10:32:41 -0700 (PDT)
Message-ID: <67ec2339.050a0220.291206.7aa5@mx.google.com>
Date: Tue, 01 Apr 2025 10:32:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4191186052637754245=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_event: Fix sending MGMT_EV_DEVICE_FOUND for invalid address
In-Reply-To: <20250401171013.3785788-1-luiz.dentz@gmail.com>
References: <20250401171013.3785788-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4191186052637754245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=949043

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.20 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      24.76 seconds
CheckAllWarning               PASS      27.30 seconds
CheckSparse                   WARNING   31.23 seconds
BuildKernel32                 PASS      24.66 seconds
TestRunnerSetup               PASS      437.15 seconds
TestRunner_l2cap-tester       PASS      21.70 seconds
TestRunner_iso-tester         PASS      35.11 seconds
TestRunner_bnep-tester        PASS      4.87 seconds
TestRunner_mgmt-tester        FAIL      121.19 seconds
TestRunner_rfcomm-tester      PASS      8.05 seconds
TestRunner_sco-tester         PASS      12.83 seconds
TestRunner_ioctl-tester       PASS      8.55 seconds
TestRunner_mesh-tester        PASS      6.24 seconds
TestRunner_smp-tester         PASS      7.49 seconds
TestRunner_userchan-tester    PASS      5.13 seconds
IncrementalBuild              PENDING   0.94 seconds

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
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.202 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.176 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4191186052637754245==--
