Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE30C43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 00:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA4922220D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 00:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f7QCgfXm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgIQAH7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Sep 2020 20:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgIQAH6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Sep 2020 20:07:58 -0400
X-Greylist: delayed 316 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 20:07:58 EDT
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D41C061788
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 17:02:41 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id r7so480588ejs.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 17:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vGLCFIVcgI24OiWenGBKe8BW0rwzw4fcxjxBsHEuLsE=;
        b=f7QCgfXmLzHqBY1cv2X4I5qGYUqFAoe2rvk/uMDZ3u3tJsfCFDQJ0oSgX2dWEMNlK4
         56ks0CoFLs56M0QTBp/cgM9EL0STAJN1wtYOckLxXYD4Xdc1VKp9MtQEIwCzZvZlLxvx
         0uGVNL+pjuIePvAsJBkgwlSyWEJl9241p0vTpLUe/bnULB4Wsu2naJjfebuKb5vbGU5e
         JogFoFZMOstimpEndyRganlk2PLK2DbWIqIrD/emAwc8/dx/vyMmwLMh5/NzdVZ3tW6Y
         +w7hoavAVkgqmgONuEC7+uosp5KoQJEiYyQ7+0s5lvfFgpaKvbGvj0Uo3XWG7XoaXPIj
         1snw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vGLCFIVcgI24OiWenGBKe8BW0rwzw4fcxjxBsHEuLsE=;
        b=iHNcJ97HFzlzpZ52M2WKYuMscASKL0YSQx2t4YpukiWF0erg/DzwIAaPtHmgLKWDGO
         ryq1TTtjrtsvFoz3yO+Bkjerx/45Amb2+O56ASbVWvigyjVivnvPr4ryj+6Iaf1w+Hsl
         pwcGGs2A6TiH1EHJ7F533zKwWJh/gLsM13cd6emy2sdKt+O5U0/INFqPIErohP/08/sH
         UJ2MVVgT5sQiwpnshS6Wbq6HULGg0iKMakK3YAeKof8qz6+42uzhQ4abhBSztScchZ8D
         paczL43ho4ghYvOGSWry41jr2UopdTVU7FX9SncZSqY2zXozQzxMcK2m/joi8Y2BqYdc
         GbYQ==
X-Gm-Message-State: AOAM533aKVNzvykNIwl/C+0zrmZ/7ca74l+Y4WnooZqYeL0G01zh+S4I
        ZTGD/vI9DFWIMQTAj1lBQyfmA5KaGalCFBl8OjD+XA==
X-Google-Smtp-Source: ABdhPJy7sY1Mukd0GzKcmrjzT7YaMRYEnmb4UUIz/yy40C1JenDIdgOuEPd6rRsfQ9lSO3ZmPR5b+VMA8lmIkxz8eEo=
X-Received: by 2002:a17:906:d045:: with SMTP id bo5mr27234847ejb.320.1600300960102;
 Wed, 16 Sep 2020 17:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200916232542.1584854-1-danielwinkler@google.com>
 <20200916162155.Bluez.2.Ic4a3667da774f5f34477d5168a68a9280657e2da@changeid>
 <CABBYNZ+5DW4eM_r0xZKRuWGbbA-y64VYnGiFTBo7hu4E7G-qZw@mail.gmail.com>
 <CAP2xMbsSXX6VVuJTKeqkmgV-AJMdfku3LB7n4yrMdo+2yJk7HQ@mail.gmail.com> <CABBYNZ+Tb+pxae+6puQ=NwZD3mSdDxXZBucAwmyMNOJxX++Wrw@mail.gmail.com>
In-Reply-To: <CABBYNZ+Tb+pxae+6puQ=NwZD3mSdDxXZBucAwmyMNOJxX++Wrw@mail.gmail.com>
From:   Daniel Winkler <danielwinkler@google.com>
Date:   Wed, 16 Sep 2020 17:02:29 -0700
Message-ID: <CAP2xMbvp9WtKn5ANEcZxXmby3zde+F-5aQibPq07UWBc-fsocA@mail.gmail.com>
Subject: Re: [Bluez PATCH 02/10] advertising: Parse intervals and tx power
 from adv
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Luiz,

