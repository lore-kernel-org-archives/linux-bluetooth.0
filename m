Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317FAEB64DC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Jul 2023 18:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjGKSkI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Jul 2023 14:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjGKSkH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Jul 2023 14:40:07 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF0D170A
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jul 2023 11:40:03 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-4039f7e1d3aso37811971cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jul 2023 11:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689100802; x=1691692802;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uJtFAUYfo4ZwjtUDI8Z4Y/5aQxS4v3g9u6v0cJu0uI4=;
        b=oNloRylorNE51SPNeJe0HhWJOrSepgNPKfWxQvdtBOBviweQkXZtb6LU4g9tEUb8PN
         glS2wwZn6Xru7g+k9+35RnTF2O1RUe1pTx6MMuM0+dj6KULjRZQFLtYnmNPjf4u+Uyhk
         jRUFqMVDGKC2ZsVD+0mMOgcSIunQokqD5qANt8+vS+Om2/Rw3xTrBQrP4mS0BiDgJKzG
         HICPPgjXoJWtrRfZU50WMIAREZistEYeFlIv1S0Mip6ppIf2zNR4TNjXGOl+v5I+HAh+
         f3buwGSyIPERtlGaKYk6tpPFDmU1VXKxh1ZR/AojEgoeNiwSCPnnmob0kDWHD9aVSKXT
         C65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689100802; x=1691692802;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJtFAUYfo4ZwjtUDI8Z4Y/5aQxS4v3g9u6v0cJu0uI4=;
        b=EEa3446wDNITyI9Dc7hXjX8MofLSoTD+OPcCTmV+tHPn0SQ+jI29BHF6kCMgwVz7NU
         vzJOOpZGgHvlSOiL4l0m2Q+2WsQYniYhGoArsoSLfmWy/DBZmZ8PH2jKn0jCq4yBkUlW
         DhzldHr2gHAokkCoie2SQmiBnugIWqcudmYV2JOu2/CYK2bJCR/MMivWez+1lPoUtlON
         fmfN7HhAKpVRuY+YVQ8NQadxUyn9Mo6fgvgcpFWY66JmhLpZeGulrTBghtO2Cb9nfmp3
         qGreGh66MJ6VIvwM8aYhJueuqM9/iiHESVDLVFAt99JFoJ+kPyKRaGqp6TjDJuqnHHHE
         JlLQ==
X-Gm-Message-State: ABy/qLaRV3NIN1qIjvYvvvLalJIVLD3DBxAuPYwxWXzx+x+tBAj2Y7ue
        Os97Z4tpivLTDlJlBl3AhjfNu5SOnZw=
X-Google-Smtp-Source: APBJJlFpY5wnhmki6BGe0OoNOvi3b/tsEiHvB1jF8k+zQ9y3QBe9qmuXNrJ44/sMqnIzWF0dDRTkZw==
X-Received: by 2002:ac8:5a41:0:b0:403:b5a1:7ee0 with SMTP id o1-20020ac85a41000000b00403b5a17ee0mr5919809qta.32.1689100802077;
        Tue, 11 Jul 2023 11:40:02 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.246.178])
        by smtp.gmail.com with ESMTPSA id l19-20020ac848d3000000b003fe0a89447fsm1379946qtr.14.2023.07.11.11.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 11:40:01 -0700 (PDT)
Message-ID: <64ada201.c80a0220.87a99.5110@mx.google.com>
Date:   Tue, 11 Jul 2023 11:40:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5728405270781800906=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, christophe.jaillet@wanadoo.fr
Subject: RE: [v3] Bluetooth: hci_debugfs: Use kstrtobool() instead of strtobool()
In-Reply-To: <58247d1b8105739f0371030a93fb28ea3dbedc57.1673687451.git.christophe.jaillet@wanadoo.fr>
References: <58247d1b8105739f0371030a93fb28ea3dbedc57.1673687451.git.christophe.jaillet@wanadoo.fr>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5728405270781800906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=764536

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
GitLint                       FAIL      0.63 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      33.35 seconds
CheckAllWarning               PASS      36.61 seconds
CheckSparse                   PASS      41.58 seconds
CheckSmatch                   PASS      114.87 seconds
BuildKernel32                 PASS      32.08 seconds
TestRunnerSetup               PASS      487.74 seconds
TestRunner_l2cap-tester       PASS      22.52 seconds
TestRunner_iso-tester         PASS      40.30 seconds
TestRunner_bnep-tester        PASS      10.19 seconds
TestRunner_mgmt-tester        PASS      214.76 seconds
TestRunner_rfcomm-tester      PASS      15.63 seconds
TestRunner_sco-tester         PASS      16.55 seconds
TestRunner_ioctl-tester       PASS      17.22 seconds
TestRunner_mesh-tester        PASS      12.98 seconds
TestRunner_smp-tester         PASS      13.79 seconds
TestRunner_userchan-tester    PASS      10.69 seconds
IncrementalBuild              PASS      30.56 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3] Bluetooth: hci_debugfs: Use kstrtobool() instead of strtobool()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
29: B1 Line exceeds max length (118>80): "  - https://lore.kernel.org/all/58207d5b81c5739c037c030893fb08ea3dbedc57.1673687451.git.christophe.jaillet@wanadoo.fr/"
31: B2 Line has trailing whitespace: "v1:  "
32: B1 Line exceeds max length (84>80): "[1]: https://lore.kernel.org/all/cover.1667336095.git.christophe.jaillet@wanadoo.fr/"


---
Regards,
Linux Bluetooth


--===============5728405270781800906==--
