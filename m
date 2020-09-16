Return-Path: <SRS0=qc6f=CZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3226C43461
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 23:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9C7722209
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 23:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/o6z4/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgIPXwI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Sep 2020 19:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgIPXwH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Sep 2020 19:52:07 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A03C06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 16:52:06 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id o8so246098otl.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 16:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/dOZpGAyEkhicuzwk7bQFgubOIonm4Qkms9cAEQj4YY=;
        b=N/o6z4/6inucRGhe9Hqkcudxl8FCtleWrI46/Bjdh8BMUDNGA7oe0CCqSrZ4XKSLhs
         Rs//ZXdW+9jeXNf/KQ42qYqCUdXYm7kUj8ufrl4uJJBKIQlXBKg9CnazKROH1tDMpdg4
         W1bthPOSuItMXygpYJfrbAH/wfggSMuh19UuFTfiLsNfRv9c3Etapm6Gq9I9U13AyhwB
         wUjVy4cbqFMaKGDJoWgExTaTBppmNWtcg/hee07xzaY4eWYr4OI8PqtJavKKl7oKGNyX
         8Dz0wCV+KZHM7VEWjAiSc7eJIdJdoTTLJ2qmErmnyieAjtzQZObfq4L5kVIB2EKpzKag
         h8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/dOZpGAyEkhicuzwk7bQFgubOIonm4Qkms9cAEQj4YY=;
        b=m+FFNpNJcwyKZLjgaxGtpjt61eRXRukf8LvscnqJMO4zlNhqpAYuAx4olQnQkOPwAx
         ejw+tSJagpEzeMhCL/WwSij/x3AsxYjwo6VYlGDYwrzjTXz0eS2QkgFlRuF7IWqwRmE0
         0aXLZL5sETs7EXpnsfuFDgSQCbEglSW8jcbYfXsNOVGVEQfQfpkAFfauDNQIQaVOfNen
         jep5lnLKbSDPX+8cxE80eDrXr6tCxFjyGVy8R9L3SVBtfjDvEvmzqj95yyMbN2rnZBa5
         xMy2IYyakfnpTWqE3bf9JL6pzlJiAq2eNZrZ2OTvvWZAQNhaO9qAo0HVTRc/ad7I6wT9
         JGkQ==
X-Gm-Message-State: AOAM5320eprRWuq6KXMw8+8tPhbrahwFCKbnaEKRdTUDzPdEV1x4jgav
        PuW1Ov9HEELXBXdpNlx9HrDFeVqMYfHcbDYrhruAS4j8
X-Google-Smtp-Source: ABdhPJwLxySAPFJEvZo0fmcsNHkbVjw3b8LoYK3Vj0Q86FOLAt58XdfWy0wGAa85kmuZ2v8QqRB3MwQYhLqmhy/wWSU=
X-Received: by 2002:a9d:5a8:: with SMTP id 37mr9775720otd.362.1600300325719;
 Wed, 16 Sep 2020 16:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200916232542.1584854-1-danielwinkler@google.com> <20200916162155.Bluez.2.Ic4a3667da774f5f34477d5168a68a9280657e2da@changeid>
In-Reply-To: <20200916162155.Bluez.2.Ic4a3667da774f5f34477d5168a68a9280657e2da@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 16 Sep 2020 16:51:54 -0700
Message-ID: <CABBYNZ+5DW4eM_r0xZKRuWGbbA-y64VYnGiFTBo7hu4E7G-qZw@mail.gmail.com>
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

