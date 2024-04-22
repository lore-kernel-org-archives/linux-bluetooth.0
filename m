Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFEC1514C3
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 14:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713796339; cv=none; b=O9mdq/lmpG4VYtghQNNPzx+e9Em0sN2wwN1WyN2gDHl5Y7HjGoL9sFeqCM1HlDcHZT1ocme4qeqBWvTWNWALGeJlMLhsdpHKwkpVSR2ki2OF+FMQmhRVRnQxkeEK8aRsCAgc1mTLdYUHBul3vMbMsR1FdInpJrs26e8xp8GYDfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713796339; c=relaxed/simple;
	bh=hmnvVkZTw341SgIX4swFV0nSX7mz0TzNBRtG1xDURmg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DjFjGNbsA7FzBWT0YID2ODhNKSAovy5bKzClv+zJreXpyIXA0shWMuSr/1YjQpf9NO5Gnoc/lUIzk73D1TRcHQA6/rP/eAJqNRDkN1i0joyUMzQO/GbpQIOspfLxOcR+E/RYQhOwfaEzYIGR7HDKuypaGZrJy4Ayqflo6oEE9go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkhOVKJI; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkhOVKJI"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43969307359so15061151cf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 07:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713796337; x=1714401137; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uGxa8wNuQqRpm12xIRx1XK3suawktRza0vClJnA2PTI=;
        b=fkhOVKJIwUrQH29DGxK7j8uANhV4Yas6grlVNg4MHz93Ej5R9AlnhRbPbUffZhRWxU
         54jRCsqjfForHnf4QzwaVEDhCOfQp3PzxTIP4driQgTFROOXfVB08EtiU+trMHqf1Y04
         /W6xe4T6hL5LwWJOHIYilEDbae8OvGezIdL1wzJFOY7df1oEIN6yV1fo0aAt6St4++r+
         mI/C0ECip7bRZ9UJgYyawRhB584zwOVuG43dBn5YGzDV4/vXNZFJVJXQsP1qpJ/Fhtpq
         9vyJTkFQL2YazhG1UIj0/9AldgCLu/YtDKY/f6ESbtQxnUDlokIiV9f4eg0XCawaV84p
         IjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713796337; x=1714401137;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uGxa8wNuQqRpm12xIRx1XK3suawktRza0vClJnA2PTI=;
        b=VPwglAar7qPI8ifIQco0USO91dVNq5VowPKs0tz5SumwoFySSwixJQ5z/EsPqnpjDS
         Wi3s2vBXL5BfBLwAvvb/fQLUTNVWQfpMffyhDXT7Mj3CZt3tPPnoX9dztr87ZO1C2lvN
         z6WQOmxbl7cmOcIkb5wYCIhejSTZhR/1axGTWct36IRHuSk6EUgXikaKwjjq/JwiNEzg
         naz1VtHkhpTgynpaFkzJlN1VXZrw98HrRap6xI9pTQHzIAXdZ/KRWk0e8d9uB2JRaBD3
         L+qGgZkROoht/qQVg/18Hyn6Vk3kNnOHq2MvxE3NLv9nzXIjwBXsEqWOUWasiJEfIURN
         Re5w==
X-Gm-Message-State: AOJu0YydMI169m67OV1r23cOLx2ZcT7mCILTQQLmNmZtrbtGsaOV6dId
	ARE0u4DE6QhWQ3gsrXFOWm9KBvNeD9M061730aPQQFiTI1Auaj+VSLUrJA==
X-Google-Smtp-Source: AGHT+IGdtl5Wiis7wK52rqyj2CKHTgVPH+vuMsJkbm9C+n841xUaV6EOcO9KVIqkxwBbfJ+vufUbSQ==
X-Received: by 2002:ac8:5941:0:b0:437:9fdb:9817 with SMTP id 1-20020ac85941000000b004379fdb9817mr11967679qtz.20.1713796336694;
        Mon, 22 Apr 2024 07:32:16 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.98.205])
        by smtp.gmail.com with ESMTPSA id e16-20020ac845d0000000b00436e0261c86sm4309453qto.45.2024.04.22.07.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 07:32:16 -0700 (PDT)
Message-ID: <662674f0.c80a0220.faed0.1b2e@mx.google.com>
Date: Mon, 22 Apr 2024 07:32:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4079731828983499835=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, johan+linaro@kernel.org
Subject: RE: Bluetooth: qca: fix NULL-deref on non-serdev setup
In-Reply-To: <20240422135748.23081-2-johan+linaro@kernel.org>
References: <20240422135748.23081-2-johan+linaro@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4079731828983499835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=846689

---Test result---

Test Summary:
CheckPatch                    PASS      1.25 seconds
GitLint                       PASS      0.55 seconds
SubjectPrefix                 PASS      0.20 seconds
BuildKernel                   PASS      30.52 seconds
CheckAllWarning               PASS      33.41 seconds
CheckSparse                   PASS      39.05 seconds
CheckSmatch                   FAIL      35.60 seconds
BuildKernel32                 PASS      29.92 seconds
TestRunnerSetup               PASS      532.50 seconds
TestRunner_l2cap-tester       PASS      18.42 seconds
TestRunner_iso-tester         FAIL      31.55 seconds
TestRunner_bnep-tester        PASS      4.68 seconds
TestRunner_mgmt-tester        FAIL      112.15 seconds
TestRunner_rfcomm-tester      PASS      7.39 seconds
TestRunner_sco-tester         PASS      15.04 seconds
TestRunner_ioctl-tester       PASS      7.75 seconds
TestRunner_mesh-tester        PASS      5.84 seconds
TestRunner_smp-tester         PASS      6.80 seconds
TestRunner_userchan-tester    PASS      4.99 seconds
IncrementalBuild              PASS      33.50 seconds

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
Total: 122, Passed: 121 (99.2%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       4.245 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 7 (AL is full)               Failed       0.195 seconds


---
Regards,
Linux Bluetooth


--===============4079731828983499835==--
