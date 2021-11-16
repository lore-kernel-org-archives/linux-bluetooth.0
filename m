Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA45C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Nov 2021 10:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1A6B61AD2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Nov 2021 10:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbhKPKLL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Nov 2021 05:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbhKPKLJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Nov 2021 05:11:09 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E8FC061746
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Nov 2021 02:08:13 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d5so36456793wrc.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Nov 2021 02:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3hUFYka7hT4QTVxRXPUnxsQTJicYLbW9pJazItGrKBk=;
        b=I3ocltNdalspXZMjB9g+P7oDUkZ8SjYnM9rdhH8B2d90vfb5j6NmwmW/7aZzTVQA7u
         80iThgyAsHaStB+TXiqJSUtJxHQg0C2BLvsHjSIjKI00ocMHIioWb9pa40EQ77obNzsM
         Zd/veebYOC3GaeeRTQtf140yeXL4HpBUHvV3goieo6Ndrwiv2jBOleVRzS99c2kM/aa6
         Y7NqX3rKHSiWx9+rao+UQWadanSzVk35XeR8NDZdRjdiAiGqA8sbK6p6JNrdodT2boEc
         jiFT8bQt6CNIPhHkhYSkSbzU0wg2g7kCBheFCOtbfsW07OuW1tQu6ol5siEd6bP7tEUZ
         iuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3hUFYka7hT4QTVxRXPUnxsQTJicYLbW9pJazItGrKBk=;
        b=rWwhak8UeShgoBH4wvddfHpg9+2+tTax8IY/fKox7BCCApLNVj0YnD2CyNXdt9SR2j
         48jjDgPaub4AvXRurI9M0d0+bBm8Z3wIymHsinzD3ob8Gyzu1rZLfefLM6cmox6/wYxj
         WmmR4QfVjAM9dXi4JXElC0cIpIE4T/WWGa+is7Q2Jy42KiO11gyxyJ9A2Alccm6tVhnw
         jMb12r+G1RqlYJ3cfZDpRTjlzFPhYzZ+iCpW/lfIHTZuWKLWRidfu5g+He53FoxpiE4K
         maNSKhjb8MUeM4jkXyiZfe4oE9AUsTphij1gvQX5nPcZ14jOW1XtYtVEz+D55CdpHZ8z
         pgPA==
X-Gm-Message-State: AOAM530waVShAa6Fyc8wnvA6BJd2ef9Q52k8kf4Lpxnk+TIAfNbNQ58F
        ukPA/IzTPocM5GoTjFtrOPhGYPfQGr/xV+jY7QVQXA==
X-Google-Smtp-Source: ABdhPJzgQbcLxud/rD3vI60l7uS2dEtvlOSWnR+KrCgBqaICtfUBc0uB7vBNd/3QLIbykGJHeyL8XXXLzuog1QRX6ZU=
X-Received: by 2002:a5d:68ce:: with SMTP id p14mr7720724wrw.116.1637057291160;
 Tue, 16 Nov 2021 02:08:11 -0800 (PST)
MIME-Version: 1.0
References: <20211115172714.Bluez.v3.1.I9fc087b25433a9347b2d8c8ff7a25fadf448ef49@changeid>
 <CABBYNZJ+gnw_BCkLUaxQ5c6aViqcroWU1FuHnhK01=+m6Mwq3g@mail.gmail.com>
