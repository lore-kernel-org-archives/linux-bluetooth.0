Return-Path: <SRS0=SaLm=PP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FE6C43387
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Jan 2019 22:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0712D2147C
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Jan 2019 22:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKU92Sen"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfAGWiJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Jan 2019 17:38:09 -0500
Received: from mail-pg1-f173.google.com ([209.85.215.173]:35314 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfAGWiJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Jan 2019 17:38:09 -0500
Received: by mail-pg1-f173.google.com with SMTP id s198so787556pgs.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jan 2019 14:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oFdzsb0RAt6lK2wWiUtbwjjXv+Kn0B0Ns2lDnvJbndw=;
        b=gKU92Senz6fNV0LLjxRXyZdhHOez60xvP1/e/U3jfIpUsJn7WsHYqLGB4I7IRf80+V
         j5B1qa378ZQVNoKXHBLgdPIIGPU+t7T31DXxn8//8/aXD/wnYTO2WrF37rS9rozOPWAK
         sFAVzDjZTVvAj77T5WErgDIKApCrhHovohm9OdIwy5vTTgNHpz+NAyKQ/cttmFXv70fY
         /m/pEpoMF8DrUeByepqVZC9cKlbyncMSN+l2izq6bOCPGhBqxLrbm7blevLur07txoks
         Wu9uXCTSNUd2smz5xX1+B8JiAXrGnVq4+M0b30CiR/YaVyD8kHWwabCT2Pc9LkWCyoaV
         dDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oFdzsb0RAt6lK2wWiUtbwjjXv+Kn0B0Ns2lDnvJbndw=;
        b=cblT6bleks6gvniZ5s3Y+qMqQ8kWMjonlBW84qYhyEob0TJE2/Wv6aTVzuEA2QPOWn
         cjLtQYwQwuys9yiXdxis15iC0bkwgrsEA7ay9z/R6SRr3ffaTPBX9DXE3w6bNi3JwHR6
         xbME6ct+GK2udzEo5xlZfMW+Zv+SffSPvfmb6g3ShrNBh96ZRLn6GlKX02hLsdW86Yfm
         k36uhCgYTlg4cOh11W8cpIePhqGh2PHdLkXsekhJz5uE8g3n8SrkFRB89nAsmg8iMXNr
         Oh2CiehbNjtieluruNaiwnv0ttWv52vI7cZJwIslUP4JypUJ5vvC9AnRIfaD6kW/BWIz
         Ennw==
X-Gm-Message-State: AJcUukdlez3wZA7QpEswcLVMCA3Q9YctvIDDA+2UiRWpos1SQioTYkKW
        tnM4HThpDf2PMmq6bRgxPe5X7u5x7giFgMT3E00mWWHa
X-Google-Smtp-Source: AFSGD/X/Yuj2eo6wnY9iNuSn0NehlGA3fyFIc6ingU3xQvE3M76N1v3eHOoV0JDPRtvBSkJHmlKTJUWcYU/f63nUp2I=
X-Received: by 2002:a62:f247:: with SMTP id y7mr64839118pfl.25.1546900688742;
 Mon, 07 Jan 2019 14:38:08 -0800 (PST)
MIME-Version: 1.0
References: <CAEQQxWzdBy9JOC7+oQTBJ35Gov1CDk17fy+XH=jha8MuT9fy9Q@mail.gmail.com>
 <49999069-238D-4FBE-8F38-3762788A67C1@holtmann.org> <CAEQQxWxAvZBX8simb7gNu6ob_0gGXzTEQuOybiP5MTV8dq5sEg@mail.gmail.com>
In-Reply-To: <CAEQQxWxAvZBX8simb7gNu6ob_0gGXzTEQuOybiP5MTV8dq5sEg@mail.gmail.com>
From:   Andrey Batyiev <batyiev@gmail.com>
Date:   Tue, 8 Jan 2019 00:37:57 +0200
Message-ID: <CAEQQxWxpi7FR=RDT1cLMDBUUGzHSfSrgngHL7dCK5V1eJOOu3Q@mail.gmail.com>
Subject: Re: Bluetooth ECDH selftest failed (endianness issue?)
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Marcel,

> On Sat, Dec 29, 2018 at 9:35 AM Marcel Holtmann <marcel@holtmann.org> wrote:
> I think that our ECDH code was endian safe, but then it got changed at some point to use standard crypto and maybe something went wrong there. Can just provide the btmon -w trace.log for the SMP pairing so that I can have a look at the binary trace.

I found out that if I change "swap_digits" method in
"net/bluetooth/ecdh_helper.c" to

static inline void swap_digits(u64 *in, u64 *out, unsigned int ndigits)
{
int i;

for (i = 0; i < ndigits; i++)
        out[i] = in[ndigits - 1 - i];
}

then BLE pairing on big-endian become operational. I'm not sure what
proper fix should be: is it a problem with crypto API usage or a
problem with crypto itself?

Thanks,
   Andrey
