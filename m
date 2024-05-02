Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6141041C60
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 May 2024 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714656819; cv=none; b=KBrLt2f+tp9w+MBMOEOR5yRjRz+tVMwbp5Bra91Qyxl08LP+JhfhxJWlTxouG/+jzmB9aBNt6zLlMob/JhrE9W/gz0wSNtpnYMg27fl34uJ3gLejQNFQQkGZ16mmS7tCfqaFk1OBtwL4mcrd91c66kWEobb67Msz4bCMryi7yQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714656819; c=relaxed/simple;
	bh=oQnuIZm2uDkoikfgzwXYvhJs+WmOiZQl+5zkjYRqqOQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qtoP3kiS/S1rQ/QBGDdJZsYvdCs/oj3Okc0RtOD/8F+fvJ3acarSOzo0SmK3Yi3AHY+kk1qULldIv72ro2GmFdRyD/bAFv3dYcYT0zdwZGRozXmpDoXZuVQKg/j9kOXuq4ePwp7vjFm0pSN9AzlB9BNPmgaZrZGGLRqPOY4r0js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U98/4ZMA; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U98/4ZMA"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-43ca8e1f990so8650241cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 May 2024 06:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714656817; x=1715261617; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9l2qIolQ700+oMmfFQW/0mxG+oAX3Ki/c/ZqT/iyawA=;
        b=U98/4ZMALJV3gEsLM86E//2gZZcVBbmuAP+/akSvBOgBo1nRo6rETrT9+eQOF9grkD
         2ZX5ZnvfJusCdkEw3F+GGj67T/HvIICm7yEfO1xMYYzzhwXryS1TJpxmVcWPz6jFthU8
         KKwzbmFZ3H3FFBKjvCoaPkCRfXwlmaYNRnS/yHqvX1HIYkclBGp7G+JK7slN/s6Q36Px
         b/3L6gdDUAMj636S6xjumQB7rR0/fUOOX1e0Hqeb65s/LaTGe7wTxJQ40hCXjsbylyIo
         Rx/KCJ2ULs0Omt/TEBPfxaIG6Ear10Qy9eHzESLEEO/AZVO9uxbY6P1XhVfVK35WLLqZ
         RPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714656817; x=1715261617;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9l2qIolQ700+oMmfFQW/0mxG+oAX3Ki/c/ZqT/iyawA=;
        b=vrULE3yfYcOWLD4jc1pE0sVj6S0c3L4ADh3tfMYIxvi4g2akUyE36gfS6Ex5hKpGKi
         GsNuKdyOmyiRzQnVXKA+ptPwsKyw4Fr3X7g9NUc/PavXA0DAW7m8RAwYJs1ipn/U7a8T
         sFQO0640aN2MFfPzrpgog7N5FZqThBzHyo3RleYnagkM7x8p5GsZvdWwgRm8VtWNYUA3
         U+1Kv3TyLAQemSIIc0YhWnujBonqY/ihM1T8aSwO/JY0aulSJYHCPPiyjEgaGqQgxSdh
         zVm0QIgJzftLCn/EoSqmtfedtkqkPB7WJarKiy1aOo3fJx68f3BZAhvsO2q42C8zC7L9
         0lsw==
X-Gm-Message-State: AOJu0Yw7v4PAlNFYkqDxfJ/JuUUQEdp3tI8g2WNWL1jAam3lAeMesx9k
	SsSCN/4/b0dI9ZiPPsTGAaQs+6rDTwPSWSrWZkZ4igERanYtuQSDV3U79Q==
X-Google-Smtp-Source: AGHT+IG9X+OspvQJoxZrmO+9AOWc4fgtWzwoj6k6DbhyGmV1xslH4CgwTqWglQTxdYrpASseJY3bhg==
X-Received: by 2002:ac8:5d05:0:b0:43a:b66d:1a67 with SMTP id f5-20020ac85d05000000b0043ab66d1a67mr4999037qtx.29.1714656816826;
        Thu, 02 May 2024 06:33:36 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.159.34])
        by smtp.gmail.com with ESMTPSA id ck12-20020a05622a230c00b0043aed0b8302sm469108qtb.61.2024.05.02.06.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 06:33:36 -0700 (PDT)
Message-ID: <66339630.050a0220.da58e.1392@mx.google.com>
Date: Thu, 02 May 2024 06:33:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3861893354889196112=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, duoming@zju.edu.cn
Subject: RE: Bluetooth: l2cap: fix null-ptr-deref in l2cap_chan_timeout
In-Reply-To: <20240502125736.28034-1-duoming@zju.edu.cn>
References: <20240502125736.28034-1-duoming@zju.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3861893354889196112==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=849889

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       FAIL      0.58 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      31.05 seconds
CheckAllWarning               PASS      32.65 seconds
CheckSparse                   PASS      38.12 seconds
CheckSmatch                   FAIL      36.16 seconds
BuildKernel32                 PASS      28.92 seconds
TestRunnerSetup               PASS      520.21 seconds
TestRunner_l2cap-tester       PASS      19.94 seconds
TestRunner_iso-tester         FAIL      33.24 seconds
TestRunner_bnep-tester        PASS      4.73 seconds
TestRunner_mgmt-tester        PASS      111.97 seconds
TestRunner_rfcomm-tester      PASS      7.27 seconds
TestRunner_sco-tester         PASS      15.24 seconds
TestRunner_ioctl-tester       PASS      7.77 seconds
TestRunner_mesh-tester        PASS      5.79 seconds
TestRunner_smp-tester         PASS      6.74 seconds
TestRunner_userchan-tester    PASS      4.96 seconds
IncrementalBuild              PASS      28.10 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: l2cap: fix null-ptr-deref in l2cap_chan_timeout

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
10: B1 Line exceeds max length (81>80): "[  472.074580] =================================================================="
14: B1 Line exceeds max length (92>80): "[  472.075308] CPU: 0 PID: 7 Comm: kworker/0:0 Not tainted 6.9.0-rc5-00356-g78c0094a146b #36"
15: B1 Line exceeds max length (116>80): "[  472.075308] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu4"
38: B1 Line exceeds max length (81>80): "[  472.075308] =================================================================="
45: B1 Line exceeds max length (109>80): "[  472.096136] CPU: 0 PID: 7 Comm: kworker/0:0 Tainted: G    B              6.9.0-rc5-00356-g78c0094a146b #36"
46: B1 Line exceeds max length (116>80): "[  472.096136] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu4"
49: B1 Line exceeds max length (116>80): "[  472.096136] Code: be 08 00 00 00 e8 f8 23 1f fd 4c 89 f7 be 08 00 00 00 e8 eb 23 1f fd 42 80 3c 23 00 74 08 48 88"
56: B1 Line exceeds max length (91>80): "[  472.096136] FS:  0000000000000000(0000) GS:ffff88806d200000(0000) knlGS:0000000000000000"
88: B1 Line exceeds max length (116>80): "[  472.096136] Code: be 08 00 00 00 e8 f8 23 1f fd 4c 89 f7 be 08 00 00 00 e8 eb 23 1f fd 42 80 3c 23 00 74 08 48 88"
95: B1 Line exceeds max length (91>80): "[  472.132932] FS:  0000000000000000(0000) GS:ffff88806d200000(0000) knlGS:0000000000000000"
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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 121 (99.2%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.176 seconds


---
Regards,
Linux Bluetooth


--===============3861893354889196112==--
