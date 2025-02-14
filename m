Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3598263F3C
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 11:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739533840; cv=none; b=btberMXe5V1HHBoOnaGDr1JDjOGApomii+WC+9+tjVypV0Sb6Hk5FHzDUHFnc6f/rHCO2YhvcbUqQ4fuaQk3vMAW8PNZdrg7G4LN17pN3rKECGPXdorVCbNlGsIBOTGO0tSn4EhAdIlas9114ffQBVV19xShq+D0dJ9LLWtygbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739533840; c=relaxed/simple;
	bh=TrNi+BWY9nzRP+p1y3Uy1gVP1AMPSjeO6mLd7GmHK3U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aHuZqgLbwFUUrqNNSa8/WtBkLcanrtonzC9vbMka+C6pMy34bd8aBESyOd178ULEWTAfC2QsXRagK+/Xv/u3Yfhxq6r8EudEHO1HCorKfVUOAu96FS5df/ifsQKKglanIzVNzo1upEizRYxZVj51EmqtpAWeJg9iyTdM12xCabw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPt43iox; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPt43iox"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e4468b7099so14987366d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 03:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739533837; x=1740138637; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A355p97gvzk/6hc2hkRZ8NtTuJZesK8LB70pc8ABY3I=;
        b=WPt43ioxI3FCwSaCtBbi66R77l7QNh2I028A3kdJ4xuxqsTLVa1IYLiL5kP0Ig318F
         oJ7bGEXlTRdrjU73k3Bzh5pbmyLq/BReYdOqa7wDfXnL/r2lF6KopiSiwVmneyGCIUvE
         sBfd0b72kRmF9wxYbtA2w76ADOI3kHqPWxPSJLUJTwEgEtv6saVrVy+AEfJxuvKzLgS7
         5jqmqLtoGgA8OzZKFHfBQw2lSLNTorYxM2+jT8+ji9Lx2vXkk0TP3g3F/EG2p5UwuVQ3
         GmMAUYyCua6vn8GfkSBKC1hNaFnYTzGfFY7ZglejhjPeoscb9RO7SgSeVGQN3m2vno7q
         5GPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739533837; x=1740138637;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A355p97gvzk/6hc2hkRZ8NtTuJZesK8LB70pc8ABY3I=;
        b=nbi+RZ4a9n3RC1IQ4jsCau1KqiQFSVUq1ZmfAkQQbHM7rKcZI8wnK9ngxJCzQ6HwSN
         /iRl2mEMTnB86WDyGh60PXLXWjiff3xwS4nlHAIE7bPpY7Pi2M/kmEvlVfpadKINqtj8
         30rewHQOH+QV5LEMlkzV59KjsxaLGn8BWnveU093R3qwb+PCMBF/VMmcICmnsn5BS3nh
         pTsMhaZFR7UJkzE4VteN2PBMLYPr3GMge5lk/dAAO5UGc32kIZlkCt1tDjhprTW9ztb/
         EJYYa1rLyxogFFgaQO32OEISujBmb8IkjxPzIPyZbqyn0lwqkoapfZPcr1f2l8Dx8u9g
         T4aw==
X-Gm-Message-State: AOJu0YzGY96lCZ8gZjQmNAsnE80lPSiVxzMmLfQrszt8whYHouW89sbY
	OCe2VjdsAnTAyVVsyC0ItRHcwfu7dWFWZjpEm2O28XNDbKcDcgOJTHYhUQ==
X-Gm-Gg: ASbGncsSBtJZDujbIMN25nR0xraZkTxCz6nG9fpoxInM1CfYvcTo/9PXchTkd/NzYDe
	icuuLyoH7pp3xgU8FIGqByRaPfy6KrSMxD9geWanAaYax72Q/LBtMSRBUKk1iOS3VerxUMhGZgm
	muqu5xWwvb9N0XuuM/WaVajJi8hoIjKJtWBD9fmILKFD9FUnEYHK1epGrzDfvDq19UgfIVPjFO6
	l+HruizTrEncE6WZCd+WrCvx7Ps+iBdK6SvTc5/jUFAXBlrb8Ti0rIjaJkIjWmJsoqBVR/mofZP
	TSkq32uBH6g6T9Rg25ctFg==
X-Google-Smtp-Source: AGHT+IEGeYkZPYdGPJ8l4r36JPHxR4lLdBiLtKqRzpU7CD2leXzkF6ObpvvplYU5Recib0HvyCdHew==
X-Received: by 2002:a0c:ed47:0:b0:6e6:5ec3:868e with SMTP id 6a1803df08f44-6e65ec38accmr66724546d6.31.1739533837568;
        Fri, 14 Feb 2025 03:50:37 -0800 (PST)
Received: from [172.17.0.2] ([104.45.201.76])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d786020sm20138336d6.46.2025.02.14.03.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 03:50:37 -0800 (PST)
Message-ID: <67af2e0d.0c0a0220.9de22.6506@mx.google.com>
Date: Fri, 14 Feb 2025 03:50:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3775226494969898695=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chharry@google.com
Subject: RE: [v5] Bluetooth: Fix possible race with userspace of sysfs isoc_alt
In-Reply-To: <20250214191615.v5.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
References: <20250214191615.v5.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3775226494969898695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=933982

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.20 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      23.96 seconds
CheckAllWarning               PASS      26.59 seconds
CheckSparse                   PASS      30.50 seconds
BuildKernel32                 PASS      23.98 seconds
TestRunnerSetup               PASS      430.81 seconds
TestRunner_l2cap-tester       FAIL      0.69 seconds
TestRunner_iso-tester         FAIL      0.31 seconds
TestRunner_bnep-tester        FAIL      0.21 seconds
TestRunner_mgmt-tester        FAIL      0.17 seconds
TestRunner_rfcomm-tester      FAIL      0.17 seconds
TestRunner_sco-tester         FAIL      0.15 seconds
TestRunner_ioctl-tester       FAIL      0.18 seconds
TestRunner_mesh-tester        FAIL      0.15 seconds
TestRunner_smp-tester         FAIL      0.15 seconds
TestRunner_userchan-tester    FAIL      0.15 seconds
IncrementalBuild              PENDING   0.51 seconds

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


--===============3775226494969898695==--
