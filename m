Return-Path: <SRS0=wtMD=CT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFEDC433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 04:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 272302076D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 04:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eTDznI5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgIJExM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Sep 2020 00:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgIJExF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Sep 2020 00:53:05 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE63C061573
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2020 21:53:04 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id u21so6435939ljl.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2020 21:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BZNWrm+gtstAC90dpi7HeJQJ7pNUj+SVExRa1Mq75FY=;
        b=eTDznI5NT6mr2SiIOyQB/yfbffUmIcfbYXRXSqvCJaQJ2RAM91QHNNBODpcB6GA9gV
         ZQuuEsPnqK0n20YVrIfDuJMeRioT9KbqeCvk45naesraP7C9pBh0qiWHwTS2rfn7D4Uf
         dwOG1/yKAvfCLaKc0wGYTsGQoMIcQkcvDAcRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BZNWrm+gtstAC90dpi7HeJQJ7pNUj+SVExRa1Mq75FY=;
        b=ifzenaGKrFoqyBKmgL0wQYJxLFc78FbmmOUAuxDHH9V6iGD5LFX44rV3i9ZY24Bevv
         SUsxK3qZzZ7n/c8z4QTIM8PjNG0gDEqr8HLoUgi4wuoNth0ZK8iIwdF/MXOovfTfj8pE
         CjEXBRGCCNSv87TTL9hbS4LBnsiwNPbDCFX3Y0NzG7Dp0kn6tcaiMTrmqEcmSsiso7Uo
         PU8uVRG5Rnhg+3o4BZfrrdXHOz2wXQwA5Ilnx6y1I4SeaReN374Ny7Y2buTs0Dp+uUKL
         Zq+xYRltV6gqoKP/zknRtXBa2mA+JAiB5qdvY8WG62hpMKlDeYG6+eevIc+3lInd8SOL
         uoQg==
X-Gm-Message-State: AOAM531+LwE4jrs4Xu1CQLsaeAKNBwrozfUYoddNzsWFgB9K2jR3XFXz
        sUULXjFDTv1h1VguRDj2Rg3C9z5h1EgFZZ+zjH9IBw==
X-Google-Smtp-Source: ABdhPJynf8UEyq3A8ZXh1XrZDFQiN9S4Xm9AoX1kIlJjeJQg9d9U+xR9RQHwkm5xXfvesygT7+YUln4fel/KEtH/aLE=
X-Received: by 2002:a2e:5d2:: with SMTP id 201mr3406157ljf.73.1599713583095;
 Wed, 09 Sep 2020 21:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200818152612.BlueZ.v1.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
 <20200818152612.BlueZ.v1.6.I47744c7eef31f44cf393dea2b3e437d7b41cef79@changeid>
 <CABBYNZJtWjhXZ9YSPLLiuP_KTzfCxox7KCOtJJvgnHY8PMZQwg@mail.gmail.com>
