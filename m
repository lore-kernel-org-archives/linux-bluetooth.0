Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209CA13958B
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 20:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716237806; cv=none; b=ZlAgIE7/8ZSoif9+WfaHPtZFWsdkDw8BtIiHKpExjEKbZkFFtNydlR12JxIXQXGWrONdBu6PBsGIyji+lpZ9hsknAtU8DerWdTo5aFkvZFErtXrTrQFXIJmcfIr6E5iRSMHQkExbL/Spt2/EN6B2XelmZVmrNuI0xJafnYvULLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716237806; c=relaxed/simple;
	bh=SlOZEE/4QgKmNk6dK/rH9tjfO5RM6eYbGnzUGG0xKcY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PscjhjDceeDKOzg8rvZLWHx2jGYoREe4OLGQRebwQ9Q+aiQqvnxsI6jEvjp5ShJBQA18EwoBxJ1EQdXOUVROShS1hiu9lOTPVFktb0KOKzS7pyZ6zszZFJE5bnCiZIAxwLasozd1m87om2LU38rvg+kvi+ZScNv4Ek0m6Wuxg5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmRtWGRl; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmRtWGRl"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-61b4cbb8834so26061027b3.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 13:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716237804; x=1716842604; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JdtSf9AXb9EHE+/aZGmcAGkqU4Guk8L9glzbcmuBq/w=;
        b=kmRtWGRlv/abGpw59BgmuQsYXUHVsUwxYSpkcwyVVH/J0fIRrSFPNrfKPdB1glnHeV
         lO96P44mHEP8N8HfvVOtlZPZ1yy/ezMUSmOo3Rps512DCvjJvVz5IDHSK9lSRiiLtDnr
         QRSXKzbwlqrNf9f491fYzE2hkTtd9pj0Kh1tJjT3Bwmdy0K/s9b9jxWBkAb2uhvuL4uP
         sdQL6+I+8ymtQ/OfRM0CoS3iHvH6KZftqfFVwX2zeF4SHbLACGreRnACxhySXEzv0SKx
         iJVFeRA7QedEVLekd1sGvEkl+u33CG0+bsYypmwlPe9Yc/UdbATbjKA9yYTxptoYbqA3
         WWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716237804; x=1716842604;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JdtSf9AXb9EHE+/aZGmcAGkqU4Guk8L9glzbcmuBq/w=;
        b=bPQOELqDvLBgG9qkKvfYUIdpE9Sw1pykiaqY9c2sc6F7U1U/jj7Deu/ycHzQS06ohI
         w0FQOAo3huWru2zrDw5zh1/fT9v2vEQW+sS73LW/CPiVaVRPJB5n94UCdgWe0Io4Sz/3
         tGc4SysK3VOtZjdwwkfi/M5B9pECZJoUYDOnTA7VZP0+2+AhVy1Pwi76o0+HDrjsFYan
         aFYJlJtpOl1LwRUhaDPIIvK4Jgg+oUXq8qzIqk+gsMpTGYZDy8xUgvyFXPrioPjgtSvG
         funScKHxNJMcrcLxhn88utDmY+rs33JUvn9ERF9wEqbyXxkArSsPp746mBoC/kSTn+9N
         TEJw==
X-Gm-Message-State: AOJu0Yz1QHsM1upp0WDMHJqat29+W3MR/PFnSDusQ5bCTqmsGYlZu5sS
	J2svVrB9INlelHvPzrVXXSU2Uh7JapqBiR6I0iYAJnoyKXpZebzXNElcXg==
X-Google-Smtp-Source: AGHT+IGrea8EhWFJD4hsfIePZIM3+w3UnZc71v4TwVgRZ9F3t//fD39zax9nWPAXFbF6NqzhG+glMw==
X-Received: by 2002:a81:6d0d:0:b0:61a:d39a:1aa6 with SMTP id 00721157ae682-622b013c509mr280187317b3.51.1716237803859;
        Mon, 20 May 2024 13:43:23 -0700 (PDT)
Received: from [172.17.0.2] ([20.49.55.100])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df56d0396sm150612681cf.86.2024.05.20.13.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 13:43:23 -0700 (PDT)
Message-ID: <664bb5eb.c80a0220.b064a.f8fc@mx.google.com>
Date: Mon, 20 May 2024 13:43:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8276029153466823871=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: L2CAP: Fix rejecting L2CAP_CONN_PARAM_UPDATE_REQ
In-Reply-To: <20240520201023.1437548-1-luiz.dentz@gmail.com>
References: <20240520201023.1437548-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8276029153466823871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=854501

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      29.82 seconds
CheckAllWarning               PASS      32.69 seconds
CheckSparse                   PASS      38.48 seconds
CheckSmatch                   FAIL      35.08 seconds
BuildKernel32                 PASS      28.84 seconds
TestRunnerSetup               PASS      527.11 seconds
TestRunner_l2cap-tester       PASS      24.49 seconds
TestRunner_iso-tester         FAIL      32.53 seconds
TestRunner_bnep-tester        PASS      4.68 seconds
TestRunner_mgmt-tester        PASS      110.10 seconds
TestRunner_rfcomm-tester      PASS      7.30 seconds
TestRunner_sco-tester         PASS      14.93 seconds
TestRunner_ioctl-tester       PASS      7.78 seconds
TestRunner_mesh-tester        PASS      6.02 seconds
TestRunner_smp-tester         PASS      6.81 seconds
TestRunner_userchan-tester    PASS      4.95 seconds
IncrementalBuild              PASS      27.92 seconds

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
Total: 122, Passed: 117 (95.9%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.176 seconds


---
Regards,
Linux Bluetooth


--===============8276029153466823871==--
