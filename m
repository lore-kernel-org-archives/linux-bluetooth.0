Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BBCC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 Jun 2022 23:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349136AbiFEX47 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 5 Jun 2022 19:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347480AbiFEX46 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 5 Jun 2022 19:56:58 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CBF39823
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Jun 2022 16:56:56 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id v25so16716146eda.6
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Jun 2022 16:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iRX+dAaHFYHOMUkkn7e8l97Dwcch2sYAXae8M4f8XjE=;
        b=B+w0Y6o1NT9jGOE9kjSjrSBAJ9eA6U+dI1XGTGNKFUSIW1CGxv58Uvz8TroRpXFL1I
         jOVUYOxXT6wmSLmfjsCY84xZJczlEuYLR0s8LaRgKZd9k2S+h1lWW2reAZZdqlSLPNu4
         ZeJUTW8DlEBxbtUxbl/awnYiB+zDYOwZ9VUro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iRX+dAaHFYHOMUkkn7e8l97Dwcch2sYAXae8M4f8XjE=;
        b=KPDIJgEW8OhizC05l/GYaLkXubz8S9MqvzDhmRl9hrhu9CopQ6LGyjXyEeGGPwHz6D
         dJXfBt30DLckCxrpCrdisuqXdyKcl4K1S5CkGXIAbGU5q4kPdY+DHXBmI9opo/VkOIRI
         SgsHjcbsHsajsXMysVdhXS7CLbdXe0r00ifDx9mj0b4JN1lBl9URppUOoza/arVBuHmS
         E/agL3cja4tLhLMv8B79l+EPLf/LEXNW5VYX9fS848fTNLQp+FOzIMIGdI2Z2sKNeGCj
         PsTLY8R+97A32Uu8E7HhyTXF25Uzg2Eqojx1U7UcEzJBn1H734TXitHFgw978J9AKbgw
         9Asw==
X-Gm-Message-State: AOAM5323xZyVxbU+FfLQzdQSJ30yygnbB79uEiHzuNF6DvAmdwLLJRtC
        CF79cMmoFlh2PfqBO81i1Z1Wjzlt++Tqbk68voI=
X-Google-Smtp-Source: ABdhPJxW+Lx1TxMxrT3s9Vx8R0YEOfBFbv0DnnaSrR6hkZQgYuLUhgFYc3pI73fQTqIiyhE/woJZQA==
X-Received: by 2002:a05:6402:e85:b0:41d:121b:f436 with SMTP id h5-20020a0564020e8500b0041d121bf436mr23975374eda.121.1654473415219;
        Sun, 05 Jun 2022 16:56:55 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id n24-20020aa7c698000000b0042bb229e81esm7583709edq.15.2022.06.05.16.56.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jun 2022 16:56:53 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id h5so17780064wrb.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Jun 2022 16:56:53 -0700 (PDT)
X-Received: by 2002:a05:6000:1b0f:b0:210:313a:ef2a with SMTP id
 f15-20020a0560001b0f00b00210313aef2amr18555328wrz.281.1654473412987; Sun, 05
 Jun 2022 16:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220605162537.1604762-1-yury.norov@gmail.com>
 <CAHk-=whqgEA=OOPQs7JF=xps3VxjJ5uUnfXgzTv4gqTDhraZFA@mail.gmail.com> <CAHk-=wib4F=71sXhamdPzLEZ9S4Lw4Dv3N2jLxv6-i8fHfMeDQ@mail.gmail.com>
In-Reply-To: <CAHk-=wib4F=71sXhamdPzLEZ9S4Lw4Dv3N2jLxv6-i8fHfMeDQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Jun 2022 16:56:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wicWxvuaL7GCj+1uEvpvpntdcB=AHot_h3j4wpenwyZ2Q@mail.gmail.com>
Message-ID: <CAHk-=wicWxvuaL7GCj+1uEvpvpntdcB=AHot_h3j4wpenwyZ2Q@mail.gmail.com>
Subject: Re: [PATCH] net/bluetooth: fix erroneous use of bitmap_from_u64()
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
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

On Sun, Jun 5, 2022 at 11:51 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> *Most* of the accesses to those connection flags seem to be with
> hci_dev_lock() held, and the ones that aren't can't possibly depend on
> atomicity since those things are currently copied around with random
> other "copy bitmaps" functions.

I've committed that patch as commit e1cff7002b71 ("bluetooth: don't
use bitmaps for random flag accesses").

That basically ends up reverting

  a9a347655d22 ("Bluetooth: MGMT: Add conditions for setting
HCI_CONN_FLAG_REMOTE_WAKEUP")
  6126ffabba6b ("Bluetooth: Introduce HCI_CONN_FLAG_DEVICE_PRIVACY device flag")

which did horrible things, and would end up overwriting the end of the
bitmap allocation on 32-bit architectures.

Luiz, if the reason for the change to use a bitmap type was because of
some atomicity concerns, then you can do that by

 (a) change 'hci_conn_flags_t' to be an 'atomic_t' instead of a 'u8'

 (b) change the regular accesses to it to use 'atomic_read/write()'

 (c) change the "bitfield" operations to use 'atomic_or/andnot()'

but honestly, when it used to mix atomic ops
(set_bit/clear_bit/test_bit) with random non-atomic users
(bitmap_from_u64(), bitmap_to_arr32() etc) it was never atomic to
begin with.

Regardless, trying to use bitmaps for this was absolutely not the
right thing to ever do. It looks like gcc randomly started complaining
when 'bitmap_from_u64()' was changed, but it was buggy before that
too.

                 Linus
