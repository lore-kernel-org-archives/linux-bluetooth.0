Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21FAECAAA3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Aug 2022 18:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244631AbiHZS4D (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Aug 2022 14:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345448AbiHZSzi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Aug 2022 14:55:38 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52588EF03B
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 11:51:14 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q18so2391802ljg.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 11:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=yVWQeHkZxeQVdvfnU1zvK0OQ9CQcHT5VgGiu1G+ynGM=;
        b=ovlpJESf/h0pciyih4OoqXK8DZBywSB+AK54y2o32OXtPOjqh8YoUJep+BVvFCe7Z+
         cvq1++/6321AUcrVKzNpE9L3IBbpDTsf2eMpWSZopTtXcbFnKMxFgqy1BLNOdSTKQ0xN
         B9mjVf7eRus3YM0rLFAPOlDupZIfwaterd6hWlecQo5eLeVNyAEOwMV78GhFSMiRzg+D
         43aQpLdaqscBU7BEK7WkpBQRdhDmlMMvnAzp0yvUj0QCdTs3fIUQPLHMNkOsESsjLH+y
         3z/fyFbiaTkLhmRC7iK5Wvfl27h39rUbQ6Vl3umppdTYt4oPil2gUuwRMI7pSl/8sbtF
         BuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=yVWQeHkZxeQVdvfnU1zvK0OQ9CQcHT5VgGiu1G+ynGM=;
        b=hm8iM9uLTs7Kba0weCHEgTl8wKg9UwLgd7WLwlxZGs0IxaL9rK0NnTxrJ/8ELB1Y9d
         X3I/puKkSvaGjHx7vWXGN3ATi6ZFEZ1OCPcoHCoZ7+5zZIDKBUXNL6OWnF2PFiwy9Mwg
         S0c/T3H+5CK0IuJT4TjXxM+rRBqeh0IiAdsw+T4gEIygKgWiY7S9qOhyWb5xgwMf5g4I
         jlzBQhB2aVhb7jmPilf+heHm5vNX6Wy1LV/aoOAUlzmBWcoclms9SFz4xoyAxOk9Zy0+
         jm+nWu/XRBVWjys1RD/EcoGW7L+awkQ1J/vMAVfn6Bmcn5TFFulVXhbKYvJ5ofSmCRaM
         AYMQ==
X-Gm-Message-State: ACgBeo2kN/C/fpK8DZp6ztpdRJDk2BSbdQmpyo77XzL5B/M9tz7UMruv
        u0r1HLiniDWZj+LrwYamCehG1d1r/Z8QkO0Q6kZLBwUp
X-Google-Smtp-Source: AA6agR54uap9gQWljJdPbZXo7KnWkhd9Y61ZyT7cDNKprmTXsuEklbMFuoOsDOMfqh9JKNr1bgptBcUrEqXQRqB0Eyg=
X-Received: by 2002:a2e:2e16:0:b0:261:cf10:3a72 with SMTP id
 u22-20020a2e2e16000000b00261cf103a72mr2849244lju.293.1661539871321; Fri, 26
 Aug 2022 11:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <db39101f70c945026e76d7b49ee358d9a2330358.camel@hadess.net>
In-Reply-To: <db39101f70c945026e76d7b49ee358d9a2330358.camel@hadess.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 26 Aug 2022 11:50:59 -0700
Message-ID: <CABBYNZL+NZ_NR8bx+CaayZis4oRywGvqYN8umqaCYEpp3uOwMw@mail.gmail.com>
Subject: Re: [PATCH] adapter: Implement PowerState property
To:     Bastien Nocera <hadess@hadess.net>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

On Thu, Aug 25, 2022 at 6:40 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> This property should allow any program to show the transitional state,
> not just the one that requested the change, and will also show
> transitional states that were the results of other system changes, like
> rfkill changes.
> ---
>
> Downstream bug in gnome-bluetooth:
> https://gitlab.gnome.org/GNOME/gnome-bluetooth/-/issues/121
>
> Note that this probably doesn't handle multiple, conflicting requests
> for power on, or power off. Is there a good way to protect against
> that?
>
>  client/main.c       |  1 +
>  doc/adapter-api.txt | 14 ++++++++++
>  src/adapter.c       | 66 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 81 insertions(+)
>
> diff --git a/client/main.c b/client/main.c
> index 19139d15b..ddd97c23c 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -981,6 +981,7 @@ static void cmd_show(int argc, char *argv[])
>         print_property(adapter->proxy, "Alias");
>         print_property(adapter->proxy, "Class");
>         print_property(adapter->proxy, "Powered");
> +       print_property(adapter->proxy, "PowerState");
>         print_property(adapter->proxy, "Discoverable");
>         print_property(adapter->proxy, "DiscoverableTimeout");
>         print_property(adapter->proxy, "Pairable");
> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> index 48466ab75..5bdb9c34e 100644
> --- a/doc/adapter-api.txt
> +++ b/doc/adapter-api.txt
> @@ -269,6 +269,20 @@ Properties string Address [readonly]
>                         restart or unplugging of the adapter it will reset
>                         back to false.
>
> +               string PowerState [readonly]
> +
> +                       The power state of an adapter.
> +
> +                       The power state will show whether the adapter is
> +                       turning off, or turning on, as well as being on
> +                       or off.
> +
> +                       Possible values:
> +                               "on" - powered on
> +                               "off" - powered off
> +                               "turning-on" - transitioning from "off" to "on"
> +                               "turning-off" - transitioning from "on" to "off"

This changes need to be split in its own patch, also not long ago I
was discussing with Marcel about MGMT power states vs rfkill, they
don't seem to be inline with each other, while rfkill does reflect on
the MGMT interface powered states doesn't which means the driver are
not aware of it since afaik the MGMT states are not communicated back
to the driver, so perhaps we should reflect this distinction on
PowerState with a dedicated state for rfkill or we start using rfkill
ourselves directly via daemon using a dedicated property.

>                 boolean Discoverable [readwrite]
>
>                         Switch an adapter to discoverable or non-discoverable
> diff --git a/src/adapter.c b/src/adapter.c
> index ec26aab1a..3b0237708 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -239,6 +239,12 @@ struct btd_adapter_pin_cb_iter {
>         /* When the iterator reaches the end, it is NULL and attempt is 0 */
>  };
>
> +enum {
> +       ADAPTER_POWER_STATE_TARGET_NONE = 0,
> +       ADAPTER_POWER_STATE_TARGET_OFF,
> +       ADAPTER_POWER_STATE_TARGET_ON
> +};
> +
>  struct btd_adapter {
>         int ref_count;
>
> @@ -252,6 +258,7 @@ struct btd_adapter {
>         char *short_name;               /* controller short name */
>         uint32_t supported_settings;    /* controller supported settings */
>         uint32_t pending_settings;      /* pending controller settings */
> +       uint32_t power_state_target;    /* the target power state */
>         uint32_t current_settings;      /* current controller settings */
>
>         char *path;                     /* adapter object path */
> @@ -579,6 +586,8 @@ static void settings_changed(struct btd_adapter *adapter, uint32_t settings)
>         if (changed_mask & MGMT_SETTING_POWERED) {
>                 g_dbus_emit_property_changed(dbus_conn, adapter->path,
>                                         ADAPTER_INTERFACE, "Powered");
> +               g_dbus_emit_property_changed(dbus_conn, adapter->path,
> +                                       ADAPTER_INTERFACE, "PowerState");
>
>                 if (adapter->current_settings & MGMT_SETTING_POWERED) {
>                         adapter_start(adapter);
> @@ -635,6 +644,11 @@ static void new_settings_callback(uint16_t index, uint16_t length,
>         if (settings == adapter->current_settings)
>                 return;
>
> +       if ((adapter->current_settings & MGMT_SETTING_POWERED) !=
> +           (settings & MGMT_SETTING_POWERED)) {
> +               adapter->power_state_target = ADAPTER_POWER_STATE_TARGET_NONE;
> +       }
> +
>         DBG("Settings: 0x%08x", settings);
>
>         settings_changed(adapter, settings);
> @@ -684,6 +698,11 @@ static bool set_mode(struct btd_adapter *adapter, uint16_t opcode,
>         switch (opcode) {
>         case MGMT_OP_SET_POWERED:
>                 setting = MGMT_SETTING_POWERED;
> +               adapter->power_state_target = mode ?
> +                       ADAPTER_POWER_STATE_TARGET_ON :
> +                       ADAPTER_POWER_STATE_TARGET_OFF;
> +               g_dbus_emit_property_changed(dbus_conn, adapter->path,
> +                                               ADAPTER_INTERFACE, "PowerState");
>                 break;
>         case MGMT_OP_SET_CONNECTABLE:
>                 setting = MGMT_SETTING_CONNECTABLE;
> @@ -708,6 +727,12 @@ static bool set_mode(struct btd_adapter *adapter, uint16_t opcode,
>                                 set_mode_complete, adapter, NULL) > 0)
>                 return true;
>
> +       if (setting == MGMT_SETTING_POWERED) {
> +               /* cancel the earlier setting */
> +               adapter->power_state_target = ADAPTER_POWER_STATE_TARGET_NONE;
> +               g_dbus_emit_property_changed(dbus_conn, adapter->path,
> +                                               ADAPTER_INTERFACE, "PowerState");
> +       }
>         btd_error(adapter->dev_id, "Failed to set mode for index %u",
>                                                         adapter->dev_id);
>
> @@ -2878,6 +2903,7 @@ static gboolean property_get_mode(struct btd_adapter *adapter,
>  struct property_set_data {
>         struct btd_adapter *adapter;
>         GDBusPendingPropertySet id;
> +       uint32_t setting;
>  };
>
>  static void property_set_mode_complete(uint8_t status, uint16_t length,
> @@ -2888,6 +2914,9 @@ static void property_set_mode_complete(uint8_t status, uint16_t length,
>
>         DBG("%s (0x%02x)", mgmt_errstr(status), status);
>
> +       if (data->setting == MGMT_SETTING_POWERED)
> +               adapter->power_state_target = ADAPTER_POWER_STATE_TARGET_NONE;
> +
>         if (status != MGMT_STATUS_SUCCESS) {
>                 const char *dbus_err;
>
> @@ -3025,6 +3054,15 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
>
>         data->adapter = adapter;
>         data->id = id;
> +       data->setting = setting;
> +
> +       if (setting == MGMT_SETTING_POWERED) {
> +               adapter->power_state_target = mode ?
> +                       ADAPTER_POWER_STATE_TARGET_ON :
> +                       ADAPTER_POWER_STATE_TARGET_OFF;
> +               g_dbus_emit_property_changed(dbus_conn, adapter->path,
> +                                               ADAPTER_INTERFACE, "PowerState");
> +       }
>
>         if (mgmt_send(adapter->mgmt, opcode, adapter->dev_id, len, param,
>                         property_set_mode_complete, data, g_free) > 0)
> @@ -3062,6 +3100,29 @@ static void property_set_powered(const GDBusPropertyTable *property,
>         property_set_mode(adapter, MGMT_SETTING_POWERED, iter, id);
>  }
>
> +static gboolean property_get_power_state(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *user_data)
> +{
> +       struct btd_adapter *adapter = user_data;
> +       const char *str;
> +
> +       if (adapter->power_state_target == ADAPTER_POWER_STATE_TARGET_NONE) {
> +               if (adapter->current_settings & MGMT_SETTING_POWERED)
> +                       str = "on";
> +               else
> +                       str = "off";
> +       } else {
> +               if (adapter->power_state_target == ADAPTER_POWER_STATE_TARGET_ON)
> +                       str = "turning-on";
> +               else
> +                       str = "turning-off";
> +       }
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &str);
> +
> +       return TRUE;
> +}
> +
>  static gboolean property_get_discoverable(const GDBusPropertyTable *property,
>                                         DBusMessageIter *iter, void *user_data)
>  {
> @@ -3700,6 +3761,7 @@ static const GDBusPropertyTable adapter_properties[] = {
>         { "Alias", "s", property_get_alias, property_set_alias },
>         { "Class", "u", property_get_class },
>         { "Powered", "b", property_get_powered, property_set_powered },
> +       { "PowerState", "s", property_get_power_state },
>         { "Discoverable", "b", property_get_discoverable,
>                                         property_set_discoverable },
>         { "DiscoverableTimeout", "u", property_get_discoverable_timeout,
> @@ -5506,6 +5568,8 @@ static void adapter_start(struct btd_adapter *adapter)
>  {
>         g_dbus_emit_property_changed(dbus_conn, adapter->path,
>                                                 ADAPTER_INTERFACE, "Powered");
> +       g_dbus_emit_property_changed(dbus_conn, adapter->path,
> +                                               ADAPTER_INTERFACE, "PowerState");
>
>         DBG("adapter %s has been enabled", adapter->path);
>
> @@ -7249,6 +7313,8 @@ static void adapter_stop(struct btd_adapter *adapter)
>
>         g_dbus_emit_property_changed(dbus_conn, adapter->path,
>                                                 ADAPTER_INTERFACE, "Powered");
> +       g_dbus_emit_property_changed(dbus_conn, adapter->path,
> +                                               ADAPTER_INTERFACE, "PowerState");
>
>         DBG("adapter %s has been disabled", adapter->path);
>  }
> --
> 2.37.2
>


-- 
Luiz Augusto von Dentz
