Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC881153512
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 15:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713800048; cv=none; b=e4kNia2HmcM7Ig838RIWZ9jQ979ls+tJRf/cqkUf3oJ8sDLpTf3Tf8jZLn+YCwU+bMnvFCXjQoukIdnfChD3xbJYaOL13U0IYP+MOwgj42GkcnOND/ssfbETPMNKLsMqAC602O1Hsk3be51QTnClNz9Y+15i+loMFv5G3NHkb8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713800048; c=relaxed/simple;
	bh=0+UEqwhs5XGaRHoa7OBqojBVOTV8TlQ+yWJRyftVQMg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Zw2Zp67jQtaQkBJw6RoKMYiUb1X7gy7DygPU/dZVVJzOv5eO2ReH5We3B52zY/gFkjC1I/Qsoyc86y/Qfv1F2KdtlXBlOxM8Wtr1GuZfJ5j7FxcnxH1UInelukW9OrOMM9nKJ+MFF6WJnFjl+IKp8FbjdzlWrvaJ11mb0J1GYkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvS/Elew; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvS/Elew"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e65a1370b7so44240765ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 08:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713800046; x=1714404846; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nksVRN5a/Wls8qgi3FhQgLN1mRRUq/aAxJKscwm8zXM=;
        b=JvS/ElewysWPP5mo16M18YWS86mnB343jpK0Kf47Vsst51VQpqb7R3bCJW99xOyr5h
         o7hIKrNnOeTxb8lzbGiDWiZOmqKMVMJkH7q8yulDmk3wKE37rFnxghllA+eLtb37CqTl
         ZEw+rpMhqpRnnUmIaXUTeFpROAReHtjgQxsK5cVK1ZUuFvkYGIKB9n78GuoGMObx/rNr
         9WjIO+nvH9C7C9LyZ27MDTlpLSLxXWN7QWlgELjzPwMke57gXsoHh4rHYLSypuxuq762
         Cp6ANmaIyj8rS6ckouM+2zhXaBY4wt990Bg3tWSb6ON2iwAKDNRPU2l9MdWEm3XxPGss
         2FfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713800046; x=1714404846;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nksVRN5a/Wls8qgi3FhQgLN1mRRUq/aAxJKscwm8zXM=;
        b=CWQoovsec5EwcosaCElz3LkPf0ESK0ilQeIK7P5/6VcyfWHP8tU02Kym6U2K6RpjI2
         Fjf5hE7HA7QDgslJl8OFn1VAW/YUd5kDTiWQy1qDs1NS7Ciw6vFH0qf2tvmPbP7KpVgf
         BZh0vQyaRV9mWc5EoLzfXptvtH1Wo2laWDNmVs+wSGEC9aDZA8mfQ6Aeg7ZI12drNLRb
         2yQGkDdzq19yr+nBPIwIINeZn3+095ZBFkTnXmt3iViCS3smznYomhfFbLzaqKXlVKqe
         mDCbzLoikrWj6XU6X267kdDQDzM1pe8YUhtyco2avQHwZppYqLTVVRKFrRJU9Zs0io50
         AP9A==
X-Gm-Message-State: AOJu0YzzkV8Gkep1tmnzeCtEH7LxAoDY2S3tH35OqvdLQW96xFMyzvVp
	O69sPoan5GFlM/ozUi1jGY4PBGPZYz0AlGUOS8EW6yxEruvkKbbZcdBdqw==
X-Google-Smtp-Source: AGHT+IH4awrW2oUmm013CsXEsxLsGzTpPP5zIYP1IoRCFyzz2cd2ssGtrw155DizW0U02u//wcVsxQ==
X-Received: by 2002:a17:902:e807:b0:1e5:d021:cf58 with SMTP id u7-20020a170902e80700b001e5d021cf58mr15484951plg.36.1713800046139;
        Mon, 22 Apr 2024 08:34:06 -0700 (PDT)
Received: from [172.17.0.2] ([52.157.1.141])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902d48a00b001dd0c5d5227sm8251164plg.193.2024.04.22.08.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 08:34:05 -0700 (PDT)
Message-ID: <6626836d.170a0220.593eb.a3c1@mx.google.com>
Date: Mon, 22 Apr 2024 08:34:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0030908138021533892=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v1,RESEND] Bluetooth: hci_conn: Remove a redundant check for HFP offload
In-Reply-To: <1713797194-22982-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1713797194-22982-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0030908138021533892==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=846706

---Test result---

Test Summary:
CheckPatch                    PASS      0.46 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      31.11 seconds
CheckAllWarning               PASS      33.50 seconds
CheckSparse                   PASS      39.85 seconds
CheckSmatch                   FAIL      37.98 seconds
BuildKernel32                 PASS      30.35 seconds
TestRunnerSetup               PASS      540.23 seconds
TestRunner_l2cap-tester       PASS      18.63 seconds
TestRunner_iso-tester         PASS      31.08 seconds
TestRunner_bnep-tester        PASS      4.60 seconds
TestRunner_mgmt-tester        FAIL      110.73 seconds
TestRunner_rfcomm-tester      PASS      7.21 seconds
TestRunner_sco-tester         PASS      14.86 seconds
TestRunner_ioctl-tester       PASS      7.52 seconds
TestRunner_mesh-tester        PASS      5.68 seconds
TestRunner_smp-tester         PASS      6.76 seconds
TestRunner_userchan-tester    PASS      4.78 seconds
IncrementalBuild              PASS      27.79 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
Pairing Acceptor - SMP over BR/EDR 1                 Timed out    1.806 seconds


---
Regards,
Linux Bluetooth


--===============0030908138021533892==--
