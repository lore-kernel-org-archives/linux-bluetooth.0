Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B71C43334
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 Jun 2022 16:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346126AbiFEQfM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 5 Jun 2022 12:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351252AbiFEQe5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 5 Jun 2022 12:34:57 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D81C4CD4C
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Jun 2022 09:34:56 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gl15so10928153ejb.4
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Jun 2022 09:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jdIVKFSk2eIbeHqEWdMi4/8HFEkUDh1Z4gYM7GW4sa0=;
        b=QiWi8O0uBmOcDTjvLLtS7RJP75oD8QAMzCNIR6xgGGo8LMbdoFvr7/kDyWQLXQ55uU
         K+AiabjxiAwoJ89j+dYMVQGZfwFWy22kGZQb4YLQYDlhkEVn7n7dby8AaXnObgdo72fN
         GZwRjklJ0BMY1TqUhjMmtDoTtyK0M+bX7NU3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jdIVKFSk2eIbeHqEWdMi4/8HFEkUDh1Z4gYM7GW4sa0=;
        b=ItaqbGKnsaL6ATc+yN5vV+fRr0qrBUOHTWUU8oZhO1gCaaYHZBDLITPxc1sKXb+q1h
         EeVsDhXqnyrqGo/LDn9sEVITDn2qpu5rgJveDeooxEA5uai/7bZzo6EZuJ3i8tQmG69s
         g1dvr83bvjhhbaENn6I/l3x4DxO7yqmd+O2IdMZlAGeUVLINNiKDMbrvSrB/rIqv64P9
         aXqlipJKtFgVqfQfOIkTJcS/hTnW4LD3CjctRTHfEC+SpzfD1panlwLuPrpQx7gLoLAY
         EUiB0XASQPjISwFqM8ZcH+rbetnZCICJ784a3pNAguODfNxHj4PEAbybnhbn5No/FFJG
         uiUA==
X-Gm-Message-State: AOAM531FET3LgWhIpf2YXo3vWoBfdOOF3SDFnnS3QWGVMoll0HtyKv8N
        as38CF7AiVX8pSjHCRowBCaYYcAas+PmV8Om
X-Google-Smtp-Source: ABdhPJyk3BGY2s7pthTf+ll6nyRipBC9INyoWzNu4NXz2jiVmzUGn/Eo48KiA3o9/EnkB+GO/54Wkg==
X-Received: by 2002:a17:907:1ca3:b0:705:5a6c:d113 with SMTP id nb35-20020a1709071ca300b007055a6cd113mr18289409ejc.535.1654446894847;
        Sun, 05 Jun 2022 09:34:54 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id n8-20020a170906724800b006fee526ed66sm5321051ejk.35.2022.06.05.09.34.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jun 2022 09:34:53 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id q15so8712609wrc.11
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Jun 2022 09:34:53 -0700 (PDT)
X-Received: by 2002:a05:6000:16c4:b0:20f:cd5d:4797 with SMTP id
 h4-20020a05600016c400b0020fcd5d4797mr17796010wrf.193.1654446893075; Sun, 05
 Jun 2022 09:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220605162537.1604762-1-yury.norov@gmail.com>
In-Reply-To: <20220605162537.1604762-1-yury.norov@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Jun 2022 09:34:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=whqgEA=OOPQs7JF=xps3VxjJ5uUnfXgzTv4gqTDhraZFA@mail.gmail.com>
Message-ID: <CAHk-=whqgEA=OOPQs7JF=xps3VxjJ5uUnfXgzTv4gqTDhraZFA@mail.gmail.com>
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

On Sun, Jun 5, 2022 at 9:25 AM Yury Norov <yury.norov@gmail.com> wrote:
>
> The commit 0a97953fd221 ("lib: add bitmap_{from,to}_arr64") changed
> implementation of bitmap_from_u64(), so that it doesn't typecast
> argument to u64, and actually dereferences memory.

Gaah.

That code shouldn't use DECLARE_BITMAP() at all, it should just use

    struct bdaddr_list_with_flags {
            ..
            unsigned long flags;
    };

and then use '&br_params->flags' when it nneds the actual atomic
'set_bit()' things and friends, and then when it copies the flags
around it should just use 'flags' as an integer value.

The bitmap functions are literally defined to work as "bit N in a set
of 'unsigned long'" exactly so that you can do that mixing of values
and bit operations, and not have to worry about insane architectures
that do big-endian bit ordering or things like that.

Using a 'bitmap' as if it's some bigger or potentially variable-sized
thing for this kind of flags usage is crazy, when the code already
does

  /* Make sure number of flags doesn't exceed sizeof(current_flags) */
  static_assert(__HCI_CONN_NUM_FLAGS < 32);

because other parts are limited to 32 bits.

I wonder how painful it would be to just fix that odd type mistake.

                  Linus
