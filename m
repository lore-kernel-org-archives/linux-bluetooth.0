Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C3F17F4E9
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jun 2024 09:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717667811; cv=none; b=Cshz9kiLEnpi2I9wOeRKzx6jnl7/xh3uNu+da1deNCNOdyNDLv4D11mcqPvqiCA/++SCqFs8mERLpCl4QE1ZORa/7R9f09/+agKiKrlAWVQtFk0DHJQcSCQdcSZO5csiOjf/V1XgUYdvScLAN58xT3dy1JmupJCOpGGRSep9ls8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717667811; c=relaxed/simple;
	bh=iOGxJGj2z6QKlZ6YT0+nQjhQoR0pX5c/xTKVw8gd+Xw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YSULbMzM/CvvVV0hAbr/W5S7ZUkaB5hQYCfu4yvmNEm8W7dgIp7p7GfLRfMXTxOtW9xfLK5XibvkRTuW/ZVFaM8UBxXjr7jdJRSU9ZfqtcBJMUJWN78M+3mviAvrf2jVOQY/yfVbubvwh9OrXRXDvrbhqdAhqeuIQyKFaXb53WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcxtK7xc; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcxtK7xc"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-795004bd75dso44276085a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Jun 2024 02:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717667808; x=1718272608; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Hw7H3IXMIFSvCets7DOFo4TZmFd6a4wOmgOjKsBWkC8=;
        b=VcxtK7xcKhxDwnLwGxrgx8vlUSWhjyXOBXuYxJXmbJhdj+C7LjnYO9T6Af5nYjZr9E
         LuszN5HDZYqujhB8lYweilZyV0tUeJUi3RDgmQ5H7ybwla4Mc1V8NYtvpzujXJaoXIC9
         pWIeT2UXH/+IMpi3yK27TuPn2IkqIKw+B6RgrpSm2ZFTNdbSwmpKyIOMOM7uV0Q0tIDh
         hBW4DA9JdVAnt+fyE9CUuwogiFlqZQmSI0gcHQ7X2hhWB2gAPr29S1fBEVwLYRqr3Umq
         bX/haYUaHWAXT7y4+6ibfmbA+VTGHY3r6xS5G/FsyNK+uAGMVCD/fytUIukv34VPe0CJ
         uttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717667808; x=1718272608;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hw7H3IXMIFSvCets7DOFo4TZmFd6a4wOmgOjKsBWkC8=;
        b=D5lws19S0MCeU/wTSfPud+sVwcUw37UU4s3QIqBTz+EI7SPW7brVC59Ecc6kzk4bNS
         A5bC+DD+Nlx35sArP13hH3Fc2ps4jPbfBGpiZ+hVEyK8hfdgF2O6QK93HpnvmZp1tiOR
         UwYPp/X31aSPNfRQmmaJr5+JbcYcqxGj66IRL5/MAKp1woJGVIpkTM9z0eJSav9d35ml
         LfZMwKccXY40MW4dMt9zLNsq7vRrmFnYSvQjJ0AiundfqOQyLg0ZpBHyVX1LrOFcgmfs
         n/mZ5SyY9heSl9wDa2qX1cuIEhSIj8ytEhvBFAXmgT1XL1+FGtv2AyHWxA/ub7X/rIO0
         QfEg==
X-Gm-Message-State: AOJu0YwWtHs9ckBXPtMIIG+zd8JeZAuv9Burs45hproahfolMP0lEbrv
	OGa1uUEpNkc++LHj47+UHJRCdnZ+HU6mCurZhqGxEFDg8hHQjGpNmvqOVQ==
X-Google-Smtp-Source: AGHT+IHAC56N1X/HvZ05UZjd7aZIVk8K16K05jZuFw1OsrbZJ7HLF5tZujWxhL2dqdbzFvx//krlLg==
X-Received: by 2002:a05:620a:13f5:b0:794:e518:58a with SMTP id af79cd13be357-79523fbf014mr509255385a.51.1717667808242;
        Thu, 06 Jun 2024 02:56:48 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.131.31])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79532821301sm45144985a.6.2024.06.06.02.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 02:56:47 -0700 (PDT)
Message-ID: <666187df.050a0220.d7750.12e8@mx.google.com>
Date: Thu, 06 Jun 2024 02:56:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2497542495085134913=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btusb: MediaTek ISO data transmission
In-Reply-To: <20240606092340.27675-2-chris.lu@mediatek.com>
References: <20240606092340.27675-2-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2497542495085134913==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=859426

---Test result---

Test Summary:
CheckPatch                    PASS      5.18 seconds
GitLint                       PASS      1.16 seconds
SubjectPrefix                 PASS      0.45 seconds
BuildKernel                   PASS      30.20 seconds
CheckAllWarning               PASS      33.84 seconds
CheckSparse                   WARNING   41.27 seconds
CheckSmatch                   FAIL      34.71 seconds
BuildKernel32                 PASS      29.16 seconds
TestRunnerSetup               PASS      526.28 seconds
TestRunner_l2cap-tester       PASS      20.49 seconds
TestRunner_iso-tester         PASS      28.40 seconds
TestRunner_bnep-tester        PASS      4.77 seconds
TestRunner_mgmt-tester        PASS      113.01 seconds
TestRunner_rfcomm-tester      PASS      8.09 seconds
TestRunner_sco-tester         PASS      14.98 seconds
TestRunner_ioctl-tester       PASS      7.74 seconds
TestRunner_mesh-tester        PASS      5.85 seconds
TestRunner_smp-tester         PASS      6.85 seconds
TestRunner_userchan-tester    PASS      4.95 seconds
IncrementalBuild              PASS      46.45 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/btmtk.c:501:45: warning: incorrect type in assignment (different base types)drivers/bluetooth/btmtk.c:501:45:    expected unsigned short [usertype] expectdrivers/bluetooth/btmtk.c:501:45:    got restricted __le16 [usertype] dlen
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


--===============2497542495085134913==--