In-Reply-To: <CABBYNZJtWjhXZ9YSPLLiuP_KTzfCxox7KCOtJJvgnHY8PMZQwg@mail.gmail.com>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Wed, 9 Sep 2020 21:52:52 -0700
Message-ID: <CABmPvSH=EXA+wainX4R=hNTxqkTQ-QzhbB4oo95AFN+ureTbcA@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1 6/7] adv_monitor: Handle D-Bus proxy event of an
 ADV monitor
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Tue, Sep 8, 2020 at 10:36 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Miao,
>
> On Tue, Aug 18, 2020 at 3:31 PM Miao-chen Chou <mcchou@chromium.org> wrote:
> >
> > This adds two handlers, one for adding and one for removing, of D-Bus proxy
> > events. The handler of property changes is set to NULL as intended,
> > since for simplicity no further changes on monitor's properties would
> > affect the ongoing monitoring.
> >
> > The following test steps were performed with bluetoothctl.
> > - After registering the root path, expose two monitors and verify that
> > the proxy added event are received.
> > - Have two monitors added, unexpose the monitors, and verify that the
> > proxy removed events are received for those two monitors.
> > - Have two monitors added, unregister the monitors and verify that the
> > proxy removed events are received for those two monitors.
> >
> > Reviewed-by: Yun-Hao Chung <howardchung@google.com>
> > Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
> > ---
> >
> >  src/adv_monitor.c | 492 ++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 479 insertions(+), 13 deletions(-)
> >
> > diff --git a/src/adv_monitor.c b/src/adv_monitor.c
> > index b5ea5ee99..23fbc2b45 100644
> > --- a/src/adv_monitor.c
> > +++ b/src/adv_monitor.c
> > @@ -37,14 +37,23 @@
> >  #include "dbus-common.h"
> >  #include "log.h"
> >  #include "src/error.h"
> > +#include "src/shared/ad.h"
> >  #include "src/shared/mgmt.h"
> >  #include "src/shared/queue.h"
> >  #include "src/shared/util.h"
> >
> >  #include "adv_monitor.h"
> >
> > +#define ADV_MONITOR_INTERFACE          "org.bluez.AdvertisementMonitor1"
> >  #define ADV_MONITOR_MGR_INTERFACE      "org.bluez.AdvertisementMonitorManager1"
> >
> > +#define ADV_MONITOR_UNSET_RSSI         127     /* dBm */
> > +#define ADV_MONITOR_MAX_RSSI           20      /* dBm */
> > +#define ADV_MONITOR_MIN_RSSI           -127    /* dBm */
> > +#define ADV_MONITOR_UNSET_TIMER                0       /* second */
> > +#define ADV_MONITOR_MIN_TIMER          1       /* second */
> > +#define ADV_MONITOR_MAX_TIMER          300     /* second */
> > +
> >  struct btd_adv_monitor_manager {
> >         struct btd_adapter *adapter;
> >         struct mgmt *mgmt;
> > @@ -66,6 +75,43 @@ struct adv_monitor_app {
> >
> >         DBusMessage *reg;
> >         GDBusClient *client;
> > +
> > +       struct queue *monitors;
> > +};
> > +
> > +enum monitor_type {
> > +       MONITOR_TYPE_NONE,
> > +       MONITOR_TYPE_OR_PATTERNS,
> > +};
> > +
> > +enum monitor_state {
> > +       MONITOR_STATE_NEW,      /* New but not yet init'ed with actual values */
> > +       MONITOR_STATE_FAILED,   /* Failed to be init'ed */
> > +       MONITOR_STATE_INITED,   /* Init'ed but not yet sent to kernel */
> > +       MONITOR_STATE_HONORED,  /* Accepted by kernel */
> > +};
> > +
> > +struct pattern {
> > +       uint8_t ad_type;
> > +       uint8_t offset;
> > +       uint8_t length;
> > +       uint8_t value[BT_AD_MAX_DATA_LEN];
> > +};
> > +
> > +struct adv_monitor {
> > +       struct adv_monitor_app *app;
> > +       GDBusProxy *proxy;
> > +       char *path;
> > +
> > +       enum monitor_state state;       /* MONITOR_STATE_* */
> > +
> > +       int8_t high_rssi;               /* high RSSI threshold */
> > +       uint16_t high_rssi_timeout;     /* high RSSI threshold timeout */
> > +       int8_t low_rssi;                /* low RSSI threshold */
> > +       uint16_t low_rssi_timeout;      /* low RSSI threshold timeout */
> > +
> > +       enum monitor_type type;         /* MONITOR_TYPE_* */
> > +       struct queue *patterns;
> >  };
> >
> >  struct app_match_data {
> > @@ -73,6 +119,14 @@ struct app_match_data {
> >         const char *path;
> >  };
> >
> > +const struct adv_monitor_type {
> > +       enum monitor_type type;
> > +       const char *name;
> > +} supported_types[] = {
> > +       { MONITOR_TYPE_OR_PATTERNS, "or_patterns" },
> > +       { },
> > +};
> > +
> >  /* Replies to an app's D-Bus message and unref it */
> >  static void app_reply_msg(struct adv_monitor_app *app, DBusMessage *reply)
> >  {
> > @@ -84,6 +138,52 @@ static void app_reply_msg(struct adv_monitor_app *app, DBusMessage *reply)
> >         app->reg = NULL;
> >  }
> >
> > +/* Frees a pattern */
> > +static void pattern_free(void *data)
> > +{
> > +       struct pattern *pattern = data;
> > +
> > +       if (!pattern)
> > +               return;
> > +
> > +       g_free(pattern);
> > +}
> > +
> > +/* Frees a monitor object */
> > +static void monitor_free(void *data)
> > +{
> > +       struct adv_monitor *monitor = data;
> > +
> > +       if (!monitor)
> > +               return;
> > +
> > +       monitor->app = NULL;
> > +       g_dbus_proxy_unref(monitor->proxy);
> > +       monitor->proxy = NULL;
> > +       g_free(monitor->path);
> > +       monitor->path = NULL;
> > +
> > +       queue_destroy(monitor->patterns, pattern_free);
> > +       monitor->patterns = NULL;
> > +
> > +       g_free(monitor);
> > +}
> > +
> > +/* Calls Release() method of the remote Adv Monitor */
> > +static void monitor_release(void *data, void *user_data)
> > +{
> > +       struct adv_monitor *monitor = data;
> > +
> > +       if (!monitor)
> > +               return;
> > +
> > +       DBG("Calling Release() on Adv Monitor of owner %s at path %s",
> > +               monitor->app->owner, monitor->path);
> > +
> > +       g_dbus_proxy_method_call(monitor->proxy, "Release", NULL, NULL, NULL,
> > +                                       NULL);
> > +}
> > +
> >  /* Destroys an app object along with related D-Bus handlers */
> >  static void app_destroy(void *data)
> >  {
> > @@ -94,6 +194,9 @@ static void app_destroy(void *data)
> >
> >         DBG("Destroy Adv Monitor app %s at path %s", app->owner, app->path);
> >
> > +       queue_foreach(app->monitors, monitor_release, NULL);
> > +       queue_destroy(app->monitors, monitor_free);
> > +
> >         if (app->reg) {
> >                 app_reply_msg(app, btd_error_failed(app->reg,
> >                                                 "Adv Monitor app destroyed"));
> > @@ -139,6 +242,372 @@ static void app_ready_cb(GDBusClient *client, void *user_data)
> >         app_reply_msg(app, dbus_message_new_method_return(app->reg));
> >  }
> >
> > +/* Allocates an Adv Monitor */
> > +static struct adv_monitor *monitor_new(struct adv_monitor_app *app,
> > +                                               GDBusProxy *proxy)
> > +{
> > +       struct adv_monitor *monitor;
> > +
> > +       if (!app || !proxy)
> > +               return NULL;
> > +
> > +       monitor = g_new0(struct adv_monitor, 1);
>
> new0
Done.
>
> > +       if (!monitor)
> > +               return NULL;
> > +
> > +       monitor->app = app;
> > +       monitor->proxy = g_dbus_proxy_ref(proxy);
> > +       monitor->path = g_strdup(g_dbus_proxy_get_path(proxy));
> > +
> > +       monitor->state = MONITOR_STATE_NEW;
> > +
> > +       monitor->high_rssi = ADV_MONITOR_UNSET_RSSI;
> > +       monitor->high_rssi_timeout = ADV_MONITOR_UNSET_TIMER;
> > +       monitor->low_rssi = ADV_MONITOR_UNSET_RSSI;
> > +       monitor->low_rssi_timeout = ADV_MONITOR_UNSET_TIMER;
> > +
> > +       monitor->type = MONITOR_TYPE_NONE;
> > +       monitor->patterns = NULL;
> > +
> > +       return monitor;
> > +}
> > +
> > +/* Matches a monitor based on its D-Bus path */
> > +static bool monitor_match(const void *a, const void *b)
> > +{
> > +       const GDBusProxy *proxy = b;
> > +       const struct adv_monitor *monitor = a;
> > +
> > +       if (!proxy || !monitor)
> > +               return false;
> > +
> > +       if (strcmp(g_dbus_proxy_get_path(proxy), monitor->path) != 0)
> > +               return false;
> > +
> > +       return true;
> > +}
> > +
> > +/* Retrieves Type from the remote Adv Monitor object, verifies the value and
> > + * update the local Adv Monitor
> > + */
> > +static bool parse_monitor_type(struct adv_monitor *monitor, const char *path)
> > +{
> > +       DBusMessageIter iter;
> > +       const struct adv_monitor_type *t;
> > +       const char *type_str;
> > +       uint16_t adapter_id = monitor->app->manager->adapter_id;
> > +
> > +       if (!g_dbus_proxy_get_property(monitor->proxy, "Type", &iter)) {
> > +               btd_error(adapter_id, "Failed to retrieve property Type from "
> > +                       "the Adv Monitor at path %s", path);
> > +               return false;
> > +       }
> > +
> > +       if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
> > +               goto failed;
> > +
> > +       dbus_message_iter_get_basic(&iter, &type_str);
> > +
> > +       for (t = supported_types; t->name; t++) {
> > +               if (strcmp(t->name, type_str) == 0) {
> > +                       monitor->type = t->type;
> > +                       return true;
> > +               }
> > +       }
> > +
> > +failed:
> > +       btd_error(adapter_id, "Invalid argument of property Type of the Adv "
> > +                       "Monitor at path %s", path);
> > +
> > +       return false;
> > +}
> > +
> > +/* Retrieves RSSIThresholdsAndTimers from the remote Adv Monitor object,
> > + * verifies the values and update the local Adv Monitor
> > + */
> > +static bool parse_rssi_and_timeout(struct adv_monitor *monitor,
> > +                                       const char *path)
> > +{
> > +       DBusMessageIter prop_struct, iter;
> > +       int16_t h_rssi, l_rssi;
> > +       uint16_t h_rssi_timer, l_rssi_timer;
> > +       uint16_t adapter_id = monitor->app->manager->adapter_id;
> > +
> > +       /* Property RSSIThresholdsAndTimers is optional */
> > +       if (!g_dbus_proxy_get_property(monitor->proxy,
> > +                                       "RSSIThresholdsAndTimers",
> > +                                       &prop_struct)) {
> > +               DBG("Adv Monitor at path %s provides no RSSI thresholds and "
> > +                       "timeouts", path);
> > +               return true;
> > +       }
> > +
> > +       if (dbus_message_iter_get_arg_type(&prop_struct) != DBUS_TYPE_STRUCT)
> > +               goto failed;
> > +
> > +       dbus_message_iter_recurse(&prop_struct, &iter);
> > +
> > +       /* Extract HighRSSIThreshold */
> > +       if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_INT16)
> > +               goto failed;
> > +       dbus_message_iter_get_basic(&iter, &h_rssi);
> > +       if (!dbus_message_iter_next(&iter))
> > +               goto failed;
> > +
> > +       /* Extract HighRSSIThresholdTimer */
> > +       if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_UINT16)
> > +               goto failed;
> > +       dbus_message_iter_get_basic(&iter, &h_rssi_timer);
> > +       if (!dbus_message_iter_next(&iter))
> > +               goto failed;
> > +
> > +       /* Extract LowRSSIThreshold */
> > +       if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_INT16)
> > +               goto failed;
> > +       dbus_message_iter_get_basic(&iter, &l_rssi);
> > +       if (!dbus_message_iter_next(&iter))
> > +               goto failed;
> > +
> > +       /* Extract LowRSSIThresholdTimer */
> > +       if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_UINT16)
> > +               goto failed;
> > +       dbus_message_iter_get_basic(&iter, &l_rssi_timer);
> > +
> > +       /* Verify the values of RSSIs and their timers. For simplicity, we
> > +        * enforce the all-or-none rule to these fields. In other words, either
> > +        * all are set to the unset values or all are set within valid ranges.
> > +        */
> > +       if (h_rssi == ADV_MONITOR_UNSET_RSSI &&
> > +               l_rssi == ADV_MONITOR_UNSET_RSSI &&
> > +               h_rssi_timer == ADV_MONITOR_UNSET_TIMER &&
> > +               l_rssi_timer == ADV_MONITOR_UNSET_TIMER) {
> > +               goto done;
> > +       }
> > +
> > +       if (h_rssi < ADV_MONITOR_MIN_RSSI || h_rssi > ADV_MONITOR_MAX_RSSI ||
> > +               l_rssi < ADV_MONITOR_MIN_RSSI ||
> > +               l_rssi > ADV_MONITOR_MAX_RSSI || h_rssi <= l_rssi) {
> > +               goto failed;
> > +       }
> > +
> > +       if (h_rssi_timer < ADV_MONITOR_MIN_TIMER ||
> > +               h_rssi_timer > ADV_MONITOR_MAX_TIMER ||
> > +               l_rssi_timer < ADV_MONITOR_MIN_TIMER ||
> > +               l_rssi_timer > ADV_MONITOR_MAX_TIMER) {
> > +               goto failed;
> > +       }
> > +
> > +       monitor->high_rssi = h_rssi;
> > +       monitor->low_rssi = l_rssi;
> > +       monitor->high_rssi_timeout = h_rssi_timer;
> > +       monitor->low_rssi_timeout = l_rssi_timer;
> > +
> > +done:
> > +       DBG("Adv Monitor at %s initiated with high RSSI threshold %d, high "
> > +               "RSSI threshold timeout %d, low RSSI threshold %d, low RSSI "
> > +               "threshold timeout %d", path, monitor->high_rssi,
> > +               monitor->high_rssi_timeout, monitor->low_rssi,
> > +               monitor->low_rssi_timeout);
> > +
> > +       return true;
> > +
> > +failed:
> > +       monitor->high_rssi = ADV_MONITOR_UNSET_RSSI;
> > +       monitor->low_rssi = ADV_MONITOR_UNSET_RSSI;
> > +       monitor->high_rssi_timeout = ADV_MONITOR_UNSET_TIMER;
> > +       monitor->low_rssi_timeout = ADV_MONITOR_UNSET_TIMER;
> > +
> > +       btd_error(adapter_id, "Invalid argument of property "
> > +                       "RSSIThresholdsAndTimers of the Adv Monitor at path %s",
> > +                       path);
> > +
> > +       return false;
> > +}
> > +
> > +/* Retrieves Patterns from the remote Adv Monitor object, verifies the values
> > + * and update the local Adv Monitor
> > + */
> > +static bool parse_patterns(struct adv_monitor *monitor, const char *path)
> > +{
> > +       DBusMessageIter array, array_iter;
> > +       uint16_t num_patterns = 0;
> > +       uint16_t adapter_id = monitor->app->manager->adapter_id;
> > +
> > +       if (!g_dbus_proxy_get_property(monitor->proxy, "Patterns", &array)) {
> > +               btd_error(adapter_id, "Failed to retrieve property Patterns "
> > +                               "from the Adv Monitor at path %s", path);
> > +               return false;
> > +       }
> > +
> > +       monitor->patterns = queue_new();
> > +
> > +       if (dbus_message_iter_get_arg_type(&array) != DBUS_TYPE_ARRAY ||
> > +               dbus_message_iter_get_element_type(&array) !=
> > +               DBUS_TYPE_STRUCT) {
> > +               goto failed;
> > +       }
> > +
> > +       dbus_message_iter_recurse(&array, &array_iter);
> > +
> > +       while (dbus_message_iter_get_arg_type(&array_iter) ==
> > +               DBUS_TYPE_STRUCT) {
> > +               int value_len;
> > +               uint8_t *value;
> > +               uint8_t offset, ad_type;
> > +               struct pattern *pattern;
> > +               DBusMessageIter struct_iter, value_iter;
> > +
> > +               dbus_message_iter_recurse(&array_iter, &struct_iter);
> > +
> > +               // Extract start position
> > +               if (dbus_message_iter_get_arg_type(&struct_iter) !=
> > +                       DBUS_TYPE_BYTE) {
> > +                       goto failed;
> > +               }
> > +               dbus_message_iter_get_basic(&struct_iter, &offset);
> > +               if (!dbus_message_iter_next(&struct_iter))
> > +                       goto failed;
> > +
> > +               // Extract AD data type
> > +               if (dbus_message_iter_get_arg_type(&struct_iter) !=
> > +                       DBUS_TYPE_BYTE) {
> > +                       goto failed;
> > +               }
> > +               dbus_message_iter_get_basic(&struct_iter, &ad_type);
> > +               if (!dbus_message_iter_next(&struct_iter))
> > +                       goto failed;
> > +
> > +               // Extract value of a pattern
> > +               if (dbus_message_iter_get_arg_type(&struct_iter) !=
> > +                       DBUS_TYPE_ARRAY) {
> > +                       goto failed;
> > +               }
> > +               dbus_message_iter_recurse(&struct_iter, &value_iter);
> > +               dbus_message_iter_get_fixed_array(&value_iter, &value,
> > +                                                       &value_len);
> > +
> > +               // Verify the values
> > +               if (offset > BT_AD_MAX_DATA_LEN - 1)
> > +                       goto failed;
> > +
> > +               if (ad_type > BT_AD_3D_INFO_DATA &&
> > +                       ad_type != BT_AD_MANUFACTURER_DATA
> > +                       || ad_type < BT_AD_FLAGS) {
> > +                       goto failed;
> > +               }
> > +
> > +               if (!value || value_len <= 0 || value_len > BT_AD_MAX_DATA_LEN)
> > +                       goto failed;
> > +
> > +               pattern = g_new0(struct pattern, 1);
>
> new0
Done.
>
> > +               if (!pattern)
> > +                       goto failed;
> > +
> > +               pattern->ad_type = ad_type;
> > +               pattern->offset = offset;
> > +               pattern->length = value_len;
> > +               g_memmove(pattern->value, value, pattern->length);
>
> This looks wrong, we shouldn't be changing the memory value points to,
> this might be equivalent to memcpy so Id just use that instead.
Done.
>
> > +
> > +               queue_push_tail(monitor->patterns, pattern);
> > +
> > +               dbus_message_iter_next(&array_iter);
> > +       }
> > +
> > +       /* There must be at least one pattern. */
> > +       if (queue_isempty(monitor->patterns))
> > +               goto failed;
> > +
> > +       return true;
> > +
> > +failed:
> > +       queue_destroy(monitor->patterns, pattern_free);
> > +       monitor->patterns = NULL;
> > +
> > +       btd_error(adapter_id, "Invalid argument of property Patterns of the "
> > +                       "Adv Monitor at path %s", path);
> > +
> > +       return false;
> > +}
> > +
> > +/* Processes the content of the remote Adv Monitor */
> > +static bool monitor_process(struct adv_monitor *monitor,
> > +                               struct adv_monitor_app *app)
> > +{
> > +       const char *path = g_dbus_proxy_get_path(monitor->proxy);
> > +
> > +       monitor->state = MONITOR_STATE_FAILED;
> > +
> > +       if (!parse_monitor_type(monitor, path))
> > +               goto done;
> > +
> > +       if (!parse_rssi_and_timeout(monitor, path))
> > +               goto done;
> > +
> > +       if (monitor->type == MONITOR_TYPE_OR_PATTERNS &&
> > +               parse_patterns(monitor, path)) {
> > +               monitor->state = MONITOR_STATE_INITED;
> > +       }
> > +
> > +done:
> > +       return monitor->state != MONITOR_STATE_FAILED;
> > +}
> > +
> > +/* Handles an Adv Monitor D-Bus proxy added event */
> > +static void monitor_proxy_added_cb(GDBusProxy *proxy, void *user_data)
> > +{
> > +       struct adv_monitor *monitor;
> > +       struct adv_monitor_app *app = user_data;
> > +       uint16_t adapter_id = app->manager->adapter_id;
> > +       const char *path = g_dbus_proxy_get_path(proxy);
> > +       const char *iface = g_dbus_proxy_get_interface(proxy);
> > +
> > +       if (strcmp(iface, ADV_MONITOR_INTERFACE) != 0 ||
> > +               !g_str_has_prefix(path, app->path)) {
> > +               return;
> > +       }
> > +
> > +       if (queue_find(app->monitors, monitor_match, proxy)) {
> > +               btd_error(adapter_id, "Adv Monitor proxy already exists with "
> > +                               "path %s", path);
> > +               return;
> > +       }
> > +
> > +       monitor = monitor_new(app, proxy);
> > +       if (!monitor) {
> > +               btd_error(adapter_id, "Failed to allocate an Adv Monitor for "
> > +                               "the object at %s", path);
> > +               return;
> > +       }
> > +
> > +       if (!monitor_process(monitor, app)) {
> > +               monitor_release(monitor, NULL);
> > +               monitor_free(monitor);
> > +               DBG("Adv Monitor at path %s released due to invalid content",
> > +                       path);
> > +               return;
> > +       }
> > +
> > +       queue_push_tail(app->monitors, monitor);
> > +
> > +       DBG("Adv Monitor allocated for the object at path %s", path);
> > +}
> > +
> > +/* Handles the removal of an Adv Monitor D-Bus proxy */
> > +static void monitor_proxy_removed_cb(GDBusProxy *proxy, void *user_data)
> > +{
> > +       struct adv_monitor *monitor;
> > +       struct adv_monitor_app *app = user_data;
> > +
> > +       monitor = queue_remove_if(app->monitors, monitor_match, proxy);
> > +       if (monitor) {
> > +               DBG("Adv Monitor removed for the object at path %s",
> > +                       monitor->path);
> > +
> > +               /* The object was gone, so we don't need to call Release() */
> > +               monitor_free(monitor);
> > +       }
> > +}
> > +
> >  /* Creates an app object, initiates it and sets D-Bus event handlers */
> >  static struct adv_monitor_app *app_create(DBusConnection *conn,
> >                                         DBusMessage *msg, const char *sender,
> > @@ -165,8 +634,17 @@ static struct adv_monitor_app *app_create(DBusConnection *conn,
> >                 return NULL;
> >         }
> >
> > +       app->monitors = queue_new();
> > +
> >         g_dbus_client_set_disconnect_watch(app->client, app_disconnect_cb, app);
> > -       g_dbus_client_set_proxy_handlers(app->client, NULL, NULL, NULL, NULL);
> > +
> > +       /* Note that any property changes on a monitor object would not affect
> > +        * the content of the corresponding monitor.
> > +        */
> > +       g_dbus_client_set_proxy_handlers(app->client, monitor_proxy_added_cb,
> > +                                               monitor_proxy_removed_cb, NULL,
> > +                                               app);
> > +
> >         g_dbus_client_set_ready_watch(app->client, app_ready_cb, app);
> >
> >         app->reg = dbus_message_ref(msg);
> > @@ -273,18 +751,6 @@ static const GDBusMethodTable adv_monitor_methods[] = {
> >         { }
> >  };
> >
> > -enum monitor_type {
> > -       MONITOR_TYPE_OR_PATTERNS,
> > -};
> > -
> > -const struct adv_monitor_type {
> > -       enum monitor_type type;
> > -       const char *name;
> > -} supported_types[] = {
> > -       { MONITOR_TYPE_OR_PATTERNS, "or_patterns" },
> > -       { },
> > -};
> > -
> >  /* Gets SupportedMonitorTypes property */
> >  static gboolean get_supported_monitor_types(const GDBusPropertyTable *property,
> >                                                 DBusMessageIter *iter,
> > --
> > 2.26.2
> >
>
>
> --
> Luiz Augusto von Dentz

Thanks,
Miao
