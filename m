Return-Path: <SRS0=k5tg=AN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACB2C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jul 2020 15:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 334C2208B8
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jul 2020 15:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mn9sqSRj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbgGBPnE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgGBPnD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jul 2020 11:43:03 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C552C08C5C1
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2020 08:43:03 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g37so715400otb.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2020 08:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wacwb6gdlVm4ErQQEHazoKnIUKGvN0uOle2VWL6Ms4E=;
        b=mn9sqSRjZ4t8Ol5Dr/3tVs9e8IIWHTvavbBa6p1ZnP7kF6kjbSkOC4Ccnu1u47y81U
         Ppr344czHUSkpMNKfFtX9e8MZsQa2I1wgD3BwLVVC4H3Mz2T9gePqc3bzkDi/p05s9Cv
         Du2N9JdnARhUAkN+QAMOB8LgwcBNR076rNMbEVA2Sgpn+kQbzIEg2umhOC4pxQXl0rA2
         rhc2SKUlFvT3EOV++GyvCmUgaHDZd87RO11siv/vFTiS04HL7KUOqG8k/NAZWWCg0GJK
         Pt6Y+JyAs2dkxKb9aLgbcOLGAJz8ao3BV2+jyrxRtHzmTg7zk+iYYwFUM7dA78C0eCm3
         Kpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wacwb6gdlVm4ErQQEHazoKnIUKGvN0uOle2VWL6Ms4E=;
        b=j4WeUUQjdLHT1o4oZkM/TgrUmG3CsDHQc1tpm5cN1PeXOgDUanPW1GOurHvTD0XbFf
         N4CwgQZUBWwNxIs9f1eS0YWHyIrQC1XDEVQRAiURfddiHxgI2UhCfAN+XA0g73Kixrgu
         uU8V7kBnzTSQ+pyljN3jefgR02AvUP86KCDz/NZOcbbvqc5+0GuSz9+bMZZNuzYGFiBx
         US4XEuOPJE5+ylUOWV7ex2Zp7QPPdMAHYj1ykN/xy6a2Vld+UaJ4MSYfnteQWGcU0N/b
         wiOX+JxbGKncyd3lOI41vK3Q7RKG3OA+t3m88KUhALptTFvmxW7vFzLcEV7K1tUOLLtT
         wYrA==
X-Gm-Message-State: AOAM531kuJIdkjgB35ogh307NYCls/ubw+lyS32oxBNdfLizwswlGzif
        QhSPAr+o43FvAOv+hcBhuxCQ7gi4sjXZTDdPuxM=
X-Google-Smtp-Source: ABdhPJwgkTuQNDmuPh/0Bn8rVx5kEK4inahJY18zg8r8VIxIctYsH2x19jGSyEc0k3gjl2L+YsvoC9ckr5v6FtTPf7g=
X-Received: by 2002:a9d:3da5:: with SMTP id l34mr26580484otc.88.1593704582694;
 Thu, 02 Jul 2020 08:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200701192202.9508-1-sonnysasaka@chromium.org>
 <CABBYNZKsM52hLuNEYSqhHoiMXE5Kix_pp6AoCJeJ4rd6f-NyWg@mail.gmail.com> <CAOxioN=0s1XebO6qg_kohi=s8Q8DkP6GXdqqqGL17QK2e=Dg4w@mail.gmail.com>
In-Reply-To: <CAOxioN=0s1XebO6qg_kohi=s8Q8DkP6GXdqqqGL17QK2e=Dg4w@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 2 Jul 2020 08:42:50 -0700
Message-ID: <CABBYNZK5SyZL6mx0D2dtRqz1P7m6+JZSBXMP-xRKjNBngf-oaA@mail.gmail.com>
Subject: Re: [PATCH v2] client: Add battery percentage to info command
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Wed, Jul 1, 2020 at 11:06 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> Hi Luiz,
>
> On Wed, Jul 1, 2020 at 10:20 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Sonny,
> >
> > On Wed, Jul 1, 2020 at 12:24 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> > >
> > > This adds the Battery Percentage to the info command based on
> > > org.bluez.Battery1 API. Example usage:
> > >
> > > [bluetooth]# info XX:XX:XX:XX:XX:XX
> > > Device XX:XX:XX:XX:XX:XX (random)
> > >         Name: ...
> > >         Alias: ...
> > >         ...
> > >         Modalias: ...
> > >         Battery Percentage: 100%
> > > ---
> > >  client/main.c | 43 +++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 43 insertions(+)
> > >
> > > diff --git a/client/main.c b/client/main.c
> > > index 422da5593..4b787240e 100644
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
> > > @@ -1606,8 +1637,10 @@ static struct GDBusProxy *find_device(int argc, char *argv[])
> > >  static void cmd_info(int argc, char *argv[])
> > >  {
> > >         GDBusProxy *proxy;
> > > +       GDBusProxy *battery_proxy;
> > >         DBusMessageIter iter;
> > >         const char *address;
> > > +       unsigned char percentage;
> > >
> > >         proxy = find_device(argc, argv);
> > >         if (!proxy)
> > > @@ -1647,6 +1680,16 @@ static void cmd_info(int argc, char *argv[])
> > >         print_property(proxy, "AdvertisingFlags");
> > >         print_property(proxy, "AdvertisingData");
> > >
> > > +       battery_proxy = find_battery_by_path(battery_proxies,
> > > +                                       g_dbus_proxy_get_path(proxy));
> >
> > I'd replace the lines below with just print_property(battery_proxy,
> > "Percentage"); and just make print_property check for NULL proxy if it
> > doesn't already.
> I tried this but the result doesn't look quite good:
> Device XX:XX:XX:XX:XX:XX (random)
>         Name: ...
>         ...
>         Modalias: ...
>         Percentage: 0x64
>
> The name "Percentage" is not clear (what kind of percentage does it
> mean) when shown in the "info" command. And also the format for byte
> data type is hex and there is no percent sign. I tried to modify the
> print_property function to support custom format but the code gets
> overly complex and I think it's more straightforward to use custom
> logic like in this patch.

Just make it always print both the decimal and (hex).

> >
> > > +       if (battery_proxy && g_dbus_proxy_get_property(
> > > +                               battery_proxy, "Percentage", &iter)) {
> > > +               dbus_message_iter_get_basic(&iter, &percentage);
> > > +               bt_shell_printf("\tBattery Percentage: %d%%\n", percentage);
> > > +       } else {
> > > +               bt_shell_printf("\tNo battery information\n");
> > > +       }
> > > +
> > >         return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> > >  }
> > >
> > > --
> > > 2.17.1
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
