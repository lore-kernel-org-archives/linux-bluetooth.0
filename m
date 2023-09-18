Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1191C46CA1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Sep 2023 16:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjIRQnm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Sep 2023 12:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjIRQnT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Sep 2023 12:43:19 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313913C3A
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Sep 2023 09:41:38 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-34df2a961a0so16671905ab.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Sep 2023 09:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695055297; x=1695660097; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K3R+3hlNOdgMvG+3mi3EbKmj+m7LkDX0Y8Bv1pJCfYc=;
        b=V+N9VqQqQozuB+7hZ/ccAq1XJBg2c7W38T+YfILUXMAY5aFtaRhWAnIGMynP2ihPf7
         fswpWnbtZDfjx9xSI67jNQNmhvXuQjjBi6cQxkxX/Ns/lHLxbnu0sc99YSstNdOI/gL/
         y2ipbKIuyJ0MYOiYUyT2RaQWxdMWdNUslMMQNjUGJaMlpBEocV4i7CSZPR3oAaNui7B5
         Lw0r/GktUYqUwPsYyoIpbfziU2eaI/yZSlnq17HM/mU6uMTJuR8fKKTIeIBMFNEHrmkL
         sPWa9ywzisnemZITann2LTkzEElU3SyU+UeUkdTe+BDzxAx7xscLwcVmzVZK4Ad5jFMi
         tBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695055297; x=1695660097;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K3R+3hlNOdgMvG+3mi3EbKmj+m7LkDX0Y8Bv1pJCfYc=;
        b=i2CmvkFPZv+cgQr2lK67Eo2KtrGacMCGj+/Opvin78Rg10m5hSD+yAmEG4m3cUJewX
         QJJiWoH7iskLje+TDbFcUt94OROxGFAg2QFvbOkM6flypQjiF0BWwFy4t+kCoNfZmT9R
         KUFm3F0orAAaH6nbk+m54vsAzLqEwdQCg2vnhIaSQ7R0DQ2Eb9slRFrsySrn9+HHx1Yt
         pOhzA5lr/Nk9NWZCrlik0n7sxWU7CJd3hhJa1cLcyxoBGPm5CYfgbQf4BLI6mQquFzt9
         /bDDBo4CtVRDt7DyWo+BQTQiC7Vw7WUFOZL93HzULHvPMMgj6BxebHm66OmaR6Tw7mQj
         7sLQ==
X-Gm-Message-State: AOJu0YxwSc2eK4QjrOpSBSXWQZCFDL+JFKtpQMU8xdFNQ7KYXaioZg9j
        rCnoOzAe/bMywJXnK3g4gRcXiCG+4d8=
X-Google-Smtp-Source: AGHT+IGolSG6ahjATiqVaRpMJwqk/7G5/czVuUfFJDFTivkM8Vthpm9Tb9fwIItYINyawPtMDmH72g==
X-Received: by 2002:a05:6e02:152:b0:34f:b296:168d with SMTP id j18-20020a056e02015200b0034fb296168dmr11463002ilr.26.1695055297178;
        Mon, 18 Sep 2023 09:41:37 -0700 (PDT)
Received: from [172.17.0.2] ([40.122.243.91])
        by smtp.gmail.com with ESMTPSA id b3-20020a920b03000000b0034f4f8e43d8sm1188503ilf.36.2023.09.18.09.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 09:41:36 -0700 (PDT)
Message-ID: <65087dc0.920a0220.d48f7.11b0@mx.google.com>
Date:   Mon, 18 Sep 2023 09:41:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3175642460635643252=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ilpo.jarvinen@linux.intel.com
Subject: RE: PCI/ASPM: Make ASPM in core robust and remove driver workarounds
In-Reply-To: <20230918131103.24119-2-ilpo.jarvinen@linux.intel.com>
References: <20230918131103.24119-2-ilpo.jarvinen@linux.intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3175642460635643252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=785259

---Test result---

Test Summary:
CheckPatch                    FAIL      9.87 seconds
GitLint                       FAIL      3.51 seconds
SubjectPrefix                 FAIL      1.40 seconds
BuildKernel                   PASS      34.49 seconds
CheckAllWarning               PASS      38.59 seconds
CheckSparse                   PASS      43.62 seconds
CheckSmatch                   PASS      115.93 seconds
BuildKernel32                 PASS      33.25 seconds
TestRunnerSetup               PASS      506.78 seconds
TestRunner_l2cap-tester       PASS      31.00 seconds
TestRunner_iso-tester         PASS      52.07 seconds
TestRunner_bnep-tester        PASS      10.59 seconds
TestRunner_mgmt-tester        PASS      222.47 seconds
TestRunner_rfcomm-tester      PASS      16.18 seconds
TestRunner_sco-tester         PASS      19.55 seconds
TestRunner_ioctl-tester       PASS      18.32 seconds
TestRunner_mesh-tester        PASS      13.60 seconds
TestRunner_smp-tester         PASS      14.51 seconds
TestRunner_userchan-tester    PASS      11.44 seconds
IncrementalBuild              PASS      79.48 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,03/13] PCI/ASPM: Disable ASPM when driver requests it
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#188: 
new file mode 100644

total: 0 errors, 1 warnings, 141 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13389910.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,07/13] mt76: Remove unreliable pci_disable_link_state() workaround
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#226: 
deleted file mode 100644

total: 0 errors, 1 warnings, 62 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13389913.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,01/13] PCI/ASPM: Rename pci_enable_link_state() to pci_set_default_link_state()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (83>80): "[v2,01/13] PCI/ASPM: Rename pci_enable_link_state() to pci_set_default_link_state()"
[v2,03/13] PCI/ASPM: Disable ASPM when driver requests it

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
33: B1 Line exceeds max length (101>80): "Link: https://lore.kernel.org/all/CANUX_P3F5YhbZX3WGU-j1AGpbXb_T9Bis2ErhvKkFMtDvzatVQ@mail.gmail.com/"
34: B1 Line exceeds max length (87>80): "Link: https://lore.kernel.org/all/20230511131441.45704-1-ilpo.jarvinen@linux.intel.com/"
[v2,08/13] e1000e: Remove unreliable pci_disable_link_state{,_locked}() workaround

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (82>80): "[v2,08/13] e1000e: Remove unreliable pci_disable_link_state{,_locked}() workaround"
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
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============3175642460635643252==--
