Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E1E16D327
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 May 2024 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714669157; cv=none; b=Ica+gx4V5t0QC1Lm/mn01gqJhBNMqRsggRxydeqJ8tJUxuXfhlNCH0zlz30n60v3tiyC/swraBXYmZwB9VrKzLqRIP8C4boKRS1Qksu+vNOFGKpl0psZkHXWn3FJH+1Ads2ML9g2+UymtQuDGzQdNE00TwJ0ZUL4ZtGI5on7kmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714669157; c=relaxed/simple;
	bh=qIfVr/nHO58mZFQSJ7EyaNKlbtsFJ1Ts4WU75fUJfDI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uH95mG9xZsBIwmW1UcfYrCqLrMuCLSqnejsEJSz2RISkYIvmGvIuiHy6ZC/pXBBb+qQf7KUs6sSo35lZekN8fO2g87iDKnKrdtOlDBKm07Az66iivGEds2zDxqr9Pwe91BacwK8g7HnevGxfP5OrCZbAOafYNLKiHTcaIA4MXh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEZgnam5; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEZgnam5"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e50a04c317so45693385ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 May 2024 09:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714669155; x=1715273955; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ILYuo2ULSW7b/er4zhUPwhiloGEnS3WrVz3220uZikY=;
        b=HEZgnam5vkUJuMSPRQF3TqSiL26nEj97G9uTG0LUib9B2s+YqPCTzQNOUJbWDmUwp0
         G+xV15dZqYn7Os0E0sIFdw2SUkmLLB+npxEcK6uX6aHGzYLvyXiKUFexJubNaaumQOE8
         FepSVJCWD5qdU4EHhbR+HUkUbb+1TCHX+JrHbMZ3lWJnXB5/V5TLXy70N12+MNRZWo2X
         pP17Sm2oXTM6vEIALLL/ep1UBFUKe/5P4v6Khsuf4M71bsZF7UToDRRKMGwEwAb7UBbn
         +qwGN9vym5XvF19n6TRVyhK6+mD2EOBOBmK7cctVV6UxmMpAEbyrbKg1LQm4mwRzTL7v
         txgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714669155; x=1715273955;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ILYuo2ULSW7b/er4zhUPwhiloGEnS3WrVz3220uZikY=;
        b=A7DKEsHXO6ww/xrpZdPDxFsP+ohmN+/dMlpsZEr/lun28DoDmSIda2CT8mZb8/cQgB
         7aQbL87Ls61ubF1voFj52Z4X+Fj4njeIBjvFcro3K47ZYZ+iU6LGX25LjWQbRvz92ihw
         qyfhW6sVv03r50cXFAe07rVEYGfzltlporI6HRryBSfcVP+MVY9WIH4BHlRkyV3rncji
         TSmK3hcrn1TL5zf1kTQOvAIjTg+27CT/oq8ppMIVewr7uy5txthQwyVy6nxwM02mROgD
         h/pLZkEMd3bAhGBnQvU1m5xStBR+Kdv2ixm4TN8CjppicSDSINICCqXimMzAwVxWcbFW
         PPLg==
X-Gm-Message-State: AOJu0YxK+t8q22fEZbXu290v5mlYVbfl5rCOtApsABv/3hy+Ghrq6ymc
	A4DeMgT2FrIfLTr3zpB2BEzxR2yIr8J22wBziO6LdXMz8Zb5Iv/WwAaDoQ==
X-Google-Smtp-Source: AGHT+IHO/uwy2q0qkvOP4bEJP58eMg3Bddh3u7RaIhLEZi3TNuznqWPGQO6R/JDu/4Ux9BPU7k+7eA==
X-Received: by 2002:a17:903:40cd:b0:1eb:4a94:ebad with SMTP id t13-20020a17090340cd00b001eb4a94ebadmr370429pld.35.1714669154767;
        Thu, 02 May 2024 09:59:14 -0700 (PDT)
Received: from [172.17.0.2] ([52.190.187.38])
        by smtp.gmail.com with ESMTPSA id u9-20020a170903124900b001ea9580e6a0sm1544239plh.20.2024.05.02.09.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 09:59:14 -0700 (PDT)
Message-ID: <6633c662.170a0220.ae619.5598@mx.google.com>
Date: Thu, 02 May 2024 09:59:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0013518099679516887=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, gustavoars@kernel.org
Subject: RE: [next] Bluetooth: hci_conn: Use __counted_by() and avoid -Wfamnae warning
In-Reply-To: <ZjO9qCx10KUJbK6w@neat>
References: <ZjO9qCx10KUJbK6w@neat>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0013518099679516887==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=849960

---Test result---

Test Summary:
CheckPatch                    PASS      1.64 seconds
GitLint                       FAIL      0.68 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      30.02 seconds
CheckAllWarning               PASS      32.49 seconds
CheckSparse                   PASS      38.56 seconds
CheckSmatch                   FAIL      35.75 seconds
BuildKernel32                 PASS      28.86 seconds
TestRunnerSetup               PASS      529.44 seconds
TestRunner_l2cap-tester       PASS      20.60 seconds
TestRunner_iso-tester         FAIL      32.45 seconds
TestRunner_bnep-tester        PASS      4.69 seconds
TestRunner_mgmt-tester        FAIL      112.58 seconds
TestRunner_rfcomm-tester      PASS      7.45 seconds
TestRunner_sco-tester         PASS      15.15 seconds
TestRunner_ioctl-tester       PASS      7.86 seconds
TestRunner_mesh-tester        PASS      5.89 seconds
TestRunner_smp-tester         PASS      6.77 seconds
TestRunner_userchan-tester    PASS      5.07 seconds
IncrementalBuild              PASS      28.43 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[next] Bluetooth: hci_conn: Use __counted_by() and avoid -Wfamnae warning

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
18: B1 Line exceeds max length (158>80): "net/bluetooth/hci_conn.c:669:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]"
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
ISO Connect Suspend - Success                        Failed       4.189 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 6 (RL is full)               Failed       0.191 seconds


---
Regards,
Linux Bluetooth


--===============0013518099679516887==--
