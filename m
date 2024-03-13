Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60DF12E73
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 08:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710318889; cv=none; b=gE6V9GqwNdtjvBFoeXw3U5z9VCiZlrcdpGHDJYNwjAal+dMYoczaNVonEBrOcoHZZlp5TTGzUFbqH+wGZYtjSG6cJj02cT3wOrJpVb6WicbGk1P3fHu+lxAA+jrMAbshwp2GHe6atIfJxdz8+sqcHFas2mCEP52zjCDjG4bbfCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710318889; c=relaxed/simple;
	bh=dU/XOV3rXHYOuISN0BtOXNzz8g/bx5UhaZxZCh34Ygo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ws7BBTtKSUVOz/ifg5yTmPNjIbkzGGQGDxVAKb857FxQUk6NkbZanmh3ZRvxuIIKU9PFOHP/dxZB8lFpoxYKU3MsBt8nC8i2iVyV4hAsAKkpHKQyN8WMTIcf4J5vzE8i/iTLdwvg1FX9EEfxgt92woGnOPwknxtcCnODqC2WRHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWNKfZyO; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWNKfZyO"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-60a5a11b59dso15001317b3.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 01:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710318887; x=1710923687; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nynm81QNnirOVe2BsgFR9L1mGEGmszxxDkqTMf5YL+0=;
        b=mWNKfZyOTScPLIDsEFICWkHpeNpjHrIZ209IOxG4egzHrQ8GQ/2FBVA+jSw21c85NQ
         ENlF3/4W1XhAQ508YFAsQXgpynXsht9HASr2GAOOSDqRZHSHZ9z2NhjOiQiXejThLZ4h
         a/5y6EUF/o93aFoSsTUwIlF0AWaDxHTfgSIts8416uhHMquXVP/9vDYulcJV2sdAPQXv
         3bZUesSqGSFMDvKp+uCduy1Kqvc3swgAPT6jtYxEUEJGKn54lhWOMgtFi4d6nwrOffdz
         bMGaPyrKZQNotUJssqwFjEq2B8aGhAaMBF9otMFDvrDgq3HGqCfLg7hAzvId0flKi/Bp
         j7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710318887; x=1710923687;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nynm81QNnirOVe2BsgFR9L1mGEGmszxxDkqTMf5YL+0=;
        b=nXP1jBxkn+GYNKv6fifJ0ciKYNyqCZr+8NLAs24CyzUHSfbc406N97RFOeyQA31hFf
         /kxj3SKuH1K1kbYOZEfpfBpNryCdRt7BbiQ/kCSO4A8WzVW84PKoK6n5rLVQ3QZREcnV
         hqdIurtr6JMuvHxxbHzXvQJvHDJJHH/Zv+KKC3ARTS207Hi5VJPgYeSjL3Pujezlcf2D
         zc+3w7b9aQHKzRwDQEVB70C+e9jXz8jyvoAZ2lShtCB/I+1c9caIrq63lKHnW1KHYFiI
         SKbvAeZ7r8GHMFoEJlkq6fKgZheB98sEjTQ9Tw/1yv4Wcm4dgDUWxDQm/kKHYFZnteLU
         DMUw==
X-Gm-Message-State: AOJu0YyqMh3eRqRKWZqjkxVdKQfURBxnE1sGefHFmhPj9kBapAWpEPKr
	+4zSary8DdyCiFfbSI1bL60WeC/GTFlGqn/UqFonLk5cln1niL1PEF1odD+n
X-Google-Smtp-Source: AGHT+IH8uk6Dy9Ba5BI/VTc+PngGsaIotXd7AuxnZDLHAyzcU4uHnaiDW/GXFHYOnZ0kGyo3fEIlyQ==
X-Received: by 2002:a0d:ca8c:0:b0:60a:57b:8db with SMTP id m134-20020a0dca8c000000b0060a057b08dbmr1927722ywd.11.1710318886707;
        Wed, 13 Mar 2024 01:34:46 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.207.136])
        by smtp.gmail.com with ESMTPSA id wg15-20020a05620a568f00b00788349c0098sm4463219qkn.50.2024.03.13.01.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 01:34:46 -0700 (PDT)
Message-ID: <65f16526.050a0220.7acd6.1aeb@mx.google.com>
Date: Wed, 13 Mar 2024 01:34:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7973379387565783124=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, youwan@nfschina.com
Subject: RE: [v2] Bluetooth: btusb: Add return ENOBUFS error code
In-Reply-To: <20240313073640.426862-1-youwan@nfschina.com>
References: <20240313073640.426862-1-youwan@nfschina.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7973379387565783124==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=834872

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      28.33 seconds
CheckAllWarning               PASS      31.83 seconds
CheckSparse                   PASS      37.19 seconds
CheckSmatch                   PASS      99.58 seconds
BuildKernel32                 PASS      27.54 seconds
TestRunnerSetup               PASS      523.79 seconds
TestRunner_l2cap-tester       PASS      17.96 seconds
TestRunner_iso-tester         PASS      28.12 seconds
TestRunner_bnep-tester        PASS      4.82 seconds
TestRunner_mgmt-tester        FAIL      112.34 seconds
TestRunner_rfcomm-tester      PASS      7.40 seconds
TestRunner_sco-tester         PASS      14.98 seconds
TestRunner_ioctl-tester       PASS      7.81 seconds
TestRunner_mesh-tester        PASS      5.91 seconds
TestRunner_smp-tester         PASS      6.89 seconds
TestRunner_userchan-tester    PASS      4.99 seconds
IncrementalBuild              PASS      26.40 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    2.098 seconds


---
Regards,
Linux Bluetooth


--===============7973379387565783124==--
