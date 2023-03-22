Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10126C6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Mar 2023 12:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjCVMDB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Mar 2023 08:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjCVMC7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Mar 2023 08:02:59 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E10D9
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Mar 2023 05:02:55 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id kq3so6644287plb.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Mar 2023 05:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679486575;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CqW/mmm/SL3u+EvmI+e3yf4Mb6kNFu06DICPryAgGM0=;
        b=FeMkSDLEDKllZm9nU/v+YSaZsDzzLW1cZR1nZY3JaGAL6o/ALcAVGQvx+2M5LGECVP
         IckpQDm/hnaLIJySZpd5M4+jQG+/uG93if5yw7iSgixrr5J/e+6IRNb67qqcoeYWRmES
         aoOJ8+OuVEHjzKSPAEXjW5zXZbtJFuuzTOiyDqdH/PY/soa0YqMSgZ9iD6bQA3ULM1i7
         eG9bB63kZRSv/hgB2RXBbLGffz78ueRXR2LjscN50/UnfS+5GviYf+XY2nbJQ8/ztJoQ
         M6gWa2NjLmfeibDYQCtxXJ/XVpGxAmrDddl+e017eVDdTBD1rmusNiMHczSyvTc/vL/o
         TPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679486575;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CqW/mmm/SL3u+EvmI+e3yf4Mb6kNFu06DICPryAgGM0=;
        b=ZBR0A09DO2rcZqftY6m733hmU0Bi53a5V6ZSRYxIBDL3bbgR381Tpo1hMkPQL+8UYp
         XuA3eOHDYy4DGdR3E+Eg52LN2G4bpd0U0eynYAzrFxcMeEUJpXaEoYWOBg/1zFfTj+LX
         XpUToy/15PVg5KAU6XtpQu6YitwhEtZANlxiGmOb/LEvFgQUAd95EIIZOMCyCF8xg0kw
         F2p+Yv07mJ69TxAtVTrP+Pi4JwzuqYmFMVozz3wPnp/Dm/GoIKkoMuClx5zAug37TdGY
         DcrGnmsioLrCYPT4WrEp8QBq4fKbluzhrGTYqhYYfAhqLU7kH9TKQNryQ1NxnN8oxZBO
         cwag==
X-Gm-Message-State: AO0yUKUKah9hfenxhxv/P2yHlv8TTax4m5blythRVudOA0D0tGPQhprJ
        fXWm/3CPJQkpb63j9c4pXPEwLdaiYlQ=
X-Google-Smtp-Source: AK7set9xdJTidwo1cNOPxGYhy/wdqSb8l1Kt7FuSKXIQVurb19s/zy+nMaPwJG/eIES8aL1bm98k1g==
X-Received: by 2002:a17:90b:4a89:b0:23f:a810:c07b with SMTP id lp9-20020a17090b4a8900b0023fa810c07bmr3388765pjb.43.1679486575021;
        Wed, 22 Mar 2023 05:02:55 -0700 (PDT)
Received: from [172.17.0.2] ([138.91.227.59])
        by smtp.gmail.com with ESMTPSA id ay16-20020a17090b031000b0023c8a23005asm9315092pjb.49.2023.03.22.05.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 05:02:54 -0700 (PDT)
Message-ID: <641aee6e.170a0220.f188f.ff1b@mx.google.com>
Date:   Wed, 22 Mar 2023 05:02:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3945022428231314526=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, arnd@kernel.org
Subject: RE: Bluetooth: NXP: select CONFIG_CRC8
In-Reply-To: <20230322111636.1028838-1-arnd@kernel.org>
References: <20230322111636.1028838-1-arnd@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3945022428231314526==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=732709

---Test result---

Test Summary:
CheckPatch                    FAIL      0.98 seconds
GitLint                       FAIL      0.63 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      43.10 seconds
CheckAllWarning               PASS      47.43 seconds
CheckSparse                   PASS      52.54 seconds
CheckSmatch                   PASS      143.76 seconds
BuildKernel32                 PASS      41.96 seconds
TestRunnerSetup               PASS      610.65 seconds
TestRunner_l2cap-tester       PASS      21.65 seconds
TestRunner_iso-tester         PASS      23.98 seconds
TestRunner_bnep-tester        PASS      7.63 seconds
TestRunner_mgmt-tester        PASS      141.46 seconds
TestRunner_rfcomm-tester      PASS      12.49 seconds
TestRunner_sco-tester         PASS      11.10 seconds
TestRunner_ioctl-tester       PASS      13.67 seconds
TestRunner_mesh-tester        PASS      9.76 seconds
TestRunner_smp-tester         PASS      10.49 seconds
TestRunner_userchan-tester    PASS      7.86 seconds
IncrementalBuild              PASS      38.89 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: NXP: select CONFIG_CRC8
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#66: 
>>>               drivers/bluetooth/btnxpuart.o:(nxp_serdev_probe) in archive vmlinux.a

total: 0 errors, 1 warnings, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13183936.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: NXP: select CONFIG_CRC8

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
9: B1 Line exceeds max length (87>80): ">>>               drivers/bluetooth/btnxpuart.o:(nxp_serdev_probe) in archive vmlinux.a"
12: B1 Line exceeds max length (83>80): ">>>               drivers/bluetooth/btnxpuart.o:(nxp_send_ack) in archive vmlinux.a"


---
Regards,
Linux Bluetooth


--===============3945022428231314526==--
