Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874CF2DCBF5
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jul 2025 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753280087; cv=none; b=CVyzA4+Zcvj4Wtw6I18Vk4te+SoPKhkniOtcIej+6kuRk4R3HBoL9kYuqLtrQP/WWH8Ud+DUryPxq9gX0KO7XiDpBM09pe3kKDTJDqPeCceLmfHkxwlnbxBO3/mIy8Omxj9YRNnnV+8oKfNrJtkaOk3z7bNmRcInplP6TH0EeGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753280087; c=relaxed/simple;
	bh=eEEfxN0i+LkLq7e8SlI6a5oQiWtlWv1/OPLEUvS+9WY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kxOadXJ9T1SEc49uSqGXtARqhR/U4cgY1cG/kmTlhEaHUyiuZTOUGnkWpcHkx4gxQGSJ8Ia5swnIcOjsGg1wPAY2oE1M3Tohy5w4lGFEKQzz8Q3HpYLTyHMDMXKsiZglKnIqwzLPaIx4kY9U3VAG3RBkW6X9daZz4XQ9QZJNNY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sg/wE+pd; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sg/wE+pd"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-706f2d1036eso17280396d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jul 2025 07:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753280084; x=1753884884; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MrviT1mmeubJj10d0WPZ0/bxCyNIY6mr+pXfrIarZV8=;
        b=Sg/wE+pdfu38kNC0O7fAqfPMOd7SQLzyCKMJ34ZRtyGqoHXkd4YLdvdf8o9j5p6nBJ
         i1+GuHFIJci678z+TTv7Oe3Z15pT/Ij541SbO7AeC1XybOke5rcZGKMkLmeLUoJ0aaZ2
         UDXcqKs1kPWwVksrqGqydJnGt/4OOchzH7WZHoLUYuzMwYCrHWDrxTokvwaJMyZGLifW
         E00x9LrvdkKLNX8E/YbqhTZizCprx4raWu/p2cH6XCEakB+sfOpHIXKgbpcaG2tA7D7/
         5nhh5WWBmjbisBPpbWFKeUlWvsmtbNaQ0B81kFgZVm0JDvBKPpKgwe1gcNf2aFOB1JsB
         AAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753280084; x=1753884884;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MrviT1mmeubJj10d0WPZ0/bxCyNIY6mr+pXfrIarZV8=;
        b=wPGO4MtbKaEv4rIjPv6MD4lRpq0jdoVzaG1+tSc1L9yhxQJlaNSOaXMxpvMnV/iiG9
         qTScmUlA4BnSfe9JlOqr8TsUMBxDr/6YkKfJMix/6GRU5mWI5JqI7ob3AnRaK2IM7m+U
         QcyPxRt2zci02jvG9ARGRPRy0tgjDJ4oR885F0s42n4uV8ZoeR7n02pFzyQlMg30nX1D
         7Ico1Uq3CH4HmtcQuBmiDnZaCDIQWdXHvR+MniMxNjkeNANElhLDYUs5Lz8bpIk2wW/J
         DoLs4c1r4KGGINdHwJfJDGQ8f3dfF0ZHA7fxwyoK39dwy9SpmVATbHI1+4cXZkmo0Yy1
         UGaA==
X-Gm-Message-State: AOJu0YxfppMvoTbWqGi4aaIkuv8UaBIVk+0awOdNTjmviqmZGWlFwLlD
	PPAwlavUJH3Myhv2kt0ddVElv7asfvA92XPf8jIOfiMziUkE1IvyL27FB9gd5A==
X-Gm-Gg: ASbGncsqUdW8FadgZqrSLUHgE1TS04G1cQ1ml1iKBVhccQkMp5y5gIimCU/Ogrx9xSU
	FP5IwaRAfrLjt1RUIxzdE1KBn+46OsVvBF5Pzoq1ikwsDEd/DiNUu7mHkYbi8zjM0bktVKs9BP8
	V6nQjcQ8LsqSHCWm7H8tceTGo66/l0EXIeJ9YI6oAPVtQhTCsgApCkjYnfLVfTQygzHouxjWU/E
	BTcMiSiigizZ+X3gdncChKndUifmgRTscc07FMK0UHKrOXS18Q2fPoVH8XW4jZ2gRcbUiRpXg52
	iqVpmMoEBOnRe9oYm4l0u4oYu9z+COsekoXCXQz5jsZRCAxhKhr2gRrgVZc82bwW2FE5dTg24qW
	+XQhZIxh8+qZOwCgbjKPtfsYO5wc=
X-Google-Smtp-Source: AGHT+IE7kQHhBHeG1KaPD3xRyNY67KJWcfZqEN/abIEa5n5mC3pnoGPdBJcj30m/fUHEd1IhcTjegQ==
X-Received: by 2002:a05:6214:20a1:b0:6fa:bb74:8d72 with SMTP id 6a1803df08f44-70700218897mr43463286d6.0.1753280084013;
        Wed, 23 Jul 2025 07:14:44 -0700 (PDT)
Received: from [172.17.0.2] ([9.234.151.21])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051b90811bsm63726146d6.42.2025.07.23.07.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:14:43 -0700 (PDT)
Message-ID: <6880ee53.050a0220.212344.5484@mx.google.com>
Date: Wed, 23 Jul 2025 07:14:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5965157067485561279=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v5] Bluetooth: btintel_pcie: Add support for _suspend() / _resume()
In-Reply-To: <20250723135715.1302241-1-kiran.k@intel.com>
References: <20250723135715.1302241-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5965157067485561279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=985145

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.45 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.92 seconds
CheckAllWarning               PASS      26.91 seconds
CheckSparse                   PASS      30.43 seconds
BuildKernel32                 PASS      24.59 seconds
TestRunnerSetup               PASS      479.88 seconds
TestRunner_l2cap-tester       PASS      25.53 seconds
TestRunner_iso-tester         PASS      40.94 seconds
TestRunner_bnep-tester        PASS      6.04 seconds
TestRunner_mgmt-tester        FAIL      134.76 seconds
TestRunner_rfcomm-tester      PASS      9.43 seconds
TestRunner_sco-tester         PASS      14.80 seconds
TestRunner_ioctl-tester       PASS      10.16 seconds
TestRunner_mesh-tester        FAIL      11.40 seconds
TestRunner_smp-tester         FAIL      10.99 seconds
TestRunner_userchan-tester    PASS      6.31 seconds
IncrementalBuild              PENDING   0.93 seconds

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
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.177 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.167 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.203 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.067 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: TestRunner_smp-tester - FAIL
Desc: Run smp-tester with test-runner
Output:
WARNING: CPU: 0 PID: 51 at net/bluetooth/hci_conn.c:568 hci_conn_timeout+0x14e/0x190
Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5965157067485561279==--
