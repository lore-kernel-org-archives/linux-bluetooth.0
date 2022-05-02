Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65D3C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 May 2022 21:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385101AbiEBV0y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 May 2022 17:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379908AbiEBV0v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 May 2022 17:26:51 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1C9BC83
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 May 2022 14:23:20 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id e5so1504036pgc.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 May 2022 14:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w4Xf4PKul0dRDsR568hSrl1yewjJixrs+wilzON3J5k=;
        b=Vloap+d59YpFEzpyYdhOelx4lfy5BdZoHZq4hwU73wx940G3HiY9+cUCYekvM72TUd
         BOqkNrNCxFDBpHpVd4kzIAX17krlq/WzX6qznsLB8TajYmQQn7XzcxOB3y0rwzCbE70v
         /AeL5ck8iR0cZ815Q9pi1sqiFcoH4uCkK6/7BUhyiMfj4U091yWDAjp8bHbaztWkldZ4
         TSDyQsC6DU/uDKlpmC6a/19Q2RKH6k89450I+/x6X9aQPfnQy0UiP4PAt6OJ6WkNqq86
         SqAC8UbIGJGaps1TBKcTLkgTujoqICbsLMBlvIm3FwJgtM7M6BlI6WzIiWwp3vHYpxLJ
         4oSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w4Xf4PKul0dRDsR568hSrl1yewjJixrs+wilzON3J5k=;
        b=FfrPu3WIAxe+sKE6jgiFlrplgIKQZNHY7ojd+xja0YuGAFdiAvrFo/EFMxv967NJts
         XMP+RVcQ43xYUTfKpU0yADHtRj0PD6AM7ZTdrgKEjKJmiGF74sH+9QtCleC5u62gqy5e
         d5oI5rxdBUrWnVb77C0zXYJH1ZgYfeksrBLLBLMb7+dQ0QjHSIrqfLTlb9IDcw0+NBy+
         XXWG0o2OX/TnBXvQKvJcF4iUjNtHUksK9ADpRm0zCzLFv/YZxuv/CgZSuF+sW6MSMJUR
         0nD9dNJwPYXtZlMrZI78gpCWgr83BExGCXEsR3P8+yr9LM/KqznCxDnAJTAfCXQ58JTO
         uz/A==
X-Gm-Message-State: AOAM5333joG1tes1M0Uu09YZLaI5npu2pvP+Jlm8jt6F492sUiV9upXT
        LwGHwLDt0PwSrMRLy451hO05ByHqnzk/KNpr401j64eJ
X-Google-Smtp-Source: ABdhPJxmJfho8mP/gzoEXHDBS3+kLLpyJHRIjKNdGFREmvhgEDeNHzwQiOkkAUbeeCQxlFwDoReh9ydHq1l5YqwWzdU=
X-Received: by 2002:a63:8143:0:b0:3ab:6bb5:8642 with SMTP id
 t64-20020a638143000000b003ab6bb58642mr10986332pgd.591.1651526600247; Mon, 02
 May 2022 14:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220418174929.2777339-1-jiangzp@google.com> <20220418174914.Bluez.v2.1.I6ab300fa4999c9310f4cb6fc09b1290edb6b2c2b@changeid>
 <CABBYNZL7YZFch1ExcgsFV1AJV2ZBq_dXSyQFR=Zhb9Xjyk66Jg@mail.gmail.com>
 <CABBYNZL1V6FXaUiDbh0=sbvpvw6FSU0de-BR=wXMAbtX5Ugwww@mail.gmail.com> <CAB4PzUpJmkXsgH_w++U0i8g_YvUbmae5n37acF3=q+3P0nJX2g@mail.gmail.com>
In-Reply-To: <CAB4PzUpJmkXsgH_w++U0i8g_YvUbmae5n37acF3=q+3P0nJX2g@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 2 May 2022 14:23:08 -0700
Message-ID: <CABBYNZLVtVqYhbAuaAqv+kY9YNsTzyCwRWW5yqyrDEh_zHkfXA@mail.gmail.com>
Subject: Re: [Bluez PATCH v2 1/2] device: Add "Bonded" flag to dbus property
To:     Zhengping Jiang <jiangzp@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Yun-Hao Chung <howardchung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Zhengping,

On Mon, May 2, 2022 at 2:20 PM Zhengping Jiang <jiangzp@google.com> wrote:
>
> Hi Luiz,
>
> Sorry for the delay. I just submitted a new patch for internal review. Will be sent upstream very soon.
> Just to confirm, I will remove the option "paired-devices" and add optional arguments to "devices" command, so it can generate a list of devices based on filters.

Great, thanks for letting me know. And yes, I think listing devices
based on filters is a better option than yet another command to list a
subset of devices.

