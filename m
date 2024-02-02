Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6B567A15
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Feb 2024 21:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706910981; cv=none; b=DEnk9oDVTHwTomQXyxHnT7EA/l2BASTEiPv0QliZEwWXqiloKXSUi4Qhzn6G/J8oJqdgoVhHa1HJIPDDYuaumpIc0mc4C9KQKkskCZCZ4428rl3wutkeF4RkKUabR6cLc50n20LUe01boybE+1h1BBb7V+9nn9JSM3BomHwkTOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706910981; c=relaxed/simple;
	bh=8ieGhPxMIPOqCdZdaQgPhWu5MMks34HyOlic7Lp7jwE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ogX7ggmyIjr0iwrPui5aCbQCdLhXXd8Y4cbVUFQNWYxrVN0tWmJIUCjEIPdnVRY78zcBOAXhYBFxzS/Jvwa613FCQa2BlgX1PigUGc8EWej3zuetBldvg7lrDWNCtl32paQndt9cYqqVi9vhlgCS7KFZXdM0u8/Pzp3WnauGQ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBrdMN38; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBrdMN38"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-42bfef4912aso7863741cf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Feb 2024 13:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706910979; x=1707515779; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ogFW0lzvbWWvdi5NTJIQUs4cwZJh3bI3JA61DpvLP/w=;
        b=SBrdMN38VfOLZLHSjEIQg9AQU+yZwNFQr02QsgipwuyvbJZJoXpYSQuEnpocWQbw4J
         yMk4cM1vCyj4qxzZfa/5VmbL4DIhLqHcStIMsL+s0EheR30xqPuRCJgehifEj2Jp3vpc
         LCv+VVnxBNRk+A7SRpFH+9CIuOYyqlXfGt0EvMbf6u5qH6Y3JqFq+TPfGOVhTtMoa4tg
         lor7CTQyY/cbbg8StuwB7UOnbzi8lhTMD217ufFHsiaQ/lkavhok2JBEQQ8OwSsRoun/
         qf5Hnr4WSlDJdnjqa89sRb5kU4C1nEAKi0PgaGsAwJ2o9TMmBab3bX1VvKz+tx3K3qOX
         2MWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706910979; x=1707515779;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ogFW0lzvbWWvdi5NTJIQUs4cwZJh3bI3JA61DpvLP/w=;
        b=xDpXR49S8zuOwQ3sYydPG6CmaUs1e6+tdHt98U8TSOiReIHUOwvlFWmLBbyGq9RNpw
         UueBCTy8ok470NP6nYhek3eFJxP1KWLcWeAKE41UaYiS9U6ICOT0K9qTum4CPcaaeGD5
         L1uD01xz6oeMGD7pOT4BffavaBR3HrJGas0+NHybrr9OIE8a4v/OGzSoZRcDX6tCXP33
         7JmgMq5NQOj0N28rS+eRONL/XF17mYM0Gnt8qbk8fRhXa04e3LdnhMJX8DK3hiAF8QaG
         yZFju8xXxf79oHpqq662H/Hxje/AV0EXUhhzKUJq2JmTrs7Xuu+OAdv4tD7RtA7YHJTW
         zA7g==
X-Gm-Message-State: AOJu0YzhHw6jzb+v6VFiuMAyLdfkq4kb6LkYsV9X3Pe3sChIHhTcXjDC
	X4/l/Pnxgc2Q1ViqpbF54OvUWYz3sdb7yiFvs/88GKBzVAjhldVbUi5P5NsY
X-Google-Smtp-Source: AGHT+IHd2wwO9IRkNIj7qLGMN8Twr8L9k1e7JsmLHxqnigLFniGK5m/nT4rpKFOKkrVy0OyvR8agaw==
X-Received: by 2002:ac8:7c55:0:b0:42b:f00d:dfbe with SMTP id o21-20020ac87c55000000b0042bf00ddfbemr3775806qtv.2.1706910978955;
        Fri, 02 Feb 2024 13:56:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWE8Feq6yW3tHcSlBNJ4LNkrmw4AfFWs0YMhLXcYpyMtICtv5yxZ2WDDWoODI6E+83/p52+L6JceTt/DAbpDtVs45w=
Received: from [172.17.0.2] ([20.75.95.209])
        by smtp.gmail.com with ESMTPSA id x24-20020ac87a98000000b0042be1188749sm1192438qtr.81.2024.02.02.13.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 13:56:18 -0800 (PST)
Message-ID: <65bd6502.c80a0220.50610.7a4f@mx.google.com>
Date: Fri, 02 Feb 2024 13:56:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7143622069060065523=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wenst@chromium.org
Subject: RE: bluetooth: mt7921s: Add binding and fixup existing dts
In-Reply-To: <20240126063500.2684087-2-wenst@chromium.org>
References: <20240126063500.2684087-2-wenst@chromium.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7143622069060065523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=820131

---Test result---

Test Summary:
CheckPatch                    PASS      1.53 seconds
GitLint                       FAIL      0.85 seconds
SubjectPrefix                 FAIL      0.42 seconds
BuildKernel                   PASS      27.56 seconds
CheckAllWarning               PASS      30.18 seconds
CheckSparse                   PASS      36.04 seconds
CheckSmatch                   PASS      97.90 seconds
BuildKernel32                 PASS      26.84 seconds
TestRunnerSetup               PASS      498.06 seconds
TestRunner_l2cap-tester       PASS      17.12 seconds
TestRunner_iso-tester         PASS      32.74 seconds
TestRunner_bnep-tester        PASS      4.93 seconds
TestRunner_mgmt-tester        FAIL      109.47 seconds
TestRunner_rfcomm-tester      PASS      7.50 seconds
TestRunner_sco-tester         PASS      11.36 seconds
TestRunner_ioctl-tester       PASS      7.83 seconds
TestRunner_mesh-tester        PASS      5.86 seconds
TestRunner_smp-tester         PASS      9.24 seconds
TestRunner_userchan-tester    PASS      5.05 seconds
IncrementalBuild              PASS      29.82 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,1/2] dt-bindings: net: bluetooth: Add MediaTek MT7921S SDIO Bluetooth

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
23: B1 Line exceeds max length (99>80): " create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml"
[v2,2/2] arm64: dts: mediatek: mt8183-pico6: Fix bluetooth node

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
10: B1 Line exceeds max length (81>80): "Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 486 (97.8%), Failed: 5, Not Run: 6

Failed Test Cases
Read Ext Controller Info 1                           Failed       0.089 seconds
Read Ext Controller Info 2                           Failed       0.096 seconds
Read Ext Controller Info 3                           Failed       0.093 seconds
Read Ext Controller Info 4                           Failed       0.090 seconds
Read Ext Controller Info 5                           Failed       0.111 seconds


---
Regards,
Linux Bluetooth


--===============7143622069060065523==--
