Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66D7146D5A
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715866463; cv=none; b=ZqMX+4El8b4+Y0rralSnDBKbmbQYj/h3PFqyKx51J+tE9zqesHs7ACMxi4wuPusBfMX8p8BeN6rTxNk8BfuLECkfr/d+gEppYmQrqG2zvvWM+xk61mkcgWl97M5edZQdvkNoR669Y6jEuEOhMOhuN5tt0Cp+yXuIJDlUxKVRgIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715866463; c=relaxed/simple;
	bh=vez31ktpoT9WbyHWysFJMSIvFq8JC36rWHeieN/Elc0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KwddjANlipvyVQ4ioyam85fxmlu5HfFb/h7OW6xqPvA6lM1lyK5EHC8pscOpW+Dml8v+ZvtHoi1ADJelMEmNz3PQSMJspkhp6u1k3LUbOyf4XKrFk51RJVToMf6EAqMFkV8M5K2PiM8fToPQ9zojqXn+Zxn11Z5y0o/QZg6yXrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xf1KWOXQ; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xf1KWOXQ"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-69b782287f9so29179486d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 06:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715866461; x=1716471261; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sNTRWVR/b+NDB39/kulNRx3gJWgR59f7aCZ+KsFUFKU=;
        b=Xf1KWOXQkZys8vx5LXXdDWZ4wPQ5YrDOggx1sjScQ4zz8kDRTloWEIkwg5wCPw1hUO
         gdYEi02U+DG2p3XQpB7FqGc6dNvufoMtGLHcP5aiZ7IGvv+k52074DL2RlbyN1RK2TsR
         aziib3sSpLvKmlrPLHOMMrzI7B41JCPd35Ul0tu+5lT8ziKQ7GjLiW+zlOwpCfxCkNmA
         yjg77Bmrwji0StEy58hsPp7uqrnvLpy1FiQcZTnTiO1+kWtVRpV5d10ZeUoYLGURhmj2
         OjheKP2KgZlKjK3r5Koutoz1xnkSo1kMqvfpDvZ0R1auI+UVTsUCdP6cHxQtKxBe5dxT
         8O8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715866461; x=1716471261;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sNTRWVR/b+NDB39/kulNRx3gJWgR59f7aCZ+KsFUFKU=;
        b=T4x3BQORj7pwMmOwEE4Q0AIKpQyJzMiqE5W8JVZ3i+F/qOf4u4uM0ZhUgzu1SZ3kdH
         HFZNF+ZBNIxPLUjoD4c7+wneEvux6PcdnXEbxk84E9sPIS/zhqk04oiYUgisWZrXwMqh
         nIaxAMogxEJjchPGFslxxhmYMbkSC4VY8KmKbUi2Awe6U0T0xxyvMq+7GkLBmmv+8Z4G
         VaIh66GIAfgRyux3LP3MZTz65vTdoBVkv5rR7bLBi3+qC1xl4DQJUI3WwPR1zEzfBSoi
         U8Budru9JwEY0V7KG69DMtDFqlmdVBPsx1e3A3c/inraBntkGRYyDoaWqJBlcHexY6nT
         AHbw==
X-Gm-Message-State: AOJu0Yx09lUyvYZVaO/sfRuNeccZT7H1+Ai4oR0hkjV1K4FnMSPeCryd
	c/ZsLok6LoizlZVfryJlhbAcfOEBrDB4HPlak+RQZ9/iUqdP2Ux8RJkOYQ==
X-Google-Smtp-Source: AGHT+IEeadRMUZFv6/ihuP/sd6kDfyeBs7PC35yo7eWo2hP/ABeItS0LKIVKfuAJLsRiiPge0hC+YQ==
X-Received: by 2002:a05:6214:5242:b0:69b:7eb7:a6ac with SMTP id 6a1803df08f44-6a16822c7ecmr208975656d6.51.1715866460746;
        Thu, 16 May 2024 06:34:20 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.88.190])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f20570bsm74808476d6.140.2024.05.16.06.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 06:34:20 -0700 (PDT)
Message-ID: <66460b5c.050a0220.ce871.8f93@mx.google.com>
Date: Thu, 16 May 2024 06:34:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1661413170365624862=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2,1/3] Bluetooth: btintel_pcie: Print Firmware Sequencer information
In-Reply-To: <20240516131510.904787-1-kiran.k@intel.com>
References: <20240516131510.904787-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1661413170365624862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=853705

---Test result---

Test Summary:
CheckPatch                    PASS      2.26 seconds
GitLint                       PASS      0.87 seconds
SubjectPrefix                 PASS      0.33 seconds
BuildKernel                   PASS      30.35 seconds
CheckAllWarning               PASS      33.13 seconds
CheckSparse                   PASS      39.07 seconds
CheckSmatch                   FAIL      35.37 seconds
BuildKernel32                 PASS      29.08 seconds
TestRunnerSetup               PASS      522.07 seconds
TestRunner_l2cap-tester       PASS      18.31 seconds
TestRunner_iso-tester         PASS      28.35 seconds
TestRunner_bnep-tester        PASS      4.74 seconds
TestRunner_mgmt-tester        FAIL      113.41 seconds
TestRunner_rfcomm-tester      PASS      7.42 seconds
TestRunner_sco-tester         PASS      16.93 seconds
TestRunner_ioctl-tester       PASS      7.83 seconds
TestRunner_mesh-tester        PASS      5.88 seconds
TestRunner_smp-tester         PASS      7.36 seconds
TestRunner_userchan-tester    PASS      4.91 seconds
IncrementalBuild              PASS      40.97 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    2.046 seconds


---
Regards,
Linux Bluetooth


--===============1661413170365624862==--
