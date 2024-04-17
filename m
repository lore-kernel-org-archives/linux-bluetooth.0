Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B03BE572
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 04:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713328487; cv=none; b=L+9d361kTOgl0yTholFtGxXxk+tgny43bI08bWaj6sufkQswTiNqlg0PcA/GIIq3Bx2XNUfUqzlCN741v/bvDtWewG9nyepVcmWqfVGc6Y6J3pYqBQdean0iEIlrZ4FPPkw/HdrEAgDz46PP4fNjmT265YVlvdkk7h+ZNR9UMS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713328487; c=relaxed/simple;
	bh=4rWhxdSS9NEozsgi5aGPFcN3iRM5/A26Y9ycC+Lz4/8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=B5P6/C5ZXII3fU4U9m76zzLKEE8Db1pmIWVFTG5SYV9bwA2AqiQFWcA2CR6JH51PKYTcbg4/QTM0lmjlP8n2psHivpatYRP1n2/x3Ng+AKBAWjgwwrXwT97EdWw7JQjZGkAJi1d+wNqD49SrHAJvw+MIdY1QezFzCGl3q2SUewc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7Gm4p+H; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7Gm4p+H"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e2b137d666so41953315ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 21:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713328485; x=1713933285; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEZJxKUzO9iT30Fxc7p4CVozjpUolLzGmqQw5tNZn7A=;
        b=N7Gm4p+HjYgCVeWBLCKgqXPUO31vlUt33JPR6MoPAyRa/4pxVfl9l8d8YoENjyDDCv
         fvR8CAF75KX0I0fezwhkmqjvDlGsu5fnklW/i2ygQpNa7DPHMUs/GiTfQsQYNu+0qFO0
         lpzF7upnqBQrB9gv4AFy4uVn3jQiYaDW7KKhQDBdDYd9+Gzjdd84a0Eyq+gOju+nO0Ct
         X5MCBEbGEpd0fWQuRa+ADNNd0yFsYjPRJRjaP5tY7t4c4hyGd1IAagmMimk73O9gsoHP
         nu7Us86+SW0id4zoJo7k+Jci9JHiEkypyOTqoSMusbG7IOXiRHP/8nlNmBtSEJ1BrVZf
         Nn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713328485; x=1713933285;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZEZJxKUzO9iT30Fxc7p4CVozjpUolLzGmqQw5tNZn7A=;
        b=Heldj+ilGKXsEphhS7DFxZdOLxnzoJIgvRXI3LVNuyXTzgMz5DOwDdD21PLE4iytxO
         +PN4V4g4OwN716ZiSMsUM1wBCEKARV700Fk5AJwmKVazEvsZSvBpkz8l9oTHjc4h/JQi
         IjAhDfG0i7CxLbpyeKaBflW+0CwOFnN0mG/f0RFhQN00gwPnP6XA3q0zHiUNHNjgPAwB
         xao6rS9Xl9+vEDmnyh1P/lWvXDi2VwDkWwgprlHeMxy1aCFj7HxdKXEBxUdQvRNceKmU
         Eb8RXZjdoMdHYb9zLzVgfsU5c22VjpoYbRr4WByIROF7SEk1sVpwZbsK0YX0rqLwP5oK
         902g==
X-Gm-Message-State: AOJu0YwDyT6h3JaJ030lmZTRs0r68HjZVnEPO6CpknAddJrFDn3eTp6/
	3p93fZJYG2hhZuCs6gmCR6KoMr4h4KVONEVhfvVshsBQS1XfxJuLpwcKAw==
X-Google-Smtp-Source: AGHT+IGLXNfT8zpWc9LLaMl28agDghA/h0ELNtdPjHXOo37tFnjoLEnALm47A2REN9ROIYjr0N8RKg==
X-Received: by 2002:a17:90a:f605:b0:2a2:5860:dea8 with SMTP id bw5-20020a17090af60500b002a25860dea8mr13477844pjb.7.1713328485541;
        Tue, 16 Apr 2024 21:34:45 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.123.156])
        by smtp.gmail.com with ESMTPSA id x22-20020a17090a789600b0029c7743cb33sm431115pjk.40.2024.04.16.21.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 21:34:45 -0700 (PDT)
Message-ID: <661f5165.170a0220.7c2f8.1cfe@mx.google.com>
Date: Tue, 16 Apr 2024 21:34:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1944311188321289661=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: Bluetooth: qca: Fix nullptr dereference for non-serdev devices
In-Reply-To: <1713325792-17181-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1713325792-17181-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1944311188321289661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=845272

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      29.66 seconds
CheckAllWarning               PASS      32.54 seconds
CheckSparse                   PASS      37.94 seconds
CheckSmatch                   FAIL      36.06 seconds
BuildKernel32                 PASS      28.89 seconds
TestRunnerSetup               PASS      518.82 seconds
TestRunner_l2cap-tester       PASS      22.47 seconds
TestRunner_iso-tester         PASS      30.86 seconds
TestRunner_bnep-tester        PASS      4.60 seconds
TestRunner_mgmt-tester        PASS      110.61 seconds
TestRunner_rfcomm-tester      PASS      7.15 seconds
TestRunner_sco-tester         PASS      14.91 seconds
TestRunner_ioctl-tester       PASS      7.52 seconds
TestRunner_mesh-tester        FAIL      5.96 seconds
TestRunner_smp-tester         PASS      6.67 seconds
TestRunner_userchan-tester    PASS      5.16 seconds
IncrementalBuild              PASS      27.78 seconds

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
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.099 seconds


---
Regards,
Linux Bluetooth


--===============1944311188321289661==--
