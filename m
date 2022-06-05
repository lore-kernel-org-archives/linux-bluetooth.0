Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382F7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 Jun 2022 17:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346253AbiFEROu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 5 Jun 2022 13:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238415AbiFEROt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 5 Jun 2022 13:14:49 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83ECEE21
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Jun 2022 10:14:47 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 68so1043893qkk.9
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Jun 2022 10:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=JkWRpAoqZa3lBJG8BYlB7WAXfhEPsJChfFNwzkQpoGE=;
        b=LmPJQB16XchJM1dJXp5qtzvSo4Z1aMUrNjU765TA1h1AOIWyr6sIicQwuhX7rWkui7
         UAQPX4Ym12n0Ru9ozDNeyBEyD75KHcMFlx4/4U63HvUF2qsWnhqwVIiT+kgg3Viq+cNt
         sGhbgKsASK/af4lgMHfwNNy7H4lf70Z/Zm7J8DJaufMV7ttoW8Q9RJoeloyIkF/QYGz7
         x/T38EsxibuEzZN2+oruB7kEonmtTiBqmwJg3xSm9GrZpvSAt+cYyP0O0/KycswK0+EZ
         SkSPD/5s906lZz8Yecy8nuNNl6TQZWD+EuMUam2Fxrh1JcTduGcTBzSiQsjUqnF1P/Iz
         EF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=JkWRpAoqZa3lBJG8BYlB7WAXfhEPsJChfFNwzkQpoGE=;
        b=ILidELxIoykTAfpQR6imQiiNJFFkY+vKxXdGp/UyGMaDCPY7vS0vVmN+m0kZWrbepP
         eAnqw7k7ERhh9ZXol3SmJUA2AU4I5TbO8WwVrEgjZwMaBtcDXr10PC7PIshSHR3oGc2X
         5KygXO23/8SIWY0/vpqlMZk9cUE75mJMwobKhqd6Phmff/NfgegHyA74qTDSfRx2r+oB
         03dihvHR1TpsRu4gVRkkcpXcU3Hkg1Rezo0RPyyKSkWxPrMhwavOuWoBNCXB1aiZZMzU
         2h+QzzST9OGRopcH8pzjdedmydQqga4z07S2KXqGCdnQ/hBlkoeXpxJhlSfzFOsX5og7
         5VWA==
X-Gm-Message-State: AOAM530gaNuR4Iivwi83GbXptJGHt+6Jfx23Do6f963QwGuk4WDhnwgK
        VRc1wRo6yu8skVmUwMf6lBk1cMOCvg7cHg==
X-Google-Smtp-Source: ABdhPJyjiXzfTy7aEBUyH8YiOEH5eWwRZmCfQfceL4zaayG3ld95+AU5v8gzlFDE65Ty+DBP/+kkFg==
X-Received: by 2002:a05:620a:98a:b0:6a3:840f:96d1 with SMTP id x10-20020a05620a098a00b006a3840f96d1mr13547001qkx.286.1654449286745;
        Sun, 05 Jun 2022 10:14:46 -0700 (PDT)
Received: from [172.17.0.2] ([20.114.128.239])
        by smtp.gmail.com with ESMTPSA id s13-20020a05622a1a8d00b002f39b99f6a4sm9150518qtc.62.2022.06.05.10.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 10:14:46 -0700 (PDT)
Message-ID: <629ce486.1c69fb81.a7fb5.3c68@mx.google.com>
Date:   Sun, 05 Jun 2022 10:14:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5961575270932011230=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yury.norov@gmail.com
Subject: RE: net/bluetooth: fix erroneous use of bitmap_from_u64()
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220605162537.1604762-1-yury.norov@gmail.com>
References: <20220605162537.1604762-1-yury.norov@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5961575270932011230==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=647461

---Test result---

Test Summary:
CheckPatch                    FAIL      1.95 seconds
GitLint                       FAIL      1.03 seconds
SubjectPrefix                 FAIL      0.87 seconds
BuildKernel                   PASS      36.71 seconds
BuildKernel32                 PASS      32.83 seconds
Incremental Build with patchesPASS      44.05 seconds
TestRunner: Setup             PASS      546.12 seconds
TestRunner: l2cap-tester      PASS      18.98 seconds
TestRunner: bnep-tester       PASS      6.98 seconds
TestRunner: mgmt-tester       PASS      113.33 seconds
TestRunner: rfcomm-tester     PASS      10.88 seconds
TestRunner: sco-tester        PASS      10.46 seconds
TestRunner: smp-tester        PASS      10.53 seconds
TestRunner: userchan-tester   PASS      7.30 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.95 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
net/bluetooth: fix erroneous use of bitmap_from_u64()\WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#117: 
    inlined from 'bitmap_copy_clear_tail' at ./include/linux/bitmap.h:263:2,

total: 0 errors, 1 warnings, 0 checks, 33 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12869809.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL - 1.03 seconds
Run gitlint with rule in .gitlint
net/bluetooth: fix erroneous use of bitmap_from_u64()
26: B1 Line exceeds max length (85>80): "    inlined from 'hci_bdaddr_list_add_with_flags' at net/bluetooth/hci_core.c:2156:2:"
27: B1 Line exceeds max length (113>80): "./include/linux/fortify-string.h:344:25: error: call to '__write_overflow_field' declared with attribute warning:"
28: B1 Line exceeds max length (107>80): "+detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]"
43: B1 Line exceeds max length (115>80): "./include/linux/bitmap.h:254:9: error: 'memcpy' forming offset [4, 7] is out of the bounds [0, 4] of object 'flags'"


##############################
Test: SubjectPrefix - FAIL - 0.87 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============5961575270932011230==--
