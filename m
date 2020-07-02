Return-Path: <SRS0=k5tg=AN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C64C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jul 2020 00:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0366B20748
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jul 2020 00:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hh5EWPj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgGBAmy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Jul 2020 20:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgGBAmy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Jul 2020 20:42:54 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0E5C08C5C1
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2020 17:42:54 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id c25so5256329otf.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2020 17:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a78PilIjJ284t3pjU0eKTgB65feaSV48np4OSgKY6xQ=;
        b=Hh5EWPj0LcBmFJmCjl4R/KO9FvzAdSlJigL+UzHXmfQ40A22zNxq+ZvvCcIVp6vcUT
         9ehUbWjyJw9Wq72ZhWBOu74mksmAiaYffY7rPXIffNGLL1DVZhHCtGrHB6XXAHg+vJMm
         zJU/Et4Qu9C4pkAP0ioi1lGtl3k+sS/zb5utcYMgBN0LVh8BUrmr3lzHVEpXGJYqKC4S
         QqPNJGcff72/z9+3/rfI7il7au7fKGAYiX7Uft/8fMwdUmIDHhdGJ426eNfZpwq4kAJb
         GF7mRsMY3MlbI5Hl55bhezesggrOIPPaL4/ak4Osrj90ufIx0SLWh3Rjc0tOfNhMTics
         p5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a78PilIjJ284t3pjU0eKTgB65feaSV48np4OSgKY6xQ=;
        b=R7hVlGxINcXivhH3xHYzOn1ka7l5nQylusbR+i3bdkQGH/NgM8ve5YEGT6QzKfv6tu
         ahm4P2Dibb9ZZqiyaJ1ODpdCiEysI6BR4QhKDXl/CJfZqNoLYnzZHCMEFSXzJpFbRtEZ
         gQZ7uyxusMAy4HtjBnqjUQqs9bhp00nnUOD0msGnfgvd+K/nj25BsjZQe32I6WH6lSDz
         GV59CI3ezfrHWjOdSllJgVMq5rogd8gXwHX5Jn2evIp4ibUv7wCtXaoBQAiruNqy8l5d
         UJ4wiw7TeaIkxmOTn3R+lGI48uBEohfL6MEPAaj0A+fff/Jw7/qmQOU1zfg8r5Wxndl+
         I9jw==
X-Gm-Message-State: AOAM5337OEs9FcT/O1eJ1K/yznB/MqpKpi0FRuDrWEC4dKUuGCZN1hlY
        okjOGzGUlE9c316MuSHFsL6zzZWI0OBR7U8cBxE=
X-Google-Smtp-Source: ABdhPJzjyBRTgQ8nbUBWwFeJrv3lKvRaWsfXsyu2CUJC3/c04ehON9e4cwDlv6gqpTjMK9FDLz1cI1NSsLpFAPx7m84=
X-Received: by 2002:a9d:3da5:: with SMTP id l34mr24201819otc.88.1593650573420;
 Wed, 01 Jul 2020 17:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200630184629.95013-1-sonnysasaka@chromium.org>
 <CABBYNZKvKNhZeQ52sEE8uZYdrX9cBjM2Wh_BrOpZnkJUc5YcKQ@mail.gmail.com> <CAOxioNkiPA01Ztw6ugCyF8H-96raKW9o8am1D+qV8veWvkrakg@mail.gmail.com>
In-Reply-To: <CAOxioNkiPA01Ztw6ugCyF8H-96raKW9o8am1D+qV8veWvkrakg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 1 Jul 2020 17:42:41 -0700
Message-ID: <CABBYNZ+EY1VGQu0w3hvB1DfVFpxmPL6FP=JfCxmXckwp-Q+iKw@mail.gmail.com>
Subject: Re: [PATCH v2] client: Add battery command
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Wed, Jul 1, 2020 at 12:23 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> Hi Luiz,
>
> I thought of doing that (combining with info command). But we foresee
> that the Battery API will get more complex (such as support of
> multiple batteries like Pixel Buds and Airpods) and deserve its own
> command. Furthermore, it's a different API (org.bluez.Device1 vs
> org.bluez.Battery1) and its inner working uses a specific profile (BAS
> over GATT), so I think that it deserves its own command. But anyway I
> sent another patch that combines this into the "info" command and if
> you think this is more appropriate we can combine it for now and
> separate it in the future when needed.

It should be a problem to combine different interfaces, and if the
Battery1 start to have more properties we just list them as well, our
D-Bus client will have them cached anything since we do get the
properties of all interface due to use of ObjectManager.

