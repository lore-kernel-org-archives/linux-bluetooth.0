Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDB6139D15
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715680611; cv=none; b=WdY1GKh5POa/dbUg20xjBfXpWUwa+hPJS4ODp5tEA6GR7kQKg7t+r3IfBHW78WxC+IMUAxDFjPuwqDShi91E0x8xJe3HpkOejSdIwO7pS8Xf2KK8LSgZ9ABgGkbyinIKIVVETq+CzRZWhjzvtvi8fmeQcQrwn/rCwOLOwzzBfl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715680611; c=relaxed/simple;
	bh=9tZqpTUOknKLpnSR0DGJSLFa8bUfEGTn7w53zolkpO4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eoVQSYon0geuSh14skvmy9IViUcKIZdZQYwI2p4KLGpPZY6BUvyOAjgHqwx1G/dB2cPJk18C2ze7rE+K/kg68zVos5IBxS20Dzpejyq7fhcLhsWL9lM/1ckCnyUnFVjyTEY6KeTH8+93EchibmGlqfZs5dB0BCJtAQtepw6r22I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LABYSyC8; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LABYSyC8"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2b432be5cc9so4211880a91.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 02:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715680609; x=1716285409; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2XZi43eRvpvyh5Y6rrEhtOn1LsXryEUtX9PIbz4EWuA=;
        b=LABYSyC8Bk4ulTUuJoGZeci45st04wBTirL7DVx8y45oZL6if0wFcqRjxNW1/owo4e
         njZ9IpOuDyWZCsLOX8ym5D3FQ+dfCcNe9JEWCCHYMrUJO/3WEOfuL19tIvW3vFXNO482
         zI5RzSJ6Gt6XNuxAdBwYxav1RXELDXJpdnNyOj3opBohCRml2K630lBFB5c8qyGKJV4F
         JG8dMc4X8bZiXrpw8i+q7lk3kZOFIRiKMtaWnMELuqe01AGtwBp/Rj3kCKbN2g5z/18F
         Bg4AVCbLRU/r/U3bDZlYXJKiezH4AxoD6bpUzWhpLAJVGv5/23BTxeMbsfyGxWPc02ku
         1I4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715680609; x=1716285409;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2XZi43eRvpvyh5Y6rrEhtOn1LsXryEUtX9PIbz4EWuA=;
        b=v5IOjpYlyfJMYEcxSdAQv8NqTZEAZ+rocOAKhzbtT4JD/tmVyHBaagFXhmjZGjTBzo
         +SkORr8QFxwNGKoxuAV1Vj8KzDU1e8g1v1wPmJ8K1Ww3pb0OI0ll9K5pIs4gqbKsSbMa
         a0QYu+oERTQyj/ilaV4Wz1iJWg554Y9rAQxrZb1BRNNpPNrYkpv4cZihD7Cuu+yUdy+e
         cKp4XkJs6J61+4PFZWnZP9Lx2QY1VxKJ5vvgG8l48Jb0eDSMExwQXKOPS5S7p9XXr9AX
         4zaLoLIBKnbymp91qWbQjqepElyTvnsn60BcC3IuVrYzDi8A9Et+nkCAM/rslmVYNzPR
         nrMQ==
X-Gm-Message-State: AOJu0Yx9iGDa6CZA7GOJ1NNJhUWB8NrCo24FQEXoHMxJ0p+X1snR23UE
	z5jp7j4zxz1f5K0ssr33Zep4N7dCcYgMzZq2KR25iBImH2Cn/oytqDWUlg==
X-Google-Smtp-Source: AGHT+IHFIefDHpL9P3xas5y1YkuTX18F7xZq02Fpe9upCAfNmQjsjJlqlPHpcG5Bl5VZ0mH+qv8twA==
X-Received: by 2002:a17:90a:d686:b0:2b6:95f6:b79f with SMTP id 98e67ed59e1d1-2b6ccef2f54mr10385550a91.33.1715680609244;
        Tue, 14 May 2024 02:56:49 -0700 (PDT)
Received: from [172.17.0.2] ([52.238.27.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b670647c39sm10306947a91.0.2024.05.14.02.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 02:56:49 -0700 (PDT)
Message-ID: <66433561.170a0220.22697.b226@mx.google.com>
Date: Tue, 14 May 2024 02:56:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3435698456544002241=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: Bluetooth: btnxpuart: Update firmware names
In-Reply-To: <20240514091320.1508015-2-neeraj.sanjaykale@nxp.com>
References: <20240514091320.1508015-2-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3435698456544002241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=853011

---Test result---

Test Summary:
CheckPatch                    PASS      0.93 seconds
GitLint                       PASS      0.40 seconds
SubjectPrefix                 FAIL      1.31 seconds
BuildKernel                   PASS      30.03 seconds
CheckAllWarning               PASS      33.64 seconds
CheckSparse                   PASS      38.11 seconds
CheckSmatch                   FAIL      36.25 seconds
BuildKernel32                 PASS      28.97 seconds
TestRunnerSetup               PASS      522.65 seconds
TestRunner_l2cap-tester       PASS      20.49 seconds
TestRunner_iso-tester         FAIL      31.43 seconds
TestRunner_bnep-tester        PASS      4.67 seconds
TestRunner_mgmt-tester        PASS      107.72 seconds
TestRunner_rfcomm-tester      PASS      7.27 seconds
TestRunner_sco-tester         PASS      10.92 seconds
TestRunner_ioctl-tester       PASS      7.67 seconds
TestRunner_mesh-tester        PASS      5.73 seconds
TestRunner_smp-tester         PASS      6.77 seconds
TestRunner_userchan-tester    PASS      4.85 seconds
IncrementalBuild              PASS      31.96 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 121 (99.2%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       4.234 seconds


---
Regards,
Linux Bluetooth


--===============3435698456544002241==--
