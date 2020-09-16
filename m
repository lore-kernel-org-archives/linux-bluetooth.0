Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED11DC433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 00:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 957CE221EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 00:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/Nxv048"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgIQASD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Sep 2020 20:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgIQASA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Sep 2020 20:18:00 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C7DC06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 16:58:45 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id y5so251713otg.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 16:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=05klGwQ04S9Ub6h6w3OPrfzCfcZrDDETUet72RYGoyw=;
        b=L/Nxv048HAY469MlzTttW9CqOASARqZovgQ6rwZtluvoWmBGsHaqDvVJqoggINm27c
         9ODVZcxuy+W5VSuB3gNcb4EcdfHNDlwTPOLS1CnypH7CFSArMlbbeUJ8xKS7SZ5SNd8L
         ceL0HUrmIN/Br6NXC16TSp0xmN8amIDs75bovRKARZ2pXDmpVkbpEHPyas1G2QsVVPEj
         gB/Ez8xGRy2mTbTwssxS1yrfeTrHYz7VGAphhfefSXkWgjAEEVK/fXCrKQXWJbo/UuEW
         7mcRfmkGmLGA93Bo000VSeQ+AwEQjqtAckQW1cJcIfTWsarv6uD4k97W3++6SlHmJoqz
         aNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=05klGwQ04S9Ub6h6w3OPrfzCfcZrDDETUet72RYGoyw=;
        b=Z5XAqiQtEIGoc5AswZ9EuzSnxVhx1sIzJ77sBpEbQXy7hBV1ds7hlknkYkEdBZWIf0
         QeYJTYQNDpKHDzgx+jIO2dfNhon5ZnhCJeELqtAcXcJ7RUxZcYl8FYzTL/KwXAsHEn10
         CDBMA18v2AE/oejPQtgX2nzy7pVF9oXQwtLHVVIszoKuzwOGHz7HPZSjkWCQIC2K4YcZ
         vFb0Cfb8/xAgeBGLQ46n8LjvUoScf3IdnUNH7cqr1yW3yev4WmnQq4zhvvRsoXiNvXNn
         1apPJt6U81EDnRcj/4QAFAyxIyellcyp2RF6VPpNZjwNOnZjgsqdzadVxnluovi8iK6o
         64pQ==
X-Gm-Message-State: AOAM533v0dlQ9F+0oxub2KCg8oBfibzAS8tcw1r0xTAG1ydVWCexAhg9
        BCpbjtcy0Q2hY443IYh9p3RnTjQ6H2ZqwGLqOow=
X-Google-Smtp-Source: ABdhPJwBoXmqu7ntFh7CLZOAMzGju32Zjzriv5XpESD+4fNNgymN+8LX4N/WqZD4Ujg6OAzTHismZjpTJ9ja6ZcI+P0=
X-Received: by 2002:a9d:5a8:: with SMTP id 37mr9787445otd.362.1600300724504;
 Wed, 16 Sep 2020 16:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200916232542.1584854-1-danielwinkler@google.com>
 <20200916162155.Bluez.2.Ic4a3667da774f5f34477d5168a68a9280657e2da@changeid>
 <CABBYNZ+5DW4eM_r0xZKRuWGbbA-y64VYnGiFTBo7hu4E7G-qZw@mail.gmail.com> <CAP2xMbsSXX6VVuJTKeqkmgV-AJMdfku3LB7n4yrMdo+2yJk7HQ@mail.gmail.com>
In-Reply-To: <CAP2xMbsSXX6VVuJTKeqkmgV-AJMdfku3LB7n4yrMdo+2yJk7HQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 16 Sep 2020 16:58:33 -0700
Message-ID: <CABBYNZ+Tb+pxae+6puQ=NwZD3mSdDxXZBucAwmyMNOJxX++Wrw@mail.gmail.com>
Subject: Re: [Bluez PATCH 02/10] advertising: Parse intervals and tx power
 from adv
To:     Daniel Winkler <danielwinkler@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Daniel,

On Wed, Sep 16, 2020 at 4:53 PM Daniel Winkler <danielwinkler@google.com> wrote:
>
> Hello Luiz,
>
> The patch allows the client to set an arbitrary TxPower, different from the include property.

Does the controller honor this setting? Can we really set a TxPower
per instance? If it doesn't then this can possibly break proximity
logic on the scanner side.

