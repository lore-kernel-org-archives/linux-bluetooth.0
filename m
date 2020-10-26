Return-Path: <SRS0=rjyd=EB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDA9C4363A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 23:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDEB421D42
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 23:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBv92dGe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408563AbgJZXr7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Oct 2020 19:47:59 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39685 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408556AbgJZXr6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Oct 2020 19:47:58 -0400
Received: by mail-ot1-f67.google.com with SMTP id o14so9615600otj.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2020 16:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jL+9JS8TXNqOfVVOwdzqDG6oj5ns0nhV8uhR7Rj24Sg=;
        b=RBv92dGe/F4qsf6ApFTIBin/K+4WsTBOkWnVGZAfbZmkFDFosIZCv8d91Jz6NtfevP
         mLlONw4uQbbjotaJvp6esWVyU7OfDLOkVWkzPNmkBm1QHSzOkIFAAmu5fyuwULwv0nyy
         bgQ9RyPKwMm3evSHX1mIdT0CXlv0iGBfq386ifVfDLwvf3DuiiSOJEYUZO9375RA/ERY
         MaPDOPLRL+9N2vqYdoBkg/Oa2JC7o/0G7m95R94JseMJR8f2Ipyws84krt3k97B2nq9L
         jjLZz3Ga889wljGfzTEXfwnyeAxBN9zbCCvyEz31euUZwzCbmG5V5/mHdebzR7JKb5rH
         MLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jL+9JS8TXNqOfVVOwdzqDG6oj5ns0nhV8uhR7Rj24Sg=;
        b=fVftGbjjsAfUSjQTcZrg5DegIZN7TYLRt23NIGC0Vao60+Vad1hVPFMiAPWyGsRyK8
         UCqL4aqXyEI0vYCWi9e7CeyZiPmYBbDYy3DT7K50J8sCicgBV0sLDZ11m/KlNJMTAk9H
         3irehIRjNcwZPRz2/lhBG7M3uXzgyhIjaMJwpON/nuhD4UBFvHR528moIvvRlCT4AOHp
         xS+M3RNoBb29R5XAp4q4KKgqNhQ5gW5YtrsnuP8BRRWLuGah19HctxzxdX95FQv3IFOh
         3FycZcsQMsvujeH+6gN6KlxKMm/8MVwoi3sb8dfOQLEkOKhJ6aIl+0IGjnh4tm4iDQz/
         KQIQ==
X-Gm-Message-State: AOAM530NWvhrGg02dc9DbvyjPshpy8i3jqQSRk8wWcAopXADYlzRqMLa
        gdLfobliMD6/l3B+S2yT7uI/YfYlCH7H0/nA/mg=
X-Google-Smtp-Source: ABdhPJyM2yyz7Civk6yERV6MnT5PjnMLTWPWJMbAouKsqxcG08NUjSChEmUqkRHtsDiMLOVr915pEUyWPoNUF/M3uD0=
X-Received: by 2002:a05:6830:400d:: with SMTP id h13mr17140545ots.371.1603756077145;
 Mon, 26 Oct 2020 16:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <20201026195408.2528476-1-marijns95@gmail.com>
In-Reply-To: <20201026195408.2528476-1-marijns95@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 26 Oct 2020 16:47:46 -0700
Message-ID: <CABBYNZJ6dRWGtPst6AZ=U9xTfjueobrEvkh3YLzWEFPx7D9uAA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] audio/media: Destroy transport if
 SetConfiguration fails
To:     Marijn Suijten <marijns95@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marijn,

On Mon, Oct 26, 2020 at 12:54 PM Marijn Suijten <marijns95@gmail.com> wrote:
>
> set_configuration creates a transport before calling SetConfiguration on
> the MediaEndpoint1 DBus interface.  If this DBus call fails the
> transport sticks around while it should instead be cleaned up.
>
> When the peer retries or reconnects (in case of BlueZ which cuts the
> connection due to a missing recount [1]) set_configuration finds this
> old transport and returns FALSE.  The peer will never succeed this call
> unless it randomly decides to call clear_configuration or BlueZ is
> restarted.
>
> [1]: https://marc.info/?l=linux-bluetooth&m=160364326629847&w=2
> ---
>
> Changes in v2:
> - Removed incorrect statement about disconnection cause
> - Store reference to transport in endpoint_request instead of retrieving
>   it through find_device_transport
>
>  profiles/audio/media.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index 74064d398..c84bbe22d 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -71,6 +71,7 @@ struct media_adapter {
>
>  struct endpoint_request {
>         struct media_endpoint   *endpoint;
> +       struct media_transport  *transport;
>         DBusMessage             *msg;
>         DBusPendingCall         *call;
>         media_endpoint_cb_t     cb;
> @@ -298,6 +299,15 @@ static void endpoint_reply(DBusPendingCall *call, void *user_data)
>                         return;
>                 }
>
> +               if (dbus_message_is_method_call(request->msg,
> +                                       MEDIA_ENDPOINT_INTERFACE,
> +                                       "SetConfiguration")) {
> +                       if (request->transport == NULL)
> +                               error("Expected to destroy transport");
> +                       else
> +                               media_transport_destroy(request->transport);
> +               }
> +
>                 dbus_error_free(&err);
>                 goto done;
>         }
> @@ -337,6 +347,7 @@ done:
>
>  static gboolean media_endpoint_async_call(DBusMessage *msg,
>                                         struct media_endpoint *endpoint,
> +                                       struct media_transport *transport,
>                                         media_endpoint_cb_t cb,
>                                         void *user_data,
>                                         GDestroyNotify destroy)
> @@ -358,6 +369,7 @@ static gboolean media_endpoint_async_call(DBusMessage *msg,
>                                                                         NULL);
>
>         request->endpoint = endpoint;
> +       request->transport = transport;
>         request->msg = msg;
>         request->cb = cb;
>         request->destroy = destroy;
> @@ -393,7 +405,8 @@ static gboolean select_configuration(struct media_endpoint *endpoint,
>                                         &capabilities, length,
>                                         DBUS_TYPE_INVALID);
>
> -       return media_endpoint_async_call(msg, endpoint, cb, user_data, destroy);
> +       return media_endpoint_async_call(msg, endpoint, NULL,
> +                                               cb, user_data, destroy);
>  }
>
>  static int transport_device_cmp(gconstpointer data, gconstpointer user_data)
> @@ -501,7 +514,8 @@ static gboolean set_configuration(struct media_endpoint *endpoint,
>
>         g_dbus_get_properties(conn, path, "org.bluez.MediaTransport1", &iter);
>
> -       return media_endpoint_async_call(msg, endpoint, cb, user_data, destroy);
> +       return media_endpoint_async_call(msg, endpoint, transport,
> +                                               cb, user_data, destroy);
>  }
>
>  static void release_endpoint(struct media_endpoint *endpoint)
> --
> 2.29.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
