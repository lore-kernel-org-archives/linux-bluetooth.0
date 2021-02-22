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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBDDC433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Feb 2021 18:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6324264DDA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Feb 2021 18:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbhBVSZp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Feb 2021 13:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbhBVSZm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Feb 2021 13:25:42 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DD6C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Feb 2021 10:25:01 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id d20so14925573oiw.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Feb 2021 10:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VQucvZBZ6vVu+FNzQTPnBDhxy3QOvokfHD2+kN8K6pA=;
        b=pJ/WM8Exp5xSJ1QpOOW1rCHWPslEvposCLJbj9visBrqXgBUcVFoiR8yEXCzBETveF
         syQ3oBvucJ72pjCtU62GOylZ1+kuGOtyxCwvnWIfS1lDAsClSMiXUzufsQJDffYCD5ci
         GQw+elcWteto/gJnyE2BA+j95uccLkNvHCT42kRit7j/Aa0KhjipY9ru/tSzpkgKkhJs
         K2UXvkRFm11cL8KplZXYQMtDue18z6eW7lsmpMjDpx8u91PXJMl50qqQ5EHichAIcp3i
         2XoruuQ32ZzhdNpTkOgQSmenyeMgEjRy4caIdTnyieSaPfXXA1tH32hi5tnxUCQI30Bb
         PbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VQucvZBZ6vVu+FNzQTPnBDhxy3QOvokfHD2+kN8K6pA=;
        b=r/P6tnEKV9LkrcGS9cIHScRj777BxmqdYBnahUFXT5BZGP1YjtihQ7qEqMLx1i9RVF
         DAWlgyR0UgiOtWYGDTRf5iv/inHok6jBJ+cPrReNQnDc67KgfGel3UE/+GjVmnyRyOIv
         DYynJD6EKlwRTxp4RvUP2asoeoA36iuQ9uNCwaD0QzmSr/shtEahw4/BehFTb/gEa1aZ
         Mz3OriC4EIi/Agg6ZoLpU/tTI1/ttzLunn/Yya9GBbRntGGOqPgyMt1SHpZ4RKUcCTeS
         qQO9SZVhJbFeqD+OcO83mkBzz5pXSJE4G9PSkW4x6xO84KcTrGOlq9Qu5yZI8MNyduxM
         vePQ==
X-Gm-Message-State: AOAM532PlvV7vAckjLFJ1LzseP8AN0U+oiTaChqw6h4hefMyLN7xO6L6
        xO0YDkDhLmrZucpJoN+/8s9t+dfg1AxOC8HQeXX4ZeIm
X-Google-Smtp-Source: ABdhPJxXmDqJSMSIqO4tX8VFXqcroz3nLgqusiQ5bdwCCN7BcZt/pZTzejG2N4h97cLu9SuHEUb6MXanHSsuLEy/5lU=
X-Received: by 2002:a54:468f:: with SMTP id k15mr16499023oic.58.1614018300647;
 Mon, 22 Feb 2021 10:25:00 -0800 (PST)
MIME-Version: 1.0
References: <20210219174946.599144-1-curtis@maves.io> <CABBYNZKakfpzTOdZaoa0tZ5Umqu9MKMmkMfNN51XY5owC_KWwQ@mail.gmail.com>
 <177bd04559f.d1a7c05c116102.319856870975137121@maves.io> <CABBYNZJJiXJJqtRMXKEvpwN-mj=eht9wdTgrK1p_Fo_36gK4Zw@mail.gmail.com>
 <177c0b3e32a.c0b69e35170119.443115256308628377@maves.io>
In-Reply-To: <177c0b3e32a.c0b69e35170119.443115256308628377@maves.io>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 22 Feb 2021 10:24:49 -0800
Message-ID: <CABBYNZ++t8Hu2b--jCwMkTwB5WeCDuMv_EU0z-cBetCjJpaZcA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gatt-database: Fix notifying on indicatable attr
To:     Curtis Maves <curtis@maves.io>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Curtis,

