Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52A616F267
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 May 2024 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906762; cv=none; b=Ng0Z1HK+9ytiqfo0s2nOyBL9V/k4OL596yXcziuia+GdeYMi8dSZURdMV2CYYb2I3bKWV95++0jQaq8KxSo6BeimRJcYdkagNxY7iLojDH9UacAubu2NpmxXs2TobIMXrW3GVNZbaR8Uwz24gkqG/2zsTx4wlDBmn74KrTxEYWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906762; c=relaxed/simple;
	bh=rcCk+MxymQmZTA44hMwmA5HoLDQu4cb7tUssZKW29CA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=R17YmN/WtMHFSm3G/ExWyUgghrGFV7i9fbUwQUiYFivncxHAPJ+CclXKmfdv8jLiLkLHUm0bnhSbMmbSuHKM/2xFn1CAd01399cOt65wmLki/0tHXB5BQceS0YS7pC+4476SP5Rt4FiDR7KRvP9JuV/hAufOudMj5OApTO8rmxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2WEPDlw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2WEPDlw"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f4a5344ec7so7062225ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 May 2024 07:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716906760; x=1717511560; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qm9otqNA/wWZM8lCZsAUIHaiN4LxgbJrr6SIZcgJpB4=;
        b=H2WEPDlwnWuk0HmQTmQY1mKDoxuyvyjEL7ijUJgd4H2sAO0fx0q9WX5Lko/SrIBY4a
         KFfBMQG+lml0Wt2bLKiDpzydZIDvyuqzUtPAL+954uhfoegzrZ1gfckPZSHoSo++rk1S
         Ph7WHAPb5ImM2feC+q6S3Y80rwKcMAbbceQfRd5tuMno4PMlrL7gCk/28xgZN6uwRTJC
         rUuOuvKjJbgbH+mnfRXV+iPpcABn4k8fQ6j4KnXEoYRt7/aGCAy2PwquXpn+nlvkzgvu
         FKRt34vHFGpYRD2XMb3NHA0fhbG1z3Y8ygfiDccmSiPQ6uH0C+9d9RFYCFZzCDKbEXST
         lOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716906760; x=1717511560;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qm9otqNA/wWZM8lCZsAUIHaiN4LxgbJrr6SIZcgJpB4=;
        b=pLRBhKS+91FI94rnpcJQPE3CI+p8D+uX0Hb6rUQOssf4A/Pei6QmwKjAAFvH3GtK+T
         aal7PjdHtENj86EAm7b+BvJjLnXATVB0Ns3f0zxSt5ivENiLZI2gpvCOBOMfSgMZXGOM
         t/5PzBmqU3Ws8Zz76KxCNdFF6y0jzXoDL5JU48wKALWdmJcSYfJiX8rv1VdenUQTQ4O3
         3wAtR2HjB9wl/LLQ2qJ1nZhFCC+wgCci96mopYzdWmGjgCQ8yAiiT4WZDXFujThk7epF
         mCFPOLCAN7RjLTV7dYqJnx7hWegovviPnq6hfep7VwoR3Wx2cVP9f/F6GsH7L7ztKUi2
         5a3Q==
X-Gm-Message-State: AOJu0YyGro9Ktbw2RCkTV6AD7OgEmMaCMK06EVtKFnRnCuDANmE+SUkG
	Xc8+KjeFIIe6QmOezQsIKe/0VW+qEthkIET5faBUmLoPXU97vFedAqb+Vw==
X-Google-Smtp-Source: AGHT+IFykfapvrY+75Ry5wTH+q4DmCQZUAX18GBdh41xUYKhxgkp5iH4Z/JiDnI+YUF1aQlWPChL5w==
X-Received: by 2002:a17:902:e5d2:b0:1f2:f8b7:60cf with SMTP id d9443c01a7336-1f339f51978mr221358675ad.27.1716906759316;
        Tue, 28 May 2024 07:32:39 -0700 (PDT)
Received: from [172.17.0.2] ([52.238.28.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9e0984sm82963865ad.305.2024.05.28.07.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 07:32:39 -0700 (PDT)
Message-ID: <6655eb07.170a0220.7b4ca.4406@mx.google.com>
Date: Tue, 28 May 2024 07:32:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8002303927269399185=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wangyuli@uniontech.com
Subject: RE: Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x13d3:0x3591
In-Reply-To: <624D89A316F197DF+20240528140345.69035-1-wangyuli@uniontech.com>
References: <624D89A316F197DF+20240528140345.69035-1-wangyuli@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8002303927269399185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=856579

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      30.23 seconds
CheckAllWarning               PASS      32.62 seconds
CheckSparse                   PASS      38.50 seconds
CheckSmatch                   FAIL      35.12 seconds
BuildKernel32                 PASS      29.37 seconds
TestRunnerSetup               PASS      527.67 seconds
TestRunner_l2cap-tester       PASS      18.37 seconds
TestRunner_iso-tester         FAIL      35.09 seconds
TestRunner_bnep-tester        PASS      5.50 seconds
TestRunner_mgmt-tester        FAIL      108.62 seconds
TestRunner_rfcomm-tester      PASS      7.45 seconds
TestRunner_sco-tester         PASS      15.03 seconds
TestRunner_ioctl-tester       PASS      7.91 seconds
TestRunner_mesh-tester        PASS      5.99 seconds
TestRunner_smp-tester         PASS      7.02 seconds
TestRunner_userchan-tester    PASS      5.06 seconds
IncrementalBuild              PASS      28.33 seconds

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
ISO Connect Suspend - Success                        Failed       6.207 seconds
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


--===============8002303927269399185==--
