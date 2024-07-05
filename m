Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236CA4D11B
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 02:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720146299; cv=none; b=ZMw79OtWCl0DipU78QjHcg2tkDBeqlzi0eaQ0Bmprn+ya+7S9fFEwFHBoZ6bB4bmcv4c5lB/L/DLjHKHOlsrgaeVzyhyS5gT8EoR3ZCQUwzUTv6WZBGw6P6L2TbMEeFpZ94gQizSwvgO4u1ZuvgMlipv86JyIf5RWpYi9sPGdrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720146299; c=relaxed/simple;
	bh=QEDHhQWCMdwYyqLQao5M6FLXrLgZIfn28oazzCmyN9Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VQtclH0QET+Hr0VtpumvZGGUCa80XbVPcCF8OifhJXEZHTcLxSNN0phR4hmGSBnRCSBvHcZkZbaKXPmCgOhEnW0DNoAQ1yKbJwCaNEbJ7ihr2INIwMYJnXBeV5rUOPHhdObSazCHQtDxfrjuiitCtRIc+G75DNkQ6A4bn0xkWlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAAfZf8T; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAAfZf8T"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b5eb69e04cso6952506d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jul 2024 19:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720146297; x=1720751097; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lumMmO8pKb1HNfCHgZ0BVvI0o1O2h1Ym2CwD/OUHMIY=;
        b=EAAfZf8TNO9ohw2ILQFsO28BnAXAsWr1m8LrbhF+NCVgruVBANreUmhHPMV7/GN7J9
         jYw8eUJtL1xeMcItbfEabb0WKzmmr2Ks/tpVL1JuEpPqZYlyCo3lpR/A5KkpZwsUiGFQ
         HtAt6L/qNvI9h8kpeN5hcG3UROFYpQJ6p6UsKtQBdX8V9aNUjbwkFrzZY3rIYFfD4vLQ
         ib9dRYIvqPhlfIL97il3vMJQuqZarKezAruupOGz26LCY/4MzsM2fitQvr3/s/sLHPe7
         tWqZ6zNPDtXjaqV7JWr4ae1q0J9PTtIMXn5kIcBoa8lKnWnXv0tbgRKSwq0S86YA35wm
         6m8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720146297; x=1720751097;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lumMmO8pKb1HNfCHgZ0BVvI0o1O2h1Ym2CwD/OUHMIY=;
        b=C3jDKSTz1aTvQrus4vFDPvIrY1gexmAW7M9x1IDhDh2r7YWELLE85lP+HNZg8wjKRa
         H0AOi8ZCBx+WP0sHqBwMK+cW5LGFrhpXqcoeD49pkwpjUdBwuwEcMj0lbt+Ru0cgBkX7
         zrs2y5sbVw/ssRthNhKGph+YzCATUJOoXkj5pRCRovVz3Lk0AWPfyuRjzwjZAmxKjrHk
         cTe9j/a8YEaRGgucCWvT/t9O+cBZr7g6Q87cjXxqgyTgcmqfKTtRToGusG148A5HV7tU
         C9gFnN0TJ1kLOH6kJE4yC5QE0myP19cV+wBSTNOgeZ1esuafEzuKuG7SSFoO87Fvx7Dt
         eWqw==
X-Gm-Message-State: AOJu0YxmAEhmqv6dqdTsGrsuHDrqi5yVp6yCBXjQknQBIWS5NPOHiqnU
	MCwQ2+kFcrfbpeYmz4/vebTiZRJQshUhP8RCy+6OOJ0sy6rNVqDIUzNC/A==
X-Google-Smtp-Source: AGHT+IE5723s5SiArwpQKcBR5bDi5/8QkpIFIW5LGkqJPyj4DvDYeDhxM0YxLiB8tRcJFoEa7jImCw==
X-Received: by 2002:a05:6214:2b0e:b0:6b5:420:bffc with SMTP id 6a1803df08f44-6b5ecfd65e2mr31336826d6.29.1720146296892;
        Thu, 04 Jul 2024 19:24:56 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.111.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44651408a27sm65156341cf.25.2024.07.04.19.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 19:24:56 -0700 (PDT)
Message-ID: <66875978.c80a0220.13411.aae4@mx.google.com>
Date: Thu, 04 Jul 2024 19:24:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0196393285344029867=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, Nobuaki.Tsunashima@infineon.com
Subject: RE: [v5] Bluetooth: btbcm: Apply HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER to CYW4373
In-Reply-To: <20240705011525.402650-1-nobuaki.tsunashima@infineon.com>
References: <20240705011525.402650-1-nobuaki.tsunashima@infineon.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0196393285344029867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=868600

---Test result---

Test Summary:
CheckPatch                    PASS      0.95 seconds
GitLint                       FAIL      0.50 seconds
SubjectPrefix                 PASS      0.22 seconds
BuildKernel                   PASS      29.73 seconds
CheckAllWarning               PASS      32.67 seconds
CheckSparse                   PASS      38.10 seconds
CheckSmatch                   PASS      107.93 seconds
BuildKernel32                 PASS      36.90 seconds
TestRunnerSetup               PASS      527.27 seconds
TestRunner_l2cap-tester       PASS      22.11 seconds
TestRunner_iso-tester         PASS      37.77 seconds
TestRunner_bnep-tester        PASS      4.86 seconds
TestRunner_mgmt-tester        PASS      112.17 seconds
TestRunner_rfcomm-tester      PASS      7.53 seconds
TestRunner_sco-tester         PASS      23.65 seconds
TestRunner_ioctl-tester       PASS      8.17 seconds
TestRunner_mesh-tester        PASS      6.05 seconds
TestRunner_smp-tester         PASS      7.04 seconds
TestRunner_userchan-tester    PASS      5.06 seconds
IncrementalBuild              PASS      28.16 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v5] Bluetooth: btbcm: Apply HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER to CYW4373

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
24: B1 Line exceeds max length (82>80): "V2 -> V3: Fix a few coding style warnings and change the subject as more specific."


---
Regards,
Linux Bluetooth


--===============0196393285344029867==--
