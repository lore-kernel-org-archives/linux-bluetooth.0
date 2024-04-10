Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF1538C
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2024 04:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712723636; cv=none; b=Rgy28nLz+yTR2CwXY2k0Z4Y1NV/9JDcu/6n0MHHl8AKKCiQEqQSk1FGAQKVCJhIRgMLitCfbrAgxw/BoPuibdCfFclBSh/4Ol2xlLAi/7BFbY6a1DwUoilUg/RsNwVnNkl5rhRYJ8oaFq+1lVsQWSqq7Uv/8RIxp68SpONWUXFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712723636; c=relaxed/simple;
	bh=OmTtvRqmTn/zoRxvkWq8zIX510a0x+niYN8e0enc+Bw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rjcrRM2or/xMP75jSJzfaS0X/otKXG0NQlcRbIhkOSNrWMdTZ64b4yvv47nJL4PoyJykDR4pyzgkXlP9qKFIuRRNhvsNYHGZQJGoSfx/Ph0muRruans8v0+5DS9yoIyM0MQhIgATpQkxj/ZbnYNMM2Gdox3udQjmBumBTJ9rV+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyHhuSpx; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyHhuSpx"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78d723c0d9fso80588285a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Apr 2024 21:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712723633; x=1713328433; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wATASWWtvtieBRGyzF9jz5KvnDM913oBlNHdFIixY98=;
        b=dyHhuSpxMFNgmPXow11cGfQpX6Na69S1noh97FBLHIwvmYQ0hrDbMjYC2huj2EfLU9
         BQ9YdgIyXBSqhbh+BhpaKkM+cZlO8BiKJFDb7x8MehgZaBdZq0qC1pOjrmh90wZ1e+DC
         RSyyQ0BbD/LTiR8iqUJY4oMW4jCed775H0EFoOO3g50120RQFzogOo9VkP4i5hi1wV6e
         ancBhxkK2kVfiT4phhZFtJCJwjA4gkCiFVzs9qxyTD9q4DLsaARijEKCVwtpkq3gLJgR
         n8RC7o3spjH9FQW7T0gFK35wXMXD4GYv9CvMBgn5gsnDUj4H/1OCC42OnMrf84JhMVuw
         3Vrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712723633; x=1713328433;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wATASWWtvtieBRGyzF9jz5KvnDM913oBlNHdFIixY98=;
        b=uxyrIUXVxquFbMzyhcCFR+aS2eITc4aF9hW18DIrbpLF0HPWG7KRwQhCa+LgzZdNS1
         LrqeXbttl/HS/et74tYTQ98obLj6LzkxMTRjq6cnTEuQ3ck9GdFH+eeD5BHN5cMMBAWG
         3qosH49hpewFXUY0dohdo4dUWNL7VHnhpcfga9PYpx7uwgoxT1gQch5fadhIkgmooBYT
         /fDla7sqQXkmlP3uzFLXLtUCnkTjUZurzrp9/+fuNvo7TpraqW3mH5RAljVvAkrEUU6v
         F9BRQRjsrkJgj178aW48vEB4PzZUR4qiyToBOaTQ7obvaJk+H1PkCKhbXNWtZ779yesV
         Hxkg==
X-Gm-Message-State: AOJu0YzCcJ9gLstSrXpalBBiTHzVyusnrGkb9z0gtJRtLU24Ev4FdmD7
	b2o/MUuYC6wPufHgr64V88n/xMTOWrq8T8CaiKotBXoc8uBSZPtDFqxmd2BI
X-Google-Smtp-Source: AGHT+IGJ1yVqj1jA3ba5GAi5QXCPNE9RLp8YzFnSiJSag4GvCzHjZZavFe6n9BEguZBFEQgc7u3rfw==
X-Received: by 2002:a05:620a:46a5:b0:78e:b9a8:a0c5 with SMTP id bq37-20020a05620a46a500b0078eb9a8a0c5mr19698qkb.67.1712723633336;
        Tue, 09 Apr 2024 21:33:53 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.39.180])
        by smtp.gmail.com with ESMTPSA id b11-20020a05620a088b00b0078d3b54eb76sm4756365qka.78.2024.04.09.21.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 21:33:53 -0700 (PDT)
Message-ID: <661616b1.050a0220.7963a.9b86@mx.google.com>
Date: Tue, 09 Apr 2024 21:33:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1414485021191414069=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, duoming@zju.edu.cn
Subject: RE: [v2] Bluetooth: Fix use-after-free bug caused by hci_cmd_timeout
In-Reply-To: <20240410035300.21160-1-duoming@zju.edu.cn>
References: <20240410035300.21160-1-duoming@zju.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1414485021191414069==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=843066

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      30.68 seconds
CheckAllWarning               PASS      33.50 seconds
CheckSparse                   PASS      38.47 seconds
CheckSmatch                   FAIL      34.98 seconds
BuildKernel32                 PASS      29.46 seconds
TestRunnerSetup               PASS      528.64 seconds
TestRunner_l2cap-tester       PASS      18.47 seconds
TestRunner_iso-tester         FAIL      35.00 seconds
TestRunner_bnep-tester        PASS      4.72 seconds
TestRunner_mgmt-tester        PASS      107.82 seconds
TestRunner_rfcomm-tester      PASS      7.34 seconds
TestRunner_sco-tester         PASS      14.96 seconds
TestRunner_ioctl-tester       PASS      7.83 seconds
TestRunner_mesh-tester        PASS      5.83 seconds
TestRunner_smp-tester         PASS      6.81 seconds
TestRunner_userchan-tester    PASS      4.87 seconds
IncrementalBuild              PASS      28.58 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 121, Passed: 120 (99.2%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.183 seconds


---
Regards,
Linux Bluetooth


--===============1414485021191414069==--
