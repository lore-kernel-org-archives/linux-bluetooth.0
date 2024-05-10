Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0AB12C539
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715355162; cv=none; b=sKvE1vy9Yl30BqhPGP8rC7OOZ4qvERT7y+g/CqBdcNXeHVTezZXVaXw+Q1KDHHQRdnWymvg0d4UrtS/n3XvfzcxsJc7gDdkYpR5Fgr6dX9Pcy6Hc/+KX8yXJ2XgvtD4X2V2pkgL9LYqTm6PVtd8+zAUR2Ct7Ncd3Qlgst8sRvi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715355162; c=relaxed/simple;
	bh=Vw3/IDg+lWyl4Bdle7IgWuSDOwOK65OIjvecylFyiJs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=chnv+0X4E1Xb3WFo5U1HmuEb/wbieqtgqJZhQunUWhWz3G/M0/X371c0+qHE/a4ZzoloD5H511Iunxrc4U4gY8kN1TPVmIC6BGyCxg8NA+hnGxsXkCk/t6XLCJF4fSKgyzItpRejg4H7YOTlAR++QK+yPqjn5woNlx/+V1tKdgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axt91xr6; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axt91xr6"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-792bd1f5b28so181834885a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 08:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715355160; x=1715959960; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=27knQoR8dDgDd7FSx6b09++f5sqCj+WAHmx4r9vfrlI=;
        b=axt91xr67SFruTA/cpxJ90p76qXHaGuufo77s2yEHcj51oDYKNRzfCAKswZyylnRx7
         fOmrkkiLGuExpeEMoumzSWSzBpbLjlA7ostxEZkkObxUCZkZxJCH+lj1qjsjuJ1EzD0J
         4eg9te1zEiE+YrvwJUYINSNcb56dj3aWXdCSWA+eyYA6dPRDjIWQSuW0vTQtkH3jGEvC
         V5SGV15dZE7JtMhI+7wqIoBQnrRJs21KEt/kDHF8xJk0HOJ1Dsiwte3Q+iynHgK4kF2g
         TFV7kwGuCxZ1PBVWp50CwkXpFNxrwaNF6uxgKKaEqhypFz98epb83bAQaM5HbEJppR22
         q2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715355160; x=1715959960;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27knQoR8dDgDd7FSx6b09++f5sqCj+WAHmx4r9vfrlI=;
        b=nr4ov6bQFHbe0ksNl4duxo2zi9yE8GOyChoxOKuQ4oFLcE+SXvYd1+z0cTRfu6Tyw9
         Dz33JjSktd6cvmS9PjRkj5lAhnUI9a5T7pq5UDjRsnAwA+8ak1JjS+sHFPEc4aI21BLR
         AEeclRBqsCT4LA5qINIUE72f00REfml/7EXXOYCkfGquMPXy/OZfqfBV54AWOgrXzA1p
         dGA3r+Mmsp2xL2Pbs4rwTFVeJ48n6EXJxS4YEFm00vQnRnlpIgTCtIWoiKORNY1UbSAZ
         jMGxxjxm0l9F/QAtb7+tuAyuYKjWyinbLmx5qpv4SYkK7tA766OJKzg3n/gMeMflclSh
         582Q==
X-Gm-Message-State: AOJu0YyDz4db/tKi4xfuiMmIL2u7qitt8MqsR1TrUKIRTDr7NkHYcme9
	8lDbvR4FOEji8HV0Z+FVUH+1+T+BS38B06EG4nxi5foyNSkBXYZcgkhcJUEg
X-Google-Smtp-Source: AGHT+IHzWpxa/oUhh3QonYJMftyJjCsc2FYeWNKTJZKfWCntNMmRFyu2SMpQfuHJiZO6GM1yQN3L2w==
X-Received: by 2002:a05:620a:102e:b0:78a:5fd9:46d7 with SMTP id af79cd13be357-792c75ffc85mr310309285a.67.1715355159605;
        Fri, 10 May 2024 08:32:39 -0700 (PDT)
Received: from [172.17.0.2] ([172.200.199.255])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2a3c8bsm189755285a.70.2024.05.10.08.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 08:32:39 -0700 (PDT)
Message-ID: <663e3e17.050a0220.b9e9b.5a1c@mx.google.com>
Date: Fri, 10 May 2024 08:32:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7061551724168026437=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3] Bluetooth: MGMT: Make MGMT_OP_LOAD_CONN_PARAM update existing connection
In-Reply-To: <20240510143645.1408056-1-luiz.dentz@gmail.com>
References: <20240510143645.1408056-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7061551724168026437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=852326

---Test result---

Test Summary:
CheckPatch                    PASS      1.08 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      29.98 seconds
CheckAllWarning               PASS      32.82 seconds
CheckSparse                   PASS      38.14 seconds
CheckSmatch                   FAIL      36.05 seconds
BuildKernel32                 PASS      28.98 seconds
TestRunnerSetup               PASS      521.04 seconds
TestRunner_l2cap-tester       PASS      20.32 seconds
TestRunner_iso-tester         PASS      33.33 seconds
TestRunner_bnep-tester        PASS      4.72 seconds
TestRunner_mgmt-tester        FAIL      115.22 seconds
TestRunner_rfcomm-tester      PASS      7.42 seconds
TestRunner_sco-tester         PASS      15.04 seconds
TestRunner_ioctl-tester       PASS      7.74 seconds
TestRunner_mesh-tester        PASS      5.80 seconds
TestRunner_smp-tester         PASS      6.79 seconds
TestRunner_userchan-tester    PASS      4.89 seconds
IncrementalBuild              PASS      28.11 seconds

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
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bpa10x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bpa10x.o'
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
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    2.534 seconds


---
Regards,
Linux Bluetooth


--===============7061551724168026437==--