> Thanks,
> Zhengping
>
> On Mon, May 2, 2022 at 2:12 PM Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>>
>> Hi Zhengping,
>>
>> On Mon, Apr 18, 2022 at 3:41 PM Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>> >
>> > Hi Zhengping,
>> >
>> > On Mon, Apr 18, 2022 at 10:49 AM Zhengping Jiang <jiangzp@google.com> wrote:
>> > >
>> > > Add "Bonded" to dbus device property table. When setting the "Bonded
>> > > flag, check the status of the Bonded property first. If the Bonded
>> > > property is changed, send property changed signal.
>> > >
>> > > Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
>> > > Reviewed-by: Yun-Hao Chung <howardchung@chromium.org>
>> > >
>> > > Signed-off-by: Zhengping Jiang <jiangzp@google.com>
>> > > ---
>> > >
>> > > Changes in v2:
>> > > - Move one variable declaration to the top following C90 standard
>> > >
>> > > Changes in v1:
>> > > - Add "Bonded" to D-Bus interface
>> > > - Send property changed signal if the bonded flag is changed
>> > >
>> > >  doc/device-api.txt |  4 ++++
>> > >  src/device.c       | 40 +++++++++++++++++++++++++++++++++++-----
>> > >  2 files changed, 39 insertions(+), 5 deletions(-)
>> > >
>> > > diff --git a/doc/device-api.txt b/doc/device-api.txt
>> > > index 4e824d2dec17..6162755f954c 100644
>> > > --- a/doc/device-api.txt
>> > > +++ b/doc/device-api.txt
>> > > @@ -171,6 +171,10 @@ Properties string Address [readonly]
>> > >
>> > >                         Indicates if the remote device is paired.
>> > >
>> > > +               boolean Bonded [readonly]
>> > > +
>> > > +                       Indicates if the remote device is bonded.
>> >
>> > It is probably a good idea to add a description about Bonded vs
>> > Paired. Btw, API documentation should be in a separate patch.
>>
>> Will you be updating following this comments or you are waiting more
>> feedback from upstream?
>>
>> > > +
>> > >                 boolean Connected [readonly]
>> > >
>> > >                         Indicates if the remote device is currently connected.
>> > > diff --git a/src/device.c b/src/device.c
>> > > index 8dc12d026827..868c41f025d9 100644
>> > > --- a/src/device.c
>> > > +++ b/src/device.c
>> > > @@ -1042,6 +1042,22 @@ static gboolean dev_property_get_paired(const GDBusPropertyTable *property,
>> > >         return TRUE;
>> > >  }
>> > >
>> > > +static gboolean dev_property_get_bonded(const GDBusPropertyTable *property,
>> > > +                                       DBusMessageIter *iter, void *data)
>> > > +{
>> > > +       struct btd_device *dev = data;
>> > > +       dbus_bool_t val;
>> > > +
>> > > +       if (dev->bredr_state.bonded || dev->le_state.bonded)
>> > > +               val = TRUE;
>> > > +       else
>> > > +               val = FALSE;
>> > > +
>> > > +       dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &val);
>> > > +
>> > > +       return TRUE;
>> > > +}
>> > > +
>> > >  static gboolean dev_property_get_legacy(const GDBusPropertyTable *property,
>> > >                                         DBusMessageIter *iter, void *data)
>> > >  {
>> > > @@ -3120,6 +3136,7 @@ static const GDBusPropertyTable device_properties[] = {
>> > >         { "Icon", "s", dev_property_get_icon, NULL,
>> > >                                         dev_property_exists_icon },
>> > >         { "Paired", "b", dev_property_get_paired },
>> > > +       { "Bonded", "b", dev_property_get_bonded },
>> > >         { "Trusted", "b", dev_property_get_trusted, dev_property_set_trusted },
>> > >         { "Blocked", "b", dev_property_get_blocked, dev_property_set_blocked },
>> > >         { "LegacyPairing", "b", dev_property_get_legacy },
>> > > @@ -6114,17 +6131,30 @@ void btd_device_set_trusted(struct btd_device *device, gboolean trusted)
>> > >
>> > >  void device_set_bonded(struct btd_device *device, uint8_t bdaddr_type)
>> > >  {
>> > > +       struct bearer_state *state;
>> > > +
>> > >         if (!device)
>> > >                 return;
>> > >
>> > > -       DBG("");
>> > > +       state = get_state(device, bdaddr_type);
>> > >
>> > > -       if (bdaddr_type == BDADDR_BREDR)
>> > > -               device->bredr_state.bonded = true;
>> > > -       else
>> > > -               device->le_state.bonded = true;
>> > > +       if (state->bonded)
>> > > +               return;
>> > > +
>> > > +       DBG("setting bonded for device to true");
>> > > +
>> > > +       state->bonded = true;
>> > >
>> > >         btd_device_set_temporary(device, false);
>> > > +
>> > > +       /* If the other bearer state was already true we don't need to
>> > > +        * send any property signals.
>> > > +        */
>> > > +       if (device->bredr_state.bonded == device->le_state.bonded)
>> > > +               return;
>> > > +
>> > > +       g_dbus_emit_property_changed(dbus_conn, device->path,
>> > > +                                               DEVICE_INTERFACE, "Bonded");
>> > >  }
>> > >
>> > >  void device_set_legacy(struct btd_device *device, bool legacy)
>> > > --
>> > > 2.36.0.rc0.470.gd361397f0d-goog
>> > >
>> >
>> >
>> > --
>> > Luiz Augusto von Dentz
>>
>>
>>
>> --
>> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
