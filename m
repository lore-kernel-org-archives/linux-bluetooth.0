Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01C3C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Oct 2022 14:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJKOjG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Oct 2022 10:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiJKOjD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Oct 2022 10:39:03 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0ED397ED7
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Oct 2022 07:39:01 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id b25so2723528qkk.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Oct 2022 07:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t/Vq35my+CjS+v52fICxItFotmkUhljjRTM7lvDGXKI=;
        b=lH0v0YjW1uSA+bqZZyoFn796Mx6h8TpR9/M2vq/3nV7Sa5bo7SXCOeYrVj+YarnPNC
         Xhll3JNKvV2BNbB2GO1x8xMw22s0JuzmOsbDKnwyR0Smb7qtxKuNmXPABbega611mc35
         eocHrTGZAME/gMF+iOurqulCuquDnB4J4cHZ6cHQ0egmHY44bcjfdM3oALwkxYXYRoys
         Oi0azUi9wniNbdJGjZs8X9iE7DGxNRirHsI+ML2qaig86JsXEUyRgLYNHBSu3oMiOsN3
         s7OYlp6eat2fpBl3DtI26BkYLdkMMJg+ky4yOT7YNHsjm1Mz/E9G8vMUYkuyKE5XOxSd
         0rbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t/Vq35my+CjS+v52fICxItFotmkUhljjRTM7lvDGXKI=;
        b=SFB6jPvSzqAByAlqI3aICg2+FnIPj9xBikxJ0c8cqC8B7qXEzwY3pfZOi/1vcdRkI+
         yKy6tPsN7VWMCNTFJIEB0HiWMsahmrj3/HOuleLhhcnrgzvGeVjVRKgmJmssS1uUhIBo
         jupy9W9nRCCSrRBS2XxXv2nG05LEI5FpVIIGyHt6DLRhRjLoUrGCIJl49VhTB2bVxHGa
         a7pfAVG+Dth2Y7gtp05jD5P+R9CGOsHYXl2mXThM+c0FUoClkRYks6XT3SoQARpg/BXi
         GI2SXb/MTrrvrA5zU6lX5pZm3I7HE+0qVZ09xkTy6JB6CBp/Eeuo4RwhLO0Gy1S85nAr
         5Xeg==
X-Gm-Message-State: ACrzQf2cqeI+jWxpm61/tb0nHut73zfiWh4BStmGZ85jDZxj31O2hIab
        SBTgDO7Tz2uxWiQnkrZ9l+Ney0c9YEKHAA==
X-Google-Smtp-Source: AMsMyM4av/bUej6UGSigti9Bv6m0vvkKxxIEeYRvUXHh8RWs36Q8ekfnFDciMsqOJZsrohleLeIxwg==
X-Received: by 2002:a05:620a:2892:b0:6cf:60a0:84ec with SMTP id j18-20020a05620a289200b006cf60a084ecmr16168654qkp.574.1665499139799;
        Tue, 11 Oct 2022 07:38:59 -0700 (PDT)
Received: from [172.17.0.2] ([20.7.164.139])
        by smtp.gmail.com with ESMTPSA id q22-20020a05620a0d9600b006c479acd82fsm13440833qkl.7.2022.10.11.07.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 07:38:59 -0700 (PDT)
Message-ID: <63458003.050a0220.a1043.8505@mx.google.com>
Date:   Tue, 11 Oct 2022 07:38:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3382387145639350390=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, isak.westin@loytec.com
Subject: RE: [BlueZ,v2] mesh: Keep canceled SAR data for at least 10 sec
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221011134315.1836-1-isak.westin@loytec.com>
References: <20221011134315.1836-1-isak.westin@loytec.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3382387145639350390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=684508

---Test result---

Test Summary:
CheckPatch                    PASS      1.51 seconds
GitLint                       PASS      1.05 seconds
Prep - Setup ELL              PASS      27.23 seconds
Build - Prep                  PASS      0.84 seconds
Build - Configure             PASS      8.57 seconds
Build - Make                  PASS      858.05 seconds
Make Check                    PASS      12.44 seconds
Make Check w/Valgrind         PASS      292.22 seconds
Make Distcheck                PASS      236.01 seconds
Build w/ext ELL - Configure   PASS      8.85 seconds
Build w/ext ELL - Make        PASS      85.34 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      512.73 seconds



---
Regards,
Linux Bluetooth


--===============3382387145639350390==--
