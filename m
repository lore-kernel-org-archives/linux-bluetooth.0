Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F64F2375F
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Apr 2024 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674645; cv=none; b=FHEbhbFF/H3v0gkdi0j8UWeFyfCF5cpxOX81bgHX2ETc+F05AyqMDOCJIBWt1DNfIQPjV5Z+gN5xhFnr4Sod0gjxkQWbqzgB92udMCj0ulAdwx74GMACqMFCRVO6C+0zgZPY7cf315N38W/ZvYfs1oh/mIR6kaMTo5MwUfpYj78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674645; c=relaxed/simple;
	bh=P0By1M3hCvx7hziF58kabP8CILlHbHhwmOWCXFHOSb0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nLxf58WcuxpSTgtVIJUOr9FaEXD2mkZToy5/jWhMCtHi9u7rQVhikbcePabSi96igF5El+X7HGMsB5aJgeVEYUSoNcFApUaq9H6PQoEjy072dU405QA1dy75wnpoWlJK0qw/o05MT0wtq3f2VGVkmrJwaSpGGWDGc5RpetfYWuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Own0NqfN; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Own0NqfN"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-615826815c2so66095307b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Apr 2024 07:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712674643; x=1713279443; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WnWAX4fFJydxXgnf4qozQ3iue7f5CbfCdlvADeXcbXw=;
        b=Own0NqfNTSLbGR2GgolZeEQ7/kJG3fRDPl/qOEsvLmFb7YPDSO7iuiHaKlgMgJng77
         8GTZtYuRK4uFrTgNkZFUVz/ytZc0SkmTzpPksZn7wD4R/uYc63H4u7B6tw6zdmJdfm6+
         J++hLDNwVhjuASrp4sSd4E8UtcgHa29xSa9xoD488hWKDc4tsx7ZWcm9ofq705oZkjjk
         8HK3evRL7x4bgq5FCBLBt5Dc6YuaCENXOMqjSBB/PkGvnI5k2pXv1XnQu24/0cHwFWWW
         ERlPhqUr0iSMV5v8sQ9aJ1WwaddtTZtf/yPXVkZUp++wapDyJWNTOH0AFQaiSB0NILIP
         +1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712674643; x=1713279443;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WnWAX4fFJydxXgnf4qozQ3iue7f5CbfCdlvADeXcbXw=;
        b=PNnxncMIJra70dwV3K1Qsw4tLV//611ooogbzVTqTOfua6qJV5Ib5ZVClCYQLMO+dT
         l0P67AhTmrjljuP/dtV+Ml+BEpdmDQ9y3qqLzkdTkVJEeX5sGVVTKEYVrrC7zK1BDSQz
         xghMI4z0bPEsgdQSH/iDl1jjBNIYO+9TOuJs9YkA67XvFd/YFUJl99r3YsUL77tqcZv9
         AVdYQ5Ph87L379I1kb3L+j4N/ddfwqsqecbmsTKfFSoFPHkq72E7jwq2CqkD5b6B/FY3
         Kh7a8yrxfyeuxOx1PrQVKLbniqqoRfg6/druMqIfT4gtkObZwVat/xhMwXDSNbsHXWo0
         2cNw==
X-Gm-Message-State: AOJu0Yx8tJZtS5Ugtn2iVsICTYtfAi0fxP0JR0HK4RpXarFPpT3d70hJ
	e8yQmhOa+YZPIaCyk3CMpuZVlKDdWLAnHFQR5iDIC1ygAX7PBB1KZx3BSAKz
X-Google-Smtp-Source: AGHT+IFtJzvvhjYXtR0EiH3pbmRE3+dXftP9Tp2oiAq46uEycRaUTyAYQaKbxfz1mGxyjzY4x1ekaQ==
X-Received: by 2002:a81:4f48:0:b0:618:3392:6d3f with SMTP id d69-20020a814f48000000b0061833926d3fmr1376662ywb.7.1712674642960;
        Tue, 09 Apr 2024 07:57:22 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.88.178])
        by smtp.gmail.com with ESMTPSA id je15-20020a05690c6f8f00b006152cd281fasm2183212ywb.23.2024.04.09.07.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 07:57:22 -0700 (PDT)
Message-ID: <66155752.050a0220.4838.b36d@mx.google.com>
Date: Tue, 09 Apr 2024 07:57:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1798799487731086524=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: btintel: Attempt to reset if Read Version fail during setup
In-Reply-To: <20240409140939.3855573-1-luiz.dentz@gmail.com>
References: <20240409140939.3855573-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1798799487731086524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=842853

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      30.38 seconds
CheckAllWarning               PASS      33.52 seconds
CheckSparse                   PASS      38.23 seconds
CheckSmatch                   FAIL      35.58 seconds
BuildKernel32                 PASS      30.23 seconds
TestRunnerSetup               PASS      527.92 seconds
TestRunner_l2cap-tester       PASS      18.27 seconds
TestRunner_iso-tester         PASS      28.21 seconds
TestRunner_bnep-tester        PASS      4.67 seconds
TestRunner_mgmt-tester        PASS      109.49 seconds
TestRunner_rfcomm-tester      PASS      7.28 seconds
TestRunner_sco-tester         PASS      14.98 seconds
TestRunner_ioctl-tester       PASS      7.61 seconds
TestRunner_mesh-tester        PASS      5.74 seconds
TestRunner_smp-tester         PASS      6.77 seconds
TestRunner_userchan-tester    PASS      4.89 seconds
IncrementalBuild              PASS      27.69 seconds

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


--===============1798799487731086524==--
