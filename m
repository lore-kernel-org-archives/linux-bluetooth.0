Return-Path: <SRS0=2FZ9=CU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FC3C43461
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Sep 2020 02:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D972A20829
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Sep 2020 02:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I9oWkBTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725300AbgIKC5d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Sep 2020 22:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgIKC53 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Sep 2020 22:57:29 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D931C061756
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2020 19:57:27 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o5so9875695wrn.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2020 19:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NV4ByKEQVi2N8GtAg0l18wtkd1/SUu1feziU5QiC7tw=;
        b=I9oWkBTRMAwO+G7Sm3zSbQVj8KOsuBdm8i7siYrmWqrGplYlVsYS1NVrOIdt5Wx38a
         he3xW79HtZiVYvj3I/jQkZjZMnrtRjwMG8hKF3AoYOazZpIhsRBsmIE5PYa433u7WG/E
         cjPad7bO8XIdUWpDeZGFtuZiXZQxL2O7H2/8eHZqvo/74J9yPaFLpRBn+SwQl7uLT94d
         01XQVWKhSnT2dQjWW2ZEjRM3gD9Q7kT0XGBP7f38FSPqY2NES2sKXJktH1GgXqOtUV2S
         kQq97J2uMKCGMGhcowsfkmKjuZT2G6jOn0OWAqyDCM2U+K3bjGJqRGAvdG/e+ncL46JD
         ZhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NV4ByKEQVi2N8GtAg0l18wtkd1/SUu1feziU5QiC7tw=;
        b=UWsnaDQEZdjBfZWRAkGevj6utIPFBkVpUywscgpU2c/3U8QFCwL7JwNSud3hCuBdOi
         ptiscpn73gP/cKz/OfeLt0cDtQ8rfgWy+VC2PvgU1/RBl+vAk5ME+eeJX6GbI6w0Vbe7
         Z9NTOB70KrCbyiFrqn3E4QiFNXL3RE14N+lLo5zurWRHDsEUXFiT2CVlZ1tSXrtEcLLv
         bU8nCnss60bEtjFq+dUnMGmhbM8od8kZg/XgnB+H7/dHbqjeuCrt/TsdpZ+86NXKMIr3
         KCUMXvXOFU56vfb0WhSv7fL6OVmq8i3auE78w/Ik8qphAOYm5FalgFybIXvKjjthYs5s
         FOjg==
X-Gm-Message-State: AOAM531c9iIv53Z/ykbyAxOE0JLSAlsZ8mxlNp95qt2aA/Dzch9zEuok
        OeXwIic2Q2pLRa+4UWapuSia0sjJa3NiPbVnz0s82Egh9N6ytw==
X-Google-Smtp-Source: ABdhPJwv5JLpgBUdapgQr5lqqYC/NgaxhHxyEyJXLrnfc1JM4trqdB1LnrH0b5/pAuSU4Fv1zffCPbw0SrOx0Oy3Sx8=
X-Received: by 2002:adf:fa0c:: with SMTP id m12mr11610778wrr.406.1599793046194;
 Thu, 10 Sep 2020 19:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200901113736.Bluez.v2.1.If16fd16b4a629ec4d4093a974256225a95b58044@changeid>
 <CAJQfnxEopr6GzSsjbq4wQaWaw9QZDu_hmZMJF9_bS7i4nU5owQ@mail.gmail.com> <CAJQfnxFyLR_rbZPt_ag68SSp7M1LkZ=0L2dZ-XP5ZZ-fwTEMrw@mail.gmail.com>
In-Reply-To: <CAJQfnxFyLR_rbZPt_ag68SSp7M1LkZ=0L2dZ-XP5ZZ-fwTEMrw@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Fri, 11 Sep 2020 10:57:14 +0800
Message-ID: <CAJQfnxG7oiLviJ0pgG1Fh314rYzey1TOj5MUeVayKRTLnH73KA@mail.gmail.com>
Subject: Re: [Bluez PATCH v2] device: don't wait for timeout if RemoveDevice
 is called
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bluez maintainers,

May I bother you to review this patch?

Thanks,
Archie


