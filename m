Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E29CC433E0
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 Feb 2021 06:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3299164EDE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 Feb 2021 06:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhBTGIu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 20 Feb 2021 01:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhBTGIt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 20 Feb 2021 01:08:49 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95B7C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Feb 2021 22:08:08 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id s107so7176710otb.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Feb 2021 22:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NYIAeeAlfZJENqCblqDXX3/qVLsMgX2I6CU0945qboI=;
        b=ioQAoJ6aLh2qQgTTtlH8NCILun6NhyGC1Refd6hJNj5dyjICiQCnv2V98q0Xj03Mx1
         6RnpyY9+ly5zNaHHTFy8Tc3L5q2sflMc/4Z8P6TN0xBHjc163AtSU3RTd8kRKUB8+u/m
         VQiRCrsxvE8Yr8MBosXm0UriM2sS9i4XbnItKiycKbcCe8l+O3W5PpQXHAV1DIgmWuqo
         ztlOcsRuKCZb1qFym3S2Q2/8Xf+Pcg5UYPmEMWLJv49VXv4MXoIYNQzwla5E8jykcKsP
         /pVQuI3URts0KfKF1gCkgRu/APlYXKHptFZDI0JoeJ+gOHSUV/BFoPgIhNwNOdwmkyj7
         tVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NYIAeeAlfZJENqCblqDXX3/qVLsMgX2I6CU0945qboI=;
        b=pXp4s/5Dnjn4koj8fRlJpTfjTOmwNybOi/7C5TlzlWnQEYuxuNokR+uKK4e22vIT9r
         NjKURDKmGqW10q5/fhyzyCGObvF3klQDfRWYMrYmQILf7dT/1u9AcLUOQdj5MaejH7Z3
         Od8MOcQQgSwSU6w8QFEjHfwpnNX87tbM8xXVPG4GLE349L8864D8zwftMpdzH7A1unba
         Qx4oGFIw3ZTcZaQ8AimiD1h0db5LORiG09rroQmfUFIBnI2q4q7wVaZDscy7efBeOBxo
         EiYJvhGcGlLK6QPLv6k3g0R3uFgfPnNJpx2feyjXkLJyUFiSdEpACYKH2oQETQr1NesE
         MTtw==
X-Gm-Message-State: AOAM530KbSdEZ6/QHLEau2kTVEjgKNmmlxU5ZCbGr2ZUoU846BpJret6
        wur1cy9xm5XL8mbhJ1a3ZGfr+ClsboWZAI7RylJx34sedzw=
X-Google-Smtp-Source: ABdhPJzUwiQg7IwFgdXqDNJ+IXlXn5Ti0uPUbg3EVOvxPXcDHv5i9KtUjwReor6AOiFM/I/vqWjPMFXC6ZE6QwokiBA=
X-Received: by 2002:a9d:6c7:: with SMTP id 65mr10086289otx.240.1613801288105;
 Fri, 19 Feb 2021 22:08:08 -0800 (PST)
MIME-Version: 1.0
References: <20210219174946.599144-1-curtis@maves.io> <CABBYNZKakfpzTOdZaoa0tZ5Umqu9MKMmkMfNN51XY5owC_KWwQ@mail.gmail.com>
 <177bd04559f.d1a7c05c116102.319856870975137121@maves.io>
In-Reply-To: <177bd04559f.d1a7c05c116102.319856870975137121@maves.io>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 19 Feb 2021 22:07:57 -0800
Message-ID: <CABBYNZJJiXJJqtRMXKEvpwN-mj=eht9wdTgrK1p_Fo_36gK4Zw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gatt-database: Fix notifying on indicatable attr
To:     Curtis Maves <curtis@maves.io>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Curtis,

