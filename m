Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8990517BCA
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 May 2024 07:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716795251; cv=none; b=E4uCc47/iblKEWS7xqhIxi3tc7eOi4UpTsK14vrTA81n3LeUsfV81Rn2UFI0qRTSwBcmwzU/UNftClolO0UV6//vei6Q9WIQBcKUACiTkWRe4/jl4+fiAxriTPt0XFxGyFVXy70qcEzD0XSosrUOHDbNINQJS/N/h0eI176STHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716795251; c=relaxed/simple;
	bh=aSIL+OR9KlUdmWIJNn8ysx0dVSaGoyzBjiO2sGrqaRM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sbFF0rqXl2vz8f3YarpV7ElNRpYQr7nSnzvzYkFRmKGBh2AXSLN4fnldIeUalo4xU23AD1srADTIlvxBwHcjJFp6IxENgdiU6oRPPvpIl1hEAhuAQbyww2WR8lFIAxMyYdLErFlsQoj9ROs3Cr+TNBGTu8MKVHRgl/TnNfHdveI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hM4D+DBE; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hM4D+DBE"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6ab9d3d878bso15512216d6.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 May 2024 00:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716795248; x=1717400048; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tIKxOa4XBlRpayDVwfZ19JHNwTUTNOe8dDgg/r4s2JE=;
        b=hM4D+DBE4qrAS5ry36GLkcvo38oykKMK7uJo4oi/4+CmMlcDja6X7iD8HO3lDdurEL
         QqEbTS/HTtfczkMGA63BOeRx5zCsT3GU/JZy3RyieciWOcPAkNzuh9QXSRfrMoSxo2xi
         DrSbVLvOwN4F9dKdUYByN9154u+KrIBdzuqL4TMpAPjOOpHkxMdME7PAuHIrgnYfMs52
         1vt0n07Ndd4djusxcGihxInJR7k+IcooN6bjtCK1j1Sv9524J5qZRzRTPPBS9rycTcPj
         PsvmRiXI4tLjKY0HjXGT+N4VMhQQSNlg+ITlC5RsW/kpgPqEz6woxbhQVkH1CIv/+cD2
         ypNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716795248; x=1717400048;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tIKxOa4XBlRpayDVwfZ19JHNwTUTNOe8dDgg/r4s2JE=;
        b=nHnAlmbmEM0I/WXkWshtQWZY2jm2Qhxy/QfhLdrF6Z4zO+WVmIkmr9rLX9XBGqobKP
         0wWMy4VWW0cLmmK1SVtFrgC+cDZys9Xgj1gtkumTU2s4YWSin7cwmSFnFQfwXMt85yiD
         tGRke/2FdoJlvcEETm8cGmKBSs+MEeL8WLJrpUuZua0m4MZsw64oPfgyoO0w/fGv8FwU
         W1DniBOh6IzhpIgXX/vdwbJHgEjaysPUdbNcG6GZN9AJTGSPwThEKm/7RAvsrdq71Aha
         Q365jGTmw7PIWPm39augjQYB/FXmaUCmKQAf5Y2vlwmNGhjwrWb5bhT2kiD3qDbPC9jd
         J/7A==
X-Gm-Message-State: AOJu0YxOb1gc6Cj15l5MlEXvaQSf0CeprJsz5cdSJl+DaKqTaC+kAuzl
	LGGG00fNJy69KY92yaRBpunl1MiGlVvpqacIKX86+/KIE1XOf2XSkfZrsg==
X-Google-Smtp-Source: AGHT+IEkv28f6bcTJGoIOBCbRrKuOVTYEGCmxo5n9NkRPRK6nwUnRR3XuB+seAqCRbfpXkdRLOUnvA==
X-Received: by 2002:a0c:9cc5:0:b0:6ad:5e4c:4e08 with SMTP id 6a1803df08f44-6ad5e4c55femr72277466d6.53.1716795248233;
        Mon, 27 May 2024 00:34:08 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.107.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad7a8086b2sm11866296d6.1.2024.05.27.00.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 00:34:07 -0700 (PDT)
Message-ID: <6654376f.050a0220.4ae4.2b74@mx.google.com>
Date: Mon, 27 May 2024 00:34:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0619389466910182428=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jiangyunshui@kylinos.cn
Subject: RE: [v2] Bluetooth: 6lowpan: use DEV_STAT_INC() to avoid races
In-Reply-To: <20240527065258.1014049-1-jiangyunshui@kylinos.cn>
References: <20240527065258.1014049-1-jiangyunshui@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0619389466910182428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=856029

---Test result---

Test Summary:
CheckPatch                    PASS      1.48 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      30.17 seconds
CheckAllWarning               PASS      33.30 seconds
CheckSparse                   PASS      38.45 seconds
CheckSmatch                   FAIL      38.05 seconds
BuildKernel32                 PASS      28.90 seconds
TestRunnerSetup               PASS      523.54 seconds
TestRunner_l2cap-tester       PASS      20.42 seconds
TestRunner_iso-tester         FAIL      32.55 seconds
TestRunner_bnep-tester        PASS      4.88 seconds
TestRunner_mgmt-tester        PASS      114.01 seconds
TestRunner_rfcomm-tester      PASS      8.52 seconds
TestRunner_sco-tester         PASS      15.01 seconds
TestRunner_ioctl-tester       PASS      7.88 seconds
TestRunner_mesh-tester        PASS      6.11 seconds
TestRunner_smp-tester         PASS      6.94 seconds
TestRunner_userchan-tester    PASS      5.07 seconds
IncrementalBuild              PASS      27.55 seconds

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
ISO Connect Suspend - Success                        Failed       4.178 seconds


---
Regards,
Linux Bluetooth


--===============0619389466910182428==--
