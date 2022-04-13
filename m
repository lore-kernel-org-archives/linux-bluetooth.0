Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD1CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Apr 2022 22:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbiDMWpR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Apr 2022 18:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiDMWpR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Apr 2022 18:45:17 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3212057489
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Apr 2022 15:42:54 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id p65so6324849ybp.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Apr 2022 15:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZN9DgpFpqXDn+wgxeMIYb4vito0Ia8RAXB7EhQWlCEo=;
        b=iR7LI8Om+QMgA5EjvGyXNWY/m4wsQEi19MuQIec5wErnK1tDvaZNWwC1zAo9k5xZqr
         pkia63hUShtzUt3iwMbi9rkysJzPCwT086JjBObKKLbNh8tz8wxWxWs1ARkvBjqAZzYB
         xNKY1Dg4IPKlcRGRMWHw9jDiOaAraX8O0UfJTKhmh2wZgtqrlorI2pxs9j/tG+/j4fKN
         REF8oELTG9+d6IPchCE7K0CwjMr7tL/Juu/bjbUmRN5lJa1T4ZycUI/7wVRKlLgrFrAv
         r+pSjQQMEvnpimGgQD2bXwrdlW3VdV7WrTDTQM0YWJhbx0KLLRCo6aNkn6eydebUoc1W
         6NMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZN9DgpFpqXDn+wgxeMIYb4vito0Ia8RAXB7EhQWlCEo=;
        b=YgydSF9oODJnqgBgieW9EklFdRce0+o/60P/Wg6IsVdFooTtC5b3YRAr6H3rSn/DF0
         lykHSzuAGs7n3xsLy60qah6mrY+IuXh0PqOtHJeDU+Ktt7QLBdVSVI/B03MCxppJZ4tN
         /BB/TmlQrdYb+qWbBwF0/wOBywtNG+7WuacwiqklM1iCk+LYvsd43tmElhU3kCs1Y+/A
         U2HI3lYZN3LwIHWuT23mJ2aklMVVv5ni4gXRwcA8ywq/l+LHB4km3bcGXXqcWNXzeNHG
         N35EeptldPP2ZUYk8bwRnYiszH6+5HPqRiW9CbYG1T/hlMXGHb4ygKB+ZGahlN9lGCw5
         gc4w==
X-Gm-Message-State: AOAM532QW+OYjSrJ+IBc5gleq1hM8AvaUSOUCkYfihE9nGhwpgHUQgQS
        M2b7ET6wAen13AS3N2ZEz6No+mfpQmHFfYULg+k=
X-Google-Smtp-Source: ABdhPJzF7IDLTcL69KtU8+qwUPqAGCY5I0cFjZX8i7M4JP6ziMvyCKhTbjBY35qJHQuZ9Uq0Qblu3t6SHxeUhLjp/Gg=
X-Received: by 2002:a05:6902:706:b0:641:5f78:71ac with SMTP id
 k6-20020a056902070600b006415f7871acmr956010ybt.612.1649889772659; Wed, 13 Apr
 2022 15:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220413135223.BlueZ.v2.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
 <20220413135223.BlueZ.v2.7.I668ef2477efd8fcdd9c44975c5f7b9f32af966ca@changeid>
 <CABBYNZL3Jd_Er8C_NNoZ2GaRwH3KpzqhhED4kKLbrr+na6KXJQ@mail.gmail.com> <CAGPPCLB1j+KV_ZCY7xQe9sHheWWAQPxaRF9pH9R53mAVdmQfHg@mail.gmail.com>
In-Reply-To: <CAGPPCLB1j+KV_ZCY7xQe9sHheWWAQPxaRF9pH9R53mAVdmQfHg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 13 Apr 2022 15:42:41 -0700
Message-ID: <CABBYNZJ_GNwK5MZOfi9ybfxTqxJk12qtCN2bGU2hdOcjFU8kvg@mail.gmail.com>
Subject: Re: [BlueZ PATCH v2 7/9] adv_monitor: Add the monitor Release reason
To:     Manish Mandlik <mmandlik@google.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Manish,

