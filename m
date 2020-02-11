Return-Path: <SRS0=Xed5=37=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A61C35242
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Feb 2020 21:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3161C20842
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Feb 2020 21:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUsQJ1AY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgBKVB7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Feb 2020 16:01:59 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34671 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729371AbgBKVB6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Feb 2020 16:01:58 -0500
Received: by mail-oi1-f195.google.com with SMTP id l136so14225007oig.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Feb 2020 13:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UWuR6mihubsKGkdhR8RGLwh+W0aKfcV3F0HnMjxodL0=;
        b=WUsQJ1AYdQmIvMii7VGm1sAIVz5/nWmzt4CkMkifsOJounakI4x3mOlq5+EPVzCesz
         h9EqFHYYl6S10EteNhlMDSyb8YmLOK2KYNakOYOptHiNlVTN0VP8aW0o/9gjSfvfCW6N
         4fgS2+66syn1stMnXtESwu2u/TxH1wJXMAtD0d71pAhB43H/Oj4YHpgQiYH/Da8+VMY7
         naypTeBPrfCKIFLurV9nvFQwqDbM7S5vjPiqxRIW62Hmir9EnDkFdzFaatj6cvgmO2rr
         Loo+SFamCThy1qSjz/iT8KQEClBMlagHgRu8a7OZj5UMZcNz9kmThgmG1zsgHhESFRQ+
         tcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UWuR6mihubsKGkdhR8RGLwh+W0aKfcV3F0HnMjxodL0=;
        b=NbP+W+MIwsY7xXPycDcex6qiwGgD5X+g+7bxBTMjfC98Z27U2PC5Q8MbFqzVBDYuot
         SD2bMpx3+651CcPw/PJqkhGm6RHnsw0EU6bhEjkm9w/PEgUNWvRO1oXsLMExPoHYGZrb
         UCnofcpqjwZdpzDdudJlNPQBWnc+oBUK11QSuL2ayIMnXXgByoDyR8l9cgMXCReHbnxs
         lyKnaOz+dqp1GmrFmSnp36fslOqOHgUYdDR6Br5KNamTdY2k6ECYX+HBholnu9TQDuU4
         tYnFOMyJLZVMaNsdHz7ns9PdCgY0fBRx580b3BcwABbrM0Udz/EcOis+4m5r/JR/L+gs
         yRsA==
X-Gm-Message-State: APjAAAX7L9Juh1NzhO5O83qaZevmfZ+3K/I+IkjARW4Outx+fnuWqaAo
        y4BFcqhhBwvBn9qpxvyp9R1+PPv414opCViHUjvhHg==
X-Google-Smtp-Source: APXvYqw18m/GKV1kYizqNwC6ovmoIJiwmRkn8aXYrbh4916XK+/8JDcmO26JIC2YZWVcgfYAjGaAJU+AVQ7+kEp5I7c=
X-Received: by 2002:a05:6808:10b:: with SMTP id b11mr4216903oie.110.1581454917872;
 Tue, 11 Feb 2020 13:01:57 -0800 (PST)
MIME-Version: 1.0
References: <20200207050856.9249-1-matt.ranostay@konsulko.com>
In-Reply-To: <20200207050856.9249-1-matt.ranostay@konsulko.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 11 Feb 2020 13:01:42 -0800
Message-ID: <CABBYNZJVeugUw-s7XDzjSknGwHKyg2w2UXd_PUHoRmMZ9GXk4g@mail.gmail.com>
Subject: Re: [PATCH RESEND] obex: report notification status on incoming message
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Matt.

On Thu, Feb 6, 2020 at 9:12 PM Matt Ranostay <matt.ranostay@konsulko.com> wrote:
>
> To match doc/obex.txt on incoming message notification the respective
> Status field should be set.
> ---
>  obexd/client/map.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/obexd/client/map.c b/obexd/client/map.c
> index 550c5afb4..23be2d6b2 100644
> --- a/obexd/client/map.c
> +++ b/obexd/client/map.c
> @@ -1914,6 +1914,7 @@ static void map_handle_notification(struct map_event *event, void *user_data)
>         switch (event->type) {
>         case MAP_ET_NEW_MESSAGE:
>                 map_handle_new_message(map, event);
> +               map_handle_status_changed(map, event, "notification");
>                 break;
>         case MAP_ET_DELIVERY_SUCCESS:
>                 map_handle_status_changed(map, event, "delivery-success");
> --
> 2.20.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
