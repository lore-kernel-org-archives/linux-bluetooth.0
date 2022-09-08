Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973B3C54EE9
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Sep 2022 00:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiIHAas (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Sep 2022 20:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiIHAar (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Sep 2022 20:30:47 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F8472FD6
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Sep 2022 17:30:45 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id a22so11739950qtw.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Sep 2022 17:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=f6/VxKKYFxnkqMYuzBIhRZ25QSTXVn9kYeoQUTtVIOY=;
        b=nfPsqzS4/0DZWZlIPqHq0Vza3MbyQ7lhXDzMZBGkYP583SGrWjQxV6u5/ACUhu+c+4
         ZhyHyHWlpolOMar1djNmORaEat8eO/CiYDpE0mVOtAiiAtGMsEc1+2lv2m2ckjKX5Tt/
         D53TyOtyEgFpM7D5vxlQwyj5+ItoZL5T146U0ubfa2OkRf6nL9mZoefckWBQWqPynKnv
         0IkaMb6gyUb+gTSwB9M0OAtR4V3Rmex02+V54s8a0c89X3NWkNVhuQWwrY+AfR36wUNN
         qnOZY+PXOHhzBgNmXl587llCCZuqb9GUeUUipaXq49JRC9xThJgk674enUEzin6kMGeR
         4CsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=f6/VxKKYFxnkqMYuzBIhRZ25QSTXVn9kYeoQUTtVIOY=;
        b=FAH36anUvdRO5BYayFyH6jPwK9pLfztvCsH1vJXzbCYfwxLeZVzSfNlVYtD6i1ZOum
         o71g2MrNnfZZjOWkcLEN3wRIUcfOpC7ij3ewsn8qPR4Fybcs7MOvdWhuC2mmxb2zk0YP
         HdDVK9SyQd0ZKhSTmBzKmkGwOntr1qhuL1aBXHa18DwzbcZmW82saQTGpJUW65erbxpD
         lIKvsdtyCVOf+Z919W20zHa7eICOSlDSdhymcGIuSavMC/P3V7FM1S2M7tYktrbdz+oM
         3nl2fb3P3a2GUjOOBdh+GS1Xjt+nRZhUQlJAJmoP3TCwLUmiZL6v63SxZ4y1abeVmwPN
         FVDQ==
X-Gm-Message-State: ACgBeo1qDISLslQeodFamsbo1OV6AYyLWmo3QnFda+NnqKFCxlWDvKic
        glgb3KpW67I0mlAz6yOteHOaxzHNtNE=
X-Google-Smtp-Source: AA6agR60Xk5y6+KojyozXQL1RiiZv2pI7Sq66mTBIc61X8yR8JoJKYR0XmPBlnMTDwZNG7nHKGnQyQ==
X-Received: by 2002:a05:622a:1a27:b0:343:633:f514 with SMTP id f39-20020a05622a1a2700b003430633f514mr5668753qtb.456.1662597044802;
        Wed, 07 Sep 2022 17:30:44 -0700 (PDT)
Received: from [172.17.0.2] ([13.82.53.206])
        by smtp.gmail.com with ESMTPSA id l22-20020a05620a28d600b006bbc3724affsm16897743qkp.45.2022.09.07.17.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 17:30:44 -0700 (PDT)
Message-ID: <631937b4.050a0220.6983d.8f0c@mx.google.com>
Date:   Wed, 07 Sep 2022 17:30:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4093704232880881496=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] mgmt-tester: Fix Get/Set PHY tests
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220907234900.3258263-1-luiz.dentz@gmail.com>
References: <20220907234900.3258263-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4093704232880881496==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=675035

---Test result---

Test Summary:
CheckPatch                    PASS      1.46 seconds
GitLint                       PASS      0.96 seconds
Prep - Setup ELL              PASS      27.19 seconds
Build - Prep                  PASS      0.87 seconds
Build - Configure             PASS      8.70 seconds
Build - Make                  PASS      966.62 seconds
Make Check                    PASS      11.90 seconds
Make Check w/Valgrind         PASS      291.59 seconds
Make Distcheck                PASS      241.36 seconds
Build w/ext ELL - Configure   PASS      8.72 seconds
Build w/ext ELL - Make        PASS      84.51 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      516.53 seconds



---
Regards,
Linux Bluetooth


--===============4093704232880881496==--
