Return-Path: <SRS0=ORc3=EC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D382DC4363A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Oct 2020 22:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DCBA20878
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Oct 2020 22:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npAO/YNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503678AbgJ0WFZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Oct 2020 18:05:25 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36274 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505592AbgJ0WFY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Oct 2020 18:05:24 -0400
Received: by mail-ot1-f67.google.com with SMTP id 32so2552740otm.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2020 15:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YH9eYeQk8+euv6FvSxItvZqW2L04axxJ5k/eDw4EpRo=;
        b=npAO/YNL/ikVy6h081iK2OZI4LvM14d04OdcrnIjtzcDMBNCkLftpxmHJ0Ez+I+6Q7
         2mCsniwsit0tpJqZibJH6oaiZYAKVyylznFDBeHh8DnPti21as9WF/z1ibnkspdlbgqS
         Ot42VYURRDTiltwH8RHd23LjTFthpX6Kih4CJ/HXgttUJc4HTvndpJLpMuq2x92Ubdqx
         S9x/WVUjPLAVYNoL43MhZuoFkzeltTnMaqNVtJ5jGV0GqKlkfjVW+5t85mh/ypkpIrds
         y/aKMJ3FcnurLpef7Zjp5KmqXXCH4nvbNOjo6sLGH1KgiStddfqp2UJ8l/XTlusXOv6t
         IF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YH9eYeQk8+euv6FvSxItvZqW2L04axxJ5k/eDw4EpRo=;
        b=nuiwU6K8E+hSg5PfoZatmEjFnJuNct6PB0nADdvN48R3lLwnQINQ+w9T6JRwrNzj5b
         9a2Ze9aiyOR8BIhGS7bFFmn/NMLc9J4ZEM1JlIKm9lpPfVyqGLFUTm5TMoJOJLXwokr5
         Rbc+lvuWCfGvF3d/DAHZgKlc4b+ZlZj6LFZViNbkxdRg+xs7i8JcgjX0gHf0U3BLOOlx
         78Z1bqC8I8I/VswPp28LkrESLR7vpselr4GVSu2Eb7Yul9QQkDAHj7xXHQF1V4YZDpc7
         aE6KCmuAde6AwUiX06H/1U318r0fBKg1Si2mhFkaFA/nVThlvkF221z19kW/yT7rVxCO
         lw1Q==
X-Gm-Message-State: AOAM5317taGvJddIN5K61suMHVd7nNmw0/iOWMN1ZhPZpHXwyeHfMuWh
        V8i1TIk/9USQa0/B6BzngjBXGvOHiTNE+QUwLDg=
X-Google-Smtp-Source: ABdhPJwurChEiZPKNnG4eRmSg7syZH7OWIk1MQW9PYdpPcHG0D8oof2uOMwo+Ok/9bJ9w4uk1xeaH7w7WBYthO3loh8=
X-Received: by 2002:a05:6830:134c:: with SMTP id r12mr2916355otq.240.1603836323702;
 Tue, 27 Oct 2020 15:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <20201001230152.2422908-1-danielwinkler@google.com> <20201001155738.Bluez.v4.8.I4e536cf2c9b6c5571b4b3800dfb8338fce8e4421@changeid>
In-Reply-To: <20201001155738.Bluez.v4.8.I4e536cf2c9b6c5571b4b3800dfb8338fce8e4421@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 27 Oct 2020 15:05:12 -0700
Message-ID: <CABBYNZ+OdP5dyG8BsEZNu5_6oiOoeF=piSXNnyzfv+6uO0QjiQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v4 08/10] advertising: Expose SupportedCapabilities
 for advertising
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

On Thu, Oct 1, 2020 at 4:07 PM Daniel Winkler <danielwinkler@google.com> wrote:
>
> To help our advertising clients understand the device capabilities, this
> patch adds a SupportedCapabilities dbus endpoint for the advertising
> manager. The primary reason behind this is to provide the valid LE tx
> power range the controller supports (populated if controller supports
> BT5), so a client can know the valid power range before requesting a tx
> power for their advertisement.
>
> I also thought it would be useful to indicate the max advertising data
> length and scan response length in this endpoint, since some clients
> will find it useful to set their advertising data (currently
> experimental feature) or scan response data (possible future feature)
> directly.
>
> This patch has been tested on Hatch (BT5 support) and Kukui (No BT5
> support) chromebooks to verify that the dbus endpoint contains the
> correct data.
>
> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> Reviewed-by: Alain Michaud <alainm@chromium.org>
> ---
>
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
>
>  src/advertising.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/src/advertising.c b/src/advertising.c
> index 41d0658c8..f76831594 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -1619,12 +1619,46 @@ static gboolean get_supported_secondary(const GDBusPropertyTable *property,
>         return TRUE;
>  }
>
> +static gboolean get_supported_cap(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data)
> +{
> +       struct btd_adv_manager *manager = data;
> +       DBusMessageIter dict;
> +       int16_t min_tx_power = manager->min_tx_power;
> +       int16_t max_tx_power = manager->max_tx_power;
> +
> +       dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
> +                                       DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
> +                                       DBUS_TYPE_STRING_AS_STRING
> +                                       DBUS_TYPE_VARIANT_AS_STRING
> +                                       DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
> +                                       &dict);
> +
> +       if (min_tx_power != ADV_TX_POWER_NO_PREFERENCE)
> +               dict_append_entry(&dict, "MinTxPower", DBUS_TYPE_INT16,
> +                               &min_tx_power);
> +
> +       if (max_tx_power != ADV_TX_POWER_NO_PREFERENCE)
> +               dict_append_entry(&dict, "MaxTxPower", DBUS_TYPE_INT16,
> +                               &max_tx_power);
> +
> +       dict_append_entry(&dict, "MaxAdvLen", DBUS_TYPE_BYTE,
> +                       &manager->max_adv_len);
> +       dict_append_entry(&dict, "MaxScnRspLen", DBUS_TYPE_BYTE,
> +                       &manager->max_scan_rsp_len);
> +
> +       dbus_message_iter_close_container(iter, &dict);
> +
> +       return TRUE;
> +}
> +
>  static const GDBusPropertyTable properties[] = {
>         { "ActiveInstances", "y", get_active_instances, NULL, NULL },
>         { "SupportedInstances", "y", get_instances, NULL, NULL },
>         { "SupportedIncludes", "as", get_supported_includes, NULL, NULL },
>         { "SupportedSecondaryChannels", "as", get_supported_secondary, NULL,
>                                                         secondary_exits },
> +       { "SupportedCapabilities", "a{sv}", get_supported_cap, NULL, NULL},

Lets mark this as experimental for now.

>         { }
>  };
>
> --
> 2.28.0.709.gb0816b6eb0-goog
>


-- 
Luiz Augusto von Dentz
