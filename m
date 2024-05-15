Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EEF2E622
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 18:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715798143; cv=none; b=Qr3u4BQWHzS2mswHqaWTTG/kRExiU3Ing3BbXN2UrI74l9l71HKCzTmZpw7mWy1bIqJXwKzZtPxKaZOE2oAOmF/v6i4yXFJsJTzxsjPD8j/NQhEa5H50pgg3VC9xAbbyO5M1zUWkAdPbNS0GkPwybSKhuYXHovoBgdWtZ3uQmg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715798143; c=relaxed/simple;
	bh=777kw3/Ip1NIUF5J2e4W35Lh7sKF1HLdO2Uzq3NU89Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eHWlP1II2gSbFBV2uiD2JMxvruYRJJh9ht9tbMAQ2gNc6GeaYXYcIwJSXV0qausK/S/9ibqC/aRH9qX1uUmAFb0vS4jxR8yuLMyclSf/+r39zCDIcvzbEQk0iZUJNqSQM1WXMtNlrTZS66N048fuX3951EeNSeg0qFMgIEUNzSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjYk6mAV; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjYk6mAV"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-43e0a5e3c08so27790441cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 11:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715798141; x=1716402941; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kFUZfEQlIeQbNcMJpxu7beUIzn256F73KdGobLHt+Is=;
        b=hjYk6mAVoQ/250UBDX18bspXZUKWlZdGCtOprIfLEDdjS3dCWIBV9LFTnzT4AlSiOz
         QLujIXO6XKyA5fcLEBCtJMdWYmQoa0Ki3OCkQ7NNsSKZlR30FlT2/lxcmeYlvQgDLEgi
         XKTU7BKtsdxCSLjWS52lcf1BQ2FQQIsCeiwgumEOQRojtGppYqLBpAhrm24qocN2Qnqu
         mAnhYcB7xZU/GUi/rW2MJp1n8exfDvpLIKRRu5VIX+skRHAlFDVus12ha+JU+NL6pdtp
         AFJIVC4gHrCRYnyiMwP2WSe22AHpGnbPB892hrzZIGQbfUvC34KRrLVRUgQ9sh1g1aBx
         8n2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715798141; x=1716402941;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kFUZfEQlIeQbNcMJpxu7beUIzn256F73KdGobLHt+Is=;
        b=pNjPHIgjHUL5ZnO21rUZ3AIogo9E2uePbtXgMPo6oZll+JnKUGfOlXEZHRDQ0mANcZ
         sCRPMWAw2x2Nrx8kkzu6OnBwQaCpMR/w5/ibfdciXcLHfgBQrkRLrKPyUkCMz1OvABoA
         Sp5tjP8A6Qmo4av0Xnt88woeND2qb+Hvd/vaqssvCFvRqWDW4cYcDtZCtvXyqvwHyuNg
         5gILS7yxFkVPJmdfr9UdtiDZFNeCNsOqa+PP1j8mkbC4E+2irp4hfSjebQk30luLdtUG
         HaW5Dd0gaEBcqdIwqLrxflUHg5uRQjDeKVmbUj987TG0pdzoYv5E83YhUj7sdb7oY7XE
         IbQg==
X-Gm-Message-State: AOJu0YxBeA00Xj55eIGJjy+07C3Ove0ZYCgYbgLIfb4JRbR5X615M9iT
	6KIHYVvxVsCflsfzK6gCaLyQUWSHp4sYSdmw/pdvvaJhVRCC6Yy1wmXMOw==
X-Google-Smtp-Source: AGHT+IHxtWyKKK2Ua9XBe5C0SAGXTSTdBfXuCWLoN8fIfycwYb7M3qqHV3f0bT5vxQXwUc8b3Dpicg==
X-Received: by 2002:ac8:7f0a:0:b0:43a:ee42:3500 with SMTP id d75a77b69052e-43dfdb271f4mr174123101cf.20.1715798140669;
        Wed, 15 May 2024 11:35:40 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.254.132])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43dfd2dbd68sm75987231cf.12.2024.05.15.11.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 11:35:40 -0700 (PDT)
Message-ID: <6645007c.050a0220.b4118.9fef@mx.google.com>
Date: Wed, 15 May 2024 11:35:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6775569047677649818=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, devnull+sven.svenpeter.dev@kernel.org
Subject: RE: Bluetooth: Add quirk to ignore reserved PHY bits in LE Extended Adv Report
In-Reply-To: <20240515-btfix-v1-1-d88caf3d5a3f@svenpeter.dev>
References: <20240515-btfix-v1-1-d88caf3d5a3f@svenpeter.dev>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6775569047677649818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=853484

---Test result---

Test Summary:
CheckPatch                    PASS      1.40 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      30.33 seconds
CheckAllWarning               PASS      32.73 seconds
CheckSparse                   WARNING   38.91 seconds
CheckSmatch                   FAIL      36.29 seconds
BuildKernel32                 PASS      30.33 seconds
TestRunnerSetup               PASS      527.22 seconds
TestRunner_l2cap-tester       PASS      20.31 seconds
TestRunner_iso-tester         PASS      32.81 seconds
TestRunner_bnep-tester        PASS      4.73 seconds
TestRunner_mgmt-tester        PASS      113.89 seconds
TestRunner_rfcomm-tester      PASS      7.28 seconds
TestRunner_sco-tester         PASS      16.93 seconds
TestRunner_ioctl-tester       PASS      7.83 seconds
TestRunner_mesh-tester        PASS      5.99 seconds
TestRunner_smp-tester         PASS      6.93 seconds
TestRunner_userchan-tester    PASS      5.03 seconds
IncrementalBuild              PASS      28.40 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
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


---
Regards,
Linux Bluetooth


--===============6775569047677649818==--
