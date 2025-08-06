Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C501FB3
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Aug 2025 01:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754444195; cv=none; b=UA7vf6I15yWVNibN16CM8axcMl/kCcxVLpjuuFbNWsSNyMyztekVu250LqcEWqFzPcxx0YmTD6bfVX3sE1DfrqiYAai/n4Mr84oUVxx722U3K2kxitdW/YSD/EpUPZq3YGDOW3PugbP5+yHB0jGwFluXZS4+zNmMgEmHnjMUTsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754444195; c=relaxed/simple;
	bh=TBPDPdHuKXFLBn/XOQWvVZVqDU30HxRwYNQ5rgzTDGg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FVF5WyvNapPbPGZU0bpbKUn4xcWbe99RRUiT5f635j1WZU13e488EqqnEQS6frFmhMDZkCp9v2sa1Sll1WM51mwmxMLCN32lydaxVOvylOvsVzHXgehHO1AKFjyFM44/wy5bbGWksdviZ2CIecYTafjmgkEhRrZcubfX7hesz1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwzTBpFw; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwzTBpFw"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-73c17c770a7so5773347b3a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Aug 2025 18:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754444193; x=1755048993; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O03lDZ0iGLXDRK/M+uWlGT70KB5rh5tcX2yWR289QwQ=;
        b=YwzTBpFwgH6EkNro2/6h+bIGU9YI6noDxH4Jk49yHrjuiFd9xAkR7VL86NxqIK9Wec
         9Xh2gYkvcXUNNkrI9vtxIokZQ/vAJZ0rshKLhp8mwvn71bVPolYcPOkMUSvj/wFCX45T
         N4LPQr2WaAwUXCs3DN5mrsHxHUXqbRn6d86VTp+TcSXmiXuPjedWesAioenLm2mBRnMr
         zzYj6O6RmIUxPybJsl1+HCNX5gyQ/NCNQTUW6r2EX4OaC+Rwjc/XXV58mXhn7MJ9sFk3
         q7a1vyyB24CZUAjXkE62OFMKnfH0gjrztA0rjPqRDy4JfSplvUboN55sntkbLKmsBan8
         pWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754444193; x=1755048993;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O03lDZ0iGLXDRK/M+uWlGT70KB5rh5tcX2yWR289QwQ=;
        b=DcEhsZQ4lqTTLz+Grll4s0KVIWUiP/o6stDTYu8/Jo06t+X4qHkNDwhGaa3WDnsONR
         8OF4SuzZK67jcXf7g50sFaFfnZhsApYgewAQs1RrlF8roQitkG8dusT3wej1zL1EHsEJ
         lMCySNIhyPk+qhlGYvjrBFjuh9f47HI3rLI9vg6Qfn/35yt/u20fVveCn2UAExWS0PrM
         0ueoXiHTnTTEmLqBJao/Lpi/5qp2HywEcZT1K4dx2W9ZZbGdQihz4I7UDsdTsH48Vs9V
         2l0zKXOWYMCMJmTV5XAqKsKW/LexQuQ5haR1sRMvnk/Zbu3oSgta+4Ta0Jzd3JX0s+UG
         /L2A==
X-Gm-Message-State: AOJu0Yzq4mb8bYZ4W+VG3eDjQkYimjxUA1CkVDaK0bpSCMeWzJb8IqoZ
	MQfOc0rdTpwwf74KYo3fOzOLiEvneKKskkbVo0/i3+K1TnXNVzYLn9QXr7Ib3A==
X-Gm-Gg: ASbGncuHlxZPaCmbUj5VamzSiiYRyOgKio1JE6Ftf3Bt7dNfjPzOPiJ1jlR0PDBKrQR
	qHsSZ4gbaKFeWD8zCwX/C/Lyl/1E0t+xFornGM6MvkpAEZCsCEUipY7rdkMJKXHNSzDc32QSmF9
	gKyTeE9A8ahg5EGttkmPYfwfiPphMEq180cVsgBSfZ5PVjX7M1xC8gAEXOoApzWKHttefeYARkw
	PtHOnVfRQOx5xINc4oeJKgnTbgQ0w7gANam0zjaSOp5ft2magGhpRISHLsqP744PVZ2vTtE75g4
	Qt7D8k769Hk4C5LcVFzmWzPOTeQ23V27NDSVpBf9eXOyruRF9ihhAGznRxJLERregWtZ5JF+B+q
	je/VO2HqBsctYhnqxcdRNxayKIBMO1TRzao09ZA==
X-Google-Smtp-Source: AGHT+IEG+kJ8MHUv+UjWEuiIycEY2ppI4++LCkfSwPLCUgrB6nokXocbmgKMJdu1BpOqzlI8AnK1CQ==
X-Received: by 2002:a05:6300:210d:b0:240:dc9:71cf with SMTP id adf61e73a8af0-24033143bddmr1181705637.38.1754444193282;
        Tue, 05 Aug 2025 18:36:33 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.227.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbce15sm14162543b3a.64.2025.08.05.18.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 18:36:32 -0700 (PDT)
Message-ID: <6892b1a0.050a0220.3fcbc.2388@mx.google.com>
Date: Tue, 05 Aug 2025 18:36:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8710002886162027261=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: Refactor Device Coredump
In-Reply-To: <20250806000535.1523133-1-kiran.k@intel.com>
References: <20250806000535.1523133-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8710002886162027261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=988575

---Test result---

Test Summary:
CheckPatch                    PENDING   0.45 seconds
GitLint                       PENDING   0.35 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      24.55 seconds
CheckAllWarning               PASS      27.51 seconds
CheckSparse                   PASS      31.33 seconds
BuildKernel32                 PASS      24.55 seconds
TestRunnerSetup               PASS      487.47 seconds
TestRunner_l2cap-tester       PASS      25.31 seconds
TestRunner_iso-tester         PASS      36.47 seconds
TestRunner_bnep-tester        PASS      6.08 seconds
TestRunner_mgmt-tester        FAIL      129.60 seconds
TestRunner_rfcomm-tester      PASS      9.50 seconds
TestRunner_sco-tester         PASS      14.81 seconds
TestRunner_ioctl-tester       PASS      10.30 seconds
TestRunner_mesh-tester        FAIL      11.50 seconds
TestRunner_smp-tester         PASS      10.94 seconds
TestRunner_userchan-tester    PASS      6.37 seconds
IncrementalBuild              PENDING   1.15 seconds

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
LL Privacy - Add Device 3 (AL is full)               Failed       0.235 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.930 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8710002886162027261==--
