Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D492BEFE1
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 18:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750096852; cv=none; b=araHTwp1cWI5jX7KSafwkV5YeFjqeTwpL3nkLw6X+MUyiISdVjeYeZKV1MDTZq/t1xOpk9WqDMoAnnn4XO8oHJKKMvrihiMRUhRDJbIuuUnNVKD4AL4L57EJjnjlcN5kZNvUgxAL4ZlkJOZKNNHo9dwobRCoNXsF/16tWiAmqE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750096852; c=relaxed/simple;
	bh=d6CkAP+sqqcLK+5SMZkREk6aA/EFYjvaD1VoQCVCRbI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PrAtFJUxQyGv0fQmbpQOblBgCn8biV1k1bIHUICngDOLDCWt5woY1lTpfIWQve8lkA9F4aeG+OHcM+Kwxixh0c7gYHBE8W9BvFJdnqT/1d1qmtJtZg7CN3vRvGMjWBgnhgtWNglSLVv59t0rWi9qUlTjX//1rLRhbLePw+O0a3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1gdoiq9; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1gdoiq9"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3138e64b42aso5452371a91.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 11:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750096850; x=1750701650; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mJqQAQawDv9jr9l/XE2f9zo6zzQTD4aJt4c9Fg/cqBM=;
        b=B1gdoiq9wnp8MwHNdie1Pnj8Fdp513o5VfrSnUpszrstFqeviBC/JmJSDhXr74MKIL
         USyR3xNtfOIYx9KF+Cw9SOSf9qR+pVVioYiWvRuaK5L2WY10qZXWY4WJ8rEH6OrokdjA
         fN0UTQ395wyadVGLnUlbfY5GAKUXq16cSVvSD4YJxUR4CsCWCWiOTo2ucTNBMSz2+DFU
         nWjySmcb72E3dRjegOB0b0ZlepLpF+uFUmzOS66vG6ud8hZ1dQSUCLwOXQOYesi9Cge6
         YwQlXv5IK4XDhCAg/G1eXab7k1acik5REN53tKJjiu5vrIcB9Meq/WKGIaQ/7CJgs9aX
         Bj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750096850; x=1750701650;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mJqQAQawDv9jr9l/XE2f9zo6zzQTD4aJt4c9Fg/cqBM=;
        b=YeKRPYdwpmNrab7qbrJqF/iH+l/CgVnev7FdP3JRHYoz8YUo/ZoLJyu/nHKexv6x0J
         yFegIYl6NsVXkVJrmPGbxd+/WDjppXP1uV4m4L1YJI8YE39VVmrfuaDOalxFa6Hx06Ca
         wmHrKRUmrdaYslV+X1mt0aTEoZEBnLbk8lGJdx9LzFgtZHn48R6kUxG3/YSnUQ4CDhLe
         Nplu5aKb6R4WhyxQVMc2co2VVQ6SwFSvDeOF5DXQWA27bjykVNquFgmwxOEF3Rp0os+q
         zxmKTYvrOGsKtyyvQPjp9Ydh8dRwn3FcxuA4yizd7lN2cyhig4y1K3gyIz83a2vqFzf3
         jBNQ==
X-Gm-Message-State: AOJu0YyTRxIbEegBrdOLaBfkDZ4gczDrJfW59tnf+3ZeZy/7/pKy1uMw
	ybqtL34nz8D65owPtFMvIXIObvfgc+cYNywd7fzQ4GqXLv5bXfEhGic0L9lKiA==
X-Gm-Gg: ASbGnctt60SYIOTZHI6xmvG78W2hKKjUT3ZpT0GVX4PfJCdfVGajtoTClnIK0LYGgFt
	KrcHQFGUGYCTF7ojhGGvoKdNscVRkKzzxNtoOf1iamW4vy3O++2yAxGNWoT+1wz81kQvrRggP8O
	My1eqdUUWN5eKpSr/4oID/pNgT9+vWF3onsaPiApfU1Lp/TtuuzWJ8mgJYtTjUV5upSLgaa/iO6
	RDxc8+qz3G8LLKN6rL2u2BTspJieCRAuvcwHRgKD8ILIJVVDEreiOessr1Dxbvi5FRq2ma3Whnp
	1g5Tv3zLOSgjI9h0zF3Vdo8WqpLdgxPWXZ15/CRMnYzM55A0NjfizvDtwyIz+8TaTJ72
X-Google-Smtp-Source: AGHT+IGnhI2fJO7L5rHrLbfFgQ8I15+vYZA1kMhWOkK2tladmkeBbyKYw8svVKILdfFV92kQUXZrLw==
X-Received: by 2002:a17:90b:2f8b:b0:312:51a9:5d44 with SMTP id 98e67ed59e1d1-313f1bef890mr14193253a91.5.1750096849557;
        Mon, 16 Jun 2025 11:00:49 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.38.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c19d1122sm8982706a91.13.2025.06.16.11.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 11:00:49 -0700 (PDT)
Message-ID: <68505bd1.170a0220.1eb603.3a29@mx.google.com>
Date: Mon, 16 Jun 2025 11:00:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1112602011381392547=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kuni1840@gmail.com
Subject: RE: [v2] Bluetooth: hci_core: Fix use-after-free in vhci_flush()
In-Reply-To: <20250616173803.928382-1-kuni1840@gmail.com>
References: <20250616173803.928382-1-kuni1840@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1112602011381392547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=972625

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.33 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      24.34 seconds
CheckAllWarning               PASS      26.59 seconds
CheckSparse                   WARNING   29.82 seconds
BuildKernel32                 PASS      24.01 seconds
TestRunnerSetup               PASS      455.63 seconds
TestRunner_l2cap-tester       PASS      24.91 seconds
TestRunner_iso-tester         FAIL      7.81 seconds
TestRunner_bnep-tester        PASS      5.75 seconds
TestRunner_mgmt-tester        FAIL      130.99 seconds
TestRunner_rfcomm-tester      PASS      9.15 seconds
TestRunner_sco-tester         PASS      14.63 seconds
TestRunner_ioctl-tester       PASS      9.81 seconds
TestRunner_mesh-tester        PASS      7.26 seconds
TestRunner_smp-tester         PASS      8.34 seconds
TestRunner_userchan-tester    PASS      6.11 seconds
IncrementalBuild              PENDING   0.84 seconds

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
net/bluetooth/hci_core.c:85:9: warning: context imbalance in '__hci_dev_get' - different lock contexts for basic blocknet/bluetooth/hci_core.c: note: in included file (through include/linux/notifier.h, include/linux/memory_hotplug.h, include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, include/linux/radix-tree.h, ...):
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.179 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.162 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.165 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1112602011381392547==--
