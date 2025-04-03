Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E509255231
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Apr 2025 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707052; cv=none; b=qq//ldkqUDvZpvhFJysW8QL/MJHJi4F4mTFz0NJxUr3bqeTJZk22kUX0p8iv9MdQS2P6TDDotVH04+BtOOjZklj93olaQrUwDdiuWBraqRz8zOSLnAxCiQ+7lZqHUfAkDETxE7wm4BYVmxYMwibqz9572Pa6tJ2fnow8WoFbpxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707052; c=relaxed/simple;
	bh=GRM+G/ln7VcwaBSi7kZRXXfsYNRcNfS6qduNbaCaV38=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZESB+rdI5NfjHSrmR8WqMu2j0IDl8ME73WfToFNPXyDddccorl6EFDjcleq7LTW9l2r3bYoQZ9VD1T5FeiIvdEVb7dLjTl5NnF4KdXtl6evj5SY5V6cddUvcZS86WOvCC9x67NW/GLHWPFFpGqNzbJLpwnq7RA7/MTpSdcm1DtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/IjPJcR; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/IjPJcR"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so1218507b3a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Apr 2025 12:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743707049; x=1744311849; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S8YiNHG6IFBPKFhsip0cVfaATSHXgGchQeAwMnNrJhg=;
        b=l/IjPJcRvLNhgq20LUGKsy3hSFL0i3lB9kFYAqcQmBO8QUc2lkvb7tg8a0YvwVqmVM
         2KX1tvF23pXpldTnxYpdBptgfDzy/Hz/RWlFH32keg5n6gSLQjnt6v9RjDSKUYGR7t41
         3xsi/ncEug4tB6N+qHAqxs3rsGwh6KGHzd7y/2kPhRgxwcacYuBMZgVI5wtabrAO4K3G
         T2cqMWFNVamgkcufdmF+M83KJRTXrY0NFdOjU4o8ufl5wvXD95QoydZHxgVW2blgV643
         ZwX6ZDnavWFvjGNO5olPvLdlBV6i8/SO8dkbPcNFPOt/4Ad6BzpQhxHc+p7LAs4OiH47
         xIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743707049; x=1744311849;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S8YiNHG6IFBPKFhsip0cVfaATSHXgGchQeAwMnNrJhg=;
        b=R513kCeh3UBTj5OYYqEZu818jiRc97ChuqDYi67KRDIHhTOONjtFfN/4pKK+fQ+Apx
         dLlI4d9M1tXVCUnCRVnSfEy5vznYaLkY4Dk+R18r/8IOOmPy80KDQtyGnY76fTN4+Bc0
         a1j0FX5tBwMa+NWzzADdCnih/PX1HkYU/6FhUWv7R8y+mcHtxZLwQAPmLKcdawuAPpGg
         YbDKA7vmiiak4Wqc2rwB8eh3ELbBPgAFgIyWYlyspU973vG11jNn6I1POrV+QUOe+erd
         ITWyDN9/CRDfSEDkt72KfpTdYRT+uxgYY+8AANynyF26ykt3p5icneJoYIA7jXTxEkgq
         fpyg==
X-Gm-Message-State: AOJu0YwIvWWK0G4bTsD3xtrrDM3M8n+lSF5bOJBx3CckJBELAS63dsap
	DNMJ8hAzQB5wSdiFxWoqdgXr2AGxXXkt8CGUgN8dArHVpzWBdYpCNgbY/g==
X-Gm-Gg: ASbGnctVSj3AV3mxMrtCoK5JjlGLFtSsSqGeqqwI2fKKMVZ7hoEII+lyQs2yvWSO1hN
	zOyEly3saFRHq2tfUVHGLcSHHNpatZdVAr0oUpYclPAVRU7VPCmhFUiTRQBBbdoNLUUc2a1xzUy
	ewJdtMDn8dA0e0JPkIe3kZFPjFqodauvdRrHuuckYlJWqjajzQoCzxPbcSBqtMBU0i5MZqTZcGo
	8T/LpoH16je47PQ25wfYE6MXSCrOnsuaCrUYtXXIEetZoGro7EzDQdTc+5USqMr30pgmhKgxWha
	MdCacPILgjVF3d/RAmtytgk+2bIqB9T5wCZuf1y1JmCpSTdWPA==
X-Google-Smtp-Source: AGHT+IHOzQeDLJmAjN+LYzNZU8xhCarmEZShpIule0CGrs2Hhf1aTRGVVpo9BmW2MXmdNZWYwSiBKA==
X-Received: by 2002:a05:6a00:1a94:b0:736:476b:fcd3 with SMTP id d2e1a72fcca58-739e4bc3811mr870847b3a.24.1743707049053;
        Thu, 03 Apr 2025 12:04:09 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.0.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0e7be3sm1912804b3a.175.2025.04.03.12.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 12:04:08 -0700 (PDT)
Message-ID: <67eedba8.050a0220.d6196.07ed@mx.google.com>
Date: Thu, 03 Apr 2025 12:04:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4710797928489881751=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: increment TX timestamping tskey always for stream sockets
In-Reply-To: <cf8e3a5bd2f4dbdba54d785d744e2b1970b28301.1743699406.git.pav@iki.fi>
References: <cf8e3a5bd2f4dbdba54d785d744e2b1970b28301.1743699406.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4710797928489881751==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=949650

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      24.17 seconds
CheckAllWarning               PASS      26.55 seconds
CheckSparse                   PASS      29.49 seconds
BuildKernel32                 PASS      24.12 seconds
TestRunnerSetup               PASS      429.74 seconds
TestRunner_l2cap-tester       PASS      20.91 seconds
TestRunner_iso-tester         PASS      32.78 seconds
TestRunner_bnep-tester        PASS      4.69 seconds
TestRunner_mgmt-tester        FAIL      119.63 seconds
TestRunner_rfcomm-tester      PASS      7.69 seconds
TestRunner_sco-tester         PASS      12.55 seconds
TestRunner_ioctl-tester       PASS      8.28 seconds
TestRunner_mesh-tester        PASS      6.00 seconds
TestRunner_smp-tester         PASS      7.15 seconds
TestRunner_userchan-tester    PASS      4.93 seconds
IncrementalBuild              PENDING   1.06 seconds

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
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.145 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4710797928489881751==--
