Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C95A23CF12
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Mar 2025 19:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741807795; cv=none; b=RuYYuqr6QGAn15jZDOYmbegNVEawM3Rg6iHZdndXqpIxU2SD+OqojnjQ8fiPPNCR1iqqIQ72a+NXVju1cXwEIwKZNtBz30m+Y/UAf9Q/1WO3Pxjb2/rWGfmQLguk/wni4jiPZH2JPaYFmzVm8vHKuyJRSPF4b8EVqUArZuumyp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741807795; c=relaxed/simple;
	bh=GbtAVVfId++SqkEAXKGmLKy7/y2bdiphVLqxkB6XZQ0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DV90Jg0z7rz7VMAY572/7XUAEtjNx0y1BNPn5DBtvyUbEznLVJopfE6Gcs1YDAhnkucmZdNSVT4EAMcn9TYoEbMqqYk7Yf79+Fh4zuvHPuaTkr95drz99dtAAFhiW/Ay9mIrQ3NT42rCLNZZ6Jyxb38i805ysuJyCfAXOYnfCT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUWXD57J; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUWXD57J"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ff64550991so494390a91.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Mar 2025 12:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741807793; x=1742412593; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=podWx9D2OfC+AEB5M8hxrSP71XYWhBxbn6jQn+wSTkM=;
        b=aUWXD57JZvNkhuf2OWvctsaQHXa7Fmjz9PGWYB6zWl0aSVZVh92hLPHP24bEUgY/gI
         DIBpd3atLCy8k7zQNd4Z1jgYVziOW7RIP1I8MPl1wQsq702V5Zp2LDW2ObUS/pDPLTsr
         0oOlQqF2u7IO768h6l5bYkxDZ/tuX1dvyLGAQ6bZT7eJteBc/aXUVlgYWB2++0eyZ50Y
         cI0+6+xpyqqMhq/9k1S2bzOdy/5MyohZSwrngqa9c1cJgx6AWr8ILTFX8Bqjex7aMtG3
         6FRXt67SClYQJp3ABeCMa0DNabPDB4+I6SjmJwMULk+5/xlxIk1IP89zhD80K8BOdwwu
         029w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741807793; x=1742412593;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=podWx9D2OfC+AEB5M8hxrSP71XYWhBxbn6jQn+wSTkM=;
        b=us4W23mRYqdoMR12F8QUdj6C0wznXQYoy5wkl4YE9OPM/pWubMNuX7D8Lj2IzfhDVV
         mlIxi9UN1Usnh8GRJ8WjujiXIM42M9TDya4YzkAEuVUXXnRXZ0zLqPgKuasDSj1CFF9/
         XKhDmJdrj26YHxNahwr4XM+o/XMNB118e+vD26idd7LhK05Puh7ECZB99K9f6w/Ps+Hb
         mbdAj9+NgaBvaxZIaGSTDWFOen71zYxMUXhGr7xdI4RJHH0hHcQYrKK6Cc5UusV1zecE
         Fiplb0QCKfB82LHGfK3H+p3n1xvDX1IWT/0LStbQ7zLgGiIyzB2z6zd6P7werVSinzKB
         O7/g==
X-Gm-Message-State: AOJu0Yze0g1LDbXpVYJNmq7FfPGqgi/omPYltMQ/Gw2RBPtAK8aNAEsT
	CWw93qOTSeVH4yZsY5elWKReF0G6y6ceUO6Ku7/8LybAvbIeZxWl9ko1Ig==
X-Gm-Gg: ASbGncsLuxf4VRvXZJjPKDBzFMxP8/dAyNTKk4RUZdHCrelWvsjBFHOxTsdD+DoU6qG
	j6XFAPiPxThT2YehpTFzq+zF2VFp0ejWi+bm+6tbJBNMIInWQq8esblTbiukhTf+9+VkpZSjx5P
	s6d6Akcda5p3bOR1xSieFisI87bJSMi8CXL7P1N9tuUHlVtC+5fPEBabgTSdTJJhpdKiMmoxv7E
	bKCnWLnncCkzZYrPl+YhD9C7aWf9BFgCnrHRxdY65DPiIZqc9AhK5GGSEMWpuBx3e8HRfiHGSG4
	M4SqaZbXe03OgYS9tHUdOl0xnVbF16m+xZ0UXDVq8Z2jTNKdreA=
X-Google-Smtp-Source: AGHT+IFl4zWVU20JhQbDJSTEg1zZg3ba+lekuTlVfukmRhsRi9osTg/ZyiVX8Iqcs7HszsqW+hi6Og==
X-Received: by 2002:a17:90b:3c02:b0:2fe:9fd4:58f4 with SMTP id 98e67ed59e1d1-2ff7cea6056mr37007482a91.16.1741807793296;
        Wed, 12 Mar 2025 12:29:53 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.33.229])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301191cca76sm2224485a91.47.2025.03.12.12.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 12:29:52 -0700 (PDT)
Message-ID: <67d1e0b0.170a0220.d0fff.7da7@mx.google.com>
Date: Wed, 12 Mar 2025 12:29:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1687947683122292600=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: Bluetooth: hci_event: Fix connection regression between LE and non-LE adapters
In-Reply-To: <20250312190943.152482-1-arkadiusz.bokowy@gmail.com>
References: <20250312190943.152482-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1687947683122292600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=943230

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      24.62 seconds
CheckAllWarning               PASS      26.71 seconds
CheckSparse                   PASS      29.90 seconds
BuildKernel32                 PASS      23.93 seconds
TestRunnerSetup               PASS      427.42 seconds
TestRunner_l2cap-tester       PASS      20.90 seconds
TestRunner_iso-tester         PASS      28.68 seconds
TestRunner_bnep-tester        PASS      4.79 seconds
TestRunner_mgmt-tester        FAIL      123.07 seconds
TestRunner_rfcomm-tester      PASS      7.87 seconds
TestRunner_sco-tester         PASS      12.14 seconds
TestRunner_ioctl-tester       PASS      8.32 seconds
TestRunner_mesh-tester        PASS      6.05 seconds
TestRunner_smp-tester         PASS      7.23 seconds
TestRunner_userchan-tester    PASS      4.90 seconds
IncrementalBuild              PENDING   0.82 seconds

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
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.192 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.142 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.135 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1687947683122292600==--
