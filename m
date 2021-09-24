Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB43C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Sep 2021 21:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C51CA61242
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Sep 2021 21:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344112AbhIXVhO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Sep 2021 17:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbhIXVhN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Sep 2021 17:37:13 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C017AC061571
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Sep 2021 14:35:39 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id 73so29774090qki.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Sep 2021 14:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=r+XJZlHSV9HEU+vgLj7LMdmPdxohqONuaY4QgMYVbIQ=;
        b=ES22Z6xWJA6oGbrsRaO42hh/rODr64UMr6M5cn91IIokk6Ez3xe74iwdYCshvZaRjA
         KjGelI8of1boC+4PDjJIorKQ674FZlmpt2mAa3VBg4Z467yvHAY84Ir0nOl0uRHRWdtR
         EXm71h07tnpakMvmEZYPAU00MaU00yW1+Hz/TrL87LacF4L3TPyHtmLrul6fFbB/Gwo9
         2rdY5aN3j5MabljvGSuulCS1X9/wnFEsgqjYEXSbR1tEcYIbsCePyT6b8yMEe+aHslgx
         WY+pI/+svNBReRU/Y1Srwo7zgAwfiR0frvHDPi9KWJugeTLMnWDAvrRIUxotmB0ngOCL
         w3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=r+XJZlHSV9HEU+vgLj7LMdmPdxohqONuaY4QgMYVbIQ=;
        b=PhPpo6VzugmyMa2BbFfHWHcWIbtNaT0yD5hiHTMe3v0R103TBr6dXERgd1BM3BhsQs
         mBXzFUMhV3Ka+RW2CA5bKAXPpN0ItXAEUhKl7sWBOVLbmaBWLNQccE2ujD9yidaMxFa6
         SbLLNL4zr7femT0y2FcuteEZ+U1lXeV9F+MLcUBVNuqO+y27mo0KuKnqg5iz33+DXA5g
         aiSxOSBshDBMXEbpxfiGqAJutRYT5N61mZrmsjhOhJD5LXK5t+UnaWmeDGpyJd4RKAiP
         oeLGzYz8h5FrDyOuolSD+UOHaC9R7pIKOxSavOIKLSmKIiAVUT0YY63WvYso/sBanukX
         7zvg==
X-Gm-Message-State: AOAM531Kk1sCfdqlBpZ8cRrOMdYZzlmVL5tM3mUkWjGNkalyN14NvkS1
        foJ3BuGMhvj+zlHiAYCJMAjm+gsZ48teTg==
X-Google-Smtp-Source: ABdhPJxKMox5ZMnJIPkWA8DaA/c9pvAtRpHaHeBMSOugq/iK0Yrlr2zok7s92ByFXxm2ZKcaffAkag==
X-Received: by 2002:a37:a850:: with SMTP id r77mr12908469qke.52.1632519338734;
        Fri, 24 Sep 2021 14:35:38 -0700 (PDT)
Received: from [172.17.0.2] ([104.46.121.241])
        by smtp.gmail.com with ESMTPSA id h2sm4122705qkk.10.2021.09.24.14.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 14:35:38 -0700 (PDT)
Message-ID: <614e44aa.1c69fb81.97ea4.01fd@mx.google.com>
Date:   Fri, 24 Sep 2021 14:35:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1040330872781233634=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] avctp: Fix not handling when kernel has ERTM disabled
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210924211824.2318562-1-luiz.dentz@gmail.com>
References: <20210924211824.2318562-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1040330872781233634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=552627

---Test result---

Test Summary:
CheckPatch                    PASS      3.15 seconds
GitLint                       PASS      4.05 seconds
Prep - Setup ELL              PASS      53.45 seconds
Build - Prep                  PASS      0.52 seconds
Build - Configure             PASS      9.81 seconds
Build - Make                  PASS      238.59 seconds
Make Check                    PASS      9.85 seconds
Make Distcheck                PASS      286.99 seconds
Build w/ext ELL - Configure   PASS      10.04 seconds
Build w/ext ELL - Make        PASS      227.25 seconds



---
Regards,
Linux Bluetooth


--===============1040330872781233634==--