On Wed, Apr 13, 2022 at 3:27 PM Manish Mandlik <mmandlik@google.com> wrote:
>
> Hi Luiz,
>
> On Wed, Apr 13, 2022 at 2:48 PM Luiz Augusto von Dentz <luiz.dentz@gmail.=
com> wrote:
>>
>> Hi Manish,
>>
>> On Wed, Apr 13, 2022 at 1:55 PM Manish Mandlik <mmandlik@google.com> wro=
te:
>> >
>> > Adv Monitor is released for various reasons. For example, incorrect RS=
SI
>> > parameters, incorrect monitor type, non-overlapping RSSI thresholds,
>> > etc.
>> >
>> > Return this release reason along with the Release event for the better
>> > visibility to clients.
>> >
>> > Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
>> > ---
>> >
>> > (no changes since v1)
>> >
>> >  doc/advertisement-monitor-api.txt | 12 ++++++-
>> >  src/adv_monitor.c                 | 56 ++++++++++++++++++++++++++++--=
-
>> >  2 files changed, 63 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/doc/advertisement-monitor-api.txt b/doc/advertisement-mon=
itor-api.txt
>> > index 942d44b2f..fcbd9c5c2 100644
>> > --- a/doc/advertisement-monitor-api.txt
>> > +++ b/doc/advertisement-monitor-api.txt
>> > @@ -17,12 +17,22 @@ Service             org.bluez
>> >  Interface      org.bluez.AdvertisementMonitor1 [experimental]
>> >  Object path    freely definable
>> >
>> > -Methods                void Release() [noreply]
>> > +Methods                void Release(Int8 reason) [noreply]
>> >
>> >                         This gets called as a signal for a client to p=
erform
>> >                         clean-up when (1)a monitor cannot be activated=
 after it
>> >                         was exposed or (2)a monitor has been deactivat=
ed.
>> >
>> > +                       Possible reasons:  0  Unknown reason
>> > +                                          1  Invalid monitor type
>> > +                                          2  Invalid RSSI parameter(s=
)
>> > +                                          3  Invalid pattern(s)
>> > +                                          4  Monitor already exists
>> > +                                          5  Kernel failed to add mon=
itor
>> > +                                          6  Kernel failed to remove =
monitor
>> > +                                          7  Monitor removed by kerne=
l
>> > +                                          8  App unregistered/destroy=
ed
>>
>> I don't really like this, this is only really useful for debugging but
>> once the code is stable it becomes pretty useless because the likes of
>> btmon would already collect errors from bluetoothd so you can already
>> debug with that, instead this just enables debugging on the
>> application layer but I don't see how it would help to recover anyway
>> so given this back to the user is probably a bad idea. Btw if you have
>> an App unregistered/destroyed the daemon most likely won't be able to
>> reach the object, so I wonder what is it for?
>
> This was added to give applications more visibility into why a monitor wa=
s not accepted. I agree that once the code is stable, most of the release r=
easons may become useless. However, the reason code "4 - Monitor already ex=
ists" may still happen. If more than one application creates monitors for t=
he same pattern but with different RSSI parameters, BlueZ merges those moni=
tors and sends it to the kernel as controllers do not accept monitors with =
the duplicate patterns. So, if RSSI parameters do not overlap with the exis=
ting monitors, BlueZ cannot merge such monitors and hence needs to release =
it. This error code will help applications to capture such scenarios and up=
date the RSSI parameters accordingly on the fly.

Not sure how the application will be able to correct the RSSI to fit
if it doesn't have access to all other monitors active in the system,
and even in case you have access to other monitors then you could
check this beforehand. I'm afraid we will need to find a way to make
this work transparently, perhaps have the RSSI updated either on the
application (strict) or in controller (relax).

>
> For the reason code "8 - App unregistered/destroyed", Release may not get=
 delivered if the app is already destroyed. But applications can unregister=
 Advertisement Monitor interface with BlueZ even if they are not exiting. I=
n such a case, Release will be delivered for all previously active monitors=
 of that application. This may help to notify applications to remove the mo=
nitor D-Bus objects if they want.

Well that removes the App destroyed then, also in case of Unregister
we normally don't attempt to reach out the object if it has been
unregistered since it is the application that is initiating the action
it should be aware that it has to release these objects so we avoid
extra traffic on D-Bus, specially in case the application is being
terminated and decide to call Unregister in the process, which it
probably shouldn't since we would cleanup anyway when it disconnects
from D-Bus, in fact I consider Unregister as a group Release and if
the application wants to register one by one then it should use
ObjectManager.InterfacesRemoves so its proxies are individually
removed.

Release is only really useful when initiated by the daemon itself,
like the adapter being unregistered, etc.

