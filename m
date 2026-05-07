Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF3F31813A
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 18:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778179863; cv=none; b=KU729Gc9m6HJqQ0N/hhOEQkqzIDV/96T35o2FHGU8XPOVDsyAApuKAd6XqdAB5s9SktAAoqvKBXlAlSPciOLQpxYrynbb/iZMegm9AvgaOcZWw0Au+gqpL4b9uPdba+w/VWKBzWZisO5tYqfpRcpQZDda8Wh8m7eHyQUd7g7TQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778179863; c=relaxed/simple;
	bh=sEwT5MMTEMcQ+8TFr7BkIHyarkDAQOpy0qJZeKhxBjA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=omW/L3rFaceHznPhnAV4vpcM9m03tUMvMqk0Dad9jPcJM85ndT/JQmGLSnqFR1WeiVnhNVm+hkLJQpy4DCc5yHCmipcP/ltG9Np41TE18y7KEg0swYA6YBarodU1ky4P35yOHa2LWRpNWuPAdjXlisU3UMnWnZBSu+bOmZKPErg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNLnuZdG; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNLnuZdG"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-685017d0fbcso698917eaf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 May 2026 11:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778179860; x=1778784660; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UBMZVUKxQJDkLeG0SnFagSB0hSReAhnhawgOZU81TD0=;
        b=JNLnuZdGveZ6N3sp7+VIFLwXDGyrgv6zkEU8U/Z4foUop3WqW6IreGT5LfVKQtEI+V
         rlfGnIPaQWigBksFrgnhFHPcz7MapA8DJtexTuAwUSS2zjTfE26Zvl7y/tRnmRXvvcKi
         2ktapNyVj2VowsmtKOZR3+FhmAPSOdxHuC95/I6uT02xHmLaoZdDjFmOFQ6S+R8wRCGT
         d8J15t2wsMMqZWBhibG42j86FCa8+vYmMkKRH6cttbv2QPwkFBOfN7gBDtXO3mw4F6Ss
         utsUL4EEc4IS56YuVFD6bEq/kIW7bS3v0N+di5PzPOFpLqc/xlaAaTOwrQyDVub5Th7v
         DrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778179860; x=1778784660;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBMZVUKxQJDkLeG0SnFagSB0hSReAhnhawgOZU81TD0=;
        b=fEu9/ECa7FSUeET/g5fxdGaPSduzDx0VRRpqOC4LoKVAgrSqJFFWectvyXW7tdeIOE
         jwkMzVvD4yN1Q6cE6DlNsjWXDy+ibQDHKj98z/gq5aBSsNT19Vw6QAI1gfPqvLrl0Wj2
         KjkdMH8pCoUSrC9KafR+PuotpIOiLVdIQuwmloZKMT4EABwhD23MgfpeZvvb7SKTvsBx
         f85z8zkAcQkKY/l5SzTmVolObX3gbF2VDWgXY7S42zJPvSandRSzJey4UAGoxxBph+qb
         3xTLtOmnDpWelPxrVpfrvzMW6JktfyLIW4D19JkAD3/AyL3JTLjcM7SopDt+6zQEfnwD
         niSw==
X-Gm-Message-State: AOJu0YzdrB1PHG5L5VzbmTUvWzngP5twNaZVwRRC7xIQMBH1eCbYrr1Y
	r450IHztNxoAV6HfVKn3bjTWl3cDk1yCZfmwYU/UdOidcr2IIcCnDdHvEACceg==