> Best,
> Daniel
>
> On Wed, Sep 16, 2020 at 4:52 PM Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>>
>> Hi Daniel,
>>
>> On Wed, Sep 16, 2020 at 4:25 PM Daniel Winkler <danielwinkler@google.com> wrote:
>> >
>> > This change adds parsers for the advertising intervals and tx power
>> > properties of the LEAdvertisement1 object. It validates that each field
>> > adheres to the 5.2 spec, and that min and max intervals are compatible
>> > with each other, i.e. that min interval is less than max interval.
>> >
>> > A note here for maintainers: The tx power that is sent in the hci
>> > parameter command is an int8_t, but as far as I can tell, there is no
>> > clean way to use a signed 8-bit integer in dbus. The dbus byte type
>> > seems incompatible with negative values in high-level languages (python)
>> > without awkward usage manipulation on the client side. For this reason,
>> > I chose to use an int16_t type for the tx power dbus field, which is
>> > then downcasted to the int8_t in bluetoothd, which at least makes the
>> > signed-ness of the type crystal clear to the dbus client that uses it.
>> >
>> > This change is manually verified by ensuring the intervals and tx power
>> > parameters are correctly parsed from the LEAdvertisement1 object, and
>> > that the parse fails if the parameters are incorrect or not compatible
>> > with each other.
>> >
>> > Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
>> > ---
>> >
>> >  src/advertising.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++
>> >  1 file changed, 89 insertions(+)
>> >
>> > diff --git a/src/advertising.c b/src/advertising.c
>> > index 172a83907..82ee87313 100644
>> > --- a/src/advertising.c
>> > +++ b/src/advertising.c
>> > @@ -63,6 +63,11 @@ struct btd_adv_manager {
>> >  #define AD_TYPE_BROADCAST 0
>> >  #define AD_TYPE_PERIPHERAL 1
>> >
>> > +/* BLUETOOTH SPECIFICATION Version 5.2 | Vol 4, Part E, page 2585
>> > + * defines tx power value indicating no preference
>> > + */
>> > +#define ADV_TX_POWER_NO_PREFERENCE 0x7F
>> > +
>> >  struct btd_adv_client {
>> >         struct btd_adv_manager *manager;
>> >         char *owner;
>> > @@ -83,6 +88,9 @@ struct btd_adv_client {
>> >         struct bt_ad *data;
>> >         struct bt_ad *scan;
>> >         uint8_t instance;
>> > +       uint32_t min_interval;
>> > +       uint32_t max_interval;
>> > +       int8_t tx_power;
>> >  };
>> >
>> >  struct dbus_obj_match {
>> > @@ -946,6 +954,74 @@ static bool parse_secondary(DBusMessageIter *iter,
>> >         return false;
>> >  }
>> >
>> > +static bool parse_min_interval(DBusMessageIter *iter,
>> > +                                       struct btd_adv_client *client)
>> > +{
>> > +       if (!iter)
>> > +               return false;
>> > +
>> > +       if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT32)
>> > +               return false;
>> > +
>> > +       dbus_message_iter_get_basic(iter, &client->min_interval);
>> > +
>> > +       /* BLUETOOTH SPECIFICATION Version 5.2 | Vol 4, Part E, page 2584
>> > +        * defines acceptable interval range
>> > +        */
>> > +       if (client->min_interval < 0x20 || client->min_interval > 0xFFFFFF) {
>> > +               client->min_interval = 0;
>> > +               return false;
>> > +       }
>> > +
>> > +       return true;
>> > +}
>> > +
>> > +static bool parse_max_interval(DBusMessageIter *iter,
>> > +                                       struct btd_adv_client *client)
>> > +{
>> > +       if (!iter)
>> > +               return false;
>> > +
>> > +       if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT32)
>> > +               return false;
>> > +
>> > +       dbus_message_iter_get_basic(iter, &client->max_interval);
>> > +
>> > +       /* BLUETOOTH SPECIFICATION Version 5.2 | Vol 4, Part E, page 2584
>> > +        * defines acceptable interval range
>> > +        */
>> > +       if (client->max_interval < 0x20 || client->max_interval > 0xFFFFFF) {
>> > +               client->max_interval = 0;
>> > +               return false;
>> > +       }
>> > +
>> > +       return true;
>> > +}
>> > +
>> > +static bool parse_tx_power(DBusMessageIter *iter,
>> > +                                       struct btd_adv_client *client)
>> > +{
>> > +       int16_t val;
>> > +
>> > +       if (!iter)
>> > +               return false;
>> > +
>> > +       if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_INT16)
>> > +               return false;
>> > +
>> > +       dbus_message_iter_get_basic(iter, &val);
>> > +
>> > +       /* BLUETOOTH SPECIFICATION Version 5.2 | Vol 4, Part E, page 2585
>> > +        * defines acceptable tx power range
>> > +        */
>> > +       if (val < -127 || val > 20)
>> > +               return false;
>> > +
>> > +       client->tx_power = val;
>> > +
>> > +       return true;
>> > +}
>> > +
>> >  static struct adv_parser {
>> >         const char *name;
>> >         bool (*func)(DBusMessageIter *iter, struct btd_adv_client *client);
>> > @@ -964,6 +1040,9 @@ static struct adv_parser {
>> >         { "Discoverable", parse_discoverable },
>> >         { "DiscoverableTimeout", parse_discoverable_timeout },
>> >         { "SecondaryChannel", parse_secondary },
>> > +       { "MinInterval", parse_min_interval },
>> > +       { "MaxInterval", parse_max_interval },
>>
>> We will need to these to the D-Bus documentation if you want to extend it.
>>
>> > +       { "TxPower", parse_tx_power },
>>
>> TxPower is already part of the include, or you want the ability to set
>> an arbitrary TxPower?
>>
>> >         { },
>> >  };
>> >
>> > @@ -1092,6 +1171,13 @@ static DBusMessage *parse_advertisement(struct btd_adv_client *client)
>> >                 goto fail;
>> >         }
>> >
>> > +       if (client->min_interval > client->max_interval) {
>> > +               /* Min interval must not be bigger than max interval */
>> > +               error("MinInterval must be less than MaxInterval (%lu > %lu)",
>> > +                               client->min_interval, client->max_interval);
>> > +               goto fail;
>> > +       }
>> > +
>> >         err = refresh_adv(client, add_adv_callback, &client->add_adv_id);
>> >         if (!err)
>> >                 return NULL;
>> > @@ -1167,6 +1253,9 @@ static struct btd_adv_client *client_create(struct btd_adv_manager *manager,
>> >
>> >         client->manager = manager;
>> >         client->appearance = UINT16_MAX;
>> > +       client->tx_power = ADV_TX_POWER_NO_PREFERENCE;
>> > +       client->min_interval = 0;
>> > +       client->max_interval = 0;
>> >
>> >         return client;
>> >
>> > --
>> > 2.28.0.618.gf4bc123cb7-goog
>> >
>>
>>
>> --
>> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
