Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19797EEED
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 May 2024 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716303412; cv=none; b=JHnAbhp/dRSfmm8qxLWDekxxwt/vOQhEm0xN9NUWuqyHwS19I1eBSBvXKBwi0G6pJitWHStdN64XuwVV7TbC/bi+sA1GyiuA+ULnbd+sChL7v747nr1WwBFQ8vWTUvetBtW/f/tsrIJL8jUU9kUsS3wB1q0t9Uq2IHyfP6vebYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716303412; c=relaxed/simple;
	bh=CHZfqqYYtaoLwS0+0Q8kJOR9Us4d3Ed8GtufOFN+D8Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=phf446hP3e22CG4bLAFa788zf/5GdSR2rxSlz0cL2nhhmD5qnGufzZZ7RGvAxSoZxcBPAY3ZboC0+5ExfaCwh8KDaZKQCM6t7sFs6Xo1G/8uS/bnQz5gxmL8v/waHEPY0GJezt056CAXozhLmfrewk3e+rglhASzhYuv8skc6Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvZULHaT; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvZULHaT"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-47f0a45375aso967432137.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 May 2024 07:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716303409; x=1716908209; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FxBQde8IHlE5tfkZ0xR1d7WnkyrzFuczTM0h1B/boSc=;
        b=FvZULHaTFnOULbVbdLW9ixH+9fifRIknmoj+WEz6twK7/FeqXTFWHemPo24aFOyCam
         i4Ckj1HKCr2EtVNjkfIzE3fq8EVLnexO0tmVne0VK67Wh++QYSQz/R1XvulGNeEwLwYu
         E+Y1sI3X8FsEaMdSWHaEYY5t6S+T8EPGoE+msZD0VODIwIaahARztrQxLajv+gtTcszE
         gMRc0HJEdH5vq56NC03m4LMA5xGlsTHYffIe5KGmarITVTWhdwgFNlh5g31U50M8UsCG
         S6AhUKNp88m2zhK6zWHxsTo5RWX/hKAwzmlfkzBeM30WR8ZCrwVi3CKt4J9+6hMCkHYM
         2Qlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716303409; x=1716908209;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FxBQde8IHlE5tfkZ0xR1d7WnkyrzFuczTM0h1B/boSc=;
        b=n7an9Jle31VNdNUgpBKYmxE1f8Z7lZEz5bUIK0bk5B2XKOB5InMb3oE18TB65qpndZ
         Ulq4HYZ1T4b1ka/oRyyo0ibSZRLKjKwX9ekccyNIqLxVIyPGUbSNEzp5zHSFKyKkEpgL
         iR7QtncwmOo/4Fm/8BxPiSyETtAntUlb79N1wZw4haQpsKBLsb5v0k77Ll+nEvyffnYQ
         yk/VdOG5lrplhFu8r9vEGuwwUHFLt+lQ3S0h5l/QeCs2csrg4+l6YDhPi6Xbxz/JV4cL
         OdLKxGYSTeIu/9GBkbcfW0k7zvkVAFwh9i4AJ2ND0gQ+KCzHnhgEm+bcJNxp4oXphbJy
         b3uw==
X-Gm-Message-State: AOJu0YykuRUXBXzi5dy0yrDKb9BqMhTs9POl5knLTZrTktuHhT26ESm1
	Jh0vS2D+rurQlo3Jnc60k1J5MU4pXyAgD5scN3HS81FUsNItnmYeCcYDpg==
X-Google-Smtp-Source: AGHT+IHKnzKcu9lrm+mUtwOLfpUmYhzeKWcP8/u+LsZfQvHAuBSoMCq0rIEdU98sTOIOErxyP6hwMA==
X-Received: by 2002:a05:6102:3051:b0:47e:fe45:eb32 with SMTP id ada2fe7eead31-48077e79174mr32104388137.25.1716303409483;
        Tue, 21 May 2024 07:56:49 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.74.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f179534sm123940406d6.17.2024.05.21.07.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 07:56:49 -0700 (PDT)
Message-ID: <664cb631.0c0a0220.cb231.7f2f@mx.google.com>
Date: Tue, 21 May 2024 07:56:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5603176715769434603=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: L2CAP: Fix rejecting L2CAP_CONN_PARAM_UPDATE_REQ
In-Reply-To: <20240521142429.1562347-1-luiz.dentz@gmail.com>
References: <20240521142429.1562347-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5603176715769434603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=854745

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      29.94 seconds
CheckAllWarning               PASS      32.64 seconds
CheckSparse                   PASS      38.43 seconds
CheckSmatch                   FAIL      35.17 seconds
BuildKernel32                 PASS      28.97 seconds
TestRunnerSetup               PASS      525.67 seconds
TestRunner_l2cap-tester       PASS      18.50 seconds
TestRunner_iso-tester         PASS      30.75 seconds
TestRunner_bnep-tester        PASS      4.78 seconds
TestRunner_mgmt-tester        PASS      111.54 seconds
TestRunner_rfcomm-tester      PASS      9.29 seconds
TestRunner_sco-tester         PASS      14.87 seconds
TestRunner_ioctl-tester       PASS      7.67 seconds
TestRunner_mesh-tester        FAIL      6.12 seconds
TestRunner_smp-tester         PASS      6.81 seconds
TestRunner_userchan-tester    PASS      4.93 seconds
IncrementalBuild              PASS      27.81 seconds

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
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.099 seconds


---
Regards,
Linux Bluetooth


--===============5603176715769434603==--
