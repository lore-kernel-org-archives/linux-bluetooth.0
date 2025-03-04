Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DAC209F4E
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Mar 2025 18:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113438; cv=none; b=GyTy3MnsGysjtRroELNpc1+2PgTmS+Ots0eQcjfNooSvdB2WAU9XxPfmOtTqQW1VcFVDOJ0XfPqM1OmGNz4wI9kIeMo/3T+jKempGk+NHQxxTWp17om3PGUeIMdXd1AT2doUeWoNi8gfWSSkioyZRMbaSFfIeZN9VF1VVXVWZQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113438; c=relaxed/simple;
	bh=zpIXDKjtAWRaqUainA8vFh8ueQvMBTqcCr3YLunZPYE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aHpllt6JUpAUiDepwXSC5R9Z4mk8YmqI/udkQyhfZpx6li7YZrIHoAp2eJMzxx6WyDcpCrvya4cJCuGG7mmigCQMPidS8wbMUDxN1YTxmBw553xep6WZSeKS2H6/WvYM3BmZC90TGWvLyzPLvMfh+ZuadiXK6Twu123/ugc5zfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V29UK/gE; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V29UK/gE"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c3be0d212fso298400285a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Mar 2025 10:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741113435; x=1741718235; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xjzv5j0cFvZDNb0GpgpXH4kaiCHix/tTuBcAtQAteSY=;
        b=V29UK/gEoKXyc1PoHuVMDUWg12ITsnYx5ivX53JXhHc/KiME3DiRtrZ+J3V3DRIxrQ
         haxhF8FxIZeZrL8HKxT25rz2sAM82Vfgypq2pJXndINetMGdWsRBPNOgxlQSgeQ2vtzN
         Qta3Os1wA9L4Bhu7dnMBlQhsF71R3iFrilRNy/c4HX+7tMJM4NVgalUnTsBRreO8OQLP
         Sgay/F3K7nAb2XGzw372Mxh+QA7AFn9Do0ca9ZQg6/IEu7jX5KPHsHq7GsccB4APbajw
         TEoffvYE1KLw0Fb7tK3XUO+F6heA2wurMe6ELZva2VX0Whxqv2hEkoG7E4klUixaPVx/
         6RYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741113435; x=1741718235;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xjzv5j0cFvZDNb0GpgpXH4kaiCHix/tTuBcAtQAteSY=;
        b=YQqx6ixLH3VxcPQuecSKf2TvK7zwz6kBVCp47/E5tTvA3NE2dntGlK7xv9JWhKnivN
         XZDBIlcCGNdwzyxeDXNpBOdByc6I/l1BPCTDW0/uCXT/ofn2t4ewdGqTNDF6UoZhzQBV
         xs1YAcxqiD5CM3RxeJejQHN4fbiHx24ET6h9SFdNgJRisRhUnWJyUyRrN9FmdZArygWv
         kAW89m0XAhMP7mYJ/ZV6hcd/+BXTfD/ESl3td7XePLPLptMRBAX6IXvyCh6IHPfHnMIw
         PjxgJMHvuj5zRRu4wF9gKODwUEr7180l+g8KgFhZeeuDmGOps+h9UdVrYpsU0G8v9nWp
         h3fg==
X-Gm-Message-State: AOJu0YwfywpS/gbMC2Mri8V5HAURjKv7OQPI+Na/PXt69Yb1nVSXfc2k
	8EtYruALCJWVk6a5WEXPUB8NifTuqREWB3JFx6rrGjUlgjdbEnndt2bkRsAn
X-Gm-Gg: ASbGncuZQW4xxPjnwgAuT5JB0RBt0LsNdJ4jlXDmO+ya71jj10hVDdURv6yfhlTAs0E
	9GZwq+t5vpRYVUczxj9OhFvlG6ffzawkX01ko05EvP+oHSdmsYFYvbsvSZcSSSV4saBT45N8zx8
	vqEE4updN57BKLbdVTSFDrsMRBYax8KMXgx5jL+FGy3l8EVBwQAFqU20DAjEcjBETYmQ3IYH4+j
	RprFpI1ZwdlovoIceXspA0NxR3lgmNsVMy0ZtwIDcV7YLxpSIcRYbRJjreKwfbbY1Pg14N+YZve
	Ku1gzzhA3mC9QG7SSTkTMo8BA+/Ze64UV0xfU3FW/sbKuNVpO1SkBQ==
X-Google-Smtp-Source: AGHT+IFaDgj7c73N41hCAMvvVbkbvENyTyUjZgokvC+aCeeefvlksr5E92OBN8qa6RmA+8xuxO6KVQ==
X-Received: by 2002:a05:620a:271b:b0:7c3:9846:c611 with SMTP id af79cd13be357-7c3d8e7c834mr50616785a.34.1741113435621;
        Tue, 04 Mar 2025 10:37:15 -0800 (PST)
Received: from [172.17.0.2] ([172.183.109.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3b53ce7a6sm350122385a.31.2025.03.04.10.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 10:37:15 -0800 (PST)
Message-ID: <67c7485b.050a0220.31aecb.af0d@mx.google.com>
Date: Tue, 04 Mar 2025 10:37:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6895035363656536798=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v5] Bluetooth: hci_core: Enable buffer flow control for SCO/eSCO
In-Reply-To: <20250304181019.214207-1-luiz.dentz@gmail.com>
References: <20250304181019.214207-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6895035363656536798==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=940193

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      1.21 seconds
BuildKernel                   PASS      26.47 seconds
CheckAllWarning               PASS      26.99 seconds
CheckSparse                   WARNING   30.29 seconds
BuildKernel32                 PASS      24.21 seconds
TestRunnerSetup               PASS      426.84 seconds
TestRunner_l2cap-tester       PASS      22.86 seconds
TestRunner_iso-tester         PASS      34.33 seconds
TestRunner_bnep-tester        PASS      5.41 seconds
TestRunner_mgmt-tester        FAIL      119.90 seconds
TestRunner_rfcomm-tester      PASS      7.99 seconds
TestRunner_sco-tester         PASS      11.72 seconds
TestRunner_ioctl-tester       PASS      8.26 seconds
TestRunner_mesh-tester        PASS      6.77 seconds
TestRunner_smp-tester         PASS      8.23 seconds
TestRunner_userchan-tester    PASS      4.95 seconds
IncrementalBuild              PENDING   0.85 seconds

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
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.175 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.196 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.147 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6895035363656536798==--
