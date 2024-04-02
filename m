Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD4315B964
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 19:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086165; cv=none; b=QeG5zrOrTxa6Y5QaSJ7M3TT6oZz+1ABBU+qFIP66oU17nhwAYqMPd/C6UITrqBq6+WQPbhKq9Fq7UR9xX6HOTZuF+uciD4Fjyh2YHBStiSJxXeljHSHO6ab+LLz15pnBnhK0VP8VbDAwF6Huc5S6yQpm8yQ3IoB1tsyxEYdy2gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086165; c=relaxed/simple;
	bh=7TSnOmuXQJM/7leNxhcnE+XzTR80eFOLsRP6zw/FBd4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HbiLEC60lRHtieK8j738pNIlLSdqr8OMZ+4+y7QsXTUXmcKpjv8Sd75A2OpFoFIV1jShufwStG5CqkJQX5cUtKPNN057uBwR9kFIaJrV9ADvQWYqUh8ctq2PNpJF79Mcf0UmzlV77TSiBdpJa+Gk65tpIjGNOqyyPcW27e9P0Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikFCpdlL; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikFCpdlL"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78be76a293aso77683385a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Apr 2024 12:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712086163; x=1712690963; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ji1yafsQgDCNv16wl9tze0d1agxE3QO7sHjAcgxzUiA=;
        b=ikFCpdlLXFpzd/umy2KGgUaFg0aJYOZ8pu5DNPkhKtAg3+U+79bj69oEjDIkNN+Vq8
         pB1JBR6NBUtUv4e6Q5AwePRoxa/10oL4mRd4lOXPRaWNtoNwVveW33XInSiHFjh1poq1
         KJhgNj/6Tu//XA9/Fc83oA4EZzzd+bBpYI82SY+FakM6MxoqHcdu1+uMzqqFlDXcJdcP
         T0byYu6OfOw3OVwGQhgZs7f2ngBtbtdV3YNvnsbeNf8ZHb+lh1KzAYVyUkZCx/XhiMtW
         3rvMuxBhvvF+AyxXDl9FmAS662szmZT59qLFoIunPdAGmGBXuXjFMV8BcApMQrN4h90e
         rXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712086163; x=1712690963;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ji1yafsQgDCNv16wl9tze0d1agxE3QO7sHjAcgxzUiA=;
        b=CBsp8+rzKhF6eL2AZmVyPaowRefIld04gMPNSCS26g62PHvKsYQtmoBxZztldpxK3b
         Ll2ybL1gVqkJJLCeb23f8TAW32bA7cLdRXoVPOryGhqVoCcgHoJYnTf1fvbhIydlntHr
         EglJe29nPWBFXGYYCz8LBICwHl3XNVLGsk6ZjCSJDiIQtYfzHdT/tLFgA/HpcFtq2Al9
         A/8Pf6/gG+QtBD4RFI2ookDmO8buDj0L46zemZ8LnQ2l5/lcnHgQpLFrZVm/fZUnsc7E
         2z+73yccnzRnKzFjU8Q456aQQqgWUA3wSko4L6ioyQlMeobwupRD516383BCmFooPk4I
         3xFA==
X-Gm-Message-State: AOJu0Yx0MKNN3hKOQLshx4EN5X+hTUAOnUB1tHAVtrhq6i8kD5VSc7+t
	nM54/z5t1xM3fqIuUnWR7vi/FHKCekBmydN1ZJV7Zo1dX47aRjcOjjUKmKKA
X-Google-Smtp-Source: AGHT+IGTZrcjL32SIY4zvIJTU2lrMazHRuC16b8ch+BoRyML40ewB/0BWAgGhPgEeA9hreUk+hw3Gw==
X-Received: by 2002:a05:620a:5814:b0:78b:e5d5:bada with SMTP id wm20-20020a05620a581400b0078be5d5badamr6502557qkn.74.1712086162679;
        Tue, 02 Apr 2024 12:29:22 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.198.157])
        by smtp.gmail.com with ESMTPSA id ea16-20020a05620a489000b0078bc503bc4bsm3999503qkb.115.2024.04.02.12.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 12:29:22 -0700 (PDT)
Message-ID: <660c5c92.050a0220.c3439.7235@mx.google.com>
Date: Tue, 02 Apr 2024 12:29:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1799360683826813894=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, me@wantyapps.xyz
Subject: RE: [v2] Bluetooth: hci_intel: Fix multiple issues reported by checkpatch.pl
In-Reply-To: <20240402183751.107948-1-me@wantyapps.xyz>
References: <20240402183751.107948-1-me@wantyapps.xyz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1799360683826813894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=840738

---Test result---

Test Summary:
CheckPatch                    PASS      1.10 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      29.80 seconds
CheckAllWarning               PASS      33.05 seconds
CheckSparse                   PASS      38.27 seconds
CheckSmatch                   FAIL      35.12 seconds
BuildKernel32                 PASS      29.06 seconds
TestRunnerSetup               PASS      520.61 seconds
TestRunner_l2cap-tester       PASS      17.89 seconds
TestRunner_iso-tester         PASS      31.78 seconds
TestRunner_bnep-tester        PASS      4.64 seconds
TestRunner_mgmt-tester        PASS      112.50 seconds
TestRunner_rfcomm-tester      PASS      8.79 seconds
TestRunner_sco-tester         PASS      14.80 seconds
TestRunner_ioctl-tester       PASS      7.52 seconds
TestRunner_mesh-tester        PASS      5.71 seconds
TestRunner_smp-tester         PASS      6.71 seconds
TestRunner_userchan-tester    PASS      4.87 seconds
IncrementalBuild              PASS      28.29 seconds

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


--===============1799360683826813894==--
