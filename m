Return-Path: <SRS0=ZhIC=B5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E8EC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 18:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD5D6207DE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 18:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BB8nlnEl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgHSShV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgHSShU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Aug 2020 14:37:20 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9B2C061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2020 11:37:19 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id q9so19846144oth.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2020 11:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0HeIGZ0DyzgCbL5apsf54ipOledAWW5U3rl6Iv7K7EU=;
        b=BB8nlnElYvnEtLlxUYqV8iuHSgs85Gg/45Dp9ymnCnHyCPW4ivRcJH3mZxdNCKhAeM
         4MDNg/t4xEB1XobP3suSRBqHaERKtqck84yTFrrTrxGUUu5DD2CHqqAcqx7FEHyQbQpo
         ozm3l4V7coBSnhyNj9PiRXY6gbzbGFXmx9yV9/u8KnWELyYJw2KBQRa8Pd6X8Jzgu5N6
         S35XjLkuvMKnRe7n5goMWpAI016ZQZkKhF/T0pDANZR9GI1zwGM17qpGEqyE2RUsdKgw
         OH0A5nM4nMIhcGbIXwQQSTAjpzUcSLvO5LwH1b3An2o6Nu6yL9/LX10A9fAfAkDBmEjc
         iNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0HeIGZ0DyzgCbL5apsf54ipOledAWW5U3rl6Iv7K7EU=;
        b=VPHCXyLsCCLBvHCsZrNSwnGSJtaF1WdH0Wis+YDRStxYMJQZE9o9cb+mVWVAEcxsoh
         +5QczhAaCVUO+aBy5vAmRTZqDE9EUbYH3vO0M2iJNCEzGpsctaJJeKL9U0uOajwTH/o7
         E2SOgbC+mWmZQqEwJ/QSusCCLOebRkjHH/WT40b6W68BYSC1FE06daNxoHTfUJDtqjvL
         aC9FWmNJMtuTD/Z1CCJ7dvnSePYCeI/69r3SZYtOmmZ08z4Za7EWbql/nr+J2+9h72Nc
         xfbfi1xjXBkTWhUBSqRB3jCCHQaBEQfg44XodNveUs0AYoIELiVvQoZAUzSKZKUBMXmt
         5e2A==
X-Gm-Message-State: AOAM531NKeQ1PhRRwWgrjTixb3af41kdUSNHxdHw1cDs0jFESJ3I2+jj
        QJwFTz6v2ZupCdx01FfGKG7p68F/jS1N/HLkuUrU4ZQtmIY=
X-Google-Smtp-Source: ABdhPJxC8UBCMYG47EEADSQckWecSzJaykg83rAruk57WKUCtMUiwmXxN8tQNglInTal0V8YVvZKIwG7D9JKz6GGqEs=
X-Received: by 2002:a9d:429:: with SMTP id 38mr18318780otc.88.1597862239111;
 Wed, 19 Aug 2020 11:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200819150931.3005-1-mark.marshall@omicronenergy.com> <2303f692-bb7c-4851-86fa-befde45b4b32@EXC04-ATKLA.omicron.at>
In-Reply-To: <2303f692-bb7c-4851-86fa-befde45b4b32@EXC04-ATKLA.omicron.at>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 19 Aug 2020 11:37:08 -0700
Message-ID: <CABBYNZ+OK4EY9KGHn7oasz4GRfBDJdWNcpOhr1GNGc3D+QtZ-g@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] src/profile.c: Add a GetProfileInfo method
To:     Mark Marshall <mark.marshall@omicronenergy.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Mark,

On Wed, Aug 19, 2020 at 8:13 AM Mark Marshall
<mark.marshall@omicronenergy.com> wrote:
>
> Add a GetProfileInfo method to org.bluez.ProfileManager1
> ---
>  doc/profile-api.txt | 13 +++++++
>  src/profile.c       | 93 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 106 insertions(+)
>
> diff --git a/doc/profile-api.txt b/doc/profile-api.txt
> index 8c7d0a06d..d13703ab4 100644
> --- a/doc/profile-api.txt
> +++ b/doc/profile-api.txt
> @@ -133,6 +133,19 @@ Object path        /org/bluez
>
>                         Possible errors: org.bluez.Error.DoesNotExist
>
> +               options GetProfileInfo(object profile, object adapter)
> +
> +                       This returns a dictionary of options for the
> +                       profile.  Values returned are: UUID, Name,
> +                       Path, Service, Mode and AddressType.  The
> +                       adapter parameter is optional - if it is
> +                       non-empty, then two additional values might be
> +                       returned, if the profile is active on the
> +                       specified adapter: PSM and Channel.
> +
> +                       Possible errors: org.bluez.Error.InvalidArguments
> +                                        org.bluez.Error.DoesNotExist
> +

If this is really required I would be willing to merge something like this:

