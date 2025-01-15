Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1663F33DB
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2025 16:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736960377; cv=none; b=GlV9szlmwBt3T7cjPbOVfm9ErjNueYlaJWDD7nwkUwzOgoyODVFQNU1evi1T9HGqZLx9xHQ1JYaTvxH6zJTakw94a7DcdKgd2xS81x1Ydh4+EP8KUFyTfWPecQBomhdEzf2hpN9uulXr19o+PaNjkHmjU29OK4DOniQpA/MMSRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736960377; c=relaxed/simple;
	bh=IuKRjy2HoQx7vnqvsWCthZ+yQWGiZXvPlyaVatert5o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PpYREDePiucoWduAAszwNks8eh8qBtpwGreEUXPsXoHRp8xzdF8fi8TSMwMeF6g3/zmUjPF3i601fJ3D1u3iWZjgsE63qKpgZbvv40x0OQ8nOS1VC84/cqktrT7p4GLVhbdyDIDx2i63JEmKp+eqq1/F2HgAqihRkBq6rLgCYho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0fxWBMk; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0fxWBMk"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b9ad0e84e6so663875585a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2025 08:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736960374; x=1737565174; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QGnRxGobFM23OhvI9xTgXdat7IX7QblA35DR+T5f/go=;
        b=G0fxWBMkHZbjqHWR06vOhk27SKjq+95eSDUGGI+fip2AWeaqL3ru/FgVAohq9foXLv
         UslUMMNWLg6vDYLyf9zOo781ErXdWjpnDK/2hkqpgF87Vry/YcR7Nh7CqmFBMsfN+9MZ
         IIYff3bZiJiH8Rh3vMJFoYL7Zg+jEBd14OvYsbqed4+UK2rJRy0I5YFSpTojOdB5/nkW
         DZzx1NVtrmUDCRdwaPRj5Usfm7v5/Wlg9DmQNUakLVPeAimbgaJ65+sLNQnoem5qBxpK
         8FBe1m3eH/J2rWRxdAw4VZI4W2+li874P+jZ6S/iLRdFU5nNKTOjbrKS/SyZO7tHzadP
         n8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736960374; x=1737565174;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QGnRxGobFM23OhvI9xTgXdat7IX7QblA35DR+T5f/go=;
        b=HpPNzv1YBJ5e9O0cnjbnKV0egbMvQ8tjDJ8Al56PdKiJJAJMyo90yOp4LlmrwhsZAU
         rreA5sGN8L8hUYeWxjPfQafpyvXC3YYqkQOa1yr/73XF5tDYHrreaho+dz8WHZkeo5KH
         pmCs74xkXM7I+dAZiWG3JeeaEtiZtD2V5XbMD/eGDfTVNkQXiAutGebVlIlrHr+v2Mtz
         /VSFb8Dmuec2Pu+LNag1A17uaJZLF9CJs4CHgdR0t5XjNZwTLW44Fd3x+Ge+DHOR3nzd
         gMav1pOPcCYYqk91kK4ImGunC+bSdRxpbVAn9X/4rl1D1ymreMkaeC8U16VsFOTvml0M
         i57Q==
X-Gm-Message-State: AOJu0YyEwBKMCye5P92WY8rotPMxBsYImPk1RjeBFRHYpa+D5I2uwans
	Hey1qXo08YwQkkbeF2NoZJZtWW0dMiT4C2NJ3sXiEqc1sjeEkS44eHpCLw==
X-Gm-Gg: ASbGncu/xMZRb1w/Kmr2G33Eg/UtFKqWFDAimpEksT8NC4eUUbhqJOwlI//xVQTb4uX
	8ZkZmWmhWbAfzO+7M5kQG00T42u/HqX/tgBOJjJvkgh5Ro1dkjzXBKX2buzOnN5s1+buOuAc5KW
	5Fz585LWn/wOOFlBvDi+qFZ4WMc0DoGKxJLJTHYp6O0OeRd1jUBT29CmugXUre9B/dYoKH4KGAv
	9QKM/zaYE9DtAIlVdw5FyL5F0UbhsWWLWzqLveLvsykVY4/wgaoOG8fNPgTMWgrKQ==
X-Google-Smtp-Source: AGHT+IG/HbTCrXeV6/buDgHW01GvNcvdDvqccucbUdCLjqwUESZepTgWeMjUdgRB/+BqXpr3QxUZgg==
X-Received: by 2002:a05:620a:4092:b0:7b6:ee6d:fc09 with SMTP id af79cd13be357-7bcd97a6f98mr4558066385a.43.1736960373546;
        Wed, 15 Jan 2025 08:59:33 -0800 (PST)
Received: from [172.17.0.2] ([172.200.183.153])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfade89079sm66433536d6.97.2025.01.15.08.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 08:59:33 -0800 (PST)
Message-ID: <6787e975.0c0a0220.1dfaa3.97d3@mx.google.com>
Date: Wed, 15 Jan 2025 08:59:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7122606312697574559=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v5,1/2] dt-bindings: net: bluetooth: nxp: Add support to set BD address
In-Reply-To: <20250115163846.2385345-1-neeraj.sanjaykale@nxp.com>
References: <20250115163846.2385345-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7122606312697574559==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=925776

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.22 seconds
SubjectPrefix                 FAIL      0.49 seconds
BuildKernel                   PASS      24.59 seconds
CheckAllWarning               PASS      27.59 seconds
CheckSparse                   PASS      31.06 seconds
BuildKernel32                 PASS      24.64 seconds
TestRunnerSetup               PASS      436.57 seconds
TestRunner_l2cap-tester       PASS      20.78 seconds
TestRunner_iso-tester         PASS      37.67 seconds
TestRunner_bnep-tester        PASS      5.41 seconds
TestRunner_mgmt-tester        FAIL      125.38 seconds
TestRunner_rfcomm-tester      PASS      7.71 seconds
TestRunner_sco-tester         PASS      9.60 seconds
TestRunner_ioctl-tester       PASS      8.28 seconds
TestRunner_mesh-tester        PASS      7.08 seconds
TestRunner_smp-tester         PASS      7.09 seconds
TestRunner_userchan-tester    PASS      5.16 seconds
IncrementalBuild              PENDING   0.50 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.166 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.206 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7122606312697574559==--
