Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51833C6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Mar 2023 10:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjCPKek (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Mar 2023 06:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjCPKej (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Mar 2023 06:34:39 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACD64EC6
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 03:34:38 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id c18so1126375qte.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 03:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678962878;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wxjGoaDURQedpHdW8SjAi+7INxvUfbbv1AUD1CBtZG8=;
        b=ddOJJiKfwOpS0hMJPtC5ggnuLOSzPv1c24bPSQ6oDW/x14KOCcJBz6LqR+nitJqxEx
         dn6qvxgfRyHeva1vIzqYk/7h780jZPtPb03FvleqR76KvQcem1Jy2b6L03bwT+zKx+YW
         R/Jhs2fr28m4HhDJOKDhs/UhtK6+APNX6wa83VcVWlRjzOJS3HJSf5Kn+LSO8ONm2GHO
         mi3twrBPNBosi6SGQ6gubgiu9AjxSYUM8OkvvaOZ+HjYD+RFCYuSe8X2LSFnnVcBUWkt
         2ve+igu1qhTQBShv6ZjHCSJ0vbMSSXvUIsixK6bWfvdun9KuRTXWV4H4k3hIhefDPrSb
         bWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678962878;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wxjGoaDURQedpHdW8SjAi+7INxvUfbbv1AUD1CBtZG8=;
        b=ZIg55clWy+SJNBYcGHmZEQ6jf33dM8jdnnPF9QF2/HLjcEyA2dM6cmR4Baz3z8IFMN
         ZFY7efvHF5x/41Xlw5JFsNLlatm/RhAZKAzGG/zA3lpHgDHeaV4rQnj6f+EwAOspXKDj
         RWopU9GJoINCuGKJD1wjYFD7XfvGV/sKq3Hznu/f8UTubcDr6pQtXZOpG/sRgHTdjtAi
         zaR9LGwjbeQegx715rloLqnf0nDIswDh9TAiFCxp95wsAkVjuf1e3i2ZiE+Q6lUwXkQC
         54gonoEpJhW5+0F4l8UunOOSDrDmlungZs467H/hQ/YSu2szh5Bd+YZTTYbk1Xy5EBSL
         3sIA==
X-Gm-Message-State: AO0yUKVvnYikV21OYkUt93McpAPnQL/plKEh8Fzt36mr8F8gKcMmOln6
        mB9oQcs/MsE32GXYWvyO7ZLK26pmG+A=
X-Google-Smtp-Source: AK7set/pHxNt8PjrsPuxXVL0HkTgLNG027Vx+6r2gNfFCjjiKEsy17MzG9Lm5SDVFrliPE2ctbsung==
X-Received: by 2002:a05:622a:89:b0:3bf:cfa6:55a1 with SMTP id o9-20020a05622a008900b003bfcfa655a1mr5743522qtw.12.1678962877744;
        Thu, 16 Mar 2023 03:34:37 -0700 (PDT)
Received: from [172.17.0.2] ([172.176.137.185])
        by smtp.gmail.com with ESMTPSA id s15-20020ac85ccf000000b003b0b903720esm5510115qta.13.2023.03.16.03.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 03:34:37 -0700 (PDT)
Message-ID: <6412f0bd.c80a0220.478d1.758b@mx.google.com>
Date:   Thu, 16 Mar 2023 03:34:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5884442773002452277=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [v2] Bluetooth: mgmt: Fix MGMT add advmon with RSSI command
In-Reply-To: <20230316175301.v2.1.I9113bb4f444afc2c5cb19d1e96569e01ddbd8939@changeid>
References: <20230316175301.v2.1.I9113bb4f444afc2c5cb19d1e96569e01ddbd8939@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5884442773002452277==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=730700

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
GitLint                       PASS      0.36 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      32.75 seconds
CheckAllWarning               PASS      35.33 seconds
CheckSparse                   PASS      40.09 seconds
CheckSmatch                   PASS      108.18 seconds
BuildKernel32                 PASS      31.15 seconds
TestRunnerSetup               PASS      451.98 seconds
TestRunner_l2cap-tester       PASS      17.22 seconds
TestRunner_iso-tester         PASS      17.74 seconds
TestRunner_bnep-tester        PASS      5.73 seconds
TestRunner_mgmt-tester        PASS      113.90 seconds
TestRunner_rfcomm-tester      PASS      9.10 seconds
TestRunner_sco-tester         PASS      8.43 seconds
TestRunner_ioctl-tester       PASS      9.85 seconds
TestRunner_mesh-tester        PASS      7.24 seconds
TestRunner_smp-tester         PASS      8.34 seconds
TestRunner_userchan-tester    PASS      6.09 seconds
IncrementalBuild              PASS      29.70 seconds



---
Regards,
Linux Bluetooth


--===============5884442773002452277==--
