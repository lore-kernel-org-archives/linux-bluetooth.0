Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7749C43334
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jun 2022 20:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239227AbiFBUko (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jun 2022 16:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239311AbiFBUkh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jun 2022 16:40:37 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0787321E02
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jun 2022 13:40:21 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id a184so991284qkg.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jun 2022 13:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=P/0CRSsWR309VEfdTvmkAH62VoVLPO+9yFTnb7mMTGQ=;
        b=IpvQtHvCxj2V/eKSsvPocTbodlXc7hvPsHfwjWSX2kvJlWwR3mE4uD/RGpP2C1s3q1
         FxgxolZAqx7mhmgdmTe4NzJ+hf5fEIKLbgdLpAD35cBYbnn8zvy8/QM1zTxegKpF4qmi
         41iiyuwoWfNjq3sJO3sPmWiSKFm13n/gFXDQoPBQEx0nYqZne+mkiaKu5gpfa6Z+r3rd
         OZmwiqPxU6YB+Q0bvEeH3JSev2nGSUvtIwDH5SypMoBzGF3N/NgwQh1BKrUw5PszwfsT
         MgwvYu47+Wlnx53LnildlfaWQu+NuwNWiUB/wSgouRrdcbASBOUp822ccRK7vvkGDqSr
         0QSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=P/0CRSsWR309VEfdTvmkAH62VoVLPO+9yFTnb7mMTGQ=;
        b=YO9SY7gYHEc2nYX8IMMJORH3EomHAmU6YspsafXqt2Jna32GK2fdriCizoDPtZCea2
         USg4uYTR5zezCS0l18kLmGo6DMkmh/8f8zfMmdq49m+5XUtpsMVTpZAUG2BjSRO3Rxch
         So5etmk3hneMXa40Wvoje2rtIhdLfm8u8Yd+Yacps5IhtXWegESaEEnIVquXQQZ4DhLH
         qhtem1+SytnQPrTJwptN4nIp/5wbCAGl/x3bcBXKwWIYBGxPFz+6Iomzynfy1pe26RB/
         Mfx38B2QIM4w2AL7aXz/s+oSEddm9gBQxHl4oi+e3qu4M4QMUbyseKT6reAHOSm4fDou
         CdiA==
X-Gm-Message-State: AOAM530GdE5KdF9oiP2QkYgQDYw74szJkw4teSYWyEa8Kw9qeizxmYBl
        bE987QlfJJtBJPB4EIPiozpJlpjZejyz/w==
X-Google-Smtp-Source: ABdhPJyKqWbAIKPgIAtmGORMfioTT2yfchEtkWvOfNW2gnKo7TngyNS7XYXX1TDDeOOmS4Sovv8GbA==
X-Received: by 2002:a05:620a:251:b0:6a6:8f5e:d56f with SMTP id q17-20020a05620a025100b006a68f5ed56fmr1888820qkn.315.1654202419990;
        Thu, 02 Jun 2022 13:40:19 -0700 (PDT)
Received: from [172.17.0.2] ([23.101.150.67])
        by smtp.gmail.com with ESMTPSA id i8-20020a05620a404800b006a69aba9f19sm94716qko.80.2022.06.02.13.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 13:40:19 -0700 (PDT)
Message-ID: <62992033.1c69fb81.c2711.0833@mx.google.com>
Date:   Thu, 02 Jun 2022 13:40:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8453168007326788688=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [V2] btproxy: Allow to select multiple BT controllers
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220602192501.90288-1-frederic.danis@collabora.com>
References: <20220602192501.90288-1-frederic.danis@collabora.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8453168007326788688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=646971

---Test result---

Test Summary:
CheckPatch                    PASS      1.50 seconds
GitLint                       PASS      1.02 seconds
Prep - Setup ELL              PASS      43.07 seconds
Build - Prep                  PASS      0.69 seconds
Build - Configure             PASS      8.38 seconds
Build - Make                  PASS      1350.13 seconds
Make Check                    PASS      11.96 seconds
Make Check w/Valgrind         PASS      440.72 seconds
Make Distcheck                PASS      228.27 seconds
Build w/ext ELL - Configure   PASS      8.47 seconds
Build w/ext ELL - Make        PASS      1339.38 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============8453168007326788688==--
