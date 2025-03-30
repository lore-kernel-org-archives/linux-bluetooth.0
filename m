Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310911BBBE5
	for <linux-bluetooth@vger.kernel.org>; Sun, 30 Mar 2025 13:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743340565; cv=none; b=k9icKxt74n7B5npsTM6R+MUb1vKYqgiDj7H/2ymJj3+QHh6McQl1r9iaKHuPlAZk64W4CbFmVQCiHbq7lB9p1WlxCpowai5RAf7ur6LKmHLnN4PfTxnHdt0qWERZL4YzFVV3Khfz3hYvrsZRC4lPHDBjhuRecHCUzrZoHS+0wiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743340565; c=relaxed/simple;
	bh=l5wv65tufqqFdLqTC3soKFClrweMBMm1y4QtOwgHAh0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QbUQTALKWzMQl1gATIJygzHxHBBYmTZm1gKSPT5AespOR6gG5lBMmXl5nwjDCNAyWV8/7BgbMO1DAqWRbXMzperF+G8dcf8ki0T5UuvrxzkGeT3pGuBu4AjbwDj5ApyxxUnFuBlJTVHo5mf+aaWAsMjhJaLr0Gh7h6e7XitjAHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ml4x+MvH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ml4x+MvH"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2255003f4c6so68207945ad.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Mar 2025 06:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743340563; x=1743945363; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NG4z7hVP23U8TX65cgnI20n4+SH3OvlzElECJWBkK8M=;
        b=ml4x+MvHLVQHhOqbSTs24ZUJvqBOwdl5Ym9rsVbINuJmNcE2nHi6D/NoTFTkR7JDfk
         qDrDjpMpbf2E+oxty4RO0iBE6jKcw6h/UQ0/FlH2c7rwK8miUZkaEZZi8QSGA07lqGdU
         LQwbLBYbV2Sjhr/tzgg+c9blcfvTgKFaeT/WMp6AkZAClCAY+kQLeY5EBpz+EYSwwrZ3
         KZbaKubiHMardTIBsl1phLTSWZgrgIAX2/6Tp9pieO2vd4IN1XgZ3ewe/zQ68coi9V0Q
         Kbq6pX7Kxpd5kN6NKTIx0Hl/bN3Qowa9sAw8Uf5qLu891Ov490ZXBKE/l/I6sD+7Ce8W
         b+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743340563; x=1743945363;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NG4z7hVP23U8TX65cgnI20n4+SH3OvlzElECJWBkK8M=;
        b=g6s6QOuRdce1X2/gnWaZQNST8P4/qui4rW+cJB9/8w8Ev9pcw8q9pfzp8OcF5VbaRx
         lOpIs+x2mWuilLfT9od5kxLQM2tfx4EX0oEcKHH+JhYclbbHJeaLTJKiX7HBnoQkmgxA
         gc+24+njyc0Fp9C8gAYPTWl9MUxfR4CEH/3Bt6nTsHOFveimEFihIvZsEGY8S898thE4
         5i8C1Hs3ayfcY33r8/BK2SRdly+fbytHIDhUgr/uUa536vEcmK3VjCJA2MtvSvKUzg+k
         +vxoGJhNz4K/4OSiHrQXKGPSE3YxD9XSGOmAQu0bCdthy+L68vAcZ8YLliZaTgHAfgAr
         Fz3A==
X-Gm-Message-State: AOJu0YwKDMFVDDA6gl8ZiPo0YPIrG3fiI4ZaHmDlZlXnb+FLDTjJ+zET
	zP7HholmWWEt1tZ1izonWosOCt2n25rwIj3aGd6lpoGPd+TilQWwh+UgBQ==
X-Gm-Gg: ASbGncvnAsmK/l64yjQXjWzLTvz9mJwor35GHhII2NnBOy1wzF5VE6+cuFDtbiLGRyC
	JU4zqzUNRUxM4StuvFUU7KvNMz4dVztzvvjP0YkLFWfURYohJuSjgmtQJRZNVB5m2IzJKSFEsCF
	Nepkf1hcqWZAtwvg7xVwWmC4xfa0SKw4EjXVJhZ3QLxuKSQLwueZZgt1NhPruX3zChTcQ8fgxJh
	LMYq8HYu7HqqNNggjxSaDl5yxLwzL65SkVdAhdxzVX/THcstg5ujWcDmmS+yMNlzYfX/AKD0OYs
	NblX44RWAFq3WIkO4qgwNebj10F6JyB9n62gK4jRXysxzj6KWw4=
X-Google-Smtp-Source: AGHT+IHrmPRJMQwLE/jo2KqHSDMe1LYFS9XXFYIJ3OLofYNBwXWwIdjMXJLryULb3f8jb7QjmprLBg==
X-Received: by 2002:a05:6a20:6f8c:b0:1f5:8a1d:38fd with SMTP id adf61e73a8af0-2009f5ba531mr11731094637.2.1743340563047;
        Sun, 30 Mar 2025 06:16:03 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.42.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af93b67f3f8sm4798144a12.7.2025.03.30.06.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 06:16:02 -0700 (PDT)
Message-ID: <67e94412.630a0220.3dac2d.f289@mx.google.com>
Date: Sun, 30 Mar 2025 06:16:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8881529139381981921=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: bpf: TSTAMP_COMPLETION_CB timestamping + enable it for Bluetooth
In-Reply-To: <256cac73a03d6c46b81766db0a1c67cd3220b8f5.1743337403.git.pav@iki.fi>
References: <256cac73a03d6c46b81766db0a1c67cd3220b8f5.1743337403.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8881529139381981921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=948355

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.37 seconds
SubjectPrefix                 FAIL      0.53 seconds
BuildKernel                   PASS      24.69 seconds
CheckAllWarning               PASS      27.05 seconds
CheckSparse                   PASS      30.91 seconds
BuildKernel32                 PASS      24.03 seconds
TestRunnerSetup               PASS      435.17 seconds
TestRunner_l2cap-tester       PASS      21.08 seconds
TestRunner_iso-tester         PASS      37.62 seconds
TestRunner_bnep-tester        PASS      5.03 seconds
TestRunner_mgmt-tester        FAIL      125.67 seconds
TestRunner_rfcomm-tester      PASS      8.08 seconds
TestRunner_sco-tester         PASS      12.76 seconds
TestRunner_ioctl-tester       PASS      8.53 seconds
TestRunner_mesh-tester        PASS      6.15 seconds
TestRunner_smp-tester         PASS      7.28 seconds
TestRunner_userchan-tester    PASS      5.04 seconds
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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.170 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8881529139381981921==--
