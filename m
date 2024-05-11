Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2985D27452
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 May 2024 05:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715406949; cv=none; b=ECxyzAo0qTThU9ZT0hEU1EJy6tw/DsPZm0t28bSHwvEqca8oCdBsl4J965GjBfiZOEyhw8YYi0IQTkNV13NOWXIL6sGDn1Tk6uzfamDmhNNLow/FhY4tv/F2JxMP9ZQOtoT1j5px8gxHUXGyiJYcQkuoIiaj+H3v7KlcUaH+F78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715406949; c=relaxed/simple;
	bh=ZqDQN9KfY181RD5Kgkug1jwfmlmtjsIvjCSIE9WTnvg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=h/CuqoXpF1ToOdPn1CtVkcpq+ir7SaD7EJgcJdhpHJ7KQzAba6NOVyixwtg2prOWsHUU6JCMCtTvmE+MeO2dsTa2tbxKkFgqYcODLwoz7sp4EngGHImejLSahIpQr9/D9trfJUVKke1BRIlm3fJS+azZWpEWBFy6eNx8Xp2QZOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7ecW5jQ; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7ecW5jQ"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6a0ffaa079dso33057046d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 22:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715406947; x=1716011747; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=87Fcym7fbtnXCHUtQci2fv0xzJqIIXMXsWBvHXl5m6Y=;
        b=P7ecW5jQpQI6Malgvw5+CbwbpNdtpLENHXsdqXFVoWonmL9EWHE+/4uf3XPPJoB1Pr
         XzxmyFy5caYdSuU/mIw9Sbk2HPwEDMp6cBNYlShsDZjOhyi108AX7kVorvBMZ4NX1heS
         YmIgpnro3SLhQqNCU+apbasJaFouy8NXEp6schhfpga6IwZFJaa534d71Wyzy7yRNgqF
         tWngS37trUYk9RuH+JW+ZGzfqhdR0BiizBbQQ7AIfJB1Ph4sG84walY21KtcrDQywYv1
         C++mxEe6f/vaBB6WxU7MuTzmKpuF6dYfksbFqMp28RBRaiEV/BUjBrrgrBcATy+VnXWN
         xS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715406947; x=1716011747;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=87Fcym7fbtnXCHUtQci2fv0xzJqIIXMXsWBvHXl5m6Y=;
        b=La4FMBHbeV3AYnd6HKotYXmsnZ99c8OobJIo4jYXC7XfNXIFyz6vBN3VxKhqhLztQD
         EFXIopAKuz+DEI0Yt+A6+X3VBDt87bXmlIbRaK2l+iuOUZncAHSO2SUbN27LxfY99MtV
         CD9bT2weQmqTSu+D7C8Q4NPADTkvtO6ABcwM/Y4izrIkiLgj7PH/9ovGSAyaM8v6PiBv
         R8ANLfNZMUje8sXAf0V60cIy9qu1YwfBhS4KSkxpEdGz7qL7AuFPg/P97wSWR1qp5/6c
         UIx3qp0aDeiie//+OKxTujoD+GuQoXO/qn6+tG/OJugZoIP01QiahcBI7ajMDy0U8rh6
         FAkw==
X-Gm-Message-State: AOJu0Yx5qUvNMedfBQGti/zTMzb5vm/06Ppszy06dXbjvFE34JAlVO+R
	jFtdPLZwfgwhFRm+uO8J43MPlk1UYPOx1zEUHDFVXUTAAs7ZDLVhnA0yOQ==
X-Google-Smtp-Source: AGHT+IHzESM8vAyuLbSJL2/xGwNVsTdJtYz0zdTm9q713Axc66PHNaGkizpF619ZRyLDC9+EnvS5DA==
X-Received: by 2002:a05:6214:4412:b0:696:4086:5e1 with SMTP id 6a1803df08f44-6a16790406fmr70885616d6.2.1715406946805;
        Fri, 10 May 2024 22:55:46 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.254.133])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f206f2esm23734846d6.145.2024.05.10.22.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 22:55:46 -0700 (PDT)
Message-ID: <663f0862.050a0220.ba647.80f5@mx.google.com>
Date: Fri, 10 May 2024 22:55:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3361666864678238084=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1,1/2] Bluetooth: btintel_pcie: Fix warning reported by sparse
In-Reply-To: <20240511054059.349729-1-kiran.k@intel.com>
References: <20240511054059.349729-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3361666864678238084==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=852490

---Test result---

Test Summary:
CheckPatch                    PASS      1.49 seconds
GitLint                       FAIL      0.79 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      29.59 seconds
CheckAllWarning               PASS      32.03 seconds
CheckSparse                   PASS      37.65 seconds
CheckSmatch                   FAIL      35.93 seconds
BuildKernel32                 PASS      28.40 seconds
TestRunnerSetup               PASS      513.42 seconds
TestRunner_l2cap-tester       PASS      20.39 seconds
TestRunner_iso-tester         PASS      30.83 seconds
TestRunner_bnep-tester        PASS      4.70 seconds
TestRunner_mgmt-tester        PASS      107.95 seconds
TestRunner_rfcomm-tester      PASS      7.24 seconds
TestRunner_sco-tester         PASS      14.99 seconds
TestRunner_ioctl-tester       PASS      7.61 seconds
TestRunner_mesh-tester        PASS      5.74 seconds
TestRunner_smp-tester         PASS      6.71 seconds
TestRunner_userchan-tester    PASS      4.87 seconds
IncrementalBuild              PASS      31.64 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1,1/2] Bluetooth: btintel_pcie: Fix warning reported by sparse

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
6: B1 Line exceeds max length (82>80): "Closes: https://lore.kernel.org/oe-kbuild-all/202405100654.0djvoryZ-lkp@intel.com/"
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


--===============3361666864678238084==--
