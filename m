Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5CFC0015E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jul 2023 22:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjGZWBo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jul 2023 18:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGZWBn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jul 2023 18:01:43 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4FA2109
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 15:01:42 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-63d058b9cafso2136296d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 15:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690408901; x=1691013701;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FEtWuKahnToyeEP8pqqIJj4XDkfDoTV54phzswNROwU=;
        b=e/br0+A0DbVyoub4mpmx9E2JLCkK5PBJ9v70nVNmOHGb1vhpgmO39WDingctRDbnj+
         QPLJSqlVPbGc9HVKuRn2of8MnCpI4Y6GVHeJ0710tbjAEQsZo3kFtV14qOO6vR0TbkIW
         tuMWWLEDqbR0G4H3kfK0UNZcVStsfyI90+xdY5DPUlZmwLwQMLo8prYiWlQSDpq2FhIu
         AYrC+t3RaPNkDPEqc888nVFLhCElLgbADokt0PWcKIu9LeDfEIQB06IwUOafkDzSWU9Z
         dPfkxfcd+MxSCxwn8Fzj1f5hiLxmvIE7yv8JPc7HmYa8N9Ak1S7MESbNPHvKo/dv+OFE
         LKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690408901; x=1691013701;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FEtWuKahnToyeEP8pqqIJj4XDkfDoTV54phzswNROwU=;
        b=YiNCxBtYydAucPaoTTOwof1UBZYjmaTCztbm9glubfcmOh1Vl4hAqfslzVZCQ/1VKm
         YabM0op6+V4lC3pf9Ldx4lfcYf5CD0pteiD/i+4h6Pc863pzllswD+iKqz/HYechSlLK
         227ppM6hQ2wxMrzL4Jf0bNuvG542uW+IOLk3IG6/CH29oWVlC08y2+8biV2sn59K//l5
         tmHBHFUIxY52RZyg3jucMadO+xXCTplDsInh/TwHSV9dTiqK/VT2P3/8FjuC8VIgLiXL
         xQH90y32cSMW0rn6JM/oWt5PdLPWMM+wowBx5KQrzvrrl6k38fy9HR8A3M2M6zD2r4jw
         +chw==
X-Gm-Message-State: ABy/qLZUjRGoFQJhR2WSu2SqCwGPplSkZHAViTx8ekU9UwvBPzAz167m
        Ju8x/TTsqOS86osdUZ8aetoEQutoxic=
X-Google-Smtp-Source: APBJJlHaGgC7VJPyy+IWqnWmCF3v28POfBNsDhrZBbC+16TUOhIka53CJG6SgmENQFEPBH1Ll6UJMA==
X-Received: by 2002:ad4:4491:0:b0:636:1377:721a with SMTP id m17-20020ad44491000000b006361377721amr2999268qvt.34.1690408900917;
        Wed, 26 Jul 2023 15:01:40 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.16.68])
        by smtp.gmail.com with ESMTPSA id q29-20020a05620a039d00b00767177a5bebsm4608335qkm.56.2023.07.26.15.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 15:01:40 -0700 (PDT)
Message-ID: <64c197c4.050a0220.662d6.4961@mx.google.com>
Date:   Wed, 26 Jul 2023 15:01:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6244418614117050836=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Locking in hci_sync
In-Reply-To: <30c5e6a7dc62ce209a2b9916fe8b2579d1b27756.1690399379.git.pav@iki.fi>
References: <30c5e6a7dc62ce209a2b9916fe8b2579d1b27756.1690399379.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6244418614117050836==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=769854

---Test result---

Test Summary:
CheckPatch                    PASS      5.24 seconds
GitLint                       FAIL      2.16 seconds
SubjectPrefix                 PASS      0.75 seconds
BuildKernel                   PASS      32.99 seconds
CheckAllWarning               PASS      36.22 seconds
CheckSparse                   PASS      42.20 seconds
CheckSmatch                   PASS      112.30 seconds
BuildKernel32                 PASS      31.92 seconds
TestRunnerSetup               PASS      484.75 seconds
TestRunner_l2cap-tester       PASS      23.23 seconds
TestRunner_iso-tester         PASS      44.83 seconds
TestRunner_bnep-tester        PASS      10.64 seconds
TestRunner_mgmt-tester        PASS      216.30 seconds
TestRunner_rfcomm-tester      PASS      16.08 seconds
TestRunner_sco-tester         PASS      16.79 seconds
TestRunner_ioctl-tester       PASS      17.90 seconds
TestRunner_mesh-tester        PASS      13.44 seconds
TestRunner_smp-tester         PASS      14.31 seconds
TestRunner_userchan-tester    PASS      11.30 seconds
IncrementalBuild              PASS      102.70 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[RFC,2/6] Bluetooth: hci_conn: add hci_conn_is_alive

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
22: B2 Line has trailing whitespace: "    "
28: B2 Line has trailing whitespace: "    "
33: B2 Line has trailing whitespace: "    "
37: B2 Line has trailing whitespace: "    "
[RFC,3/6] Bluetooth: hci_sync: add hci_conn_sync_queue and hci_cmd_sync_dev_(un)lock

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (84>80): "[RFC,3/6] Bluetooth: hci_sync: add hci_conn_sync_queue and hci_cmd_sync_dev_(un)lock"
[RFC,4/6] Bluetooth: hci_sync: fix locking in hci_conn_abort and hci_disconnect_all_sync

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (88>80): "[RFC,4/6] Bluetooth: hci_sync: fix locking in hci_conn_abort and hci_disconnect_all_sync"


---
Regards,
Linux Bluetooth


--===============6244418614117050836==--