>>
>> >                 void Activate() [noreply]
>> >
>> >                         After a monitor was exposed, this gets called =
as a
>> > diff --git a/src/adv_monitor.c b/src/adv_monitor.c
>> > index d88e1bbbb..9e67d984b 100644
>> > --- a/src/adv_monitor.c
>> > +++ b/src/adv_monitor.c
>> > @@ -90,6 +90,18 @@ enum monitor_state {
>> >         MONITOR_STATE_RELEASED, /* Dbus Object removed by app */
>> >  };
>> >
>> > +enum monitor_release_reason {
>> > +       REASON_UNKNOWN,
>> > +       REASON_INVALID_TYPE,
>> > +       REASON_INVALID_RSSI_PARAMS,
>> > +       REASON_INVALID_PATTERNS,
>> > +       REASON_ALREADY_EXISTS,
>> > +       REASON_FAILED_TO_ADD,
>> > +       REASON_FAILED_TO_REMOVE,
>> > +       REASON_REMOVED_BY_KERNEL,
>> > +       REASON_APP_DESTROYED,
>> > +};
>> > +
>> >  enum merged_pattern_state {
>> >         MERGED_PATTERN_STATE_ADDING,    /* Adding pattern to kernel */
>> >         MERGED_PATTERN_STATE_REMOVING,  /* Removing pattern from kerne=
l */
>> > @@ -113,6 +125,7 @@ struct adv_monitor {
>> >         char *path;
>> >
>> >         enum monitor_state state;       /* MONITOR_STATE_* */
>> > +       enum monitor_release_reason release_reason;
>> >
>> >         struct rssi_parameters rssi;    /* RSSI parameter for this mon=
itor */
>> >         struct adv_monitor_merged_pattern *merged_pattern;
>> > @@ -137,6 +150,7 @@ struct adv_monitor_merged_pattern {
>> >         struct queue *patterns;         /* List of bt_ad_pattern objec=
ts */
>> >         enum merged_pattern_state current_state; /* MERGED_PATTERN_STA=
TE_* */
>> >         enum merged_pattern_state next_state;    /* MERGED_PATTERN_STA=
TE_* */
>> > +       enum monitor_release_reason release_reason;
>> >  };
>> >
>> >  /* Some data like last_seen, timer/timeout values need to be maintain=
ed
>> > @@ -541,6 +555,18 @@ static void monitor_free(struct adv_monitor *moni=
tor)
>> >         free(monitor);
>> >  }
>> >
>> > +/* Includes monitor release reason into the dbus message */
>> > +static void report_release_reason_setup(DBusMessageIter *iter, void *=
user_data)
>> > +{
>> > +       const struct adv_monitor *monitor =3D user_data;
>> > +       int8_t release_reason =3D REASON_UNKNOWN;
>> > +
>> > +       if (monitor)
>> > +               release_reason =3D monitor->release_reason;
>> > +
>> > +       dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &release_=
reason);
>> > +}
>> > +
>> >  /* Calls Release() method of the remote Adv Monitor */
>> >  static void monitor_release(struct adv_monitor *monitor)
>> >  {
>> > @@ -560,8 +586,9 @@ static void monitor_release(struct adv_monitor *mo=
nitor)
>> >         DBG("Calling Release() on Adv Monitor of owner %s at path %s",
>> >                 monitor->app->owner, monitor->path);
>> >
>> > -       g_dbus_proxy_method_call(monitor->proxy, "Release", NULL, NULL=
, NULL,
>> > -                                       NULL);
>> > +       g_dbus_proxy_method_call(monitor->proxy, "Release",
>> > +                                       report_release_reason_setup, N=
ULL,
>> > +                                       monitor, NULL);
>> >  }
>> >
>> >  /* Removes monitor from the merged_pattern. This would result in remo=
ving it
>> > @@ -635,13 +662,20 @@ static void monitor_destroy(void *data)
>> >  static void app_destroy(void *data)
>> >  {
>> >         struct adv_monitor_app *app =3D data;
>> > +       const struct queue_entry *e;
>> >
>> >         if (!app)
>> >                 return;
>> >
>> >         DBG("Destroy Adv Monitor app %s at path %s", app->owner, app->=
path);
>> >
>> > -       queue_destroy(app->monitors, monitor_destroy);
>> > +       for (e =3D queue_get_entries(app->monitors); e; e =3D e->next)=
 {
>> > +               struct adv_monitor *m =3D e->data;
>> > +
>> > +               m->release_reason =3D REASON_APP_DESTROYED;
>> > +               monitor_destroy(m);
>> > +       }
>> > +       queue_destroy(app->monitors, NULL);
>> >
>> >         if (app->reg) {
>> >                 app_reply_msg(app, btd_error_failed(app->reg,
>> > @@ -793,6 +827,7 @@ static bool parse_monitor_type(struct adv_monitor =
*monitor, const char *path)
>> >         }
>> >
>> >  failed:
>> > +       monitor->release_reason =3D REASON_INVALID_TYPE;
>> >         btd_error(adapter_id,
>> >                         "Invalid argument of property Type of the Adv =
Monitor "
>> >                         "at path %s", path);
>> > @@ -919,6 +954,7 @@ done:
>> >         return true;
>> >
>> >  failed:
>> > +       monitor->release_reason =3D REASON_INVALID_RSSI_PARAMS;
>> >         btd_error(adapter_id,
>> >                         "Invalid argument of RSSI thresholds and timeo=
uts "
>> >                         "of the Adv Monitor at path %s",
>> > @@ -1005,6 +1041,7 @@ static bool parse_patterns(struct adv_monitor *m=
onitor, const char *path)
>> >         return true;
>> >
>> >  failed:
>> > +       monitor->release_reason =3D REASON_INVALID_PATTERNS;
>> >         btd_error(adapter_id, "Invalid argument of property Patterns o=
f the "
>> >                         "Adv Monitor at path %s", path);
>> >
>> > @@ -1053,6 +1090,7 @@ static void merged_pattern_destroy_monitors(
>> >                 struct adv_monitor *monitor =3D e->data;
>> >
>> >                 monitor->merged_pattern =3D NULL;
>> > +               monitor->release_reason =3D merged_pattern->release_re=
ason;
>> >                 monitor_destroy(monitor);
>> >         }
>> >  }
>> > @@ -1086,6 +1124,7 @@ static void remove_adv_monitor_cb(uint8_t status=
, uint16_t length,
>> >         return;
>> >
>> >  fail:
>> > +       merged_pattern->release_reason =3D REASON_FAILED_TO_REMOVE;
>> >         merged_pattern_destroy_monitors(merged_pattern);
>> >         merged_pattern_free(merged_pattern);
>> >  }
>> > @@ -1142,6 +1181,7 @@ static void add_adv_patterns_monitor_cb(uint8_t =
status, uint16_t length,
>> >         return;
>> >
>> >  fail:
>> > +       merged_pattern->release_reason =3D REASON_FAILED_TO_ADD;
>> >         merged_pattern_destroy_monitors(merged_pattern);
>> >         merged_pattern_free(merged_pattern);
>> >  }
>> > @@ -1285,6 +1325,7 @@ static void monitor_proxy_added_cb(GDBusProxy *p=
roxy, void *user_data)
>> >                 merged_pattern_add(monitor->merged_pattern);
>> >         } else {
>> >                 if (!merge_is_possible(existing_pattern, monitor)) {
>> > +                       monitor->release_reason =3D REASON_ALREADY_EXI=
STS;
>> >                         monitor_destroy(monitor);
>> >                         DBG("Adv Monitor at path %s released due to ex=
isting "
>> >                                 "monitor", path);
>> > @@ -1551,6 +1592,7 @@ static void remove_merged_pattern(void *data, vo=
id *user_data)
>> >  {
>> >         struct adv_monitor_merged_pattern *merged_pattern =3D data;
>> >         uint16_t *handle =3D user_data;
>> > +       const struct queue_entry *e;
>> >
>> >         if (!handle)
>> >                 return;
>> > @@ -1562,8 +1604,14 @@ static void remove_merged_pattern(void *data, v=
oid *user_data)
>> >         DBG("Adv monitor with handle:0x%04x removed by kernel",
>> >                 merged_pattern->monitor_handle);
>> >
>> > +       for (e =3D queue_get_entries(merged_pattern->monitors); e; e =
=3D e->next) {
>> > +               struct adv_monitor *m =3D e->data;
>> > +
>> > +               m->release_reason =3D REASON_REMOVED_BY_KERNEL;
>> > +               monitor_destroy(m);
>> > +       }
>> >         queue_foreach(merged_pattern->monitors, monitor_state_removed,=
 NULL);
>> > -       queue_destroy(merged_pattern->monitors, monitor_destroy);
>> > +       queue_destroy(merged_pattern->monitors, NULL);
>> >         merged_pattern_free(merged_pattern);
>> >  }
>> >
>> > --
>> > 2.36.0.rc0.470.gd361397f0d-goog
>> >
>>
>>
>> --
>> Luiz Augusto von Dentz
>
>
> Regards,
> Manish.



--=20
Luiz Augusto von Dentz
