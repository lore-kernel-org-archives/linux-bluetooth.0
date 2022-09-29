Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682C3C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 11:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbiI2LWC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 07:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234919AbiI2LWA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 07:22:00 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B2B147F33
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 04:21:59 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-11e9a7135easo1422282fac.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 04:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=x6Tn8HTHtkm2komAmoYIRrtZB95IT/lbGc0TFz+8XKY=;
        b=mAZKkuK0eOIwkqKJq2WmEhq0sb+p7/RA5D/zuhI96EiisL1OnJohaUt6uUI9lf55qi
         Zv2Pgb5sogUVKLum99/Ziw6tLSlyNHlS1m4lMiFbaH5VNGsMtDq/9gxhHDHx3punof+7
         qz0snOTMzDJ7MlCOtCtzEV/f7vBhl5DnSVsITQcoennt4eBBSv+9831B71qynI6vUsNO
         djQleKU9ddhv5APgbVyUm136G8s5pDhV3erVM9J5Aq2Rdqg4o1YVR1FQgVZnMPFnELVS
         kyABLuEg4Yro7jC/jfHrlVYQEnVuN9LTG0OcwhZ2wukBJ2L/EEc2aLW6A0BGj3wQflmu
         oFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=x6Tn8HTHtkm2komAmoYIRrtZB95IT/lbGc0TFz+8XKY=;
        b=G4psa9LNu938ZmFOV0UZu8RyZ1zW56evIxS+1RaxWXUT6IX0Hjg7nB8gBEKBptGY5h
         4cvaat/eshN2VHUvw0O5MffQhR3cUCCi7jm2DjpErOT9y3wG77gJK9vusjeQEP/ZOkHz
         8oQN2HpSHxyn/0TtxDn4dmp96FD/d6rggi08mxYWbgBp1FIRlPFlPJcMNzBYWtS/Q48U
         +A6jpVpeEZ31oZW2QEE1nLk1dRgy5XLnD382ER62MfpCgMV+eiG6gZsPSxR5sIjDPujc
         sL5JqAxuHijb3N7IqR5pIvDo+6T8YJ6QRUNE5GB+BKDoNVjLjZItg+sDOe0ZqCqg0HBu
         h2mQ==
X-Gm-Message-State: ACrzQf3qRdpXI+We9rwkmuf4MRFNmuEcRDzfqqNd8MO+JQys5Hem9P1u
        WxmzgJrh4hEu5/I7SodjTv0QpKfDzLguDQ==
X-Google-Smtp-Source: AMsMyM6chhSbTnsiltB/yzD4RlgotURpyEUtNraGXsK1DdaZdrNLLij2McZX7CcktEsbLHys5RyGEg==
X-Received: by 2002:a05:6870:310:b0:f1:f473:a53f with SMTP id m16-20020a056870031000b000f1f473a53fmr8189259oaf.34.1664450518862;
        Thu, 29 Sep 2022 04:21:58 -0700 (PDT)
Received: from [172.17.0.2] ([20.165.69.160])
        by smtp.gmail.com with ESMTPSA id 99-20020a9d0eec000000b00636d0984f5asm3123676otj.11.2022.09.29.04.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 04:21:58 -0700 (PDT)
Message-ID: <63357fd6.9d0a0220.30164.b491@mx.google.com>
Date:   Thu, 29 Sep 2022 04:21:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5460569372740410140=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ceggers@arri.de
Subject: RE: [RESEND,BlueZ] client/gatt: gatt_register_app: fix parsing of UUIDs
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220929101832.30203-1-ceggers@arri.de>
References: <20220929101832.30203-1-ceggers@arri.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5460569372740410140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=681861

---Test result---

Test Summary:
CheckPatch                    PASS      1.21 seconds
GitLint                       PASS      0.85 seconds
Prep - Setup ELL              PASS      36.44 seconds
Build - Prep                  PASS      0.97 seconds
Build - Configure             PASS      11.33 seconds
Build - Make                  PASS      1236.83 seconds
Make Check                    PASS      13.42 seconds
Make Check w/Valgrind         PASS      372.48 seconds
Make Distcheck                PASS      314.48 seconds
Build w/ext ELL - Configure   PASS      10.68 seconds
Build w/ext ELL - Make        PASS      105.23 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      665.67 seconds



---
Regards,
Linux Bluetooth


--===============5460569372740410140==--
