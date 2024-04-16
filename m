Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA6D1118E
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 06:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713250648; cv=none; b=Z4O8nmh3fUjZWzZRSs8DfsvIghzc1aFaK3YcFpOqgos8NDROiqp4Ac9oTDy1bZnyJKUVgd8QM/Am65zks/4/dhp47f3oFbizznxjMhjIvT3CPeA71OhSTPxSpJXwfUhp0E74oeM2mWV3x98kXvvbBMHTMjaZrcG0wR1CwHve5B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713250648; c=relaxed/simple;
	bh=sRqsbKYFWv8XpVeAPrxKTWDgKEXR6x+9bs+ZR31tH8Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Q7v02cZXrvp15PJmXfJ8wCZRbyjBOkV2yKaMc3J1MxCPtLykcj05VGSF2F0LNXgvQDFaz9Gj2y3J5ggJYTJRfhzbj4TH//2YV4DI8F2G2mWwn57Gi3nVeANb+8AANy+4qo4e44+gXuSrdeUs4MMBSv0cN7m4KkKDOnEMHYqTyHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JscHLWoa; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JscHLWoa"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78edc3ad5fdso191873285a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 23:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713250645; x=1713855445; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ANehhd1wnZmNDchR75Dffw5Dkwtxtti4n5PVkqyiobM=;
        b=JscHLWoaJ1hom2EmtTbGqoVdWJPX+ClX5Tmrjz6/SNGjtEmIzoX9kzU9jOyZPs6Lky
         30D07bIuwKynWVtNgrGXTKgBo+RarydlJjbrplyBTd9sWyks4whFRwR+ursjb66n03fQ
         mTtFw4xVuq63yM05i4DlIM8ZwYggxJEUXB3JI44XdwbjUWcJi+cG8vv1HQD1q6uYRv+b
         Z66U2xEZdA87vFX1Lsmyo6/W0LI0EvDcOcw7iozISTuFPc0RQKFrxopMgZTYDc9wT/q+
         FnkIvGh45vyerynOy0OOFufdkFpym8ngW0K3QtNvahjVpi0h4YL2FDBaazfmaelI5cNE
         vMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713250645; x=1713855445;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANehhd1wnZmNDchR75Dffw5Dkwtxtti4n5PVkqyiobM=;
        b=cVuwrD8ILAsUKQIwQr27K+ZLa93WLJg6EpMrpuD1oyMVCoGtvYBAqS8C1AiD/1QBqT
         BsWFkolOlFUT3bPj44z1Xol+atU464QRGPFJ0xayxkmuQc5iJBf3WTu7ObDHOQrMmD5Z
         2r+OfU7CrfDWgrcpYbsT/QiiMTryFUrqHrHUJUs4aSEz/VwW4PCEnxQb8kWugpEQr1D7
         6s6idltjBqoe50JxAH7XoxtcV01WCdQGmlnUVQYhxArQa9fjiRPkbzzwHOkCwoBkLMpe
         V6vGEDSZly/cpjgMb8hMvN77BS5+JU4/vxIF3cpgyrdl4Gt4BeubVmDSWUMvjE8JjSl+
         zOyA==
X-Gm-Message-State: AOJu0YxstUQ4Zxr1CgPtpjLQwSE3/HgIuf7QpJ3qG/5hRyfIlc2tShC9
	y8nICr2zSpe4O4dY/JCzUlE2/yDaRKuescvYKh+CRdx1QUiy5V3QeN7S7A==
X-Google-Smtp-Source: AGHT+IHvLYNaW7p2zFMS/2K/0Yktn0c9p3rmYu6v8wANfw8Th5i4err8bQgJ/iYnVAEh2RU6shRYEQ==
X-Received: by 2002:a05:620a:22a4:b0:78e:13f1:3040 with SMTP id p4-20020a05620a22a400b0078e13f13040mr1525203qkh.22.1713250644691;
        Mon, 15 Apr 2024 23:57:24 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.91.166])
        by smtp.gmail.com with ESMTPSA id h23-20020a05620a10b700b0078d5f7b9a2dsm7276365qkk.15.2024.04.15.23.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 23:57:24 -0700 (PDT)
Message-ID: <661e2154.050a0220.9847b.11a6@mx.google.com>
Date: Mon, 15 Apr 2024 23:57:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4022073935138755152=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1] Bluetooth: btnxpuart: Enable status prints for firmware download
In-Reply-To: <20240416061109.894645-1-neeraj.sanjaykale@nxp.com>
References: <20240416061109.894645-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4022073935138755152==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=844924

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      31.43 seconds
CheckAllWarning               PASS      34.25 seconds
CheckSparse                   PASS      41.17 seconds
CheckSmatch                   FAIL      36.36 seconds
BuildKernel32                 PASS      30.18 seconds
TestRunnerSetup               PASS      546.91 seconds
TestRunner_l2cap-tester       PASS      18.94 seconds
TestRunner_iso-tester         FAIL      36.33 seconds
TestRunner_bnep-tester        PASS      5.35 seconds
TestRunner_mgmt-tester        PASS      121.83 seconds
TestRunner_rfcomm-tester      PASS      10.97 seconds
TestRunner_sco-tester         PASS      15.29 seconds
TestRunner_ioctl-tester       PASS      8.08 seconds
TestRunner_mesh-tester        PASS      6.12 seconds
TestRunner_smp-tester         PASS      7.07 seconds
TestRunner_userchan-tester    PASS      5.16 seconds
IncrementalBuild              PASS      29.76 seconds

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
Total: 122, Passed: 121 (99.2%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.178 seconds


---
Regards,
Linux Bluetooth


--===============4022073935138755152==--
