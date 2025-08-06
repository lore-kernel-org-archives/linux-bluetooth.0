Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C831EB9F2
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Aug 2025 07:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754464729; cv=none; b=aSPhPHCM2ClSwOdWCYORZWF9fdtvgoldrXuqWPZbqBSfTm4x1XB9LHJlrHeSoj+r6powH1BvuTWltif/qT3VwD2RCE3eywd2mVfOuh3BIFPy5cFufaUd74MOvTWtv20QMNXLxfnxwFPNUCBVBnrf91eWgRDBf7VGdACEOLeQytQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754464729; c=relaxed/simple;
	bh=/wBb5hqNMILgnXI/ZKV6H+AyTmcePAuaUJdZZ/lIi2Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=V5rxppSJqBL4sfQ9rdJuQEygodb+lM5UExqvllXaCmhugHVp6dAgAAmEIXgE8CrZZxnAxa9GVCuC51cSY3eU1blcrPHg9AZ6c+DrQkbGQFhSGmkQ3HvRRVnqQI5p8FbQhH1ham5r6e8XFEDLfeSlgLjoHBa++Rj/XcXo38aYWl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlM62m1O; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlM62m1O"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-88192b5c38cso117246239f.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Aug 2025 00:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754464727; x=1755069527; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kwlsQ8hpJXlH5BRSItr5b/k8rTpKD0Odp7X+pf4HVXs=;
        b=LlM62m1Oj5NllZITBcXmFLBJkXEl74/dcTxyaNFMxXmUZTSzziJgZ7tTjH2jUUM2Bm
         qA//WMRaJ1XyZStYi+ELIuwG0quq9IAy/xlUa9n75gWwuv+8Trz23qQbgxmVhvbjT4zh
         NGwsRZWsyXedOUCfTAM7BauR8MFDzwDJKtdkHRKuwneqw5jTno8O05aAsQnGyJoi7SGy
         BYUNDJcY/3OL90v2NV5l7a2L9zw56K95I57WnGS0ZR0Vqsy4cTjDuIvNVwX+HRMGpWf2
         z30+7BleBLHFd2K6IjPLh1wbdlnX+5fFhX+FCYLDS5IKXHp8a0DLQAUaOmACDH0/58hb
         mVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754464727; x=1755069527;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kwlsQ8hpJXlH5BRSItr5b/k8rTpKD0Odp7X+pf4HVXs=;
        b=XAby/tuUxbjHo1MXn/fELCkaBe186xd5IQqSP9inYcDhmPJodjyAq9mYxDXN6SGqcu
         wd2VIVj4OZ2KRWMWN0TARXlP6VZHnk8uwZwMPZ723mbbiwPgiTyh46Owzy+PmjcxZsU5
         PQt+H30GQxc2/O1qjTgC8ao4bLdk/JwbdUfrvdekzQyM/y407ElKOJKkIC1+MRoqXyYh
         uh8g9kDkaW8/TMbDuvOcQcI/eBa4SEf6451nrPzOSk2H+IZa7VnFr0DYjRiFKadRALwH
         5fJd8dKwPgsFXTZpPSXkAR+lFkhcQMMH7bCpaD/jZgaaB/n7aQjs/hHhc+LiFTJNl165
         3RAg==
X-Gm-Message-State: AOJu0YwEbc4UOTA4eUXLBWZT8fdwu6djEnSFj0WKtR9W++nDSfkU4nlu
	SHUJT1/VucTxluAlRewY/QeoXDOWrSchTraIL7mqC0yi2Qvv03HRZKN/ELn5zQ==
X-Gm-Gg: ASbGncuIJo5kvPBD17zkwVboaJd/D1EY9ND46yT76RvIKf72E6yLGhTeJXu+iObpQnx
	m/U5nNyEYTRkPAtregIjCwlAkPYiaVV3mE6DZOSrbH18Qe7WwIvSOLDOs3DiDV/nsQw41NLx/Yc
	B+cvk1Kyxum8AwlZHtScq6oUlI/dPQL8aUvHvadcA77b4/p12HzSxd2Tn9nmHwgJQcUSuT0Wou1
	i+g+8Nf9DYG7dsSz9e+A8jpkI6nIVD3XgTxOBuuQU2MQCGLBw4p7BD0Uz9osszVcCtEdkPm0sq+
	Viz+uTSYN5kkFLuHcrYSOgHI1hNvg5JcJr3eaj6gudWxv2g7t6v4rbMHh7x6q4vMv1RQ6b07y5m
	fz35m8GChEqF1sLt9zfFvRjJQcf/a0DXqkWxvdjuUkaqy2rX4yl4=
X-Google-Smtp-Source: AGHT+IGtfn38x4fPKff1k/booxR1/tMPvDw64xaQrmp6dMAhsD0V/ffCpUWLvSVZJ9ggez8jmh+95Q==
X-Received: by 2002:a05:6602:14c4:b0:881:a0df:34cb with SMTP id ca18e2360f4ac-881a0df393amr186857839f.1.1754464726899;
        Wed, 06 Aug 2025 00:18:46 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.192.145])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8818f695c65sm133559939f.11.2025.08.06.00.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 00:18:46 -0700 (PDT)
Message-ID: <689301d6.050a0220.712be.3b55@mx.google.com>
Date: Wed, 06 Aug 2025 00:18:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8560286587558511529=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2] Bluetooth: btintel_pcie: Refactor Device Coredump
In-Reply-To: <20250806064849.1533531-1-kiran.k@intel.com>
References: <20250806064849.1533531-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8560286587558511529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=988630

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      24.94 seconds
CheckAllWarning               PASS      27.61 seconds
CheckSparse                   PASS      30.72 seconds
BuildKernel32                 PASS      24.32 seconds
TestRunnerSetup               PASS      488.05 seconds
TestRunner_l2cap-tester       PASS      25.08 seconds
TestRunner_iso-tester         PASS      37.90 seconds
TestRunner_bnep-tester        PASS      6.09 seconds
TestRunner_mgmt-tester        PASS      126.54 seconds
TestRunner_rfcomm-tester      PASS      9.16 seconds
TestRunner_sco-tester         PASS      14.61 seconds
TestRunner_ioctl-tester       PASS      10.13 seconds
TestRunner_mesh-tester        FAIL      11.47 seconds
TestRunner_smp-tester         PASS      8.63 seconds
TestRunner_userchan-tester    PASS      6.29 seconds
IncrementalBuild              PENDING   0.92 seconds

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
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.029 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8560286587558511529==--
