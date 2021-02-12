Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBD4C433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Feb 2021 01:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C68364E3D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Feb 2021 01:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhBLB7W (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Feb 2021 20:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhBLB7R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Feb 2021 20:59:17 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A961C061756
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Feb 2021 17:58:37 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id r75so8424948oie.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Feb 2021 17:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PuKsIFQ2yur6CXnrJyDjm5OHR20Vg66EHl1odneBJnM=;
        b=VRT4l14IdglefgTFPldsK5l0ziNsfo+PpyyD0ZYPIgHTKGT3S6oyUmn2QxdaGEoa59
         EGbKj38D/QsbhV3V4ZGTJd7/GftCbSWFr9RzZHXA+sSu7AxSfLfInZOzJszQO9VtiaVe
         W34PpHXa1dtslAS5Wgk5QsiV4tUTohFd/uhoTJvXLIxdh/3TCGsApjWzjnnnbT9fwiNI
         VZcVcddjbayQj3i6y7tzjmyvXuSgLNJJbdIx2xtrXU57ZFPUL/hHRuB5HIOkS9MwQxrQ
         aWYmKb/KAoKZWbdrkiv+DYcFOHBHwohSZmD7sJ0sA1QewAj05KFJqIdcuppIhuNlRJjT
         Tnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PuKsIFQ2yur6CXnrJyDjm5OHR20Vg66EHl1odneBJnM=;
        b=rBz+88MeNxkYeoC2HVMgfx9p20yJLkFCE5qDHoybew19XcRY7DXn4lkzYc5zQKT7aF
         qrrn2TvpuZqv6PanGMkp3Edpai7D6pJpx98fvnyM/4pb9EOdwTbp43K6zcs4IW1zErwv
         8QsDRJntbuX7T6FWPg0wevbIFPI27V+vbVtyLUXLpjLqAFe0KnlAQOr9NwNEtMJIZKo1
         +lFAa5K9lnoQz2THuwnKtPN1iC2/4bsZxS5xsDnHL2tD31f9wNKfqPygpnjCjn4gcosW
         JPnuNqx4s66V+5OxXMTLv7i0wnJG8E9OaSSvEhNMNsJmjcLH4xeZS63w58DCGha+VaUB
         O+Jw==
X-Gm-Message-State: AOAM533DgFvmFtSxUnFddgawzt+E9xoGO5Vb87Duvjv181PnDWvi5tju
        7oDi8JAHhb4IRufTG+zlk+t/2wZtNtXpglppYbA=
X-Google-Smtp-Source: ABdhPJw6KcsWz5d/GK3toEDjIYan+lOyUtHjCqMLevkYg0SbjVbR1Ki60sNS7rMBsP63oJmgtajLSn3SDsd2C/hZAR8=
X-Received: by 2002:aca:c109:: with SMTP id r9mr462801oif.64.1613095116900;
 Thu, 11 Feb 2021 17:58:36 -0800 (PST)
MIME-Version: 1.0
References: <20210211172813.BlueZ.v1.1.I0b1ea92cf6c47ac45a2b3b9264b6b64fb8437442@changeid>
In-Reply-To: <20210211172813.BlueZ.v1.1.I0b1ea92cf6c47ac45a2b3b9264b6b64fb8437442@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 11 Feb 2021 17:58:25 -0800
Message-ID: <CABBYNZ+pgtoSzLyHh5kwfyAU+LpJRi5FngwJ8y_qVkopU-WORA@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1] adapter: Add adapter cleanup watchdog
To:     Miao-chen Chou <mcchou@chromium.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Miao,

On Thu, Feb 11, 2021 at 5:33 PM Miao-chen Chou <mcchou@chromium.org> wrote:
>
> This adds a watchdog timer to prevent race caused by rapid index_added()
> event following index_removed() event during system resume. The issue
> can happen on the platform where the power of controller would be cut
> off when the system goes to suspend. If there is an audio device paired
> and connected before the suspend, there is a chance that index_added()
> event happens before the device is fully torn down. The D-Bus interface
> of the same device cannot be added during the loading of paired device,
> and then the session_cb() of AVDTP arrives and triggers device_free().
> The symptom is that device wouldn't be presented to D-Bus interface at
> all.
>
> The watchdog timeout is set to 1000 ms based on AVDTP disconnection
> timeout. The experiments shows that it took about ~50ms for session_cb()
> to arrive after index_removed().