https://github.com/Vudentz/BlueZ/commit/9e196f8830511a4102e990d82d06c2e0487b3ad9

It exposes service objects so you can control exactly what gets
connect, though now given a second look at this seem to return details
that the client can query directly on the socket itself like the
Channel, PSM, Mode, etc, also not sure what is the point on retrieving
things like UUID, Name, Path if the application is already in control
of these when registering.

>  Profile hierarchy
>  =================
> diff --git a/src/profile.c b/src/profile.c
> index 10850f305..e287a66d7 100644
> --- a/src/profile.c
> +++ b/src/profile.c
> @@ -2509,6 +2509,96 @@ static DBusMessage *unregister_profile(DBusConnection *conn,
>         return dbus_message_new_method_return(msg);
>  }
>
> +static DBusMessage *get_profile_info(DBusConnection *conn,
> +                                       DBusMessage *msg, void *user_data)
> +{
> +       DBusMessage *reply;
> +       DBusMessageIter iter, dict;
> +       const char *path, *adapter, *sender;
> +       struct ext_profile *ext;
> +       uint16_t u16;
> +       GSList *l, *next;
> +
> +       sender = dbus_message_get_sender(msg);
> +
> +       DBG("sender %s", sender);
> +
> +       if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
> +                                  DBUS_TYPE_OBJECT_PATH, &adapter,
> +                                  DBUS_TYPE_INVALID)) {
> +               return btd_error_invalid_args(msg);
> +       }
> +
> +       if (adapter && !*adapter)
> +               adapter = NULL;
> +
> +       ext = find_ext_profile(sender, path);
> +       if (!ext)
> +               return btd_error_does_not_exist(msg);
> +
> +       reply = dbus_message_new_method_return(msg);
> +
> +       dbus_message_iter_init_append(reply, &iter);
> +
> +       dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
> +                                        "{sv}", &dict);
> +
> +       g_dbus_dict_append_entry(&dict, "UUID", DBUS_TYPE_STRING,
> +                                &ext->uuid);
> +       if (ext->name) {
> +               g_dbus_dict_append_entry(&dict, "Name", DBUS_TYPE_STRING,
> +                                        &ext->name);
> +       }
> +       if (ext->path) {
> +               g_dbus_dict_append_entry(&dict, "Path", DBUS_TYPE_STRING,
> +                                        &ext->path);
> +       }
> +       if (ext->service) {
> +               g_dbus_dict_append_entry(&dict, "Service", DBUS_TYPE_STRING,
> +                                        &ext->service);
> +       }
> +
> +       u16 = ext->mode;
> +       g_dbus_dict_append_entry(&dict, "Mode", DBUS_TYPE_UINT16,
> +                                &u16);
> +
> +       u16 = ext->addr_type;
> +       g_dbus_dict_append_entry(&dict, "AddressType", DBUS_TYPE_UINT16,
> +                                &u16);
> +
> +       if (adapter) {
> +               for (l = ext->servers; l != NULL; l = next) {
> +                       struct ext_io *server = l->data;
> +                       const char *ctype;
> +
> +                       DBG("server:%p  %d %d psm:%d chan:%d",
> +                           server, server->resolving, server->connected,
> +                           server->psm, server->chan);
> +
> +                       next = g_slist_next(l);
> +
> +                       if (strcmp(adapter, adapter_get_path(server->adapter)))
> +                               continue;
> +
> +                       if (server->proto == BTPROTO_L2CAP) {
> +                               ctype = "PSM";
> +                               u16 = server->psm;
> +                       } else if (server->proto == BTPROTO_RFCOMM) {
> +                               ctype = "Channel";
> +                               u16 = server->chan;
> +                       } else {
> +                               continue;
> +                       }
> +                       g_dbus_dict_append_entry(
> +                               &dict, ctype, DBUS_TYPE_UINT16, &u16);
> +               }
> +       }
> +
> +       dbus_message_iter_close_container(&iter, &dict);
> +
> +       return reply;
> +}
> +
>  static const GDBusMethodTable methods[] = {
>         { GDBUS_METHOD("RegisterProfile",
>                         GDBUS_ARGS({ "profile", "o"}, { "UUID", "s" },
> @@ -2516,6 +2606,9 @@ static const GDBusMethodTable methods[] = {
>                         NULL, register_profile) },
>         { GDBUS_METHOD("UnregisterProfile", GDBUS_ARGS({ "profile", "o" }),
>                         NULL, unregister_profile) },
> +       { GDBUS_METHOD("GetProfileInfo",
> +                       GDBUS_ARGS({ "profile", "o" }, { "adapter", "o" }),
> +                       GDBUS_ARGS({ "options", "a{sv}" }), get_profile_info) },
>         { }
>  };
>
> --
> 2.17.1
>


-- 
Luiz Augusto von Dentz
