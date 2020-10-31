Return-Path: <SRS0=4lpm=EG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DC0C00A89
	for <linux-bluetooth@archiver.kernel.org>; Sat, 31 Oct 2020 01:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2681B208B6
	for <linux-bluetooth@archiver.kernel.org>; Sat, 31 Oct 2020 01:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M6lKJpf7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725562AbgJaBFJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Oct 2020 21:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgJaBFJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Oct 2020 21:05:09 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1315C0613D5
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2020 18:05:08 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m16so8773129ljo.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2020 18:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m3cyTtL3gE60MdkRjTURo3nC5k2de6f+n1Y9Vqufd2E=;
        b=M6lKJpf7996COSv7aisxfQGVYVgLSZn4d8Y5Msu67LvHXFsdaLx+Fji2M1Aqe8yj7B
         4IlWFkbuzjhMvX1vCKUycJTaomTSnLTGVINFf/J7ubB2ng4NntsOn3M3VrXlc1qsd001
         SKiaQoOrKgEZyEYIyW3ReZ8PPFwUVJJUVEVI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m3cyTtL3gE60MdkRjTURo3nC5k2de6f+n1Y9Vqufd2E=;
        b=HKHgHdW/YkxnrCo+7emTNQZIRSQfqSFLYGfL6qGvhGOw8RCqiLRyQ9DruL9triWZXJ
         b7A4Xl8FRhDm1bYVGuIIBCJuIrh0SSkrFvVaYvFRDGgBFXp/Fe22ghoOspuMpDxnszDh
         UJk2THQd39dScebEDZq9722bKPa7/39O2YWUjmCB1N6VgH6eXWOkSaaJmPoLUuBUYSj4
         5YpsjsMWxLXNqf9Mi9r5QNk/vv4RzsBnx3aJOgUK48Doz4BPvOPwIAIlOSrNfpoi1QtS
         QbyLg/Dc3o8dsafs4DihZq8D3h4VmOiNlPy5mJ+rUA5prDqzzifN/vIZaAMp3cotYeem
         ke3g==
X-Gm-Message-State: AOAM533ajSbSxlUpbMpv14LCVrBct/tJvyf0fJ/K5b3/HcL+gl+aZ3rj
        oEZwRdcGT4vPwTsM4W2Lra2R55BztPP1hqpedXIZ2A==
X-Google-Smtp-Source: ABdhPJwrAzJpARZlYwap64mfGibHAnqe01EOTcac7juge2Xkb6Dm04JC5smOO7E7U4dwXVUARy4EU5psZCMCFM2XCBU=
X-Received: by 2002:a2e:5049:: with SMTP id v9mr2253038ljd.273.1604106306934;
 Fri, 30 Oct 2020 18:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <20201028160433.BlueZ.v7.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
 <20201028160433.BlueZ.v7.3.I578ae5e76fcf7243206a27d4f5a25783662a5f14@changeid>
 <CABBYNZ+VUGUDGo7qu5p21CLDpn7KhCFBPTdkLuv=fWLfzqFWGQ@mail.gmail.com>
