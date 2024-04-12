Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BE438DC8
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 16:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941012; cv=none; b=WdmjL04a8GVzEuvsT7Z/j+rgXKR7c08c4/tbw4VqR8TO4mMS/wUwIOe8ojaV8t4YiPh+PmYCQyt7rpqZw6xbOD/mL1nJ39qtp9GsMhYNlhOhpb4lh9p0bYT0XNeJD64UKRHA6Xdl3fE05QjUqpQm4KJ7yB8UXLfKjDRIaw2jntE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941012; c=relaxed/simple;
	bh=SqI4fmFqxK3UEKzIzXFl4RtloKdyKTFdWhqVYJplXEE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HsNFFIpO5oie18uUe9alcijvyPg+LC79puKiBDu9T+eeDpxaHHdjNO/B8Uds1IKv/kFBkhAcinoD04KvbdmOqFjIPmyowCQUGrIszVwBN9w8lUlGsW4wUovafQ084GKlj9ZyNlsB/qlhdwK5vWmYvQLRetods+psDAHMbV81vrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7KudxsD; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7KudxsD"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e2232e30f4so10331865ad.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 09:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712941010; x=1713545810; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IDMIUKhW/Lx/laloezdC5ylh8RFVeGXV/DJLgXiWAGY=;
        b=K7KudxsD3t1eorlYzIJVKRXvmwNCVPVd33Y/T8M1Si4vxD36HZ7mXcQwfGYMo1OzIh
         t2QCd/OfmHs6rW5OhsZ7SApMB0oYOq4oWkzPy9orRWp9nJ/2wAybaysXhvxQABnsFLUz
         HmH3J2ciNYxu2WemicdwsEMCnvgxwDSNpzbajp5FtzF5qq6zzG7h9POrCgFURDQzaX69
         SU83AMmbK4S7t084tJGsP9252V4YruLVUXdfoGFhtpDfpZn2iSJ2ISgjYZoWNYYiaajB
         19oy+EVCgllOR8okserbm+K6b4G0FdzLYxhpjAlWEILGBReaPUwzHlqpzwDeixnS/cGB
         dLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712941010; x=1713545810;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IDMIUKhW/Lx/laloezdC5ylh8RFVeGXV/DJLgXiWAGY=;
        b=JCavDFPpxezaPDqT4MKhHwfq2Kke0T12Dw7zyRrNPQ07b6YeZLPTziXquW/ulubM9H
         ELQHZQAoD6EBCXELIO2mNzD7un65gbZejPI1y2BcrQ4eT9ed23u/CEerfKgwIX5pMaJf
         pqh9uADamb2N9cOoYn/JR/vg/rRKWSf/UjyLMpPsy5fNlozA1O3cNkxH2ZrXkaIHO2pc
         G9rbPbeotHtMJbVLs1OOzFjZYXnU/5ogwc/pRZdPjNb7lQBIY/AYSJ5HezJELmyN1bRV
         pm93XkZCtVe3lrZZiyQ4s+T75dXnY6vmOArzQ9gLII3hlDalsCQyX99HE11Gh/GdxW0n
         Xd0A==
X-Gm-Message-State: AOJu0YwJLLIdsV5zUJvW0cnSV7qoofdPQttMV8Y3S3NiPUgd0Cgb0RGK
	NdmLE15H7dK4JuyAFF+O3pLMebT2ni13ZGnqgtBLdZCM3/qaJ85FnW7j6w==
X-Google-Smtp-Source: AGHT+IF4fXf/tWIEaeG8Qpm/F343+6nYN10LRTqcdCTYQ1Sc3+L0Z8GMQ4PvFZips5PHD+/WTdg23A==
X-Received: by 2002:a17:902:a510:b0:1e1:3300:702b with SMTP id s16-20020a170902a51000b001e13300702bmr2427648plq.15.1712941009789;
        Fri, 12 Apr 2024 09:56:49 -0700 (PDT)
Received: from [172.17.0.2] ([52.225.77.111])
        by smtp.gmail.com with ESMTPSA id u22-20020a1709026e1600b001e2ba8605dfsm1666896plk.150.2024.04.12.09.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 09:56:49 -0700 (PDT)
Message-ID: <661967d1.170a0220.ee0a.48f8@mx.google.com>
Date: Fri, 12 Apr 2024 09:56:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1361719723172477657=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: Fix 2 tool btattach issues for QCA controllers
In-Reply-To: <1712939188-25529-2-git-send-email-quic_zijuhu@quicinc.com>
References: <1712939188-25529-2-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1361719723172477657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=844120

---Test result---

Test Summary:
CheckPatch                    PASS      1.73 seconds
GitLint                       PASS      0.56 seconds
SubjectPrefix                 PASS      0.17 seconds
BuildKernel                   PASS      29.94 seconds
CheckAllWarning               PASS      32.59 seconds
CheckSparse                   PASS      37.83 seconds
CheckSmatch                   FAIL      34.84 seconds
BuildKernel32                 PASS      28.64 seconds
TestRunnerSetup               PASS      519.51 seconds
TestRunner_l2cap-tester       PASS      18.38 seconds
TestRunner_iso-tester         PASS      32.85 seconds
TestRunner_bnep-tester        PASS      4.64 seconds
TestRunner_mgmt-tester        PASS      108.95 seconds
TestRunner_rfcomm-tester      PASS      7.20 seconds
TestRunner_sco-tester         PASS      14.86 seconds
TestRunner_ioctl-tester       PASS      9.88 seconds
TestRunner_mesh-tester        FAIL      5.85 seconds
TestRunner_smp-tester         PASS      6.65 seconds
TestRunner_userchan-tester    PASS      4.80 seconds
IncrementalBuild              PASS      40.47 seconds

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
Mesh - Send cancel - 1                               Failed       0.100 seconds


---
Regards,
Linux Bluetooth


--===============1361719723172477657==--
