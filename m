Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AE319DF61
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2025 22:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739485668; cv=none; b=oUn0o0ucbWjTHqlw4JmYCXXjns3uIvRaRkPyUK3m9IUONqMw9Ud1+a6SN4ztjBlh+twzAgbbGB3TieFHzB3t52pFHMriC1uzGoEgqLPcT5YddBV3ymyzRl7F70JnMBBj1zv5oLK2ttXayB9XexwB0rozyf9nDgXCkYtufqcJ8aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739485668; c=relaxed/simple;
	bh=KtjPMSkZRIYtpM4RPIyUXJRpNEJKlsUfzFgwlZZsTxU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=avpE2hUYDrj9M6OnIM6rh94TmQHjVhsytqs92QSMTKM/P9i6CybzVdcuVrTm64qgQybug4TQBRHFxQ4tKXj/6/vLVJ0G+U6Ngp5pIMDHcqeWpClHwe/7xEUrI0avM0aNwMzFDY9vC1w18EqxYwXt72PHq1fbFFdrC5/rXqL4uMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmKNOL+i; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmKNOL+i"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f5660c2fdso28698025ad.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2025 14:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739485666; x=1740090466; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i3pHpUOx4Bzac0PEvcEExnfgR5f1xY4NTczJyuw5flo=;
        b=NmKNOL+iGpuZRt+AEu8vcSRNA91nHre+MfkF7wjHLh6rT7mYFjgJE/YDuaH38IvB3s
         A0jEB1KXEl9n+qdHKhQXGlc0i66n1YFD5FqP0mbGgOscrOPuE4JDKhR/UTBbSSlg8IOX
         SwS2JpLGhIar1WeUVJpY1I/nSPriE7e5GGVR9TeZTs6MYggaFH6+aEFHN6r6LadR+yWd
         s4kIuk29OxMQU4KZ8eXIMT3XEQblpXtmNghGHA/JvJCP1qeW5zkcS9+r8mnFy+s26e6c
         IH6T1YE7SPio/NwQQfNsNMnCKpvbv78mg/Kzjmw/kZivou3uVdfB5uzRxN/KkeI8G31b
         5OhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739485666; x=1740090466;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i3pHpUOx4Bzac0PEvcEExnfgR5f1xY4NTczJyuw5flo=;
        b=YUTIYZXGMvBLArfw0HO2vNEFdDZbG3tEnQ1OV6caL+8ObVSR8NVqHz+k2vtyZEHyQJ
         egFygf3CbVeOqen+M28pY2gWva177CiR8Vh115uw2qFMVOEu+32LxUgDBc6/BqrYVGcR
         7rG0e8edTDFXWtQf94R9lIMitvM5wfOldB+2Wg/r7luyemLg12MRbA/p/dg9t19ANcVY
         Hyc6SUjk0lQBfRuLcSfVBzfYRcx171oqfHe1VQ2K8vHHI/do9rUNF8l988kXT4OY89aR
         gOmj6TFkA/XcOAvCWtYlxgvV2/f1zRhfxxF/k1dE6Y2fUMFHI/6+rgzMcFIi4UufESBS
         129w==
X-Gm-Message-State: AOJu0YyOgIVU/0c/HhQT4uZL8R9zsuyzSaHv/+ihjqe1sNbDoTmgxa0/
	Veh3vLYJYa4jnmYHLjrj9kvoeLiW43YAchqOli/4yw7k2U45SL476Hmlrw==
X-Gm-Gg: ASbGncuXnVqZPIFtbgdD9cXfxIgWoc+mWP19WXv+OAya+MixJ6E4F1PNK/KyZRHCvyl
	Ka2OVXF0uxZfmI9UiWxvGXKEeFPfxUW3B/UvFWtBNmfRlMuYAuZfyM6VuI+yQo51KeVU9ByIpFN
	300cwKg+HzQwJ8KLOYFSGYqaclE4xZgetNkK+5Wr1n31iWWMu0JLhkDhWFh3Gyc7N+Udh84fyEQ
	hZZTKRhpcBgdw7sk8Rkq7szl9n/GO/AMm9n0KOaHKh8dzLNuUmOQrEN5uzgmd4iIowx6PpKfBod
	iYZnlpFbI53S8jz6Wl4U1A==
X-Google-Smtp-Source: AGHT+IG6W4VgJP/309qDU8LE05xZetzQAPk/YK32pAqBOzaiC6SO0ihmvViEM0xSiT/+cvznjOxrjg==
X-Received: by 2002:a17:902:ef4c:b0:215:b1a3:4701 with SMTP id d9443c01a7336-220d1ec5362mr65383325ad.13.1739485665596;
        Thu, 13 Feb 2025 14:27:45 -0800 (PST)
