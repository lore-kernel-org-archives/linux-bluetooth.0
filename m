Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADBEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Apr 2022 20:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353921AbiDTUFF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Apr 2022 16:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240917AbiDTUFD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Apr 2022 16:05:03 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E918F3D1F1
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Apr 2022 13:02:15 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-e5c42b6e31so3119273fac.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Apr 2022 13:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pEeFSPYdHK6LRYsRsuhh7YFFEOwsXzZdiFmHtX47S4k=;
        b=pwOxI2a19GokRRkN50iOViuigVHfKkiqFTl8QQbzg1rAgGhZMoiF6JWGUaSY20W7e0
         CieQrL17jha2/rfetZMGhopbyi9vCDmWTZGhCy4CbHXueo9xYQNVk6u/W28d5I2CVMgS
         pgckHU6LtHRhS2uS1yjVAUVJ4HA49y3i5qKYwHQlZV40n7yyzhfqwwQB6vH/Z2ZswOvr
         3mKvvidlP8eR3vDEmk/xkmWyi6RfDZUapO/HtPHu7DHcnWPwWcnCdkWx4wIvEefN7USY
         1KU5060FR/A039vyAowS8easCe8IVE5Ts6bztpdz1jasK+8wf7jjhZmGjO+apmcOyDPU
         +bHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pEeFSPYdHK6LRYsRsuhh7YFFEOwsXzZdiFmHtX47S4k=;
        b=tds/VDyQRWMUFQin4SR35aFcCLc3t1U9/bY/rAGb497qn3MjKeFnTvW6cSSUaBeEqx
         dO7PmHqt8vLqk0GidmVOR7YSA0unXpagWladW14nIEY/qA9Kw/ojsNBjKH2ozPnqOIVV
         Mt2oVikyiyhkjLxTEaZ/v5RhFIzPMxLSnEJpeEtdv55MTFJj+HsP5Ye24WLO1Oh+9oHG
         eYyh7eW8pTUitDp3dyJNuRCHYe8yGc9yyNHR7/BUr9O+n04vcqPT+xEr+Z6Ufl9/RG8J
         K92RBmyQoailkgTU2H4Ak9kU+Zs58hIHYXJaYgwSR3V2AkxzalNnD2R5mE1znKlYBYjj
         qLaQ==
X-Gm-Message-State: AOAM530LFNSle9jJvo61UWmxO/H/FmzFZ0sEtryzmJ2OOTvA7SczdHK8
        jibaeEbXu0cutEEI9r5MuRgrd+SdIwujRYCuHVA=
X-Google-Smtp-Source: ABdhPJyAc/MCpf2gOLIImPzJrd2p1eNyMHpA7JqYe46Q0gXd/MaBhWy4ruzNPMGFwqvIF2fCN8lTgg8vajv4Kys1IHA=
X-Received: by 2002:a05:6870:8287:b0:e5:fb34:6089 with SMTP id
 q7-20020a056870828700b000e5fb346089mr2368002oae.207.1650484935080; Wed, 20
 Apr 2022 13:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220413135223.BlueZ.v2.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
 <20220413135223.BlueZ.v2.7.I668ef2477efd8fcdd9c44975c5f7b9f32af966ca@changeid>
 <CABBYNZL3Jd_Er8C_NNoZ2GaRwH3KpzqhhED4kKLbrr+na6KXJQ@mail.gmail.com>
 <CAGPPCLB1j+KV_ZCY7xQe9sHheWWAQPxaRF9pH9R53mAVdmQfHg@mail.gmail.com>
 <CABBYNZJ_GNwK5MZOfi9ybfxTqxJk12qtCN2bGU2hdOcjFU8kvg@mail.gmail.com> <CAGPPCLBaoP=dXKp53F7Q3Pg4pnSELdkt_ns9Aw-A-yYk6Vs0yw@mail.gmail.com>
In-Reply-To: <CAGPPCLBaoP=dXKp53F7Q3Pg4pnSELdkt_ns9Aw-A-yYk6Vs0yw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 20 Apr 2022 13:02:03 -0700
Message-ID: <CABBYNZ+_mxPO1wef3RcVv0keHW1Bq9UZ81uHjWfX68NVXQ0fyQ@mail.gmail.com>
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

