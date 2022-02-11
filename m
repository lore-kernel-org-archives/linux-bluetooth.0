Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25578C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Feb 2022 05:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbiBKFMe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Feb 2022 00:12:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiBKFMb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Feb 2022 00:12:31 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A0E2651
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 21:12:30 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d27so13229696wrc.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 21:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jdIK2FXUTw0zgAqPGwlh0Unbbi9HK+v/BFspsvbakwc=;
        b=ZkIBYeWz1USza2E5JM/ovn6/iOTP/07JD1GaZJYvaFHmbJ5DZDpLeUxl2WXx9drpFj
         baCr0znBL/rBomaP11QZUOFCo3yLGRQJYuKmxyFTcuNXjoTT5Q5w6GUz2JTkk64fTH8A
         pB4CgSMjC1d1IIsxpO/jwU2JLjNxpLnbvhfUC/MpT/VdS+lTef8jNnPia5S+kGDTL06r
         hJGAv7tBPW2IwaRG4vOE/elFYxBauvsAthomF0PVTBCdKz/kEZHbU73JkjnmA+Wp+fVo
         stBT88nJZ8GEU5ITFM3LQeyFvawssJtGwnMEBmR8AGGf/CwFqj5ARXVgktXVAdrCHD6w
         tGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jdIK2FXUTw0zgAqPGwlh0Unbbi9HK+v/BFspsvbakwc=;
        b=DPoZYFbi3KR1pcv5skJQZvaEDckFZvgCPPOqGKPyUNuqrS8sb/ksNfy33LcQ7rNAK4
         1AcecNXBJFl3NdIEP/X4tv1AXeDZs+8Zf1t1zPjebbXMeBtRwrdn6dU7LBPKMobItxld
         2xzyOe4lf1P10QYc+ef3TFyGBPuWO933zLeblK7ckUJAXsYkUeZ6IzTitwVxhECjM+Z8
         1KmUVrwbKLIolkVlv63JgY83iV0W6gszDkLe0PiBW5soDaq9lFvrMAAnKBF53LpdjBGz
         9LDbRlJ9uRYnMIhou5e1bCIowGC3qeIW8E/8d5tRNv4aDJZq/csYP3K6IB/8Y8UHwKZO
         y8jw==
X-Gm-Message-State: AOAM533/66MwcA0trKHLNMDd/j9ofTvvoHQB7OEqJLWAtCmYwgXFLez/
        3H0uoZ9rf3+vK6BbBMZD204tLfWauId57BWAZFAhl3fJsOFTxg==
X-Google-Smtp-Source: ABdhPJz47kfjXF+rM3tKiOMojqZZbR93c1Dd917TLigAfCJ23hLAvDcGwsZSskcwTs2z//C8vBZJi4VpHcvM0qkso8w=
X-Received: by 2002:a5d:610f:: with SMTP id v15mr8498653wrt.602.1644556349103;
 Thu, 10 Feb 2022 21:12:29 -0800 (PST)
MIME-Version: 1.0
References: <20200915110347.Bluez.v3.1.If16fd16b4a629ec4d4093a974256225a95b58044@changeid>
 <CABBYNZKQhnQDaTQ_e-FA6hCEW5ZChaOdOQ-qCx3gpQXSPBD29g@mail.gmail.com>
 <CABBYNZJLdqu7WhdqGoH7HQry1enU=PkQXNBVonfiHwDbFpoVxw@mail.gmail.com>
 <CAJQfnxG-=cJoYoTwSvUOjDtdk5tx=F4XXWzLOOAo3oGsvcQovw@mail.gmail.com> <CABBYNZL4uv1eC4t+=zh9PouSdEU0sAo=3OX3B8B5MTYrcq7oHA@mail.gmail.com>