On Wed, Sep 16, 2020 at 4:25 PM Daniel Winkler <danielwinkler@google.com> wrote:
>
> This change adds parsers for the advertising intervals and tx power
> properties of the LEAdvertisement1 object. It validates that each field
> adheres to the 5.2 spec, and that min and max intervals are compatible
> with each other, i.e. that min interval is less than max interval.
>
> A note here for maintainers: The tx power that is sent in the hci
> parameter command is an int8_t, but as far as I can tell, there is no
> clean way to use a signed 8-bit integer in dbus. The dbus byte type
> seems incompatible with negative values in high-level languages (python)
> without awkward usage manipulation on the client side. For this reason,
> I chose to use an int16_t type for the tx power dbus field, which is
> then downcasted to the int8_t in bluetoothd, which at least makes the
> signed-ness of the type crystal clear to the dbus client that uses it.
>
> This change is manually verified by ensuring the intervals and tx power
> parameters are correctly parsed from the LEAdvertisement1 object, and
> that the parse fails if the parameters are incorrect or not compatible
> with each other.
>
> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> ---
>
>  src/advertising.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
>
> diff --git a/src/advertising.c b/src/advertising.c
> index 172a83907..82ee87313 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -63,6 +63,11 @@ struct btd_adv_manager {
>  #define AD_TYPE_BROADCAST 0
>  #define AD_TYPE_PERIPHERAL 1
>
> +/* BLUETOOTH SPECIFICATION Version 5.2 | Vol 4, Part E, page 2585
> + * defines tx power value indicating no preference
> + */
> +#define ADV_TX_POWER_NO_PREFERENCE 0x7F
> +
>  struct btd_adv_client {
>         struct btd_adv_manager *manager;
>         char *owner;
> @@ -83,6 +88,9 @@ struct btd_adv_client {
>         struct bt_ad *data;
>         struct bt_ad *scan;
>         uint8_t instance;
> +       uint32_t min_interval;
> +       uint32_t max_interval;
> +       int8_t tx_power;
>  };
>
>  struct dbus_obj_match {
> @@ -946,6 +954,74 @@ static bool parse_secondary(DBusMessageIter *iter,
>         return false;
>  }
>
> +static bool parse_min_interval(DBusMessageIter *iter,
> +                                       struct btd_adv_client *client)
> +{
> +       if (!iter)
> +               return false;
> +
> +       if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT32)
> +               return false;
> +
> +       dbus_message_iter_get_basic(iter, &client->min_interval);
> +
> +       /* BLUETOOTH SPECIFICATION Version 5.2 | Vol 4, Part E, page 2584
> +        * defines acceptable interval range
> +        */
> +       if (client->min_interval < 0x20 || client->min_interval > 0xFFFFFF) {
> +               client->min_interval = 0;
> +               return false;
> +       }
> +
> +       return true;
> +}
> +
> +static bool parse_max_interval(DBusMessageIter *iter,
> +                                       struct btd_adv_client *client)
> +{
> +       if (!iter)
> +               return false;
> +
> +       if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT32)
> +               return false;
> +
> +       dbus_message_iter_get_basic(iter, &client->max_interval);
> +
> +       /* BLUETOOTH SPECIFICATION Version 5.2 | Vol 4, Part E, page 2584
> +        * defines acceptable interval range
> +        */
> +       if (client->max_interval < 0x20 || client->max_interval > 0xFFFFFF) {
> +               client->max_interval = 0;
> +               return false;
> +       }
> +
> +       return true;
> +}
> +
> +static bool parse_tx_power(DBusMessageIter *iter,
> +                                       struct btd_adv_client *client)
> +{
> +       int16_t val;
> +
> +       if (!iter)
> +               return false;
> +
> +       if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_INT16)
> +               return false;
> +
> +       dbus_message_iter_get_basic(iter, &val);
> +
> +       /* BLUETOOTH SPECIFICATION Version 5.2 | Vol 4, Part E, page 2585
> +        * defines acceptable tx power range
> +        */
> +       if (val < -127 || val > 20)
> +               return false;
> +
> +       client->tx_power = val;
> +
> +       return true;
> +}
> +
>  static struct adv_parser {
>         const char *name;
>         bool (*func)(DBusMessageIter *iter, struct btd_adv_client *client);
> @@ -964,6 +1040,9 @@ static struct adv_parser {
>         { "Discoverable", parse_discoverable },
>         { "DiscoverableTimeout", parse_discoverable_timeout },
>         { "SecondaryChannel", parse_secondary },
> +       { "MinInterval", parse_min_interval },
> +       { "MaxInterval", parse_max_interval },

We will need to these to the D-Bus documentation if you want to extend it.

> +       { "TxPower", parse_tx_power },

TxPower is already part of the include, or you want the ability to set
an arbitrary TxPower?

>         { },
>  };
>
> @@ -1092,6 +1171,13 @@ static DBusMessage *parse_advertisement(struct btd_adv_client *client)
>                 goto fail;
>         }
>
> +       if (client->min_interval > client->max_interval) {
> +               /* Min interval must not be bigger than max interval */
> +               error("MinInterval must be less than MaxInterval (%lu > %lu)",
> +                               client->min_interval, client->max_interval);
> +               goto fail;
> +       }
> +
>         err = refresh_adv(client, add_adv_callback, &client->add_adv_id);
>         if (!err)
>                 return NULL;
> @@ -1167,6 +1253,9 @@ static struct btd_adv_client *client_create(struct btd_adv_manager *manager,
>
>         client->manager = manager;
>         client->appearance = UINT16_MAX;
> +       client->tx_power = ADV_TX_POWER_NO_PREFERENCE;
> +       client->min_interval = 0;
> +       client->max_interval = 0;
>
>         return client;
>
> --
> 2.28.0.618.gf4bc123cb7-goog
>


-- 
Luiz Augusto von Dentz
