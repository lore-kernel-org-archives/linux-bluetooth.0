Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFE3C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Jun 2023 08:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239682AbjFGI7P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Jun 2023 04:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbjFGI6v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Jun 2023 04:58:51 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454161FF5
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jun 2023 01:57:33 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-75d4fb03100so470599685a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Jun 2023 01:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686128252; x=1688720252;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=94ERGjy2OXmnR5HhcCS0X9JEEn208NGai367IPw9IQk=;
        b=PpEf85MRcoYEsKUNCB7KDFZ5fcibi7aIqooyEcGN05wuNBEpMvQNRusolw0+n92h7R
         rJrSImM14jxmaicCTQWrnoQ3bIpB/OItZCBtMkIb7KWFabolRVH2o5eM6YyuuS5Gv2IP
         pSogkDWOC7HWCtJSV4S0S4j3KLflesu2abp/SDieCamJWgIAuAenzOIHTdGhaIcO3pn+
         dRx3uUdGnv7lNyzi/oxz5J6CPl5i1lUWSyzQbgETfEHxBr7NfggqqU2Nh81XIWlJLbMm
         Yk5TJgWbxSsd6Dfzo6ZqTJ4GMm2yMTxwbaKv7ozGMnkEGxN9KoVLSGYLUY61zJD9QjvZ
         /sxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686128252; x=1688720252;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=94ERGjy2OXmnR5HhcCS0X9JEEn208NGai367IPw9IQk=;
        b=aTV/WpIojXS/lbE5jm8iZRsN4i6iW2X/yo+3MyUGmbxKHP/XMp+DP4O9l3oUBgy3lk
         qon0alQshwB+3DuZ8yDkVYmCYF7PUGUsrdXiilwtosew3AZlXI2QUdGJLhXCgJncMY3T
         3ISKhpp3jftJz0goCib7oAPYqSGZlK9MRH2HZrDnIZk1C0ksFqRWkyCF89XV19iIjuy0
         sRp33hg7rb6fg6KGhpEIVy3VHWwZv/xJTPkEVyPx8XaorjBLzZ2dwPfmkXL7WUaHfhzs
         lorRp7v/0sKU+NTaBvUUVWTY7ougunxwSAhiPKouX4FITE1Fh75A+3GeNTDI7MyOyt22
         nPSA==
X-Gm-Message-State: AC+VfDyGUTPjs3Xp5S1XAfejN0AoKYTgNfdhy34canl+0WTvtdRWeWII
        9ml5rjdD4i2bmDwkMjR2q86rdSoOz2Y=
X-Google-Smtp-Source: ACHHUZ5QjwgSEHRqPrjDXEbsVON9YCMlVnyGrWTi/k3v/50uwBtJVqdAIyNjmcXUfq4aKLUMwdFVqQ==
X-Received: by 2002:a05:620a:1723:b0:75e:b9f5:9f70 with SMTP id az35-20020a05620a172300b0075eb9f59f70mr1417567qkb.7.1686128252102;
        Wed, 07 Jun 2023 01:57:32 -0700 (PDT)
Received: from [172.17.0.2] ([172.176.229.24])
        by smtp.gmail.com with ESMTPSA id z2-20020ae9c102000000b0074e0951c7e7sm5528302qki.28.2023.06.07.01.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 01:57:31 -0700 (PDT)
Message-ID: <6480467b.e90a0220.2a165.096e@mx.google.com>
Date:   Wed, 07 Jun 2023 01:57:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3351159804074897330=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: cleanup bound BISes
In-Reply-To: <20230607082011.4915-2-iulia.tanasescu@nxp.com>
References: <20230607082011.4915-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3351159804074897330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=754765

---Test result---

Test Summary:
CheckPatch                    PASS      0.71 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      33.93 seconds
CheckAllWarning               PASS      37.72 seconds
CheckSparse                   PASS      42.03 seconds
CheckSmatch                   PASS      115.65 seconds
BuildKernel32                 PASS      32.34 seconds
TestRunnerSetup               PASS      443.80 seconds
TestRunner_l2cap-tester       PASS      16.49 seconds
TestRunner_iso-tester         PASS      22.45 seconds
TestRunner_bnep-tester        PASS      5.39 seconds
TestRunner_mgmt-tester        PASS      110.42 seconds
TestRunner_rfcomm-tester      PASS      8.62 seconds
TestRunner_sco-tester         PASS      7.92 seconds
TestRunner_ioctl-tester       PASS      9.15 seconds
TestRunner_mesh-tester        PASS      6.80 seconds
TestRunner_smp-tester         PASS      7.84 seconds
TestRunner_userchan-tester    PASS      5.67 seconds
IncrementalBuild              PASS      29.24 seconds



---
Regards,
Linux Bluetooth


--===============3351159804074897330==--
