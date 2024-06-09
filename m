Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27FF210E4
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Jun 2024 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717947128; cv=none; b=EnTOCRA1P6Ew2Y8GN3SYpaIyHtErz3lrtUqXdc4RdNxiNUDPdphpnJiO5azChxd2kklpUlOsoLa1441/2hWnN8xygJzomy4TcvE9SO9dpuD6Z8Upjsa7N2hpQQYcDR4vpZjva6ZCRyceo/wx34YZ1uEWJ6UAHM/05c+SOmvj/zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717947128; c=relaxed/simple;
	bh=6A0zIQi74U9lbuO/ZXSOGSvVTRlJrc4Kj9KbcG80m7s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ktqR0HSv5/G0E2YcjQ5N7/a2Vd51dUKYxZ+QGZ+e3q1KQkNvhmS5Fza+h94via1FsPxbsYyFcxEOdf6TVbvnx+9efAKvXsr5JCUJDkkg+tAMYYuSvu4/Xfyj2rv1vVoTYLDggp0m2vs1lD1jf0ImYbPuHiD6YhCnZ4AAqt5MFe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MERaOhVg; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MERaOhVg"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-795dc9e0d15so11494985a.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 09 Jun 2024 08:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717947126; x=1718551926; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uAIDGT3v3AN69P4WOQ9CX8XkgQkKUWgm1smjm+Gs8Is=;
        b=MERaOhVg09/JNiN/r6l+eyLumXf9KllBSAGLjeOssxukubVk4YOnLyTQ8K0gCaH2iy
         L9iemv6HedrLDIcbYlpQQHikhj4IxoZTnnZMml6/37aao4EC0EG7dDukDe2CLQ1ubZuD
         wkuJ2/M+a0pQrfhX/bICeBA3fpHT2TPtLuOK21AjjNldO6GlCXY3XDPHayaAKunA2pmL
         dFNK7ZPFK3J3bWO2dHQhkC7onam3GkEGqrnCUR1DKR1I7Y0tkGTRBs2BeEpEunBwMeNW
         2N5wX4aZFc2KP2cRm4FgzZ7FPHKbP6CEHRX/uVGWebn4wpG0zL8FnGqZf+7E288m8Pa1
         JyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717947126; x=1718551926;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uAIDGT3v3AN69P4WOQ9CX8XkgQkKUWgm1smjm+Gs8Is=;
        b=l/pquoyriWA2JTlt2+ahYX0+iDzp201ubRxMHBs2B3nWtNRnkRlWUUtyuQM+cXAdqx
         J+Z80V2f/047wSsVpIQn5MNi2kNgbNSHvcFlLwrIBwCwTnrlMrA+6Lg2T2DPvm/Qx0DG
         Xs6Vm/gq21b3BbyX14E85w0XO3umkIp2+sK9Ac34sNlzYS6RQwvm02HqZxhwmSQ5x/+e
         QU8bipfxm81hWMKkodvuXvDUDff01HHXNwpkIjTPqazb9rL0KZdZhVClz2mzjeADE4Ob
         5jrBEUf7pEEAQ1iKHJXY57ZU9T13vR0IghxhP5edKg9aV9w6gZA1892y67T8ULDI4rog
         a+Mg==
X-Gm-Message-State: AOJu0YwS3f1nGbLcut2nKvKc3NxCQwx9hq2q2WrPyYNyIqYIXv4AJ+KQ
	YEqn9L6KRscgWE1hqIW+8GQCuoPwW6ScQFYZH/T7M7tsG9e5fAaYl3YZSg==
X-Google-Smtp-Source: AGHT+IFnG8dV5ZAl0MiC+eKtRRVU9JsuVp7fl8er60Tt+w6JgXEbH7ekCz71stTN2vgCLWElhwrnlg==
X-Received: by 2002:a05:620a:4710:b0:795:4711:21d9 with SMTP id af79cd13be357-79547112354mr694669385a.41.1717947125606;
        Sun, 09 Jun 2024 08:32:05 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.111.253])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7954e1be2a3sm193726985a.38.2024.06.09.08.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 08:32:05 -0700 (PDT)
Message-ID: <6665caf5.050a0220.eefa4.6b4f@mx.google.com>
Date: Sun, 09 Jun 2024 08:32:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3098542558909889412=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [v2] Bluetooth: fix connection setup in l2cap_connect
In-Reply-To: <ad69720e0ba720209cb04240fbc3c5ff059accbc.1717945321.git.pav@iki.fi>
References: <ad69720e0ba720209cb04240fbc3c5ff059accbc.1717945321.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3098542558909889412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=860256

---Test result---

Test Summary:
CheckPatch                    PASS      0.79 seconds
GitLint                       FAIL      0.54 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      30.75 seconds
CheckAllWarning               PASS      33.22 seconds
CheckSparse                   PASS      39.03 seconds
CheckSmatch                   FAIL      35.74 seconds
BuildKernel32                 PASS      28.69 seconds
TestRunnerSetup               PASS      520.59 seconds
TestRunner_l2cap-tester       PASS      20.24 seconds
TestRunner_iso-tester         PASS      32.85 seconds
TestRunner_bnep-tester        PASS      4.74 seconds
TestRunner_mgmt-tester        PASS      112.00 seconds
TestRunner_rfcomm-tester      PASS      7.42 seconds
TestRunner_sco-tester         PASS      14.92 seconds
TestRunner_ioctl-tester       PASS      7.73 seconds
TestRunner_mesh-tester        PASS      5.82 seconds
TestRunner_smp-tester         PASS      6.79 seconds
TestRunner_userchan-tester    PASS      4.90 seconds
IncrementalBuild              PASS      27.56 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: fix connection setup in l2cap_connect

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
18: B2 Line has trailing whitespace: "    "
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


---
Regards,
Linux Bluetooth


--===============3098542558909889412==--
