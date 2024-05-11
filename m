Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D093BB21
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 May 2024 13:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715432852; cv=none; b=n4MRNXuvDUbqqIaMUm0P1osIdaZuPLCzc2cgqjP6rCSuVbf7LrnlFMCEj5R5VzbffX1q94zGjSdGP3xs6tOD5LFM1nUlAim1wNJxywIstTnTP4Ets4iqVqUSB9TcxNQNa1taceT11EPfUfkibJDpE37Mqi0BdK+P6RJWCmF34ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715432852; c=relaxed/simple;
	bh=cbWDHetmlQW9RTWxiBnL2zdEMRtFoFIT1H/wwCQ4AZk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tqv8bx7eeeSMA1FLl28iSprIz3QO0odbUayWebPWHoau6qcbPYtvSCDe9eRsuiinVKMyMbagdtQN7H9Nmn6KAorfmoyFt06a8u2/jAEzI7BageZjEWdBXoMBcB/x6SCwQHzyr1ehsYLktWBMAe3Djkj9VtedZ+GAo4Ui58LvU9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9OsjGfp; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9OsjGfp"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5b2733389f9so1519183eaf.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 May 2024 06:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715432850; x=1716037650; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A4JMIqNOtUen2aYKqEJQMkL+88GRsazPOf+4g8H6IaM=;
        b=j9OsjGfpli2/zaVy0RCqKLc8lwgTTP+Hsm6R/RqmlPG5dYZ/lMF9ySCl7cVoWrrIeb
         WwVDSSaE+uN9XGXTHiLVTismH1u0miWWL5yb+3nQnLDc6fEPtsZNHBdilDZKYgltdWpb
         1iPE5TtZgO+njjjFn3uaBRudJg2Zk2pPVvTk2ObB1lXWM362k5NV8WVpAQiIDA63Xcg6
         /Lq9IU9spALmwwmc+HdBEYW8OQoUtw6OzuU9BcTsQib65OueN3qP6EiT5XorcLYrJXe2
         BFU0+mo5BEL+VpQsJ3uF3nXxVMJbVs4zh2X1twcf6M2uYCCyUewaJfvG1VRUdPVbaoJO
         6/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715432850; x=1716037650;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A4JMIqNOtUen2aYKqEJQMkL+88GRsazPOf+4g8H6IaM=;
        b=qYtJ/L2dtfiUb/4V7th38im3i8l0S+1BgT8EJAL1Cbeq7VWR2TvjzG+HHReByR8Lcn
         vcOVZ3bIOJ1E3v03eNHM7pNkq4mMrDJK8DCTa8JLuEhv+jvZg5h881hMwDjWwfZvZdlM
         +GLGFJA1/EIY9yiNKKxmsAFCJ2FdNtiUN10WZ5gAnUJ4qUBmAt7j26DtnY3DQJsfxVlZ
         dIzD/VOLfqpvGZw7THEB706c1AgUYd/GwLR7k7Vv//vsrznhX0SX2vpGk/vaZBJlMZPa
         yIVzQf8sTvkh2U2dk3hcxKJZvPeAGvnxK6rR5OZMay7ymn5mpe5Q+joqy3k56GTTtlld
         40PA==
X-Gm-Message-State: AOJu0YxmHAhw1pZXcnJjnrnMgOL32E7VjvtYaA21ABOJXAi373f53lSP
	35FdBeNZfsIgIoJIA9OkUGxQ0KH2/tRxVL5cnYcSlx5AIPdj6t6rMVnHT5ci
X-Google-Smtp-Source: AGHT+IH+Yr3Z8xkpvZc6DjBcleV1RGggiO/8hPts7LZQtavcffraFkxGmyuLZMGEwtyD0lqaVTLtTQ==
X-Received: by 2002:a05:6359:a3a5:b0:18d:e328:7e7f with SMTP id e5c5f4694b2df-193bd000215mr558372155d.23.1715432849594;
        Sat, 11 May 2024 06:07:29 -0700 (PDT)
Received: from [172.17.0.2] ([40.116.86.231])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e0daba775sm3321291cf.63.2024.05.11.06.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 06:07:29 -0700 (PDT)
Message-ID: <663f6d91.050a0220.3dab9.0a2e@mx.google.com>
Date: Sat, 11 May 2024 06:07:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7220328102854069090=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hdegoede@redhat.com
Subject: RE: Bluetooth: Use led_set_brightness() in LED trigger activate() callback
In-Reply-To: <20240511123510.22303-1-hdegoede@redhat.com>
References: <20240511123510.22303-1-hdegoede@redhat.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7220328102854069090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=852528

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      29.32 seconds
CheckAllWarning               PASS      32.06 seconds
CheckSparse                   PASS      37.35 seconds
CheckSmatch                   FAIL      36.09 seconds
BuildKernel32                 PASS      28.59 seconds
TestRunnerSetup               PASS      515.06 seconds
TestRunner_l2cap-tester       PASS      20.40 seconds
TestRunner_iso-tester         PASS      29.05 seconds
TestRunner_bnep-tester        PASS      4.69 seconds
TestRunner_mgmt-tester        PASS      108.69 seconds
TestRunner_rfcomm-tester      PASS      7.23 seconds
TestRunner_sco-tester         PASS      14.98 seconds
TestRunner_ioctl-tester       PASS      9.64 seconds
TestRunner_mesh-tester        FAIL      5.96 seconds
TestRunner_smp-tester         PASS      6.76 seconds
TestRunner_userchan-tester    PASS      4.88 seconds
IncrementalBuild              PASS      27.34 seconds

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
Mesh - Send cancel - 2                               Failed       0.097 seconds


---
Regards,
Linux Bluetooth


--===============7220328102854069090==--
