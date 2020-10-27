Return-Path: <SRS0=ORc3=EC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7056C4363A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Oct 2020 22:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60E83221FB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Oct 2020 22:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsAr9vf3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760108AbgJ0WDP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Oct 2020 18:03:15 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42425 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756627AbgJ0WDO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Oct 2020 18:03:14 -0400
Received: by mail-oi1-f194.google.com with SMTP id c72so2910284oig.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2020 15:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qdTqHYuL62CeJ4c8eXBwKMcV+0FLgQ1L9r48F59GFLI=;
        b=PsAr9vf3R9hvCkXILo6uNRjrrNU+KhEqkQQH2bxZsfxAfQAs8/FyH/pcXM48zc+gSz
         2hM803TtjBUVc4BMe80iTHTFiOu4yyNeBxNJ4A94iJj7+1VxfxUkHiRVtVrtH/uzY7CM
         acNDLpeN+zKPjRVTTd4vWfqDsAMpSFAjG3tSr3ulxhC5Nz51jk7ghyxgfKQm0JUagl/m
         VxosG9NLOiB8LnbB69UZtGIkSBoqdEdrK602qVWjZxj59EDM/OChebNx9CjefoAmmOgg
         tqHURD9+d8SeIwsbsTdAjzJNOAZcCNRDKVfkujaV+3/VQzRdTCULVTrjFUsETegK/dXI
         zJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qdTqHYuL62CeJ4c8eXBwKMcV+0FLgQ1L9r48F59GFLI=;
        b=ZufTz5D5cfoZb3htUAJD/EQRTQWXTgrdk6j/pfyHQ3IdN4Qklmo+hw9JDmeiRPT2po
         v1d5EWndl4AJ0MlQG6gY2v0KdCS1abvqBVqwaBenvEnhZoes/QUwAEJcZvUKxBSHjojV
         FXkjOl3QXlE9IX/PSMB2+c/oMrSYmmiJ2rP//D+CW1VS0eJeetKH6asQDlYyYoI1GLX/
         i5X/ZDttLEz3xKx9hMw6V0LZkkM3Ot5br8NYK7OX70vazFnXGsh0j3JIOR2GPXCUlc9V
         7so2GhlJuh1/HgdDwULPLFfKLaSKT7uHLrAbm0suIPll454uPeqmCZccfLzLzi5RgXRD
         xVTw==
X-Gm-Message-State: AOAM530ejcN4srmgvFL8WJgdkakI+xfP5PYnKL8Iq90iJaBlL4nNvbSH
        0EU2E0Zrfx3bv8r9T3ZVRGwXjfpA7vdhE4Y+IDM=
X-Google-Smtp-Source: ABdhPJxkrXx8g8V5pCxW8OepEQWWgwIVUbYYnGYU+qBJeVm1k4kwL+zk04il8ezS8+JnX3Gau3f+aJIi2K+dV7D6xgY=
X-Received: by 2002:aca:4ac6:: with SMTP id x189mr2406244oia.58.1603836192906;
 Tue, 27 Oct 2020 15:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20201001230152.2422908-1-danielwinkler@google.com> <20201001155738.Bluez.v4.5.Ic4a3667da774f5f34477d5168a68a9280657e2da@changeid>
In-Reply-To: <20201001155738.Bluez.v4.5.Ic4a3667da774f5f34477d5168a68a9280657e2da@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 27 Oct 2020 15:03:01 -0700
Message-ID: <CABBYNZJD1bvcN-bWJaA5Q7u0py_-8DLzpoTJovSctuWQh8KcUA@mail.gmail.com>
Subject: Re: [Bluez PATCH v4 05/10] advertising: Parse intervals and tx power
 from adv
To:     Daniel Winkler <danielwinkler@google.com>
Cc:     Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Daniel,

On Thu, Oct 1, 2020 at 4:05 PM Daniel Winkler <danielwinkler@google.com> wrote:
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
> Reviewed-by: Alain Michaud <alainm@chromium.org>
> ---
>
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
>
>  src/advertising.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
>
> diff --git a/src/advertising.c b/src/advertising.c
> index 7c7599552..3690a2aac 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -54,6 +54,11 @@ struct btd_adv_manager {
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
> @@ -74,6 +79,9 @@ struct btd_adv_client {
>         struct bt_ad *data;
>         struct bt_ad *scan;
>         uint8_t instance;
> +       uint32_t min_interval;
> +       uint32_t max_interval;
> +       int8_t tx_power;
>  };
>
>  struct dbus_obj_match {
> @@ -937,6 +945,74 @@ static bool parse_secondary(DBusMessageIter *iter,
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
> @@ -955,6 +1031,9 @@ static struct adv_parser {
>         { "Discoverable", parse_discoverable },
>         { "DiscoverableTimeout", parse_discoverable_timeout },
>         { "SecondaryChannel", parse_secondary },
> +       { "MinInterval", parse_min_interval },
> +       { "MaxInterval", parse_max_interval },
> +       { "TxPower", parse_tx_power },
>         { },
>  };
>
> @@ -1083,6 +1162,13 @@ static DBusMessage *parse_advertisement(struct btd_adv_client *client)
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
> @@ -1158,6 +1244,9 @@ static struct btd_adv_client *client_create(struct btd_adv_manager *manager,
>
>         client->manager = manager;
>         client->appearance = UINT16_MAX;
> +       client->tx_power = ADV_TX_POWER_NO_PREFERENCE;
> +       client->min_interval = 0;
> +       client->max_interval = 0;

Lets only parse these if experimental is enabled.

>         return client;
>
> --
> 2.28.0.709.gb0816b6eb0-goog
>


-- 
Luiz Augusto von Dentz
