Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9EFC4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Oct 2022 20:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiJQUOW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Oct 2022 16:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiJQUOG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Oct 2022 16:14:06 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33CA7D1CB
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Oct 2022 13:13:03 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id a29so19303272lfo.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Oct 2022 13:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MgVBfujJDguuHORIw9kprf2P/cgxvQLdds5A8QIqbjQ=;
        b=jFSgeVtpQhEWOtmSom+67TEvhEmMkmUxNgnqE3uTeAyD27n1GHp0cP4DNB30XuHOQb
         qe20nvQftN8RJszpLmQ4Z4+bWkQAMTZrnjrQZLX+0CXWMmuv+zfvoP/gQhH8i6bNjdgu
         09jyvNhVbcsGUt5keGh+Dyig7pUFCP9KQ1P3EBIAhcT3BwhR/PcLsOoGH2fTNmGp45vf
         0mfiTXPYSPSPBHO15PkoFdVKf6dJN7bTV//s3PO+oijEtYzRUKer+Ny4iBuhK6TkC3aI
         Q1RRN8fw6OXwqyVd/Q4u8sqLzkq8wLiBXIYXb/LcgH3+xiJAN5CNVAofdg8bZVXz15td
         c0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MgVBfujJDguuHORIw9kprf2P/cgxvQLdds5A8QIqbjQ=;
        b=YfrPVPgsB5/206fiGsLSvQbA7ExYzop7cTwHfw0w6TQSQhfXXlnyflAZYtFhz5cqQd
         kEQd4d6hDPxmTrPC8FNzJTePF0pJL5c//LywYp1OCvVX0ZWlY4Qklv6Tk0rY2EocR98Q
         jJba0845Y10f9DOrGJnBv3Rq5+aK0Nzr8mFIEzpYCzFgCj5CQ316HwEBtUtvdSqSQn5T
         eWHqC0jR58FG8+/+H1r59K1dg9owQd73K39E/IMkYzIrKoxgcOFhU0Q2aHUzXASZQZiI
         zG8a8KYFgAMxcgRw2hvXVyxfiI77Ut+FgLrJTm+IdzHieHuOynXqMPfdMzZPhyfANiAN
         Uqrw==
X-Gm-Message-State: ACrzQf3HNl2gJEWb76GYkRhw8ImQn6JdxReJfEUs/EUMpD1C0cOB30uq
        f++0Sz0VY9Sgb1IoJwJAodDy/SrD2WKdkzb7KHVYJoqdTI8=
X-Google-Smtp-Source: AMsMyM73fSC9O8cYg1qSu6YYUF1FdsTmrjNkhvzUbPOmu8Pxp/AQ/XxiZDoKxNAuxlOtjEn2PyRJ91cErcP8DyILmzE=
X-Received: by 2002:a05:6512:34c9:b0:4a2:2b33:5358 with SMTP id
 w9-20020a05651234c900b004a22b335358mr4219209lfr.106.1666037486633; Mon, 17
 Oct 2022 13:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <2264504.ElGaqSPkdT@n95hx1g2>
In-Reply-To: <2264504.ElGaqSPkdT@n95hx1g2>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 17 Oct 2022 13:11:15 -0700
Message-ID: <CABBYNZKmKz40WAD9fZ-UixDGe7isQxmrrf_7L54yRrLm6P-0XQ@mail.gmail.com>
Subject: Re: Support for Data Length Extension (DLE)?
To:     Christian Eggers <ceggers@arri.de>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Christian,

On Mon, Oct 17, 2022 at 7:57 AM Christian Eggers <ceggers@arri.de> wrote:
>
> When monitoring a Bluetooth connection between two Linux systems
> (kernel 5.14 / 5.15 + bluez-5.65), I noticed the following:
>
> > HCI Event: LE Meta Event (0x3e) plen 12                                                                                                                          #21108 [hci0] 1650.255887
>       LE Read Remote Used Features (0x04)
>         Status: Success (0x00)
>         Handle: 25 Address: 00:1A:7D:F0:21:40 (OUI 00-1A-7D)
>         Features: 0xbd 0x5f 0x66 0x00 0x00 0x00 0x00 0x00
> ...
>           LE Data Packet Length Extension
> ...
>
> > ACL Data RX: Handle 25 flags 0x02 dlen 18                                                                                                                        #21109 [hci0] 1650.300224
>       LE L2CAP: LE Connection Request (0x14) ident 1 len 10
>         PSM: 128 (0x0080)
>         Source CID: 64
>         MTU: 672
>         MPS: 23
>         Credits: 30
> < ACL Data TX: Handle 25 flags 0x00 dlen 18                                                                                                                        #21110 [hci0] 1650.300431
>       LE L2CAP: LE Connection Response (0x15) ident 1 len 10
>         Destination CID: 64
>         MTU: 672
>         MPS: 23
>         Credits: 30
>         Result: Connection successful (0x0000)
> ...
> > HCI Event: LE Meta Event (0x3e) plen 11                                                                                                                          #21113 [hci0] 1650.345822
>       LE Data Length Change (0x07)
>         Handle: 25 Address: 00:1A:7D:F0:21:40 (OUI 00-1A-7D)
>         Max TX octets: 251
>         Max TX time: 2120
>         Max RX octets: 251
>         Max RX time: 2120
>
> I can't find that HCI_EV_LE_DATA_LEN_CHANGE is implemented anywhere in the kernel nor in bluez userspace.
> So why do I get this event? Is it generated by controller firmware itself?

We do programm the it earlier though with HCI_OP_LE_WRITE_DEF_DATA_LEN:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/bluetooth/hci_sync.c#n4362

> I think that both adapters support DLE. Is there there already support for using it with Linux?

I guess it would probably make sense to handle
HCI_EV_LE_DATA_LEN_CHANGE, that said it seems to come after the L2CAP
Connection Request in case you are suggesting to align the MTU with
Max TX/RX length.

> regards
> Christian
>
>
>


-- 
Luiz Augusto von Dentz
