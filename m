Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC31847D959
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780490369; cv=none; b=qE6OfHBXuTKJoD9M6vfpA643bdzg2y5BX7tOl3hhy0oH9MdroxfurQdnFPlwID7rydne8/MnVyDF3nNDMjmcCXYG2J+c6W26pfIQyuOBxZbgbfliE8hw30eHF9eqbPK46+G75NCjmkDqQpN+fhLwuRgK9VnbrFH8Fv+X8Dbwn+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780490369; c=relaxed/simple;
	bh=AOA/O4lZegISBi0qrdeWx1pPfklZNIizIiXoi4lTY7o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rg9aFaJYBlHo3pHoaWZSFARfX4xwJyuK38k31jVAgLadSHTeiMpylVJH5GeI5j8I3nPtWknZpWPT9Mv7+qUTCtKj8Pumi+0T3z0XRw4GSNhB5mIoAy0GTQQ3X7Kxy3a3BGL7xq+zamU5vQV0qzUjvpD84hBdeRbqbp3RV69eHUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSsJaFwW; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSsJaFwW"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8ce65629acaso44481176d6.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2026 05:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780490360; x=1781095160; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XqsfF9+zV0Glt+3wKU6iDB6IkxNKZnKK7yybx5un/vU=;
        b=cSsJaFwW37jRlxs/mBtYelqDrxDWvytpnVuq4/jDS6xrLOJjytaHx6EsXYS8jZAB3h
         078BQCVKEQcA3CzEDZfqFyh8nxTJiUSF64J6GFprwNYETKzrQeRp/2gUswlzMNesP3Zo
         wlH1p/9B3cdVBEcNviV2vclhZPtdOv+4XUGjK7zYA0i9D4Oug8oa5Pe09sitsY04n3zP
         f1QAP0gdx1btHkztRPenQkSZbdMwX3xEgmOQMlp++axEWq24CdJ4Kr2trWnWIgPIfFiF
         545wH0ZJTiMF3wJWrgTweUCCvbUatDfZD9nc6vz6hy3cR4RO0HpKRfIO1xMm8tTAXaAC
         o2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780490360; x=1781095160;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqsfF9+zV0Glt+3wKU6iDB6IkxNKZnKK7yybx5un/vU=;
        b=UaCc1vOL+GCL/u592de0tmimSPPamhvRSAwBu5dm6rbYEHL/nT1WymR+BMcKg5jI3n
         9gdojv2WdaL6prhUYFfuE8Uz5C/08PCJShCE7J9LUXstHV527bEJvt1Mdhrv+dphRb53
         jbK+ZqayPhvGULVkN/2Z2GTmiqo0nSUukcFTRZ4mbMMQkxFZYyc5I9DXlPfADCh5+Hhg
         kYPB1eW/0yTS6FKDb1Lg4hTxNFHVNnyinPnzcqf15Bjr2ppdrN5+6KFO2wbw4SD28kJU
         DgPWrblG0P/AKB5CaQU3cj36TCK8nexEuWoX0uw4OqCYrE6R+B1hhvGR/Qb2JeVTCTch
         a++A==
X-Gm-Message-State: AOJu0YxRPnWp8BuBddacclcaVhs9cA+mckyGUEqYav//oThQuxUjL+v+
	ZeqclHx4tGrU3oMS8mD890R08w/ap7y3ljRyK+9pKHOoNbilwsJ6Hg/XNsvDjw==
X-Gm-Gg: Acq92OHCTN42c7FaIB4d04ZlPofZv+Q1iX2dElWmaQdMHGEUwyCZnHmcgOUPs4T/ZPB
	MzNJW+AuNxVlxll6fzwAl015tBMz77Q/q9SNTNrlVR+bL8yUS+l3F+r1Bq33pBhwbq6ikzGkQTY
	EU4cifYOWwvSpKJgh9tpeHBR+g/1jsDAcs2jgqN7nr6JXTMVh2QNJHOyOYNseeee9c8GDbP2bS5
	qGNLTng0M0JrzZx9hEIf8dblsPkZNbUJWoHoi9EehxxDgzr/oNBL/Pv4vYgOa0nBDrOgbeQOvNV
	eD1SD+RWFwpp4m7Wlj5K2GTNiL/MQ8sMamdfXUvng395ure0SnjAochEjxhuSRxdMHDQEid8aA0
	KOMQvfjj//v9ydfaAdYUSfpLcMBOVQLh+5aTXtcYSfsr2GNGMOa9FOO02TuZvSJIYzmLATQT+co
	KIC4oR5gGKVK5+pUy6PehMca4ACsYC8ma/wYp07783
X-Received: by 2002:a0c:e086:0:b0:8ce:a005:3ea6 with SMTP id 6a1803df08f44-8cecdf0cd6dmr41438636d6.22.1780490360316;
        Wed, 03 Jun 2026 05:39:20 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.68.246])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd26e9e3sm18669786d6.46.2026.06.03.05.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 05:39:19 -0700 (PDT)
Message-ID: <6a202077.50eb26ae.2d7cf3.e8b9@mx.google.com>
Date: Wed, 03 Jun 2026 05:39:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4424866327013179815=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jaggyaur@gmail.com
Subject: RE: [v4] Bluetooth: hci_core: Fix UAF in hci_unregister_dev()
In-Reply-To: <20260603085047.256779-1-jaggyaur@gmail.com>
References: <20260603085047.256779-1-jaggyaur@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4424866327013179815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1105168

---Test result---

Test Summary:
CheckPatch                    PASS      0.72 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.12 seconds
CheckAllWarning               PASS      27.85 seconds
CheckSparse                   PASS      26.29 seconds
BuildKernel32                 PASS      24.34 seconds
TestRunnerSetup               PASS      519.77 seconds
TestRunner_l2cap-tester       FAIL      58.96 seconds
TestRunner_iso-tester         PASS      75.65 seconds
TestRunner_bnep-tester        PASS      19.41 seconds
TestRunner_mgmt-tester        FAIL      209.19 seconds
TestRunner_rfcomm-tester      PASS      25.68 seconds
TestRunner_sco-tester         PASS      32.57 seconds
TestRunner_ioctl-tester       PASS      26.29 seconds
TestRunner_mesh-tester        FAIL      25.39 seconds
TestRunner_smp-tester         PASS      23.55 seconds
TestRunner_userchan-tester    PASS      19.76 seconds
TestRunner_6lowpan-tester     PASS      22.67 seconds
IncrementalBuild              PASS      24.73 seconds

Details
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 3M                     Failed       0.251 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.241 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.048 seconds
Mesh - Send cancel - 2                               Timed out    1.988 seconds


https://github.com/bluez/bluetooth-next/pull/280

---
Regards,
Linux Bluetooth


--===============4424866327013179815==--
