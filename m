Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AE5C77B78
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 May 2023 14:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjECOio (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 May 2023 10:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjECOij (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 May 2023 10:38:39 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1E16A53
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 May 2023 07:38:34 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6434e65d808so536240b3a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 May 2023 07:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683124713; x=1685716713;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8gz1V56nxTxeYMCJ7M0zWqOb5kJKyDmXXlMDCngOgPk=;
        b=f7zBACvuAbm9Q/QFXz3E3/A9L1v2YSK/6YuByClHJXPIE1NN6v8OHfpls8V11Nyt9s
         rSkDVbL8AwuSSVnxc+OmyX69XoTzMQVMgb/W1MV6e9yokpgfbFIlLXVrNq5TKxF6pRmR
         LJax8W4la1xF43Mz96d6K7qbh0D4GuBhP8avpF4/eAwPHyVcCPIMnJ0kyqdrKdZeAjHG
         DuSETziKPrqSlWV9f2CAzBnk7gU7HrZU4x07eJ97K7RZ8kBYQPLUfS6PoAJ8DuEAychO
         G4rhkxfnBxPCNJYeLRMmJzOezL/q+323/fCHcPgiYfr1DPXkAmgDmVtLY3lsN2v4wKOA
         rf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683124713; x=1685716713;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8gz1V56nxTxeYMCJ7M0zWqOb5kJKyDmXXlMDCngOgPk=;
        b=MUXdorMSVEwsBGjh3Mppb3JhRGu/k9ts1AtckvmUMS3U9NAMuYpdhcyEEYVkTYOkud
         GAmXQXxwy/rdWBFDVM/KtXzZ13Dsqkktfb0QiJ1zhVLXbn1HLirT77f447+1SEOyfJSm
         JUjfpFk9sHWcmUFUVFNKntGX2iTt/QYp+UO+p4JX7adcS+FD6YQyh4r/3SfXjEV77nKQ
         7yOYDCZDF+eAMg8joUg1nepjFxJPqHq1BH7H1h9QxS8EZbi0MaeH3k8OhUiBwDVDtqjH
         8Gn5lBMneYB+c/Es9/v0sn9xPGiBJofYRy1+tU3/lB3Ysdwn4FBRn4wkU1sb34/vm9qE
         mJqQ==
X-Gm-Message-State: AC+VfDxIZjCpnhORpbfGsSkn/P5OOMrX7Q0tcwsk6PNfJEvuKwGWAv8n
        u6WQUaEM4uTQDzxIpLlS0l78mcdNoII=
X-Google-Smtp-Source: ACHHUZ7o4aSMxgJ3kfG+iyqgEkKVelCs194YmzF2na3R4yzFsXbKaDkHswuHZKAaEkIaLOfcIVg3rA==
X-Received: by 2002:a05:6a20:3d03:b0:ee:f25e:925f with SMTP id y3-20020a056a203d0300b000eef25e925fmr27757049pzi.53.1683124713305;
        Wed, 03 May 2023 07:38:33 -0700 (PDT)
Received: from [172.17.0.2] ([13.86.156.40])
        by smtp.gmail.com with ESMTPSA id j9-20020a056a00234900b0063d3d776910sm23687284pfj.138.2023.05.03.07.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 07:38:33 -0700 (PDT)
Message-ID: <645271e9.050a0220.cc54e.ebee@mx.google.com>
Date:   Wed, 03 May 2023 07:38:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4960715534021635129=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, lrh2000@pku.edu.cn
Subject: RE: [v4,1/4] Bluetooth: Fix potential double free caused by hci_conn_unlink
In-Reply-To: <20230503133937.169647-1-lrh2000@pku.edu.cn>
References: <20230503133937.169647-1-lrh2000@pku.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4960715534021635129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=744697

---Test result---

Test Summary:
CheckPatch                    FAIL      3.22 seconds
GitLint                       FAIL      1.40 seconds
SubjectPrefix                 PASS      0.28 seconds
BuildKernel                   PASS      43.05 seconds
CheckAllWarning               PASS      46.73 seconds
CheckSparse                   PASS      54.02 seconds
CheckSmatch                   PASS      143.56 seconds
BuildKernel32                 PASS      42.36 seconds
TestRunnerSetup               PASS      597.83 seconds
TestRunner_l2cap-tester       PASS      21.30 seconds
TestRunner_iso-tester         PASS      28.00 seconds
TestRunner_bnep-tester        PASS      7.24 seconds
TestRunner_mgmt-tester        PASS      146.36 seconds
TestRunner_rfcomm-tester      PASS      11.56 seconds
TestRunner_sco-tester         PASS      10.86 seconds
TestRunner_ioctl-tester       PASS      13.13 seconds
TestRunner_mesh-tester        PASS      9.28 seconds
TestRunner_smp-tester         PASS      10.50 seconds
TestRunner_userchan-tester    PASS      7.56 seconds
IncrementalBuild              PASS      88.80 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v4,1/4] Bluetooth: Fix potential double free caused by hci_conn_unlink
WARNING: Reported-by: should be immediately followed by Link: with a URL to the report
#82: 
Reported-by: syzbot+690b90b14f14f43f4688@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-bluetooth/000000000000484a8205faafe216@google.com/

WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#83: 
Closes: https://lore.kernel.org/linux-bluetooth/000000000000484a8205faafe216@google.com/

WARNING: Unknown link reference 'Closes:', use 'Link:' instead
#83: 
Closes: https://lore.kernel.org/linux-bluetooth/000000000000484a8205faafe216@google.com/

total: 0 errors, 3 warnings, 0 checks, 33 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13230190.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v4,2/4] Bluetooth: Refcnt drop must be placed last in hci_conn_unlink
WARNING: Reported-by: should be immediately followed by Link: with a URL to the report
#83: 
Reported-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Closes: https://lore.kernel.org/linux-bluetooth/CABBYNZ+1kce8_RJrLNOXd_8=Mdpb=2bx4Nto-hFORk=qiOkoCg@mail.gmail.com/

WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#84: 
Closes: https://lore.kernel.org/linux-bluetooth/CABBYNZ+1kce8_RJrLNOXd_8=Mdpb=2bx4Nto-hFORk=qiOkoCg@mail.gmail.com/

WARNING: Unknown link reference 'Closes:', use 'Link:' instead
#84: 
Closes: https://lore.kernel.org/linux-bluetooth/CABBYNZ+1kce8_RJrLNOXd_8=Mdpb=2bx4Nto-hFORk=qiOkoCg@mail.gmail.com/

total: 0 errors, 3 warnings, 0 checks, 15 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13230188.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v4,3/4] Bluetooth: Fix UAF in hci_conn_hash_flush again
WARNING: Reported-by: should be immediately followed by Link: with a URL to the report
#94: 
Reported-by: syzbot+8bb72f86fc823817bc5d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-bluetooth/000000000000aa920505f60d25ad@google.com/

WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#95: 
Closes: https://lore.kernel.org/linux-bluetooth/000000000000aa920505f60d25ad@google.com/

WARNING: Unknown link reference 'Closes:', use 'Link:' instead
#95: 
Closes: https://lore.kernel.org/linux-bluetooth/000000000000aa920505f60d25ad@google.com/

total: 0 errors, 3 warnings, 0 checks, 73 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13230191.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v4,1/4] Bluetooth: Fix potential double free caused by hci_conn_unlink

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
13: B1 Line exceeds max length (88>80): "Closes: https://lore.kernel.org/linux-bluetooth/000000000000484a8205faafe216@google.com/"
[v4,2/4] Bluetooth: Refcnt drop must be placed last in hci_conn_unlink

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
13: B1 Line exceeds max length (115>80): "Closes: https://lore.kernel.org/linux-bluetooth/CABBYNZ+1kce8_RJrLNOXd_8=Mdpb=2bx4Nto-hFORk=qiOkoCg@mail.gmail.com/"
[v4,3/4] Bluetooth: Fix UAF in hci_conn_hash_flush again

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
24: B1 Line exceeds max length (88>80): "Closes: https://lore.kernel.org/linux-bluetooth/000000000000aa920505f60d25ad@google.com/"


---
Regards,
Linux Bluetooth


--===============4960715534021635129==--