On Fri, 11 Sep 2020 at 10:56, Archie Pusaka <apusaka@google.com> wrote:
>
> Hi Bluez maintainers,
>
> May I bother you to review this patch?
>
> Thanks,
> Archie
>
> On Mon, 7 Sep 2020 at 10:38, Archie Pusaka <apusaka@google.com> wrote:
>>
>> Hi Bluez maintainers,
>>
>> Could you take another look at this patch?
>>
>> Thanks,
>> Archie
>>
>> On Tue, 1 Sep 2020 at 11:37, Archie Pusaka <apusaka@google.com> wrote:
>> >
>> > From: Archie Pusaka <apusaka@chromium.org>
>> >
>> > RemoveDevice on adapter interface used to remove a device, even when
>> > the device is connected. However, since the introduction of the new
>> > 30 seconds timeout when setting a device as temporary, RemoveDevice
>> > doesn't immediately remove a connected device, but only disconnects
>> > it and waits for the timer to expire before effectively removes it.
>> >
>> > This patch removes the device as soon as it gets disconnected,
>> > provided the disconnection is triggered by a call to RemoveDevice.
>> > The regular timeout still applies for other cases.
>> >
>> > Tested manually by calling RemoveDevice on a connected device,
>> > and with ChromeOS autotest setup.
>> >
>> > Reviewed-by: Daniel Winkler <danielwinkler@google.com>
>> >
>> > Signed-off-by: Archie Pusaka <apusaka@chromium.org>
>> > ---
>> >
>> > Changes in v2:
>> > * Rebasing to HEAD
>> >
>> >  src/adapter.c |  2 --
>> >  src/adapter.h |  2 ++
>> >  src/device.c  | 11 +++++++++++
>> >  3 files changed, 13 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/src/adapter.c b/src/adapter.c
>> > index 1435e2bd7..ffd05aa0b 100644
>> > --- a/src/adapter.c
>> > +++ b/src/adapter.c
>> > @@ -79,8 +79,6 @@
>> >  #include "advertising.h"
>> >  #include "eir.h"
>> >
>> > -#define ADAPTER_INTERFACE      "org.bluez.Adapter1"
>> > -
>> >  #define MODE_OFF               0x00
>> >  #define MODE_CONNECTABLE       0x01
>> >  #define MODE_DISCOVERABLE      0x02
>> > diff --git a/src/adapter.h b/src/adapter.h
>> > index f8ac20261..f835c984f 100644
>> > --- a/src/adapter.h
>> > +++ b/src/adapter.h
>> > @@ -26,6 +26,8 @@
>> >  #include <dbus/dbus.h>
>> >  #include <glib.h>
>> >
>> > +#define ADAPTER_INTERFACE      "org.bluez.Adapter1"
>> > +
>> >  #define MAX_NAME_LENGTH                248
>> >
>> >  /* Invalid SSP passkey value used to indicate negative replies */
>> > diff --git a/src/device.c b/src/device.c
>> > index df440ce09..f20270017 100644
>> > --- a/src/device.c
>> > +++ b/src/device.c
>> > @@ -3007,6 +3007,7 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
>> >  {
>> >         struct bearer_state *state = get_state(device, bdaddr_type);
>> >         DBusMessage *reply;
>> > +       bool remove_device = false;
>> >
>> >         if (!state->connected)
>> >                 return;
>> > @@ -3036,6 +3037,10 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
>> >         while (device->disconnects) {
>> >                 DBusMessage *msg = device->disconnects->data;
>> >
>> > +               if (dbus_message_is_method_call(msg, ADAPTER_INTERFACE,
>> > +                                                               "RemoveDevice"))
>> > +                       remove_device = true;
>> > +
>> >                 g_dbus_send_reply(dbus_conn, msg, DBUS_TYPE_INVALID);
>> >                 device->disconnects = g_slist_remove(device->disconnects, msg);
>> >                 dbus_message_unref(msg);
>> > @@ -3061,6 +3066,9 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
>> >
>> >         g_dbus_emit_property_changed(dbus_conn, device->path,
>> >                                                 DEVICE_INTERFACE, "Connected");
>> > +
>> > +       if (remove_device)
>> > +               btd_adapter_remove_device(device->adapter, device);
>> >  }
>> >
>> >  guint device_add_disconnect_watch(struct btd_device *device,
>> > @@ -4477,6 +4485,9 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
>> >                 disconnect_all(device);
>> >         }
>> >
>> > +       if (device->temporary_timer > 0)
>> > +               g_source_remove(device->temporary_timer);
>> > +
>> >         if (device->store_id > 0) {
>> >                 g_source_remove(device->store_id);
>> >                 device->store_id = 0;
>> > --
>> > 2.28.0.402.g5ffc5be6b7-goog
>> >
