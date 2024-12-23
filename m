Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376A518A6D7
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Dec 2024 09:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734946390; cv=none; b=pBJYjJZVFQVRJMi9S5if5skwzsf3+jeLtrnC7gJV5GGIY/ACVSf2MvwqtY3hr047S5JklE7U8c8vui+v+s3peX8cohh4t1XZKSVW2rPRVxirheXnXn1fyKSKFfbdQcBFYS9eHLSemVrjbNPMX2FLDK2usUnN9VJJqp7Bk2JHzaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734946390; c=relaxed/simple;
	bh=GYpW0qef6NIiuxxNOcPeRvCnuNg9CMdxd2zulgp5dyw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cyg0gfsFabUamavw7D/wEy17PUyUwsfKoz+UK/IlH+25kYYJRX3mYCJvqm9iFR3C+n2xc6RsKhPacFZoOg2zcpHZQ7liL9MU4Wdk1Vqu6l4lvdWgcLJtEU8UgKcJNMY25isdOA81CSzUw/g/ZFYWn2VDHBYOiSoke0px+ZgiUMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtrkPxuB; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtrkPxuB"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-725ea1e19f0so3213850b3a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Dec 2024 01:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734946388; x=1735551188; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=05PPo3LSvAT7EaYtmOIHOKorm8bsbQKeEj5jmf+ZLgs=;
        b=PtrkPxuB4jANlCFeYsOR0+SxrJ9SvPQUaJFzm7fWJptCfG0OsTAzlZ2JnoINymFAnk
         mwILrrtDCQGORCBVJn1k/5hxYOMGxIgnJazQntAIDDjeeD/ddVNuqsjNtbM4EoBuJP7w
         z+0gck/sK6ojC+YjPiUIn3Kwiwz2JdYjmZggE8CdHaP9BV/2WCoKiueEX8oYGeTQxTdJ
         7nn0G9EgsrjZcDqnV39hbiAkfnYilm8aCL1JKdTsjp/pKWz70ljKL/WTKyJzHpVA4gkz
         6nCYpJ5EQxuQGzbYa4dp3CapCIt0o73+U6o9eFZWwj7loHuzc4l7ghQg/XhPy710ffmx
         Q72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734946388; x=1735551188;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05PPo3LSvAT7EaYtmOIHOKorm8bsbQKeEj5jmf+ZLgs=;
        b=wvY2+ILacRqFL5TFwqW9I1ivddIQgAefdIopz3RUulm75UGRoiuY58RRQ4nL9ZblP7
         zcrIiEIH1eA+D2EsxCUQiqi+tpLPGcDW1NxrTCqK+7BDeOJlwkkmr2Tpgmzcp5lIvfH0
         CYheDt4LXQVtBgTxYILWZ5p8oWMq8x7S2LGXaLRjfWIWehz/0mJVAsRsOFG9oPE6Krgr
         xw1F+2RdQ9ZFh1iHuTKX8ZLVjS99Fct8s3Z16GEFJEa4sCFFWqIxSGKhG9VGYoiHjTts
         u9+2dC0ILes0I/4G8V7CTfZQ6I7VAB0uadQa7+LXgqKGpzvbvMRNicPoCgf4FxrECk9X
         TSGg==
X-Gm-Message-State: AOJu0YwHKI26COMUUZKyJVVwe8xsM3CK3pCB80Vj54ReP9dKX92sIp4x
	Bv6Y8Jim7Ag60U8USQyIMtj3agSEdT7opxlI1CWOo5JnW64omOZIya7McQ==
X-Gm-Gg: ASbGnctnKgbduTVwIA66hSstC7QW+ATWOi1B2d9LpQgTQVQ4cMYkHam6FJn1svCmwB8
	M1Tu/1aAidnjWBV7C4jb8/O3fBkrcYUwV/n5MVHewY835T+EeXuysGrEV0lxQsP14PjD5z/SfFq
	FUOKcbFUI0i2POvXN+tmBe8k1GMWG+4TUWyU2uYQsZinFJlLzqw+mvRO/uVcw+nfYNzIXST6EKM
	y4Z2aqIzhX84AAFyfH6OR8kSPuv+LxxgO3MtKSSSUiuHTl6vn3vs0AMGRHy1A==
X-Google-Smtp-Source: AGHT+IHE3UAI4Y0MNgn//Am3W4mjHxJskzLMHX67Ap/tBUwOOz8AXs5HMuastF4oOl1dbLHqG8eXNA==
X-Received: by 2002:a05:6a20:1582:b0:1e0:d5f3:f3ed with SMTP id adf61e73a8af0-1e5e048ab3bmr19482374637.19.1734946388057;
        Mon, 23 Dec 2024 01:33:08 -0800 (PST)
Received: from [172.17.0.2] ([52.234.38.42])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad84877bsm7423480b3a.84.2024.12.23.01.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:33:07 -0800 (PST)
Message-ID: <67692e53.a70a0220.2e0fed.2e98@mx.google.com>
Date: Mon, 23 Dec 2024 01:33:07 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7655110032705071935=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [v1] Bluetooth: btmtk: Fix failed to send func ctrl for MediaTek devices.
In-Reply-To: <20241223085818.722707-1-chris.lu@mediatek.com>
References: <20241223085818.722707-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7655110032705071935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=920358

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      24.87 seconds
CheckAllWarning               PASS      27.26 seconds
CheckSparse                   PASS      30.92 seconds
BuildKernel32                 PASS      24.68 seconds
TestRunnerSetup               PASS      442.25 seconds
TestRunner_l2cap-tester       PASS      20.60 seconds
TestRunner_iso-tester         PASS      32.16 seconds
TestRunner_bnep-tester        PASS      4.89 seconds
TestRunner_mgmt-tester        FAIL      128.16 seconds
TestRunner_rfcomm-tester      PASS      12.71 seconds
TestRunner_sco-tester         PASS      9.49 seconds
TestRunner_ioctl-tester       PASS      8.35 seconds
TestRunner_mesh-tester        PASS      5.92 seconds
TestRunner_smp-tester         PASS      6.90 seconds
TestRunner_userchan-tester    PASS      4.97 seconds
IncrementalBuild              PENDING   0.86 seconds

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
LL Privacy - Add Device 3 (AL is full)               Failed       0.199 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7655110032705071935==--
