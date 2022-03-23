Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7367C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 06:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241836AbiCWGEU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 02:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiCWGES (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 02:04:18 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103776D18A
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 23:02:50 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id f3so503023qvz.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 23:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=IIUGxbzu76oLZycGcHSM1dxrvM2L04zq1shm3Q+5Ylo=;
        b=TaI7g2qfJ3uJmdp9q5pojuryUJzrSUG8ac4JbjB+Q2V9blgfA9V4JMXysSX9qmO5NN
         ZxWzjK1vhfNuFslsPdWnPxlK425P/a070UP9ubLfWpVTnHNIu4hJdrrNwGsX1lZSYYzb
         olH0R+Y08riRBveAHIzmbC3NVe55tAfDZpNVZ5nNnMc/fxPO8YR2pj9/+KqqMzPVXTh2
         Hj9E8hGG+qKOGs7lRYTWVS2tXzvr3jZaqqeogsf3jOY4tpkkvJ2dJQByxlEl+Cqt9FB9
         HpFsFyqX92UOwLMCxA/cX/BAgUDp77IeKAULhCwmTaoEgWbnHz303J51Ry4TZvP9Qs4K
         S+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=IIUGxbzu76oLZycGcHSM1dxrvM2L04zq1shm3Q+5Ylo=;
        b=QE/0xsxY/hDv2w4nX0gnKppFTVhu3ibCCD3Ct30rVrHGjRED/G9EEePePkN/kkG5qS
         CnkwZOmBUE0YCKhMkmaoss0pz04Tk7bNxYdvZylwnDn+mCvpCYbDTUdFtQDH+XCcL5xu
         kC1HiJ5G4ggkWjBuz+CsxSgFWiq8oXPNCvVnFz6J7S4R+8KKr1IfZm9L2857UGZI24LM
         gUCbDGqRSDq7ISEnAtzuo+z7Ss7Nmr/gZx9S/2rmEyMLkolusjYNBHuG7e5M/cfpc0hd
         RQ3+CmxHcPlT3QSJz4/nohbj+SYdhFoxdSXjZL9n+Yxa66TJQtdgF/Q0uvY2HfWn+GFY
         +CKA==
X-Gm-Message-State: AOAM533jkJFgD01xhpeNb1gc2QdivwkTuND0d4gj7uTRwQ93u6uFDz2T
        4al3TSwUZtyYBlzmu1smXXtsCyNPcJtgZQ==
X-Google-Smtp-Source: ABdhPJz3oYnfT+hOg0bFFtc/xQaUGat+jZM9c0VyTRCV42qEWV1CBmeTAznfOsjcj55/Iyif47WWmQ==
X-Received: by 2002:a05:6214:5281:b0:441:ac1:dd21 with SMTP id kj1-20020a056214528100b004410ac1dd21mr14875132qvb.2.1648015368365;
        Tue, 22 Mar 2022 23:02:48 -0700 (PDT)
Received: from [172.17.0.2] ([23.102.123.174])
        by smtp.gmail.com with ESMTPSA id p13-20020a05622a048d00b002e1ce0c627csm16349501qtx.58.2022.03.22.23.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 23:02:48 -0700 (PDT)
Message-ID: <623ab808.1c69fb81.a2a1a.7e03@mx.google.com>
Date:   Tue, 22 Mar 2022 23:02:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2819753785265437717=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/9] log: Introduce DBG_IS_ENABLED
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220323000654.3157833-1-luiz.dentz@gmail.com>
References: <20220323000654.3157833-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2819753785265437717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=625602

---Test result---

Test Summary:
CheckPatch                    FAIL      13.01 seconds
GitLint                       PASS      8.92 seconds
Prep - Setup ELL              PASS      43.75 seconds
Build - Prep                  PASS      0.71 seconds
Build - Configure             PASS      8.81 seconds
Build - Make                  PASS      1290.37 seconds
Make Check                    PASS      11.94 seconds
Make Check w/Valgrind         PASS      439.98 seconds
Make Distcheck                PASS      232.10 seconds
Build w/ext ELL - Configure   PASS      8.79 seconds
Build w/ext ELL - Make        PASS      1255.66 seconds
Incremental Build with patchesPASS      11577.93 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,v2,3/9] mgmt: Introduce mgmt_set_verbose
WARNING:REPEATED_WORD: Possible repeated word: 'the'
#83: 
the the likes hexdump of packets, by default it is disabled since in

/github/workspace/src/12789344.patch total: 0 errors, 1 warnings, 61 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12789344.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============2819753785265437717==--
