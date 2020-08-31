Return-Path: <SRS0=C8Ye=CJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4DBC433E6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Aug 2020 17:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4D592083E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Aug 2020 17:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uJwz38bA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgHaRUR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgHaRUQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Aug 2020 13:20:16 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA5DC061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 10:20:15 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id h17so5981413otl.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 10:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1IzJEopicGDPL2oMYcs87CbSRYx5MMY1Eccm67ldgkw=;
        b=uJwz38bAn/fZ1ojGptuEUEA9s7LYOxamKwJWKwX9ocW5IhZwkDZxq3nfAFM+iZH4ve
         ntWvzBmttmTEGt91PxxNZifpc9aPE+mqrMwGeebl/P3wMHIDOPQT/GZbluRYquOmAfjJ
         2cqvWomTVzSkO16o8WowVf+0O02MpNWDK94vzObNRjj2n8qPTA4jVhFduZFOcOHqqu7j
         0ycUEXipRMXVjNkir2o8vWMnhMfGLJeGApttlcj3RS1TzMeMJi1xDxp5LKJ9x0Cp1VtI
         Fvdu7XbjoQXy1s0ZRYqhWGyriIQoOh2xHdX9QypLRe55HlnUcbxPeYWBNpy28CyRIkNT
         LUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1IzJEopicGDPL2oMYcs87CbSRYx5MMY1Eccm67ldgkw=;
        b=n01SegU1c+1foxS6salIJFYy2NfSYTkIAIHAk5SKbe/SXvho473B1GJ/J1Nhdq9gkV
         /wsY1XkKBSazL+tcukas1MEDtCWgFdAm224YJbi3yFSY7Q/ev/rgJxXS0MfuTixOqrSd
         oUmTsCIAnNAanNc/7/Kwpov7kZSRC6zv+3sp5iSxpWjwxjkf+AuyzqtB2drXMpY81Ep4
         d+AoGhbbW++9RFQzvjJ8JRARyIqx+m6D5/oh0KZM5y5ZVoG8K/YSTGbNX/4NpCTk1/cI
         qVN1WsSVIuk6akdBtkQPYBJx/yzujgNsOsSdarsIruo5emdg51cY2mjbXTHBCI+YqzQV
         gvmA==
X-Gm-Message-State: AOAM533djgl+8SvKjEctDMHwPkEuf8Uy816dvhXR3FSkZ0UdkzvU4c+o
        xRT4tIUe9uPZWUwC8XrSDZUjA234GOMr4/mtMFA=
X-Google-Smtp-Source: ABdhPJwDKbNnYCHrbNVp864QnkJthxhtmCXUcSv4wkI4T6VnPFM49YnjCdn6VTNnLOtDiXgmZgeMZ7wyn4wnxoMhhTE=
X-Received: by 2002:a9d:6053:: with SMTP id v19mr1540513otj.362.1598894415317;
 Mon, 31 Aug 2020 10:20:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200831154443.Bluez.v1.1.Ieeae14ab680eda03474551fdb7a0a020f950e9c1@changeid>
In-Reply-To: <20200831154443.Bluez.v1.1.Ieeae14ab680eda03474551fdb7a0a020f950e9c1@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 31 Aug 2020 10:20:05 -0700
Message-ID: <CABBYNZJhkBJY7+Y73tdpV_ca5dmoiYhutq5iONAMbCjD+EL+zQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] media: Don't set initial volume if it's invalid
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Yu Liu <yudiliu@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Mon, Aug 31, 2020 at 12:45 AM Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> When initializing media transport, we try to initialize the volume
> of the player. However, the assigned initial volume could be invalid
> due to the session has not been initialized, or when we assume the
> role of audio sink. In this case, we should not assign the initial
> volume.

Not really following the explanation here, if the session has not been
initialized yet shouldn't the volume be actually invalid? Or is the
problem that we don't call media_transport_update_volume later when it
is initialized?

> Reviewed-by: Michael Sun <michaelfsun@google.com>
> Reviewed-by: Yu Liu <yudiliu@google.com>
> ---
>
>  profiles/audio/media.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index 02bf82a49..acb4a8ee9 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -494,7 +494,8 @@ static gboolean set_configuration(struct media_endpoint *endpoint,
>                 return FALSE;
>
>         init_volume = media_player_get_device_volume(device);
> -       media_transport_update_volume(transport, init_volume);
> +       if (init_volume >= 0)
> +               media_transport_update_volume(transport, init_volume);

You can probably move the check to be done internally inside update_volume.

>         msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
>                                                 MEDIA_ENDPOINT_INTERFACE,
> --
> 2.28.0.402.g5ffc5be6b7-goog
>


-- 
Luiz Augusto von Dentz
