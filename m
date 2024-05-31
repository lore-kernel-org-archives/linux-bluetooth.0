Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B48168DA
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 May 2024 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717199788; cv=none; b=a0LRfjF0fe9KSvFYueqfcFFaxGGJOCZu0TkfvYmZ/CtxGnDIC6RIW9a24xQyzdDVrMeX3Rb2oxT2362DcWADt125q2OonWSAVg/mNgKqe+Z2RD+/qdQGmmSJGOvXyZMowogfwRr9H+Uxsna1GB9ATNqYeUo02BsfNAXedRfMK+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717199788; c=relaxed/simple;
	bh=iR6OaZNaB1BrSA+Qlwn6SNyYiBAcYGpGLqVl7Sf5Iqo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RaafV+4isbLiUuiQttlcsF18c5cpbNeHVwiR4L51ixPf+yq7ZvMCmd7QvV1Wk18nDwtOlIgC+W6KwVa0AQwIZbyvivWje7+UWbK8GOLG5gM2qr9UUTBT79mTsNujY9eYV7ocaKrw6w19/oSt4bqHqV9/NJZ0XTTBTmsNP8X34Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfejjTWR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfejjTWR"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f630e35a01so12792315ad.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 May 2024 16:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717199786; x=1717804586; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=udMmE6QqRyHNkUAxecxaSQd+UsgaHaD0nljR10MFcyc=;
        b=CfejjTWRhYPcKyWE6QCk1XIa701q+QKs26zBm6nbJC876u2ILfFG5FM+U7GrRSL5GL
         XOquEweE7smssU44Fo7yfZ20W0xuYPPTsmhMhHBr6bfN5YE/nY5+xBuJ0yWqyHiRUc6y
         86waBvleQ6oSGmZnVvjE8L3q7aLavrHveo0wGsbfKgfs9Zr5k4b78A+yopgMUa/b0fE5
         lVAACwUKoabg3iE3FfYs0/6+vaoh8uj1/xwZjhFzSmSbskvnTgvbdZHt1g5m3ob8kdX+
         ZAtAePe4xhCcWuyNAy+ucjkK1U+qsZx1Q7gWnI7AKvugoM0B4rpdtotBmXmYXfvUQhX9
         ZdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717199786; x=1717804586;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=udMmE6QqRyHNkUAxecxaSQd+UsgaHaD0nljR10MFcyc=;
        b=vix9CxyiH+qtkOTQ8AJnVLdKfVYrETQddOOe7Z1fnm+AD0YxXa89USYiuCpdvh+1rq
         yD/OMSs0rBixvmdyK2jdyH5d0kNkmJHZomP1MnjHKjPJi6jzvvHKbv88ywfjSTqL+/Oy
         b+YDVlOg0VSOjWKGB0Xg4hS3dre68aFkJdb0zrwnPZL9nxiJLFNN7IPuYa/IWqf+ptHq
         EmgYFAOwJMnDZlTAoDTh6jcWnjK5sAvdDwghrxXqeO11qI05Z2bt5obtFCpfejHIKytt
         BkgOUuEP9hWuTk3N8RSUsxw5sIt8v0RMm6dK50ic7Z/BpvX8eLXrLzoxT3e1emHQU9TA
         TP0A==
X-Gm-Message-State: AOJu0YyV45eMxrUlVqFmeih6hwPrahrUUgfyiIOB5HwEY4gKSzss/5qs
	0KGTLWqo+KZNB1LGni6FYRHyljmzlSVY+7+Zw+xYl4ZP3CNvOaivhB9nOQ==
X-Google-Smtp-Source: AGHT+IG7zAJMooCgjd5yGZXRQICvp/ZAp0yDIAtAySmnyuWRZLoSt32E1c8WAQ4HYuScFmoi2N1Ykg==
X-Received: by 2002:a17:903:22cd:b0:1f4:8b81:9889 with SMTP id d9443c01a7336-1f636fd237emr36535465ad.7.1717199786338;
        Fri, 31 May 2024 16:56:26 -0700 (PDT)
Received: from [172.17.0.2] ([52.225.77.223])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f64cff7166sm2739405ad.160.2024.05.31.16.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 16:56:26 -0700 (PDT)
Message-ID: <665a63aa.170a0220.29f6dd.1414@mx.google.com>
Date: Fri, 31 May 2024 16:56:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2671213467496017662=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, linux@treblig.org
Subject: RE: Bluetooth: iso: remove unused struct 'iso_list_data'
In-Reply-To: <20240531232614.302215-1-linux@treblig.org>
References: <20240531232614.302215-1-linux@treblig.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2671213467496017662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=857869

---Test result---

Test Summary:
CheckPatch                    PASS      0.47 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      29.53 seconds
CheckAllWarning               PASS      32.27 seconds
CheckSparse                   PASS      37.81 seconds
CheckSmatch                   FAIL      34.51 seconds
BuildKernel32                 PASS      29.74 seconds
TestRunnerSetup               PASS      515.75 seconds
TestRunner_l2cap-tester       PASS      20.27 seconds
TestRunner_iso-tester         FAIL      34.58 seconds
TestRunner_bnep-tester        PASS      4.72 seconds
TestRunner_mgmt-tester        PASS      110.94 seconds
TestRunner_rfcomm-tester      PASS      7.30 seconds
TestRunner_sco-tester         PASS      14.90 seconds
TestRunner_ioctl-tester       PASS      7.69 seconds
TestRunner_mesh-tester        PASS      5.83 seconds
TestRunner_smp-tester         PASS      7.20 seconds
TestRunner_userchan-tester    PASS      4.92 seconds
IncrementalBuild              PASS      28.08 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 116 (95.1%), Failed: 2, Not Run: 4

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.169 seconds
ISO Connect2 Suspend - Success                       Failed       6.225 seconds


---
Regards,
Linux Bluetooth


--===============2671213467496017662==--
