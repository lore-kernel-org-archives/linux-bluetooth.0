Return-Path: <SRS0=EsMn=TA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8FAC43219
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Apr 2019 12:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4851D2075E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Apr 2019 12:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcX1XO2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfD3MtI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Apr 2019 08:49:08 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45404 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfD3MtI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Apr 2019 08:49:08 -0400
Received: by mail-ot1-f65.google.com with SMTP id a10so2940837otl.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Apr 2019 05:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WL5lnw9Knrg+JFMO9Ld5I6IcgT1nNuf/oMAfmnCQtzA=;
        b=NcX1XO2s72XuvTr5CWj/Lm6RzJOgsNKRuLDhNhrot92Wk+GwlHUFKw5wuzdsrpIaya
         YAnDernVODQ/DzFXEUv43TozhGNKdw6Nh+w3lUgRM3siGYBfEb+ltWymEZfns8u5jPAN
         D+E8cOXnFASjFwnrdEuHej8V7db/uBfjjGRVm0NWGTni162jKElNAIHf83TEFDvSogyD
         SUyZ72642jU+q29jF+bYUFeX6y9cVGRQeEDo7URPEwhxfov9BgHe1l1Ri+MsT/h8ID27
         xwF1OmthSdAI5S6NRUVAqT+62dDPHVqB3EX3duNJjwxEwrX/Ws4EeVe/fKt+oFOgUmjU
         ou0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WL5lnw9Knrg+JFMO9Ld5I6IcgT1nNuf/oMAfmnCQtzA=;
        b=N8cqIqG7soTr7475IXxh8kDkOwodYc1UPG/WNA5XoZrqNWXZsNt38G91kYf7Kj8dxT
         hEyL/GDi0aHYHsbVv2OQ7LcqjPtggy4nd8XNHqlWattUy9844NasUbVS2AXDYlyst4oP
         wrD7/7SiduTjf320roJWav6EoVD5HfPsvA0yO1LN2pprBggbOTCDf2FKR8T3dLtANLiR
         dKwQYUsWoUIsRza2pSqrPmife2JU7wOzpKiNMuz9xFyTOgNdbcfM36aaGp201+oZ1UTW
         +IB9WmXQuncXQFydcoyyC0LaabYLR0wOhdjGt9aigomCPGXm2g8+4xRNbO4zIj9H/MFO
         EG+w==
X-Gm-Message-State: APjAAAXTvpjQAmJO2F3ju/QwVt3xGw1rmHBpYPT83lwglMt8RKZjjTjM
        kmrQ0xUwAQkoMeuIaxVrSYqR2AyTINuE4Pop7DM=
X-Google-Smtp-Source: APXvYqx3pnZSxqp4/wZJ2ITbPoAecjXJhcMOWB6P+n+y+/NvWy3BvGdbTEorxyKrKxk2RpV1j7LjkHayPgTLBxtglAk=
X-Received: by 2002:a9d:740d:: with SMTP id n13mr7229889otk.291.1556628547631;
 Tue, 30 Apr 2019 05:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190429111441.20481-1-troels.d.hoffmeyer@gmail.com> <20190430115147.14631-1-troels.d.hoffmeyer@gmail.com>
In-Reply-To: <20190430115147.14631-1-troels.d.hoffmeyer@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 30 Apr 2019 15:48:55 +0300
Message-ID: <CABBYNZ++ear7VemMBkMzhqM5sr7y+DMy0+kOGCct26VnVk7Q9w@mail.gmail.com>
Subject: Re: [PATCH Bluez 0/1] Commit message fixup
To:     Troels Dalsgaard Hoffmeyer <troels.d.hoffmeyer@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Troels,

On Tue, Apr 30, 2019 at 2:57 PM Troels Dalsgaard Hoffmeyer
<troels.d.hoffmeyer@gmail.com> wrote:
>
> I didn't put a newline between the subject and the description.
> I hope this commit message is better. It is my first time doing patches by email, and i'm still learning :)
>
> I didn't know that setting the timeout to 0 would be a missuse.
> I just modified the python advertisement example.
> The problem i ran into was that creating and releasing these advertisments with timeout 0 could sometimes cause a segfault in bluetoothd
>
> Troels Dalsgaard Hoffmeyer (1):
>   advertising: Timeout of 0 should not fire a callback
>
>  src/advertising.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> --
> 2.17.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
