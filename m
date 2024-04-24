Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B63158D88
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 09:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713951156; cv=none; b=jALqevvDkQVTChhS2WechhLNYUTlWFBxpVdNS/IM601zLmxexiWwMnlpsxCoSO4+CuAdX8WcXvBz2BIBJRztAEwXazYgexZR8urUV5MN6RtXk+ncB+Mjx4XiVEaGRTxVG4kBlHr9+BVA/YgbbZYzR3hIU6OY9dz85uEHbIUV5X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713951156; c=relaxed/simple;
	bh=psBW16JWPdsleZ7LTc+QrvMpsjoaeZLqxWfAgG3gblU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EmOElKvfW9qSTbHWly6UL1X4QpmCIbrlN0kVRgQgY7I032gSuyJ6p5jhZXiKzL64jVdX0a7/+kCQLnSVLfUBSFysc+aICkmKFRnSx//loZV16PeKyzvofhtB75PooEiQR9M3I8mGXP080pyPrTMxGeezP+5l4Ew7nfgl0FG7clA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWCa9oCv; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWCa9oCv"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-61804067da0so65561197b3.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 02:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713951154; x=1714555954; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fdnCB0aW6fdlcvMchecxxhWpHNIBGNUoZyZbniuM+nQ=;
        b=KWCa9oCvfh/CdMTnwmM/k9jZNJVD+3SB4/2XYdvzCoaNBcj1GfshQK2G9q10ZGj9Pl
         F9tLWCM+bsYuvC3aqyxw/eZ6N1Ywh+UNzzLNjh5YoeccOQ5WzK8r+Ly/TXosefKsP/Kz
         nffkIfHzY3JmB3aaHCEuQ/xH+2GxfGQNaCd95af6Oox7YCioudhdUva4qCXARonT2sJr
         SRJulYN8ZzFHphknHKlto1Yv5wbsQ6Y9devlH4dZNpvfQGxBoT8/Ej/xDMLkAJLufDWF
         i5u1fr1JFWVbcGb79jFINlRqqpwN9n4Cr2yRLDq3WzNEl9h9ZFqbfL5bZvGkbVBFbR6h
         IYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713951154; x=1714555954;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fdnCB0aW6fdlcvMchecxxhWpHNIBGNUoZyZbniuM+nQ=;
        b=PHclx5x7GkPULoH9jUQsZjOXqPeKIXARP4DhEx3Gu3YBN/+qQCJCQVRkDkL/kQ27zx
         FvUiHu8HLZ2f9+0IjmI+rosvxsZeApnRy3UDyTImkLWqm57UkQmnwa/VAfsEziih8y+Z
         k4Ru9hzwTd3db1ROm/qMiMcweVVN90RV10WsLG9ER5ndCnJKrKShLOlJFTOWEMIVFxsl
         FWutrPAvnGCoKSac8QMz0w/qhf3QX1se4iazBaamjI2wpoOuUDPeNvmQjmu7mLbLB0Li
         TCon1WlEWKPB4tzU5fBuOfioflUhiELoVpqpIgzHapDEAHqWr/RgAoCxYRDUf2WlmrKP
         8QCg==
X-Gm-Message-State: AOJu0Yzog95ZIsYeLy/2k5rc+gy/kpIGIpwpNK8tJtzsYQ9ZxLri/bmS
	AtGUfYEmqn4JojSsPjIWPJlukYvOGybBj1G36F7uA8WM9CM8F0CXUdUklw==
X-Google-Smtp-Source: AGHT+IHH1YojEgKqFwR7jwYY0c3sNtr1Ho0efmPXPF44xYnZSLODBpj3v00SgtM3yzUeVMG8CoDraw==
X-Received: by 2002:a05:690c:6202:b0:61a:da7e:1f66 with SMTP id hl2-20020a05690c620200b0061ada7e1f66mr2425489ywb.2.1713951154105;
        Wed, 24 Apr 2024 02:32:34 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.98.99])
        by smtp.gmail.com with ESMTPSA id t20-20020a81b514000000b0061ad6e89bdesm2892772ywh.108.2024.04.24.02.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 02:32:33 -0700 (PDT)
Message-ID: <6628d1b1.810a0220.5bec3.e38a@mx.google.com>
Date: Wed, 24 Apr 2024 02:32:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7771317159873514956=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v1] Bluetooth: qca: Correct property enable-gpios handling logic for WCN6750 and WCN6855
In-Reply-To: <1713947712-4307-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1713947712-4307-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7771317159873514956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=847360

---Test result---

Test Summary:
CheckPatch                    PASS      0.58 seconds
GitLint                       FAIL      0.49 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      30.11 seconds
CheckAllWarning               PASS      32.36 seconds
CheckSparse                   PASS      38.10 seconds
CheckSmatch                   FAIL      36.30 seconds
BuildKernel32                 PASS      28.81 seconds
TestRunnerSetup               PASS      527.55 seconds
TestRunner_l2cap-tester       PASS      18.31 seconds
TestRunner_iso-tester         PASS      29.06 seconds
TestRunner_bnep-tester        PASS      4.72 seconds
TestRunner_mgmt-tester        PASS      113.75 seconds
TestRunner_rfcomm-tester      PASS      7.22 seconds
TestRunner_sco-tester         PASS      15.00 seconds
TestRunner_ioctl-tester       PASS      7.72 seconds
TestRunner_mesh-tester        PASS      5.74 seconds
TestRunner_smp-tester         PASS      6.72 seconds
TestRunner_userchan-tester    PASS      4.87 seconds
IncrementalBuild              PASS      28.20 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1] Bluetooth: qca: Correct property enable-gpios handling logic for WCN6750 and WCN6855

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (89>80): "[v1] Bluetooth: qca: Correct property enable-gpios handling logic for WCN6750 and WCN6855"
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


--===============7771317159873514956==--
