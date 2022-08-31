Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7FCECAAD1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Aug 2022 20:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiHaUDa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Aug 2022 16:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiHaUD2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Aug 2022 16:03:28 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32286C0B60
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 13:03:27 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id by6so15735203ljb.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 13:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=4nNIYpynXaL8tg8tJOQTV4uclF/mefsgytUiEQgEsk4=;
        b=OJztqRoN0c9bWGcCXK9V7S+Bgok7O5aeV/+eyoc1Mifriu5/rTYaix61TXxSdLAQmE
         h5WmD2SXiMPWmAPoRfXGm0v5wfKA25Lv6c92UHEf7QjVWODLw/bBSpyKsOLuXWBuJfZK
         yTWGKMXrAjL2FJj4Aq1ZG6t96OO9Y+R1o0OAibyzIGvDqXMQXAzFl2CtUlw0t5gI3PhL
         BPpmFpHSfrSV7mIU0E8zCzZRUouScMC5GkZF4M1jskkGTxIS1AO6tD2H1+E3A+9WNAG9
         dXHTYovADew0AwA7fezsdgWf7mFD6XYmCOf0sVGwJDgaYNtriQsL3iYxB62I/+r+d5za
         zkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=4nNIYpynXaL8tg8tJOQTV4uclF/mefsgytUiEQgEsk4=;
        b=HLf9hsbJjf/3JKStuyj8Vc2p09B7KwbMIxHL8zZQMwckEdfPQoF1o0d8UHZM87p74q
         YtgmRt3kwmT9/sDnNetouKB6aPMofc30QHS+kTjPcom+GbSlu6pgzGm4fhhv/mhkJ7B3
         aiPR/cyKwwRGVxmV0Rjy1CJGI8SG3eXtoK1C6zVW4eCuqaoBl/VwGEjioU1xOWMuwVH+
         WKlST8fUJxQT6pWHxNyTKXCLvFCvf2q4QBSh+nyMQn+2NtAyEEJ2+TN2LcYGny2WZWOW
         VNfjJkOKVLgt5K/XkWYnOst/R/vDoGGFB9x2XqrF6+7fLw8a2TW6yG9t73dOCpYBkSZh
         P73g==
X-Gm-Message-State: ACgBeo0Lp+S8Lisd0pS7WlDuLWYPPZeEK67f8Lh7c51sb3kMGBvcCguD
        +uWWPahBDVWxEsBjAiMb2ghnqIVxb0uhVK1IJwRukP2ur5U=
X-Google-Smtp-Source: AA6agR6SwhjMUwsK9jQ9+dY95yF1OQddn9OTNThaFz7X+pzrf+RIPOeQX8ur74gVMZjplT2JdjGRZE4AGt8USEWdsC4=
X-Received: by 2002:a2e:9d81:0:b0:266:a1d7:74b4 with SMTP id
 c1-20020a2e9d81000000b00266a1d774b4mr3461467ljj.423.1661976205335; Wed, 31
 Aug 2022 13:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220831091912.47894-1-hadess@hadess.net> <20220831091912.47894-2-hadess@hadess.net>
In-Reply-To: <20220831091912.47894-2-hadess@hadess.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 31 Aug 2022 13:03:13 -0700
Message-ID: <CABBYNZ+aqTbSR-=R7CP8pY48=QxoEjsYnY7oCWc=niLYr7o2fg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 2/6] adapter: Implement PowerState property
To:     Bastien Nocera <hadess@hadess.net>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

