Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C595464D
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Sep 2025 12:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756990069; cv=none; b=LliC5VeWj/d3S76QVAXoOuWhZYhokGJHXxwRbSxbah3G5GVEVyEBDPKodSd3B9KiKRFSsQgC80T4D879K3eymBwrofEq+2zKDB8aNSdOLGhviOzzQXyEXhEu+sUuWksb0vmMmqjF0xP41ESkl2/TDOEtin6coK/cgHM8W/IKOIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756990069; c=relaxed/simple;
	bh=tHi9fWV371mEyW2Dxhwq+hRA+wLGEQO2gOO0odHyhiU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gUMrfGg5j1QSE+m5cIJsVLzIpD30ELXitl6+PnE1Xc9SdbKHX2GTiXrBcN8TZVKEFsvln2krs8GteFkuZRIL1UN8V9qIpMgmZZtdn7wcx1KjX5NY8m4yKL3lEz4SJ1g/VThT4C6LN6OeyXcrLidIWJ3IxBr8Pept5PMgZAWtUAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJvTpmV9; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJvTpmV9"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7726c7ff7e5so933626b3a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Sep 2025 05:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756990067; x=1757594867; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yLyFNCqKPQqpX32nYljaqlIX5/pUREGKS47bky2QOKI=;
        b=TJvTpmV9qfWjyUhV+AQjpxMDp6p+cuS3hpiYZ37+bVLSFKG2jYk9dsMGsdaXpFnHQF
         upfWHRfKYJv9v+Q9uTjP5G+xyePhwI7glM9EY/FKkSWeapqPJO6TGK9QAf+I3gjE5ICQ
         5a+Op6FS8jg4WyPYDix2TVMmfnKGCyqSDLgL9lPVRmOywHGBuDm6Gggu7VhNkjBaLyNx
         zKCYZ94mI59Ly8ci4/e8MS44/VJLEELr56CUS6q2BfpuyRpyi7fHTxI5pAH0uWWpuJd2
         5FPhbPdYYne+5SVIeC3V/icKWq3lGl3Vm7kb7fp4VA0fBK7FhPc1MjiZn5Q9YvW+fG2F
         ktNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756990067; x=1757594867;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yLyFNCqKPQqpX32nYljaqlIX5/pUREGKS47bky2QOKI=;
        b=VDSdyTXj3kWzdNyT+90FGPHH8NMz5hDn1WR1WGAqDeBTU6cdNXArqRaAYd/nth3LVw
         6JCfRTIezYYV0F0Ee2N1aGJvUYYn/UciiFddFRGAS+4lpRDMFOhSNgajNsZUOJ06BcrS
         JJ5Wpkzh/g5mQyFrb0jrr2FfNO3Ox7N5X5cokkJ7tkPHZ+Na6zAdcQckATKHQ485D6l0
         UdG4Qcr5M+0BUt87CoYVxgXgduEMR9ZeyxxT2uVz7sbELLOxTUyK/e82un2mwZFumqA4
         sS2yGgqKg9nP4uN+mAR/bxBWEYnCwZSY65f5Yyw8kb/FJltRQ7l1G/pCeIIpMcZgNK8Z
         GOPw==
X-Gm-Message-State: AOJu0YybPIZhHBGJgBjDr1I3aqvwaMm8seh+6ubiD9z8pWCTnrW0ouwU
	o0rENJKMMn2bi7rTigIPIaEWj+NqzC0yCiPSZbxfn37In1ztT306pqTy9hRAgg==
X-Gm-Gg: ASbGncv2h7/iXdTqbIVWSo8YLKzCFYGnvdb2no+km8yJUy40/qClVRSVW2r+05Kd9NJ
	eLwU1mEij+o8NFrNedG+M92XKoVuTt9Hj3OWP/Od96cHNAK0cfYyXZDF4wvH4gll1SWbYVIhGDi
	hJaMfiza/haL/RN5N6MQnVuiUtF7zY5JQUfrJEFPnaf9ygFVoDEwPIEA8iR4P9nlyxHU0UcvdsP
	AA0DTR6UN1u5fho5NcOzj8ZSDzth7TmCnPcdahbFea/+yXf2peM3K5fsXgcs6jHTNoFYpe1UbzD
	eYT8T8ItJxg1gMXZg+dMrqGT3dYKfw15Q0TR9PMkRg9DAdlkmlJk2z2fmK0ZDej3b47YshP25yj
	kXPMYqtt9hTpk278GczZHPYX6b/M7GPv+eihURpM33P6evaYq6q2O
X-Google-Smtp-Source: AGHT+IEeW0CD7NU1X8rT36/JO36GINDVcRTm55Z44QFeOLf2aG3js8NkCCSJK3VKWF7A83Umv5EWyQ==
X-Received: by 2002:a05:6a00:846:b0:772:86aa:ed0a with SMTP id d2e1a72fcca58-77286aaf14emr6157345b3a.25.1756990066609;
        Thu, 04 Sep 2025 05:47:46 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.211.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26bc9csm19578801b3a.18.2025.09.04.05.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 05:47:46 -0700 (PDT)
Message-ID: <68b98a72.050a0220.10b8d.eaa9@mx.google.com>
Date: Thu, 04 Sep 2025 05:47:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8708706135773684988=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [v1] Bluetooth: btusb: Add new VID/PID 13d3/3633 for MT7922
In-Reply-To: <20250904114611.762004-1-chris.lu@mediatek.com>
References: <20250904114611.762004-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8708706135773684988==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=998835

---Test result---

Test Summary:
CheckPatch                    PENDING   0.47 seconds
GitLint                       PENDING   0.35 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      24.41 seconds
CheckAllWarning               PASS      27.18 seconds
CheckSparse                   PASS      30.44 seconds
BuildKernel32                 PASS      24.31 seconds
TestRunnerSetup               PASS      475.14 seconds
TestRunner_l2cap-tester       PASS      24.74 seconds
TestRunner_iso-tester         PASS      38.55 seconds
TestRunner_bnep-tester        PASS      5.80 seconds
TestRunner_mgmt-tester        FAIL      125.70 seconds
TestRunner_rfcomm-tester      PASS      9.30 seconds
TestRunner_sco-tester         PASS      14.63 seconds
TestRunner_ioctl-tester       PASS      10.08 seconds
TestRunner_mesh-tester        FAIL      11.62 seconds
TestRunner_smp-tester         PASS      8.51 seconds
TestRunner_userchan-tester    PASS      6.20 seconds
IncrementalBuild              PENDING   1.12 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.100 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.079 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8708706135773684988==--
