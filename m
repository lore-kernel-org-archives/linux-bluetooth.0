Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E146DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 May 2022 21:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387584AbiEBVPj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 May 2022 17:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbiEBVPi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 May 2022 17:15:38 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBCE1104
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 May 2022 14:12:08 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso418271pjj.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 May 2022 14:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mjEyjWzwg01OjZmfgcXhjH7l+zjibnXv5mKAEZHcc4g=;
        b=fj7/xFtwibHaNuOW3ws2R7mf2axo0NYQ1dUKDOo4vrclFf+O4aG51SprO6BCQOUBa5
         gWycH1dxNUhWqnFR1zYtnwCC5ftSOLRoP0RoEWOYIEZg+wvlK+L52hTBkxV+1Df/ya4U
         fJdth8VnV4nV3HIiwcH4+GGXHh62Cv+zw9dWfy27FuofmUtNj+fwEh7GWGvjKWNPLUxK
         grTKkO+Mo1R/NvVuOt9mNXB1pfn2ady9+L5lrPR2RwGoB7vpiA5U+8u2WR5jC5grz+T4
         nyJvvPtTq9BoIne+mchbo62YarptvKWiQBvrraCR6AJVKdFhpkp6Y84piwxupAlQ8HmH
         wxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mjEyjWzwg01OjZmfgcXhjH7l+zjibnXv5mKAEZHcc4g=;
        b=s0GxbiNeWcww98T5s/7Ntgpm3Sqhtv3WeK9Ftm1HSzpmq3aSPoAdo42+uG6i2egHat
         5a5/JLBwbor44VA3wtTWS64Bn/otmPj+CDAHh1CsjSj97yWDdNtPNHl7C17OVhNIK7WY
         cvbQaiXMCshokb6ggdKSetqrG3ClRPO7miN13iSTVygckMjfFjp4Y5jLx7xXUrD5KvwK
         x19LxBAhdFQ+r7nU8sTX+yHT/RSJOwK8TCNbuav49dBOFvb+o2CuiXncWsQ0gOMtT4jf
         zKRNq7kzqTvoApXC0WzwLepUd+xlqUZR8kBh1KMApDSWIsk+3/ukSi3DfhIWukbJS7+9
         6grw==
X-Gm-Message-State: AOAM532c8MMrmQ/X4Jipwh/eUq905bicOFg54z7PZW3a17atzN5q4a+T
        Sk6ox1TKWygfVf1z7C+U3sU9V1FwzeTiztrhFU0=
X-Google-Smtp-Source: ABdhPJwgZ3m8wAyFGIX+f+Wsdb84O7DoQnsQlxpRgRw5t6n4o4+4Rb6rHRb1JG2t1ax7qSGqbXJ8ep97neD+TajJQVA=
X-Received: by 2002:a17:90a:8a92:b0:1d7:3cca:69d8 with SMTP id
 x18-20020a17090a8a9200b001d73cca69d8mr1124169pjn.61.1651525927657; Mon, 02
 May 2022 14:12:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220418174929.2777339-1-jiangzp@google.com> <20220418174914.Bluez.v2.1.I6ab300fa4999c9310f4cb6fc09b1290edb6b2c2b@changeid>
 <CABBYNZL7YZFch1ExcgsFV1AJV2ZBq_dXSyQFR=Zhb9Xjyk66Jg@mail.gmail.com>
In-Reply-To: <CABBYNZL7YZFch1ExcgsFV1AJV2ZBq_dXSyQFR=Zhb9Xjyk66Jg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 2 May 2022 14:11:56 -0700
Message-ID: <CABBYNZL1V6FXaUiDbh0=sbvpvw6FSU0de-BR=wXMAbtX5Ugwww@mail.gmail.com>
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

