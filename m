Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295E81DA24
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 May 2024 20:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715633842; cv=none; b=rWRzPExgSeNVpFqgBh1Msm3EYlFtLTXHYwuLn2kb10eTC4qWC5T4h4jvyJ+Kp3Wd9lQOnef2iUptuKbeTN2nuPE/nNNA7qHt2bpk2D1h/nwNFym5jNcAwzbDuNpzpUvVoU4Pcce3aAoMPSQfHPXjrzF0v6GqrD3pwtzeDqtlay4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715633842; c=relaxed/simple;
	bh=ywrKSYDZ3TZfZNoHa8J83EoYqiO+N5GMU7NPVoWhNnA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KaJkPIFlh+zCQBmZIxGDhDFAT9PNlGCVKOd+zFp0FqdkhA+QJ2Ghgz9p4PuDBBUI/GSR9993bBOVWF4r9XyuzvK7GJIqFIbSDZDkbXct9I5hwZfA3hcZejwJ6jhew5VWvHJH4QH8VxoqhAJ1Ul+Rpij403h7nukj2H1+N701ELI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgMzMWgk; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgMzMWgk"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ec41d82b8bso46119985ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 May 2024 13:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715633840; x=1716238640; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AmYDlJgR/YcTmOLH+fIUI7VtCRKAG/OUGDN0G22L1NA=;
        b=IgMzMWgkWemaBoR8Dk0r26A4HXEBYUbYjaMKUaISO8oOXKeZLaZJcPdQx9D5ybESP+
         xYqgGq2V+4AmxOONZn8jDde2EzGf3TZ+5pLqz97lV/x/6lMEiaOACxT/h7AXS7KmX3He
         yoad3zqp6/sv4P4DFFOZnRISm/wz66vaH0XLoxCZyIp6QK/7XCowImFyiLbh+iw2eCEx
         o4pRT5WId0QHtQ+KU3z64TL+mf4OyJfL5t4lk6tx5QK199SfFRdgo9NYX+3A7lLmAzGn
         WHVc4EXjxl4sFI2Y3JugpYjC+V3v5b01uTpFOWNrvUCp73hVVSorndEu7OekBuqr8QyH
         gYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715633840; x=1716238640;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AmYDlJgR/YcTmOLH+fIUI7VtCRKAG/OUGDN0G22L1NA=;
        b=iPuei4Irk6Rwq+XF6HFbR/uujAbSEcVL+CArJ6G/hxm3dek2oMgR5/udCDcvh/KmoD
         6G2MvbpLOb8ZZnGAlEqxbvLHC/9TGYhve/zaE3psdpd/rxKNI5PkDUNAZOovRfHnrjLt
         UUYUFHl3jXGZ5zS7d3RSZ81aXrMUYTnhs9l4YqmSWLUKtiLQR7Oesm5VBGGAPza6Ly4+
         piKCdpsS83OiG8SYKEdG337omm6l3QXXc/VxdGmYKVagZkeHFxeFOd7zN12bVh302cW4
         ALrpMbVk21u9fsPfSKrBq1CzWxXpwxU0qDSnHGf4A5pjBYM8q3XMFpnC43cG+IskJ3le
         3ERg==
X-Gm-Message-State: AOJu0YzU9tHXEENW6Sz/VyKel2o0yPV55YW1IhXMkKBcchV/4Yhkc97J
	VypvvVZVKlv1wX/1tpi86/1fi5rU4RHMTxMBtlDwgAaU8qIiXpFCFLagmQ==
X-Google-Smtp-Source: AGHT+IG2SlCa9zAHB5TtDDWkene9ZFzMX5Hi4vg4PfPX/wQpeN+aARzP6/o+8uOgole/xhYaKjT6NQ==
X-Received: by 2002:a17:902:7c05:b0:1ee:8fb7:dce1 with SMTP id d9443c01a7336-1ef43e25d19mr104473575ad.31.1715633840280;
        Mon, 13 May 2024 13:57:20 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.122.39])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf319e2sm85584695ad.174.2024.05.13.13.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 13:57:20 -0700 (PDT)
Message-ID: <66427eb0.170a0220.b212d.64ae@mx.google.com>
Date: Mon, 13 May 2024 13:57:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4194837250194076555=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_core: Fix not handling hdev->le_num_of_adv_sets=1
In-Reply-To: <20240513202607.369337-1-luiz.dentz@gmail.com>
References: <20240513202607.369337-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4194837250194076555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=852912

---Test result---

Test Summary:
CheckPatch                    PASS      0.90 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      29.73 seconds
CheckAllWarning               PASS      32.84 seconds
CheckSparse                   PASS      38.14 seconds
CheckSmatch                   FAIL      34.84 seconds
BuildKernel32                 PASS      28.80 seconds
TestRunnerSetup               PASS      520.07 seconds
TestRunner_l2cap-tester       PASS      18.56 seconds
TestRunner_iso-tester         PASS      31.76 seconds
TestRunner_bnep-tester        PASS      4.89 seconds
TestRunner_mgmt-tester        PASS      111.65 seconds
TestRunner_rfcomm-tester      PASS      7.43 seconds
TestRunner_sco-tester         PASS      15.19 seconds
TestRunner_ioctl-tester       PASS      7.85 seconds
TestRunner_mesh-tester        PASS      6.04 seconds
TestRunner_smp-tester         PASS      7.04 seconds
TestRunner_userchan-tester    PASS      5.07 seconds
IncrementalBuild              PASS      27.96 seconds

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


---
Regards,
Linux Bluetooth


--===============4194837250194076555==--
