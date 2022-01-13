Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF54C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jan 2022 07:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiAMHbu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jan 2022 02:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiAMHbu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jan 2022 02:31:50 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39055C06173F
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jan 2022 23:31:50 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id h16so6353971qkp.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jan 2022 23:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=debsy8zS9W0+gqMZm+r+xlr/YLM1F27mVCyIJUqdoqc=;
        b=USkrLNSecyOEnxdnqFpMrip+5ckAFyEU+BdLNaFV+M6IOr/21QmpumV6eDOMCS+pnX
         2yFc8kF1Ugh4PdyUGZ228BJAnNLoBjRfardrKpYTa6Vg5amPfHR/XDdEDJCRmR4JPQyS
         ZMoryHhiUtZs9MNrDq5AMBX9balDO+7CqpGrJ4yF/Hn66TG+iukF7QTMF1zDVa2Ps6G3
         0qKTa3esk3GgXAYuNk/wUnOb5HXfsBYY6vvjVZ7xfvmKRgAFcdzBwOlsZGr8dPs8Cd0s
         iu2RUDIbM3MOLGso8i/BcoPpwy5zn53L/ACINQOHOIV3qOaDfID3alwsW30T40jI1sIC
         y5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=debsy8zS9W0+gqMZm+r+xlr/YLM1F27mVCyIJUqdoqc=;
        b=ijvT5zEvx+239yu2z+z04TVxZ1Oyo8bKbnMqBLOUHaXZiiEijUHoLpbkEdmmem9WGv
         iMO/nN9WhU26IBpMZiuqanK6gTh4qXyI2KOt58Mjdkfd8TjGWmRWfbkHlsn7pAOptbfZ
         UzFPLd6M3Cm09m2Kqy9pMzLnk8II9HsrELVFnmf07BbF5ycjixJlcCI2KV9Wob4myKy/
         kmK+pEEQhkuCpmBqSTrxebovr/JTSYdbtMAbhpUZYcpwxfQ1nc9wxmaFhY1QGLDCuH44
         LPpQ0Dxe3wD0J+CNhB6QmvWi3tGEFqLkByZF2gjNh29VQwRNAci1W8D0gUvZd/hG3Cca
         pVzw==
X-Gm-Message-State: AOAM533onavEzOQzcAoFusiOPG1DTkKpbp1Wj2o1doCaP0RSyo1uhL3s
        gkmJ/pLC/Bm0p6kOKF09VVw07yrhpiIFhA==
X-Google-Smtp-Source: ABdhPJxSiS06w7tG8pomQodRuvYxTLMAd8nbLlhR2B4C+Xn/BIoF61rCOPexV0zR3hMRbvq9eEokjw==
X-Received: by 2002:a05:620a:1791:: with SMTP id ay17mr2294285qkb.78.1642059109245;
        Wed, 12 Jan 2022 23:31:49 -0800 (PST)
Received: from [172.17.0.2] ([104.209.180.152])
        by smtp.gmail.com with ESMTPSA id bj15sm1323521qkb.39.2022.01.12.23.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 23:31:48 -0800 (PST)
Message-ID: <61dfd564.1c69fb81.2f1e3.773d@mx.google.com>
Date:   Wed, 12 Jan 2022 23:31:48 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5732339771332155270=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez] device: Fix device can't be scanned for 5 mins after reboot
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220113141533.Bluez.1.Iad485a29772515142eefb1b120d5eb5e101d82f6@changeid>
References: <20220113141533.Bluez.1.Iad485a29772515142eefb1b120d5eb5e101d82f6@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5732339771332155270==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=605086

---Test result---

Test Summary:
CheckPatch                    PASS      1.37 seconds
GitLint                       PASS      1.00 seconds
Prep - Setup ELL              PASS      42.67 seconds
Build - Prep                  PASS      0.67 seconds
Build - Configure             PASS      8.57 seconds
Build - Make                  PASS      1416.24 seconds
Make Check                    PASS      12.01 seconds
Make Check w/Valgrind         PASS      446.97 seconds
Make Distcheck                PASS      219.77 seconds
Build w/ext ELL - Configure   PASS      8.66 seconds
Build w/ext ELL - Make        PASS      1400.11 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============5732339771332155270==--
