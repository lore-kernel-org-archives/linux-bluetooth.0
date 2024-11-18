Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB531E7655
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 20:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731963404; cv=none; b=pK1Py0i35+H4Z6TqbPhRsskbDLfcsx18G6eevPtxY4c5ZCQtPQsyPhuyyoOIjGzlPZG6MPGbHf+BAeQYkCk6CXO/stwKpgry/vUjEF5LMPyihsHp+Z89C6+THo12g8deA10QmLsh+Jc0oGyehLlvv1bKcxIoURZ1bSl7u6RCRm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731963404; c=relaxed/simple;
	bh=Xsfxx5iUgK/PZNM8wNUBQ7RyAUV+aLamb8pr6sLmaaI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lrD+dMCOetAZ28oZSdInAj70MSs6SwsKj6KidFShjrt9Ji3yr81OKxMfQHKrBdV7PCyIZefU3iKd0/VE6rDrO5N44ouH/vLg67RFxzq+saXGkoXDRpAg8n85DufTHnYP7i2hmhwSNyonTuQ1nLZ7oyc9pkG/nZB6csG8hob5Yl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwYx/UWl; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwYx/UWl"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e38b2d868c8so681568276.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 12:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731963401; x=1732568201; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CytWLO0CLWSJa51b6dj2dZQRN/PEGRmerBN9r+HOmkk=;
        b=VwYx/UWlC2jrl4NzBP9FmfxG7M/diJx/dP4b8+SsUa+eFnPoZxqCautwqOrY2Oz1BS
         rw+h+ONLukKoSmY/5d+UAeuqlp3BbWjpVdAPY8u3k+9RvRHZBLm6r/NJMIYLPLqoTUfW
         Ff2oBc6X/qUagIHpuUhavggpvwW7atJae3FtNbGqCORoR9aJbMLo7Xu9Oyaov0pDquoC
         ju+UEiYey8T5Q0RHYpuyml5S9MxlFLpsdBa1AJKI2mMthTt/00YLp0BHjCj1ob7oEtgz
         li7eFcpLIfv1dFriSkxGHc5fj/02WPjB8vC67AVuUg5xYjDR8BsJ2GHazti2VGTIwZZs
         kdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731963401; x=1732568201;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CytWLO0CLWSJa51b6dj2dZQRN/PEGRmerBN9r+HOmkk=;
        b=D63DHyfW1kkNjTxLIRtXG8kM/mWR/Q/Et0gmD7dcXvUPFTp3HOshUzz07nJCBbUpAs
         A5zYovq/A69MZKvTV2dF/Sqf5FpcEHm3XA61v3VvbWO8Z6cgNw7OBSVRLAeeAz9TzyKj
         IAEYa7crYcIyl7gjAlTuknB2My1LuVJy9iFzNBV3zRr2hdR5gjvNZO6E1wYeERTklzHK
         Z2Cot33Wd1xRUR805eEvREoivQn4lzM0GMftNVzkECmdMTeevhZMXHKVk1f/Nwc1d/to
         9rXU/6Br035mdBZSUbx5rSW62j+eol9gZ30m1V2RfJr9t1/lTv1v7Xd49jhSBz0c2sDN
         v8jg==
X-Gm-Message-State: AOJu0YzH2sa/L2VU6d6/VWoW+hBrDA6Hd9OL/HGbH/8LVOwXcJD6JRpd
	ojh7NUi50kRAoKqmDBa/Mm/N6wMI9vNvUf/rxd6jMwHavGgfKRwaoFhV0Q==
X-Google-Smtp-Source: AGHT+IGvPeRhtSc6C6NCJP2U/Xy5QjzvKXpPHQ9Fmt2GKHiDx5emNzISUL+3kHid8+cSkJqG13MSew==
X-Received: by 2002:a05:6902:1083:b0:e38:8a2e:e3bc with SMTP id 3f1490d57ef6-e388a2eedc8mr6535239276.5.1731963401509;
        Mon, 18 Nov 2024 12:56:41 -0800 (PST)
Received: from [172.17.0.2] ([172.200.199.248])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d40dc3eca1sm40036806d6.57.2024.11.18.12.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 12:56:41 -0800 (PST)
Message-ID: <673baa09.d40a0220.1381e2.9cb7@mx.google.com>
Date: Mon, 18 Nov 2024 12:56:41 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5128005866911877621=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v5] Bluetooth: MGMT: Fix slab-use-after-free Read in set_powered_sync
In-Reply-To: <20241118203337.2648476-1-luiz.dentz@gmail.com>
References: <20241118203337.2648476-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5128005866911877621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=910738

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.19 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      24.61 seconds
CheckAllWarning               PASS      27.40 seconds
CheckSparse                   PASS      30.66 seconds
BuildKernel32                 PASS      24.85 seconds
TestRunnerSetup               PASS      437.88 seconds
TestRunner_l2cap-tester       PASS      22.38 seconds
TestRunner_iso-tester         FAIL      26.77 seconds
TestRunner_bnep-tester        PASS      4.83 seconds
TestRunner_mgmt-tester        PASS      119.03 seconds
TestRunner_rfcomm-tester      PASS      7.71 seconds
TestRunner_sco-tester         PASS      11.59 seconds
TestRunner_ioctl-tester       PASS      8.31 seconds
TestRunner_mesh-tester        PASS      6.15 seconds
TestRunner_smp-tester         PASS      7.03 seconds
TestRunner_userchan-tester    PASS      5.12 seconds
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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
Total: 124, Passed: 120 (96.8%), Failed: 0, Not Run: 4
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5128005866911877621==--
