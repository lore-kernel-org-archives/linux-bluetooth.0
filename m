Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3394F4C8F
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2025 03:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740367480; cv=none; b=U5k54kK7RS/bzAOX+7FYQcwWv1JwftSe/5fI7+B8eS/9U3DV4hj3DXE9KnP+aIDYgoCeF0sK0ym5UFgUDFjgLqv04EII7TZMDTvmUvYa+wfKDL0sz44S7MYohg3Q58xIycF9JGDuUcJaKd3fNVMQAHkHp5rlF9yhJJVtskm3x1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740367480; c=relaxed/simple;
	bh=p6FRovY8Kg916F/vgYS8SVHJbsaJzvdT4OqPgeT55q0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fBRWhDurZsviu0cl9cFPPncmQxUWeMmhaJX7FGEQz0Va+YGEz7L/LgOeyf3RflpNk+S/5D7o2CVhCQrJ1Dp3DxrNLENGNfAeBYPeEI/0a1HxvZeuFEzKgyxrqvFob8sPtwG94jUZuUtoGVJ6fw1IYtXinjmhzMHWeOpIablIIFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7LM/pWU; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7LM/pWU"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-221050f3f00so85558025ad.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Feb 2025 19:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740367478; x=1740972278; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j+5YqKvdNmovZL2oaSmgpgovHXZo2itpPmIiOg4e218=;
        b=I7LM/pWU+chFL2xbeLAlb1p7sLYuwaeHylsLMVND8fElqtK7MSsfpgk1nfiN1v4Jph
         GisfOZZZ19Rtq4np7B4LG/T/NrrFyr77Vs8MqDuB1LVfk2CHxVuXpW69E9uAsvPYAmZe
         5md/PXVnIqTa5H9OPDs4JubXMF2hkmAVuwBXWgJo+kfD0TjRzapJGdnIMiwghqybqVTz
         3e3g/j2OuocWoZIFZEquN7VJ1GkHns9q1Kx4woGp/cIiSHNVkxFAhET+CTLmMP+Cc+be
         LVQmLArrlgNHN9DmeCp3wTSTDaqRPe8fyc8SkNu4voQBReVxcCMShymEfFL8CsAZZaUH
         cf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740367478; x=1740972278;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+5YqKvdNmovZL2oaSmgpgovHXZo2itpPmIiOg4e218=;
        b=XPxDtGx81ZT2dL1uiwYee0nErRp1RpfmcndyxNZeSQcYxycSvq7yEdNsgx9/sbAROL
         QmmIiXd8HUzFeSCcyQiEC8P/UMId60DnxploH2VBl0vNaPvKS9PTGVKhQJk/qti7J0R7
         Z+XnFLaQCUs8yH4ZOufqRRtrggjBRmae/5TGZVIdYwL1UawmCYQKCQpsmASNpE7OU9VT
         GL80JPj+CccW0tOwRPQtvsFqTKQhBlmhRjUHjtGs+5jzbRWZ+xT/zc7VI9QojoWsbtcT
         hFSrmnmQJMlK0VbcfL0Woy/5JnC8/8zr21t8o53i2aCNlCj6jYCnAfMk4aDrP2AGwnqV
         F6tg==
X-Gm-Message-State: AOJu0YwsSFQQ9OGhu1oJ0MOfe2k91JNhk88OdA5yxpO1m57z5PfUTyqX
	0yswmXhjxf5UfF6Qz83lt6Bi27u/Sk3Rs0nF/SKRj3GH+N8FR3A8Zu3f/A==
X-Gm-Gg: ASbGnctMxgUu8YYjTElSKzwBblH8nNmjVAR1Y4+XwM0T71Y6y8gHlnvvG2je0JXbuvH
	p/XgaSDupU4/gTWgAlr3UC+RcZRgo8Ft2ZpcAhnXJypYTDnYFHdR6dGAxxoYeRs1tshyUo+WAyG
	L52P1VlE8PrfirpSzdSKsH3W15WLVpSJkk9bsi35isgJuFSrB8NKr6TxEkhs+hQxV6YkhyaaLEy
	QllEkH3I9R/3xyMZWDGhiNNS5dk2PrvnDmG3FXh8chSZ2qzVdUdrdBzCEtrWLfaRbHYO5wuVglb
	pS+tvrtj4g2YxgmJSRS/a+0rYUX5o9gN
X-Google-Smtp-Source: AGHT+IFtJhaSeJTtxqLgcuXJ5PAgfLBZ76zm9pJnFTL70LMZyj1xwFDPXvkxwOL6vI2myqnjqdimeg==
X-Received: by 2002:a17:902:d502:b0:215:e685:fa25 with SMTP id d9443c01a7336-2219ff4ecb5mr166312545ad.20.1740367478095;
        Sun, 23 Feb 2025 19:24:38 -0800 (PST)
Received: from [172.17.0.2] ([52.234.33.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5596133sm171124395ad.259.2025.02.23.19.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 19:24:37 -0800 (PST)
Message-ID: <67bbe675.170a0220.1f8f5e.46ce@mx.google.com>
Date: Sun, 23 Feb 2025 19:24:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4566363985241914207=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chharry@google.com
Subject: RE: Bluetooth: btusb: Configure altsetting for USER_CHANNEL
In-Reply-To: <20250224022447.1141413-1-chharry@google.com>
References: <20250224022447.1141413-1-chharry@google.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4566363985241914207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=936859

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.33 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      24.31 seconds
CheckAllWarning               PASS      26.77 seconds
CheckSparse                   PASS      30.62 seconds
BuildKernel32                 PASS      24.18 seconds
TestRunnerSetup               PASS      428.79 seconds
TestRunner_l2cap-tester       PASS      21.02 seconds
TestRunner_iso-tester         PASS      37.62 seconds
TestRunner_bnep-tester        PASS      4.69 seconds
TestRunner_mgmt-tester        FAIL      122.71 seconds
TestRunner_rfcomm-tester      PASS      7.92 seconds
TestRunner_sco-tester         PASS      10.94 seconds
TestRunner_ioctl-tester       PASS      8.18 seconds
TestRunner_mesh-tester        PASS      6.09 seconds
TestRunner_smp-tester         PASS      7.23 seconds
TestRunner_userchan-tester    PASS      4.91 seconds
IncrementalBuild              PENDING   0.80 seconds

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
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.170 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4566363985241914207==--
