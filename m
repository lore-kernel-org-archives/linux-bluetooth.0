Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E363274413
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 19:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722454419; cv=none; b=i9BkTLIjyVOn1FWRxr8a7KVh8lH3AYHebBBTgKiCRQCJb/QWrtDQGLtvaA/Zui7SZM+EBO6pp83buKQuLhDyxdfHMpW/mxn/w54oJRHHP+WCI4rLAmJcNyLGPDacXq0GUiXeJkLXnmtElTNExQHkPicPaSfxWP8nXQGm8YAeEco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722454419; c=relaxed/simple;
	bh=MKzKxBdiK8CV1g79MaTkH39XftNOhPUICgBvyNflXXk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LCuzGuGFumVwcdpkjgHjshQDY6IWBHcciMNAhYzDGwgPokxvkxj5Up7qWrVA1C3wBNjhc/zHCgbFzsd0nkg2jzla3J5L1PRL9vnAJn5fjI7CGrTzPytgpxA+b6Am1J1E1a4/V3bqsw8vlZdRpqB0SX4okvWXxzSSMiTfqppiR+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7o0gjaE; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7o0gjaE"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3db18c4927bso3279645b6e.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 12:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722454417; x=1723059217; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IGrdH5WWLL4HB1BWbcxs6hPQMIa/mynPC1NqLMNKqVM=;
        b=E7o0gjaE3IX1dYg3+T0hQl2lIZqdZ2i97c5+gb9zhGylCoIHkav9wycfbnZMDyoyVw
         7vhks8UXKEt3grn+dY/Cb6IOCCbwOwfeh2sVk42Yn+90FLfCRjGtLwEzhYGbBsNQ+463
         tbEq2ThI22BuNcyrUV4tnJgWYxS+gaIkP8dPCa9VgZv0FiN7JNUD6mGrCLCkdFEX0dQz
         LWGPkbBiVE4JA+95QbybjwyrlINSjmragX1y7jyRI5/dcy9f8e6CEk8M55t64MHaa5MG
         8nZ2+D9Vqb/iKQ9KNpbRt+lBNi50Xt/Izx8aOGQpJLyfP9vB9FJrT3UOb5KftLJuWrz9
         cpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722454417; x=1723059217;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IGrdH5WWLL4HB1BWbcxs6hPQMIa/mynPC1NqLMNKqVM=;
        b=IZbO86CBaY6n4APr8BDdJhSXdaNMBGt+6v2ajeX9XOb7uNHXgYDL2zI8Rvs6Tnh6oW
         2/LT6zkgtw2LMY438E0vuorrzrpR8jxV4/o5fjVNj7lqWq4XZqE7p317PUGHDOxZEw2n
         BCzIjN8PGOU9vWQ/HRs59Yf5Fe8A9Jq4MDJKTEopxoxgQ18Hii5Oybu+CX9dwX9lPSiI
         MKPtiR8DZ4m9igsROzNhpLKzWyICq+EfyUeuPSgPmtYxQOBKB4NiiQHTJ06TPSSUKe/G
         y/vh/2x2dEyyctheWzmfrDlQPB9LKk1OBflZCALu0go4qcrT5uSDmlgKAAiw3/vatAHm
         1TPw==
X-Gm-Message-State: AOJu0YwBZQBt0xm/A4rv2nscmgaSNLqBkAKwZ+ar+/V8ett6dq3LZfCa
	LRpQH3wvDV3+DsI5p3ZL8S/owaHcumtbQZVGylSgh5oDbEVpWV2GPdNHSw==
X-Google-Smtp-Source: AGHT+IE+hTNOj7VPmNsRsrlsZCYxHOX//S4tXYMAEs/uacn/YLUWd7B1vTFLQ+wqhXLJy5QcQFMV0g==
X-Received: by 2002:a05:6808:188f:b0:3d9:34c4:1c07 with SMTP id 5614622812f47-3db511c860dmr141390b6e.9.1722454416812;
        Wed, 31 Jul 2024 12:33:36 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.223.39])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe840f8afsm63059991cf.87.2024.07.31.12.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 12:33:36 -0700 (PDT)
Message-ID: <66aa9190.c80a0220.ffa5e.5a57@mx.google.com>
Date: Wed, 31 Jul 2024 12:33:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6382411107317635176=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cascardo@igalia.com
Subject: RE: Bluetooth: btmtk: avoid UAF in btmtk_process_coredump
In-Reply-To: <20240731190330.1619718-1-cascardo@igalia.com>
References: <20240731190330.1619718-1-cascardo@igalia.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6382411107317635176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=875598

---Test result---

Test Summary:
CheckPatch                    FAIL      0.94 seconds
GitLint                       FAIL      0.50 seconds
SubjectPrefix                 PASS      0.83 seconds
BuildKernel                   PASS      30.40 seconds
CheckAllWarning               PASS      45.30 seconds
CheckSparse                   PASS      38.73 seconds
CheckSmatch                   PASS      104.59 seconds
BuildKernel32                 PASS      29.56 seconds
TestRunnerSetup               PASS      539.78 seconds
TestRunner_l2cap-tester       PASS      20.46 seconds
TestRunner_iso-tester         PASS      41.69 seconds
TestRunner_bnep-tester        PASS      5.08 seconds
TestRunner_mgmt-tester        PASS      119.77 seconds
TestRunner_rfcomm-tester      PASS      7.79 seconds
TestRunner_sco-tester         PASS      15.28 seconds
TestRunner_ioctl-tester       PASS      8.33 seconds
TestRunner_mesh-tester        PASS      6.25 seconds
TestRunner_smp-tester         PASS      7.19 seconds
TestRunner_userchan-tester    PASS      5.36 seconds
IncrementalBuild              PASS      28.58 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: btmtk: avoid UAF in btmtk_process_coredump
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#81: 
CPU: 0 PID: 82 Comm: kworker/0:3 Tainted: G     U             6.6.40-lockdep-03464-g1d8b4eb3060e #1 b0b3c1cc0c842735643fb411799d97921d1f688c

total: 0 errors, 1 warnings, 37 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13749065.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: btmtk: avoid UAF in btmtk_process_coredump

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
10: B1 Line exceeds max length (140>80): "CPU: 0 PID: 82 Comm: kworker/0:3 Tainted: G     U             6.6.40-lockdep-03464-g1d8b4eb3060e #1 b0b3c1cc0c842735643fb411799d97921d1f688c"
11: B1 Line exceeds max length (90>80): "Hardware name: Google Yaviks_Ufs/Yaviks_Ufs, BIOS Google_Yaviks_Ufs.15217.552.0 05/07/2024"
18: B1 Line exceeds max length (84>80): " btmtk_process_coredump+0x2a7/0x2d0 [btmtk 03edd567dd71a65958807c95a65db31d433e1d01]"
58: B1 Line exceeds max length (90>80): "page:00000000a174ba93 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x33cfa"


---
Regards,
Linux Bluetooth


--===============6382411107317635176==--