On Mon, Apr 18, 2022 at 3:41 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Zhengping,
>
> On Mon, Apr 18, 2022 at 10:49 AM Zhengping Jiang <jiangzp@google.com> wrote:
> >
> > Add "Bonded" to dbus device property table. When setting the "Bonded
> > flag, check the status of the Bonded property first. If the Bonded
> > property is changed, send property changed signal.
> >
> > Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> > Reviewed-by: Yun-Hao Chung <howardchung@chromium.org>
> >
> > Signed-off-by: Zhengping Jiang <jiangzp@google.com>
> > ---
> >
> > Changes in v2:
> > - Move one variable declaration to the top following C90 standard
> >
> > Changes in v1:
> > - Add "Bonded" to D-Bus interface
> > - Send property changed signal if the bonded flag is changed
> >
> >  doc/device-api.txt |  4 ++++
> >  src/device.c       | 40 +++++++++++++++++++++++++++++++++++-----
> >  2 files changed, 39 insertions(+), 5 deletions(-)
> >
> > diff --git a/doc/device-api.txt b/doc/device-api.txt
> > index 4e824d2dec17..6162755f954c 100644
> > --- a/doc/device-api.txt
> > +++ b/doc/device-api.txt
> > @@ -171,6 +171,10 @@ Properties string Address [readonly]
> >
> >                         Indicates if the remote device is paired.
> >
> > +               boolean Bonded [readonly]
> > +
> > +                       Indicates if the remote device is bonded.
>
> It is probably a good idea to add a description about Bonded vs
> Paired. Btw, API documentation should be in a separate patch.

Will you be updating following this comments or you are waiting more
feedback from upstream?

> > +
> >                 boolean Connected [readonly]
> >
> >                         Indicates if the remote device is currently connected.
> > diff --git a/src/device.c b/src/device.c
> > index 8dc12d026827..868c41f025d9 100644
> > --- a/src/device.c
> > +++ b/src/device.c
> > @@ -1042,6 +1042,22 @@ static gboolean dev_property_get_paired(const GDBusPropertyTable *property,
> >         return TRUE;
> >  }
> >
> > +static gboolean dev_property_get_bonded(const GDBusPropertyTable *property,
> > +                                       DBusMessageIter *iter, void *data)
> > +{
> > +       struct btd_device *dev = data;
> > +       dbus_bool_t val;
> > +
> > +       if (dev->bredr_state.bonded || dev->le_state.bonded)
> > +               val = TRUE;
> > +       else
> > +               val = FALSE;
> > +
> > +       dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &val);
> > +
> > +       return TRUE;
> > +}
> > +
> >  static gboolean dev_property_get_legacy(const GDBusPropertyTable *property,
> >                                         DBusMessageIter *iter, void *data)
> >  {
> > @@ -3120,6 +3136,7 @@ static const GDBusPropertyTable device_properties[] = {
> >         { "Icon", "s", dev_property_get_icon, NULL,
> >                                         dev_property_exists_icon },
> >         { "Paired", "b", dev_property_get_paired },
> > +       { "Bonded", "b", dev_property_get_bonded },
> >         { "Trusted", "b", dev_property_get_trusted, dev_property_set_trusted },
> >         { "Blocked", "b", dev_property_get_blocked, dev_property_set_blocked },
> >         { "LegacyPairing", "b", dev_property_get_legacy },
> > @@ -6114,17 +6131,30 @@ void btd_device_set_trusted(struct btd_device *device, gboolean trusted)
> >
> >  void device_set_bonded(struct btd_device *device, uint8_t bdaddr_type)
> >  {
> > +       struct bearer_state *state;
> > +
> >         if (!device)
> >                 return;
> >
> > -       DBG("");
> > +       state = get_state(device, bdaddr_type);
> >
> > -       if (bdaddr_type == BDADDR_BREDR)
> > -               device->bredr_state.bonded = true;
> > -       else
> > -               device->le_state.bonded = true;
> > +       if (state->bonded)
> > +               return;
> > +
> > +       DBG("setting bonded for device to true");
> > +
> > +       state->bonded = true;
> >
> >         btd_device_set_temporary(device, false);
> > +
> > +       /* If the other bearer state was already true we don't need to
> > +        * send any property signals.
> > +        */
> > +       if (device->bredr_state.bonded == device->le_state.bonded)
> > +               return;
> > +
> > +       g_dbus_emit_property_changed(dbus_conn, device->path,
> > +                                               DEVICE_INTERFACE, "Bonded");
> >  }
> >
> >  void device_set_legacy(struct btd_device *device, bool legacy)
> > --
> > 2.36.0.rc0.470.gd361397f0d-goog
> >
>
>
> --
> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
