Return-Path: <SRS0=kmT4=B7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F91C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 20:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79FB820735
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 20:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ofKZdUWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgHUUS4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Aug 2020 16:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgHUUSx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Aug 2020 16:18:53 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEEAC061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 13:18:52 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id z10so612155ooi.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 13:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oXHXAm4q+TYGHtxOfWBF8ZTfK3HEauWUVopzxyclBjk=;
        b=ofKZdUWGys1UqhInXDEbybNl9qmjJ3EiTpl72sf9StQEA6gTwvEVJdkXUtZ62OVZ5i
         yYEfVTrhm6p5/z6EiRIWlJYbxnUylF4/NkfMuECEdOgXcv4VhtZHWIIq+gENmnlX3wV4
         Q+0PZOCD6kBCJmFubuwz0+Njkh5QT4ixDKE4H4IQSm8eQowQHvFTW1CUoJeCk36RCyDR
         9w9rzfc+6uKC+dDUyiq7RJrESjbdGp3lq2hBJT49xVdeMJEqCvYvioc3PUP5Jn1LoY47
         lkpmcOwvnwtLzeTUSujA5iJDcfTcNIIlpMaz7ElHmVz/yGrxyH73h6nFlTs0U71S++r9
         AHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oXHXAm4q+TYGHtxOfWBF8ZTfK3HEauWUVopzxyclBjk=;
        b=IzDD2jBXRu0BlPq346BB+MEvAf1OQI2RPSXfNt4OzQFPXSc13SiO20FNbyCjYAWsqp
         uoQJ9Bfdc4NViEmLVOheH8RBEsYXmmb7fJ1s0mQj6PsKiIWI/Ep5Ftes5lB4E62Nj5fH
         KbJVW4GgiEd3kGIQ+tcqj97hQy5nKw5wZkazZwNnI+psKKtvg+NNSo/A+LaVVihmAQdR
         0HmZNd9GkTUZfESTwJTxNgyUaC3BNCIQ4B12GPgIqFLY52cU/e/YmfD5nBKcRnVK8NiF
         b7JxotMOnqRLeeOJXNo4AI7JIJfoOEyv52d/AdDURQfw76EVPG76HsRajkcMnxRg0JEL
         U5cA==
X-Gm-Message-State: AOAM533s9INyE8CcX8AD7egPwTEfqErR1qYgFoThMThddhlpMwLdNdBQ
        tCeAK3HxO82z+lOzvonkW4ap/eLrHA2/6X7CMwo=
X-Google-Smtp-Source: ABdhPJwTTef4jR876xO5l46J+RUb/Dx3LQwB2H8njjQImcOYvX2HY7XJSn8Xnh8+GX/lt7nlLK/u22zv7AipcgpD+eA=
X-Received: by 2002:a4a:380b:: with SMTP id c11mr3392275ooa.17.1598041130670;
 Fri, 21 Aug 2020 13:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200821180106.21048-1-sonnysasaka@chromium.org>
In-Reply-To: <20200821180106.21048-1-sonnysasaka@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 21 Aug 2020 13:18:40 -0700
Message-ID: <CABBYNZLukR4BiogyFSDden0KMVrMaSSTfWO-Eg6h5GGd_kiW+g@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] device: Fix race condition between device
 connection and disconnection
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Fri, Aug 21, 2020 at 11:04 AM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> When Connect() is called and waiting for return, dev_disconnected may be
> called due to MGMT_EV_DEVICE_DISCONNECTED event from kernel. In that
> case reply to client that the connection failed otherwise the dbus
> method will timeout because bluetoothd never replies.
>
> Tested with simulation of a lot of Connect() to bluetooth devices and
> check that error is returned from bluetoothd rather than dbus timeout
> when this race condition happens.
>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
>
> ---
>  src/device.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/src/device.c b/src/device.c
> index 7b7808405..f59b6c1d0 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -3006,6 +3006,7 @@ void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type)
>  void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
>  {
>         struct bearer_state *state = get_state(device, bdaddr_type);
> +       DBusMessage *reply;
>
>         if (!state->connected)
>                 return;
> @@ -3020,6 +3021,18 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
>                 device->disconn_timer = 0;
>         }
>
> +       /* This could be executed while the client is waiting for Connect() but
> +        * att_connect_cb has not been invoked.
> +        * In that case reply the client that the connection failed.
> +        */
> +       if (device->connect) {
> +               DBG("connection removed while Connect() is waiting reply");
> +               reply = btd_error_failed(device->connect, "Disconnected early");
> +               g_dbus_send_message(dbus_conn, reply);
> +               dbus_message_unref(device->connect);
> +               device->connect = NULL;
> +       }
> +
>         while (device->disconnects) {
>                 DBusMessage *msg = device->disconnects->data;
>
> --
> 2.26.2
>

Applied, thanks.

-- 
Luiz Augusto von Dentz
