Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C84A1386C0
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Feb 2024 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049561; cv=none; b=dGoKd4Vstw2GqZR+VnD7NeHtzKGS4xCH2RA+2ynMhgKJwSYaZ2o+XUvqN0QioeoHTMMpWg5yCPgM2lZaKsiHoMfv/JqaNAtHDyqhZOYAgyZMorP65K01NSWoom4hHfI6FqzfdWxTwKDwKLpyp2pK5JFIGHCsGdiaDQ1dAQdslI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049561; c=relaxed/simple;
	bh=L5JJIJGRhxN4pyHpuFp2x1RTeKErOFr8ynLpilhMHOE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oZBG4djrv45Cr7mX5PJwNrVXfPa/bEp/HNZTiDS8h5FL3rxsakI+ysJjPot9URFpGWwQlCPcGYsmRLe1i+9nuMxgKDt/EUx9QmibhZj5SG2x0aDZywOAzeX3IhvLl26FSB2nymUy5JQmhHp0XgT9pLq5VHHGmnqx0ha7aRXrPoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGAb6xUv; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGAb6xUv"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c19e18470aso1903325b6e.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Feb 2024 07:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709049559; x=1709654359; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GgTWVOES17M0Yej6EjKMCbsiR84I4bE4nEcpiLbwHbM=;
        b=lGAb6xUvxvF3I3FwO0bGJlg0Ct4YnFT7VZyfAlPtN2/suUCJ01icmKk2TPdet0uUos
         RTafZDeYkilfskC4b32wnV3XxXRbdboSk2wlgKvVYKs8yAlQoSHq1oj3N3cknLvqaJq1
         ksxkpLY/7XhpvUisDdDD+a9PJa4ZwdbAM3cuZhDd/ekw2NJeS4TgAjtnjl8BJsuSXH8K
         tDE8jjGdwXVg22KBPUYXpH6+6hEJcfz0gXwWleAPM5z7ylqb8il3yxZ2xEHd4a+r9VDr
         hIav4+LeoaN4RtKKh8O9+RW7RifQWVK0h7P5tvRJBiuDGL/3UBmCG3BOLdmuWTy3md3M
         8eng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709049559; x=1709654359;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GgTWVOES17M0Yej6EjKMCbsiR84I4bE4nEcpiLbwHbM=;
        b=IW+ObZcnH3l/7HYTwuoNjXa4JukvYHbp+LzHIEvTO3TcVV2kFeGaMQxOBBmNIeM2nB
         DdXy3TbswQSCbpigaErLGZI6zDO8CACHxMINA7//JcHsSOmXu9Ci4HvoBEkRgbFN59lc
         jFxsy8tUpOR+UCGuaKe0/qfTlLLA2KIWCfXCa0KZyjpO80TXv1ubXv/Ct4aGTYHQ682R
         te4i4b5sN2sSSHcElcPiHIo+QthEAWw/ztgJ+WcMG7WOXiv1gJKbFnd3JxtIQRXSQPtt
         ApXbGJF4Zs6oLbTP75cUlldSvyC0S8pZv9yqTc5yLYGHf9cXwQJCyp/GxG2gENpb/X1o
         w8pw==
X-Gm-Message-State: AOJu0Ywo4toBtZ5eGpw2BU8DLygj+HzV9CYMPPrqBC84tmKk19wWqi5k
	/ZSQL5nD/DgE85Q3HEzXR9KQKSFd1MQHNQCdtmUcf1hdF9aoJ0vxf/fn7psB
X-Google-Smtp-Source: AGHT+IE+DnK5gbE5oQ2vW5n7SNF+wjhJKyJamOUxp9nShLouTialXNF5zJgctSPNNUT91DQ/4dZ+6A==
X-Received: by 2002:a05:6358:5e04:b0:17b:57ee:7b7e with SMTP id q4-20020a0563585e0400b0017b57ee7b7emr9629601rwn.26.1709049558359;
        Tue, 27 Feb 2024 07:59:18 -0800 (PST)
Received: from [172.17.0.2] ([40.71.163.76])
        by smtp.gmail.com with ESMTPSA id nz7-20020a0562143a8700b0068d29a0009csm4260881qvb.85.2024.02.27.07.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:59:18 -0800 (PST)
Message-ID: <65de06d6.050a0220.cc628.0353@mx.google.com>
Date: Tue, 27 Feb 2024 07:59:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2397011596286466361=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v5,1/2] Bluetooth: hci_sync: Use address filtering when HCI_PA_SYNC is set
In-Reply-To: <20240227151537.1884044-1-luiz.dentz@gmail.com>
References: <20240227151537.1884044-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2397011596286466361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=830316

---Test result---

Test Summary:
CheckPatch                    PASS      1.34 seconds
GitLint                       PASS      0.62 seconds
SubjectPrefix                 PASS      0.24 seconds
BuildKernel                   PASS      27.74 seconds
CheckAllWarning               PASS      30.40 seconds
CheckSparse                   PASS      36.39 seconds
CheckSmatch                   PASS      101.69 seconds
BuildKernel32                 PASS      26.94 seconds
TestRunnerSetup               PASS      498.06 seconds
TestRunner_l2cap-tester       FAIL      25.74 seconds
TestRunner_iso-tester         PASS      129.50 seconds
TestRunner_bnep-tester        PASS      4.82 seconds
TestRunner_mgmt-tester        PASS      116.94 seconds
TestRunner_rfcomm-tester      PASS      7.40 seconds
TestRunner_sco-tester         PASS      10.95 seconds
TestRunner_ioctl-tester       PASS      7.79 seconds
TestRunner_mesh-tester        PASS      5.88 seconds
TestRunner_smp-tester         PASS      6.83 seconds
TestRunner_userchan-tester    PASS      4.96 seconds
IncrementalBuild              PASS      31.59 seconds

Details
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 51, Passed: 50 (98.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP LE Client - Close socket 2                     Timed out    2.172 seconds


---
Regards,
Linux Bluetooth


--===============2397011596286466361==--
