Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619AFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 May 2022 23:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241164AbiEXXog (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 May 2022 19:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241044AbiEXXoc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 May 2022 19:44:32 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D02359B91
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 16:44:31 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d22so17134877plr.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 16:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FKHMTFjQws0f0fEqUojYEp1QD0ZQeUAbjgeH93iNZT4=;
        b=Gq44dh8wvT218pHmcPKQiQ9Wy4ZuLdJCV2bBqPPmx1FsLynTk7NIg0K5KQFVLxB0Hn
         /eSUTqbUQ8hU3L7E/xMmZiu1yJDZxh6aFBqJOZiHD6M11ny7c0e6DurnnoXTKBf8ByFn
         kwhYHcdu8qDegpKMRYTXiOwHuO9UVxOxEfN0o/Lw2eBgzZi3T02+yD2S7U4x46uLwm8Q
         grXbDjIIzs+1oFS3UuX4Y8I7eg7bSmYp6wuFTE+SM3ljTDiYT02seHRNjHio9MdcBumR
         C/40vNGAYZe+1cpUhEERWweX7+xfuWAV/D+maFI7Aw+pI3GIff7e3YQG605PGvXIC1o7
         LT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FKHMTFjQws0f0fEqUojYEp1QD0ZQeUAbjgeH93iNZT4=;
        b=p8UU8R9tPJavpM3HFP456rgKsz2fNARid91j/KutCnn8qaAIuPzoCheryaBrsNN6gk
         NU50jU6LQIMPbU6RA+Gnb/TjmEhhQbXRneRvK74DHgOI51V+IPJtldWuswCudF8oFC1R
         oBqRaAJWM1I6X7xUsOgsddqbrus0R2664w3ZGDP4ZBTV6TjabHNzCGPoZR6DxdwLQ9i4
         /KH07hJg0OfE3Is0eLQAb4LJ5vu6pAY5nfrCCcu6LvF9eR4gDKff1VR1PvpB6h21CxU3
         nCzTdzcyjxiRGH9ieIZ0T+mZfT7+pWNGhgN+QQaGUEVQBspa/0adg7msoy7yzeLWfDg3
         rsPw==
X-Gm-Message-State: AOAM530cbCi6XLnoaVPHo2pJnbxONKVAra/q0kgleOThZOT7aXTIh0By
        zMw5spIL0XrAUj+WrEHuCnqi97UZ95CT5blWwE0=
X-Google-Smtp-Source: ABdhPJyfT7ax3jUOnXTyAaFn/OD9c9/hqe+9y07qqKQ4YIF6ZY5wPcVO/mJiBfsRvsJyARtEhBmqtPaaSPYpHQQjzPA=
X-Received: by 2002:a17:90b:3506:b0:1e0:51a1:a8ee with SMTP id
 ls6-20020a17090b350600b001e051a1a8eemr7087062pjb.112.1653435870981; Tue, 24
 May 2022 16:44:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220520183713.2641513-1-luiz.dentz@gmail.com>
 <148a9f76-0784-1d17-22cd-80343895aa37@pengutronix.de> <9e5b51ae-5089-dc91-57cb-52b0d76249d8@pengutronix.de>
 <CABBYNZ+DNOvguwKXie+1NVJ6xQjOYQiUCroBcBNEyUuKjt2+_Q@mail.gmail.com> <f5730712-1967-9d1b-3e04-9fcb6b4a3070@pengutronix.de>
In-Reply-To: <f5730712-1967-9d1b-3e04-9fcb6b4a3070@pengutronix.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 24 May 2022 16:44:19 -0700
Message-ID: <CABBYNZJpgsZnGuJDJ4GyQm=_kJ8xgJJ=gorE9PXmwzCv3YcsUA@mail.gmail.com>
Subject: Re: [PATCH-stable] Bluetooth: hci_conn: Fix hci_connect_le_sync
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ahmad,

On Tue, May 24, 2022 at 3:01 PM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hello Luiz,
>
> On 24.05.22 20:08, Luiz Augusto von Dentz wrote:
> > On Tue, May 24, 2022 at 8:55 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >> On 24.05.22 16:48, Ahmad Fatoum wrote:
> >> I see now that this fix doesn't build for v5.17 because hci_conn_failed
> >> was only introduced in v5.18. Can the hci_conn.c hunk be safely dropped?
> >
> > Are you talking about:
> >
> >         if (status) {
> > -               hci_le_conn_failed(conn, status);
> > +               hci_conn_failed(conn, status);
> >                 goto unlock;
> >         }
> >
> > You just need to replace hci_conn_failed with hci_le_conn_failed or
> > well in the code above the end result is the same since it is not
> > supposed to cleanup in the event handler.
>
> Yes, that cleanup in le_conn_complete_evt() needs to be removed.
> I am talking about the other hunk in hci_conn.c:
>
>   -    if (!conn)
>   +    /* Check if connection is still pending */
>   +    if (conn != hci_lookup_le_connect(hdev))
>                goto done;
>
>    -    hci_le_conn_failed(conn, err);
>    +    hci_conn_failed(conn, err);
>
>     done:
>         hci_dev_unlock(hdev);
>
>
> Can this be dropped for v5.17?

I guess it should be alright but perhaps keep if (conn !=
hci_lookup_le_connect(hdev)) just in case.

> Cheers,
> Ahmad
>
> --
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |



-- 
Luiz Augusto von Dentz
