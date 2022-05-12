Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC86DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 May 2022 03:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242503AbiELDQ7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 May 2022 23:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbiELDQ6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 May 2022 23:16:58 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AECC67D2F
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 May 2022 20:16:55 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id g3so2193329qtb.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 May 2022 20:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=J6BEHoNhTyg6RXmNNM/ZjsxjCWDLxVsUNbPfAQLslH4=;
        b=ov/rShXGt6acMBvp8DvbeiUI8UO6rhz9MS+I35d+zk5e+1tBTYrViS9kinvmg68XZE
         VRBbWCus+Ao+iycNzkFLSW8d5wShL/icFJPapHYpfZplTcYfVPQHV+YJcfOxiEq9L0ka
         qC8KsIAQI8BBJeixFfi6cGHulxNcxp4h2xeF9QYmkwaaaJaZOnxlSrDeKztlIUy7VIdW
         fd6YlWNKWdAkr8qk1/2cd/oF583vNGNtkL6EWAgkdJkT7h/lp+axx7jSYJYdgK9i4yWo
         IPt5npV4y/+yfCVXz7j2s7wVXWpOhD/8QV2hmNAFnnGM3DkM68Ovd4heDKzGEi5Ru3rw
         FE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=J6BEHoNhTyg6RXmNNM/ZjsxjCWDLxVsUNbPfAQLslH4=;
        b=2RudBNcx5tHeDGHiSCRbSMOCf+bOLJOvc+qnEAuiTYJExRaSBMns7bb/ayAGtM+pxE
         Ft1lHRPcR6iNIsLgjLlSy6RLEueXJnb/HJswuNsdSAAWkJ46hNqzZvR6GU9TP1+hQA5c
         u5A+r+dj/IY+yYZuaBmSrLCoAG3ElUnz+9ejmClDyI0Nv+Oiid/L8/aFqYlVy24O64Gw
         C8GHAcMlLpuPoBLw4cKKYYvaqsbmaqfe5thVFxzkt6dPAgap9/CMdvAQ7L6zIxhMKUbI
         W85Ambtngm2W+BLkPCw8BurN9AEfwGzk9HpmA68QbJw2EPlwL7NgclX5gMaVkGnM4nl+
         Afkg==
X-Gm-Message-State: AOAM532uoDwErbsxq7F8QrmSBmnHvFhjigC5xAmvsW5BK7F5+n8DkPuP
        GU6PKT/zvUGzYIsHYNA8c+1+g1w2t9dQVg==
X-Google-Smtp-Source: ABdhPJwlB9/aO/IhyHsgxgsAanDvNdi5QkomDvbFopjKfnlDVkzJg4NJTPBwpGd0PsRDBkDURy8fHQ==
X-Received: by 2002:ac8:5913:0:b0:2f3:a402:1054 with SMTP id 19-20020ac85913000000b002f3a4021054mr27258129qty.513.1652325414318;
        Wed, 11 May 2022 20:16:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.231.16.59])
        by smtp.gmail.com with ESMTPSA id bi25-20020a05620a319900b0069fc13ce1e5sm2416055qkb.22.2022.05.11.20.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 20:16:54 -0700 (PDT)
Message-ID: <627c7c26.1c69fb81.64cb1.be38@mx.google.com>
Date:   Wed, 11 May 2022 20:16:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6293214756268335994=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] gatt-db: Allow passing Characteristic Value to gatt_db_attribute_get_char_data
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220512005515.844857-1-luiz.dentz@gmail.com>
References: <20220512005515.844857-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6293214756268335994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=640776

---Test result---

Test Summary:
CheckPatch                    PASS      1.66 seconds
GitLint                       FAIL      1.10 seconds
Prep - Setup ELL              PASS      52.47 seconds
Build - Prep                  PASS      0.82 seconds
Build - Configure             PASS      10.66 seconds
Build - Make                  PASS      1520.85 seconds
Make Check                    PASS      13.21 seconds
Make Check w/Valgrind         PASS      538.52 seconds
Make Distcheck                PASS      281.07 seconds
Build w/ext ELL - Configure   PASS      10.57 seconds
Build w/ext ELL - Make        PASS      1484.25 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ] gatt-db: Allow passing Characteristic Value to gatt_db_attribute_get_char_data
1: T1 Title exceeds max length (86>80): "[BlueZ] gatt-db: Allow passing Characteristic Value to gatt_db_attribute_get_char_data"




---
Regards,
Linux Bluetooth


--===============6293214756268335994==--