Is this the grace time that we take from avdtp_unref to disconnect:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/profiles/audio/avdtp.c#n1208

I think we should actually inform the driver when the adapter is
removed so they can release any reference to the device they may have
or retry connecting, etc. Do you know which reference prevents the
device to be freed.

> The following test steps were performed:
> (1) Pair and connect to Bose QC35
> (2) Call powerd_dbus_suspend
> (3) Suspend the device, wait for 30 seconds and resume the device.
> (4) Verify if device shows up on the paired device list.
>
> ---
> Hi BlueZ Maintainers,
>
> This issue was discovered during a platform bring-up where the reload of
> the Bluetooth firmware is fast enough and index_added() arrives before
> the torn-down of an audio device.
>
> Chrome OS Bluetooth Team
>
>  src/adapter.c | 131 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 130 insertions(+), 1 deletion(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index c1f976323..e0ee16085 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -86,6 +86,11 @@
>  #define DISTANCE_VAL_INVALID   0x7FFF
>  #define PATHLOSS_MAX           137
>
> +/* The unit is millisecons, and the value refers to the disconnection timeout
> + * of AVDTP session.
> + */
> +#define CLEANUP_WATCHDOG_TIMEOUT       1000
> +
>  /*
>   * These are known security keys that have been compromised.
>   * If this grows or there are needs to be platform specific, it is
> @@ -121,6 +126,13 @@ static GSList *adapter_drivers = NULL;
>  static GSList *disconnect_list = NULL;
>  static GSList *conn_fail_list = NULL;
>
> +/* Watchdog timer of rapid index added after index removed */
> +static guint cleanup_watchdog_timer;
> +/* List of struct cleanup_watchdog, used to prevent rapid index added after
> + * index removed.
> + */
> +static struct queue *cleanup_watchdogs;
> +
>  struct link_key_info {
>         bdaddr_t bdaddr;
>         unsigned char key[16];
> @@ -288,6 +300,14 @@ typedef enum {
>         ADAPTER_AUTHORIZE_CHECK_CONNECTED
>  } adapter_authorize_type;
>
> +struct cleanup_watchdog {
> +       uint16_t index;         /* adapter index */
> +       time_t target_ts;       /* targeted timestamp for index added to be
> +                                * triggered
> +                                */
> +       bool should_add;
> +};
> +
>  static struct btd_adapter *btd_adapter_lookup(uint16_t index)
>  {
>         GList *list;
> @@ -517,6 +537,9 @@ static void adapter_stop(struct btd_adapter *adapter);
>  static void trigger_passive_scanning(struct btd_adapter *adapter);
>  static bool set_mode(struct btd_adapter *adapter, uint16_t opcode,
>                                                         uint8_t mode);
> +static void index_added(uint16_t index, uint16_t length, const void *param,
> +                                                       void *user_data);
> +static gboolean expire_cleanup_watchdog(gpointer user_data);
>
>  static void settings_changed(struct btd_adapter *adapter, uint32_t settings)
>  {
> @@ -5319,9 +5342,81 @@ static void remove_discovery_list(struct btd_adapter *adapter)
>         adapter->discovery_list = NULL;
>  }
>
> +static void cleanup_watchdog_free(void *data)
> +{
> +       struct cleanup_watchdog *watchdog = data;
> +
> +       free(watchdog);
> +}
> +
> +static void start_cleanup_watchdog_timer(time_t current_ts)
> +{
> +       double diff_ts;
> +       struct cleanup_watchdog *watchdog;
> +
> +       if (cleanup_watchdog_timer)
> +               return;
> +
> +       watchdog = queue_peek_head(cleanup_watchdogs);
> +       if (!watchdog)
> +               return;
> +
> +       diff_ts = difftime(watchdog->target_ts, current_ts) * 1000;
> +       cleanup_watchdog_timer = g_timeout_add(diff_ts, expire_cleanup_watchdog,
> +                                               NULL);
> +
> +       DBG("Cleanup watchdog timer set for adapter %u with %f ms",
> +               watchdog->index, diff_ts);
> +}
> +
> +static gboolean expire_cleanup_watchdog(gpointer user_data)
> +{
> +       time_t current_ts;
> +       struct cleanup_watchdog *watchdog;
> +
> +       g_source_remove(cleanup_watchdog_timer);
> +       cleanup_watchdog_timer = 0;
> +
> +       time(&current_ts);
> +
> +       while (watchdog = queue_peek_head(cleanup_watchdogs)) {
> +               if (watchdog->target_ts <= current_ts) {
> +                       queue_pop_head(cleanup_watchdogs);
> +
> +                       DBG("expire cleanup watchdog for adapter %u",
> +                               watchdog->index);
> +
> +                       if (watchdog->should_add)
> +                               index_added(watchdog->index, 0, NULL, NULL);
> +
> +                       cleanup_watchdog_free(watchdog);
> +               } else {
> +                       start_cleanup_watchdog_timer(current_ts);
> +                       return FALSE;
> +               }
> +       }
> +
> +       return FALSE;
> +}
> +
> +static bool match_cleanup_watchdog_by_index(const void *data,
> +                                               const void *user_data)
> +{
> +       const uint16_t *index = user_data;
> +       const struct cleanup_watchdog *watchdog = data;
> +
> +       if (!watchdog || !index)
> +               return false;
> +
> +       return watchdog->index == *index;
> +}
> +
>  static void adapter_free(gpointer user_data)
>  {
> +       struct cleanup_watchdog *watchdog;
>         struct btd_adapter *adapter = user_data;
> +       time_t current_ts;
> +       uint16_t index = adapter->dev_id;
>
>         DBG("%p", adapter);
>
> @@ -5384,6 +5479,23 @@ static void adapter_free(gpointer user_data)
>         g_free(adapter->current_alias);
>         free(adapter->modalias);
>         g_free(adapter);
> +
> +       DBG("Set cleanup watchdog for adapter %u", index);
> +       watchdog = queue_find(cleanup_watchdogs,
> +                               match_cleanup_watchdog_by_index, NULL);
> +       if (watchdog) {
> +               queue_remove(cleanup_watchdogs, watchdog);
> +       } else {
> +               watchdog = new0(struct cleanup_watchdog, 1);
> +               watchdog->index = index;
> +       }
> +
> +       time(&current_ts);
> +       watchdog->should_add = false;
> +       watchdog->target_ts = current_ts + (CLEANUP_WATCHDOG_TIMEOUT / 1000);
> +
> +       queue_push_tail(cleanup_watchdogs, watchdog);
> +       start_cleanup_watchdog_timer(current_ts);
>  }
>
>  struct btd_adapter *btd_adapter_ref(struct btd_adapter *adapter)
> @@ -9568,6 +9680,18 @@ static void index_added(uint16_t index, uint16_t length, const void *param,
>                                                         void *user_data)
>  {
>         struct btd_adapter *adapter;
> +       struct cleanup_watchdog *watchdog;
> +
> +       if (!!cleanup_watchdog_timer) {
> +               watchdog = queue_find(cleanup_watchdogs,
> +                                       match_cleanup_watchdog_by_index,
> +                                       &index);
> +               if (watchdog) {
> +                       warn("Postpone adding adapter %u", index);
> +                       watchdog->should_add = true;
> +                       return;
> +               }
> +       }
>
>         DBG("index %u", index);
>
> @@ -9829,8 +9953,10 @@ int adapter_init(void)
>
>         if (mgmt_send(mgmt_master, MGMT_OP_READ_VERSION,
>                                 MGMT_INDEX_NONE, 0, NULL,
> -                               read_version_complete, NULL, NULL) > 0)
> +                               read_version_complete, NULL, NULL) > 0) {
> +               cleanup_watchdogs = queue_new();
>                 return 0;
> +       }
>
>         error("Failed to read management version information");
>
> @@ -9880,6 +10006,9 @@ void adapter_shutdown(void)
>
>         DBG("");
>
> +       queue_destroy(cleanup_watchdogs, cleanup_watchdog_free);
> +       cleanup_watchdogs = NULL;
> +
>         powering_down = true;
>
>         for (list = g_list_first(adapter_list); list;
> --
> 2.30.0.478.g8a0d178c01-goog
>


-- 
Luiz Augusto von Dentz