On Sat, Feb 20, 2021 at 10:29 AM Curtis Maves <curtis@maves.io> wrote:
>
> Hi Luiz,
> ---- On Sat, 20 Feb 2021 01:07:57 -0500 Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote ----
>
>  > Hi Curtis,
>  >
>  > On Fri, Feb 19, 2021 at 5:18 PM Curtis Maves <curtis@maves.io> wrote:
>  > >
>  > > Hi Luiz,
>  > > ---- On Fri, 19 Feb 2021 19:55:06 -0500 Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote ----
>  > >
>  > >  > Hi Curtis,
>  > >  >
>  > >  > On Fri, Feb 19, 2021 at 10:11 AM Curtis <curtis@maves.io> wrote:
>  > >  > >
>  > >  > > When a local GATT characteristic has both the indicate and notify
>  > >  > > properties, notifications will not be send to clients requesting them.
>  > >  > > This change fixes this, allowing for notifications to be sent.
>  > >  > >
>  > >  > > Also simplifies logic about when notifications/indications should
>  > >  > > be sent.
>  > >  > > ---
>  > >  > >  src/gatt-database.c | 15 ++++++---------
>  > >  > >  1 file changed, 6 insertions(+), 9 deletions(-)
>  > >  > >
>  > >  > > diff --git a/src/gatt-database.c b/src/gatt-database.c
>  > >  > > index d635c3214..bd5864bcd 100644
>  > >  > > --- a/src/gatt-database.c
>  > >  > > +++ b/src/gatt-database.c
>  > >  > > @@ -1344,10 +1344,7 @@ static void send_notification_to_device(void *data, void *user_data)
>  > >  > >         }
>  > >  > >
>  > >  > >         ccc = find_ccc_state(device_state, notify->ccc_handle);
>  > >  > > -       if (!ccc)
>  > >  > > -               return;
>  > >  > > -
>  > >  > > -       if (!ccc->value || (notify->conf && !(ccc->value & 0x0002)))
>  > >  > > +       if (!ccc || !(ccc->value & 0x0003))
>  > >  > >                 return;
>  > >  > >
>  > >  > >         device = btd_adapter_find_device(notify->database->adapter,
>  > >  > > @@ -1374,7 +1371,7 @@ static void send_notification_to_device(void *data, void *user_data)
>  > >  > >          * TODO: If the device is not connected but bonded, send the
>  > >  > >          * notification/indication when it becomes connected.
>  > >  > >          */
>  > >  > > -       if (!notify->conf) {
>  > >  > > +       if (!(ccc->value & 0x0002)) {
>  > >  > >                 DBG("GATT server sending notification");
>  > >  > >                 bt_gatt_server_send_notification(server,
>  > >  > >                                         notify->handle, notify->value,
>  > >  > > @@ -2415,8 +2412,8 @@ static bool sock_io_read(struct io *io, void *user_data)
>  > >  > >                                 gatt_db_attribute_get_handle(chrc->attrib),
>  > >  > >                                 buf, bytes_read,
>  > >  > >                                 gatt_db_attribute_get_handle(chrc->ccc),
>  > >  > > -                               chrc->props & BT_GATT_CHRC_PROP_INDICATE ?
>  > >  > > -                               conf_cb : NULL, chrc->proxy);
>  > >  > > +                               conf_cb,
>  > >  > > +                               chrc->proxy);
>  > >  >
>  > >  > Not why are you changing this code to always set the conf_cb? This
>  > >  > would then always send indication rather then notifications:
>  > >  >
>  > >  > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-database.c#n1387
>  > >  >
>  > >  > We might need to check what value it stored in the ccc state if both
>  > >  > indication and notification is supported.
>  > >  >
>  > >  > >
>  > >  > >         return true;
>  > >  > >  }
>  > >  > > @@ -2725,8 +2722,8 @@ static void property_changed_cb(GDBusProxy *proxy, const char *name,
>  > >  > >                                 gatt_db_attribute_get_handle(chrc->attrib),
>  > >  > >                                 value, len,
>  > >  > >                                 gatt_db_attribute_get_handle(chrc->ccc),
>  > >  > > -                               chrc->props & BT_GATT_CHRC_PROP_INDICATE ?
>  > >  > > -                               conf_cb : NULL, proxy);
>  > >  > > +                               conf_cb,
>  > >  > > +                               proxy);
>  > >  > >  }
>  > >  > >
>  > >  > >  static bool database_add_ccc(struct external_service *service,
>  > >  > > --
>  > >  > > 2.30.1
>  > >  > >
>  > >  > >
>  > >  >
>  > >  >
>  > >  > --
>  > >  > Luiz Augusto von Dentz
>  > >  >
>  > >
>  > > This patch changes the if-statement around sending notifications to check that the
>  > > ccc->value is not indicating rather than checking if conf_cb (notify->conf) is null.
>  > > This change makes unnecessary to conditionally pass the conf_cb. It's now simpler to always pass it.
>  >
>  > What Im saying is that we can't do this:
>  >
>  > if (!notify->conf) {
>  > DBG("GATT server sending notification");
>  >
>  > conf callback will always be set so instead we need to change that to:
>  >
>  > if (ccc->value != 0x02)
>  >
>  >
>  >
>  > > --
>  > > Curtis Maves
>  >
>  >
>  >
>  > --
>  > Luiz Augusto von Dentz
>  >
> I agree that we can no longer do the following on line 1377:
>  > if (!notify->conf) {
>  > DBG("GATT server sending notification");
>
> As you said the ccc value needs to be tested instead.
> This part of the patch  already makes a change similar to what you suggested:
>  > >  > > @@ -1374,7 +1371,7 @@ static void send_notification_to_device(void *data, void *user_data)
>  > >  > >          * TODO: If the device is not connected but bonded, send the
>  > >  > >          * notification/indication when it becomes connected.
>  > >  > >          */
>  > >  > > -       if (!notify->conf) {
>  > >  > > +       if (!(ccc->value & 0x0002)) {
> Is there anywhere else where notify->conf is checked?

I see, I probably overlooked this change when reviewing the first time.

> I looked around but did not find any on my own.
> --
> Curtis Maves
>


-- 
Luiz Augusto von Dentz