X-Gm-Gg: AeBDiev1k5g9wTrL35bTtpxaMTMXW8rgI7iZMMDnu9HWq/RY4wANJzwFD5uSmC8WfQI
	uTHKOJticg0ue9BFpRvKR7jTHgrD/MTGKqC+Yhy5lXF4G0uWnGDQKSD7tP+4+ETTWHPNQDYDENJ
	pBqXyd6wry5aI4GHxz/5SiuH/BvP1J2O+nGjPGBzZcSglY6hpnsvF7LlkqzuPDufoWsa1QgvPXs
	bTucCPPE+5ODX87I76CPPR2EyS/gJN2lbSVLptQZGK75Dws+MXGTLAeEHxy/bgxjJS3s6GVbZlS
	b4G13LBbgI6sg8Dg4pnt3tjL954dsLMYldfgku9ryCECGxCYjAMVpD6XA5rz7gw0Z8kr0492IhY
	8hDpgblsCkcL3pQoQZYVZSQ+BT+mwIvnMxuVFI+XLbRpWpUJ+6T2sOZc+2qg+YVG9SyPloEpu0m
	ztmYE5NX1d44vBPFuuZzGRisAGeRE6ZA==
X-Received: by 2002:a05:6820:4b8d:b0:696:1cbd:27ac with SMTP id 006d021491bc7-69998d3021dmr5153035eaf.49.1778179860585;
        Thu, 07 May 2026 11:51:00 -0700 (PDT)
Received: from [172.17.0.2] ([132.196.32.66])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69b20ed507bsm99810eaf.10.2026.05.07.11.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 11:51:00 -0700 (PDT)
Message-ID: <69fcdf14.050a0220.8151c.6082@mx.google.com>
Date: Thu, 07 May 2026 11:51:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9169254390241326973=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, manivannan.sadhasivam@oss.qualcomm.com
Subject: RE: Fixes/improvements for the PCI M.2 power sequencing driver
In-Reply-To: <20260507-pwrseq-m2-bt-v2-1-1740bd478539@oss.qualcomm.com>
References: <20260507-pwrseq-m2-bt-v2-1-1740bd478539@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9169254390241326973==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1091159

---Test result---

Test Summary:
CheckPatch                    PASS      5.83 seconds
GitLint                       FAIL      2.49 seconds
SubjectPrefix                 FAIL      0.89 seconds
BuildKernel                   PASS      27.15 seconds
CheckAllWarning               PASS      29.30 seconds
CheckSparse                   PASS      28.12 seconds
BuildKernel32                 PASS      25.66 seconds
TestRunnerSetup               PASS      566.63 seconds
TestRunner_l2cap-tester       PASS      378.06 seconds
TestRunner_iso-tester         PASS      594.73 seconds
TestRunner_bnep-tester        PASS      18.80 seconds
TestRunner_mgmt-tester        PASS      2022.73 seconds
TestRunner_rfcomm-tester      PASS      63.46 seconds
TestRunner_sco-tester         PASS      141.37 seconds
TestRunner_ioctl-tester       PASS      133.16 seconds
TestRunner_mesh-tester        PASS      59.66 seconds
TestRunner_smp-tester         PASS      17.73 seconds
TestRunner_userchan-tester    PASS      19.19 seconds
TestRunner_6lowpan-tester     PASS      51.12 seconds
IncrementalBuild              PASS      37.89 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,2/9] power: sequencing: pcie-m2: Allow creating serdev for multiple PCI devices

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (83>80): "[v2,2/9] power: sequencing: pcie-m2: Allow creating serdev for multiple PCI devices"
[v2,4/9] power: sequencing: pcie-m2: Create serdev for PCI devices present before probe

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (87>80): "[v2,4/9] power: sequencing: pcie-m2: Create serdev for PCI devices present before probe"
[v2,5/9] power: sequencing: pcie-m2: Create BT node based on the pci_device_id[] table

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (86>80): "[v2,5/9] power: sequencing: pcie-m2: Create BT node based on the pci_device_id[] table"
[v2,8/9] power: sequencing: Add an API to return the pwrseq device's 'dev' pointer

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (82>80): "[v2,8/9] power: sequencing: Add an API to return the pwrseq device's 'dev' pointer"
[v2,9/9] Bluetooth: hci_qca: Set 'bt_en_available' based on W_DISABLE2# presence in M.2 connector

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (97>80): "[v2,9/9] Bluetooth: hci_qca: Set 'bt_en_available' based on W_DISABLE2# presence in M.2 connector"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


https://github.com/bluez/bluetooth-next/pull/153

---
Regards,
Linux Bluetooth


--===============9169254390241326973==--
