Return-Path: <SRS0=7SIp=DO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06214C4363C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Oct 2020 06:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E09E208C7
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Oct 2020 06:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVKINKuZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgJGGVi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Oct 2020 02:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgJGGVi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Oct 2020 02:21:38 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74602C061755
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2020 23:21:38 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id z26so1254477oih.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2020 23:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K0YMpfMu4CzAZWyJuaaELOi60/QF70TWWjuC6mlj140=;
        b=oVKINKuZEVk+I5VnLU4uJ9A9VBpNXYGyiKMlQg8/eoUi+YbtxK6Epm7SVmxSjtJht5
         QH+3BQ9o8ePHhAz57BQckUzdaT8ysnN3j4PQml3ipvIroI5t1YOyFhNg3rREbOFeebLJ
         P2610YFZPf7q2m4uIzZ2fcWLArpQh0pQUBIxRybZ6QvCMqYd2SffvJHiKm+9uoMyAqWl
         t2qPUGgAoF6SZXUiFCakfk5ZYLMKPXpO7iB7EovLSaOCvSYj3rdSWzZe/2/bp9Q8A+Z/
         u1Ma69AUcS2HrV6BPKxvxuAgZPTsD8MR5yIK1Aa7kZfKjbzdPdsE82sc/am53q/P7EcT
         enMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K0YMpfMu4CzAZWyJuaaELOi60/QF70TWWjuC6mlj140=;
        b=ZUOFLUn3sq5YGXXx35iQjiqNgtO8nrEdwQhtXARA8hIc2G7ajxdYCm8vLdOHeORVO7
         fY1EPHb4dND2UeiEKIblG1p5zGXCLS0bm6oJNwHviAv6mrB64Xz+8i87gSny2UC6fPPD
         9IKKAHsNIovtyDxFzP67YLZFytPzGP1dPzMTTwV8N2sR7rZAnD0qiMQZxrco4VeBotj9
         jqerq2wCdQDYjNTP4qE1hyplRnPZK6Q5n199AapmtCqs+wj99MtIObs5HVLICdYSWuaD
         02tbfJWv7vAU/OnNJDdMFHO9IpJCahnXY0ft2Mq+YSC/aZLYuKqucd9sFZ+8914xTK/u
         pTRQ==
X-Gm-Message-State: AOAM532UFsO18Gp5ZzO0VNx13T5qKESe+IwQi1tq1Jn5/PwAVURXfwSd
        K7F34FweB/o9jQZOpd4AAafMTVWSIFcg2SzOiD0=
X-Google-Smtp-Source: ABdhPJwgw9Fh+aJyhkbo8xxgl8wiToUbzyr6Iybsl5IrtQaCBDKpL+ZHOsrh5ztmPl7nOu4j64NtCRxW/On3qBIH9KI=
X-Received: by 2002:aca:30d4:: with SMTP id w203mr1035936oiw.64.1602051697459;
 Tue, 06 Oct 2020 23:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201006171333.BlueZ.v6.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
 <20201006171333.BlueZ.v6.2.I578ae5e76fcf7243206a27d4f5a25783662a5f14@changeid>
In-Reply-To: <20201006171333.BlueZ.v6.2.I578ae5e76fcf7243206a27d4f5a25783662a5f14@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 6 Oct 2020 23:21:24 -0700
Message-ID: <CABBYNZ+pmByP5WMibCGQJXTvy7ephJdJdALg=mYagzAjWMLk9w@mail.gmail.com>
Subject: Re: [BlueZ PATCH v6 2/6] adv_monitor: Implement Adv matching based on
 stored monitors
To:     Miao-chen Chou <mcchou@chromium.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Miao,

