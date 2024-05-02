Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7C316FF33
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 May 2024 16:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714669138; cv=none; b=jy850ZWuZl5FR9cWY3B50L0arxNmUD1QAeNo/XxvBW9EHkSKmFYvs1Py3ym+T06Vc7CnXnbAssC7MT6aDd2/Zmj3oG51LzFhIrN4UQ/kc39/D8MpgBZESPRZrlrdlTmbGLJQM5+Uw7JTp4lw3eyAKwaV9adbm7h2CR8/nCJT9GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714669138; c=relaxed/simple;
	bh=X/bBGfPAoJfd5OY9lEBa3KTzfAB8eAUxcyFLFvCijdc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nvV0QSRESEg7ou0rTfzgNPpPHOxE/UKceHE+2kPidFjia2N0oGVSx1T+VGjJJk4wVB4UpKUEUayfkL/IPj2KKa9g1i6uACkYP+2Ia7zeTFDOLEdz8xnjSDaqOJFodwah7Xb3xzmMMim/mR4JFtP3zD92WLU8GtE1dA3cuiEU/uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgrxP96/; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgrxP96/"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c74ff209f6so5115429b6e.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 May 2024 09:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714669136; x=1715273936; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VLC+4aLjHCSjcC2DEe0guuCBItqoO8IFvH4wrUbSvAk=;
        b=HgrxP96/GE8Jza+mXefqDlK9BlaJwTVrdO87u4rvXFEmJIPglI/GBDea4q6ZMiLLpA
         iHit76vm6S5Cki11hnmjekSCgpR2gDN7VsQOclvyRWLw9e1VBffrTI8I27buozks5f86
         rrFY8H2Wj8jdbs6U/+y32C95lgGfpUUogRvrpJKJoCsx6kwTeDgMxwvOdTFgme1/41Nk
         IiCF9ilRe+FrjruHBm/ABvKZzDI8vDFkPUd6G3TkMlypXyppURZk3wNv1ejSgZZtCYlp
         G5vOeGKAJj8BUxCkI6CJZI/ku05kETb/Or5WhNk714D90oY3aAgnQJ3W5dugNWzHEZr9
         M1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714669136; x=1715273936;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VLC+4aLjHCSjcC2DEe0guuCBItqoO8IFvH4wrUbSvAk=;
        b=EvJ9jI8SjpzFsDtuNq+qvZATcj7TODOHTXqz8ljnmoSTnYv2vBmgCic+4d4GKqeWDM
         YbWaYktWGaLujGhetcsHHHRGSS6udforOLgDZsOJdSGHz0FwMpVNivJ0z1mRg9S/QC/r
         uwb1kA7Yd3VpsGdbClq6P+8GCaagZYDvtHgsPfpYHmF/tCS1J6IuNwoz8LhWfQHb27kQ
         sxO29epl3oUWSwWqiN/92LsQRazpZFiSoqyCZdVLilcLQGIleZyDO0m4MT0N0xKOAfAM
         Vp/rBzQMXrKx4pQUBEZ1KS0CAXaDVcrVBpHRlQmxncdb808JDL7NcXNyEJ1C+iveqM1J
         ENAQ==
X-Gm-Message-State: AOJu0YzV4ki6lyccCauUkDpSiUMpGBuzw3MxcbkYkIDoRGiM2XuFlZsu
	0Z37lhczR3768oESlQchQNJRfJNsJwcpiZA63yUpHHlkUGobKsYnTyhYxA==
X-Google-Smtp-Source: AGHT+IFMMeNlon7KcX3y5j6N3Mh9ToRK95K2sy8gthrJ6FICqKU2baXV8Ft81/KG28XlvUIYip3rvw==
X-Received: by 2002:a05:6808:ec6:b0:3c7:522c:3407 with SMTP id q6-20020a0568080ec600b003c7522c3407mr572566oiv.12.1714669136316;
        Thu, 02 May 2024 09:58:56 -0700 (PDT)
Received: from [172.17.0.2] ([13.90.174.199])
        by smtp.gmail.com with ESMTPSA id p17-20020a0cf691000000b006a0cc19f870sm489992qvn.9.2024.05.02.09.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 09:58:56 -0700 (PDT)
Message-ID: <6633c650.0c0a0220.c294a.2059@mx.google.com>
Date: Thu, 02 May 2024 09:58:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8278603591960857949=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iam@sung-woo.kim
Subject: RE: [v2] Bluetooth: HCI: Fix potential null-ptr-deref
In-Reply-To: <20240502160931.1135175-1-iam@sung-woo.kim>
References: <20240502160931.1135175-1-iam@sung-woo.kim>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8278603591960857949==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=849964

---Test result---

Test Summary:
CheckPatch                    FAIL      1.14 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.19 seconds
BuildKernel                   PASS      29.68 seconds
CheckAllWarning               PASS      32.60 seconds
CheckSparse                   WARNING   38.20 seconds
CheckSmatch                   FAIL      34.98 seconds
BuildKernel32                 PASS      28.80 seconds
TestRunnerSetup               PASS      515.43 seconds
TestRunner_l2cap-tester       PASS      20.45 seconds
TestRunner_iso-tester         PASS      31.36 seconds
TestRunner_bnep-tester        PASS      4.68 seconds
TestRunner_mgmt-tester        PASS      109.26 seconds
TestRunner_rfcomm-tester      PASS      7.23 seconds
TestRunner_sco-tester         PASS      15.07 seconds
TestRunner_ioctl-tester       PASS      7.67 seconds
TestRunner_mesh-tester        PASS      5.80 seconds
TestRunner_smp-tester         PASS      6.77 seconds
TestRunner_userchan-tester    PASS      4.88 seconds
IncrementalBuild              PASS      27.83 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: HCI: Fix potential null-ptr-deref
WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes:  ("Bluetooth: ISO: Notify user space about failed bis connections")'
#81: 
Fixes: f777d8827817 (Bluetooth: ISO: Notify user space about failed bis connections)

total: 0 errors, 1 warnings, 0 checks, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13651869.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


Use of uninitialized value $cid in concatenation (.) or string at /github/workspace/src/src/scripts/checkpatch.pl line 3229.
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
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


--===============8278603591960857949==--
