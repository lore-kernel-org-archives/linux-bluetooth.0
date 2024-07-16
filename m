Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579631953BD
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jul 2024 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721119093; cv=none; b=mRNNha7CvGhZA/e9wAMQTHWhVdsuNuD6Nt6PPi3/G3Hh+SOUS7C3NyFkx2KHmiHtS5zPiCXf/MQmoK6NVNCkcB9r0+8uRiIbaw0Zb3QFnV/XPgmslyqjyLXhx/sTRf3cPsIcLTE+j856TeVqOn+h07dMH7YHJP6yK1imixZst3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721119093; c=relaxed/simple;
	bh=tBwb8O4FGQhJJcwj0OTY2Q1KrI668s6G/PT4SGAqhL0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Hgs8sUXs0XCFrH8CaFgUI88WSvsbrdVbHcAF9Sr+IKL2g5cXnp/MEXnnsr7nnWlCYMTQl3UCwpbazyobbGsbRyh28P3vJSbW+jGnlp5bcXdp3veAr5bNGxupt7oDcwzKFPPQcRCyT/OtJdFwyo8AmeP9DU+iOp/2F5jaWurDuBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUKd1R3e; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUKd1R3e"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79ef7635818so358787185a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jul 2024 01:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721119091; x=1721723891; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CMglFcPGuP/RXNU2rHzr70vLn0AYbdKBoYJY4o9F3Z8=;
        b=cUKd1R3eE7z1PmAZ3zYcQo+jwhCko5BtXLltiFmQactEb9QfvFLl1/6FL2cE6Eftwz
         Q+6GD+xNnLuKyldZ+M70aK9NdD1Gygh4UWhM58Kk+R6MMkTbIDVkt8BqWhxblKVMFIHE
         vJzmtUsGgS5k45VpHQPnnylfxXssEB0xeORg6GGlHKUeRjdoIgOMDqEJq1KiJMnpQYjo
         PA5w1+r3AvtOBGEBZRSspF8bv7f0eS5ev3xx1LGvC63QSTZ8IhoWbinQ2v2jaRNiW/8H
         RKQ72G3IMxNPlbqotpZgDaxlg1h5xDd1HYOqqTevY22gB7hzqf/kmbkgE7ksPauvDtM0
         eJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721119091; x=1721723891;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMglFcPGuP/RXNU2rHzr70vLn0AYbdKBoYJY4o9F3Z8=;
        b=VVYDrNpn02dmc01obZI8LyRfVHxyZx/VOp/PjAM6i1IiKfiEEzMrEARH/718RCE+4l
         mV7nkpE929Ojl1RgXr9uU0FaJlASonj4Uh8yJkS9j91O/TQr3lzSi4Z/w2QuOniIsjwP
         hWB/p2xEzKcPM4eShw6SUT7C5jvlJy2hAwpNLX4jkpPgQxjSe+f37hnW5hOPeRtrf4C1
         0v3pRzuT/14CaB8DSksW45tQOSgi0YrPtActdHxTDGygbtPWm+JNVqK33UEManYJpIRf
         RNIg2zlH0keA7fnJia19mtgSPdApAJTzqB6vyF1GWyWNr+YDqppy4bhzNhZMNzYI95YJ
         i6dA==
X-Gm-Message-State: AOJu0YyEEBfXQEQ05/fy17kcCJNGIN94eA90/+1+oDtQGMW505lAmcr2
	ZD4WH6DLyGlMq36XxhjY61vqoprhARYyww/a+3tIZc4+AfKHNafFL2eZpw==
X-Google-Smtp-Source: AGHT+IFWoFJf2gri60E8wSpsGpEDdko/PXHQ2nfUuU6wPhaURClIKrSkTpHYaEF3X8dDMyCPHXh7Fw==
X-Received: by 2002:a05:620a:2890:b0:79f:184c:7755 with SMTP id af79cd13be357-7a17b6fb402mr185707685a.71.1721119091163;
        Tue, 16 Jul 2024 01:38:11 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.223.134])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f5b8366e4sm32682841cf.66.2024.07.16.01.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 01:38:11 -0700 (PDT)
Message-ID: <66963173.050a0220.3c07.b8d2@mx.google.com>
Date: Tue, 16 Jul 2024 01:38:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6213383741590791218=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [v1] Bluetooth: btmtk: Fix kernel crash when entering btmtk_usb_suspend
In-Reply-To: <20240716074947.23073-1-chris.lu@mediatek.com>
References: <20240716074947.23073-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6213383741590791218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=871587

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      29.34 seconds
CheckAllWarning               PASS      32.01 seconds
CheckSparse                   PASS      39.47 seconds
CheckSmatch                   PASS      102.91 seconds
BuildKernel32                 PASS      29.24 seconds
TestRunnerSetup               PASS      525.46 seconds
TestRunner_l2cap-tester       PASS      24.08 seconds
TestRunner_iso-tester         PASS      32.86 seconds
TestRunner_bnep-tester        PASS      4.92 seconds
TestRunner_mgmt-tester        FAIL      113.69 seconds
TestRunner_rfcomm-tester      PASS      7.42 seconds
TestRunner_sco-tester         PASS      15.09 seconds
TestRunner_ioctl-tester       PASS      7.86 seconds
TestRunner_mesh-tester        PASS      5.99 seconds
TestRunner_smp-tester         PASS      6.94 seconds
TestRunner_userchan-tester    PASS      5.12 seconds
IncrementalBuild              PASS      27.08 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
Pairing Acceptor - SMP over BR/EDR 1                 Timed out    2.519 seconds


---
Regards,
Linux Bluetooth


--===============6213383741590791218==--
