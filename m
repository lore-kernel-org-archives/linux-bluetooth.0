Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B47C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 19:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E24AB61175
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 19:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243853AbhKITqG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Nov 2021 14:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237907AbhKITqE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Nov 2021 14:46:04 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C8FC061764
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Nov 2021 11:43:18 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id b3so40843228uam.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Nov 2021 11:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dLW3FKwNRcw6X/ewgEn9wbsfnf+v9s0zmEJvSP58kGE=;
        b=ambZ1T3cXE0oRNb/G0erFw3jIU/H6KkSI8hDb0nudjGD4Ywa6WYz1tVeT/vpcGLJ4c
         AD/3ietghQy4+7bFMPcYtfkhw85hhiRhF0KWl7dknlKGZacDDhiCealoSIBxdI83lRLu
         xVKhyuZsSUkD3IlP57G0Bk0r3bhvbl1fo35nir5sRXaHcCDFkErAddgh5YtaZ6gwZYGk
         s0RtH3jqUCkFaOy25hmUzxW2QC1xrR5KcRNse65pNOQt6jZWGYjd+su3YFEmXiCgE0EC
         TJtRremHxutjvNFM+/JCxwR3Khxm2kQAH7URPIvQGLN/LH1UDe/1TA6MoDSx5vhyEfWi
         RvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dLW3FKwNRcw6X/ewgEn9wbsfnf+v9s0zmEJvSP58kGE=;
        b=eubxVO8zbXncB9evb0CcdIzfSez8JQZ9GuFQo0Sjb6S7OfGtB/BIKwo0qE+CkEjihH
         V3+JzqqpdlkN4aAbnMrAFhHxWAd7IaaDB0u3Vr/OxpNB21hNolcNabgZxppa3I5VGGN3
         fujX7nSgTHkSSqGdsJbKIc1s1YSMsqvT+5XoLC5WIbtUtb9M0yFZPwM4UWO0J+4PSnZY
         8GuNHnr3s0F4Tvi1OsALv5fWSwd0uh74VjNO90icwC99bVUO0LCiEgyfNE7Zcu8evWFf
         eYFgTy2Zyi3MH03uPFmYgNvTSt9PLg3wOPxvlLwNZAuZi4mfuaYRlWc3dDP1PEjOmBcr
         eUnA==
X-Gm-Message-State: AOAM532cBhnIYfmX89O/xAFjxiPM3r4SSWZerIVuUZboJsMBa/3gmkzc
        kjnJbJSbkM8p2nIWnbU4s4/nJMuA8tFZPhYY7pz20K03
X-Google-Smtp-Source: ABdhPJxe0tw7dZDrWD/VEFpI/91+HnOf8rhA9LSHirfUkQygb1dpSafEIWianS3B/qNGAZfPepZIy9n2FED+jywXYUo=
X-Received: by 2002:a05:6102:5109:: with SMTP id bm9mr28383728vsb.10.1636486997069;
 Tue, 09 Nov 2021 11:43:17 -0800 (PST)
MIME-Version: 1.0
References: <20211108191752.895782-1-luiz.dentz@gmail.com> <AM0PR07MB4131776DEB5C241B869CA071AF929@AM0PR07MB4131.eurprd07.prod.outlook.com>
In-Reply-To: <AM0PR07MB4131776DEB5C241B869CA071AF929@AM0PR07MB4131.eurprd07.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 9 Nov 2021 11:43:06 -0800
Message-ID: <CABBYNZ+q9xn5wHHUCMEDoy-WMBj3AHbJOXYtUnKbt3QM=ushsg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] client/gatt: Fix using atoi
To:     Thiemo van Engelen <tvanengelen@victronenergy.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Thiemo,

