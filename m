Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE19C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Mar 2022 03:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiCZDDN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Mar 2022 23:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiCZDDM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Mar 2022 23:03:12 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144DB4F466
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Mar 2022 20:01:36 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t4so4831201pgc.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Mar 2022 20:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=AZK3qIdJ1yG5dPf67VSR55OckksFVxo8zLyeKzjzR+k=;
        b=JZhHUzs6te4enULEN050KnzJx5Oz1NFzJVZlN2avz4LUNthPh1Y1+/Sm4ZE6i9TNOT
         YZ8BNoY5ZFYIjijAkH1P+BCknlEWAVeYlEDI/mY9pqmeLbQMrj9fqxCuElDPGzZlcbIn
         yuAj8vf+hPPC+QDWQ1HXtb+3+hkXj7i1uFRoVDgtDq+CgYF3tYlpJ1WZ7Ww2yCmR4ZT1
         bNQgGH+lsweEGze9ZsLpyYu9RNDyR2LrDtmr3CQ94fHDDYJIAd7dcqWJcUdUCSR9pJCr
         FM5GPYmkQxCGmSTYi/s5UXJDRuJMn03mRymYXLPFRFcuky/i8VKiPQLySook83ClG8os
         dgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=AZK3qIdJ1yG5dPf67VSR55OckksFVxo8zLyeKzjzR+k=;
        b=khWjVyZ8Uh5PB+7FdX8HsnkfTozOOiiXavUOVlYeH2hj0KDK1xW1V2JIf9m8X9nKbi
         Q92+TBlapBd2B1XBEI4Kdf9nxydd+2olMTeEp97BiYdb77hQZEHDHclh7KgQTXwDg7Fs
         yyv+StzpbpA79ncHmvxHzQg3IsTtd/W4ylRftAvJa4uV+s8+aYWsInP1b02NwfKUBYA+
         EO98m7DyWa9/bplUAEV1eU9HAyN56wd31Ri40dpJliGxcVAvb4iJKHpI5gvMt97PgM+6
         AEJMrrT2GaFSYGZa4vjI0vHD5ERBzhbNEv7bIvp7o2vPaofMfvKtrcZzGDcnBah219lj
         dLwA==
X-Gm-Message-State: AOAM5315+wKzq3l3XWvMNMet+nU8icwx7MAzx0XWYv7m9P780qgZSX1S
        3OXUycfM8KrZmDJ/JCv8d7dvFH6AVWk=
X-Google-Smtp-Source: ABdhPJxbtg92NW0/SGBuI6I8YsRBfNI6h0yb3nits+X7GNSCm6gTmcs1/57SY0EVGwzBAGUCEZaCYg==
X-Received: by 2002:a63:7f50:0:b0:386:2b5c:9d16 with SMTP id p16-20020a637f50000000b003862b5c9d16mr1967435pgn.153.1648263695343;
        Fri, 25 Mar 2022 20:01:35 -0700 (PDT)
Received: from [172.17.0.2] ([52.190.195.239])
        by smtp.gmail.com with ESMTPSA id j14-20020a056a00174e00b004fb100a1b51sm4092846pfc.94.2022.03.25.20.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 20:01:34 -0700 (PDT)
Message-ID: <623e820e.1c69fb81.cd3ef.c2c0@mx.google.com>
Date:   Fri, 25 Mar 2022 20:01:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1864897963062018469=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ,v2] mesh: Fix address overrun error in rx filter
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220325234625.24642-1-inga.stotland@intel.com>
References: <20220325234625.24642-1-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1864897963062018469==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=626461

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
GitLint                       PASS      0.45 seconds
Prep - Setup ELL              PASS      51.63 seconds
Build - Prep                  PASS      0.68 seconds
Build - Configure             PASS      10.01 seconds
Build - Make                  PASS      1755.44 seconds
Make Check                    PASS      12.14 seconds
Make Check w/Valgrind         PASS      531.49 seconds
Make Distcheck                PASS      279.33 seconds
Build w/ext ELL - Configure   PASS      10.12 seconds
Build w/ext ELL - Make        PASS      1723.72 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============1864897963062018469==--
