Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733D11756E
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 09:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710149618; cv=none; b=i9nPyzU3EpcoQ3FstHTZIgiWdnwUnO/ltY+WHhToV6Y/HF3kPFbzTLX0x7ikZEaG3CGgVPNydZTUJqoFz7V71LGFBV+XW+nmZiJ/pRIvrasbIAw8Cm+mZa2tawNZLLbHHLYBX9qbgt1+Ylb2gRyEKueL0qhqe2NLvEBcgIoUegU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710149618; c=relaxed/simple;
	bh=Bolfai/2oeFssbtQenJG1F6WavjD6bVus1bDoNh7Fhg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=u94wUCGKsQuDsnMXkuqvY4bdTlRIu2u92zEwtS3lVmvy7EeiQX2fO6ib7JODdC10LJQJTUPyG+8M4gQjvGweDjxyN4c5helnwW7HL6IpO/YKCRNn6r75qDCcups3PAduVp8O+fnKCWdwJmQppyVLLe4oUsxVaczsZH7h9co4B7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1ehI8tp; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1ehI8tp"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so2277677276.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 02:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710149615; x=1710754415; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vozbKevAA/P1g6zYXtck8N1zOQ7tA0I4YgJ4j6NyOKw=;
        b=j1ehI8tpA/3encD9Q7zoPfVlW+pzpWB9ZMDB6UPmYTHMr0HZDa1qvk9PUvdL0lJsuD
         Y2jUMHBiIn4Vb51/Ypf9gAZif3AXARO/aGVjoAvOLeaM27CPqiy/RW6HZsFjRXJ7eHJe
         DxX2Rjl+M+JEsauw7MZO0bsEdy+p/x+tF2zG2IbCqmsiQZ/veLAHcezcuAl8NLTD4aLX
         601FT5qIV0VrxBo3sQL7XFUe2Wt77Odw4PYhWlqN5aCMU4NzZVDnx42YMdHnsb+gsKMu
         y3KjyfIfmV61Rw4CE+PWspvIOPdDO6M63SEoLyou6JsX/BcTCPGWekqrpMJZ7JLPTqBz
         DTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710149615; x=1710754415;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vozbKevAA/P1g6zYXtck8N1zOQ7tA0I4YgJ4j6NyOKw=;
        b=h1ofJm1F+dRB/hNXw0dL+RFuMxgR4k78MUr1A2dXlzglk9psJ4OC5QKpQjusSUpDtu
         nhy+eLKP82njMcnNjckeCfg9QrFyMC7ik1W8ZxVLM/qX3f8rFlxTE7014YUt9lw1/7DV
         +BpMXYiBYuqWc9QeQfy3hzJLphNwqbgmL1Ju+3KI10MwoL7zR6A/c6VxGog+KBrFVL69
         ksANqsiQ0+l5EOQ+VgsIZsVyVVGzIVjL1GOSpDlvGmy6aJtVMBvSTHyAtzlHirxUGzcO
         F5XMFvnidH+mTZRp6zevXGkpLxpRWV/qQsRc31rJErhw18nrcaJlobOHZY5PK7qUY3xe
         L2Cw==
X-Gm-Message-State: AOJu0Yy37tdmBSZWBhN7yZm0YqH2qKfIGXIaLA0yI0vH0BqLHOXdp5P+
	rpDtXBNU2mWTPfydQ0Ipy0W6nFiniwepzTypYwoGU1TYejoCBUE6hfZ8dRO0
X-Google-Smtp-Source: AGHT+IH0FA4s6TazpK8mGDhmgOwJsVw6Uvw+JEjxtJF0dIGV5iCsKwDEI1iFlbxyWhduEMjqg+9Mcg==
X-Received: by 2002:a25:acdb:0:b0:dcf:f525:2b81 with SMTP id x27-20020a25acdb000000b00dcff5252b81mr2745707ybd.46.1710149615115;
        Mon, 11 Mar 2024 02:33:35 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.107.192])
        by smtp.gmail.com with ESMTPSA id l7-20020ac848c7000000b0042f4041c24fsm1509298qtr.12.2024.03.11.02.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 02:33:34 -0700 (PDT)
Message-ID: <65eecfee.c80a0220.bb647.3c73@mx.google.com>
Date: Mon, 11 Mar 2024 02:33:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1247638036729063508=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v5,1/2] Bluetooth: btintel: Define macros for image types
In-Reply-To: <20240311084626.402325-1-kiran.k@intel.com>
References: <20240311084626.402325-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1247638036729063508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=834216

---Test result---

Test Summary:
CheckPatch                    FAIL      1.90 seconds
GitLint                       FAIL      0.82 seconds
SubjectPrefix                 PASS      0.21 seconds
BuildKernel                   PASS      26.85 seconds
CheckAllWarning               PASS      30.21 seconds
CheckSparse                   PASS      35.73 seconds
CheckSmatch                   PASS      96.96 seconds
BuildKernel32                 PASS      25.72 seconds
TestRunnerSetup               PASS      485.01 seconds
TestRunner_l2cap-tester       PASS      17.43 seconds
TestRunner_iso-tester         PASS      29.07 seconds
TestRunner_bnep-tester        PASS      4.47 seconds
TestRunner_mgmt-tester        PASS      107.17 seconds
TestRunner_rfcomm-tester      PASS      7.07 seconds
TestRunner_sco-tester         PASS      14.63 seconds
TestRunner_ioctl-tester       PASS      7.36 seconds
TestRunner_mesh-tester        PASS      5.79 seconds
TestRunner_smp-tester         PASS      6.49 seconds
TestRunner_userchan-tester    PASS      4.66 seconds
IncrementalBuild              PASS      31.11 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v5,2/2] Bluetooth: btintel: Add support to download intermediate loader
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#80: 
Intermediate bootloader (IML) image. IML gives flexibility to fix issues as its

total: 0 errors, 1 warnings, 69 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13588355.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v5,2/2] Bluetooth: btintel: Add support to download intermediate loader

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
24: B1 Line exceeds max length (81>80): "[13.458075] Bluetooth: hci0: Bootloader timestamp 2022.46 buildtype 1 build 26590"


---
Regards,
Linux Bluetooth


--===============1247638036729063508==--