In-Reply-To: <CABBYNZJ+gnw_BCkLUaxQ5c6aViqcroWU1FuHnhK01=+m6Mwq3g@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Tue, 16 Nov 2021 18:08:03 +0800
Message-ID: <CAJQfnxGkeHRvLm+TMP_LPCxnj6tLuTNPCPzWVxrdZUDshJYrcQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v3 1/3] Listen and process remote name resolving failure
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Tue, 16 Nov 2021 at 07:50, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie,
>
> On Mon, Nov 15, 2021 at 1:27 AM Archie Pusaka <apusaka@google.com> wrote:
> >
> > From: Archie Pusaka <apusaka@chromium.org>
> >
> > When Remote Name Resolve ends with failure, record this occurrence and
> > prevent remote name resolving for the same device for some time.
> > Increase the time duration for subsequent failures.
> > ---
> > Hi maintainers,
> >
> > This is the patch series for remote name request as was discussed here.
> > https://patchwork.kernel.org/project/bluetooth/patch/20211028191805.1.I35b7f3a496f834de6b43a32f94b6160cb1467c94@changeid/
> > Please also review the corresponding kernel space change.
> >
> > Changes in v3:
> > * Rename MGMT const to align with the doc
> >
> > Changes in v2:
> > * Stay silent instead of sending MGMT_OP_CONFIRM_NAME with DONT_CARE flag.
> >
> >  lib/mgmt.h    |  1 +
> >  src/adapter.c | 15 +++++++++++++--
> >  src/device.c  | 23 +++++++++++++++++++++++
> >  src/device.h  |  2 ++
> >  4 files changed, 39 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/mgmt.h b/lib/mgmt.h
> > index 0d1678f01d..d860b27401 100644
> > --- a/lib/mgmt.h
> > +++ b/lib/mgmt.h
> > @@ -856,6 +856,7 @@ struct mgmt_ev_auth_failed {
> >  #define MGMT_DEV_FOUND_CONFIRM_NAME    0x01
> >  #define MGMT_DEV_FOUND_LEGACY_PAIRING  0x02
> >  #define MGMT_DEV_FOUND_NOT_CONNECTABLE 0x04
> > +#define MGMT_DEV_FOUND_NAME_REQUEST_FAILED 0x10
> >
> >  #define MGMT_EV_DEVICE_FOUND           0x0012
> >  struct mgmt_ev_device_found {
> > diff --git a/src/adapter.c b/src/adapter.c
> > index d0d38621b8..6100448b5f 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -6989,6 +6989,7 @@ static void update_found_devices(struct btd_adapter *adapter,
> >                                         uint8_t bdaddr_type, int8_t rssi,
> >                                         bool confirm, bool legacy,
> >                                         bool not_connectable,
> > +                                       bool name_resolve_failed,
> >                                         const uint8_t *data, uint8_t data_len)
> >  {
> >         struct btd_device *dev;
> > @@ -7081,6 +7082,9 @@ static void update_found_devices(struct btd_adapter *adapter,
> >
> >         device_set_legacy(dev, legacy);
> >
> > +       if (name_resolve_failed)
> > +               device_name_resolve_fail(dev);
> > +
> >         if (adapter->filtered_discovery)
> >                 device_set_rssi_with_delta(dev, rssi, 0);
> >         else
> > @@ -7151,7 +7155,10 @@ static void update_found_devices(struct btd_adapter *adapter,
> >         if (g_slist_find(adapter->discovery_found, dev))
> >                 return;
> >
> > -       if (confirm)
> > +       /* If name is unknown but it's not allowed to resolve, don't send
> > +        * MGMT_OP_CONFIRM_NAME.
> > +        */
> > +       if (confirm && (name_known || device_name_resolve_allowed(dev)))
> >                 confirm_name(adapter, bdaddr, bdaddr_type, name_known);
> >
> >         adapter->discovery_found = g_slist_prepend(adapter->discovery_found,
> > @@ -7201,6 +7208,8 @@ static void device_found_callback(uint16_t index, uint16_t length,
> >         uint32_t flags;
> >         bool confirm_name;
> >         bool legacy;
> > +       bool not_connectable;
> > +       bool name_resolve_failed;
> >         char addr[18];
> >
> >         if (length < sizeof(*ev)) {
> > @@ -7230,10 +7239,12 @@ static void device_found_callback(uint16_t index, uint16_t length,
> >
> >         confirm_name = (flags & MGMT_DEV_FOUND_CONFIRM_NAME);
> >         legacy = (flags & MGMT_DEV_FOUND_LEGACY_PAIRING);
> > +       not_connectable = (flags & MGMT_DEV_FOUND_NOT_CONNECTABLE);
> > +       name_resolve_failed = (flags & MGMT_DEV_FOUND_NAME_REQUEST_FAILED);
> >
> >         update_found_devices(adapter, &ev->addr.bdaddr, ev->addr.type,
> >                                         ev->rssi, confirm_name, legacy,
> > -                                       flags & MGMT_DEV_FOUND_NOT_CONNECTABLE,
> > +                                       not_connectable, name_resolve_failed,
> >                                         eir, eir_len);
> >  }
> >
> > diff --git a/src/device.c b/src/device.c
> > index fdc2d50a47..699faeba3b 100644
> > --- a/src/device.c
> > +++ b/src/device.c
> > @@ -79,6 +79,8 @@
> >  #define GATT_INCLUDE_UUID_STR "2802"
> >  #define GATT_CHARAC_UUID_STR "2803"
> >
> > +#define NAME_RESOLVE_RETRY_DELAY       120 /* seconds */
>
> I'd make this configurable since on headless systems it might be a
> good idea to have an option to disable the retrying logic.
>
Ack. Will be revised.

> >  static DBusConnection *dbus_conn = NULL;
> >  static unsigned service_state_cb_id;
> >
> > @@ -272,6 +274,9 @@ struct btd_device {
> >
> >         GIOChannel      *att_io;
> >         guint           store_id;
> > +
> > +       time_t          name_resolve_earliest_allow_time;
> > +       uint8_t         name_resolve_fail_count;
> >  };
> >
> >  static const uint16_t uuid_list[] = {
> > @@ -4361,6 +4366,24 @@ bool device_name_known(struct btd_device *device)
> >         return device->name[0] != '\0';
> >  }
> >
> > +bool device_name_resolve_allowed(struct btd_device *device)
> > +{
> > +       return time(NULL) >= device->name_resolve_earliest_allow_time;
> > +}
> > +
> > +void device_name_resolve_fail(struct btd_device *device)
> > +{
> > +       if (!device)
> > +               return;
> > +
> > +       /* Punish this device by not allowing name resolve for some time.
> > +        * increase punishment time for subsequent failures.
> > +        */
> > +       device->name_resolve_fail_count++;
> > +       device->name_resolve_earliest_allow_time = time(NULL) +
> > +               NAME_RESOLVE_RETRY_DELAY * device->name_resolve_fail_count;
>
> Like I said above we should probably make the number of retries and
> intervals configurable, have a look how it was done for reconnections
> in the policy plugin since I believe this would look very similar to
> that. Anyway we can't really use the system time as that can be
> modified causing jumps backward or forward in time so you must use
> CLOCK_MONOTONIC if you don't want it to be affected by system time
> changes.
>
Good point! Will be revised.

> The other possible solution would be not to have any retry logic since
> those device are likely to fail resolving their names on each retry,
> or we are doing this because we now properly abort the name
> resolution?
>
This might also be caused by the peer device suddenly losing power or
moving away, therefore is unresponsive to the name resolve request. As
such, I think it's important to retry at some point.

> > +}
> > +
> >  void device_set_class(struct btd_device *device, uint32_t class)
> >  {
> >         if (device->class == class)
> > diff --git a/src/device.h b/src/device.h
> > index 5f615cb4b6..76d79855f8 100644
> > --- a/src/device.h
> > +++ b/src/device.h
> > @@ -25,6 +25,8 @@ void btd_device_device_set_name(struct btd_device *device, const char *name);
> >  void device_store_cached_name(struct btd_device *dev, const char *name);
> >  void device_get_name(struct btd_device *device, char *name, size_t len);
> >  bool device_name_known(struct btd_device *device);
> > +bool device_name_resolve_allowed(struct btd_device *device);
> > +void device_name_resolve_fail(struct btd_device *device);
> >  void device_set_class(struct btd_device *device, uint32_t class);
> >  void device_update_addr(struct btd_device *device, const bdaddr_t *bdaddr,
> >                                                         uint8_t bdaddr_type);
> > --
> > 2.34.0.rc1.387.gb447b232ab-goog
> >
>
>
> --
> Luiz Augusto von Dentz

Thanks,
Archie
