Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE0EC71155
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 05:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EE5022203
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 05:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgLCFLb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Dec 2020 00:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbgLCFLa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Dec 2020 00:11:30 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B166DC061A4F
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Dec 2020 21:10:50 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id k26so995495oiw.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Dec 2020 21:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vcgip+IsWiqFz8idQOoOeSoBXwyE7NXCtezIH07uilw=;
        b=jh/+C1cuOHkGej+3EDJsceDHDryRZzCQ8kco+GxXamR5ZtVQ26eplMKdnw21gVY2fC
         gL9igaFwhhmXbgogLzF07eQYJnmuEJlHg/omU2+iAD9zhAiuNCZpsM4Rc3kujkwwcW5X
         rlZT8uqyMirATAdYYEH1m4BX8wzvdmoCoisYHz9AFr595BOGb90fPuhAC6T1QMtP2hX8
         E6kdkeqrqrXA1TWTRaOZPc1PQgp3ekKk254tacox6PotWlP9J5z1+X6EWFLqzMhkLiW1
         WFSMwTtlDOCSAGOzeQWGu+p5d0XjpjIYQxFswMfHBdjOPgi+AXRT9QhYKwcesO51rkzU
         EVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vcgip+IsWiqFz8idQOoOeSoBXwyE7NXCtezIH07uilw=;
        b=nJoKcuZe2QGJQ1OG+UsIAKH8r784Kss6Z2lLuob5t6Z2cK3V0AKN7LaYbaVzbuQMob
         rE4VY42yx7EfrHl0k2FmWbXRbeIJvQC5EAf66+oGLnN6PeWt3lF4iMx2YrRngUeEewU9
         hYFAlNTJ/VdOr1k21ZulUtWRZtmuP6Z3I9Otc/1MVa2vNkhcqVgavGmH0AOrXvveEi9M
         NmK1Ea8JZlYdkJfQOxP/skWYA8yY4jtDEDta/1/qm6t3dGeADtTc0i0noUHMzi7vvqTC
         ryKzpfez1Th7oSJicWNgAHxxlBInOXE0AGQ2I/upnjqPkGzHHBIYKTHtHnkaMT7vDTYm
         ganA==
X-Gm-Message-State: AOAM533GoV/5VBCAFcZWPeYzJqnhIf+T7j+gtULyl0egHQJHyMLNrYFs
        LovHh29YPnyHBsFmNB2I5t5eV8WF245UpoPSAzw=
X-Google-Smtp-Source: ABdhPJz7aziWVhgK/6567Y2MhiognyjJgWC9zs8fQcQ9pEMYO7ttmswuIfexgRmH1NEuuvvtSS4KIJ2KJeJHUterkoA=
X-Received: by 2002:a05:6808:1d8:: with SMTP id x24mr843118oic.64.1606972250036;
 Wed, 02 Dec 2020 21:10:50 -0800 (PST)
MIME-Version: 1.0
References: <20201125121844.bluez.v2.1.I4dd1c737d5f8806fe2aa99b8c2d8154fe58871ed@changeid>
 <CAGPPCLDBqBM0J+gKogB5D2J_LdMjyFss2FVhdM3r2dscGJ77Ug@mail.gmail.com>
In-Reply-To: <CAGPPCLDBqBM0J+gKogB5D2J_LdMjyFss2FVhdM3r2dscGJ77Ug@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 2 Dec 2020 21:10:39 -0800
Message-ID: <CABBYNZ+Wq81dVL2fi2oOh5bmgjAcxn+qUwVD68JEHeS4mu6-OA@mail.gmail.com>
Subject: Re: [bluez PATCH v2] adv_monitor: Update log messages
To:     Manish Mandlik <mmandlik@google.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Manish,

