Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312A7C7618E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Apr 2023 23:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242613AbjDZX6G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Apr 2023 19:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242611AbjDZX6F (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Apr 2023 19:58:05 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D408269F
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Apr 2023 16:58:04 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-751319e0dbfso56356485a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Apr 2023 16:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682553483; x=1685145483;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VgXrhBZ0wsTQZpu72Dl06b9IFUXnwzrT2cxDb7GZjBs=;
        b=c0XJTk2EWHND5z//60UXf0IuKsAt8Idowl7Du4ba6QJO/9pt2OvNzc2kNMe+Q8+hwV
         8X/3PhlRZ2MKKgik2BHsq5Af7xYcuvX4K72gqoX9chejYLmjAVhFKWt9TNTkRRAzOKAH
         UKBKn+CTKqS33EX6LNE3dMqUbP4o4x9B2dqWzJ5BQzlY92Cd7y0I7JqU46aHcNxPqlTY
         HAXGyhd3IqAoAc9Cmv/J3LSIQKJ+izA0D4R+HtlCSGjW1yXun4/Jz908XcT2Kupn3rWc
         WnNuS1rd/69ON9LQfelfO88hjYmrLXYFHnJuHElt9fytdoXbDj4Ni1+BAnInJb/dgxCU
         7tJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682553483; x=1685145483;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VgXrhBZ0wsTQZpu72Dl06b9IFUXnwzrT2cxDb7GZjBs=;
        b=L6G0gG1osth+4l0jRKAAULt0X6JcC+EIuFDs0ueP8yBooGO+QAnkzvUxpIUNS1zKSK
         Xu7qZFGEEs1V+RWSOhfgHgxDzrDGXqmEc2LbCnccAwOpf2vKkmoPM/2mOdl20gNCvsYZ
         lFTgPLhdj6uKKKQLzAUXCiDvKr58ACQToMtD+f9ZdlBAopIQlTUChFcup2kbmhw/x6J0
         58JrUxa87Ql76cy5iz6KwMvhe+cQWXnUFMFkOTvhbCwctQNQqbYZWJdeN1kQyRHQXeWB
         hGM/KTnbBOfeHJn0LtFxLUftvK2Y38PraEssYTA/5qh1M2HDDAOaWBofyofiFyOqdcdY
         O/Qw==
X-Gm-Message-State: AC+VfDzboCQAGeljYjdW5ATV4/n/uAZXgfCjZ9LeF46sgDJWwAiJ55AD
        niiv2iNf1P0IUSYCAVi10aAr4GCpsM4=
X-Google-Smtp-Source: ACHHUZ5gt6JK9EOP1EVdgHDgJ/Ke8eAOyKX1ugBSkx5J6+KZy6rcfW4XrdIwHddCwWUnEFyqvAWRCA==
X-Received: by 2002:a05:622a:15cd:b0:3ef:357b:751f with SMTP id d13-20020a05622a15cd00b003ef357b751fmr74392qty.14.1682553483446;
        Wed, 26 Apr 2023 16:58:03 -0700 (PDT)
Received: from [172.17.0.2] ([40.75.119.48])
        by smtp.gmail.com with ESMTPSA id k1-20020ac86041000000b003ecf475286csm5677415qtm.39.2023.04.26.16.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 16:58:03 -0700 (PDT)
Message-ID: <6449ba8b.c80a0220.241a5.77b3@mx.google.com>
Date:   Wed, 26 Apr 2023 16:58:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0776742893933456342=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sean.wang@mediatek.com
Subject: RE: [v4,1/3] Bluetooth: btusb: mediatek: use readx_poll_timeout instead of open coding
In-Reply-To: <4699f59b36d522ec263dcea71eda40ae939004f8.1682549719.git.objelf@gmail.com>
References: <4699f59b36d522ec263dcea71eda40ae939004f8.1682549719.git.objelf@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0776742893933456342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=743473

---Test result---

Test Summary:
CheckPatch                    PASS      2.91 seconds
GitLint                       FAIL      1.27 seconds
SubjectPrefix                 PASS      0.38 seconds
BuildKernel                   PASS      32.63 seconds
CheckAllWarning               PASS      35.52 seconds
CheckSparse                   PASS      41.39 seconds
CheckSmatch                   PASS      109.94 seconds
BuildKernel32                 PASS      31.82 seconds
TestRunnerSetup               PASS      452.25 seconds
TestRunner_l2cap-tester       PASS      17.25 seconds
TestRunner_iso-tester         PASS      21.54 seconds
TestRunner_bnep-tester        PASS      5.65 seconds
TestRunner_mgmt-tester        PASS      117.22 seconds
TestRunner_rfcomm-tester      PASS      9.05 seconds
TestRunner_sco-tester         PASS      8.47 seconds
TestRunner_ioctl-tester       PASS      9.83 seconds
TestRunner_mesh-tester        PASS      7.26 seconds
TestRunner_smp-tester         PASS      8.28 seconds
TestRunner_userchan-tester    PASS      5.96 seconds
IncrementalBuild              PASS      42.65 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v4,1/3] Bluetooth: btusb: mediatek: use readx_poll_timeout instead of open coding

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (82>80): "[v4,1/3] Bluetooth: btusb: mediatek: use readx_poll_timeout instead of open coding"


---
Regards,
Linux Bluetooth


--===============0776742893933456342==--
