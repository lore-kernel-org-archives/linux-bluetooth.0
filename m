Return-Path: <SRS0=HAk7=CK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3923AC433E6
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 03:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13ECA20719
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 03:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RrcDNVss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgIAD1n (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Aug 2020 23:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgIAD1n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Aug 2020 23:27:43 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41C0C0612FE
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 20:27:42 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z4so5108073wrr.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 20:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZvfKyEsORwjIi8Yl5iGwTWA+U3ccsHL5F+yZy/hSxPw=;
        b=RrcDNVssnho0vBsBCKwwxwcJBfhzSwYsyywgx8lNjBbSsKSlsDvdU+g256ZAt2kWAp
         JmlX9IlKjyve0AxaSLOOuQYSx1hVJPpy2n+93dPZmtUF3zgbo6oKjYSwP5RRNtLcddM4
         rVh58ydGaFziufBNcRuxDqLpIJhF0AecqeISBQ6S/tv6s9AFoETuPSl2LnUND+3C3/CG
         AWY5OckL2jHXWliFtv7zQaxwAb39FHy0cAJpVLEisaiiIZlVnePbYxKFh7YXkZeIJeFs
         A5bWFUPD99nJSJkSIp//Y/akFCqvOWBObSB1YmqaIkb1hGoHfCma4rRJNTcsjqcVAO19
         Khow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZvfKyEsORwjIi8Yl5iGwTWA+U3ccsHL5F+yZy/hSxPw=;
        b=Mj/j8NrtieeuexeV/FDhParju+3TBLSKicNpWs8IgWOUZIAH035K4fDR8k4mULEcMe
         R4/AgAKRSNOqXJk3u8G4a1lExVM62Zv6BomRHrgUcTTscl1FIIgSYHg6cfy0GnY7h646
         WOFWzxpaOQ+gZcjdU8T7+rNjKQ1CN6uYE0sOjRbnG4tAg8SM4Bfg67EetSuTwcmnIN8x
         n7DDeCyl1URFYS05Xit+IY1bFbiV0nzcy4f5wCSuituW1t0iE6baATPGc0b7h1Dtyt/K
         treawiy1i/tEw21J/2KEIT2/LS+wyUugH6DwCTlw43HEnfimz7kHDgkHX1Hztdg7XEbx
         417w==
X-Gm-Message-State: AOAM532JWFAlliOcQKfuWhIGInzp2FL8rs1Vin/7nmw/cHM6q3biHM+D
        wbxQtHZR/bRMzHQQGqebhe7KXGB5yXP7+RAtarlYfg==
X-Google-Smtp-Source: ABdhPJx7hptAE0c5dIBJ1XR8jdj5DYtW53Fr1l80ug398v5yGkFZPqGpI/RhlREkD321OQT9BTo2BQcdT3fpV7CChuk=
X-Received: by 2002:adf:fa0c:: with SMTP id m12mr4175001wrr.406.1598930861037;
 Mon, 31 Aug 2020 20:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200831161140.Bluez.v1.1.If16fd16b4a629ec4d4093a974256225a95b58044@changeid>
 <CABBYNZLTY_cFcttmMdiBH7PNU1xT2bw-eKnOQkHDak3+Y8WrXQ@mail.gmail.com>
In-Reply-To: <CABBYNZLTY_cFcttmMdiBH7PNU1xT2bw-eKnOQkHDak3+Y8WrXQ@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Tue, 1 Sep 2020 11:27:30 +0800
Message-ID: <CAJQfnxH2hcAtLOCd4MywT+ydzTchGX7S+7Vb+b3vgmDvEQ6GHA@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] device: don't wait for timeout if RemoveDevice
 is called
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Tue, 1 Sep 2020 at 01:35, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie,
>
> On Mon, Aug 31, 2020 at 1:12 AM Archie Pusaka <apusaka@google.com> wrote:
> >
> > From: Archie Pusaka <apusaka@chromium.org>
> >
> > RemoveDevice on adapter interface used to remove a device, even when
> > the device is connected. However, since the introduction of the new
> > 30 seconds timeout when setting a device as temporary, RemoveDevice
> > doesn't immediately remove a connected device, but only disconnects
> > it and waits for the timer to expire before effectively removes it.
> >
> > This patch removes the device as soon as it gets disconnected,
> > provided the disconnection is triggered by a call to RemoveDevice.
> > The regular timeout still applies for other cases.
> >
> > Tested manually by calling RemoveDevice on a connected device,
> > and with ChromeOS autotest setup.
> >
> > Reviewed-by: Daniel Winkler <danielwinkler@google.com>
> > ---
> >
> >  src/adapter.c |  2 --
> >  src/adapter.h |  2 ++
> >  src/device.c  | 11 +++++++++++
> >  3 files changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/src/adapter.c b/src/adapter.c
> > index 5e896a9f0..d6c65ff69 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -79,8 +79,6 @@
> >  #include "advertising.h"
> >  #include "eir.h"
> >
> > -#define ADAPTER_INTERFACE      "org.bluez.Adapter1"
> > -
> >  #define MODE_OFF               0x00
> >  #define MODE_CONNECTABLE       0x01
> >  #define MODE_DISCOVERABLE      0x02
> > diff --git a/src/adapter.h b/src/adapter.h
> > index f8ac20261..f835c984f 100644
> > --- a/src/adapter.h
> > +++ b/src/adapter.h
> > @@ -26,6 +26,8 @@
> >  #include <dbus/dbus.h>
> >  #include <glib.h>
> >
> > +#define ADAPTER_INTERFACE      "org.bluez.Adapter1"
> > +
> >  #define MAX_NAME_LENGTH                248
> >
> >  /* Invalid SSP passkey value used to indicate negative replies */
> > diff --git a/src/device.c b/src/device.c
> > index bb8e07e8f..cee0ddfd2 100644
> > --- a/src/device.c
> > +++ b/src/device.c
> > @@ -3001,6 +3001,7 @@ void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type)
> >  void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
> >  {
> >         struct bearer_state *state = get_state(device, bdaddr_type);
> > +       bool remove_device = false;
> >
> >         if (!state->connected)
> >                 return;
> > @@ -3018,6 +3019,10 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
> >         while (device->disconnects) {
> >                 DBusMessage *msg = device->disconnects->data;
> >
> > +               if (dbus_message_is_method_call(msg, ADAPTER_INTERFACE,
> > +                                                               "RemoveDevice"))
> > +                       remove_device = true;
> > +
> >                 g_dbus_send_reply(dbus_conn, msg, DBUS_TYPE_INVALID);
> >                 device->disconnects = g_slist_remove(device->disconnects, msg);
> >                 dbus_message_unref(msg);
> > @@ -3043,6 +3048,9 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
> >
> >         g_dbus_emit_property_changed(dbus_conn, device->path,
> >                                                 DEVICE_INTERFACE, "Connected");
> > +
> > +       if (remove_device)
> > +               btd_adapter_remove_device(device->adapter, device);
> >  }
> >
> >  guint device_add_disconnect_watch(struct btd_device *device,
> > @@ -4457,6 +4465,9 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
> >                 disconnect_all(device);
> >         }
> >
> > +       if (device->temporary_timer > 0)
> > +               g_source_remove(device->temporary_timer);
> > +
> >         if (device->store_id > 0) {
> >                 g_source_remove(device->store_id);
> >                 device->store_id = 0;
> > --
> > 2.28.0.402.g5ffc5be6b7-goog
>
> Does not apply:
>
> Applying: device: don't wait for timeout if RemoveDevice is called
> error: patch failed: src/device.c:3001
> error: src/device.c: patch does not apply

Oops, let me rebase and resubmit.

>
>
>
> --
> Luiz Augusto von Dentz

Thanks,
Archie