On Tue, Nov 9, 2021 at 12:04 AM Thiemo van Engelen
<tvanengelen@victronenergy.com> wrote:
>
> Hi Luiz,
>
> > -----Original Message-----
> > From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > Sent: maandag 8 november 2021 20:18
> > To: linux-bluetooth@vger.kernel.org
> > Subject: [PATCH BlueZ] client/gatt: Fix using atoi
> >
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > atoi doesn't support values entered in hexadecimal (0x...) which is likely the
> > prefered format for the likes of handles, etc, so this replaces the uses of atoi
> > with strtol.
> > ---
> >  client/gatt.c | 71 +++++++++++++++++++++++++++++++++++++++++++----
> > ----
> >  1 file changed, 60 insertions(+), 11 deletions(-)
> >
> > diff --git a/client/gatt.c b/client/gatt.c index 21fd38ecf..12e213d0f 100644
> > --- a/client/gatt.c
> > +++ b/client/gatt.c
> > @@ -650,19 +650,27 @@ static void read_attribute(GDBusProxy *proxy,
> > uint16_t offset)  void gatt_read_attribute(GDBusProxy *proxy, int argc, char
> > *argv[])  {
> >       const char *iface;
> > -     uint16_t offset = 0;
> > +     long offset = 0;
> >
> >       iface = g_dbus_proxy_get_interface(proxy);
> >       if (!strcmp(iface, "org.bluez.GattCharacteristic1") ||
> >                               !strcmp(iface, "org.bluez.GattDescriptor1")) {
> >
> > -             if (argc == 2)
> > -                     offset = atoi(argv[1]);
> > +             if (argc == 2) {
> > +                     char *endptr = NULL;
> > +
> > +                     offset = strtol(argv[1], &endptr, 0);
>
> Perhaps it is better to use strtoul and make offset an unsigned long or check for < 0 when C99 is not used as read_attribute takes it as a uint16_t?
> And from the naming of the other variables that are assigned using strtol I would guess more or less the same applies to those strtol calls.

Yep, I forgot about strtoul existed but you are right that for these
values we can definitely use it.

> > +                     if (!endptr || *endptr != '\0' || offset >
> > UINT16_MAX) {
> > +                             bt_shell_printf("Invalid offload: %s", argv[1]);
> > +                             goto done;
> > +                     }
> > +             }
> >
> >               read_attribute(proxy, offset);
> >               return;
> >       }
> >
> > +done:
> >       bt_shell_printf("Unable to read attribute %s\n",
> >
> >       g_dbus_proxy_get_path(proxy));
> >       return bt_shell_noninteractive_quit(EXIT_FAILURE);
> > @@ -805,8 +813,18 @@ void gatt_write_attribute(GDBusProxy *proxy, int
> > argc, char *argv[])
> >                               !strcmp(iface, "org.bluez.GattDescriptor1")) {
> >               data.iov.iov_base = str2bytearray(argv[1], &data.iov.iov_len);
> >
> > -             if (argc > 2)
> > -                     data.offset = atoi(argv[2]);
> > +             if (argc > 2) {
> > +                     char *endptr = NULL;
> > +                     long offset;
> > +
> > +                     offset = strtol(argv[1], &endptr, 0);
> > +                     if (!endptr || *endptr != '\0' || offset >
> > UINT16_MAX) {
> > +                             bt_shell_printf("Invalid offload: %s", argv[1]);
> > +                             goto fail;
> > +                     }
> > +
> > +                     data.offset = offset;
> > +             }
> >
> >               if (argc > 3)
> >                       data.type = argv[3];
> > @@ -815,6 +833,7 @@ void gatt_write_attribute(GDBusProxy *proxy, int
> > argc, char *argv[])
> >               return;
> >       }
> >
> > +fail:
> >       bt_shell_printf("Unable to write attribute %s\n",
> >
> >       g_dbus_proxy_get_path(proxy));
> >
> > @@ -1482,8 +1501,18 @@ void gatt_register_service(DBusConnection
> > *conn, GDBusProxy *proxy,
> >                                       g_list_length(local_services));
> >       service->primary = primary;
> >
> > -     if (argc > 2)
> > -             service->handle = atoi(argv[2]);
> > +     if (argc > 2) {
> > +             char *endptr = NULL;
> > +             long handle;
> > +
> > +             handle = strtol(argv[2], &endptr, 0);
> > +             if (!endptr || *endptr != '\0' || handle > UINT16_MAX) {
> > +                     bt_shell_printf("Invalid handle: %s", argv[2]);
> > +                     return bt_shell_noninteractive_quit(EXIT_FAILURE);
> > +             }
> > +
> > +             service->handle = handle;
> > +     }
> >
> >       if (g_dbus_register_interface(conn, service->path,
> >                                       SERVICE_INTERFACE, NULL, NULL,
> > @@ -2574,8 +2603,18 @@ void gatt_register_chrc(DBusConnection *conn,
> > GDBusProxy *proxy,
> >       chrc->flags = g_strsplit(argv[2], ",", -1);
> >       chrc->authorization_req = attr_authorization_flag_exists(chrc-
> > >flags);
> >
> > -     if (argc > 3)
> > -             chrc->handle = atoi(argv[3]);
> > +     if (argc > 3) {
> > +             char *endptr = NULL;
> > +             long handle;
> > +
> > +             handle = strtol(argv[3], &endptr, 0);
> > +             if (!endptr || *endptr != '\0' || handle > UINT16_MAX) {
> > +                     bt_shell_printf("Invalid handle: %s", argv[3]);
> > +                     return bt_shell_noninteractive_quit(EXIT_FAILURE);
> > +             }
> > +
> > +             chrc->handle = handle;
> > +     }
> >
> >       if (g_dbus_register_interface(conn, chrc->path, CHRC_INTERFACE,
> >                                       chrc_methods, NULL, chrc_properties,
> > @@ -2851,8 +2890,18 @@ void gatt_register_desc(DBusConnection *conn,
> > GDBusProxy *proxy,
> >                                       g_list_length(desc->chrc->descs));
> >       desc->flags = g_strsplit(argv[2], ",", -1);
> >
> > -     if (argc > 3)
> > -             desc->handle = atoi(argv[3]);
> > +     if (argc > 3) {
> > +             char *endptr = NULL;
> > +             long handle;
> > +
> > +             handle = strtol(argv[3], &endptr, 0);
> > +             if (!endptr || *endptr != '\0' || handle > UINT16_MAX) {
> > +                     bt_shell_printf("Invalid handle: %s", argv[3]);
> > +                     return bt_shell_noninteractive_quit(EXIT_FAILURE);
> > +             }
> > +
> > +             desc->handle = handle;
> > +     }
> >
> >       if (g_dbus_register_interface(conn, desc->path, DESC_INTERFACE,
> >                                       desc_methods, NULL,
> > desc_properties,
> > --
> > 2.31.1
>
> Kind regards,
> Thiemo



-- 
Luiz Augusto von Dentz