On Wed, Apr 20, 2022 at 10:51 AM Manish Mandlik <mmandlik@google.com> wrote=
:
>
> Hi Luiz,
>
> On Wed, Apr 13, 2022 at 3:42 PM Luiz Augusto von Dentz <luiz.dentz@gmail.=
com> wrote:
>>
>> Hi Manish,
>>
>> On Wed, Apr 13, 2022 at 3:27 PM Manish Mandlik <mmandlik@google.com> wro=
te:
>> >
>> > Hi Luiz,
>> >
>> > On Wed, Apr 13, 2022 at 2:48 PM Luiz Augusto von Dentz <luiz.dentz@gma=
il.com> wrote:
>> >>
>> >> Hi Manish,
>> >>
>> >> On Wed, Apr 13, 2022 at 1:55 PM Manish Mandlik <mmandlik@google.com> =
wrote:
>> >> >
>> >> > Adv Monitor is released for various reasons. For example, incorrect=
 RSSI
>> >> > parameters, incorrect monitor type, non-overlapping RSSI thresholds=
,
>> >> > etc.
>> >> >
>> >> > Return this release reason along with the Release event for the bet=
ter
>> >> > visibility to clients.
>> >> >
>> >> > Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
>> >> > ---
>> >> >
>> >> > (no changes since v1)
>> >> >
>> >> >  doc/advertisement-monitor-api.txt | 12 ++++++-
>> >> >  src/adv_monitor.c                 | 56 +++++++++++++++++++++++++++=
+---
>> >> >  2 files changed, 63 insertions(+), 5 deletions(-)
>> >> >
>> >> > diff --git a/doc/advertisement-monitor-api.txt b/doc/advertisement-=
monitor-api.txt
>> >> > index 942d44b2f..fcbd9c5c2 100644
>> >> > --- a/doc/advertisement-monitor-api.txt
>> >> > +++ b/doc/advertisement-monitor-api.txt
>> >> > @@ -17,12 +17,22 @@ Service             org.bluez
>> >> >  Interface      org.bluez.AdvertisementMonitor1 [experimental]
>> >> >  Object path    freely definable
>> >> >
>> >> > -Methods                void Release() [noreply]
>> >> > +Methods                void Release(Int8 reason) [noreply]
>> >> >
>> >> >                         This gets called as a signal for a client t=
o perform
>> >> >                         clean-up when (1)a monitor cannot be activa=
ted after it
>> >> >                         was exposed or (2)a monitor has been deacti=
vated.
>> >> >
>> >> > +                       Possible reasons:  0  Unknown reason
>> >> > +                                          1  Invalid monitor type
>> >> > +                                          2  Invalid RSSI paramete=
r(s)
>> >> > +                                          3  Invalid pattern(s)
>> >> > +                                          4  Monitor already exist=
s
>> >> > +                                          5  Kernel failed to add =
monitor
>> >> > +                                          6  Kernel failed to remo=
ve monitor
>> >> > +                                          7  Monitor removed by ke=
rnel
>> >> > +                                          8  App unregistered/dest=
royed
>> >>
>> >> I don't really like this, this is only really useful for debugging bu=
t
>> >> once the code is stable it becomes pretty useless because the likes o=
f
>> >> btmon would already collect errors from bluetoothd so you can already
>> >> debug with that, instead this just enables debugging on the
>> >> application layer but I don't see how it would help to recover anyway
>> >> so given this back to the user is probably a bad idea. Btw if you hav=
e
>> >> an App unregistered/destroyed the daemon most likely won't be able to
>> >> reach the object, so I wonder what is it for?
>> >
>> > This was added to give applications more visibility into why a monitor=
 was not accepted. I agree that once the code is stable, most of the releas=
e reasons may become useless. However, the reason code "4 - Monitor already=
 exists" may still happen. If more than one application creates monitors fo=
r the same pattern but with different RSSI parameters, BlueZ merges those m=
onitors and sends it to the kernel as controllers do not accept monitors wi=
th the duplicate patterns. So, if RSSI parameters do not overlap with the e=
xisting monitors, BlueZ cannot merge such monitors and hence needs to relea=
se it. This error code will help applications to capture such scenarios and=
 update the RSSI parameters accordingly on the fly.
