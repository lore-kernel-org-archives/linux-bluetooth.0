Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B31BC433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jan 2021 03:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6C15224B1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jan 2021 03:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbhAYDgS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 24 Jan 2021 22:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbhAYDgP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 24 Jan 2021 22:36:15 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E31C061573
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Jan 2021 19:35:35 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 36so11489093otp.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Jan 2021 19:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sWCIZkNG9V5891xrVruyNqQCmhK58wXe75MOyr6ERJw=;
        b=jCCCcesqWXFGWL98nemCjnWrOjrF5+8FAYgxaAAeQZkJcY3yysNUMdPNNLmm4JO2o1
         +NyZ5Q6aUqSmtpef9cxUPaUSvsvlhYgcjq8upnlbwl2GyZzJSLLxX3OJC8xGo/B+Rjtf
         jKVdUefeZmYk36Iaw9QNGhgWccXFhllRmeexbisPn5X6OXi7rEtmdcxL1UPj011aiXye
         0LdE1f8y2EQb7hDli/dtJavmYScwK/mnddwE5vkVmJn22ysPUYrmJXhEInhs5QRavzkv
         DVDbA8Q2bqfq469e9sT0DkTQmjS6FxbAXaVXu4XSfM/VaEOhBIzVJqyT7ggzotPK33mP
         OpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sWCIZkNG9V5891xrVruyNqQCmhK58wXe75MOyr6ERJw=;
        b=oZmaCKiAGQWaMiCPPMzATwvTdlPkKkznAUa5wxp2MzZ0M2iw519ghr5bTRGK6+dgf9
         O21eXiOyyXZrraEx+S4zxymZOVNgN0jZcrVswaUxLP0FQdn0EBY1CYEbrlsJfcinztI8
         rfgydC6COALP/JvswtAxd+uzjPkDqQZScx8rFTqwCB8oa3vc33wc6UaYtpzsW2S2emRh
         T5iFPephp3nT5XA/exobvI407BYbQL5cIzZAMMpBlHidA7uelTi/dtGGDQLOaUOQ6nkC
         eySAEJTF1cvqE5/9k7CKuCrSzDWtXQ9SZIgpN6d5LUV1I6BuFIv437qg9nx8yzUWkw/V
         cSNw==
X-Gm-Message-State: AOAM530feOvp8wWXn3KoMkspxFOAOreiWhqmIR9GMKst8GOXF4P1wki7
        2sz0smcpxWvWjDuN1HSmtMBjGIVxmbSu5H3oqg0=
X-Google-Smtp-Source: ABdhPJzSfLJOY2r5riuB+QVtLIYRZuekNhzAFY+k/0yU3wh23pTIr83Cb7ZMPpbd3mqQ502dZvtaa793wv0l3q90/4s=
X-Received: by 2002:a9d:2035:: with SMTP id n50mr10428908ota.44.1611545734757;
 Sun, 24 Jan 2021 19:35:34 -0800 (PST)
MIME-Version: 1.0
References: <CAC9s0NazfjTcapy52XSdJSKSmoAQmBom_JTfgROKRkVmAbaMDg@mail.gmail.com>
In-Reply-To: <CAC9s0NazfjTcapy52XSdJSKSmoAQmBom_JTfgROKRkVmAbaMDg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sun, 24 Jan 2021 19:35:23 -0800
Message-ID: <CABBYNZJrb=jpuaUAC9DxRSnRrReZRQgPTKwgqQYBN-3KWoUxQA@mail.gmail.com>
Subject: Re: How to add "Service Changed Indication"
To:     Kenny Bian <kennybian@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kenny,

On Sun, Jan 24, 2021 at 12:45 AM Kenny Bian <kennybian@gmail.com> wrote:
>
> Hello,
>
> We implemented a GATT server on Linux in Python. The code is based on
> the code sample(https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/example-gatt-server).
> The BlueZ version is 5.48. But we found a problem. The cached data in
> /var/lib/bluetooth caused the mobile app to crash if some
> characteristics are changed. After some research, we found "Under BLE
> standard 'Generic Attribute'(0x1801), there is a Characteristic
> 'Service Changed' (0x2A05) with 'indicate' property", see
> https://github.com/espressif/esp-idf/issues/1777.
>
> The questions we have:
> How to enable the "Service Changed Indication"(0x2A05) in the
> bluetooth? Is there any code example in Python?

If you are registering the services with Bluetoothd then it should
generate the service change automatically:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-database.c#n1185

When a new service is registered it is indicated here:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-database.c#n1452


-- 
Luiz Augusto von Dentz
