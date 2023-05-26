Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56ACC77B7A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 May 2023 18:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243651AbjEZS5K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 May 2023 14:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243628AbjEZS5J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 May 2023 14:57:09 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B544A1B3
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 May 2023 11:57:06 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64d577071a6so1560278b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 May 2023 11:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685127426; x=1687719426;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cRKRqs1azPbd7iwxCa0GioomO5os6B6BTILzfIHdDts=;
        b=Yic5detC8GlyOlPa5ME7aKUdei7Rs0jP0zcK0QoO6AHIsE6uqdZENpDI8h22H7whyK
         uXlp3cqukTBIVZTFA8n0XXyfH1gs9JDpburQCMckFVCjBPE60a9d3qKiBLx6BsQfccBx
         kG1Cb+n3mrUON9MeUitZW4c/eQj+yuat60noiezO81+S1siKke8K6mDSZa/tJizEzHFM
         vQGAn2oNrXIFoScsbdPpATaj9AvVs2zDDSyUcUb5qF3Mk2XHFSVHxI/n+lFLoghfxQdg
         BBAcOU8x4VgDhgioKw5SwmC1urke0ZTcPPppXwgqF/QayqJFtNI/qDjYsM4yZA19Sd29
         JEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685127426; x=1687719426;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cRKRqs1azPbd7iwxCa0GioomO5os6B6BTILzfIHdDts=;
        b=GBiNBruIXjB0D9v+ovSCe1DzV4sLEAFjGRsSZXV4xM5XrvpqQjXSWL2KeWxW5jIlMs
         Bh9WYywrRmSiSF/wkmhmGJMN2hL1jB1kFkr2SCxP9sc5d6gB4JjgWJ85YQjoYpaYZG9x
         6xCZGnKYaQFRnH+qn92rCPz5NVMcnp6EEckMdOUSimfj6SQiepmWiZYFQ6FuIEzwI+NV
         4884m/iRdnzFhjHOKO+9p06NQVwxCFAy5Hehn+ephVKxZEo8XUKnhR6+wC7iF2YgWRkg
         A3sumrXZdVFtz7qqpn6ylB8gzOCX1EYdfb0CBC9lr7QGYWuWqtmxgzfgZyAkK8iz6p4+
         Ptzg==
X-Gm-Message-State: AC+VfDzg91YqR9ksoU5+0BV/Heu+MJoAbq6wI2rAdaEKx80JO9DVV+KS
        S2jiTSOcL4SY2IEx0JO5K2iW6uACHKk=
X-Google-Smtp-Source: ACHHUZ7rqv0oVdBAmg0F0pR2VtLusf/64jsNveQ9ULYTyVF7IBbiE3bEYkzFn+eUbyD2OU3tkHvOTQ==
X-Received: by 2002:a05:6a00:189f:b0:64c:e899:dcd1 with SMTP id x31-20020a056a00189f00b0064ce899dcd1mr5584902pfh.5.1685127425736;
        Fri, 26 May 2023 11:57:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.59.211])
        by smtp.gmail.com with ESMTPSA id e16-20020aa78c50000000b0063b867a1959sm3018178pfd.133.2023.05.26.11.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 11:57:05 -0700 (PDT)
Message-ID: <64710101.a70a0220.679a4.6773@mx.google.com>
Date:   Fri, 26 May 2023 11:57:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4200464974692261302=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iam@sung-woo.kim
Subject: RE: Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_ready_cb
In-Reply-To: <20230526181647.3074391-1-iam@sung-woo.kim>
References: <20230526181647.3074391-1-iam@sung-woo.kim>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4200464974692261302==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=751481

---Test result---

Test Summary:
CheckPatch                    FAIL      0.81 seconds
GitLint                       FAIL      0.54 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      31.67 seconds
CheckAllWarning               PASS      34.90 seconds
CheckSparse                   PASS      39.38 seconds
CheckSmatch                   PASS      110.87 seconds
BuildKernel32                 PASS      30.74 seconds
TestRunnerSetup               PASS      441.52 seconds
TestRunner_l2cap-tester       PASS      16.65 seconds
TestRunner_iso-tester         PASS      21.28 seconds
TestRunner_bnep-tester        PASS      5.47 seconds
TestRunner_mgmt-tester        PASS      110.94 seconds
TestRunner_rfcomm-tester      PASS      8.76 seconds
TestRunner_sco-tester         PASS      8.05 seconds
TestRunner_ioctl-tester       PASS      9.27 seconds
TestRunner_mesh-tester        PASS      6.87 seconds
TestRunner_smp-tester         PASS      7.98 seconds
TestRunner_userchan-tester    PASS      5.72 seconds
IncrementalBuild              PASS      29.11 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_ready_cb
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#74: 
> >> net/bluetooth/l2cap_sock.c:1418:9: error: implicit declaration of function 'l2cap_sock_cleanup_listen'; did you mean 'l2cap_sock_listen'? [-Werror=implicit-function-declaration]

ERROR: trailing whitespace
#113: FILE: net/bluetooth/l2cap_sock.c:1418:
+^I^I$

total: 1 errors, 1 warnings, 0 checks, 16 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/src/13257259.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_ready_cb

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
4: B1 Line exceeds max length (182>80): "> >> net/bluetooth/l2cap_sock.c:1418:9: error: implicit declaration of function 'l2cap_sock_cleanup_listen'; did you mean 'l2cap_sock_listen'? [-Werror=implicit-function-declaration]"
12: B1 Line exceeds max length (127>80): "> >> net/bluetooth/l2cap_sock.c:1436:13: warning: conflicting types for 'l2cap_sock_cleanup_listen'; have 'void(struct sock *)'"
15: B1 Line exceeds max length (128>80): "> >> net/bluetooth/l2cap_sock.c:1436:13: error: static declaration of 'l2cap_sock_cleanup_listen' follows non-static declaration"
16: B1 Line exceeds max length (138>80): ">    net/bluetooth/l2cap_sock.c:1418:9: note: previous implicit declaration of 'l2cap_sock_cleanup_listen' with type 'void(struct sock *)'"


---
Regards,
Linux Bluetooth


--===============4200464974692261302==--
