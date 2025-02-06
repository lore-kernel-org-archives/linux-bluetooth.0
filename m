Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD49D19AD70
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Feb 2025 21:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738877464; cv=none; b=Ium7sazd9bIr64IBDkAnwSMwHwI/hlLlSJvvR4ntfn3AX2y1YBzo7KLWAzJ3k30MRKeNI84XEA9rqWMzET/LG+pLwRyTXf+e7LtIRU4XM7hSk1CaCJcNaAHwcOwccDaLoyOYI1qCpwFRM4YrVVGy85NvoxoTVai12jUcEgw5si4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738877464; c=relaxed/simple;
	bh=R8cPHRdVzEOSyjwICnrVi8FhwWxmh90xbOCi+aj060Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KmPeQTmRaLKgMabIp5XtslRdKUlsTvmLReM25aONsLN17QTB2jxdapkzN16wxPJbCKCADgFSPh+X2021ezjVuTaU87sN0LgZ7nsTdZs8oXn3LPlQdmExmfNBz+mDdjouKpbmac+qqdR0PrSMv2wvdrjQN8sjmGVHrU6aKyyTmp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldNmSxsy; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldNmSxsy"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-46c8474d8daso10801221cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Feb 2025 13:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738877461; x=1739482261; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BP3yjeMT/OD8u7XdCuxgn/EzUGHHwzsGbRsWTUIAHw0=;
        b=ldNmSxsy9Gj/9If1EGwXPz+X1IsB6kDUrw8g7GQYo3b1c+4JnARlYoIIglYpdCLqop
         KrsDEaVwb0V1jNx/IPMGuEZa3fMtEx4lxmkRXm//9CUHhetUH6Rp9k3FVwwirlTJshCZ
         brtaFxaknYQos2mVpJFhN4aicID8FJbxy8gIoe2R4Je827Eeq4qok+EPsFBGza7M2z6N
         X7AEcJoRHGL5giedbU9cnp1naqyYfuY7A+JySgBiqilO/cy1nda1f5RBiy0yhZEP4Mqx
         biD9KeiMQ/JcJmJ71adrhI1Nc9fMDXTThNFMigDV45raqOo6gxnv5PLDtEnr+3DbYc7a
         qxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738877461; x=1739482261;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BP3yjeMT/OD8u7XdCuxgn/EzUGHHwzsGbRsWTUIAHw0=;
        b=D62FFkTvavMLKqO44cTZ0necHZaY/f+7/w85x3xSAoyaSQg/Z8dOaViGyUrmrRVDej
         sOdXOg4pWJ9O0xII/xxp5B8gEfnea3s1nadab5VtvqffKIixmxebGW0Mpk6+6r+B17gr
         hWNwgqoPJ18Z5G5iLQahC/yWjmiD48avceniBFFgsF14soIt67fXM2CGiHMoeXailXpG
         AmSMFtc8CqEjqtV824vr/UqEY8iT4c6TC0mNuQCDOOwucTId7DoGxL19wCVi/9vSkddb
         J9c0/omD/DCjf8VFWJtK2NjfI+SIrTH2Roz/yc7uD8Nuf9/22f717RJW8N1hcMeYyBW7
         MmZg==
X-Gm-Message-State: AOJu0YzNGHUoqUxAuNMDhyEPUKZMQOAQXdr359FnnqFeZf7fDJTSm5A1
	19vRxTPclWcwirYdUne21eL9ydbWhX7fHsvGq57WIOkRStG1kGseviqr4w==
X-Gm-Gg: ASbGncsIqF/fDTFEoROHv47n15BAqoCW3Kxniq8KBGtg9PIjDqLMKgvALqoGu6AGBsw
	K3SwAVzhURLx+rmYBmYCAwc1QG7XxRB4Vr09d/sfXNNxZtVPs6HbIMS1asG3Yh6cHfclg9C24j1
	oHqhwAP5aGWr1W5iCgPNHzO/Og8nvQL8FtNjBB7XUw1JUiEkGxDJ6yumu+zu10UzUIO7/wURjwp
	dsL8nrAPX9Gl7zAvEt7dT/BkYaYVmW4pUfXHEOxWNCeFYGmy7GTSb08BQzA8vBX7Y9BwJwD5lD2
	vRE22qnhRJcK5R8sGlzH
X-Google-Smtp-Source: AGHT+IEQCF2DU3Op6oB8kxV/UQKxd8PQMUyhMmXXMwxQ02G/xFR6fGszdZHoi7UbPFALuvn+gNn6hg==
X-Received: by 2002:ac8:5812:0:b0:467:681c:425c with SMTP id d75a77b69052e-471679a8fe8mr11632091cf.1.1738877461412;
        Thu, 06 Feb 2025 13:31:01 -0800 (PST)
Received: from [172.17.0.2] ([20.42.12.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471492763ebsm9277371cf.1.2025.02.06.13.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 13:31:01 -0800 (PST)
Message-ID: <67a52a15.050a0220.299209.4b94@mx.google.com>
Date: Thu, 06 Feb 2025 13:31:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1925002696095638211=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: L2CAP: Fix corrupted list in hci_chan_del
In-Reply-To: <20250206210110.3283152-1-luiz.dentz@gmail.com>
References: <20250206210110.3283152-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1925002696095638211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=931349

---Test result---

Test Summary:
CheckPatch                    PENDING   0.22 seconds
GitLint                       PENDING   0.18 seconds
SubjectPrefix                 PASS      0.70 seconds
BuildKernel                   PASS      24.46 seconds
CheckAllWarning               PASS      27.03 seconds
CheckSparse                   PASS      30.16 seconds
BuildKernel32                 PASS      24.14 seconds
TestRunnerSetup               PASS      429.34 seconds
TestRunner_l2cap-tester       PASS      21.07 seconds
TestRunner_iso-tester         PASS      29.95 seconds
TestRunner_bnep-tester        PASS      5.73 seconds
TestRunner_mgmt-tester        PASS      121.81 seconds
TestRunner_rfcomm-tester      PASS      7.62 seconds
TestRunner_sco-tester         PASS      9.37 seconds
TestRunner_ioctl-tester       PASS      8.13 seconds
TestRunner_mesh-tester        FAIL      6.21 seconds
TestRunner_smp-tester         PASS      6.99 seconds
TestRunner_userchan-tester    PASS      5.20 seconds
IncrementalBuild              PENDING   0.42 seconds

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
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.125 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1925002696095638211==--