>>
>> Not sure how the application will be able to correct the RSSI to fit
>> if it doesn't have access to all other monitors active in the system,
>> and even in case you have access to other monitors then you could
>> check this beforehand. I'm afraid we will need to find a way to make
>> this work transparently, perhaps have the RSSI updated either on the
>> application (strict) or in controller (relax).
>
> All monitors are exposed on org.bluez.AdvertisementMonitor1 interface and=
 applications can check all monitors on that interface. However, multiple a=
pplications adding monitors with the same pattern won't be a common case. S=
o, it will be an overhead to check all other monitors while creating a new =
monitor every time. BlueZ anyway updates the RSSI if there is an overlap of=
 the RSSI parameters. The failure case would occur only when there is no ov=
erlap. So I feel providing a release reason along with a Release() method c=
all would rather be an optimised approach and the application can read thro=
ugh all other monitors only if BlueZ notifies of a conflict. Let me know wh=
at you think about this.

If I got you right you want the daemon to check if there are any
conflicts for the application and if there is than call Release with
the error code, but still we don't inform what the conflict is or
rather what is the RSSI that can be used to resolve the conflict which
comes back to my initial response that this should be resolved by the
daemon somehow and if the application is not happy with the resulting
RSSI then it just unregister which should make this less error prone.

>>
>>
>> >
>> > For the reason code "8 - App unregistered/destroyed", Release may not =
get delivered if the app is already destroyed. But applications can unregis=
ter Advertisement Monitor interface with BlueZ even if they are not exiting=
. In such a case, Release will be delivered for all previously active monit=
ors of that application. This may help to notify applications to remove the=
 monitor D-Bus objects if they want.
