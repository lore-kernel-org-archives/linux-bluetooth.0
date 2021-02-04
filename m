Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C31C433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Feb 2021 05:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EA7A64F47
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Feb 2021 05:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhBDFRu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Feb 2021 00:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhBDFRu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Feb 2021 00:17:50 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44753C0613D6
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Feb 2021 21:17:10 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id x81so2297394qkb.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Feb 2021 21:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=fBDSancv4Z7n+5iAPrGDSQxTXPZCFUyduSA9pZkH7Gg=;
        b=HulFc6a3biWks1bdAtNDF8/u1E2Y+7A9N0+wrH3Phs1W3btpLhd6YRsYa1urAf1x6+
         H93RmlJ39M1aTvtzOwBmw5XDl10qn1HsTZXbz+NrVbu+iPxvrJtyB/c7orFOSh/jbn8T
         nWpQ5I6tmrV/sH9FJVeRSyg8uPvrNd9Ve4NggBwVZe5FQbVaw1tBTr7Op2kx62UB1O0C
         4ts7aU8pZJDqsNFkhFu6jCMKNa+m/UF/fR24JAQ1NjuhSE/aIicjcrJiwVu50Qqyksur
         pv2yhCQypqKzCOtGrPn1cG+UCUF9RR5whI02PYPhszLI+IdHCh9qAglwXCoIusrjUTDQ
         Dc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=fBDSancv4Z7n+5iAPrGDSQxTXPZCFUyduSA9pZkH7Gg=;
        b=X+iQYiXJevmFyIz5Uf/sLzm05B4RdDCp921hIaCjmmH3EvCSLpu8czhbVgUpQJzdZv
         sYPZkT86Ii1eQhNqd0teyrFwSIHWn2hwXYvGmO+nRWXZBSTrKX9vCvzhtq5iacU6ikH9
         97iEkOIvSsfdKavAL3tnMgZW0lg8fwcPpEHl7PjVYkMgAb/oxga6usHUzEVJUvQqWHol
         lf0Ntfr8WaJzzhXsTbq7F0hu6Tfpp7aNE8owe3aSq/C3mK7ZgQiyujqjAzdDQDwSHB3k
         b2A1aZ28NTBe4Lz/4j/4w+hdHzCYYQ0i9TDgof9DvgJ8foWt03bEGaubLqTi2ZQn/PTJ
         QUsw==
X-Gm-Message-State: AOAM5316gR52h7+qyihMSPVFIkzdVIc084o9iLkc7d3gI6n8E1koUYZF
        LmDemHoY5HfmX8LwdF+BPw5HCXULhH4SEsKPzV+85AJWZAxP
X-Google-Smtp-Source: ABdhPJxxgO2UF2RKkwH4qhmwvPtjJwEGIDVsKI+4VF3ZFUYBgmfFYZXqcn0zK0OmMLPZaUQlQfBROmJz+WMBEeqq+iY=
X-Received: by 2002:a37:6897:: with SMTP id d145mr6094137qkc.168.1612415829303;
 Wed, 03 Feb 2021 21:17:09 -0800 (PST)
MIME-Version: 1.0
From:   Kenny Bian <kennybian@gmail.com>
Date:   Wed, 3 Feb 2021 21:16:58 -0800
Message-ID: <CAC9s0NaGXXVcZ_mDf9=QFp18BT7Ke-nduUCgx9u4zMOxuW0yeA@mail.gmail.com>
Subject: How to disable cache?
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

In "/etc/bluetooth/main.conf", there seems a way to disable the cache:
[GATT]
Cache = no

What does exactly the "disable cache" mean? It means the
"/var/lib/bluetooth/[MAC_ADDRESS]/cache" folder won't be created?

We tried to disable the cache by changing the
"/etc/bluetooth/main.conf". It seems the
"/var/lib/bluetooth/[MAC_ADDRESS]/cache" folder is still created even
if it was deleted.
However, we noticed that the "[Attributes]" section in
"/var/lib/bluetooth/[MAC_ADDRESS]/cache/[iPHONE_MAC]" file is gone.
Does it mean the "disable cache" is working? Does it mean the handles
used between the bluetooth and the mobile app won't be cached?

Thanks!