On Tue, Oct 6, 2020 at 5:17 PM Miao-chen Chou <mcchou@chromium.org> wrote:
>
> This implements create an entry point in adapter to start the matching of
> Adv based on all monitors and invoke the RSSI tracking for Adv reporting.
>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Reviewed-by: Alain Michaud <alainm@chromium.org>
> Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
> ---
>
> Changes in v6:
> - Fix the termination condition of AD data paring and remove unnecessary
> length check
>
> Changes in v5:
> - Remove unittest helper functions
>
> Changes in v3:
> - Remove unused variables
> - Fix signature of queue_find()
>
>  src/adapter.c     |  35 ++++++--
>  src/adv_monitor.c | 219 ++++++++++++++++++++++++++++++++++++++++------
>  src/adv_monitor.h |  12 +++
>  3 files changed, 234 insertions(+), 32 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 6d0114a6b..fdd9b3808 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -6601,6 +6601,15 @@ static void update_found_devices(struct btd_adapter *adapter,
>         bool name_known, discoverable;
>         char addr[18];
>         bool duplicate = false;
> +       GSList *matched_monitors;
> +
> +       /* During the background scanning, update the device only when the data
> +        * match at least one Adv monitor
> +        */
> +       matched_monitors = btd_adv_monitor_content_filter(
> +                               adapter->adv_monitor_manager, data, data_len);
> +       if (!adapter->discovering && !matched_monitors)
> +               return;
>
>         memset(&eir_data, 0, sizeof(eir_data));
>         eir_parse(&eir_data, data, data_len);
> @@ -6646,18 +6655,22 @@ static void update_found_devices(struct btd_adapter *adapter,
>                 device_store_cached_name(dev, eir_data.name);
>
>         /*
> -        * Only skip devices that are not connected, are temporary and there
> -        * is no active discovery session ongoing.
> +        * Only skip devices that are not connected, are temporary, and there
> +        * is no active discovery session ongoing and no matched Adv monitors
>          */
> -       if (!btd_device_is_connected(dev) && (device_is_temporary(dev) &&
> -                                                !adapter->discovery_list)) {
> +       if (!btd_device_is_connected(dev) &&
> +               (device_is_temporary(dev) && !adapter->discovery_list) &&
> +               !matched_monitors) {
>                 eir_data_free(&eir_data);
>                 return;
>         }
>
> -       /* Don't continue if not discoverable or if filter don't match */
> -       if (!discoverable || (adapter->filtered_discovery &&
> -           !is_filter_match(adapter->discovery_list, &eir_data, rssi))) {
> +       /* If there is no matched Adv monitors, don't continue if not
> +        * discoverable or if active discovery filter don't match.
> +        */
> +       if (!matched_monitors && (!discoverable ||
> +               (adapter->filtered_discovery && !is_filter_match(
> +                               adapter->discovery_list, &eir_data, rssi)))) {
>                 eir_data_free(&eir_data);
>                 return;
>         }
> @@ -6714,6 +6727,14 @@ static void update_found_devices(struct btd_adapter *adapter,
>
>         eir_data_free(&eir_data);
>
> +       /* After the device is updated, notify the matched Adv monitors */
> +       if (matched_monitors) {
> +               btd_adv_monitor_notify_monitors(adapter->adv_monitor_manager,
> +                                               dev, rssi, matched_monitors);
> +               g_slist_free(matched_monitors);
> +               matched_monitors = NULL;
> +       }
> +
>         /*
>          * Only if at least one client has requested discovery, maintain
>          * list of found devices and name confirming for legacy devices.
> diff --git a/src/adv_monitor.c b/src/adv_monitor.c
> index 31ed30a00..fcb127cd4 100644
> --- a/src/adv_monitor.c
> +++ b/src/adv_monitor.c
> @@ -29,15 +29,12 @@
>  #include "device.h"
>  #include "log.h"
>  #include "src/error.h"
> -#include "src/shared/ad.h"
>  #include "src/shared/mgmt.h"
>  #include "src/shared/queue.h"
>  #include "src/shared/util.h"
>
>  #include "adv_monitor.h"
>
> -static void monitor_device_free(void *data);
> -
>  #define ADV_MONITOR_INTERFACE          "org.bluez.AdvertisementMonitor1"
>  #define ADV_MONITOR_MGR_INTERFACE      "org.bluez.AdvertisementMonitorManager1"
>
> @@ -84,7 +81,7 @@ enum monitor_state {
>         MONITOR_STATE_HONORED,  /* Accepted by kernel */
>  };
>
> -struct pattern {
> +struct btd_adv_monitor_pattern {
>         uint8_t ad_type;
>         uint8_t offset;
>         uint8_t length;
> @@ -133,6 +130,23 @@ struct app_match_data {
>         const char *path;
>  };
>
> +struct adv_content_filter_info {
> +       uint8_t eir_len;
> +       const uint8_t *eir;
> +
> +       bool matched;                   /* Intermediate state per monitor */
> +       GSList *matched_monitors;       /* List of matched monitors */

Please use struct queue on new code.

> +};
> +
> +struct adv_rssi_filter_info {
> +       struct btd_device *device;
> +       int8_t rssi;
> +};
> +
> +static void monitor_device_free(void *data);
> +static void adv_monitor_filter_rssi(struct adv_monitor *monitor,
> +                                       struct btd_device *device, int8_t rssi);
> +
>  const struct adv_monitor_type {
>         enum monitor_type type;
>         const char *name;
> @@ -155,7 +169,7 @@ static void app_reply_msg(struct adv_monitor_app *app, DBusMessage *reply)
>  /* Frees a pattern */
>  static void pattern_free(void *data)
>  {
> -       struct pattern *pattern = data;
> +       struct btd_adv_monitor_pattern *pattern = data;
>
>         if (!pattern)
>                 return;
> @@ -435,6 +449,36 @@ failed:
>         return false;
>  }
>
> +/* Allocates and initiates a pattern with the given content */
> +static struct btd_adv_monitor_pattern *pattern_create(
> +       uint8_t ad_type, uint8_t offset, uint8_t length, const uint8_t *value)
> +{
> +       struct btd_adv_monitor_pattern *pattern;
> +
> +       if (offset > BT_AD_MAX_DATA_LEN - 1)
> +               return NULL;
> +
> +       if ((ad_type > BT_AD_3D_INFO_DATA &&
> +               ad_type != BT_AD_MANUFACTURER_DATA) ||
> +               ad_type < BT_AD_FLAGS) {
> +               return NULL;
> +       }
> +
> +       if (!value || !length || offset + length > BT_AD_MAX_DATA_LEN)
> +               return NULL;
> +
> +       pattern = new0(struct btd_adv_monitor_pattern, 1);
> +       if (!pattern)
> +               return NULL;
> +
> +       pattern->ad_type = ad_type;
> +       pattern->offset = offset;
> +       pattern->length = length;
> +       memcpy(pattern->value, value, pattern->length);

I wonder why you didn't add pattern matching into bt_ad directly, that
should make it simpler to unit test such feature and enable using in
other tools as well.

> +       return pattern;
> +}
> +
>  /* Retrieves Patterns from the remote Adv Monitor object, verifies the values
>   * and update the local Adv Monitor
>   */
> @@ -464,7 +508,7 @@ static bool parse_patterns(struct adv_monitor *monitor, const char *path)
>                 int value_len;
>                 uint8_t *value;
>                 uint8_t offset, ad_type;
> -               struct pattern *pattern;
> +               struct btd_adv_monitor_pattern *pattern;
>                 DBusMessageIter struct_iter, value_iter;
>
>                 dbus_message_iter_recurse(&array_iter, &struct_iter);
> @@ -496,28 +540,10 @@ static bool parse_patterns(struct adv_monitor *monitor, const char *path)
>                 dbus_message_iter_get_fixed_array(&value_iter, &value,
>                                                         &value_len);
>
> -               // Verify the values
> -               if (offset > BT_AD_MAX_DATA_LEN - 1)
> -                       goto failed;
> -
> -               if ((ad_type > BT_AD_3D_INFO_DATA &&
> -                       ad_type != BT_AD_MANUFACTURER_DATA) ||
> -                       ad_type < BT_AD_FLAGS) {
> -                       goto failed;
> -               }
> -
> -               if (!value || value_len <= 0 || value_len > BT_AD_MAX_DATA_LEN)
> -                       goto failed;
> -
> -               pattern = new0(struct pattern, 1);
> +               pattern = pattern_create(ad_type, offset, value_len, value);
>                 if (!pattern)
>                         goto failed;
>
> -               pattern->ad_type = ad_type;
> -               pattern->offset = offset;
> -               pattern->length = value_len;
> -               memcpy(pattern->value, value, pattern->length);
> -
>                 queue_push_tail(monitor->patterns, pattern);
>
>                 dbus_message_iter_next(&array_iter);
> @@ -952,6 +978,149 @@ void btd_adv_monitor_manager_destroy(struct btd_adv_monitor_manager *manager)
>         manager_destroy(manager);
>  }
>
> +static bool pattern_match(const uint8_t *eir, uint8_t eir_len,
> +                               const struct btd_adv_monitor_pattern *pattern)
> +{
> +       const uint8_t *data;
> +       uint8_t idx = 0;
> +       uint8_t field_len, data_len, data_type;
> +
> +       while (idx < eir_len - 1) {
> +               field_len = eir[0];
> +
> +               /* Check for the end of EIR */
> +               if (field_len == 0)
> +                       break;
> +
> +               idx += field_len + 1;
> +
> +               /* Do not continue filtering if got incorrect length */
> +               if (idx > eir_len)
> +                       break;
> +
> +               data = &eir[2];
> +               data_type = eir[1];
> +               data_len = field_len - 1;
> +
> +               eir += field_len + 1;
> +
> +               if (data_type != pattern->ad_type)
> +                       continue;
> +
> +               if (data_len < pattern->offset + pattern->length)
> +                       continue;
> +
> +               if (!memcmp(data + pattern->offset, pattern->value,
> +                               pattern->length))
> +                       return true;
> +       }

Perhaps something like:

struct bt_ad *bt_ad_new_with_data(uint8_t *data, uint8_t len);

and

bool bt_ad_has_pattern(struct bt_ad *ad, const struct bt_ad_pattern *pattern);

> +       return false;
> +}
> +
> +/* Processes the content matching based on a pattern */
> +static void adv_match_per_pattern(void *data, void *user_data)
> +{
> +       struct btd_adv_monitor_pattern *pattern = data;
> +       struct adv_content_filter_info *info = user_data;
> +
> +       if (!pattern || info->matched)
> +               return;
> +
> +       info->matched = pattern_match(info->eir, info->eir_len, pattern);
> +}
> +
> +/* Processes the content matching based pattern(s) of a monitor */
> +static void adv_match_per_monitor(void *data, void *user_data)
> +{
> +       struct adv_monitor *monitor = data;
> +       struct adv_content_filter_info *info = user_data;
> +
> +       if (!monitor && monitor->state != MONITOR_STATE_HONORED)
> +               return;
> +
> +       /* Reset the intermediate matched status */
> +       info->matched = false;
> +
> +       if (monitor->type == MONITOR_TYPE_OR_PATTERNS) {
> +               queue_foreach(monitor->patterns, adv_match_per_pattern, info);
> +               if (info->matched)
> +                       goto matched;
> +       }
> +
> +       return;
> +
> +matched:
> +       info->matched_monitors = g_slist_prepend(info->matched_monitors,
> +                                                       monitor);
> +}
> +
> +/* Processes the content matching for the monitor(s) of an app */
> +static void adv_match_per_app(void *data, void *user_data)
> +{
> +       struct adv_monitor_app *app = data;
> +
> +       if (!app)
> +               return;
> +
> +       queue_foreach(app->monitors, adv_match_per_monitor, user_data);
> +}
> +
> +/* Processes the content matching for every app without RSSI filtering and
> + * notifying monitors. The caller is responsible of releasing the memory of the
> + * list but not the data.
> + * Returns the list of monitors whose content match eir.
> + */
> +GSList *btd_adv_monitor_content_filter(struct btd_adv_monitor_manager *manager,
> +                                       const uint8_t *eir, uint8_t eir_len)
> +{
> +       struct adv_content_filter_info info;
> +
> +       if (!manager || !eir || !eir_len)
> +               return NULL;
> +
> +       info.eir_len = eir_len;
> +       info.eir = eir;
> +       info.matched_monitors = NULL;
> +
> +       queue_foreach(manager->apps, adv_match_per_app, &info);
> +
> +       return info.matched_monitors;
> +}
> +
> +/* Wraps adv_monitor_filter_rssi() to processes the content-matched monitor with
> + * RSSI filtering and notifies it on device found/lost event
> + */
> +static void monitor_filter_rssi(gpointer a, gpointer b)
> +{
> +       struct adv_monitor *monitor = a;
> +       struct adv_rssi_filter_info *info = b;
> +
> +       if (!monitor || !info)
> +               return;
> +
> +       adv_monitor_filter_rssi(monitor, info->device, info->rssi);
> +}
> +
> +/* Processes every content-matched monitor with RSSI filtering and notifies on
> + * device found/lost event. The caller is responsible of releasing the memory
> + * of matched_monitors list but not its data.
> + */
> +void btd_adv_monitor_notify_monitors(struct btd_adv_monitor_manager *manager,
> +                                       struct btd_device *device, int8_t rssi,
> +                                       GSList *matched_monitors)
> +{
> +       struct adv_rssi_filter_info info;
> +
> +       if (!manager || !device || !matched_monitors)
> +               return;
> +
> +       info.device = device;
> +       info.rssi = rssi;
> +
> +       g_slist_foreach(matched_monitors, monitor_filter_rssi, &info);
> +}
> +
>  /* Matches a device based on btd_device object */
>  static bool monitor_device_match(const void *a, const void *b)
>  {
> diff --git a/src/adv_monitor.h b/src/adv_monitor.h
> index 13d5d7282..e2482e11e 100644
> --- a/src/adv_monitor.h
> +++ b/src/adv_monitor.h
> @@ -11,16 +11,28 @@
>  #ifndef __ADV_MONITOR_H
>  #define __ADV_MONITOR_H
>
> +#include <glib.h>
> +
> +#include "src/shared/ad.h"
> +
>  struct mgmt;
>  struct btd_device;
>  struct btd_adapter;
>  struct btd_adv_monitor_manager;
> +struct btd_adv_monitor_pattern;
>
>  struct btd_adv_monitor_manager *btd_adv_monitor_manager_create(
>                                                 struct btd_adapter *adapter,
>                                                 struct mgmt *mgmt);
>  void btd_adv_monitor_manager_destroy(struct btd_adv_monitor_manager *manager);
>
> +GSList *btd_adv_monitor_content_filter(struct btd_adv_monitor_manager *manager,
> +                                       const uint8_t *eir, uint8_t eir_len);
> +
> +void btd_adv_monitor_notify_monitors(struct btd_adv_monitor_manager *manager,
> +                                       struct btd_device *device, int8_t rssi,
> +                                       GSList *matched_monitors);
> +
>  void btd_adv_monitor_device_remove(struct btd_adv_monitor_manager *manager,
>                                    struct btd_device *device);
>
> --
> 2.26.2
>


-- 
Luiz Augusto von Dentz
