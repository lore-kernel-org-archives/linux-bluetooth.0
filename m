Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAA7200DE
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 May 2024 11:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714823759; cv=none; b=BlTVPyp0dR0gF01m9oFluDad+Po7YZqkrF7ZxHS9XYtYOCiz1lg3hEtNW6fRWGrfuAuG9V/NMMx0FjnR6pik0/jgCI+Aklk8XXXf7B3Q7NrFoXaeoGo2cuBR1yh9riFhmpuUjVD1EkqM8fwm7PqfGtFN8EBr8lQtjPqTQFuu2p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714823759; c=relaxed/simple;
	bh=Q4I7mYUN88YU24VVCz9T31iDSu0p3P5bvQm3pa+9G1Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=My1xZlek0Z2xhJuoJ7jGylxKvvwUnfnSNFifLuHq5ivMf8C5wse6kf/KVQ7EDwFl87JfjidTX3PGfI+InApMfRt4yb6Ivmgi0WwzNV6sygsTvbRy1hiIeci0JmFr2K05B/unvSLgNkxJ7JRPnWVNGe7TIPr/ICeSOajGAaqgPxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miHJB+It; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miHJB+It"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5aa1bf6cb40so416872eaf.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 04 May 2024 04:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714823757; x=1715428557; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yazpc+tlhucITUfyeCXprOnNbYe9kONOHm30PXTr1fk=;
        b=miHJB+ItzpSJXjEJQorUfnDw7eyOry+INcz+e0NzeoPOnvzil4ZFweNtBdIp7tJLup
         gRbqld3ys49bPofRqeS7OtYppZ93nyKweR0PKC9I8IvsSUwMbseiUOKDs4zazJVzhH8A
         aiuiLbwsES3Gw+A4S+1gtimIlgLryExa6kMpqi7KLdio8PzQCg3QrC8z+NDymxbWxpJN
         QPLEnKs1RopmPxGb3HoMKttpa2Nv4D4rL5U2TEbNoCYV/jhFFr3TZQcpmpflw4yNwGAO
         RLzBISCvlXFcK/FzmzvV0xbzoHTPORNxt0R+eNKGAcd217hDkZcFC84mCyPCZa15mP8q
         VJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714823757; x=1715428557;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yazpc+tlhucITUfyeCXprOnNbYe9kONOHm30PXTr1fk=;
        b=J9aK2yQGz9RVJ2bivPJFQR+yzQghZsjXu7nnO7cwgQQspCgLqWZi3wZ3qlAFdPObIV
         YcOqOadBM8yWLCpJFgi1WY0VRRwGwcrgiqtwtvWed3kA/Tfz+JfKRHptX/iDz1REW+vF
         ULVxVaJazDYDGiCl36mHCJ+ZpTnKlXwgF72qUAdgyG14L978BFY0Jw5t3udtJHdZZzzp
         YtAdMvbxNE7uiN65SIhn8AEsHHoC28c6kVnVTTMg8tQB2w06sk0R+Je66zxIE2w0BkYS
         XOC8IG505b3oEEYWfyiFn+MHaky0IOR7D2hsuyLJgF4SYAHhoByrdZRdRKL312ermBqs
         g58g==
X-Gm-Message-State: AOJu0Yy8MwjHLhCdwHP/vworiVxQALD5kKgjMLXO1AJ7FDlC45/HcJoU
	bPdO9BtfbuU8PtWKcKVkV/rPCX4iLHDGaY6yfdk32WlsIDd2Q9mB+pQ+Xg==
X-Google-Smtp-Source: AGHT+IGYys2YxtTPi7+EExspldyull/dTNIiRmOb0UbLcQSc+kfmiDCkB34nl1OUjFusthvcfhzE1A==
X-Received: by 2002:a05:6358:e48b:b0:183:7d27:c07b with SMTP id by11-20020a056358e48b00b001837d27c07bmr5666690rwb.32.1714823756790;
        Sat, 04 May 2024 04:55:56 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.0.44])
        by smtp.gmail.com with ESMTPSA id ko15-20020a17090307cf00b001e3cfb853a2sm4888413plb.183.2024.05.04.04.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 04:55:56 -0700 (PDT)
Message-ID: <6636224c.170a0220.80443.1664@mx.google.com>
Date: Sat, 04 May 2024 04:55:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0710480867987596244=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dan.carpenter@linaro.org
Subject: RE: Bluetooth: qca: Fix error code in qca_read_fw_build_info()
In-Reply-To: <515be96c-4c44-44d5-891f-fe57275e9f47@moroto.mountain>
References: <515be96c-4c44-44d5-891f-fe57275e9f47@moroto.mountain>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0710480867987596244==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=850445

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      29.88 seconds
CheckAllWarning               PASS      32.70 seconds
CheckSparse                   PASS      40.47 seconds
CheckSmatch                   FAIL      35.81 seconds
BuildKernel32                 PASS      28.64 seconds
TestRunnerSetup               PASS      519.33 seconds
TestRunner_l2cap-tester       PASS      20.38 seconds
TestRunner_iso-tester         PASS      32.67 seconds
TestRunner_bnep-tester        PASS      4.84 seconds
TestRunner_mgmt-tester        PASS      108.87 seconds
TestRunner_rfcomm-tester      PASS      7.37 seconds
TestRunner_sco-tester         PASS      15.02 seconds
TestRunner_ioctl-tester       PASS      7.79 seconds
TestRunner_mesh-tester        PASS      5.75 seconds
TestRunner_smp-tester         PASS      6.78 seconds
TestRunner_userchan-tester    PASS      4.91 seconds
IncrementalBuild              PASS      27.36 seconds

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


---
Regards,
Linux Bluetooth


--===============0710480867987596244==--
