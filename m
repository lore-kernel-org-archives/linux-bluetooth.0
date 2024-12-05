Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6641917EE
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Dec 2024 07:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733385381; cv=none; b=AD0V8XJesOIexWW4rp767IrDpulhkcNwVc1xJiDL/aPKCNrUDSOb68gxrj9Y/XaDNNrI5wRolQVDI2MF6mGI/U3ncm/09OwNdjBMdNW7t+uvVKh/AfUUWa4hu8yEkGWTvXWPCOUiZVPc8tE4vAkntYYcohHjso7u7cMYhrbJaRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733385381; c=relaxed/simple;
	bh=uxWpfG/NXHBm4ssiM3/LOhpBg8la1lGhxcwYXX0bBKc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=o1fk5sR1QdaB0y997So8oHLtQ2QI6CZ5EcZ+pmOul4Tza0qcY9UZRVu7XA2QMjZ+w8yKKw3kHOgBuLneofYElSVefTVC47Q9g9bL7KofCXILj4MxqeoRg77emYVvDZIPZbZ0vH3NwmgIpF4Yq53p/gwKR+XGhk4XmSPbz3faUTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmbSBmaL; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmbSBmaL"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b66d08d529so60242085a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Dec 2024 23:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733385378; x=1733990178; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fVMKeG2BU1k+f8hZOsNmEcpXp9HT7LYkGQByxGZdszQ=;
        b=RmbSBmaLCM6TnUsWEdHvHJJr9rEznSnnu26KAGQlhOt06Lp+40teC+JmKxv3Ut60AI
         qNr+UCC6AMP61XuFCNDiEvCppQqVkW3mNjlFAsezCWRNtsV7BnCS6+b76++aVofzc/M+
         1/PuTKPo4AN2ehciYmcVs+c4wOF8Lc7DKg0Ajju5fH4A4DisjFHmFUhd+UyPIpB2Xlf8
         yEQFCFL4hL4VKc3Do3y7gV6BRjlVY7DIQzZ80G7cteGjjZy2thtmQUMleBia7z4zuxMK
         rUafbQp9PhvRWSj0XE7HF38TlDhjvgZ1OnnwxqyDCUW2N4Od73S4/GoneKHMjkmk+uiv
         Axfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733385378; x=1733990178;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fVMKeG2BU1k+f8hZOsNmEcpXp9HT7LYkGQByxGZdszQ=;
        b=Wc8DSqAK3ElucMPcH6rNf59NIkTas+NQtAxK4rjKWEUgHzKtCK0BDxduZq7UdwfDZm
         c8wDmwZIu0vl7DzlILuF8l5Kjm1ef860ZYlCvrbEGoWvqVaWWJ96og6iagWvci5DwK3z
         9L2ojkfiHA9lZrfIG3EKJ3adqFMLtzd2eesz/fSR/5NFWwxU1MBpj8Vk9nCkIY7fgmNg
         GOWm1bWkxApEctIKEDOqfuFXg0X49q/DKTM+JxzEPm+eG80F7Q6Cjrsu+PU9HiCJeMt9
         qQhTQdqp0DZXD70ahOL1k2Tr6wTII4eRqqtcNVpAdxW0GHZCBlwKXR7Ch0310ii9WNFN
         V7CQ==
X-Gm-Message-State: AOJu0YwR5NhubF7NBM2zYjB24Od+I8lMTpwFHCcvaIh4FlEBCc/fg/iq
	p/fvDtxAq8tx7bvUEpXr+mK8USXMebaeuUIDT8jJujNq5oMuB1fHl2feIg==
X-Gm-Gg: ASbGncsgYkxWBOLm2DT4XWiGMZnSxXKJr1xgkusrpxITG9HElM8tUK6wuOFAgS2ILAa
	ZNjNxYzEHtMW139FqavNZyglG0II3DkNrU4H+IfCr42tFcYQNSzADNJLb4Ra6TFlWo7zij9ySPh
	e74ZIx3M07GPrAJZD+HdNhi8urJlD8eq8y082ut9cMqkpk3qoayctImECFEiqUb/AIYfQKUurnj
	Uw8SGhCInM2Du0BbJ9bZ51O4TzKGTpjuOw1iB/viekfRV7L6tgdzaMd
X-Google-Smtp-Source: AGHT+IHYRL10on5SzE4++kyXOXd3z+HVORIKOaaZvOTUPh4DimzzC76bgufEJw5lNF2KTBw/Qxx3dQ==
X-Received: by 2002:a05:620a:3188:b0:7a6:75e6:3c21 with SMTP id af79cd13be357-7b6b414c1d4mr330688285a.1.1733385377996;
        Wed, 04 Dec 2024 23:56:17 -0800 (PST)
Received: from [172.17.0.2] ([20.97.191.134])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46729793741sm5271221cf.61.2024.12.04.23.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 23:56:17 -0800 (PST)
Message-ID: <67515ca1.c80a0220.2d1dc2.139e@mx.google.com>
Date: Wed, 04 Dec 2024 23:56:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0403561784702348346=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, en-wei.wu@canonical.com
Subject: RE: Bluetooth: btusb: Fix QCA dump packet handling and improve SKB safety
In-Reply-To: <20241205071727.36710-2-en-wei.wu@canonical.com>
References: <20241205071727.36710-2-en-wei.wu@canonical.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0403561784702348346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=914799

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.19 seconds
SubjectPrefix                 PASS      0.22 seconds
BuildKernel                   PASS      25.86 seconds
CheckAllWarning               PASS      27.05 seconds
CheckSparse                   PASS      30.47 seconds
BuildKernel32                 PASS      24.19 seconds
TestRunnerSetup               PASS      434.56 seconds
TestRunner_l2cap-tester       PASS      20.49 seconds
TestRunner_iso-tester         FAIL      34.54 seconds
TestRunner_bnep-tester        PASS      4.87 seconds
TestRunner_mgmt-tester        PASS      121.33 seconds
TestRunner_rfcomm-tester      PASS      7.74 seconds
TestRunner_sco-tester         PASS      9.38 seconds
TestRunner_ioctl-tester       PASS      8.20 seconds
TestRunner_mesh-tester        PASS      6.11 seconds
TestRunner_smp-tester         PASS      6.94 seconds
TestRunner_userchan-tester    PASS      5.06 seconds
IncrementalBuild              PENDING   0.39 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
Total: 125, Passed: 120 (96.0%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       4.258 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0403561784702348346==--