Yes, there is a separate kernel patch series that allows the TxPower
parameter to be set on a per-instance basis. This only applies to
controllers supporting extended advertising, so another bluez patch
series (awaiting review at
https://patchwork.kernel.org/patch/11749533/) allows the client to
check if the controller supports it first. This information is
clarified in the later patches in this series, where the advertising
api is updated.

Thanks!
Daniel


On Wed, Sep 16, 2020 at 4:58 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Daniel,
>
> On Wed, Sep 16, 2020 at 4:53 PM Daniel Winkler <danielwinkler@google.com> wrote:
> >
> > Hello Luiz,
> >
> > The patch allows the client to set an arbitrary TxPower, different from the include property.
>
> Does the controller honor this setting? Can we really set a TxPower
> per instance? If it doesn't then this can possibly break proximity
> logic on the scanner side.
>
> > Best,
> > Daniel
> >
> > On Wed, Sep 16, 2020 at 4:52 PM Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> >>
> >> Hi Daniel,
> >>
> >> On Wed, Sep 16, 2020 at 4:25 PM Daniel Winkler <danielwinkler@google.com> wrote:
> >> >
> >> > This change adds parsers for the advertising intervals and tx power
> >> > properties of the LEAdvertisement1 object. It validates that each field
> >> > adheres to the 5.2 spec, and that min and max intervals are compatible
> >> > with each other, i.e. that min interval is less than max interval.
> >> >
> >> > A note here for maintainers: The tx power that is sent in the hci
> >> > parameter command is an int8_t, but as far as I can tell, there is no
> >> > clean way to use a signed 8-bit integer in dbus. The dbus byte type
> >> > seems incompatible with negative values in high-level languages (python)
> >> > without awkward usage manipulation on the client side. For this reason,
> >> > I chose to use an int16_t type for the tx power dbus field, which is
> >> > then downcasted to the int8_t in bluetoothd, which at least makes the
> >> > signed-ness of the type crystal clear to the dbus client that uses it.
> >> >
> >> > This change is manually verified by ensuring the intervals and tx power
> >> > parameters are correctly parsed from the LEAdvertisement1 object, and
> >> > that the parse fails if the parameters are incorrect or not compatible
> >> > with each other.
> >> >
> >> > Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> >> > ---
> >> >
> >> >  src/advertising.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++
> >> >  1 file changed, 89 insertions(+)
> >> >
> >> > diff --git a/src/advertising.c b/src/advertising.c
> >> > index 172a83907..82ee87313 100644
> >> > --- a/src/advertising.c
> >> > +++ b/src/advertising.c
> >> > @@ -63,6 +63,11 @@ struct btd_adv_manager {
> >> >  #define AD_TYPE_BROADCAST 0
> >> >  #define AD_TYPE_PERIPHERAL 1
> >> >
> >> > +/* BLUETOOTH SPECIFICATION Version 5.2 | Vol 4, Part E, page 2585
> >> > + * defines tx power value indicating no preference
> >> > + */
> >> > +#define ADV_TX_POWER_NO_PREFERENCE 0x7F
> >> > +
> >> >  struct btd_adv_client {
> >> >         struct btd_adv_manager *manager;
> >> >         char *owner;
> >> > @@ -83,6 +88,9 @@ struct btd_adv_client {
> >> >         struct bt_ad *data;
> >> >         struct bt_ad *scan;
> >> >         uint8_t instance;
> >> > +       uint32_t min_interval;
> >> > +       uint32_t max_interval;
> >> > +       int8_t tx_power;
> >> >  };
> >> >
> >> >  struct dbus_obj_match {
> >> > @@ -946,6 +954,74 @@ static bool parse_secondary(DBusMessageIter *iter,
> >> >         return false;
> >> >  }
> >> >
> >> > +static bool parse_min_interval(DBusMessageIter *iter,
> >> > +                                       struct btd_adv_client *client)
> >> > +{
> >> > +       if (!iter)
> >> > +               return false;
> >> > +
> >> > +       if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT32)
> >> > +               return false;
> >> > +
> >> > +       dbus_message_iter_get_basic(iter, &client->min_interval);
> >> > +
> >> > +       /* BLUETOOTH SPECIFICATION Version 5.2 | Vol 4, Part E, page 2584
> >> > +        * defines acceptable interval range
> >> > +        */
> >> > +       if (client->min_interval < 0x20 || client->min_interval > 0xFFFFFF) {
> >> > +               client->min_interval = 0;
> >> > +               return false;
> >> > +       }
> >> > +
> >> > +       return true;
> >> > +}
> >> > +
> >> > +static bool parse_max_interval(DBusMessageIter *iter,
> >> > +                                       struct btd_adv_client *client)
> >> > +{
> >> > +       if (!iter)
> >> > +               return false;
> >> > +
> >> > +       if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT32)
> >> > +               return false;
> >> > +
> >> > +       dbus_message_iter_get_basic(iter, &client->max_interval);
> >> > +
> >> > +       /* BLUETOOTH SPECIFICATION Version 5.2 | Vol 4, Part E, page 2584
> >> > +        * defines acceptable interval range
> >> > +        */
> >> > +       if (client->max_interval < 0x20 || client->max_interval > 0xFFFFFF) {
> >> > +               client->max_interval = 0;
> >> > +               return false;
> >> > +       }
> >> > +
> >> > +       return true;
> >> > +}
> >> > +
> >> > +static bool parse_tx_power(DBusMessageIter *iter,
> >> > +                                       struct btd_adv_client *client)
> >> > +{
> >> > +       int16_t val;
> >> > +
> >> > +       if (!iter)
> >> > +               return false;
> >> > +
> >> > +       if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_INT16)
> >> > +               return false;
> >> > +
> >> > +       dbus_message_iter_get_basic(iter, &val);
> >> > +
> >> > +       /* BLUETOOTH SPECIFICATION Version 5.2 | Vol 4, Part E, page 2585
> >> > +        * defines acceptable tx power range
> >> > +        */
> >> > +       if (val < -127 || val > 20)
> >> > +               return false;
> >> > +
> >> > +       client->tx_power = val;
> >> > +
> >> > +       return true;
> >> > +}
> >> > +
> >> >  static struct adv_parser {
> >> >         const char *name;
> >> >         bool (*func)(DBusMessageIter *iter, struct btd_adv_client *client);
> >> > @@ -964,6 +1040,9 @@ static struct adv_parser {
> >> >         { "Discoverable", parse_discoverable },
> >> >         { "DiscoverableTimeout", parse_discoverable_timeout },
> >> >         { "SecondaryChannel", parse_secondary },
> >> > +       { "MinInterval", parse_min_interval },
> >> > +       { "MaxInterval", parse_max_interval },
> >>
> >> We will need to these to the D-Bus documentation if you want to extend it.
> >>
> >> > +       { "TxPower", parse_tx_power },
> >>
> >> TxPower is already part of the include, or you want the ability to set
> >> an arbitrary TxPower?
> >>
> >> >         { },
> >> >  };
> >> >
> >> > @@ -1092,6 +1171,13 @@ static DBusMessage *parse_advertisement(struct btd_adv_client *client)
> >> >                 goto fail;
> >> >         }
> >> >
> >> > +       if (client->min_interval > client->max_interval) {
> >> > +               /* Min interval must not be bigger than max interval */
> >> > +               error("MinInterval must be less than MaxInterval (%lu > %lu)",
> >> > +                               client->min_interval, client->max_interval);
> >> > +               goto fail;
> >> > +       }
> >> > +
> >> >         err = refresh_adv(client, add_adv_callback, &client->add_adv_id);
> >> >         if (!err)
> >> >                 return NULL;
> >> > @@ -1167,6 +1253,9 @@ static struct btd_adv_client *client_create(struct btd_adv_manager *manager,
> >> >
> >> >         client->manager = manager;
> >> >         client->appearance = UINT16_MAX;
> >> > +       client->tx_power = ADV_TX_POWER_NO_PREFERENCE;
> >> > +       client->min_interval = 0;
> >> > +       client->max_interval = 0;
> >> >
> >> >         return client;
> >> >
> >> > --
> >> > 2.28.0.618.gf4bc123cb7-goog
> >> >
> >>
> >>
> >> --
> >> Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
