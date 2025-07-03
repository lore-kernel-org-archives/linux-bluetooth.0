Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF47253B58
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551728; cv=none; b=OjPTsK434rdjB3gb36sQ3EZO5yb/Z8T/qHLus5Nr7xEDHpeTyoDqR5Wtou8fjWMVl0ukBfgIWcT5eCMVXaKWyUof5JXqKytCrnRCOMKlhaEJgaGq8c2+I2TH9NNC0onmGp8V9+fPjiCPI8SGUq8HZbsj+qHP4pskvki7sU70KPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551728; c=relaxed/simple;
	bh=CQ+TiDCoaUIahsN22WpvEYGYgGJzObZbhQGnVZ5zsgQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=erQlKVd0ryAPwgkokod3qOqDk0riPs3Q61dXSmErnGrPeydHY9wbVYMqbys1X0Ql2yNCMIZFlsQhaQOFXzttaGz/es1ByusEAy6dZEoIyQ4QXxyTKtzmiE9mFTPaCDMFt5VjINu10OavoEupsmTfKq6tfXPMIf2/KcjPSa25Xl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8DdaR8R; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8DdaR8R"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-311a6236effso4206467a91.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Jul 2025 07:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751551726; x=1752156526; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YRRsqpcFqKlJM+xhadd1WNXWkbAqO4SPM+GUgcx9LnY=;
        b=P8DdaR8Rb5e2twZTKRsg+U4IME+L2ZCXQJ16LbQYpdXdKond2TECJUhmbZyJPN4o63
         jPunJaO941oh4AxSzBrCz/S+FiOJ7kmQVpYRwJnyfljrI8rQXD427+QajDqBPk7unFe4
         QnRMGrAUxu2tdwmGkbewYBCuHNT99YKuNBB5reo7lfML3uKqdzwEvCkPoupUrHs7Ezge
         5Ym6NkM7dNouCj1cI4rbr1o/UR6gbxVOXEc9BdoOzwjbcJFAv0LziJePEVxT9yIzwvUB
         3ne7rCcY5sZ4LJmrLc1O1CvDY7fsUkDoPvvbN5UaouU2Mi7lQQ8N7RjyZ2awBUHQ2UEF
         nJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751551726; x=1752156526;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YRRsqpcFqKlJM+xhadd1WNXWkbAqO4SPM+GUgcx9LnY=;
        b=Egv8kDCD5qzXPgdTwLEs8735ApcF0WbV/th6JpGaKI0nXaNR/cDaBBx9HHvqTK16HR
         wClx4wDfhH07brMTEi2vG9DDnJu2R2MXUQmbKdNQdXD3FEdPJ/0unHV1Sh2EEWxa4JWt
         PidTvtJbqVHFsCfS/2U9H/5G90Jm7QH6nVSRbZJOVOclcYWaTIIw8DGU7SSgr4HwqvxW
         82ImMLZh2ez/Xhw040bBwXwmRmG516E/Za/nP1mc1i/9Zdm9kfhN8tGJXjWgtqNdkSPb
         M+GRzewIFfJ5KIjLjpRXS+PrdV1s8CiNOLptT2mvIPJF+NVC4d3TF2WaQV1kEnwlL7m9
         YwYA==
X-Gm-Message-State: AOJu0Yzx8ZSjFiEWxfy2Xsc5McigxHFLI7YAL/vV4nnV74KhDFyhrrnL
	n1JKD+HRV49c6uPRbLiCyAXs4eG/b5q/oa5kDw/nwRV1LDWbbmVV3DI3yGE5s0MS
X-Gm-Gg: ASbGncvrFTMLNkJXblq52DAk+KZ2cT1rvDyPWu9PXIqZeQa5JcUQyN7PL/RWMmTsrhN
	cyGMtUPe9rQNP3JYhd1TdEaW/kI0gu6/CEhLEETHA0xOOGhvt/BTY6LDjr5YidzSbB2XNDmCq6V
	DmaqIzLVzQkPHCtCSjWnE09eb2TbGNc7YD6HrUUHswQDo+5ufDkzlB2g0aY6aFyluhZvfDhKB1m
	bDaU83FX/Qt4wBpEZEg+AUKuqkzIMNkOn/ADy7sfznnopL9FAAMdxNs3hwZv+gDLXkseI/8Dz6s
	soGQ1FXvyloxA1a+IyOzL/UPR+5iAsFDWEyY/doTxZsv7MjkWraC8YnOASrQf9lKLC88pA==
X-Google-Smtp-Source: AGHT+IGYsaiBmUUJcBgup6S8emHzeMCB6exwKBZbVNkWiL3bZN6nSOIeVinY9GO+hksjkYZ8HfdHPQ==
X-Received: by 2002:a17:90b:5823:b0:313:15fe:4c13 with SMTP id 98e67ed59e1d1-31a9d5c8cfbmr4351055a91.27.1751551725746;
        Thu, 03 Jul 2025 07:08:45 -0700 (PDT)
Received: from [172.17.0.2] ([138.91.197.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9cc49c02sm2601993a91.5.2025.07.03.07.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 07:08:45 -0700 (PDT)
Message-ID: <68668eed.170a0220.1b8be7.b8ae@mx.google.com>
Date: Thu, 03 Jul 2025 07:08:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6713743582665808520=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1,1/2] Bluetooth: btnxpuart: Correct the Independent Reset handling after FW dump
In-Reply-To: <20250703130549.1659732-1-neeraj.sanjaykale@nxp.com>
References: <20250703130549.1659732-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6713743582665808520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=978644

---Test result---

Test Summary:
CheckPatch                    PENDING   0.42 seconds
GitLint                       PENDING   0.35 seconds
SubjectPrefix                 PASS      0.32 seconds
BuildKernel                   PASS      24.10 seconds
CheckAllWarning               PASS      26.48 seconds
CheckSparse                   PASS      30.12 seconds
BuildKernel32                 PASS      24.28 seconds
TestRunnerSetup               PASS      473.91 seconds
TestRunner_l2cap-tester       PASS      25.40 seconds
TestRunner_iso-tester         PASS      42.42 seconds
TestRunner_bnep-tester        PASS      6.08 seconds
TestRunner_mgmt-tester        FAIL      134.34 seconds
TestRunner_rfcomm-tester      PASS      9.42 seconds
TestRunner_sco-tester         PASS      14.80 seconds
TestRunner_ioctl-tester       PASS      10.10 seconds
TestRunner_mesh-tester        FAIL      11.42 seconds
TestRunner_smp-tester         PASS      8.56 seconds
TestRunner_userchan-tester    PASS      6.27 seconds
IncrementalBuild              PENDING   0.99 seconds

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
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.228 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.163 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.071 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6713743582665808520==--
