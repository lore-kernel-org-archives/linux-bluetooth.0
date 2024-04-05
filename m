Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D700011718
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 22:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712356316; cv=none; b=ep8xuFj1pSmjWyLG85XxJhVs8h6uLMHSbV/4YFV66VQnsAcnMSWA4npexuL1sfe+i6fUnkpEM89ubH3595ikkQshuFxcGZpwnyRVjdtyEDo2LW09u4v6SqVBG30rs/w/mUDXLXIHxGaGgd6vZYSEU+m9v5/mdKThhaUgrJRXhPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712356316; c=relaxed/simple;
	bh=D+C1fuvSyEd00iyXCVNxYKAqIiuhh3V0TRVFHSZiAAo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ARn8NR57QaPAPQ6TiT57OpjbXtTnNGBKljqJIcUfp1rNBx3OOTNL5FgfAatzgvrSE/QM0xUbIQ6RAoocWv4ETzxcYwarE7mqoRjJJac4zDfiDbqtGKksmNTTZ5KeSKBCA1wntB9kYBJRQn0gBvfZlln+ypvHx5VBGJF3YpixRXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUc7FK6x; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUc7FK6x"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78a5580333bso144168285a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Apr 2024 15:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712356313; x=1712961113; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2v4lHy4NwK682p1L7S4dGMF9G/rifiSXhBy2saimtp8=;
        b=jUc7FK6xXmqNEGm49WWYKVF3vLFcuQe9GmwTwPqFrG/9P+DFDbveana2L/gux4aDnj
         VW4O+wBtWJxG04BRYMP/sIF8aauWfL7JazHu8zs++p8kq4nII8EtzMp1L9i1uxke09ZM
         MzZ38LNPysd4c+ag9u8YAd5K3X7SG/I8hBgTWp3s5qaNB3B+vC3q6iDcCoaAEVa0IXdC
         f+bz2sKpNTPMeYdUL1xf4YaqAVky8GZFHzAeSv2JDa6dxxPtvSfIT0oT4ILFbFlnR1Jz
         CO4D9ZDYhr29IFHAnbgJDRhQMBvtPMbpvfq8AIU3R7olgrCLvPQKaedBt0UcR3Xrb/G6
         5z7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712356313; x=1712961113;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2v4lHy4NwK682p1L7S4dGMF9G/rifiSXhBy2saimtp8=;
        b=PUehgMobv5yALVaEYOxGwqpoIaDWmFUPSxJs+0s9Ahg40FYJEhISxQ3UHkMcSQTs7c
         HbfpajMD8Vh/5hkcYfu0nABDFuUugL2F4MzGFYHufPu7bE5Ck3GGqvLvbR8FhFgEXJZC
         uw3QhowMc1RDuFXvPMFlXgEn+tTpq/GCGSp7AQxEaK7Ex79cBJ6C3X9tirU5Bdn6Ma6T
         jqv9LJZghbZ/rR+VTDXOvZDBbrdKS0BoNtOaBIQDW+N/VgBp6u5eBmgzXXZdLsjQPXGr
         16RcVy/b8O7vHmxpX7uYn/e43Gu/Btb7/MKbhSt/dTyV4h9WJoM03J+uOa57J0QGpqOM
         BHBA==
X-Gm-Message-State: AOJu0YxGDREHX5fVjYxrZ1vbSmvK0cyvDJLiV9pD1vowNMbB7N7XNRbX
	Oaesd6P2DZhFqd2UoZNYZdW2iAeqEehQvZcyD5CXJYb+v/ZtW0nfXUpZyyHb
X-Google-Smtp-Source: AGHT+IFxTublx5VdZDb5MJpM3kSUQpJQ/Cf6yBSpFf3AaYlsLR7cB51LXM8MYSHg3ldfS8961cFfJw==
X-Received: by 2002:ad4:5f0c:0:b0:699:3495:cac3 with SMTP id fo12-20020ad45f0c000000b006993495cac3mr3024152qvb.56.1712356313585;
        Fri, 05 Apr 2024 15:31:53 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.131.17])
        by smtp.gmail.com with ESMTPSA id ek8-20020ad45988000000b00699410d2991sm741708qvb.66.2024.04.05.15.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 15:31:53 -0700 (PDT)
Message-ID: <66107bd9.d40a0220.48ece.5f06@mx.google.com>
Date: Fri, 05 Apr 2024 15:31:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0392973932911100033=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, me@wantyapps.xyz
Subject: RE: [v3] Bluetooth: ath3k: Fix multiple issues reported by checkpatch.pl
In-Reply-To: <20240405214225.2170476-1-me@wantyapps.xyz>
References: <20240405214225.2170476-1-me@wantyapps.xyz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0392973932911100033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=841953

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      30.13 seconds
CheckAllWarning               PASS      34.76 seconds
CheckSparse                   PASS      38.45 seconds
CheckSmatch                   FAIL      34.86 seconds
BuildKernel32                 PASS      29.07 seconds
TestRunnerSetup               PASS      517.03 seconds
TestRunner_l2cap-tester       PASS      18.46 seconds
TestRunner_iso-tester         PASS      28.15 seconds
TestRunner_bnep-tester        PASS      4.63 seconds
TestRunner_mgmt-tester        PASS      113.87 seconds
TestRunner_rfcomm-tester      PASS      7.36 seconds
TestRunner_sco-tester         PASS      17.01 seconds
TestRunner_ioctl-tester       PASS      7.58 seconds
TestRunner_mesh-tester        FAIL      5.84 seconds
TestRunner_smp-tester         PASS      6.61 seconds
TestRunner_userchan-tester    PASS      4.78 seconds
IncrementalBuild              PASS      27.57 seconds

Details
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Error 139
make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: net] Error 2
make[2]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.102 seconds


---
Regards,
Linux Bluetooth


--===============0392973932911100033==--
