Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9292FC07E9D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 19:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbiIWTSt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 15:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiIWTSs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 15:18:48 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420E012C689
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 12:18:46 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id s6so1737094lfo.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 12:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=cr1tpz5WtAZ2lKN1bXAYO4alLn9gTjvHkoOURjWj0Vw=;
        b=MikWSaBz/VRpa0xtXkXSuJkBaJ3JH8/t1ObMUc9vEXl5O9T8HNpSN7b52BT0uW3li4
         VGYkqKJR9mq2zSeaD5hX4q4pPgQHP6DRsLP/1KhteIgchmsXi8+dp2dP+027p+aolErZ
         u5YGi9plMyb9vd6nFMZ0OyByh2n5ZF201b82aU4+m1tkMp75MyqSIfZF6cE4kBHYXAh5
         I/Z/85kQx5HZpG5Jlj/EbDAvqnZvHir78L2MVSSLci+kYPmR+gkpVqbSf1SiskT72dE2
         yx4U14cB/dYuQEuNT5zVirKKJa3CyXa3VPHK82f0AV6MyX4eF5s1/UJ91pxwyZmAGdOf
         YW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=cr1tpz5WtAZ2lKN1bXAYO4alLn9gTjvHkoOURjWj0Vw=;
        b=rud92RXWvg7LijSbacH9EAGhwvhh7JPLWNc7hhguYVVNPLgxoi//69U5FHkK+dFEK6
         hpG+kXas3kNJ2ztmQ/NnLyinXFF+hFeKflXrzXWiYH+HMIebYQjiAlNx3CnGE1IbH21z
         MQMz/i97lrNMbRBmravAWcTmwHOfqkj8JILS3LvCgMwXqkSkuN9Kyy+MCc1lVTbq8uHi
         bYJM5FXytPrQvYSI7w/Jx/abEt0ejEWJgj7DTFm8mIZDjGkxsIn+SPFcjSaitmSR8Hvh
         /hz2ptk/FCQybzO/T1hJrwX3gZTIXHCOZh730LSlku7sz+cY7JiA1jCCPO1dFwtrPmxq
         2gVA==
X-Gm-Message-State: ACrzQf0y1hDZUl/GBMwav3OJgFcxHARFbtWokI7MidJQ05odMVBInbUD
        ptaAEY58h4VCAguBULqyydlQj+dNQwRIH5kfdc4=
X-Google-Smtp-Source: AMsMyM6oMHsUjFrDrUOQTZ8br9r5aYvG3cOFqxtpdgsrVmIgaHWDmWGo72PY9PXSJBU9+e84p0bTM9uPhWIgAKZWlG4=
X-Received: by 2002:ac2:5cb9:0:b0:498:eb6f:740d with SMTP id
 e25-20020ac25cb9000000b00498eb6f740dmr3677408lfq.106.1663960724398; Fri, 23
 Sep 2022 12:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220923145602.25872-1-ceggers@arri.de>
In-Reply-To: <20220923145602.25872-1-ceggers@arri.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 23 Sep 2022 12:18:32 -0700
Message-ID: <CABBYNZLFPY-xiLhiJiJZ1LUQkKpNT7FFbf3sxOhr1Fw7GhBXpA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 0/9] properties_changed: check for NULL iterator
To:     Christian Eggers <ceggers@arri.de>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Christian,

On Fri, Sep 23, 2022 at 8:02 AM Christian Eggers <ceggers@arri.de> wrote:

Perhaps you should rephrase to mention the NULL iter is actually the
result of invalidate properties.

> v2:
> ----
> - 7/9: don't call memcpy(x, NULL, 0) [Scan Build]
> - 9/9: shorten GIT summary [GitLint]
>
> Christian Eggers (9):
>   advertising: parse_secondary: fix loop condition
>   advertising: parse_secondary: fix mask value
>   advertising: parse_secondary: check for NULL iterator
>   advertising: parse_min_interval: reset min_interval if iter is NULL
>   advertising: parse_[min|max]_interval: reset value if iter is NULL
>   advertising: parse_tx_power: reset value if iter is NULL
>   client/gatt: proxy_property_changed: check for NULL iterator
>   gatt: proxy_property_changed: check for NULL iterator
>   battery: provided_battery_property_changed_cb: check iterator
>
>  client/gatt.c       | 17 ++++++++++-------
>  src/advertising.c   | 22 +++++++++++++++++-----
>  src/battery.c       | 10 ++++++----
>  src/gatt-database.c | 20 +++++++++++---------
>  4 files changed, 44 insertions(+), 25 deletions(-)
>
> --
> 2.35.3
>


-- 
Luiz Augusto von Dentz
