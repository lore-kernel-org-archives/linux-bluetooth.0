Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBD92FDC41
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Nov 2025 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763109650; cv=none; b=KPmHDOVLDXdlBYTfx/m76mLlFmII/XxWrXoZ1VAWHsL1LNgAfaq/dCqCbWD0e0Wkx8eGQM+tSPUyLAF9J4qseYUMwMt0Jki50oYXUoQ/0OiFLD7y3SNS4ZDhF6x/Q5TAZT4rHC2VplwG3tJOVTFsCi7MkthV0mqB8QC6hXwhcZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763109650; c=relaxed/simple;
	bh=LYNt0on8OEOi+vTSs7dYsT7UD/mjH5n5lI/k0nwADUg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rMlDrp4nTBwjKAzNrclxgXxkN0tklT/Kgbkq2TCHD9D8BemZRvCL5zCgGq27Onnob+6w7AImr98m6D2Xi/Lf2wdsrv8YHXQ1gxXVn9cqMwcY1pCJuKLO7hbPjNLrKPHlvWWIUuTSDS19460bFrEYzq6iwqW3DJgmlW64KuybHSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzOPUBBB; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzOPUBBB"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8b28f983333so174509785a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Nov 2025 00:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763109647; x=1763714447; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iDWkhI9OZvklrAE9Q7OhgPz8WFuid5b4GA8fXFATU/I=;
        b=KzOPUBBB+XIauSXtewpAM5YDG0PXINpzVlpcQ36JPCvV3pGSG2lRFYEOQJE2sxLf3W
         U+hIJ72860aS3I3Z4Am3SgQrsL3T3npl11aUbS8wZSIor7qFrXYoGVbGv2JqZ7ObmBSZ
         ytkQTSL2/hr2E2KqSJ0R1eog4r2jho4KXjdwNG4YQ9FOhS1z0ubCXnronJdRnSaNaqHB
         RKto7STUYTnGN6XGVp9nppA5FsdjS0UVl+U9g9uCLXeGMJ/0Cgvl+QXFsJnLU6iIXSAl
         rBdExCYhFFpqScAa3pmmrUemtefbf7PF/RnKinXoZyy0kGdmQ8AGPL+VsIaTyfRI3gxB
         U/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763109647; x=1763714447;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDWkhI9OZvklrAE9Q7OhgPz8WFuid5b4GA8fXFATU/I=;
        b=VwjVTBNbv6a2xKylo73aviK3ldbVNNd4hg3PD4JOUhm94QtGAkAyQTjtWxKbrymeI4
         SmmqKC5VCPEJjzqjEUdf/5mDwTxHlR+p+v3b1sUER1LdIk2u7nZH8vc8at3dlQZsgQ9X
         5uFAxyHLS7zZKsB4ASV52IhZyk/tbLv+VP4MAeeyaXU+fJQReV5UwkFdalev23CLZAla
         H06HGTcfZmRodFDZh++Aa6VYzapcPr4Wxfeaptuxo+lN0P271x053qloLN6pv8aIkL2I
         bvRPDXJb4VUTkXgS1QZETSoTeT6tvrvJJoVVMHmsJXfOeJxxWlxyPM0h/R39rDU1VG1c
         04yA==
X-Gm-Message-State: AOJu0YwnSsKam9Zoj1IVNWYGHeTvTB+01eKHS6gZQKKrklFXOGvcA99U
	WKE1Ccscz6419yEGLXZ0kU7bf3LdM97gDGRubKkEqTnIBF93RD2U1YEwh0MdZw==
X-Gm-Gg: ASbGncuuJHh0A0q/AezOY4CQgCvp4SM9MjNZ4OnMHAQKYWzRaxaBFvSJKdZLpgA/dzd
	uFWiwR9NRrKQGRAwVjdiGnKDPCQpoBQz8Dj6kmtHKd/lIhpZilEzYObEj2j5sail0071qo4JbIr
	gYwsF1kZOB3WpWhFsEXoWiUxhKnqlnfXQWeLpkFgalaELoTfb2vphZUgv6QNoRSadWKpNZue6RQ
	bqFIi8rPSLC/BqAzn961FBjY4+zrhE7DijJP2xFnDGRuyr58MTiJPWIyytkPiouth2xiBVvcxfk
	N462ABGrImKWGXcFNxHM2IUrzI5BTi3a3aI7kJXC/rRIHyKSh3kZjE1PdLpyi1CUJM9T8KgDxjZ
	wyBqZosfeP6TGn0XR6oZ4b4oa38DKIkhGp+dszqZMoBn6GY+YPw2NhSe33YMKAuftYxT8nGFX1R
	OEBbRgYA==
X-Google-Smtp-Source: AGHT+IEjWHT3eenrhIJ4md7+jeTgQxSal7GYe0l1EWpcCIAskzUWBnEhp/PcUy1msGSHu74Z+wpsxg==
X-Received: by 2002:a05:620a:4723:b0:8b2:6606:edaf with SMTP id af79cd13be357-8b2c315e56cmr275668885a.37.1763109647532;
        Fri, 14 Nov 2025 00:40:47 -0800 (PST)
Received: from [172.17.0.2] ([172.172.158.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2af064ad0sm289917185a.59.2025.11.14.00.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 00:40:47 -0800 (PST)
Message-ID: <6916eb0f.050a0220.2f4fd7.7a24@mx.google.com>
Date: Fri, 14 Nov 2025 00:40:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1921499539775322038=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: Bluetooth: btqca: Add WCN6855 firmware priority selection feature
In-Reply-To: <20251114081751.3940541-2-shuai.zhang@oss.qualcomm.com>
References: <20251114081751.3940541-2-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1921499539775322038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1023378

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.23 seconds
CheckAllWarning               PASS      27.58 seconds
CheckSparse                   PASS      31.32 seconds
BuildKernel32                 PASS      24.71 seconds
TestRunnerSetup               PASS      498.02 seconds
TestRunner_l2cap-tester       PASS      23.91 seconds
TestRunner_iso-tester         PASS      58.39 seconds
TestRunner_bnep-tester        PASS      6.20 seconds
TestRunner_mgmt-tester        FAIL      118.81 seconds
TestRunner_rfcomm-tester      PASS      9.34 seconds
TestRunner_sco-tester         PASS      14.36 seconds
TestRunner_ioctl-tester       PASS      10.09 seconds
TestRunner_mesh-tester        FAIL      11.48 seconds
TestRunner_smp-tester         PASS      8.53 seconds
TestRunner_userchan-tester    PASS      6.53 seconds
IncrementalBuild              PENDING   0.46 seconds

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
Total: 492, Passed: 485 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.102 seconds
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.163 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.152 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.921 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1921499539775322038==--