Received: from [172.17.0.2] ([52.234.41.124])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53491dfsm17434285ad.3.2025.02.13.14.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 14:27:45 -0800 (PST)
Message-ID: <67ae71e1.170a0220.69f3b.9ade@mx.google.com>
Date: Thu, 13 Feb 2025 14:27:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0446896310150194414=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arnd@kernel.org
Subject: RE: hid: intel-thc: fix CONFIG_HID dependency
In-Reply-To: <20250123134908.805346-1-arnd@kernel.org>
References: <20250123134908.805346-1-arnd@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0446896310150194414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=927825

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.22 seconds
SubjectPrefix                 FAIL      0.36 seconds
BuildKernel                   PASS      23.92 seconds
CheckAllWarning               PASS      26.68 seconds
CheckSparse                   PASS      30.26 seconds
BuildKernel32                 PASS      23.83 seconds
TestRunnerSetup               PASS      428.49 seconds
TestRunner_l2cap-tester       FAIL      0.09 seconds
TestRunner_iso-tester         FAIL      0.09 seconds
TestRunner_bnep-tester        FAIL      0.14 seconds
TestRunner_mgmt-tester        FAIL      0.18 seconds
TestRunner_rfcomm-tester      FAIL      0.16 seconds
TestRunner_sco-tester         FAIL      0.09 seconds
TestRunner_ioctl-tester       FAIL      0.08 seconds
TestRunner_mesh-tester        FAIL      0.09 seconds
TestRunner_smp-tester         FAIL      0.09 seconds
TestRunner_userchan-tester    FAIL      0.08 seconds
IncrementalBuild              PENDING   0.48 seconds

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
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:

Could not access KVM kernel module: No such file or directory
qemu-system-x86_64: failed to initialize KVM: No such file or directory
qemu-system-x86_64: Back to tcg accelerator
qemu-system-x86_64: CPU model 'host' requires KVM
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:

Could not access KVM kernel module: No such file or directory
qemu-system-x86_64: failed to initialize KVM: No such file or directory
qemu-system-x86_64: Back to tcg accelerator
qemu-system-x86_64: CPU model 'host' requires KVM
##############################
Test: TestRunner_bnep-tester - FAIL
Desc: Run bnep-tester with test-runner
Output:

Could not access KVM kernel module: No such file or directory
qemu-system-x86_64: failed to initialize KVM: No such file or directory
qemu-system-x86_64: Back to tcg accelerator
qemu-system-x86_64: CPU model 'host' requires KVM
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:

Could not access KVM kernel module: No such file or directory
qemu-system-x86_64: failed to initialize KVM: No such file or directory
qemu-system-x86_64: Back to tcg accelerator
qemu-system-x86_64: CPU model 'host' requires KVM
##############################
Test: TestRunner_rfcomm-tester - FAIL
Desc: Run rfcomm-tester with test-runner
Output:

Could not access KVM kernel module: No such file or directory
qemu-system-x86_64: failed to initialize KVM: No such file or directory
qemu-system-x86_64: Back to tcg accelerator
qemu-system-x86_64: CPU model 'host' requires KVM
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:

Could not access KVM kernel module: No such file or directory
qemu-system-x86_64: failed to initialize KVM: No such file or directory
qemu-system-x86_64: Back to tcg accelerator
qemu-system-x86_64: CPU model 'host' requires KVM
##############################
Test: TestRunner_ioctl-tester - FAIL
Desc: Run ioctl-tester with test-runner
Output:

Could not access KVM kernel module: No such file or directory
qemu-system-x86_64: failed to initialize KVM: No such file or directory
qemu-system-x86_64: Back to tcg accelerator
qemu-system-x86_64: CPU model 'host' requires KVM
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:

Could not access KVM kernel module: No such file or directory
qemu-system-x86_64: failed to initialize KVM: No such file or directory
qemu-system-x86_64: Back to tcg accelerator
qemu-system-x86_64: CPU model 'host' requires KVM
##############################
Test: TestRunner_smp-tester - FAIL
Desc: Run smp-tester with test-runner
Output:

Could not access KVM kernel module: No such file or directory
qemu-system-x86_64: failed to initialize KVM: No such file or directory
qemu-system-x86_64: Back to tcg accelerator
qemu-system-x86_64: CPU model 'host' requires KVM
##############################
Test: TestRunner_userchan-tester - FAIL
Desc: Run userchan-tester with test-runner
Output:

Could not access KVM kernel module: No such file or directory
qemu-system-x86_64: failed to initialize KVM: No such file or directory
qemu-system-x86_64: Back to tcg accelerator
qemu-system-x86_64: CPU model 'host' requires KVM
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0446896310150194414==--