In-Reply-To: <CABBYNZL4uv1eC4t+=zh9PouSdEU0sAo=3OX3B8B5MTYrcq7oHA@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Fri, 11 Feb 2022 13:12:17 +0800
Message-ID: <CAJQfnxHHoD8sNi+B2S6NSKkk98=-0AubwTtCpBG41ZmWGLMZgA@mail.gmail.com>
Subject: Re: [Bluez PATCH v3] device: don't wait for timeout if RemoveDevice
 is called
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Fri, 11 Feb 2022 at 05:31, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie,
>
> On Tue, Feb 8, 2022 at 10:37 PM Archie Pusaka <apusaka@google.com> wrote:
> >
> > Hi Luiz,
> >
> > On Wed, 9 Feb 2022 at 10:39, Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Archie,
> > >
> > > On Tue, Sep 15, 2020 at 9:51 AM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Archie,
> > > >
> > > > On Mon, Sep 14, 2020 at 8:04 PM Archie Pusaka <apusaka@google.com> wrote:
> > > > >
> > > > > From: Archie Pusaka <apusaka@chromium.org>
> > > > >
> > > > > RemoveDevice on adapter interface used to remove a device, even when
> > > > > the device is connected. However, since the introduction of the new
> > > > > 30 seconds timeout when setting a device as temporary, RemoveDevice
> > > > > doesn't immediately remove a connected device, but only disconnects
> > > > > it and waits for the timer to expire before effectively removes it.
> > > > >
> > > > > This patch removes the device as soon as it gets disconnected,
> > > > > provided the disconnection is triggered by a call to RemoveDevice.
> > > > > The regular timeout still applies for other cases.
> > > > >
> > > > > Tested manually by calling RemoveDevice on a connected device,
> > > > > and with ChromeOS autotest setup.
> > > > >
> > > > > Reviewed-by: Daniel Winkler <danielwinkler@google.com>
> > > > > ---
> > > > >
> > > > > Changes in v3:
> > > > > * Rebasing again
> > > > >
> > > > > Changes in v2:
> > > > > * Rebasing to HEAD
> > > > >
> > > > >  src/adapter.c |  2 --
> > > > >  src/adapter.h |  2 ++
> > > > >  src/device.c  | 11 +++++++++++
> > > > >  3 files changed, 13 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/src/adapter.c b/src/adapter.c
> > > > > index df628a7fd..4e27bd74b 100644
> > > > > --- a/src/adapter.c
> > > > > +++ b/src/adapter.c
> > > > > @@ -80,8 +80,6 @@
> > > > >  #include "adv_monitor.h"
> > > > >  #include "eir.h"
> > > > >
> > > > > -#define ADAPTER_INTERFACE      "org.bluez.Adapter1"
> > > > > -
> > > > >  #define MODE_OFF               0x00
> > > > >  #define MODE_CONNECTABLE       0x01
> > > > >  #define MODE_DISCOVERABLE      0x02
> > > > > diff --git a/src/adapter.h b/src/adapter.h
> > > > > index c70a7b0da..2f1e4b737 100644
> > > > > --- a/src/adapter.h
> > > > > +++ b/src/adapter.h
> > > > > @@ -29,6 +29,8 @@
> > > > >  #include <lib/bluetooth.h>
> > > > >  #include <lib/sdp.h>
> > > > >
> > > > > +#define ADAPTER_INTERFACE      "org.bluez.Adapter1"
> > > > > +
> > > > >  #define MAX_NAME_LENGTH                248
> > > > >
> > > > >  /* Invalid SSP passkey value used to indicate negative replies */
> > > > > diff --git a/src/device.c b/src/device.c
> > > > > index 8f73ce4d3..3e7784034 100644
> > > > > --- a/src/device.c
> > > > > +++ b/src/device.c
> > > > > @@ -3007,6 +3007,7 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
> > > > >  {
> > > > >         struct bearer_state *state = get_state(device, bdaddr_type);
> > > > >         DBusMessage *reply;
> > > > > +       bool remove_device = false;
> > > > >
> > > > >         if (!state->connected)
> > > > >                 return;
> > > > > @@ -3036,6 +3037,10 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
> > > > >         while (device->disconnects) {
> > > > >                 DBusMessage *msg = device->disconnects->data;
> > > > >
> > > > > +               if (dbus_message_is_method_call(msg, ADAPTER_INTERFACE,
> > > > > +                                                               "RemoveDevice"))
> > > > > +                       remove_device = true;
> > > > > +
> > > > >                 g_dbus_send_reply(dbus_conn, msg, DBUS_TYPE_INVALID);
> > > > >                 device->disconnects = g_slist_remove(device->disconnects, msg);
> > > > >                 dbus_message_unref(msg);
> > > > > @@ -3061,6 +3066,9 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
> > > > >
> > > > >         g_dbus_emit_property_changed(dbus_conn, device->path,
> > > > >                                                 DEVICE_INTERFACE, "Connected");
> > > > > +
> > > > > +       if (remove_device)
> > > > > +               btd_adapter_remove_device(device->adapter, device);
> > >
> > > It looks like there are instances where device_remove_connection is
> > > called that can lead to the following trace:
> > >
> > > ==4030336== Invalid read of size 8
> > > ==4030336==    at 0x40B8A1: device_is_authenticating (device.c:6975)
> > > ==4030336==    by 0x3ABA2F: adapter_remove_connection (adapter.c:7166)
> > > ==4030336==    by 0x3C2A60: dev_disconnected (adapter.c:8123)
> > > ==4030336==    by 0x45C6B4: request_complete (mgmt.c:298)
> > > ==4030336==    by 0x45FF74: can_read_data (mgmt.c:390)
> > > ==4030336==    by 0x49B28F: watch_callback (io-glib.c:157)
> > > ==4030336==    by 0x495312F: g_main_context_dispatch (in
> > > /usr/lib64/libglib-2.0.so.0.7000.2)
> > > ==4030336==    by 0x49A8207: ??? (in /usr/lib64/libglib-2.0.so.0.7000.2)
> > > ==4030336==    by 0x4952852: g_main_loop_run (in
> > > /usr/lib64/libglib-2.0.so.0.7000.2)
> > > ==4030336==    by 0x49C814: mainloop_run (mainloop-glib.c:66)
> > > ==4030336==    by 0x49CD0B: mainloop_run_with_signal (mainloop-notify.c:188)
> > > ==4030336==    by 0x29B18B: main (main.c:1239)
> > > ==4030336==  Address 0x771bfe0 is 448 bytes inside a block of size 656 free'd
> > > ==4030336==    at 0x48440E4: free (vg_replace_malloc.c:872)
> > > ==4030336==    by 0x4954DAC: g_free (in /usr/lib64/libglib-2.0.so.0.7000.2)
> > > ==4030336==    by 0x44D166: remove_interface (object.c:660)
> > > ==4030336==    by 0x44DEDA: g_dbus_unregister_interface (object.c:1394)
> > > ==4030336==    by 0x3ABA27: adapter_remove_connection (adapter.c:7164)
> > > ==4030336==    by 0x3C2A60: dev_disconnected (adapter.c:8123)
> > > ==4030336==    by 0x45C6B4: request_complete (mgmt.c:298)
> > > ==4030336==    by 0x45FF74: can_read_data (mgmt.c:390)
> > > ==4030336==    by 0x49B28F: watch_callback (io-glib.c:157)
> > > ==4030336==    by 0x495312F: g_main_context_dispatch (in
> > > /usr/lib64/libglib-2.0.so.0.7000.2)
> > > ==4030336==    by 0x49A8207: ??? (in /usr/lib64/libglib-2.0.so.0.7000.2)
> > > ==4030336==    by 0x4952852: g_main_loop_run (in
> > > /usr/lib64/libglib-2.0.so.0.7000.2)
> > >
> > > So it appeared to be unsafe to call btd_adapter_remove_device, btw
> > > this happened when Ive attempted to pair 2 emulator instances
> > > (btvirt).
> >
> > Does this happen after calling Adapter1.RemoveDevice? I suppose if
> > that's true then adapter_remove_connection shouldn't have been called
> > since the device should have been removed at this point.
> > Perhaps I misunderstood your message?
>
> Looks like there are more people with the same problem:
>
> https://github.com/bluez/bluez/issues/290

Thanks for letting me know.
I see that you have submitted a fix and Tedd has verified it.
Strangely enough I cannot seem to repro it, nor do I understand how
that even happened.
>
> > > > >  }
> > > > >
> > > > >  guint device_add_disconnect_watch(struct btd_device *device,
> > > > > @@ -4482,6 +4490,9 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
> > > > >                 disconnect_all(device);
> > > > >         }
> > > > >
> > > > > +       if (device->temporary_timer > 0)
> > > > > +               g_source_remove(device->temporary_timer);
> > > > > +
> > > > >         if (device->store_id > 0) {
> > > > >                 g_source_remove(device->store_id);
> > > > >                 device->store_id = 0;
> > > > > --
> > > > > 2.28.0.618.gf4bc123cb7-goog
> > > > >
> > > >
> > > > Applied, thanks.
> > > >
> > > > --
> > > > Luiz Augusto von Dentz
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
> >
> > Thanks,
> > Archie
>
>
>
> --
> Luiz Augusto von Dentz

Regards,
Archie
