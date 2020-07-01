Return-Path: <SRS0=mBsK=AM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAA4C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 19:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3670620760
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 19:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hOt4Huxe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgGATXT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Jul 2020 15:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgGATXT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Jul 2020 15:23:19 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F23C08C5C1
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2020 12:23:19 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id h1so110383otq.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2020 12:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bShO5PDmct0f9bu7tk9Guh9swfNV4oTpxjld44HtZVk=;
        b=hOt4Huxeq1RPojKuUYowCT6t/vMi/vCpUXuxbJg9T2HT+qrFxln355/C8/HrYmg/gC
         YdQN5fnk2BjoIRW6UFyIZPHwAWtO7G6y5BfaRYAvj63VEIqjdu76dpWh1PYH+EByWnCw
         Lul703vYB9GOhPe1p8i6HlC4XGD3WVMeQPa1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bShO5PDmct0f9bu7tk9Guh9swfNV4oTpxjld44HtZVk=;
        b=m8QwFHCektQxgcun68UoV9/GkxrhcTHoSI7+kPJ+fF4/+ieGtcEIxwXM0f1o6OCxq4
         HpkmAJdW+qV1Z4Yd+eC1VmLoNAxHNu2oUuU6FtYitPC3Ijga5HEz4dA9//X91AeZPZXP
         Oo6ZhwqZ5GCWG6N3uJuI1NSeokoEQ7vXGVAZV6L0+SEucWtmdHIlQji8+n1Gd7+nqn/D
         /iP7O6mbFOSjUQzK5Os+ZTltIYRVpzAABw/HqL6faJhzAt9Ugc6NblrGcwNKMBYUYRZn
         jBgAO9gGQ4ONBqeS0rE2lO+n9/n3V4HvKbrnTfy6q3x9/X+7ijB8kTw2F0EudufOVlWG
         n3hg==
X-Gm-Message-State: AOAM533I15LY8Hn7YBK2Oi4YJUaaj7j61lKuWhhX49LR/jaY05Ps8Qot
        KaIXnztOnunrYMnNrAQD4n/goAINZSIHAZbfncTO2wHV7IE=
X-Google-Smtp-Source: ABdhPJxrQ2qx8nRisk5ESJV4eSS73BFcSe4ovFdmUayVyVTmXLFx6/J6A8V7WYNy7+X1iBx0gX5w4ZdQFvBxcNbfOfI=
X-Received: by 2002:a9d:554d:: with SMTP id h13mr22544440oti.329.1593631398806;
 Wed, 01 Jul 2020 12:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200630184629.95013-1-sonnysasaka@chromium.org> <CABBYNZKvKNhZeQ52sEE8uZYdrX9cBjM2Wh_BrOpZnkJUc5YcKQ@mail.gmail.com>
In-Reply-To: <CABBYNZKvKNhZeQ52sEE8uZYdrX9cBjM2Wh_BrOpZnkJUc5YcKQ@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Wed, 1 Jul 2020 12:23:06 -0700
Message-ID: <CAOxioNkiPA01Ztw6ugCyF8H-96raKW9o8am1D+qV8veWvkrakg@mail.gmail.com>
Subject: Re: [PATCH v2] client: Add battery command
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

I thought of doing that (combining with info command). But we foresee
that the Battery API will get more complex (such as support of
multiple batteries like Pixel Buds and Airpods) and deserve its own
command. Furthermore, it's a different API (org.bluez.Device1 vs
org.bluez.Battery1) and its inner working uses a specific profile (BAS
over GATT), so I think that it deserves its own command. But anyway I
sent another patch that combines this into the "info" command and if
you think this is more appropriate we can combine it for now and
separate it in the future when needed.


