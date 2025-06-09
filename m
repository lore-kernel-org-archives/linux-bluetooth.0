Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3528B1D9A5D
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jun 2025 09:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749461811; cv=none; b=jIbh/a2X8jg1MCdCxjRH6OFjfqynOH5M+qBFYv6bhr/curr8ET9XOsvJs/vD4/DbR8r/invyZN5czH+1T0cM/2a7mlb2oOvhs1A4V2hUcbLksf2eaSxf4G1KIas3cjm95fk+VMgaZMFXHUuM5vyI5YOsBTg8vwHu71bQ7Cv8/EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749461811; c=relaxed/simple;
	bh=urvfqHrtGvhu4DAygvw5lN66mr/JGd7Z8alLtFrxA2Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RweQOgRx+4c2T74TOm1+Y/zH8K5f9n982bBWuYXWUtVKPNU7bmq7YbJonsvcR2ukqWdvfu3+o8D5P8sp5pjPtrJJeZ6phAmnIQZCQTbpDaFrEA2y9yxTryZRKmLN2ErepuIikIerZGmKSxikNGeJMSxmsvsBAWftu0TGlB2ULYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkgA/VCr; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkgA/VCr"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2350fc2591dso31700095ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Jun 2025 02:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749461809; x=1750066609; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=emNrPh7ya7ObrW2f/EKQ1wpDJasEagHxf23wjyWFt8o=;
        b=DkgA/VCrPO9LvspZT2k57JABee4mwBTniRghkp1SGrGJs7bOPf77RkdMjZaOdMlEQC
         8CYjSWGVSMPsXI1RKAv3gaokgY7xFr4k02cF38d7CJjFouwFJB17k2Mv55CwtQr5UPyZ
         dPysR7X3kbTROzRB8eipB4s4XYYdhCP1eZAa2URJT1yl88+CKxWtWjsQf0xCLUx2f3Ks
         4+bp8PRmate/l7/k4m8p283UK6itYUMOYInmK3fFN3SGu5+qFiL1YWJ5Mxz2nCglAuJf
         juk+ZqX5qpULSl+J9HACNQEYAtVeRu3oVcCbl4krJj2IP5ijjB8FDfnsj1u3EaRoLYL8
         hzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749461809; x=1750066609;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=emNrPh7ya7ObrW2f/EKQ1wpDJasEagHxf23wjyWFt8o=;
        b=Bil9gl9dPgZbX2G6nOQzvNg7+R0DG37RM3DpABi8T6Nifk/DSJ9/SNoQpPz7nTcKgk
         9Z5TpNAkrDYjeaOPM97uIf5gVMnSb/6L1JmO7EjetuUlAx+pxAfwYJZhMiMT4mx//S7k
         mlZIV4Lqj24vSHRPI4lMuB9CVJTAkhcoZAVC9hL+XeDOzBKoNlyJmxA3z3HQ4FKolJAA
         Kx0KUa5E/UmH1ZHO6OVpBLiDdkRWgD4JEAr4k14VaaNLL9uJsVU/QuP/9LVdy3IpIdFh
         H7Jhl0Emm+GYU/Ytg0lEiCXquqyN0Co7aq6BetlHCVQx3fW6/8ARNa4AIBG3d+5gJolL
         iqJw==
X-Gm-Message-State: AOJu0YzRefSUCkcxQNbVF5gAhVadldZZqM2/j2+HT6M4xqmsjzvyN3F6
	ijv/nygbCflnBv4oxcHN/iVQzoGIQ8tiwNLSL5zaeDFl9uSJcEdUueDtvfvv/0hn
X-Gm-Gg: ASbGnctEk/HYX5ZSeExozQr8G/rx+ThNpcHqNoKDNt2Neid5Uw9w9qXLRsrEdRBzdnU
	efoCCy9Z/H8TlOL6bFH75B/COSD9ocjviqI14J5JDEY9Gpx/2auQSVoMWuXU+Efi/NrcPp+kmRR
	L6ZUbj8FtS+BSiEt8jFhMQ07Sk/R+dbl/onbGfwp3L9C4O8LrZub/QfHiyA7mg81kgcjddhkD2M
	1bzqp2DQT722e09pWW0Mxqxy+yln16TY/6Cmaewz+W3TEecbR4iZrgTWZRZZ5ng1+ryMKvc9K1F
	UNaJ9rfnSmo+7nn4xdKgQMKmEm0fz+7tmUsC2GOSbmD89t+m3XYc94+jQ0PdBCMhy7t0
X-Google-Smtp-Source: AGHT+IHgzPxxNFZ1Dm91EpqjrVM3/2ioIHLcdxsVIf7LE/t1lKomHZg6N/GnpocamoHMdRK1NYL0MA==
X-Received: by 2002:a17:902:f612:b0:234:2d80:36 with SMTP id d9443c01a7336-23613673a06mr121437485ad.14.1749461809056;
        Mon, 09 Jun 2025 02:36:49 -0700 (PDT)
Received: from [172.17.0.2] ([13.93.228.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603c6c325sm49883585ad.173.2025.06.09.02.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 02:36:48 -0700 (PDT)
Message-ID: <6846ab30.170a0220.b97a5.fbe7@mx.google.com>
Date: Mon, 09 Jun 2025 02:36:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2261192690687473665=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, giraffesnn123@163.com
Subject: RE: Bluetooth: btintel_pcie: Use devm_free_irq() instead of free_irq()
In-Reply-To: <20250609091040.7535-1-giraffesnn123@163.com>
References: <20250609091040.7535-1-giraffesnn123@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2261192690687473665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=969746

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.34 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      24.35 seconds
CheckAllWarning               PASS      27.03 seconds
CheckSparse                   PASS      31.27 seconds
BuildKernel32                 PASS      24.30 seconds
TestRunnerSetup               PASS      462.15 seconds
TestRunner_l2cap-tester       PASS      25.49 seconds
TestRunner_iso-tester         PASS      38.47 seconds
TestRunner_bnep-tester        PASS      5.91 seconds
TestRunner_mgmt-tester        FAIL      136.52 seconds
TestRunner_rfcomm-tester      PASS      9.43 seconds
TestRunner_sco-tester         PASS      14.84 seconds
TestRunner_ioctl-tester       PASS      10.06 seconds
TestRunner_mesh-tester        PASS      7.51 seconds
TestRunner_smp-tester         PASS      9.98 seconds
TestRunner_userchan-tester    PASS      6.19 seconds
IncrementalBuild              PENDING   0.77 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.178 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.215 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2261192690687473665==--
