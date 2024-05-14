Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E46012A166
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 09:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715679258; cv=none; b=VMmm19jITgxa8eb9RKpuYfNXZ50J2dV+PbPYzSYvQCM3tS5x/UvHDdE50vAj624u4JQivUD7U1/1C+xTuhvu7meWXHemYQ+mTGCVZiFwqpujaulmIeFgyBfZEvbURexOBun9OUjFSH6opfeaO5vTUhqZSlHwwzLrs5qq++GFaQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715679258; c=relaxed/simple;
	bh=4ZkaiMstXT6yMmfp7MAWW8mAaKPqMV61lPnjML9baow=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mV+xQT+yyZa+a52hq2CknRJKYgZTllOCKXfLLJUspR2GF32aErNCJlHyViaaqINekLLmjgqrYuhxUZR++qxfB6GlEcpbnP6sWG5rX8cSTnA4uPXUXFurOTcQA/PlSj1fUpnkjBI/BPEAUu7vHKzgIDm3OZIBMxS6AccdVMbVkhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1bMj6eV; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1bMj6eV"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-69b514d3cf4so61153576d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 02:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715679256; x=1716284056; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hNPLEPl7DDHhbzcS++JPe1oz37hbFaCvlai9iYdPIA8=;
        b=m1bMj6eVIB6zLWsEbSVtmkQjggjnsBCeVspb3qzsRmZhN++c+0k9G64xHogXgiLJbo
         Jwrlo0vUS/3YKoamr+7o0hxTTHsZacGzYPODkJLlW7r6G4B6UBiQPNW1L3km125sgPjs
         cvQQjQlxCvxJ7YOXNBsetK0C62B9z9ibe7x1RkB276KZLLV+p8tW8BsmBNhn7WYZ8Z+g
         9pECwPZsl4mGiaUt1YJkzKbA6JXPiSH7kPAZ/lYHPaPXpuyLg/CBT0IJoQyrdh11gOQM
         dPaPQqPpQjXCVXDq2uiGZRkjKzfWN+qT85UKauz3N+o0pwQpofnNjQJLcBR+v9YGPzhy
         tupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715679256; x=1716284056;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hNPLEPl7DDHhbzcS++JPe1oz37hbFaCvlai9iYdPIA8=;
        b=VD1LAu/Xnf/732LalZokFI4euDyheQCQ7S947Swxhpdk3u/Lgjb50sCl4V+or3U1o8
         j0fzxiFWxAQrXCNK50w6yF1ffZk6Y9s8gRd0zSQPTi6ZH6EettNYpFGMcOIzxVu6N86l
         PZKatPFxj2gPfBZR0ylv6zvMLq1CWDydx4Um0cEtYxT2RxgmSD3KT2jpHhYINCarA+Ms
         KsbGSP64bZz00baxFxrQOFZe/VBsCsAy2c2n1eRu1t4NujL3yTYA7udL6QZTAAXJx/Xt
         trOu8s0fzXB7IvHLfaVZRuLjrsclTDddFh+jEvWpK7Kq3rVtwcpjtkH5iBq13aiQ5MMt
         SH+w==
X-Gm-Message-State: AOJu0Ywqz3J9MUr8VpF+wOaEtbjBnE7GlXos03bIZKInsBHzce0Bg/d0
	cv2mVUBUL4NyAqetLdQV3D3Vp45U2R1qOKf/r0Y5Uk8zg0m78eIieN/WCA==
X-Google-Smtp-Source: AGHT+IHanxa9vd3VvxYiCKv9Xfh6b11Unf5Tqve6yvXjPrEjc/FKUd+UrjiuUOTIL2OXWD6mx4QK8Q==
X-Received: by 2002:a05:6214:4497:b0:6a0:b3eb:5626 with SMTP id 6a1803df08f44-6a1681a167cmr158004456d6.39.1715679255835;
        Tue, 14 May 2024 02:34:15 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.111.255])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f194945sm51136306d6.61.2024.05.14.02.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 02:34:15 -0700 (PDT)
Message-ID: <66433017.0c0a0220.27bb8.054f@mx.google.com>
Date: Tue, 14 May 2024 02:34:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1825990449872527972=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1,1/1] Bluetooth: btnxpuart: Add handling for boot-signature timeout errors
In-Reply-To: <20240514090913.1507990-1-neeraj.sanjaykale@nxp.com>
References: <20240514090913.1507990-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1825990449872527972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=853010

---Test result---

Test Summary:
CheckPatch                    PASS      1.04 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      30.32 seconds
CheckAllWarning               PASS      33.07 seconds
CheckSparse                   PASS      38.71 seconds
CheckSmatch                   FAIL      36.07 seconds
BuildKernel32                 PASS      28.88 seconds
TestRunnerSetup               PASS      522.58 seconds
TestRunner_l2cap-tester       PASS      20.37 seconds
TestRunner_iso-tester         FAIL      39.42 seconds
TestRunner_bnep-tester        PASS      4.73 seconds
TestRunner_mgmt-tester        FAIL      118.58 seconds
TestRunner_rfcomm-tester      PASS      7.32 seconds
TestRunner_sco-tester         PASS      14.98 seconds
TestRunner_ioctl-tester       PASS      7.74 seconds
TestRunner_mesh-tester        PASS      6.21 seconds
TestRunner_smp-tester         PASS      6.78 seconds
TestRunner_userchan-tester    PASS      4.94 seconds
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
ISO Connect2 Suspend - Success                       Failed      10.194 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.134 seconds


---
Regards,
Linux Bluetooth


--===============1825990449872527972==--