On Wed, Jul 1, 2020 at 10:56 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sonny,
>
> On Tue, Jun 30, 2020 at 1:48 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >
> > This adds the "battery" command to show battery information of a peer
> > device based on org.bluez.Battery1 API. Example usage:
> >
> > [bluetooth]# battery XX:XX:XX:XX:XX:XX
> > Percentage: 100%
>
> It might be better to put the battery level under info command.
>
> > ---
> >  client/main.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> >
> > diff --git a/client/main.c b/client/main.c
> > index 422da5593..8c1ed00fb 100644
> > --- a/client/main.c
> > +++ b/client/main.c
> > @@ -65,6 +65,7 @@ static struct adapter *default_ctrl;
> >  static GDBusProxy *default_dev;
> >  static GDBusProxy *default_attr;
> >  static GList *ctrl_list;
> > +static GList *battery_proxies;
> >
> >  static const char *agent_arguments[] = {
> >         "on",
> > @@ -107,7 +108,9 @@ static void disconnect_handler(DBusConnection *connection, void *user_data)
> >         bt_shell_set_prompt(PROMPT_OFF);
> >
> >         g_list_free_full(ctrl_list, proxy_leak);
> > +       g_list_free_full(battery_proxies, proxy_leak);
> >         ctrl_list = NULL;
> > +       battery_proxies = NULL;
> >
> >         default_ctrl = NULL;
> >  }
> > @@ -445,6 +448,16 @@ done:
> >         g_free(desc);
> >  }
> >
> > +static void battery_added(GDBusProxy *proxy)
> > +{
> > +       battery_proxies = g_list_append(battery_proxies, proxy);
> > +}
> > +
> > +static void battery_removed(GDBusProxy *proxy)
> > +{
> > +       battery_proxies = g_list_remove(battery_proxies, proxy);
> > +}
> > +
> >  static void device_added(GDBusProxy *proxy)
> >  {
> >         DBusMessageIter iter;
> > @@ -539,6 +552,8 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
> >                 gatt_add_manager(proxy);
> >         } else if (!strcmp(interface, "org.bluez.LEAdvertisingManager1")) {
> >                 ad_manager_added(proxy);
> > +       } else if (!strcmp(interface, "org.bluez.Battery1")) {
> > +               battery_added(proxy);
> >         }
> >  }
> >
> > @@ -630,6 +645,8 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
> >                 gatt_remove_manager(proxy);
> >         } else if (!strcmp(interface, "org.bluez.LEAdvertisingManager1")) {
> >                 ad_unregister(dbus_conn, NULL);
> > +       } else if (!strcmp(interface, "org.bluez.Battery1")) {
> > +               battery_removed(proxy);
> >         }
> >  }
> >
> > @@ -763,6 +780,20 @@ static struct adapter *find_ctrl_by_address(GList *source, const char *address)
> >         return NULL;
> >  }
> >
> > +static GDBusProxy *find_battery_by_path(GList *source, const char *path)
> > +{
> > +       GList *list;
> > +
> > +       for (list = g_list_first(source); list; list = g_list_next(list)) {
> > +               GDBusProxy *proxy = list->data;
> > +
> > +               if (strcmp(g_dbus_proxy_get_path(proxy), path) == 0)
> > +                       return proxy;
> > +       }
> > +
> > +       return NULL;
> > +}
> > +
> >  static GDBusProxy *find_proxy_by_address(GList *source, const char *address)
> >  {
> >         GList *list;
> > @@ -1650,6 +1681,35 @@ static void cmd_info(int argc, char *argv[])
> >         return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> >  }
> >
> > +static void cmd_battery(int argc, char *argv[])
> > +{
> > +       DBusMessageIter iter;
> > +       GDBusProxy *device_proxy;
> > +       GDBusProxy *battery_proxy;
> > +       unsigned char percentage;
> > +
> > +       device_proxy = find_device(argc, argv);
> > +       if (!device_proxy)
> > +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> > +
> > +       battery_proxy = find_battery_by_path(battery_proxies,
> > +                                       g_dbus_proxy_get_path(device_proxy));
> > +       if (!battery_proxy) {
> > +               bt_shell_printf("Device %s does not have battery information\n",
> > +                               argv[1]);
> > +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> > +       }
> > +
> > +       if (g_dbus_proxy_get_property(battery_proxy, "Percentage", &iter) ==
> > +                                                                       FALSE)
> > +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> > +
> > +       dbus_message_iter_get_basic(&iter, &percentage);
> > +       bt_shell_printf("Percentage: %d%%\n", percentage);
> > +
> > +       return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> > +}
> > +
> >  static void pair_reply(DBusMessage *message, void *user_data)
> >  {
> >         DBusError error;
> > @@ -2785,6 +2845,8 @@ static const struct bt_shell_menu main_menu = {
> >                                                         dev_generator },
> >         { "disconnect",   "[dev]",    cmd_disconn, "Disconnect device",
> >                                                         dev_generator },
> > +       { "battery",      "[dev]",    cmd_battery, "Show device battery",
> > +                                                       dev_generator },
> >         { } },
> >  };
> >
> > --
> > 2.26.2
> >
>
>
> --
> Luiz Augusto von Dentz