On Wed, Dec 2, 2020 at 7:55 PM Manish Mandlik <mmandlik@google.com> wrote:
>
> Friendly reminder to review this patch.
>
> Thanks,
> Manish.
>
>
> On Wed, Nov 25, 2020 at 12:18 PM Manish Mandlik <mmandlik@google.com> wrote:
>>
>> Update log messages to avoid breaking of user-visible log strings
>> to make it easy to grep for them.
>>
>> Reviewed-by: mcchou@chromium.org
>> Reviewed-by: alainm@chromium.org
>> Signed-off-by: Manish Mandlik <mmandlik@google.com>
>> ---
>>
>> Changes in v2:
>> - Fix merge conflicts
>>
>>  src/adv_monitor.c | 58 +++++++++++++++++++++++++++--------------------
>>  1 file changed, 34 insertions(+), 24 deletions(-)
>>
>> diff --git a/src/adv_monitor.c b/src/adv_monitor.c
>> index fc058dbf1..767c1c82d 100644
>> --- a/src/adv_monitor.c
>> +++ b/src/adv_monitor.c
>> @@ -318,8 +318,9 @@ static void app_disconnect_cb(DBusConnection *conn, void *user_data)
>>                 return;
>>         }
>>
>> -       btd_info(app->manager->adapter_id, "Adv Monitor app %s disconnected "
>> -                       "from D-Bus", app->owner);
>> +       btd_info(app->manager->adapter_id,
>> +                       "Adv Monitor app %s disconnected from D-Bus",
>> +                       app->owner);
>>
>>         if (queue_remove(app->manager->apps, app)) {
>>                 queue_foreach(app->monitors, monitor_state_released, NULL);
>> @@ -396,8 +397,9 @@ static bool parse_monitor_type(struct adv_monitor *monitor, const char *path)
>>         uint16_t adapter_id = monitor->app->manager->adapter_id;
>>
>>         if (!g_dbus_proxy_get_property(monitor->proxy, "Type", &iter)) {
>> -               btd_error(adapter_id, "Failed to retrieve property Type from "
>> -                       "the Adv Monitor at path %s", path);
>> +               btd_error(adapter_id,
>> +                               "Failed to retrieve property Type from the "
>> +                               "Adv Monitor at path %s", path);
>>                 return false;
>>         }
>>
>> @@ -414,8 +416,9 @@ static bool parse_monitor_type(struct adv_monitor *monitor, const char *path)
>>         }
>>
>>  failed:
>> -       btd_error(adapter_id, "Invalid argument of property Type of the Adv "
>> -                       "Monitor at path %s", path);
>> +       btd_error(adapter_id,
>> +                       "Invalid argument of property Type of the Adv Monitor "
>> +                       "at path %s", path);
>>
>>         return false;
>>  }
>> @@ -515,8 +518,9 @@ failed:
>>         monitor->high_rssi_timeout = ADV_MONITOR_UNSET_TIMER;
>>         monitor->low_rssi_timeout = ADV_MONITOR_UNSET_TIMER;
>>
>> -       btd_error(adapter_id, "Invalid argument of property "
>> -                       "RSSIThresholdsAndTimers of the Adv Monitor at path %s",
>> +       btd_error(adapter_id,
>> +                       "Invalid argument of property RSSIThresholdsAndTimers "
>> +                       "of the Adv Monitor at path %s",
>>                         path);
>>
>>         return false;
>> @@ -531,8 +535,9 @@ static bool parse_patterns(struct adv_monitor *monitor, const char *path)
>>         uint16_t adapter_id = monitor->app->manager->adapter_id;
>>
>>         if (!g_dbus_proxy_get_property(monitor->proxy, "Patterns", &array)) {
>> -               btd_error(adapter_id, "Failed to retrieve property Patterns "
>> -                               "from the Adv Monitor at path %s", path);
>> +               btd_error(adapter_id,
>> +                               "Failed to retrieve property Patterns from the "
>> +                               "Adv Monitor at path %s", path);
>>                 return false;
>>         }
>>
>> @@ -640,8 +645,9 @@ static void add_adv_patterns_monitor_cb(uint8_t status, uint16_t length,
>>         uint16_t adapter_id = monitor->app->manager->adapter_id;
>>
>>         if (status != MGMT_STATUS_SUCCESS || !param) {
>> -               btd_error(adapter_id, "Failed to Add Adv Patterns Monitor "
>> -                               "with status 0x%02x", status);
>> +               btd_error(adapter_id,
>> +                               "Failed to Add Adv Patterns Monitor with status"
>> +                               " 0x%02x", status);
>>                 monitor->state = MONITOR_STATE_FAILED;
>>                 monitor_destroy(monitor);
>>                 return;
>> @@ -696,15 +702,17 @@ static void monitor_proxy_added_cb(GDBusProxy *proxy, void *user_data)
>>         }
>>
>>         if (queue_find(app->monitors, monitor_match, proxy)) {
>> -               btd_error(adapter_id, "Adv Monitor proxy already exists with "
>> -                               "path %s", path);
>> +               btd_error(adapter_id,
>> +                               "Adv Monitor proxy already exists with path %s",
>> +                               path);
>>                 return;
>>         }
>>
>>         monitor = monitor_new(app, proxy);
>>         if (!monitor) {
>> -               btd_error(adapter_id, "Failed to allocate an Adv Monitor for "
>> -                               "the object at %s", path);
>> +               btd_error(adapter_id,
>> +                               "Failed to allocate an Adv Monitor for the "
>> +                               "object at %s", path);
>>                 return;
>>         }
>>
>> @@ -882,8 +890,9 @@ static DBusMessage *unregister_monitor(DBusConnection *conn,
>>         queue_remove(manager->apps, app);
>>         app_destroy(app);
>>
>> -       btd_info(manager->adapter_id, "Path %s removed along with Adv Monitor "
>> -                       "app %s", match.path, match.owner);
>> +       btd_info(manager->adapter_id,
>> +                       "Path %s removed along with Adv Monitor app %s",
>> +                       match.path, match.owner);
>>
>>         return dbus_message_new_method_return(msg);
>>  }
>> @@ -1021,8 +1030,8 @@ static void adv_monitor_removed_callback(uint16_t index, uint16_t length,
>>         const uint16_t adapter_id = manager->adapter_id;
>>
>>         if (length < sizeof(*ev)) {
>> -               btd_error(adapter_id, "Wrong size of Adv Monitor Removed "
>> -                               "event");
>> +               btd_error(adapter_id,
>> +                               "Wrong size of Adv Monitor Removed event");
>>                 return;
>>         }
>>
>> @@ -1093,8 +1102,9 @@ static void read_adv_monitor_features_cb(uint8_t status, uint16_t length,
>>         struct btd_adv_monitor_manager *manager = user_data;
>>
>>         if (status != MGMT_STATUS_SUCCESS || !param) {
>> -               btd_error(manager->adapter_id, "Failed to Read Adv Monitor "
>> -                               "Features with status 0x%02x", status);
>> +               btd_error(manager->adapter_id,
>> +                               "Failed to Read Adv Monitor Features with "
>> +                               "status 0x%02x", status);
>>                 return;
>>         }
>>
>> @@ -1436,8 +1446,8 @@ static void adv_monitor_filter_rssi(struct adv_monitor *monitor,
>>         if (!dev) {
>>                 dev = monitor_device_create(monitor, device);
>>                 if (!dev) {
>> -                       btd_error(adapter_id, "Failed to create Adv Monitor "
>> -                                             "device object.");
>> +                       btd_error(adapter_id,
>> +                               "Failed to create Adv Monitor device object.");
>>                         return;
>>                 }
>>         }
>> --
>> 2.29.2.454.gaff20da3a2-goog

Applied, thanks.


-- 
Luiz Augusto von Dentz
