Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B75C678D5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Mar 2023 17:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjCHRNJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Mar 2023 12:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCHRNH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Mar 2023 12:13:07 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FE82D6C
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Mar 2023 09:13:04 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id r5so18851532qtp.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Mar 2023 09:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678295583;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yv2IszsVivehPboxXonut+0u2fCShAnJqKTlitiOKbc=;
        b=LJ/md4/o+bI/6daBkUHdA01xFDZZD0d8MxgP8X1PNv0vN5+bWXqBS1i0EvvdCxzUdh
         OVuYgSbZKe9o04VeVZBLNFDjbFQWKB33U9zEVZ34Wd/5cl2W4bbEvNVUt4BIHo7aM8wx
         W6PzpvMQ4r+zR2N2+t542SKANpre7xuEfJzifOkCAOC5ZYNjPdSMO5gBjlJ+W6GbVQWU
         SF0Vvjgy7M2E0z/PCzjTIuApfVQl7hKQNuKKczPcDyhkHhotmcAqtDbmp568F+QlGxJR
         7UMlQWCup64egfUbiiEPiI1ztnRN57mMaaKlbHX/SDX9QLBkXZjB7Lgi9zpRp+LjcJdp
         Jx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678295583;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yv2IszsVivehPboxXonut+0u2fCShAnJqKTlitiOKbc=;
        b=4gXyo42ZGS0Se1RiyYD99mHMl8OUhWbM6ZHRZ7XRvWEduq7V9Md56GdP2ylu4lN32X
         3GLuJSLFH024lFVNZWS2UIJ6eXWmAsm0BCahtyBZBfWVFQB9fwtf+0sCCp2QXt4vi+8s
         4yuUavFgYKc+e+4IQcTlhzofcAGrrpp3fCzIBeVrpQwGLnr4ha4OHMKkJaQn68qwanHc
         TF0SAIbws7xsne7/H0SbTIt+AV6Eg3LmE54yQpH0j9zYsJJOF6O9KpT0LK/juaBTVkZe
         Qt46+iw9Vl1PoGs9MzAI3757IJkvB4bd4bqK1eABKZ9Lts8K4DIyIRQFsj5YcHcCGdCf
         Da2g==
X-Gm-Message-State: AO0yUKWMa6CQzd+LnJVXUF86jb0QZPPzK7sLg/W0OVmMBGgwOgMOI0cy
        M42uPD+huSDjsbA6kBhfcQaWTTP/v/M=
X-Google-Smtp-Source: AK7set8uAtdlG3SOaY18z9o5wTbpGAheEryIwZ/85rTDO7TYu3NsLDZeSuWuf8kRak3sjSqzjj8Lhg==
X-Received: by 2002:a05:622a:48d:b0:3c0:40c1:8408 with SMTP id p13-20020a05622a048d00b003c040c18408mr6604432qtx.63.1678295583376;
        Wed, 08 Mar 2023 09:13:03 -0800 (PST)
Received: from [172.17.0.2] ([104.45.203.192])
        by smtp.gmail.com with ESMTPSA id p188-20020a3742c5000000b006fed58fc1a3sm11825314qka.119.2023.03.08.09.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 09:13:03 -0800 (PST)
Message-ID: <6408c21f.370a0220.cfcec.6169@mx.google.com>
Date:   Wed, 08 Mar 2023 09:13:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7837619437257930051=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, zyytlz.wz@163.com
Subject: RE: Bluetooth: btsdio: fix use after free bug in btsdio_remove due to race condition
In-Reply-To: <20230308164501.2734985-1-zyytlz.wz@163.com>
References: <20230308164501.2734985-1-zyytlz.wz@163.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7837619437257930051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=727958

---Test result---

Test Summary:
CheckPatch                    PASS      0.76 seconds
GitLint                       FAIL      0.83 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      39.44 seconds
CheckAllWarning               PASS      42.69 seconds
CheckSparse                   PASS      47.97 seconds
CheckSmatch                   PASS      129.08 seconds
BuildKernel32                 PASS      37.70 seconds
TestRunnerSetup               PASS      534.76 seconds
TestRunner_l2cap-tester       PASS      18.95 seconds
TestRunner_iso-tester         PASS      20.78 seconds
TestRunner_bnep-tester        PASS      6.83 seconds
TestRunner_mgmt-tester        PASS      129.65 seconds
TestRunner_rfcomm-tester      PASS      11.47 seconds
TestRunner_sco-tester         PASS      10.05 seconds
TestRunner_ioctl-tester       PASS      12.28 seconds
TestRunner_mesh-tester        PASS      9.09 seconds
TestRunner_smp-tester         PASS      9.82 seconds
TestRunner_userchan-tester    PASS      7.66 seconds
IncrementalBuild              PASS      35.26 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: btsdio: fix use after free bug in btsdio_remove due to race condition

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
3: B2 Line has trailing whitespace: "In btsdio_probe, the data->work is bound with btsdio_work. It will be "
6: B2 Line has trailing whitespace: "If the btsdio_remove runs with a unfinished work, there may be a race "
7: B2 Line has trailing whitespace: "condition that hdev is freed but used in btsdio_work. Fix it by "


---
Regards,
Linux Bluetooth


--===============7837619437257930051==--
