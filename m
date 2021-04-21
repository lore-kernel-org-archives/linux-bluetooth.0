Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DD8C433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Apr 2021 20:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D80B56144A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Apr 2021 20:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240388AbhDUUYu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Apr 2021 16:24:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38284 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbhDUUYr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Apr 2021 16:24:47 -0400
Received: from mail-ed1-f70.google.com ([209.85.208.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <dave.jones@canonical.com>)
        id 1lZJON-0000LO-QR
        for linux-bluetooth@vger.kernel.org; Wed, 21 Apr 2021 20:24:11 +0000
Received: by mail-ed1-f70.google.com with SMTP id c13-20020a05640227cdb0290385526e5de5so5570205ede.21
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Apr 2021 13:24:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=UnDMO5bNE851pwqmU5AL+/ZrdrnPN1FsAoYYVQAIJns=;
        b=tPGfn8BemK1q8+3pBj2Rqy5l6H21hGzCDMbExXMI2dU1iSlo8HpnT4gf9Yx8gBX5ej
         Zx22Pn6GjqsnF3ozDRsulry3j3nSoit/yqLiVir9YdTGuoQhS9zhQgSQASNkUMWhHg2X
         cyCW37wcPSTzUQ1SScHatlNuYqkTz6G9kcSUHWePcoxGzt9tEHwXAlpHQCIgaicoUWd3
         s94ijScGq0txBMK53BHVR6JPq85XWbbnQ1Xl1FljBm/0CufSBgfhP23VvyyO4esrMwNl
         zqSeoWl6c9tZ/9Q3AUqnOsttDqC4nE8K0tA7Yfi7rZits7vOSCkwt5YGxIzVnFGQALFU
         TN9A==
X-Gm-Message-State: AOAM530d4oE3Vw/PeJYhhZwyE2dYIg1MnpclPZzaGIloLvw1kUA0p59+
        LuR3sSQ6iCKwhcrDqoS14RsrsLhQTKuUTsWlLvyGVhYKGvBgkgLO7dPwOkDtYRWbfQl4iksCmlU
        DK5iv15lxtNDuxj4U9Ec3zKWvmbtYtKeE8Ncnv4oC6b6meg==
X-Received: by 2002:a17:906:4342:: with SMTP id z2mr19707113ejm.337.1619036651176;
        Wed, 21 Apr 2021 13:24:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxK3N+gE1HCIUjcNrSoX7h+rfG5s5kxs+p3KeaXjzI+1cf8E7z0CFS6sVdYg5+JvBi8NgsXA==
X-Received: by 2002:a17:906:4342:: with SMTP id z2mr19707099ejm.337.1619036650939;
        Wed, 21 Apr 2021 13:24:10 -0700 (PDT)
Received: from localhost (waveform.plus.com. [80.229.34.140])
        by smtp.gmail.com with ESMTPSA id u15sm362307edx.34.2021.04.21.13.24.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 13:24:10 -0700 (PDT)
Date:   Wed, 21 Apr 2021 21:24:08 +0100
From:   Dave Jones <dave.jones@canonical.com>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Subject: Archived raspi compatibility patchset
Message-ID: <20210421202408.itigrlc2cltwu4sv@gonzo.waveform.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20201127
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I've just noticed the patchset [1] I submitted a while back for 
compatibility with the bt modules on Raspberry Pi boards was archived, 
and was wondering if I'd missed some procedure to follow in getting it 
reviewed? My apologies if I've jumped the gun on something!

I'm happy to either rebase and re-submit (though looking at the current 
master I think they'd probably apply cleanly still), or unarchive them 
on patchwork (if that's an acceptable alternative)?

[1]:
https://patchwork.kernel.org/project/bluetooth/cover/20201218190609.107898-1-dave.jones@canonical.com/

Thanks,

Dave Jones.