On Wed, Aug 31, 2022 at 2:32 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> This property should allow any program to show whether an adapter is in
> the process of being turned on.
>
> As turning on an adapter isn't instantaneous, it's important that the UI
> reflects the transitional state of the adapter's power, and doesn't
> assume the device is already turned on but not yet working, or still off
> despite having requested for it to be turned on, in both cases making
> the UI feel unresponsive.
>
> This can also not be implemented in front-ends directly as, then,
> the status of an adapter wouldn't be reflected correctly in the Settings
> window if it's turned on in the system menu. Implementing it in the
> front-ends would also preclude from having feedback about the state of
> the adapter when bluetoothd is the one powering up the adapter after the
> rfkill was unblocked.
>
> See https://gitlab.gnome.org/GNOME/gnome-bluetooth/-/issues/121
> and the original https://gitlab.gnome.org/GNOME/gnome-shell/-/issues/5773
> ---
>  src/adapter.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 87 insertions(+), 1 deletion(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 641db67f9..e295ef247 100644
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

Lets take out the TARGET portion and have all the states PowerState
can assume including the transitioning ones.

> +
>  struct btd_adapter {
>         int ref_count;
>
> @@ -253,6 +259,7 @@ struct btd_adapter {
>         bool blocked;                   /* whether rfkill is enabled */
>         uint32_t supported_settings;    /* controller supported settings */
>         uint32_t pending_settings;      /* pending controller settings */
> +       uint32_t power_state_target;    /* the target power state */

Let's have the value stored as the enum here so it reflects directly
the values PowerState property can assume.

>         uint32_t current_settings;      /* current controller settings */
>
>         char *path;                     /* adapter object path */
> @@ -580,6 +587,8 @@ static void settings_changed(struct btd_adapter *adapter, uint32_t settings)
>         if (changed_mask & MGMT_SETTING_POWERED) {
>                 g_dbus_emit_property_changed(dbus_conn, adapter->path,
>                                         ADAPTER_INTERFACE, "Powered");
> +               g_dbus_emit_property_changed(dbus_conn, adapter->path,
> +                                       ADAPTER_INTERFACE, "PowerState");
>
>                 if (adapter->current_settings & MGMT_SETTING_POWERED) {
>                         adapter_start(adapter);
> @@ -619,6 +628,16 @@ static void settings_changed(struct btd_adapter *adapter, uint32_t settings)
>         }
>  }
>
> +static void reset_power_state_target(struct btd_adapter *adapter, uint8_t value)
> +{
> +       if ((value &&
> +            adapter->power_state_target == ADAPTER_POWER_STATE_TARGET_ON) ||
> +           (!value &&
> +            adapter->power_state_target == ADAPTER_POWER_STATE_TARGET_OFF)) {
> +               adapter->power_state_target = ADAPTER_POWER_STATE_TARGET_NONE;
> +       }
> +}

Id suggest we add DBG statement to make it easier to debug, and rework
a little bit so it takes care of updating the property when the state
changes:

static void adapter_set_power_state(struct btd_adapter *adapter, enum value)
{
    if (adapter->power_state == value)
        return;

    DBG("%s", adapter_power_state_str(value));
...update...

    g_dbus_emit_property_changed(dbus_conn, adapter->path,
                                               ADAPTER_INTERFACE, "PowerState");
}

>  static void new_settings_callback(uint16_t index, uint16_t length,
>                                         const void *param, void *user_data)
>  {
> @@ -636,6 +655,9 @@ static void new_settings_callback(uint16_t index, uint16_t length,
>         if (settings == adapter->current_settings)
>                 return;
>
> +       if ((adapter->current_settings ^ settings) & MGMT_SETTING_POWERED)
> +               reset_power_state_target(adapter, settings & MGMT_SETTING_POWERED ? 0x01 : 0x00);
> +
>         DBG("Settings: 0x%08x", settings);
>
>         settings_changed(adapter, settings);
> @@ -644,6 +666,7 @@ static void new_settings_callback(uint16_t index, uint16_t length,
>  struct set_mode_data {
>         struct btd_adapter *adapter;
>         uint32_t setting;
> +       uint8_t value;
>  };
>
>  static void set_mode_complete(uint8_t status, uint16_t length,
> @@ -658,6 +681,8 @@ static void set_mode_complete(uint8_t status, uint16_t length,
>                 if (status == MGMT_STATUS_RFKILLED)
>                         adapter->blocked = true;
>                 adapter->pending_settings &= ~data->setting;
> +               if (data->setting & MGMT_SETTING_POWERED)
> +                       reset_power_state_target(adapter, data->value);
>                 return;
>         }
>
> @@ -695,6 +720,11 @@ static bool set_mode(struct btd_adapter *adapter, uint16_t opcode,
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
> @@ -715,6 +745,7 @@ static bool set_mode(struct btd_adapter *adapter, uint16_t opcode,
>         data = g_new0(struct set_mode_data, 1);
>         data->adapter = adapter;
>         data->setting = setting;
> +       data->value = mode;
>
>         if (mgmt_send(adapter->mgmt, opcode,
>                                 adapter->dev_id, sizeof(cp), &cp,
> @@ -722,8 +753,13 @@ static bool set_mode(struct btd_adapter *adapter, uint16_t opcode,
>                 adapter->pending_settings |= setting;
>                 return true;
>         }
> -
>         g_free(data);
> +       if (setting == MGMT_SETTING_POWERED) {
> +               /* cancel the earlier setting */
> +               adapter->power_state_target = ADAPTER_POWER_STATE_TARGET_NONE;
> +               g_dbus_emit_property_changed(dbus_conn, adapter->path,
> +                                               ADAPTER_INTERFACE, "PowerState");
> +       }
>         btd_error(adapter->dev_id, "Failed to set mode for index %u",
>                                                         adapter->dev_id);
>
> @@ -2901,6 +2937,7 @@ struct property_set_data {
>         struct btd_adapter *adapter;
>         uint32_t setting;
>         GDBusPendingPropertySet id;
> +       uint8_t value;
>  };
>
>  static void property_set_mode_complete(uint8_t status, uint16_t length,
> @@ -2928,6 +2965,8 @@ static void property_set_mode_complete(uint8_t status, uint16_t length,
>                                                         mgmt_errstr(status));
>
>                 adapter->pending_settings &= ~data->setting;
> +               if (data->setting & MGMT_SETTING_POWERED)
> +                       reset_power_state_target(adapter, data->value);
>                 return;
>         }
>
> @@ -3051,6 +3090,16 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
>         data->adapter = adapter;
>         data->setting = setting;
>         data->id = id;
> +       data->setting = setting;
> +       data->value = mode;
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
>                         property_set_mode_complete, data, g_free) > 0) {
> @@ -3059,6 +3108,12 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
>         }
>
>         g_free(data);
> +       if (setting == MGMT_SETTING_POWERED) {
> +               /* cancel the earlier setting */
> +               adapter->power_state_target = ADAPTER_POWER_STATE_TARGET_NONE;
> +               g_dbus_emit_property_changed(dbus_conn, adapter->path,
> +                                               ADAPTER_INTERFACE, "PowerState");
> +       }
>
>  failed:
>         btd_error(adapter->dev_id, "Failed to set mode for index %u",
> @@ -3090,6 +3145,31 @@ static void property_set_powered(const GDBusPropertyTable *property,
>         property_set_mode(adapter, MGMT_SETTING_POWERED, iter, id);
>  }
>
> +static gboolean property_get_power_state(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *user_data)
> +{
> +       struct btd_adapter *adapter = user_data;
> +       const char *str;
> +
> +       if (adapter->blocked) {
> +               str = "off-blocked";
> +       } else if (adapter->power_state_target == ADAPTER_POWER_STATE_TARGET_NONE) {
> +               if (adapter->current_settings & MGMT_SETTING_POWERED)
> +                       str = "on";
> +               else
> +                       str = "off";
> +       } else {
> +               if (adapter->power_state_target == ADAPTER_POWER_STATE_TARGET_ON)
> +                       str = "off-enabling";
> +               else
> +                       str = "on-disabling";
> +       }
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &str);

With the suggestion above this should be just a matter of:

    const char *str = adapter_power_state_str(adapter->power_state);

    dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &str);

So any updates to the enum, etc, are reflected directly as well since
we will need to update adapter_power_state_str.

> +       return TRUE;
> +}
> +
>  static gboolean property_get_discoverable(const GDBusPropertyTable *property,
>                                         DBusMessageIter *iter, void *user_data)
>  {
> @@ -3728,6 +3808,8 @@ static const GDBusPropertyTable adapter_properties[] = {
>         { "Alias", "s", property_get_alias, property_set_alias },
>         { "Class", "u", property_get_class },
>         { "Powered", "b", property_get_powered, property_set_powered },
> +       { "PowerState", "s", property_get_power_state, NULL, NULL,
> +                            G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
>         { "Discoverable", "b", property_get_discoverable,
>                                         property_set_discoverable },
>         { "DiscoverableTimeout", "u", property_get_discoverable_timeout,
> @@ -5534,6 +5616,8 @@ static void adapter_start(struct btd_adapter *adapter)
>  {
>         g_dbus_emit_property_changed(dbus_conn, adapter->path,
>                                                 ADAPTER_INTERFACE, "Powered");
> +       g_dbus_emit_property_changed(dbus_conn, adapter->path,
> +                                               ADAPTER_INTERFACE, "PowerState");
>
>         DBG("adapter %s has been enabled", adapter->path);
>
> @@ -7277,6 +7361,8 @@ static void adapter_stop(struct btd_adapter *adapter)
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
