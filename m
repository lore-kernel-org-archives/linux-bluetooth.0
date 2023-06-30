Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25EAEB64DA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jun 2023 22:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjF3Wg6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Jun 2023 18:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjF3Wg4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Jun 2023 18:36:56 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AA71731
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 15:36:54 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-635e107642fso10897306d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 15:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688164613; x=1690756613;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ACj5gMgMKK2I2QimvihSUN+RZ82jGWl6zhY9i3I+TRg=;
        b=h3ffgYJJD+C+WF9IJQwQe9/M9xGwPtB7Poev6zfugNfyl8JH8ftejhoLFJAeni7wx7
         GhTVkf1hGK+VofGxOzRKQpNsrougL96+OYADdvMLsuBxnDDjyFS3ZntsRoTGw7M+22UF
         KYMryjT9mriSouL4UU4C82jd2idcehFer+lZYoZcg0xQq+mAk0vdFOdHJs9xX9YOeYdM
         3uu1WOq0vbVKxWPc9eRJIZe/gSMCbiHFfQeHZbNFo5IvAKJMBRI2vHb3MsvN63m5p6Aq
         /m3help8hJr4a+/CEmm/bi3PnOw3FtANEGNKs5I/HONublc+rq/ejo6dddujbjAn0LHr
         xoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688164613; x=1690756613;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ACj5gMgMKK2I2QimvihSUN+RZ82jGWl6zhY9i3I+TRg=;
        b=g2b/+JACkGYWt4MblX4QCkCVmBpjHnxNruVQe6wLyzcrKvvHV5wXpayB3Q76o/Qd1z
         wKSfxyqDcrFe73RpaKgRFRMzVNaoWLin3PJ/QbJZMya5WhdNoS7x8+RA3OXVfD575O8f
         zNHEusy6+Gja4p2Hklzwk1Z4II1bHn9PAWimcDcvadaPrlRT99EMf/U9F7h514rgQXrq
         hxMOhvh6WzSNKSymffhwWmZ+iInljQQ5fbvngXkXKz2CufGCGN9xAJ4E9C4dsN9N/yE7
         R9xr2UiZMdrgSle6SFMBzQlLFic+RJokpOmG09tCc97xr+ih/tOIFxgTUGlP8BC53S+h
         wcBQ==
X-Gm-Message-State: ABy/qLbDZYHQ8+1csCuoDLeAh9NkftXmxGoUxyCjD6Nt8AjWWR35ddEn
        4blFiP8YQZTyguqljC1fphnrkJc0yHY=
X-Google-Smtp-Source: APBJJlGg2AcIWPrGXdRUWJ3zIAub9rZ0+npw6aeyyOgxiFx+xQA7ZoET/2BeJMIAhMpDwxYeEH4jeg==
X-Received: by 2002:a05:6214:2269:b0:630:34f:80d5 with SMTP id gs9-20020a056214226900b00630034f80d5mr6456771qvb.15.1688164613406;
        Fri, 30 Jun 2023 15:36:53 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.206.84])
        by smtp.gmail.com with ESMTPSA id mi6-20020a056214558600b0062120b054easm3816294qvb.20.2023.06.30.15.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 15:36:53 -0700 (PDT)
Message-ID: <649f5905.050a0220.f5e82.c900@mx.google.com>
Date:   Fri, 30 Jun 2023 15:36:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7140728914622765427=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dianders@chromium.org
Subject: RE: Bluetooth: hci_sync: Avoid use-after-free in dbg for hci_remove_adv_monitor()
In-Reply-To: <20230630143125.1.I3b7c8905728f3124576361ca35ed28e37f12f5d1@changeid>
References: <20230630143125.1.I3b7c8905728f3124576361ca35ed28e37f12f5d1@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7140728914622765427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=761687

---Test result---

Test Summary:
CheckPatch                    PASS      0.82 seconds
GitLint                       PASS      0.39 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      40.34 seconds
CheckAllWarning               PASS      43.82 seconds
CheckSparse                   PASS      49.54 seconds
CheckSmatch                   PASS      133.50 seconds
BuildKernel32                 PASS      38.92 seconds
TestRunnerSetup               PASS      548.39 seconds
TestRunner_l2cap-tester       PASS      16.87 seconds
TestRunner_iso-tester         PASS      30.80 seconds
TestRunner_bnep-tester        PASS      7.45 seconds
TestRunner_mgmt-tester        PASS      158.27 seconds
TestRunner_rfcomm-tester      PASS      11.48 seconds
TestRunner_sco-tester         PASS      12.65 seconds
TestRunner_ioctl-tester       PASS      12.88 seconds
TestRunner_mesh-tester        PASS      9.09 seconds
TestRunner_smp-tester         PASS      10.63 seconds
TestRunner_userchan-tester    PASS      7.63 seconds
IncrementalBuild              PASS      36.82 seconds



---
Regards,
Linux Bluetooth


--===============7140728914622765427==--
