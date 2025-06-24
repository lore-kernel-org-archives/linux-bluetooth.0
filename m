Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F50F158218
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jun 2025 06:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750745077; cv=none; b=glDyP6BhcMOBtPFweUUyBgJ+dvxuu0lcCdaxIMOVqesvslw/zOcTlRu9LtjgwDxpwRJsiqVzn2QxTe+rRL/knixbACci2IMhIA3jsOEdEUX1m1/Kwv1Eanu+H+EVffLqjFytfI7dMB5aLV8E+6gbvlA5wmtHH2yRP9fGFO+v4W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750745077; c=relaxed/simple;
	bh=9KVVYtPNWl/cwWE+bzQ3ccQQ1M+BIvywrP0P6EZeVVc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qZCV1Rq3TDNay1nekbVowo9orbowgUUoI5LK4ygK0agA0sLBPucZhdrnLpAKs3mpZ9+gQkXm9EHxWUXWNxA54TsPz7NtVxWi3HF9FaPAToRG1wG5We89VZvQq6KYqaPaB+0VH43sbY8zVKtSxOnQoKTs6OYpCHa+nNMb79ovkCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTvQd+I3; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTvQd+I3"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6faf66905baso74902436d6.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jun 2025 23:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750745075; x=1751349875; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a633PEmI68MDvV7oekWfRMZ4wh+5vd3gskiFjo+7JNY=;
        b=mTvQd+I3eZt6T6TEEE0L5xKIvqG2R2p2y9ddTiIoomYME4mg5gM3OmTCnXqplWVpyt
         s7sQoQ3r5nyxX174HrAJTnaRNiPIiDqYSCKuFOs4X+UeGcTHmhxaTYQrY6N4mvtIvPWY
         L5O6Uh+jEyNG8GrtOFSoRN06FxSOx27L4NRsMDt509NW1axVEy1CB+LCy/6p4FxFMN+l
         Nibdix5pr+R/4a+hNuOjzX4ognQsZpKJcOCB2T87ByM8HzOGyTQPm09SgtAVy45vyXCj
         NANvPjpxoV6XL3Pe5wQGgUt5dsSyA99deQ+4TidamWHBiTINs2j57rk+UTSYf7tFDqOy
         N5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750745075; x=1751349875;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a633PEmI68MDvV7oekWfRMZ4wh+5vd3gskiFjo+7JNY=;
        b=pDZuPlRBNUsbkftCbPJERnLi/0LfYk4ZffLrkBW14CjJpBo6QShTheKkdl8Jrlbk0j
         f6N4xdPR1tFaeV8WDlt6eZ0vznFyj+ptIFyspidHyNufp9V2gkXUv1hemjHwJ97wepTj
         LbxuHONYg1AAYGOioxCdUtUl6dmqcK61NUfg0YDKhhPeVbr9piZ74OntyVFxBVb+DRim
         6EfWEaH2N+HmkQUNGV6xdOShpCbLlxTlFV2s8ySEplzFmgJFJVREOCsDvIBmwuNdq9pB
         zwE2cpbE0HQhh5hoj8SQnmzXoggUv2iSCFs045A9w20mj8ExjM9FFRyKbL8a8rCvoi76
         bZDA==
X-Gm-Message-State: AOJu0YzV3bG+T5/iuJDD7run5uClEyYoCbwUiEPUTgjdci93+gjeCPXi
	zhY+F/LOM62SxZ9hVeMENrmAS6JVhZxz14/k7KoF/QiESQg/TKRo8wfD0BiwbQ==
X-Gm-Gg: ASbGncvTEZnhaQJw85GX+aXZixRIRmDtwmMKoHset1UnVw9vjz2OJyrghHyHJYDPJGX
	6VGGA0F1BaXRIFsnF3BC779VkZc/Ykpr5GGMdd44/NKkvaGvsmUJKFUa6xZuzaJtQYq8PPDlY9N
	4t4tr1CFX/9OCHpAuF/22BjD8qf03Memw5ztOMJ16vxOMQMoDrczlWd6Bj4Esqum8VzFJjD1VuQ
	15iDR/i8QDsBPMgujqoPX96FpVXYzyJjpHlDs3qqEMJxFLcRZnmeQfCf9NHdFGy05oFyWVFqsFX
	A74wUkcLL3Z/Xiqm+lQX3jvLBRchepKSNH++3yW2wwckcQr1Q6e480KX/OjugVAaECT+OMSZCEe
	LfX4=
X-Google-Smtp-Source: AGHT+IHJWBB1XigqccesPmlSK6STapGxdLdWfUvl4xTWP6C+z1DbKwna6dRcJaylLjSHFDbRvplcAw==
X-Received: by 2002:a05:6214:5b81:b0:6f2:d45c:4a35 with SMTP id 6a1803df08f44-6fd0a5c09ddmr278073436d6.37.1750745074842;
        Mon, 23 Jun 2025 23:04:34 -0700 (PDT)
Received: from [172.17.0.2] ([68.154.31.203])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd09593450sm53352286d6.98.2025.06.23.23.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 23:04:34 -0700 (PDT)
Message-ID: <685a3ff2.050a0220.304a03.19c9@mx.google.com>
Date: Mon, 23 Jun 2025 23:04:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2589696669638360599=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: Bluetooth: hci_event: Add support for handling LE BIG Sync Lost event
In-Reply-To: <20250624-handle_big_sync_lost_event-v1-1-c32ce37dd6a5@amlogic.com>
References: <20250624-handle_big_sync_lost_event-v1-1-c32ce37dd6a5@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2589696669638360599==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=975118

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.80 seconds
CheckAllWarning               PASS      27.16 seconds
CheckSparse                   WARNING   30.70 seconds
BuildKernel32                 PASS      24.35 seconds
TestRunnerSetup               PASS      473.69 seconds
TestRunner_l2cap-tester       PASS      25.59 seconds
TestRunner_iso-tester         PASS      42.43 seconds
TestRunner_bnep-tester        PASS      5.99 seconds
TestRunner_mgmt-tester        FAIL      135.12 seconds
TestRunner_rfcomm-tester      PASS      9.42 seconds
TestRunner_sco-tester         PASS      14.95 seconds
TestRunner_ioctl-tester       PASS      10.09 seconds
TestRunner_mesh-tester        PASS      7.56 seconds
TestRunner_smp-tester         PASS      8.65 seconds
TestRunner_userchan-tester    PASS      6.34 seconds
IncrementalBuild              PENDING   1.02 seconds

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
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.231 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.155 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2589696669638360599==--
