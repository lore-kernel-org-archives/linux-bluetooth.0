Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC11230274
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Jun 2025 23:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749857645; cv=none; b=Ss0sRb9TqoslG3XmHx8EdiPsrgL3TqQDCVgTQzHmZSjM6atWXn1G4h3hP7s8V9nZPkjfss1iQZJlWfLckLKzI6qv0EkGQNyo3spG6saf1zwMB3yzQcnz0rF374kIlGfQt/4iu9+5gX8eMs4VHEp3DGeAHoWRIsGOshKMeRHkaRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749857645; c=relaxed/simple;
	bh=ghPLo9ms+0cdSTWCvCNqNNqimlPdVF7nB/bX54G6pIk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VBAurRHd9wbY5SUntR0GaTFU2w882LCs3CqFMGU+hEqNZc6NuMCA573NJ7hD+1XXdtt1nOQ8QYRlf6jzOsTTO8TGuRNNTYjnqNrAUUwlLxp8DfgOiSZAWgnpOgFZVLG0mpGTcSjLpMw3QcGO2/1CXuSJ9UtSm0eNd4/tKSdEoT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMSdv+w6; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMSdv+w6"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a4bb155edeso32587231cf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Jun 2025 16:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749857642; x=1750462442; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+x7718/gbwnkYwCWC9p5qskC7PHsb26hK69tkNx63o8=;
        b=QMSdv+w6RyVXwEhQZ+DbChNPYpxWhMqqIPZLnYPf463QP/DpSFeHE20BXr1dXVgr//
         oSKQqzz82nlNq10l4Ymc3AVAghEN4djGIAtw5QI6Jt4DDChdfkkmz1nPmUzoeK1+LFxs
         r5JYw7lso+mWd7HZt9Ruee6SvIKm1KNZO7zP+rde3HuMq/QkI2OUDlchfmBlAbdwoS9w
         y3O59pTUoo73SzhT1s0reNdwxPVXhljZPS0d4leXi8m2f6QHc6Zr5coeZnZuSWMQHg/A
         D2GaHNQDgw59/FSPxNQg3FXSmJbu7oo0PYHzNaFENZGu8cCIMI3F8yRMov8dqduW8ZyW
         ZWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749857642; x=1750462442;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+x7718/gbwnkYwCWC9p5qskC7PHsb26hK69tkNx63o8=;
        b=jH6JA7MwfJx3nYR/xk1RK1ldcWDSgrZxRl8NwYNGdOAthO0F7xdcnY+2lzDOQ/W2hy
         e+0JWDeHYnrp0IiEYkhGmW9WNsu0QjuynzPAbsuSPL85APdkFvd5TOLTECMotESq0DaK
         2bCdJLi8q3l68wO+zIV4MMIuy58LVy6QZX9ksX4wF2mVSGVpS0/OEWXDkKLPZIGMjGCd
         iKF8jFMU5JNMp3KWmTZTqqT1qevwEUrMQgcQeilfHn2gUmaFB3HWPJobHBRIqBhWm2AO
         mdyv0EUndyyAlycV30MldVVt+iAwZyLs0neISZ/p0RPuOF1kxvCl3B50Uc2CkuisaEY/
         z4og==
X-Gm-Message-State: AOJu0YwP2jy8IatqRKHuoBcQwGxbtHedCdp8r1+vr9PeY9X2XtY1gmkc
	LjYrgGLLXlI5/nMSdQL6nohhKdRUom1vUpjZnQjYbTIlcvWBw4y7CWByVIprQQ==
X-Gm-Gg: ASbGnctWO+lzRB17DlDyjBAgwVMrZ/OFEBYwtMVgUioiJv4RBNLPxKNxtjy1HPdfDTr
	ibV3noVXT26fNcxTfzs87Wu+Pu5Br9cNLuNsswPvzJc/i7z/Z1TEP+rRm9fCVJUYSYuakC1+Ws1
	DNP3yLQl5B83sv1xOuzVv3F2zBidCkwwuaChZeCRc4hPUW3RJUqH2UWZK4pr8iINeSNaMaePo86
	qQAFw4MTAaXHJBTXQhhsrND1Y9bmamlqAY9Z2xVfEGHrkLR0/uA5QqHb7/SfQqoCRrYsLKiEOQi
	nfNPaNfMLCeFSVJUgGcsPtG/LadnaZN6eOt9bBGmMgTp9c/dt7zC0woFs+mYN7ComSvg
X-Google-Smtp-Source: AGHT+IHKabso894yb6Claw2KV3yersvOh1Nxdr+vPOLyo3SIALcZdPXq1XVnFz2LckegPYMAQZBaDg==
X-Received: by 2002:a05:622a:1820:b0:48c:54ad:c409 with SMTP id d75a77b69052e-4a73c4fd287mr14517471cf.10.1749857642508;
        Fri, 13 Jun 2025 16:34:02 -0700 (PDT)
Received: from [172.17.0.2] ([48.217.44.220])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a72a315c58sm23053161cf.36.2025.06.13.16.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 16:34:02 -0700 (PDT)
Message-ID: <684cb56a.c80a0220.7fb1f.b9e7@mx.google.com>
Date: Fri, 13 Jun 2025 16:34:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8382948741793499734=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kuni1840@gmail.com
Subject: RE: [v1] bluetooth: hci_core: Fix use-after-free in vhci_flush().
In-Reply-To: <20250613230228.1243343-1-kuni1840@gmail.com>
References: <20250613230228.1243343-1-kuni1840@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8382948741793499734==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=972027

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.32 seconds
SubjectPrefix                 FAIL      0.30 seconds
BuildKernel                   PASS      24.78 seconds
CheckAllWarning               PASS      27.17 seconds
CheckSparse                   WARNING   30.51 seconds
BuildKernel32                 PASS      24.54 seconds
TestRunnerSetup               PASS      461.88 seconds
TestRunner_l2cap-tester       PASS      24.94 seconds
TestRunner_iso-tester         FAIL      7.68 seconds
TestRunner_bnep-tester        PASS      5.92 seconds
TestRunner_mgmt-tester        PASS      131.78 seconds
TestRunner_rfcomm-tester      PASS      9.27 seconds
TestRunner_sco-tester         PASS      14.67 seconds
TestRunner_ioctl-tester       PASS      11.73 seconds
TestRunner_mesh-tester        FAIL      7.37 seconds
TestRunner_smp-tester         PASS      8.45 seconds
TestRunner_userchan-tester    PASS      6.08 seconds
IncrementalBuild              PENDING   0.78 seconds

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
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76b/0x7d0
WARNING: CPU: 0 PID: 68 at kernel/workqueue.c:2257 __queue_work+0x93e/0xba0
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.148 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8382948741793499734==--
