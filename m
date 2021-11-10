Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149FCC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Nov 2021 18:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9CC56115A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Nov 2021 18:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhKJSlr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Nov 2021 13:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhKJSlr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Nov 2021 13:41:47 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82175C061764
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Nov 2021 10:38:59 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id g18so3448409pfk.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Nov 2021 10:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=oJdzx1C5XEQO4N7+XSq3sZ5aSqf6720au8otV8XoUxU=;
        b=IQy0bXsT2TEeIty+zQGZfTlqpoPfwpcSE0v8y1TW4mf4aNfgbt32uGPZIcgVz4snxN
         p+JU0fxuDeUES8Kynz7Ut7gGPafpmV1BSaTd7qGoPInUuKGK2LUO+5J3NI1tUhp6hH2Z
         fNSAXDcbRRwUIca2sjjekcOKpoJ+AroTFEKtp0xsPzNtcZNip0DWRfmUdHU4q0TyzwOZ
         9qMoLoLL3h+cyAq9olJpvCDsw7VHWjopIcQqmOo93MWtlJ7rjZAo6oXQcg3rIKAZSlz9
         4BRFiRsruNEZiGRDzekLyxBruJYX3HGORxkWFY1vnbRV5piCsKp4QEZalUsOHuRvkYpy
         /Liw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=oJdzx1C5XEQO4N7+XSq3sZ5aSqf6720au8otV8XoUxU=;
        b=K3crhD5qsPmVLjRBQ2Axxfzjyg9njtpIES0tym29F6me4oWSuZz4mrIHZI3Gcg8G9t
         xPRFURb6rqTcog/J8mOzc1aixX6wyuOveno80g8XeXqsEfYHmoAWHSYSVjFPCNQ3E1+y
         uSORKkA7v5ZX+cQ4rw/TGIXtuK1Go6Igip8/Akz0LNozz5m/gIW7Ko61YUh4pE+LD5ki
         MmZJY9896ACw9r7R3wxmhV2mCc03yXs76Cbf8G2FoP4zJWydIdJe6wWeiegZYIIRLfJi
         0RzRrNdL7BIoInHdaASag7w2NGACaVYr6aqiWL9ht6ZTDpDt9/QKNq7otzGAl2v+bk7h
         SFog==
X-Gm-Message-State: AOAM533Sk264zUJGbIir4wchE4TPdiBiobyueVKoIorCm06sBrdQmp1I
        Rda9/v8i9QED7nl1dtfT+6aIGUgngTo=
X-Google-Smtp-Source: ABdhPJy4owyzYeijTaUC/XdKcpDHL4JQFTl7xLcZJr+xN5Bi3X+D2jZoiE5s5ruiu/FiaZIL82QQUg==
X-Received: by 2002:a05:6a00:22d2:b0:4a0:93a:e165 with SMTP id f18-20020a056a0022d200b004a0093ae165mr1247569pfj.68.1636569538711;
        Wed, 10 Nov 2021 10:38:58 -0800 (PST)
Received: from [172.17.0.2] ([52.183.92.217])
        by smtp.gmail.com with ESMTPSA id q30sm253239pgl.46.2021.11.10.10.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 10:38:58 -0800 (PST)
Message-ID: <618c11c2.1c69fb81.8a500.12f6@mx.google.com>
Date:   Wed, 10 Nov 2021 10:38:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5894536362697585916=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] mgmt-api: Add new action to Add Device
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211102221046.23293-1-luiz.dentz@gmail.com>
References: <20211102221046.23293-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5894536362697585916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=574409

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.30 seconds
Prep - Setup ELL              PASS      48.29 seconds
Build - Prep                  PASS      0.21 seconds
Build - Configure             PASS      9.06 seconds
Build - Make                  PASS      207.87 seconds
Make Check                    PASS      9.27 seconds
Make Distcheck                PASS      245.43 seconds
Build w/ext ELL - Configure   PASS      9.03 seconds
Build w/ext ELL - Make        PASS      197.71 seconds



---
Regards,
Linux Bluetooth


--===============5894536362697585916==--