On Fri, Feb 19, 2021 at 5:18 PM Curtis Maves <curtis@maves.io> wrote:
>
> Hi Luiz,
> ---- On Fri, 19 Feb 2021 19:55:06 -0500 Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote ----
>
>  > Hi Curtis,
>  >
>  > On Fri, Feb 19, 2021 at 10:11 AM Curtis <curtis@maves.io> wrote:
>  > >
>  > > When a local GATT characteristic has both the indicate and notify
>  > > properties, notifications will not be send to clients requesting them.
>  > > This change fixes this, allowing for notifications to be sent.
>  > >
>  > > Also simplifies logic about when notifications/indications should
>  > > be sent.
>  > > ---
>  > >  src/gatt-database.c | 15 ++++++---------
>  > >  1 file changed, 6 insertions(+), 9 deletions(-)
>  > >
>  > > diff --git a/src/gatt-database.c b/src/gatt-database.c
>  > > index d635c3214..bd5864bcd 100644
>  > > --- a/src/gatt-database.c
>  > > +++ b/src/gatt-database.c
>  > > @@ -1344,10 +1344,7 @@ static void send_notification_to_device(void *data, void *user_data)
>  > >         }
>  > >
>  > >         ccc = find_ccc_state(device_state, notify->ccc_handle);
>  > > -       if (!ccc)
>  > > -               return;
>  > > -
>  > > -       if (!ccc->value || (notify->conf && !(ccc->value & 0x0002)))
>  > > +       if (!ccc || !(ccc->value & 0x0003))
>  > >                 return;
>  > >
>  > >         device = btd_adapter_find_device(notify->database->adapter,
>  > > @@ -1374,7 +1371,7 @@ static void send_notification_to_device(void *data, void *user_data)
>  > >          * TODO: If the device is not connected but bonded, send the
>  > >          * notification/indication when it becomes connected.
>  > >          */
>  > > -       if (!notify->conf) {
>  > > +       if (!(ccc->value & 0x0002)) {
>  > >                 DBG("GATT server sending notification");
>  > >                 bt_gatt_server_send_notification(server,
>  > >                                         notify->handle, notify->value,
>  > > @@ -2415,8 +2412,8 @@ static bool sock_io_read(struct io *io, void *user_data)
>  > >                                 gatt_db_attribute_get_handle(chrc->attrib),
>  > >                                 buf, bytes_read,
>  > >                                 gatt_db_attribute_get_handle(chrc->ccc),
>  > > -                               chrc->props & BT_GATT_CHRC_PROP_INDICATE ?
>  > > -                               conf_cb : NULL, chrc->proxy);
>  > > +                               conf_cb,
>  > > +                               chrc->proxy);
>  >
>  > Not why are you changing this code to always set the conf_cb? This
>  > would then always send indication rather then notifications:
>  >
>  > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-database.c#n1387
>  >
>  > We might need to check what value it stored in the ccc state if both
>  > indication and notification is supported.
>  >
>  > >
>  > >         return true;
>  > >  }
>  > > @@ -2725,8 +2722,8 @@ static void property_changed_cb(GDBusProxy *proxy, const char *name,
>  > >                                 gatt_db_attribute_get_handle(chrc->attrib),
>  > >                                 value, len,
>  > >                                 gatt_db_attribute_get_handle(chrc->ccc),
>  > > -                               chrc->props & BT_GATT_CHRC_PROP_INDICATE ?
>  > > -                               conf_cb : NULL, proxy);
>  > > +                               conf_cb,
>  > > +                               proxy);
>  > >  }
>  > >
>  > >  static bool database_add_ccc(struct external_service *service,
>  > > --
>  > > 2.30.1
>  > >
>  > >
>  >
>  >
>  > --
>  > Luiz Augusto von Dentz
>  >
>
> This patch changes the if-statement around sending notifications to check that the
> ccc->value is not indicating rather than checking if conf_cb (notify->conf) is null.
> This change makes unnecessary to conditionally pass the conf_cb. It's now simpler to always pass it.

What Im saying is that we can't do this:

if (!notify->conf) {
DBG("GATT server sending notification");

conf callback will always be set so instead we need to change that to:

if (ccc->value != 0x02)



> --
> Curtis Maves



-- 
Luiz Augusto von Dentz