In-Reply-To: <CABBYNZ+VUGUDGo7qu5p21CLDpn7KhCFBPTdkLuv=fWLfzqFWGQ@mail.gmail.com>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Fri, 30 Oct 2020 18:04:56 -0700
Message-ID: <CABmPvSETi7p4KGt9p-udH8Yvn+8jwpkZ1f76bZD=o1E8ao04mg@mail.gmail.com>
Subject: Re: [BlueZ PATCH v7 3/7] adv_monitor: Implement Adv matching based on
 stored monitors
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "An, Tedd" <tedd.an@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Thu, Oct 29, 2020 at 10:25 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Miao,
>
> On Thu, Oct 29, 2020 at 12:54 AM Miao-chen Chou <mcchou@chromium.org> wro=
te:
> >
> > This implements create an entry point in adapter to start the matching =
of
> > Adv based on all monitors and invoke the RSSI tracking for Adv reportin=
g.
> >
> > Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > Reviewed-by: Alain Michaud <alainm@chromium.org>
> > Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
> > ---
> >
> > Changes in v7:
> > - Replace the use of GSList with struct queue
> > - Adopt bt_ad_pattern from shared/ad
> > - Add error logs
> >
> > Changes in v6:
> > - Fix the termination condition of AD data paring and remove unnecessar=
y
> > length check
> >
> > Changes in v5:
> > - Remove unittest helper functions
> >
> > Changes in v3:
> > - Remove unused variables
> > - Fix signature of queue_find()
> >
> >  src/adapter.c     |  44 +++++++++++---
> >  src/adv_monitor.c | 151 +++++++++++++++++++++++++++++++++++-----------
> >  src/adv_monitor.h |  14 +++++
> >  3 files changed, 167 insertions(+), 42 deletions(-)
> >
> > diff --git a/src/adapter.c b/src/adapter.c
> > index 6d0114a6b..0e3fd57f3 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -6597,10 +6597,28 @@ static void update_found_devices(struct btd_ada=
pter *adapter,
> >                                         const uint8_t *data, uint8_t da=
ta_len)
> >  {
> >         struct btd_device *dev;
> > +       struct bt_ad *ad =3D NULL;
> >         struct eir_data eir_data;
> >         bool name_known, discoverable;
> >         char addr[18];
> >         bool duplicate =3D false;
> > +       struct queue *matched_monitors =3D NULL;
> > +
> > +       if (bdaddr_type !=3D BDADDR_BREDR)
> > +               ad =3D bt_ad_new_with_data(data_len, data);
> > +
> > +       /* During the background scanning, update the device only when =
the data
> > +        * match at least one Adv monitor
> > +        */
> > +       if (ad) {
> > +               matched_monitors =3D btd_adv_monitor_content_filter(
> > +                                       adapter->adv_monitor_manager, a=
d);
> > +               bt_ad_unref(ad);
> > +               ad =3D NULL;
> > +       }
> > +
> > +       if (!adapter->discovering && !matched_monitors)
> > +               return;
> >
> >         memset(&eir_data, 0, sizeof(eir_data));
> >         eir_parse(&eir_data, data, data_len);
> > @@ -6646,18 +6664,22 @@ static void update_found_devices(struct btd_ada=
pter *adapter,
> >                 device_store_cached_name(dev, eir_data.name);
> >
> >         /*
> > -        * Only skip devices that are not connected, are temporary and =
there
> > -        * is no active discovery session ongoing.
> > +        * Only skip devices that are not connected, are temporary, and=
 there
> > +        * is no active discovery session ongoing and no matched Adv mo=
nitors
> >          */
> > -       if (!btd_device_is_connected(dev) && (device_is_temporary(dev) =
&&
> > -                                                !adapter->discovery_li=
st)) {
> > +       if (!btd_device_is_connected(dev) &&
> > +               (device_is_temporary(dev) && !adapter->discovery_list) =
&&
> > +               !matched_monitors) {
> >                 eir_data_free(&eir_data);
> >                 return;
> >         }
> >
> > -       /* Don't continue if not discoverable or if filter don't match =
*/
> > -       if (!discoverable || (adapter->filtered_discovery &&
> > -           !is_filter_match(adapter->discovery_list, &eir_data, rssi))=
) {
> > +       /* If there is no matched Adv monitors, don't continue if not
> > +        * discoverable or if active discovery filter don't match.
> > +        */
> > +       if (!matched_monitors && (!discoverable ||
> > +               (adapter->filtered_discovery && !is_filter_match(
> > +                               adapter->discovery_list, &eir_data, rss=
i)))) {
> >                 eir_data_free(&eir_data);
> >                 return;
> >         }
> > @@ -6714,6 +6736,14 @@ static void update_found_devices(struct btd_adap=
ter *adapter,
> >
> >         eir_data_free(&eir_data);
> >
> > +       /* After the device is updated, notify the matched Adv monitors=
 */
> > +       if (matched_monitors) {
> > +               btd_adv_monitor_notify_monitors(adapter->adv_monitor_ma=
nager,
> > +                                               dev, rssi, matched_moni=
tors);
> > +               queue_destroy(matched_monitors, NULL);
> > +               matched_monitors =3D NULL;
> > +       }
> > +
> >         /*
> >          * Only if at least one client has requested discovery, maintai=
n
> >          * list of found devices and name confirming for legacy devices=
.
> > diff --git a/src/adv_monitor.c b/src/adv_monitor.c
> > index 74351d91e..9a04da6e1 100644
> > --- a/src/adv_monitor.c
> > +++ b/src/adv_monitor.c
> > @@ -29,15 +29,12 @@
> >  #include "device.h"
> >  #include "log.h"
> >  #include "src/error.h"
> > -#include "src/shared/ad.h"
> >  #include "src/shared/mgmt.h"
> >  #include "src/shared/queue.h"
> >  #include "src/shared/util.h"
> >
> >  #include "adv_monitor.h"
> >
> > -static void monitor_device_free(void *data);
> > -
> >  #define ADV_MONITOR_INTERFACE          "org.bluez.AdvertisementMonitor=
1"
> >  #define ADV_MONITOR_MGR_INTERFACE      "org.bluez.AdvertisementMonitor=
Manager1"
> >
> > @@ -84,13 +81,6 @@ enum monitor_state {
> >         MONITOR_STATE_HONORED,  /* Accepted by kernel */
> >  };
> >
> > -struct pattern {
> > -       uint8_t ad_type;
> > -       uint8_t offset;
> > -       uint8_t length;
> > -       uint8_t value[BT_AD_MAX_DATA_LEN];
> > -};
> > -
> >  struct adv_monitor {
> >         struct adv_monitor_app *app;
> >         GDBusProxy *proxy;
> > @@ -105,7 +95,7 @@ struct adv_monitor {
> >         struct queue *devices;          /* List of adv_monitor_device o=
bjects */
> >
> >         enum monitor_type type;         /* MONITOR_TYPE_* */
> > -       struct queue *patterns;
> > +       struct queue *patterns;         /* List of bt_ad_pattern object=
s */
> >  };
> >
> >  /* Some data like last_seen, timer/timeout values need to be maintaine=
d
> > @@ -133,6 +123,20 @@ struct app_match_data {
> >         const char *path;
> >  };
> >
> > +struct adv_content_filter_info {
> > +       struct bt_ad *ad;
> > +       struct queue *matched_monitors; /* List of matched monitors */
> > +};
> > +
> > +struct adv_rssi_filter_info {
> > +       struct btd_device *device;
> > +       int8_t rssi;
> > +};
> > +
> > +static void monitor_device_free(void *data);
> > +static void adv_monitor_filter_rssi(struct adv_monitor *monitor,
> > +                                       struct btd_device *device, int8=
_t rssi);
> > +
> >  const struct adv_monitor_type {
> >         enum monitor_type type;
> >         const char *name;
> > @@ -155,10 +159,7 @@ static void app_reply_msg(struct adv_monitor_app *=
app, DBusMessage *reply)
> >  /* Frees a pattern */
> >  static void pattern_free(void *data)
> >  {
> > -       struct pattern *pattern =3D data;
> > -
> > -       if (!pattern)
> > -               return;
> > +       struct bt_ad_pattern *pattern =3D data;
> >
> >         free(pattern);
> >  }
> > @@ -464,7 +465,7 @@ static bool parse_patterns(struct adv_monitor *moni=
tor, const char *path)
> >                 int value_len;
> >                 uint8_t *value;
> >                 uint8_t offset, ad_type;
> > -               struct pattern *pattern;
> > +               struct bt_ad_pattern *pattern;
> >                 DBusMessageIter struct_iter, value_iter;
> >
> >                 dbus_message_iter_recurse(&array_iter, &struct_iter);
> > @@ -496,28 +497,10 @@ static bool parse_patterns(struct adv_monitor *mo=
nitor, const char *path)
> >                 dbus_message_iter_get_fixed_array(&value_iter, &value,
> >                                                         &value_len);
> >
> > -               // Verify the values
> > -               if (offset > BT_AD_MAX_DATA_LEN - 1)
> > -                       goto failed;
> > -
> > -               if ((ad_type > BT_AD_3D_INFO_DATA &&
> > -                       ad_type !=3D BT_AD_MANUFACTURER_DATA) ||
> > -                       ad_type < BT_AD_FLAGS) {
> > -                       goto failed;
> > -               }
> > -
> > -               if (!value || value_len <=3D 0 || value_len > BT_AD_MAX=
_DATA_LEN)
> > -                       goto failed;
> > -
> > -               pattern =3D new0(struct pattern, 1);
> > +               pattern =3D bt_ad_pattern_new(ad_type, offset, value_le=
n, value);
> >                 if (!pattern)
> >                         goto failed;
> >
> > -               pattern->ad_type =3D ad_type;
> > -               pattern->offset =3D offset;
> > -               pattern->length =3D value_len;
> > -               memcpy(pattern->value, value, pattern->length);
> > -
> >                 queue_push_tail(monitor->patterns, pattern);
> >
> >                 dbus_message_iter_next(&array_iter);
> > @@ -952,6 +935,104 @@ void btd_adv_monitor_manager_destroy(struct btd_a=
dv_monitor_manager *manager)
> >         manager_destroy(manager);
> >  }
> >
> > +/* Processes the content matching based pattern(s) of a monitor */
> > +static void adv_match_per_monitor(void *data, void *user_data)
> > +{
> > +       struct adv_monitor *monitor =3D data;
> > +       struct adv_content_filter_info *info =3D user_data;
> > +
> > +       if (!monitor) {
> > +               error("Unexpected NULL adv_monitor object upon match");
> > +               return;
> > +       }
> > +
> > +       if (monitor->state !=3D MONITOR_STATE_HONORED)
> > +               return;
> > +
> > +       if (monitor->type =3D=3D MONITOR_TYPE_OR_PATTERNS &&
> > +               bt_ad_pattern_match(info->ad, monitor->patterns)) {
> > +               goto matched;
> > +       }
> > +
> > +       return;
> > +
> > +matched:
> > +       if (!info->matched_monitors)
> > +               info->matched_monitors =3D queue_new();
> > +
> > +       queue_push_tail(info->matched_monitors, monitor);
> > +}
> > +
> > +/* Processes the content matching for the monitor(s) of an app */
> > +static void adv_match_per_app(void *data, void *user_data)
> > +{
> > +       struct adv_monitor_app *app =3D data;
> > +
> > +       if (!app) {
> > +               error("Unexpected NULL adv_monitor_app object upon matc=
h");
> > +               return;
> > +       }
> > +
> > +       queue_foreach(app->monitors, adv_match_per_monitor, user_data);
> > +}
> > +
> > +/* Processes the content matching for every app without RSSI filtering=
 and
> > + * notifying monitors. The caller is responsible of releasing the memo=
ry of the
> > + * list but not the ad data.
> > + * Returns the list of monitors whose content match the ad data.
> > + */
> > +struct queue *btd_adv_monitor_content_filter(
> > +                               struct btd_adv_monitor_manager *manager=
,
> > +                               struct bt_ad *ad)
> > +{
> > +       struct adv_content_filter_info info;
> > +
> > +       if (!manager || !ad)
> > +               return NULL;
> > +
> > +       info.ad =3D ad;
> > +       info.matched_monitors =3D NULL;
> > +
> > +       queue_foreach(manager->apps, adv_match_per_app, &info);
> > +
> > +       return info.matched_monitors;
> > +}
> > +
> > +/* Wraps adv_monitor_filter_rssi() to processes the content-matched mo=
nitor with
> > + * RSSI filtering and notifies it on device found/lost event
> > + */
> > +static void monitor_filter_rssi(void *data, void *user_data)
> > +{
> > +       struct adv_monitor *monitor =3D data;
> > +       struct adv_rssi_filter_info *info =3D user_data;
> > +
> > +       if (!monitor || !info)
> > +               return;
> > +
> > +       adv_monitor_filter_rssi(monitor, info->device, info->rssi);
> > +}
> > +
> > +/* Processes every content-matched monitor with RSSI filtering and not=
ifies on
> > + * device found/lost event. The caller is responsible of releasing the=
 memory
> > + * of matched_monitors list but not its data.
> > + */
> > +void btd_adv_monitor_notify_monitors(struct btd_adv_monitor_manager *m=
anager,
> > +                                       struct btd_device *device, int8=
_t rssi,
> > +                                       struct queue *matched_monitors)
> > +{
> > +       struct adv_rssi_filter_info info;
> > +
> > +       if (!manager || !device || !matched_monitors ||
> > +               queue_isempty(matched_monitors)) {
> > +               return;
> > +       }
> > +
> > +       info.device =3D device;
> > +       info.rssi =3D rssi;
> > +
> > +       queue_foreach(matched_monitors, monitor_filter_rssi, &info);
> > +}
> > +
> >  /* Matches a device based on btd_device object */
> >  static bool monitor_device_match(const void *a, const void *b)
> >  {
> > diff --git a/src/adv_monitor.h b/src/adv_monitor.h
> > index 13d5d7282..2b4f68abf 100644
> > --- a/src/adv_monitor.h
> > +++ b/src/adv_monitor.h
> > @@ -11,16 +11,30 @@
> >  #ifndef __ADV_MONITOR_H
> >  #define __ADV_MONITOR_H
> >
> > +#include <glib.h>
> > +
> > +#include "src/shared/ad.h"
> > +
> >  struct mgmt;
> > +struct queue;
> >  struct btd_device;
> >  struct btd_adapter;
> >  struct btd_adv_monitor_manager;
> > +struct btd_adv_monitor_pattern;
> >
> >  struct btd_adv_monitor_manager *btd_adv_monitor_manager_create(
> >                                                 struct btd_adapter *ada=
pter,
> >                                                 struct mgmt *mgmt);
> >  void btd_adv_monitor_manager_destroy(struct btd_adv_monitor_manager *m=
anager);
> >
> > +struct queue *btd_adv_monitor_content_filter(
> > +                               struct btd_adv_monitor_manager *manager=
,
> > +                               struct bt_ad *ad);
> > +
> > +void btd_adv_monitor_notify_monitors(struct btd_adv_monitor_manager *m=
anager,
> > +                                       struct btd_device *device, int8=
_t rssi,
> > +                                       struct queue *matched_monitors)=
;
> > +
> >  void btd_adv_monitor_device_remove(struct btd_adv_monitor_manager *man=
ager,
> >                                    struct btd_device *device);
> >
> > --
> > 2.26.2
>
> If I compile patch by patch this one fails:
>
> [detached HEAD 5a221084c] adv_monitor: Implement Adv matching based on
> stored monitors
>  Author: Miao-chen Chou <mcchou@chromium.org>
>  Date: Wed Oct 28 16:05:30 2020 -0700
>  3 files changed, 167 insertions(+), 42 deletions(-)
> Executing: make -j12
> make --no-print-directory all-am
>   CC       src/bluetoothd-adapter.o
>   CC       src/bluetoothd-adv_monitor.o
> src/adv_monitor.c:137:13: error: =E2=80=98adv_monitor_filter_rssi=E2=80=
=99 used but
> never defined [-Werror]
>   137 | static void adv_monitor_filter_rssi(struct adv_monitor *monitor,
>       |             ^~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>
> You might want to move these functions to the patch they start use
> them so we don't break bisect, you can test them with something like:
>
> git rebase -i origin/master --exec=3Dmake
>
> @An, Tedd We should probably update the CI to do something like the
> above so it can detect when a set would introduce a patch that doesn't
> build.
>
Since the RSSI filtering patch introduces some functions that will be
used by the following patch, so I merge this commit with the other one
where it is used in v8.
> --
> Luiz Augusto von Dentz

Thanks,
Miao
