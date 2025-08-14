Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4882D4B47
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 10:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755167861; cv=none; b=T6BpAdBgnR8jIJFBg2CsDwJ8E4N18CvVeuO7eNpuvAWMoubpCW80YUDav38sbx+S1C78O3oqcmgkWGBOXROsw8NvKVLdFhdLlnqrI6hLnwXEzSkHbOfdvZ2+UAnVAzSgGWpqfaUX6awgPzVi0Zj8eYz49sqyLdyy0Kp9Ppu5FvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755167861; c=relaxed/simple;
	bh=6vaywVH4J67fBUYJAkjujsT2GCeBxC5sXbpGv5IXAmw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=U0vezoDYtbKmUp3jjvqqaIYe4XB76Iv1lk45jK2UtvP8e48W6m30xZtyBbCBuQljd2Bg7dk/sh+sXalMkKSANztLPnk+CR74goCgCVqjrC981O8wnT3XEp+9RqmSnbRv6NbNxnBsdncjbKwf7Y0ihF0DXmifE06gcw3Og97kbpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjClkZU+; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjClkZU+"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3e5700aa375so5294805ab.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 03:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755167858; x=1755772658; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QZTU4acEO0GWJVbnd9av/BoOgHRVOruBaC4jmsJu2EQ=;
        b=DjClkZU+FIfwNxJ/YledU/yGedC1WN8bgyggwhilh8sJCbzOcx1FMjKgydxe5FXpgz
         SCFzs/IFjRXHeD90xpSoKt0QzyAN1WhUMBp1YUefF+zZO6mx8p4F/DiC3cPXozvi7rWn
         6Ux49hNKtFI/HXnBiEtgEfR5XzZgN9njMyB4dzfa2dY5apT0BgHCa24OcBYPpwRcS5FM
         4TmfDhguaktBlA+UVOOMfBIALjt8PTcyZQNZi0R3ctb5kVkvYWXlgeQBJQJw7zjGwCSo
         ETGCsCRRV8IMa0jbq1BFHjeRh3iqNoiR3rbaB4Sw/8GytiOLiJ+BhG7z6UNo6Prmj0VK
         xI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755167858; x=1755772658;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QZTU4acEO0GWJVbnd9av/BoOgHRVOruBaC4jmsJu2EQ=;
        b=bi6P0r+7hdx5FlhAuAkfnenLrv3lkMyRekf3OGhPbbpngEEps4+uJeegOuqetIvpVj
         pJs3B4TQEyr2ITHEtmwYvZSMBITUAm8FpCid2Pdhl70diXhkfWL7NVidH1DOAMqmdpsB
         s1NPfOxF959MEmKdH04g6Z49t34AFLcpTm5OnS9wnYz6iv4hsQUzSocj6OKVCRMjmwZR
         f2JS56sBl4UVuyAd9ShWsommV0ivDf9vMNPA7/IY9OSj1O62jg7H2PpHhw1PlURn8IJM
         lTGjnElxRNK0tsPlwVgVocqvbk+dgSSddDtslOOyXISV6zNxUcsRZYs5Q97atjJby39H
         47CQ==
X-Gm-Message-State: AOJu0Yy+pDVHO79bbuQP6nGZZY5gHRjhRhjH+Ke0rb9nbVG6CQt98u1V
	Ke6K0ltYFc9vnhgoI5EEW5TCfQ+ACwoMCRC0j1lcDhcc1L8xFvr66fXm8L99+g==
X-Gm-Gg: ASbGnctMCzv2lUAdVK8iCmMEe02DUGmd22KR1PaTSWh8B7mJ9jJybjc8YNlJZw/lbr9
	cMk/xB0rdAVO1FbENmuGq6N3PM3y6vPpIQvKl5vXOEsiHrnZTV/M+q2/IVa95XHvqXAsJj3r4qa
	aYOqbjrt1sPAlJYygZ8Ch8Q2oaiv+JWmuhj8uaIow+4ZF/4g98ax6jcXz9TnVqoEDSBc/yEAjth
	VA/LvQ6Lq3rx1D4w4rAi3NumuqHNt/cIGJ+Dv32lqfw7BebTqGA72245Xnun3YhZcqKJKuzXcmi
	r+AyvHXXjKuyEGOKnaUhIC5xMEVSnVGeQyPGH8uQQwIHLxOg+sF46H4Qbi6TNfMSBIzmibgloEj
	V2BabNIZ4A6Dy4TQuTj60OyvFSPC9
X-Google-Smtp-Source: AGHT+IF6IM1dTeUdFn16t+fHFA/I5cjA/5WZxMw2DRMz96ddPERT6ufDLX9fqsmpEdFEugJL7nmWDQ==
X-Received: by 2002:a05:6e02:2144:b0:3e3:fe52:e576 with SMTP id e9e14a558f8ab-3e570848d59mr46467055ab.9.1755167858239;
        Thu, 14 Aug 2025 03:37:38 -0700 (PDT)
Received: from [172.17.0.2] ([52.173.108.18])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50b357798ecsm1400259173.97.2025.08.14.03.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 03:37:37 -0700 (PDT)
Message-ID: <689dbc71.050a0220.1a641b.29f7@mx.google.com>
Date: Thu, 14 Aug 2025 03:37:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0019073492034834934=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, liujiajia@kylinos.cn
Subject: RE: [v2] Bluetooth: btrtl: fix rtl_dump.fw_version for firmware v2
In-Reply-To: <20250814095739.38343-1-liujiajia@kylinos.cn>
References: <20250814095739.38343-1-liujiajia@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0019073492034834934==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=991430

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      24.04 seconds
CheckAllWarning               PASS      26.63 seconds
CheckSparse                   PASS      30.22 seconds
BuildKernel32                 PASS      24.02 seconds
TestRunnerSetup               PASS      473.93 seconds
TestRunner_l2cap-tester       PASS      24.66 seconds
TestRunner_iso-tester         PASS      39.22 seconds
TestRunner_bnep-tester        PASS      5.97 seconds
TestRunner_mgmt-tester        FAIL      127.05 seconds
TestRunner_rfcomm-tester      PASS      9.30 seconds
TestRunner_sco-tester         PASS      14.61 seconds
TestRunner_ioctl-tester       PASS      15.49 seconds
TestRunner_mesh-tester        FAIL      13.38 seconds
TestRunner_smp-tester         PASS      8.49 seconds
TestRunner_userchan-tester    PASS      6.24 seconds
IncrementalBuild              PENDING   0.80 seconds

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
Total: 490, Passed: 482 (98.4%), Failed: 4, Not Run: 4

Failed Test Cases
Add Ext Advertising - Success 22 (LE -> off, Remove) Failed       0.127 seconds
Set Device ID - Power off and Power on               Failed       0.127 seconds
Set Device ID - SSP off and Power on                 Failed       0.117 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.199 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.107 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0019073492034834934==--
