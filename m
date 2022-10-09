Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C2AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sun,  9 Oct 2022 08:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiJIIKU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 9 Oct 2022 04:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJIIKT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 9 Oct 2022 04:10:19 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E240625C50
        for <linux-bluetooth@vger.kernel.org>; Sun,  9 Oct 2022 01:10:18 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id i6so8410541pfb.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 09 Oct 2022 01:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KZVzLyB++CFzT3KEkcXZ5JNLfOlFxypYk6nHy1imv3o=;
        b=dDSfQTC9jLF4AbCgaO2zePXVO0TsBp1XHmX1Uzdn+RLZ2uriRsS7QVof4xSU0Emq5U
         iIv+D0LnSogU2QeVEiCq05gx2OX8lMa0xE2ljjCGexvV31HZOfm4QsX8R4GBnvOzMVIj
         cpvObJ3uC92hKchQdlF8d6oTmP6YE3E4hc1wZ8D5lxl0+1YAEIxhgIX5uUNZ+X1LLwVA
         QtyQT4uMHJaxtRpiJZiYljtZg/XXF9qa72W1kj/3n5l84y0MQQrSUqPlM3bctjgZuvf+
         Qpq0i9L+f4OGhrBvYXITDtaCMC0Vbc0r6EKcCSZShT7bWPboiqZPg2XAYf4GrQJqzGbN
         hD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KZVzLyB++CFzT3KEkcXZ5JNLfOlFxypYk6nHy1imv3o=;
        b=VPjlQXXIX2peDiz29F0TzHAT0zXGM+PBf+VUNxGKDpNjpff7gSYxL6lYSqBFVyO2Hv
         uMMz1JD3LtGPRNO3XakYQqj+/zGRCK2HSHCch06clARSnrMVKYMI8Wge6892O6DtgXSF
         DD54hV3kS5l8BLI3QzbaoOus5I06UG0OWoTkng5YQrcBZWX78D/ZDUtNN5lZzuCdgmRK
         HMeJEnB6s9og/c4GbvuG18aqhkUfffZncRcy/tfUn1HKtnPWPM4qrnIBY25hFOsKOZ1Z
         +vJ686mH4HCr8eWS4m0aNUnSmnDgcFsXbl+LrkPUWMETRi0fyS+O/ypjPYxwIS8uAqW/
         etfg==
X-Gm-Message-State: ACrzQf2/RNvdtfPo1/Qpc/91wlvcspS2RR8iQAH/AY4fWFJM9UMjHhub
        7hzhYSkY3GmcOQJm4baSOdXFL11RYKI+4K+P7JpRkejtO3Q=
X-Google-Smtp-Source: AMsMyM7zCdkYARjMsPPrHRMgYQ6BY2TogmDwy+obV0hmy/nDZF0eeD9PiRE6hzcXfwBXtocufXjP2gM0YOwv3jy5JfM=
X-Received: by 2002:a63:1d1:0:b0:43a:348b:63fd with SMTP id
 200-20020a6301d1000000b0043a348b63fdmr12211490pgb.52.1665303017839; Sun, 09
 Oct 2022 01:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221007061223.46114-1-sathish.narasimman@intel.com> <633fd6b4.630a0220.c2ace.1c2b@mx.google.com>
In-Reply-To: <633fd6b4.630a0220.c2ace.1c2b@mx.google.com>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Sun, 9 Oct 2022 13:40:06 +0530
Message-ID: <CAOVXEJK1U3FZ1mGxSuLFqT6KKRcbt8CF6OknqU6Ps3CpvBy_4g@mail.gmail.com>
Subject: Re: [BlueZ,v2,1/3] audio/transport: Add volume callback to BAP transport
To:     linux-bluetooth@vger.kernel.org
Cc:     sathish.narasimman@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi

On Fri, Oct 7, 2022 at 1:26 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=683646
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      2.41 seconds
> GitLint                       PASS      1.40 seconds
> Prep - Setup ELL              PASS      31.92 seconds
> Build - Prep                  PASS      0.66 seconds
> Build - Configure             PASS      10.33 seconds
> Build - Make                  PASS      963.09 seconds
> Make Check                    PASS      13.13 seconds
> Make Check w/Valgrind         PASS      347.55 seconds
> Make Distcheck                PASS      292.36 seconds
> Build w/ext ELL - Configure   PASS      10.51 seconds
> Build w/ext ELL - Make        PASS      101.36 seconds
> Incremental Build w/ patches  PASS      359.03 seconds
> Scan Build                    PASS      624.27 seconds
>
>
>

Please help to review the changes


> ---
> Regards,
> Linux Bluetooth
>

Regards
Sathish N