>
> On Wed, Jul 1, 2020 at 10:56 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Sonny,
> >
> > On Tue, Jun 30, 2020 at 1:48 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> > >
> > > This adds the "battery" command to show battery information of a peer
> > > device based on org.bluez.Battery1 API. Example usage:
> > >
> > > [bluetooth]# battery XX:XX:XX:XX:XX:XX
> > > Percentage: 100%
> >
> > It might be better to put the battery level under info command.
> >
> > > ---
> > >  client/main.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 62 insertions(+)
> > >
> > > diff --git a/client/main.c b/client/main.c
> > > index 422da5593..8c1ed00fb 100644
> > > --- a/client/main.c
> > > +++ b/client/main.c
> > > @@ -65,6 +65,7 @@ static struct adapter *default_ctrl;
> > >  static GDBusProxy *default_dev;
> > >  static GDBusProxy *default_attr;
> > >  static GList *ctrl_list;
> > > +static GList *battery_proxies;
> > >
> > >  static const char *agent_arguments[] = {
> > >         "on",
> > > @@ -107,7 +108,9 @@ static void disconnect_handler(DBusConnection *connection, void *user_data)
> > >         bt_shell_set_prompt(PROMPT_OFF);
> > >
> > >         g_list_free_full(ctrl_list, proxy_leak);
> > > +       g_list_free_full(battery_proxies, proxy_leak);
> > >         ctrl_list = NULL;
> > > +       battery_proxies = NULL;
> > >
> > >         default_ctrl = NULL;
> > >  }
> > > @@ -445,6 +448,16 @@ done:
> > >         g_free(desc);
> > >  }
> > >
> > > +static void battery_added(GDBusProxy *proxy)
> > > +{
> > > +       battery_proxies = g_list_append(battery_proxies, proxy);
> > > +}
> > > +
> > > +static void battery_removed(GDBusProxy *proxy)
> > > +{
> > > +       battery_proxies = g_list_remove(battery_proxies, proxy);
> > > +}
> > > +
> > >  static void device_added(GDBusProxy *proxy)
> > >  {
> > >         DBusMessageIter iter;
> > > @@ -539,6 +552,8 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
> > >                 gatt_add_manager(proxy);
> > >         } else if (!strcmp(interface, "org.bluez.LEAdvertisingManager1")) {
> > >                 ad_manager_added(proxy);
> > > +       } else if (!strcmp(interface, "org.bluez.Battery1")) {
> > > +               battery_added(proxy);
> > >         }
> > >  }
> > >
> > > @@ -630,6 +645,8 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
> > >                 gatt_remove_manager(proxy);
> > >         } else if (!strcmp(interface, "org.bluez.LEAdvertisingManager1")) {
> > >                 ad_unregister(dbus_conn, NULL);
> > > +       } else if (!strcmp(interface, "org.bluez.Battery1")) {
> > > +               battery_removed(proxy);
> > >         }
> > >  }
> > >
> > > @@ -763,6 +780,20 @@ static struct adapter *find_ctrl_by_address(GList *source, const char *address)
> > >         return NULL;
> > >  }
> > >
> > > +static GDBusProxy *find_battery_by_path(GList *source, const char *path)
> > > +{
> > > +       GList *list;
> > > +
> > > +       for (list = g_list_first(source); list; list = g_list_next(list)) {
> > > +               GDBusProxy *proxy = list->data;
> > > +
> > > +               if (strcmp(g_dbus_proxy_get_path(proxy), path) == 0)
> > > +                       return proxy;
> > > +       }
> > > +
> > > +       return NULL;
> > > +}
> > > +
> > >  static GDBusProxy *find_proxy_by_address(GList *source, const char *address)
> > >  {
> > >         GList *list;
> > > @@ -1650,6 +1681,35 @@ static void cmd_info(int argc, char *argv[])
> > >         return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> > >  }
> > >
> > > +static void cmd_battery(int argc, char *argv[])
> > > +{
> > > +       DBusMessageIter iter;
> > > +       GDBusProxy *device_proxy;
> > > +       GDBusProxy *battery_proxy;
> > > +       unsigned char percentage;
> > > +
> > > +       device_proxy = find_device(argc, argv);
> > > +       if (!device_proxy)
> > > +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> > > +
> > > +       battery_proxy = find_battery_by_path(battery_proxies,
> > > +                                       g_dbus_proxy_get_path(device_proxy));
> > > +       if (!battery_proxy) {
> > > +               bt_shell_printf("Device %s does not have battery information\n",
> > > +                               argv[1]);
> > > +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> > > +       }
> > > +
> > > +       if (g_dbus_proxy_get_property(battery_proxy, "Percentage", &iter) ==
> > > +                                                                       FALSE)
> > > +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> > > +
> > > +       dbus_message_iter_get_basic(&iter, &percentage);
> > > +       bt_shell_printf("Percentage: %d%%\n", percentage);
> > > +
> > > +       return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> > > +}
> > > +
> > >  static void pair_reply(DBusMessage *message, void *user_data)
> > >  {
> > >         DBusError error;
> > > @@ -2785,6 +2845,8 @@ static const struct bt_shell_menu main_menu = {
> > >                                                         dev_generator },
> > >         { "disconnect",   "[dev]",    cmd_disconn, "Disconnect device",
> > >                                                         dev_generator },
> > > +       { "battery",      "[dev]",    cmd_battery, "Show device battery",
> > > +                                                       dev_generator },
> > >         { } },
> > >  };
> > >
> > > --
> > > 2.26.2
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
