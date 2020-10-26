Return-Path: <SRS0=rjyd=EB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5AEC4363A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 20:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D055D21D42
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 20:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMIIFKsp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbgJZUPz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Oct 2020 16:15:55 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40781 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730520AbgJZUPz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Oct 2020 16:15:55 -0400
Received: by mail-ot1-f67.google.com with SMTP id f97so9195980otb.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2020 13:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QG4NUmqXGXwIbzx0TIj7UQd+x/Ou6xdFNfX5U+SSxkI=;
        b=kMIIFKspXKvEHbg9y9bvwBt8fvlSgAxcXkEBXK5yMc0XNVocrwIEQVjk7JBqiNl8r2
         me4MKMc/rHv3uNnKX3n5rpTDY1gWCKAy5Q8czLyb4CxDNzblGuH0zKWPYHoTx4vy1Q/6
         Zq0XSsQLxhozhz/C4rqqGw35el5za2khjmWOA95aSNY9OyoCgQXmeTQXhQmMf8SBFMex
         8Ap2iHa9LECBl9WRdlFV3TqVtv7pwDAxf4ORCOfnojIqvLrFnj3LQ+TDOJK5E5HL1lCY
         FUde6DJVbLt0Qm+xqvIRE6NGuWPWhUwmkyhB2veHJO3x5uKRZRdUVnavZUDTR9On+YbH
         60ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QG4NUmqXGXwIbzx0TIj7UQd+x/Ou6xdFNfX5U+SSxkI=;
        b=Qpsm7jgI1Yw/GwdgaUiaM1u1pf7Y5FT9BmEuGdLve3pxlrOj2yj5DpAR36XES7E4wV
         ahKVDTZ1otHn+zUdzIMSXiMaSsPI2GFdcWlL4+Ulr0v6gz4/rjjuLU8yN/yTdhV3nhSx
         7dLZoOOk0Wvh7OVu8POa60KSgHFf8TYgg79XxJ6d8R84kvF/jYLil9YnIIEfNk+lRDZI
         RpRoG2MSYSFcpfVdrg+FkxITuBB7faQ3hBKH2An6ZQx8g6KE3TJNv0XtSU41uC1LiYQl
         nwgiLLE16uREcZlDa7JY3xRTUUrONJPt/1eoyK4dFqfBWSyBgP6Zz0adx41LVwrmvSsW
         uc6A==
X-Gm-Message-State: AOAM533+EO27uLHM3SC2zc9qMy2FiyEEG09IwWPvW5a2KxFiOj5K2Uda
        IuPnIxv2gpARYH0AYeJqF6dPZ/+PjNbYvGe/zuk=
X-Google-Smtp-Source: ABdhPJzMcgnyq2ZbBM08GeZ8VgsYZOBb7NydSESV2h8zfPVz5MUEgreJptW0IMQiRdZI0sX0YJKZMpsT8nL64uUUJyc=
X-Received: by 2002:a05:6830:400d:: with SMTP id h13mr16511762ots.371.1603743354557;
 Mon, 26 Oct 2020 13:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <20201025162730.47247-1-marijns95@gmail.com>
In-Reply-To: <20201025162730.47247-1-marijns95@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 26 Oct 2020 13:15:43 -0700
Message-ID: <CABBYNZKxYFQ8iodcHZsKHq3JCuC10EOmBykU4ZsS8ECACQ5ktQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] audio/a2dp: a2dp_channel should have a refcount on
 avdtp session
To:     Marijn Suijten <marijns95@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marijn,

On Sun, Oct 25, 2020 at 9:27 AM Marijn Suijten <marijns95@gmail.com> wrote:
>
> a2dp_channel keeps a reference to an avdtp session without incrementing
> its refcount.  Not only does this appear wrong, it causes unexpected
> disconnections when the remote SEP responds with rejections.
>
> During testing with an audio application disconnections are observed
> when a codec config change through MediaEndpoint1.SetConfiguration
> fails.  As soon as BlueZ receives this failure from the peer the
> corresponding a2dp_setup object is cleaned up which holds the last
> refcount to an avdtp session, in turn starting the disconnect process.
> An eventual open sink/source and transport have already closed by that
> time and released their refcounts.
>
> Adding refcounting semantics around a2dp_channel resolves the
> disconnections and allows future calls on MediaEndpoint1 to safely
> access the sesion stored within this channel.
> ---
>  profiles/audio/a2dp.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index cc4866b5b..0eac0135f 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -1507,6 +1507,9 @@ static void channel_free(void *data)
>
>         avdtp_remove_state_cb(chan->state_id);
>
> +       if (chan->session)
> +               avdtp_unref(chan->session);
> +
>         queue_destroy(chan->seps, remove_remote_sep);
>         free(chan->last_used);
>         g_free(chan);
> @@ -2065,7 +2068,7 @@ static void avdtp_state_cb(struct btd_device *dev, struct avdtp *session,
>                 break;
>         case AVDTP_SESSION_STATE_CONNECTED:
>                 if (!chan->session)
> -                       chan->session = session;
> +                       chan->session = avdtp_ref(session);

Afaik this was done on purpose since we only need a weak reference as
taking a reference would prevent the session to be disconnected when
there is no setup in place, so I pretty sure this will cause
regressions, instead we should probably add a reference when
reconfiguring is in place and have a grace period for switching to
another codec.

>                 load_remote_seps(chan);
>                 break;
>         }
> @@ -2145,6 +2148,7 @@ found:
>                 channel_remove(chan);
>                 return NULL;
>         }
> +       avdtp_ref(chan->session);
>
>         return avdtp_ref(chan->session);
>  }
> @@ -2165,6 +2169,7 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
>                         error("Unable to create AVDTP session");
>                         goto fail;
>                 }
> +               avdtp_ref(chan->session);
>         }
>
>         g_io_channel_unref(chan->io);
> --
> 2.29.1
>
> Marijn Suijten



-- 
Luiz Augusto von Dentz
