Return-Path: <SRS0=+1pe=TT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289FCC04AB4
	for <linux-bluetooth@archiver.kernel.org>; Sun, 19 May 2019 17:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87A52054F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 19 May 2019 17:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YW2/d+WS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfESR4u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 19 May 2019 13:56:50 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:45607 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbfESR4u (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 19 May 2019 13:56:50 -0400
Received: by mail-oi1-f177.google.com with SMTP id w144so8373680oie.12
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 May 2019 10:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4XabjI+dgAkCkGsMLUH06s8zHqHaWwkyxs+sQtXHOfQ=;
        b=YW2/d+WS/Pqz+G06dpkVVN8o6bSAo+NpqA8CydkUNp1SZy2426Fz6fHqAw9Gc7cKHi
         2T1mX7PnQqHjfmbS5FylNtFcZgdq9eXppOUizgM/kJGYalI1QpgoQQdUIE25BPR51+6S
         z5BPwn1D0m+YMa5XQ3ApnZdjxntZOyDqbWexNL55uYQigjCgJgUIut9VeluDysen8dDD
         CLz9tv9xWYbwVnkIZaUyJa6pXCHtBI853b/hX/rxdha2jTOWI6hsdPxz2A3OQDtfL7+/
         s8yKG9gnIBfh10mbvRtsGC+Yn0Eho8PaKdRte//K78kMu+DuaklgOyY2kz7J1o9EYvSz
         JK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4XabjI+dgAkCkGsMLUH06s8zHqHaWwkyxs+sQtXHOfQ=;
        b=F1TUxyyzf7Nbv4ffM43LRvNgDikb2SSix7cfJUhHFjTHSP2jVLbqgCGzcrqpTfd1vp
         NNOvpgFzSKdYaaWPT/NuydekcmxBvAycd2VCHkLEnwm83F8+lcUEXm7wdV+rHjFzzgog
         zHrzyBDrFDljmfwSH+11WNOsGUEyqmXVSUrBYO1Y4c8mZg3eMbBFu5NNcyqXJ7OwFXxv
         xIjYoLdy7Xvjlry3wbiB0kLGUWR/WDvT1Zcn73YWEeaVyIJbRQF9SPJezw6nm/htd0or
         SLRCcurPI8WgvNc8bPSxYflsQ+RL2+uwwNiO20wMANz1aGunhj+TvT2Z19eOtCLtThnr
         id3w==
X-Gm-Message-State: APjAAAUzegYzchNo/2p5V8xFkFctnQ/G1YQnxPT6QmB8zWk5QIuFLGvs
        T4i10v9XOl5xDFIectziJ+SfJMwUXL07K+STx5tDRsZ1rkHEVg==
X-Google-Smtp-Source: APXvYqzuupiU8vs8rYjwO45oq6DcN4N+cRO00ukS0M4ZyoRsZAisCOt+yE3D2YKZ+X2KVJMjli+qqV8AtnNc3xilKHQ=
X-Received: by 2002:aca:54c7:: with SMTP id i190mr8351918oib.108.1558255198783;
 Sun, 19 May 2019 01:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAELgYhdqAxTGA98RsUEOSEA5WfhxGaVn7C_DegAfU13sHx817A@mail.gmail.com>
 <CANxMttCx4uFeVpM9EsYmfg9VoXG45ihpzw=phJcx0Uy53cGD_A@mail.gmail.com>
 <CABBYNZLGgUL6W=-v+stoaukpN5kvt1AHFBQ_vEdh=sqU9JO0LQ@mail.gmail.com>
 <CAELgYhcCBAUr6oQxTnmjBjQfkc8JeTbkXHea64PN+7cWQSqQ=Q@mail.gmail.com>
 <CANxMttCqEYDZOwTriLqC-q39+JhEJ9KCOsPhRqkjZwE1h-64Gg@mail.gmail.com>
 <CABBYNZKbWAaO9dTnHcV7vCYodRQYEZT8=PBws+=_iip-7Njo2w@mail.gmail.com> <0FBE6EB8-B42A-4D24-ACAB-80AB47316B97@gmail.com>
In-Reply-To: <0FBE6EB8-B42A-4D24-ACAB-80AB47316B97@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sun, 19 May 2019 11:39:46 +0300
Message-ID: <CABBYNZLX+XZG694s+E-L=+VjosbMvytB3nAaVorpghCK=ineSg@mail.gmail.com>
Subject: Re: After kernel update: connect/disconnect forever while attempting
 to auto-reconnect
To:     Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Alexandre Pereira Nunes <alexandre.nunes@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Johan,

+Marcel

On Sat, May 18, 2019 at 9:08 PM Johan Hedberg <johan.hedberg@gmail.com> wrote:
>
> Hi Luiz,
>
> On 18 May 2019, at 19.30, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> > The problem seems to be here:
> >
> > < ACL Data TX: Handle 512 flags 0x00 dlen 16                #87 [hci0] 9.952984
> >      L2CAP: Connection Response (0x03) ident 1 len 8
> >        Destination CID: 0
> >        Source CID: 65
> >        Result: Connection refused - security block (0x0003)
> >        Status: No further information available (0x0000)
> >
> > Ruling out encryption since HID don't require it:
>
> When both devices support SSP, encryption is required for any non-SDP PSM. The kernel enforces this regardless of what kind of options were set for the socket.

Perhaps it could be this one:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/net/bluetooth/hci_conn.c?id=d5bb334a8e171b262e48f378bd2096c0ea458265

It looks like the test you mentioned it is just above the check for
enc_key_size, though people mentioned it has been working so could it
be that SSP is not enabled after all?

-- 
Luiz Augusto von Dentz
