Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5119C2FC3C8
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jul 2025 17:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476280; cv=none; b=uChiDylr5X51MDM/ifouaAqs6YpvAfBN7sO5zvY1QR+26czY6TAAySxZzhqBeIaPcAxwr2arSRubtgHaEFi6ZW+Z8BzzfpC/ANkGUYHNMdznLyjKEHTbIKRyYvGuka92mBdwmX5aQQJ6MyYH7uAK3woHe+YeFYsQLEp6csv4FLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476280; c=relaxed/simple;
	bh=t4O0w52E9TxYDcYoracCMsoqTRdL8eXzhewWj3M/HBE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PiG00R8We24PorBDcsatobE1+aVbtjJjGmUlfhj1mdg4A+Hny9FH1466STXicC+Lfiofq4JV4ysZ+ywlEYwEusDNEGNO2rlafA3d1pMdTZNLmcUAIptGoXZZ7LlNhCq4g3imOCiOAlA8wy5MG/M0mT5hE3Xm01R2paCvJQKlkWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGUHlY1B; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGUHlY1B"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-235d6de331fso60967045ad.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Jul 2025 10:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751476278; x=1752081078; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6FyGMRy81HIMcLKdjcG+vzug/y4aacCKZzaExDFxiKQ=;
        b=DGUHlY1Bmvh+7Zuc0WIvnWP8qaxXEpMQ0begAIvHX22zm9rJn9O0F5mghPV5LTXrxv
         a4LuaNHBz4kbnuASr417c0a1u7PW9FIEkMULBAogjgMjUTIJCnQa+n2r51N16bI/v1w0
         8YYb4bVl6Gf1JYV/1M6ifES5zSQSoF4SB2wBMOJZ84lFlau0QgwIqGt/DRHEXW+8SXX1
         PAL3IQB2JsMMOg7ljZfFB6KTTUkGlIwNzVdW2r3zYmut4DRfQmuby6UwnkxyL1DzyYSz
         QXIMLY7dsTNrH9ur6e7P4/KI0S3gJX1neawrtf8L197jOzQvjX8174e34Toi8wI9eBme
         k8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751476278; x=1752081078;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6FyGMRy81HIMcLKdjcG+vzug/y4aacCKZzaExDFxiKQ=;
        b=S2t3paPfc1hqYt4uSzAg3880cMTL3cMf7ZdnC56Hy0CLryRqrAkNwDomUzwVk29Cah
         HuVFA9S//axwDFR5cNSPwuCX0FZv9fqfXjjuTCgVrohSlhptOogyPSyDQufytM3QUGkw
         K5STLJujylW8eBQEyvw67q7r+ZvccpaRvqpc+6lNtdtfYgmql1s4WXmAux+T2Kv+M/m3
         nAPhC/jbFCEDih5OqKQgDisjOcK4LgTr4cRjqIvOT1BkhKkGsuOsLpKez37U5c3OmBoI
         OfoybeNEtOtkz3AHwCZR3vNxDRmcszd1fqSvcV/IwpYNBTw9T5cSaUyYYHdmOjEidh/l
         Htng==
X-Gm-Message-State: AOJu0Yz5//2E2jbKUz3rWi1ebuI6TLjSMH9HRrbt6TtDjozim6a+FTz2
	bCIQh9y6A8Ec6G/ghCl59KVxUcajTgaGTpJKgPhjuJhdf9DV3oorcsHwoWAYKg==
X-Gm-Gg: ASbGnctFhp3kUmHXyylpWmBJvcBALMhVt76nxIRO8JzSZ0QJm7qMZo42SY/Srshhc/E
	da/93QX7sL8f+YLkRBMmvOjSXNClUdF4mmaiheX02J3tuZAL/xZH7DNUBOInqiuK9q20o7cbVlH
	S2WQrRgrv9B0COyPac+Bb8Tr6YDs9FxZoSg0eJnhvaDh2l2Ysr/CCcs4GUyq6t8gyeGr7GvXsKQ
	KU99F3x80ppaUKwm6lA3osbscb4H/QsPEp2VgXzLMTSybqhSidyNqDXNJtGz+T9QpGrYx2rtuew
	MxFPVHKMLQu/KWgx94FYyj76J9YpaAZOFQElpcoGgxj7a4yLzSzglfvWx5ZfpMVzoldcgvIxy8h
	R5Mk=
X-Google-Smtp-Source: AGHT+IHAg4w1pRF8BOxPANIRr58z2IwQcVJ5jk1nhafYK2zeF5C/LIpVwEuIqi7GNjJCkYmLCzN2jA==
X-Received: by 2002:a17:902:fc8f:b0:235:ca87:37ae with SMTP id d9443c01a7336-23c796ac5famr1820785ad.41.1751476278016;
        Wed, 02 Jul 2025 10:11:18 -0700 (PDT)
Received: from [172.17.0.2] ([40.112.151.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39be6fsm143130915ad.106.2025.07.02.10.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 10:11:17 -0700 (PDT)
Message-ID: <68656835.170a0220.2223b5.2204@mx.google.com>
Date: Wed, 02 Jul 2025 10:11:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6368299292757917532=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/2] Bluetooth: SMP: If an unallowed command is received consider it a failure
In-Reply-To: <20250702162352.1374119-1-luiz.dentz@gmail.com>
References: <20250702162352.1374119-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6368299292757917532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=978298

---Test result---

Test Summary:
CheckPatch                    PENDING   0.43 seconds
GitLint                       PENDING   0.36 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      23.93 seconds
CheckAllWarning               PASS      26.32 seconds
CheckSparse                   PASS      29.82 seconds
BuildKernel32                 PASS      23.79 seconds
TestRunnerSetup               PASS      467.34 seconds
TestRunner_l2cap-tester       PASS      25.00 seconds
TestRunner_iso-tester         PASS      40.49 seconds
TestRunner_bnep-tester        PASS      8.11 seconds
TestRunner_mgmt-tester        FAIL      133.43 seconds
TestRunner_rfcomm-tester      PASS      9.24 seconds
TestRunner_sco-tester         PASS      14.50 seconds
TestRunner_ioctl-tester       PASS      10.02 seconds
TestRunner_mesh-tester        FAIL      11.39 seconds
TestRunner_smp-tester         PASS      8.53 seconds
TestRunner_userchan-tester    PASS      6.14 seconds
IncrementalBuild              PENDING   0.64 seconds

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
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.213 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.128 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6368299292757917532==--