>>
>> Well that removes the App destroyed then, also in case of Unregister
>> we normally don't attempt to reach out the object if it has been
>> unregistered since it is the application that is initiating the action
>> it should be aware that it has to release these objects so we avoid
>> extra traffic on D-Bus, specially in case the application is being
>> terminated and decide to call Unregister in the process, which it
>> probably shouldn't since we would cleanup anyway when it disconnects
>> from D-Bus, in fact I consider Unregister as a group Release and if
>> the application wants to register one by one then it should use
>> ObjectManager.InterfacesRemoves so its proxies are individually
>> removed.
>
> Ack. I'll remove this release reason and I'll also create another patch t=
o remove calling the Release() on monitor objects in such a case from the e=
xisting code.
>
>>
>> Release is only really useful when initiated by the daemon itself,
>> like the adapter being unregistered, etc.
>>
>> >>
>> >> >                 void Activate() [noreply]
>> >> >
>> >> >                         After a monitor was exposed, this gets call=
ed as a
>> >> > diff --git a/src/adv_monitor.c b/src/adv_monitor.c
>> >> > index d88e1bbbb..9e67d984b 100644
>> >> > --- a/src/adv_monitor.c
>> >> > +++ b/src/adv_monitor.c
>> >> > @@ -90,6 +90,18 @@ enum monitor_state {
>> >> >         MONITOR_STATE_RELEASED, /* Dbus Object removed by app */
>> >> >  };
>> >> >
>> >> > +enum monitor_release_reason {
>> >> > +       REASON_UNKNOWN,
>> >> > +       REASON_INVALID_TYPE,
>> >> > +       REASON_INVALID_RSSI_PARAMS,
>> >> > +       REASON_INVALID_PATTERNS,
>> >> > +       REASON_ALREADY_EXISTS,
>> >> > +       REASON_FAILED_TO_ADD,
>> >> > +       REASON_FAILED_TO_REMOVE,
>> >> > +       REASON_REMOVED_BY_KERNEL,
>> >> > +       REASON_APP_DESTROYED,
>> >> > +};
>> >> > +
>> >> >  enum merged_pattern_state {
>> >> >         MERGED_PATTERN_STATE_ADDING,    /* Adding pattern to kernel=
 */
>> >> >         MERGED_PATTERN_STATE_REMOVING,  /* Removing pattern from ke=
rnel */
>> >> > @@ -113,6 +125,7 @@ struct adv_monitor {
>> >> >         char *path;
>> >> >
>> >> >         enum monitor_state state;       /* MONITOR_STATE_* */
>> >> > +       enum monitor_release_reason release_reason;
>> >> >
>> >> >         struct rssi_parameters rssi;    /* RSSI parameter for this =
monitor */
>> >> >         struct adv_monitor_merged_pattern *merged_pattern;
>> >> > @@ -137,6 +150,7 @@ struct adv_monitor_merged_pattern {
>> >> >         struct queue *patterns;         /* List of bt_ad_pattern ob=
jects */
>> >> >         enum merged_pattern_state current_state; /* MERGED_PATTERN_=
STATE_* */
>> >> >         enum merged_pattern_state next_state;    /* MERGED_PATTERN_=
STATE_* */
>> >> > +       enum monitor_release_reason release_reason;
>> >> >  };
>> >> >
>> >> >  /* Some data like last_seen, timer/timeout values need to be maint=
ained
>> >> > @@ -541,6 +555,18 @@ static void monitor_free(struct adv_monitor *m=
onitor)
>> >> >         free(monitor);
>> >> >  }
>> >> >
>> >> > +/* Includes monitor release reason into the dbus message */
>> >> > +static void report_release_reason_setup(DBusMessageIter *iter, voi=
d *user_data)
>> >> > +{
>> >> > +       const struct adv_monitor *monitor =3D user_data;
>> >> > +       int8_t release_reason =3D REASON_UNKNOWN;
>> >> > +
>> >> > +       if (monitor)
>> >> > +               release_reason =3D monitor->release_reason;
>> >> > +
>> >> > +       dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &relea=
se_reason);
>> >> > +}
>> >> > +
>> >> >  /* Calls Release() method of the remote Adv Monitor */
>> >> >  static void monitor_release(struct adv_monitor *monitor)
>> >> >  {
>> >> > @@ -560,8 +586,9 @@ static void monitor_release(struct adv_monitor =
*monitor)
>> >> >         DBG("Calling Release() on Adv Monitor of owner %s at path %=
s",
>> >> >                 monitor->app->owner, monitor->path);
>> >> >
>> >> > -       g_dbus_proxy_method_call(monitor->proxy, "Release", NULL, N=
ULL, NULL,
>> >> > -                                       NULL);
>> >> > +       g_dbus_proxy_method_call(monitor->proxy, "Release",
>> >> > +                                       report_release_reason_setup=
, NULL,
>> >> > +                                       monitor, NULL);
>> >> >  }
>> >> >
>> >> >  /* Removes monitor from the merged_pattern. This would result in r=
emoving it
>> >> > @@ -635,13 +662,20 @@ static void monitor_destroy(void *data)
>> >> >  static void app_destroy(void *data)
>> >> >  {
>> >> >         struct adv_monitor_app *app =3D data;
>> >> > +       const struct queue_entry *e;
>> >> >
>> >> >         if (!app)
>> >> >                 return;
>> >> >
>> >> >         DBG("Destroy Adv Monitor app %s at path %s", app->owner, ap=
p->path);
>> >> >
>> >> > -       queue_destroy(app->monitors, monitor_destroy);
>> >> > +       for (e =3D queue_get_entries(app->monitors); e; e =3D e->ne=
xt) {
>> >> > +               struct adv_monitor *m =3D e->data;
>> >> > +
>> >> > +               m->release_reason =3D REASON_APP_DESTROYED;
>> >> > +               monitor_destroy(m);
>> >> > +       }
>> >> > +       queue_destroy(app->monitors, NULL);
>> >> >
>> >> >         if (app->reg) {
>> >> >                 app_reply_msg(app, btd_error_failed(app->reg,
>> >> > @@ -793,6 +827,7 @@ static bool parse_monitor_type(struct adv_monit=
or *monitor, const char *path)
>> >> >         }
>> >> >
>> >> >  failed:
>> >> > +       monitor->release_reason =3D REASON_INVALID_TYPE;
>> >> >         btd_error(adapter_id,
>> >> >                         "Invalid argument of property Type of the A=
dv Monitor "
>> >> >                         "at path %s", path);
>> >> > @@ -919,6 +954,7 @@ done:
>> >> >         return true;
>> >> >
>> >> >  failed:
>> >> > +       monitor->release_reason =3D REASON_INVALID_RSSI_PARAMS;
>> >> >         btd_error(adapter_id,
>> >> >                         "Invalid argument of RSSI thresholds and ti=
meouts "
>> >> >                         "of the Adv Monitor at path %s",
>> >> > @@ -1005,6 +1041,7 @@ static bool parse_patterns(struct adv_monitor=
 *monitor, const char *path)
>> >> >         return true;
>> >> >
>> >> >  failed:
>> >> > +       monitor->release_reason =3D REASON_INVALID_PATTERNS;
>> >> >         btd_error(adapter_id, "Invalid argument of property Pattern=
s of the "
>> >> >                         "Adv Monitor at path %s", path);
>> >> >
>> >> > @@ -1053,6 +1090,7 @@ static void merged_pattern_destroy_monitors(
>> >> >                 struct adv_monitor *monitor =3D e->data;
>> >> >
>> >> >                 monitor->merged_pattern =3D NULL;
>> >> > +               monitor->release_reason =3D merged_pattern->release=
_reason;
>> >> >                 monitor_destroy(monitor);
>> >> >         }
>> >> >  }
>> >> > @@ -1086,6 +1124,7 @@ static void remove_adv_monitor_cb(uint8_t sta=
tus, uint16_t length,
>> >> >         return;
>> >> >
>> >> >  fail:
>> >> > +       merged_pattern->release_reason =3D REASON_FAILED_TO_REMOVE;
>> >> >         merged_pattern_destroy_monitors(merged_pattern);
>> >> >         merged_pattern_free(merged_pattern);
>> >> >  }
>> >> > @@ -1142,6 +1181,7 @@ static void add_adv_patterns_monitor_cb(uint8=
_t status, uint16_t length,
>> >> >         return;
>> >> >
>> >> >  fail:
>> >> > +       merged_pattern->release_reason =3D REASON_FAILED_TO_ADD;
>> >> >         merged_pattern_destroy_monitors(merged_pattern);
>> >> >         merged_pattern_free(merged_pattern);
>> >> >  }
>> >> > @@ -1285,6 +1325,7 @@ static void monitor_proxy_added_cb(GDBusProxy=
 *proxy, void *user_data)
>> >> >                 merged_pattern_add(monitor->merged_pattern);
>> >> >         } else {
>> >> >                 if (!merge_is_possible(existing_pattern, monitor)) =
{
>> >> > +                       monitor->release_reason =3D REASON_ALREADY_=
EXISTS;
>> >> >                         monitor_destroy(monitor);
>> >> >                         DBG("Adv Monitor at path %s released due to=
 existing "
>> >> >                                 "monitor", path);
>> >> > @@ -1551,6 +1592,7 @@ static void remove_merged_pattern(void *data,=
 void *user_data)
>> >> >  {
>> >> >         struct adv_monitor_merged_pattern *merged_pattern =3D data;
>> >> >         uint16_t *handle =3D user_data;
>> >> > +       const struct queue_entry *e;
>> >> >
>> >> >         if (!handle)
>> >> >                 return;
>> >> > @@ -1562,8 +1604,14 @@ static void remove_merged_pattern(void *data=
, void *user_data)
>> >> >         DBG("Adv monitor with handle:0x%04x removed by kernel",
>> >> >                 merged_pattern->monitor_handle);
>> >> >
>> >> > +       for (e =3D queue_get_entries(merged_pattern->monitors); e; =
e =3D e->next) {
>> >> > +               struct adv_monitor *m =3D e->data;
>> >> > +
>> >> > +               m->release_reason =3D REASON_REMOVED_BY_KERNEL;
>> >> > +               monitor_destroy(m);
>> >> > +       }
>> >> >         queue_foreach(merged_pattern->monitors, monitor_state_remov=
ed, NULL);
>> >> > -       queue_destroy(merged_pattern->monitors, monitor_destroy);
>> >> > +       queue_destroy(merged_pattern->monitors, NULL);
>> >> >         merged_pattern_free(merged_pattern);
>> >> >  }
>> >> >
>> >> > --
>> >> > 2.36.0.rc0.470.gd361397f0d-goog
>> >> >
>> >>
>> >>
>> >> --
>> >> Luiz Augusto von Dentz
>> >
>> >
>> > Regards,
>> > Manish.
>>
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
