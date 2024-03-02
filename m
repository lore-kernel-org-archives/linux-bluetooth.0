Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D49515EA2
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Mar 2024 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709411610; cv=none; b=jUJ8z3OiFRupjc5pw+cF5/r+DQzDjHAeZBvkJ4g2GIEUkRUSml9gVZl9DwQX4XBxlB3fc2ndCx9wd5MNOf/GsDMZ4OEZLnCU8rniZ5F07hJeSU6L5eV/2F/S5tABmfRTlhzQJOaVMAS2L8kvh0KF0S42MNzoUqNEMUufTzZpw6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709411610; c=relaxed/simple;
	bh=5qEVGgXghf789QTF6Vviq09kHNOjQZJgQPRio1oG5wY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=okeUUQpSoXs1A8mouIvkvtjWVmfFwLjAWm+jdZ15vRKmyUIWdjAQU4hNllDmr8KpPuRAVtnktUh2Dj/nlFBG7kmoOY3ISkn2JQEFXnokt9bNzeyAXoqj5plO6Q8YaoutHGWFwKY6ULNfzX9GC4bAYDjDiUe59Cd8cVRRu8+xHpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwA/O9dK; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwA/O9dK"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7c83fbeb300so16406139f.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 02 Mar 2024 12:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709411607; x=1710016407; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YWs/kx6ClVcKXIGk91vtjusRqRD6ZLeb6cqT+TeBH1k=;
        b=QwA/O9dKSe80N10jNuAzeeAvsL7O7uMV1wPXgsHqRsBH08nKu8caPVvEdfs4jXxe0Q
         0/f3/F8wV1TyPpSp3dj9VmkFbcOCigp7bBc4EC7kiogAiYc0GzZbdN7RCAcWlMNFt14b
         DZ3nZoAOR/Foiy4hA3VRm9jYiJGc2V7035Rc0NhgAJhat6qfECrf2UnLc0SaIHqvt12T
         gjD2CeM29++wQ8UdUGFTOlQkFz+DzVN6cdcZSUu5ijKxB5JMgUA43oIR6Pltgx/Y+HAo
         JVA+sBsh+Jd8gIEUEI2Z3dJF/Ns7taYJSZ40fflSD4pY0sKlenRjOWtxa1aMXeYFgrrm
         jQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709411607; x=1710016407;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YWs/kx6ClVcKXIGk91vtjusRqRD6ZLeb6cqT+TeBH1k=;
        b=dZr0Qs0lNw/ySqkY8bNWUjE1SJYq4TANlO1P/FbRhfSFwsZbl14ORyd/GgqjgWC9r3
         B/sQYQGL3ewvLUI8mEH7eSA7JF3tUJNHAPpw28YUHJ0iWwLq0+akljX/5NCkKKeXHGqH
         LmgBIH2kXtBtgi9i8Ekf2TGp0o5FfWB2cliShUL0QgGMbzzQCXYf1xvS5gLCXUCnzpsm
         +XVJuzaBmfalbsUy9tiezF1B3fq+IBFA0b0/O7xWMa/uVFzsX0qU2kBZwLnfVOzlB8Le
         4xFfN++ROD5AeNzFOD7OdG3REqJaD0CWvBf5YxCIasE6TG/uB/mJ8IMmRNWSbN4dDn7O
         aaYA==
X-Gm-Message-State: AOJu0YxHwUXl3x62ijE8P7UiBOvg01rVhHNSgaLiwwqUkYRBw7nC6rr6
	AaBb9os5zdvQo5p4gg9a7XIfD0DV2hNPes5IX8oQssavw4/9iPFSksAm3V7S
X-Google-Smtp-Source: AGHT+IE94m2mE/hntQsVyu+R3O3WFoSZih2P85vMFaRsEYdt2PBWMrNdiZY9bVAX0QHWHAwCovLfew==
X-Received: by 2002:a05:6e02:144c:b0:365:3e8f:6ac4 with SMTP id p12-20020a056e02144c00b003653e8f6ac4mr5563377ilo.27.1709411607588;
        Sat, 02 Mar 2024 12:33:27 -0800 (PST)
Received: from [172.17.0.2] ([52.157.4.128])
        by smtp.gmail.com with ESMTPSA id 30-20020a63195e000000b005d67862799asm4872082pgz.44.2024.03.02.12.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 12:33:27 -0800 (PST)
Message-ID: <65e38d17.630a0220.6d377.4b55@mx.google.com>
Date: Sat, 02 Mar 2024 12:33:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8395193839238784125=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: add TX timestamping for ISO and L2CAP
In-Reply-To: <d19187ab9842df2565d1d82beb171a8967d2ea94.1709409547.git.pav@iki.fi>
References: <d19187ab9842df2565d1d82beb171a8967d2ea94.1709409547.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8395193839238784125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=831819

---Test result---

Test Summary:
CheckPatch                    PASS      2.84 seconds
GitLint                       PASS      0.55 seconds
SubjectPrefix                 PASS      0.18 seconds
BuildKernel                   PASS      27.56 seconds
CheckAllWarning               PASS      30.66 seconds
CheckSparse                   WARNING   35.36 seconds
CheckSmatch                   WARNING   97.77 seconds
BuildKernel32                 PASS      26.93 seconds
TestRunnerSetup               PASS      497.74 seconds
TestRunner_l2cap-tester       PASS      18.07 seconds
TestRunner_iso-tester         PASS      128.12 seconds
TestRunner_bnep-tester        PASS      4.73 seconds
TestRunner_mgmt-tester        FAIL      111.18 seconds
TestRunner_rfcomm-tester      PASS      7.27 seconds
TestRunner_sco-tester         PASS      14.86 seconds
TestRunner_ioctl-tester       PASS      7.67 seconds
TestRunner_mesh-tester        PASS      5.88 seconds
TestRunner_smp-tester         PASS      6.79 seconds
TestRunner_userchan-tester    PASS      4.91 seconds
IncrementalBuild              PASS      59.57 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.171 seconds


---
Regards,
Linux Bluetooth


--===============8395193839238784125==--
