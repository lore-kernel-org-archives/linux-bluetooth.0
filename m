Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39DAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Feb 2022 12:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiBZMfE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Feb 2022 07:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiBZMfD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Feb 2022 07:35:03 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7661CFA39
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Feb 2022 04:34:29 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id bd1so6940535plb.13
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Feb 2022 04:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=8dkuS8nFyIVsukgEQxusb2IPuh+3SCrADuKPiyVZFG8=;
        b=Agb9+R0/19FMVlm10Z+bAJEK5SfZJ/EiFq/MqwMTDIbqpwtyF2B+J/tFvoaYRRQtFY
         MKO77G52og12rzIM8eUJuJXJqHp8OpVdOVKozTDG1EP1hra/PeYDfcNCTfJKJLnMTzi9
         FwtYWEZLYSv9iwW1bNubpXIQwC3LoqCI05SfnTh372aBbEH93J3DD52j8ErWia4ywaIQ
         wxrknWwfjMFg1jOCc3u6N9vD6hiQ4WNBwhLBOv7dodlLB1zFsvUpgOs50qwGClv4bldh
         PWAnkF8nF38SJSqmv+Z5LBNSpccFf3LqNDAxf0YXAR0/bQJGr8wFEB8j1Eh2nZUf7kUK
         EAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=8dkuS8nFyIVsukgEQxusb2IPuh+3SCrADuKPiyVZFG8=;
        b=zdeYeR3v3FtZ/i/G2fCcFgFFvFYC09PyMlEm6sypM6OMxAXMBTxeaCkwbJd07tlmpa
         TWsaT+R1o9IHvr4R6lGUSvxIIT16FuYhjKFASMKhw824yaKx/DxNb/n9sf2H7KMQMjAH
         SxI02XWnDcljJbi91C4+bKud6cix/FPxS2x1ybTjdicIwgAhe8xwdYHvUscNlAw+WxA3
         xwuyfEZ1R/qPisjkgNpW4YLInYt8ep0WsoFtUnTNT0ACmNgEA5jyRwNgp7Tlm8tCRKdU
         Bt6uOCfPSr1i1KMKcDKwebHwArx61+T3Fw8EhPjAM9xDc1eTpHVm6P8n2ewag2Y4IGAd
         3ZPg==
X-Gm-Message-State: AOAM530VYA6t5v4fMxKHfJT8XSKBxjLk8lbFAO93rndj2Wyo+lFUPGQZ
        Fn0mMCHR1cJxqKWkhdRzFAkicim6rLE=
X-Google-Smtp-Source: ABdhPJx0vLWX6zIBxl2Jet1wpsDwKb/48G1aNmQq6/dmv8ogrU9n9hhUCZldPAE9DwqlI31wsAJM5A==
X-Received: by 2002:a17:902:b091:b0:14b:4b27:48d1 with SMTP id p17-20020a170902b09100b0014b4b2748d1mr12055811plr.52.1645878868276;
        Sat, 26 Feb 2022 04:34:28 -0800 (PST)
Received: from [172.17.0.2] ([20.114.41.193])
        by smtp.gmail.com with ESMTPSA id s17-20020a056a0008d100b004cce703d042sm6826743pfu.32.2022.02.26.04.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 04:34:27 -0800 (PST)
Message-ID: <621a1e53.1c69fb81.c033.11d9@mx.google.com>
Date:   Sat, 26 Feb 2022 04:34:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7538114553431303715=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, andreas@kemnade.info
Subject: RE: [BlueZ] gatt: sanitize input at profile registration
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220226100836.1540367-1-andreas@kemnade.info>
References: <20220226100836.1540367-1-andreas@kemnade.info>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7538114553431303715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=618281

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
GitLint                       PASS      0.38 seconds
Prep - Setup ELL              PASS      51.10 seconds
Build - Prep                  PASS      0.62 seconds
Build - Configure             PASS      10.09 seconds
Build - Make                  PASS      1750.78 seconds
Make Check                    PASS      12.32 seconds
Make Check w/Valgrind         PASS      517.24 seconds
Make Distcheck                PASS      280.39 seconds
Build w/ext ELL - Configure   PASS      10.10 seconds
Build w/ext ELL - Make        PASS      1730.19 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============7538114553431303715==--
