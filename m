Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F1CCCA482
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jun 2022 21:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378710AbiFGVHT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jun 2022 17:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379802AbiFGVG1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jun 2022 17:06:27 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC70211100
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jun 2022 11:50:20 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id v25so24170568eda.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jun 2022 11:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lxgwqXrTE5CS81OOTZfgrmr4rRv5j2bUa4aaRbpCvDQ=;
        b=UIn4bvZhXW7AF2rT52jP/vHIPjI8XyKoA3dn2Q+Bi0s2HH11YyOvGVEVe86JVSoGKI
         BaaWsQh6OrE4aTrQmY6fkIGKtAYybadmY8CgsBkfKkdrn9/E2Hw2YgipoxbbIFvguJ8i
         wugGZSlCqni+gcqC9Yso1tIQl10wVmmIOsHm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lxgwqXrTE5CS81OOTZfgrmr4rRv5j2bUa4aaRbpCvDQ=;
        b=ZEVqypHEA9z857YmwEGJaalLHSP6uO99NcmMutSQfb6s+LJiUIFL24T1krB4t/Ge1K
         PFeGv+opvKs9xfH8EPXG8DQAaERdxZop6DAgz20IxMxxhK1g/B8lRC6se17Mjj6GE0ap
         wODLP7Vh6X2W4sZqWFL9PscaaX3Jo9/iOhTMa3lhZ2hBfAxmrE+nrA1IVhXEY/DqrFCV
         2KMWTuwdhj4HX0pbNODTnCXeNvSxiMjlztYLfsAVvSoniRLQYPnbc9vS6TXJDoHgDSIP
         iDFw6GSsR1HCFVNMv5b/nfYPVk4JapWLQ8WxaDMWu5EHQYpai2xuChpeofzWrixYpQAw
         QgAA==
X-Gm-Message-State: AOAM533RdW43/GW5Nwh+nTUO/b174nk2S2woZnhYMeJi/dAlKlcR2bUo
        D2/CYCfXBOuV5MOZlcuqlgSkjJbABros+fdwMrA=
X-Google-Smtp-Source: ABdhPJxamfO7+lW1nXD386uo8akJRRFQVBWjqIrUj4D7leXgJdCBUqffS68U3vjBFhJQkgQ83FW4hg==
X-Received: by 2002:a05:6402:2892:b0:42d:c871:78f4 with SMTP id eg18-20020a056402289200b0042dc87178f4mr35811900edb.192.1654627815174;
        Tue, 07 Jun 2022 11:50:15 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id m11-20020a056402050b00b0042dd7e13391sm10828040edv.45.2022.06.07.11.50.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 11:50:14 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id m26so13941021wrb.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jun 2022 11:50:13 -0700 (PDT)
X-Received: by 2002:a05:6000:1b0f:b0:210:313a:ef2a with SMTP id
 f15-20020a0560001b0f00b00210313aef2amr28815309wrz.281.1654627813569; Tue, 07
 Jun 2022 11:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220605162537.1604762-1-yury.norov@gmail.com>
 <CAHk-=whqgEA=OOPQs7JF=xps3VxjJ5uUnfXgzTv4gqTDhraZFA@mail.gmail.com>
 <CAHk-=wib4F=71sXhamdPzLEZ9S4Lw4Dv3N2jLxv6-i8fHfMeDQ@mail.gmail.com>
 <CAHk-=wicWxvuaL7GCj+1uEvpvpntdcB=AHot_h3j4wpenwyZ2Q@mail.gmail.com> <CABBYNZJfqAU-o7f9HhLCgTmL46WfwNQbM5NsCACsVVDLACMLYw@mail.gmail.com>
In-Reply-To: <CABBYNZJfqAU-o7f9HhLCgTmL46WfwNQbM5NsCACsVVDLACMLYw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Jun 2022 11:49:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=whcV=BE6bkyd50eZZnggaczKdpU_PevFRWw_hjJS72UPw@mail.gmail.com>
Message-ID: <CAHk-=whcV=BE6bkyd50eZZnggaczKdpU_PevFRWw_hjJS72UPw@mail.gmail.com>
Subject: Re: [PATCH] net/bluetooth: fix erroneous use of bitmap_from_u64()
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Guo Ren <guoren@kernel.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Jun 6, 2022 at 11:00 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Right, thanks for fixing it. About some of the changes perhaps we
> should use BIT when declaring values in enum hci_conn_flags?

That sounds sane, although with just two flag values I'm not sure it matters.

But I guess it would document the fact that it's a bitmask, not an
ordinal value, and it looks like that header is already using BIT()
elsewhere so there are no new header file dependencies..

              Linus
