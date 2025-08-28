Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396AF1F3B96
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Aug 2025 06:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756363267; cv=none; b=FOhX3Zv9h75Zh2Dpc5jIEg7q+ilFmwVi3cbZt6tgOykzG/SsOEV8u9zgOSx6thj2sEXSUVnvO8LM716pVZRYlNgvsa8Tjoh42h4nE5rF/ClvNXTvtR6wMWnzzZK5i37ebHaxxoNZ8TZzziBz9ZgfxpNcZXPKWNVWGDXCxx7ld1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756363267; c=relaxed/simple;
	bh=KTFfcTlCTmUYhcJC7sPP1VxHrPrEXQZ8RfEib79LRto=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JIa6nxsyvNZ7GuwsdZqyci96IV//aEby9mDLKzn1ZGBXg+7x8+ckumPXqRHwr3J4pocfkTT0qEgJZMH7x+P1Kf+p4kowGzENJENsNhnAXTSNIzTq73Z6u/t4jYSKxzPRmf4GM7DoitxuQ+MV5u+eeME4hzqeFqJ82+gkG3jVJ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcOXzI6D; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcOXzI6D"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3ecbe06f849so3366355ab.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 23:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756363265; x=1756968065; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mdRjBG4AMENQyuephjEV9oV5khr1tCv+6jZARzAUCdE=;
        b=XcOXzI6DlQ+LOOoWSS0OOOO3KQBFL6RNBGdz4hh+BxxsU+kq2Cu0IZGrJYjAx0vG6o
         sn14bKoubt3oUk3s0aBJVaSxJdrtkDszIh4oWptvjXDShSL3764LqBUBHPy9Sj4zbtys
         gNyoZywrRspbikngbCR+slg/siQmPe8JxYOQY4+6BASfF1WlwjEHvvLwTTdQUnG5M7yb
         NOQWj2dlsCJkBA3p66Gc/v3V2jbcfm4jvGPxuhNr9z4L3Z0qQiywMh2CqkxiXRVn4oK6
         HRSuRwHl/3+rtq94iCJ/90Z74PJHxGbQuMMCt6vBqteXMFIBNPXuIi4o7R/wPCoSlW2X
         sYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756363265; x=1756968065;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mdRjBG4AMENQyuephjEV9oV5khr1tCv+6jZARzAUCdE=;
        b=SCUHNL7VSnQ0nCkLkvDk8rQyg+Mo7ZYScg3wF9oJyRaCOcDi7CFAtQHXLzErEiJNOE
         lPErGoNA6gEgLcBsovzrhVb3gwpm+/4YwN2Sq+vUu6QI0eceltEcMBBoIHg41xEqVpE8
         bkWfmHW7/sG37U9MLq17jXMZ8/bPwAfoggyUtcwrJSn+VnXvKLyp89LLLaWqRAdM9Ale
         H6yI5yjp8/uP6rwyBdn3Y/SrE3GyrZ5oqrAsF9kgE4GyNFCOLvzNdNSqyGOhPVk1Qr/M
         Fly0DupJLpcuxe1gbwEJt4lpCwyjq8Wcu1Ci+7ZoOQ+Zj+jBAbNvd2A4TghPv7Q6k4+U
         JfRA==
X-Gm-Message-State: AOJu0YxpklgRyKxpZvJo2eVAax6n/F0gPEn+S30x/gJfuOks2wMBSxPV
	iWunxECBTdcMjcK/Q3IBGb2YKX0PP8jXh6Ef8/FF9MC5mGaEo5ZsqvTSdwOSeA==
X-Gm-Gg: ASbGncs61t1ISWL617j2oYIYubzWrZ34/nmjR5zZHvfrPgEfgLmHyoWnsKaBLHxlkIX
	E59QYm7dtC/GLKILZyw5kPLRVwHZ/rkucr0WVi2mrn2IsbnNWdqCFHaWJAeXlWVLqAt6SyanFYI
	eQY25BAGbwLJr/yj+JxhnFaj/Vg69tE7HQAC/gCOcKzIznsFi+tpzNvy2qCY0Hie0ABC0AqnSLD
	jR4w/LX3z7fcCEg8V9na2WTgp9chV/1xhrSF3ql9F8HkhGQbMrc/YNc29SluG6uB53xkF4wTanw
	Db3REg5O5uf2W72lroBZLf8AUmAPJi/g3QU6ZbIg1oIUURt1tTgcNp0w18zRJlwpA89ruG1zfYo
	VbL+JuiSy9JQNxrZj1DO3Vy5daKqWYA==
X-Google-Smtp-Source: AGHT+IEWpsFT72v5cmYRvOloVTIoOlHFlfElPt6cNb8F8IMM2FbCnLLQIm13UuxOHYVgHwvR9yHCKQ==
X-Received: by 2002:a05:6e02:3e02:b0:3e5:5fd4:d82b with SMTP id e9e14a558f8ab-3e922319f65mr341398625ab.22.1756363265057;
        Wed, 27 Aug 2025 23:41:05 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.200.102])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3f012188a64sm25719845ab.12.2025.08.27.23.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 23:41:04 -0700 (PDT)
Message-ID: <68affa00.050a0220.43d91.5402@mx.google.com>
Date: Wed, 27 Aug 2025 23:41:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0446224932037868886=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: [v4,1/2] Bluetooth: btrtl: Firmware format v3 support
In-Reply-To: <20250828060427.1794237-1-hildawu@realtek.com>
References: <20250828060427.1794237-1-hildawu@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0446224932037868886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=996323

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.30 seconds
SubjectPrefix                 PASS      0.18 seconds
BuildKernel                   PASS      24.14 seconds
CheckAllWarning               PASS      26.70 seconds
CheckSparse                   PASS      30.04 seconds
BuildKernel32                 PASS      24.10 seconds
TestRunnerSetup               PASS      474.06 seconds
TestRunner_l2cap-tester       PASS      24.87 seconds
TestRunner_iso-tester         PASS      36.40 seconds
TestRunner_bnep-tester        PASS      6.07 seconds
TestRunner_mgmt-tester        FAIL      128.90 seconds
TestRunner_rfcomm-tester      PASS      11.17 seconds
TestRunner_sco-tester         PASS      14.76 seconds
TestRunner_ioctl-tester       PASS      10.00 seconds
TestRunner_mesh-tester        FAIL      11.36 seconds
TestRunner_smp-tester         PASS      8.44 seconds
TestRunner_userchan-tester    PASS      6.16 seconds
IncrementalBuild              PENDING   0.69 seconds

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
Read Exp Feature - Success                           Failed       0.105 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.196 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0446224932037868886==--
