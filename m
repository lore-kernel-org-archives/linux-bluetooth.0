Return-Path: <SRS0=Sobe=CX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917ACC2BBD1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Sep 2020 20:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11D36207EA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Sep 2020 20:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQu9R27P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgINUAB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Sep 2020 16:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgINT77 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Sep 2020 15:59:59 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B306C06174A
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2020 12:59:59 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id i17so1151708oig.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2020 12:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zGN5I9LgHN+DhLe8/+o3YXmY2cN3FrYdeDnwLsEJz4Q=;
        b=IQu9R27Pw5uLu3gnj7q6zsiHQBgLSM9iMUCXQzvljntSFdn/yk4MRO9pwpsvsTRYLA
         Zfy6YQ4RiPXfu9IPkqL1dXAm5NlPpRird7HRT8dPLwI8/AXg1p+PxUxd2oz3bu+IBYtl
         b5jpeibX+Xd6ltITwL78JTvlcyKMOM9MxOIfWqcbzIVVEowYTObJvB+0GDNWMVeC1uaV
         hhQsZcrrRclyJ5cYQfQMcRrNz18ye6lEy+BRFtD2huP7JggiXbmrtma9X5umsH1JUD+o
         5qAwhlWqUzOeyrBUf0W/Ckmi8oEJsqe5kHiwc+VHqTRQbf4tLLaztHi4mfSGw7KS2Tqk
         RpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zGN5I9LgHN+DhLe8/+o3YXmY2cN3FrYdeDnwLsEJz4Q=;
        b=ay1xdSztSszyZRXIdiUyG+lBvd+xiOE4wY5EdY7TdHmph59Q1BOcdEVX61yHFByAWh
         DF/zDZ+49QKoMNLBIhH7aGi931V+Lp5JL3K1CqjNNIQ02bESIBqFblBcLUf0ykJKLai6
         Igqd7yWBH1Dd5fYFNyqqzu0O1ltq3/CN6BVy3JVcH2PDO9OSX4E7HU7Ze0RJKNSf94Az
         3hZfUjZbjyptyLNjYZwt/kuDiHJyfzBlAphlo1V5F9IoI6qmPMLAVA47qsJqFFHAJNb4
         v0M08pxYTM9P3QyCL0fB8dJJZM9lUGg80DjFO9UwLtK+skE3TOoH7yIDlOXAKtyLMtnK
         GqpA==
X-Gm-Message-State: AOAM530yjb6Ir5fcPHdg50neCDwBZ579eK9yEg6iEDLrreBNO0VbbPXo
        5RK+6njfPg3jvKUkVpjefngUwvRnXT8ZJdkmbq8SWrny
X-Google-Smtp-Source: ABdhPJza6u9FYFjtOGAUSZUNoOcT1KiUZD3544Ai50+TVGzs9ArpKuapy5KMzMIgGcyAca56J6t3u6ktmRUhv6RB63Y=
X-Received: by 2002:aca:aad0:: with SMTP id t199mr691787oie.48.1600113598290;
 Mon, 14 Sep 2020 12:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200911223037.4127188-1-abhishekpandit@chromium.org> <20200911153010.Bluez.v4.1.Ib9712d2bf5d4b3f90c5bc835742aea8c7cd239e4@changeid>
In-Reply-To: <20200911153010.Bluez.v4.1.Ib9712d2bf5d4b3f90c5bc835742aea8c7cd239e4@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 14 Sep 2020 12:59:47 -0700
Message-ID: <CABBYNZKk=tgUgF6UrYfGxS5fv9b9WBbFAo-iZiMe9z1OECJUEQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v4 1/4] adapter: Refactor kernel feature globals
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

On Fri, Sep 11, 2020 at 3:30 PM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> Move all the kernel specific feature globals into a single
> kernel_features bitfield and replace all uses with the bitfield instead.
> ---
>
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
>
>  src/adapter.c | 59 ++++++++++++++++++++++++++-------------------------
>  src/adapter.h |  9 ++++++++
>  2 files changed, 39 insertions(+), 29 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 1435e2bd7..e700a78d5 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -116,13 +116,7 @@ static const struct mgmt_blocked_key_info blocked_keys[] = {
>
>  static DBusConnection *dbus_conn = NULL;
>
> -static bool kernel_conn_control = false;
> -
> -static bool kernel_blocked_keys_supported = false;
> -
> -static bool kernel_set_system_config = false;
> -
> -static bool kernel_exp_features = false;
> +static uint32_t kernel_features = 0;
>
>  static GList *adapter_list = NULL;
>  static unsigned int adapter_remaining = 0;
> @@ -678,7 +672,7 @@ static bool set_discoverable(struct btd_adapter *adapter, uint8_t mode,
>
>         DBG("sending set mode command for index %u", adapter->dev_id);
>
> -       if (kernel_conn_control) {
> +       if (has_kernel_features(KERNEL_CONN_CONTROL)) {
>                 if (mode)
>                         set_mode(adapter, MGMT_OP_SET_CONNECTABLE, mode);
>                 else
> @@ -1334,7 +1328,7 @@ static void trigger_passive_scanning(struct btd_adapter *adapter)
>          * no need to start any discovery. The kernel will keep scanning
>          * as long as devices are in its auto-connection list.
>          */
> -       if (kernel_conn_control)
> +       if (has_kernel_features(KERNEL_CONN_CONTROL))
>                 return;
>
>         /*
> @@ -1385,7 +1379,7 @@ static void stop_passive_scanning_complete(uint8_t status, uint16_t length,
>          * no need to stop any discovery. The kernel will handle the
>          * auto-connection by itself.
>          */
> -       if (kernel_conn_control)
> +       if (has_kernel_features(KERNEL_CONN_CONTROL))
>                 return;
>
>         /*
> @@ -2816,7 +2810,7 @@ static void property_set_mode_complete(uint8_t status, uint16_t length,
>
>  static void clear_discoverable(struct btd_adapter *adapter)
>  {
> -       if (!kernel_conn_control)
> +       if (!has_kernel_features(KERNEL_CONN_CONTROL))
>                 return;
>
>         if (!(adapter->current_settings & MGMT_SETTING_DISCOVERABLE))
> @@ -2876,7 +2870,7 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
>
>                 break;
>         case MGMT_SETTING_DISCOVERABLE:
> -               if (kernel_conn_control) {
> +               if (has_kernel_features(KERNEL_CONN_CONTROL)) {
>                         if (mode) {
>                                 set_mode(adapter, MGMT_OP_SET_CONNECTABLE,
>                                                                         mode);
> @@ -4193,7 +4187,8 @@ static void load_default_system_params(struct btd_adapter *adapter)
>         size_t len = 0;
>         unsigned int err;
>
> -       if (!main_opts.default_params.num_entries || !kernel_set_system_config)
> +       if (!main_opts.default_params.num_entries ||
> +           !has_kernel_features(KERNEL_SET_SYSTEM_CONFIG))
>                 return;
>
>         params = malloc0(sizeof(*params) *
> @@ -4878,7 +4873,7 @@ int adapter_connect_list_add(struct btd_adapter *adapter,
>          * adapter_auto_connect_add() function is used to maintain what to
>          * connect.
>          */
> -       if (kernel_conn_control)
> +       if (has_kernel_features(KERNEL_CONN_CONTROL))
>                 return 0;
>
>         if (g_slist_find(adapter->connect_list, device)) {
> @@ -4918,7 +4913,7 @@ void adapter_connect_list_remove(struct btd_adapter *adapter,
>         if (device == adapter->connect_le)
>                 adapter->connect_le = NULL;
>
> -       if (kernel_conn_control)
> +       if (has_kernel_features(KERNEL_CONN_CONTROL))
>                 return;
>
>         if (!g_slist_find(adapter->connect_list, device)) {
> @@ -4980,7 +4975,7 @@ void adapter_whitelist_add(struct btd_adapter *adapter, struct btd_device *dev)
>  {
>         struct mgmt_cp_add_device cp;
>
> -       if (!kernel_conn_control)
> +       if (!has_kernel_features(KERNEL_CONN_CONTROL))
>                 return;
>
>         memset(&cp, 0, sizeof(cp));
> @@ -5019,7 +5014,7 @@ void adapter_whitelist_remove(struct btd_adapter *adapter, struct btd_device *de
>  {
>         struct mgmt_cp_remove_device cp;
>
> -       if (!kernel_conn_control)
> +       if (!has_kernel_features(KERNEL_CONN_CONTROL))
>                 return;
>
>         memset(&cp, 0, sizeof(cp));
> @@ -5075,7 +5070,7 @@ void adapter_auto_connect_add(struct btd_adapter *adapter,
>         uint8_t bdaddr_type;
>         unsigned int id;
>
> -       if (!kernel_conn_control)
> +       if (!has_kernel_features(KERNEL_CONN_CONTROL))
>                 return;
>
>         if (g_slist_find(adapter->connect_list, device)) {
> @@ -5147,7 +5142,7 @@ void adapter_set_device_wakeable(struct btd_adapter *adapter,
>         const bdaddr_t *bdaddr;
>         uint8_t bdaddr_type;
>
> -       if (!kernel_conn_control)
> +       if (!has_kernel_features(KERNEL_CONN_CONTROL))
>                 return;
>
>         bdaddr = device_get_address(device);
> @@ -5224,7 +5219,7 @@ void adapter_auto_connect_remove(struct btd_adapter *adapter,
>         uint8_t bdaddr_type;
>         unsigned int id;
>
> -       if (!kernel_conn_control)
> +       if (!has_kernel_features(KERNEL_CONN_CONTROL))
>                 return;
>
>         if (!g_slist_find(adapter->connect_list, device)) {
> @@ -6764,7 +6759,7 @@ connect_le:
>          * If kernel background scan is used then the kernel is
>          * responsible for connecting.
>          */
> -       if (kernel_conn_control)
> +       if (has_kernel_features(KERNEL_CONN_CONTROL))
>                 return;
>
>         /*
> @@ -8964,7 +8959,7 @@ static int clear_devices(struct btd_adapter *adapter)
>  {
>         struct mgmt_cp_remove_device cp;
>
> -       if (!kernel_conn_control)
> +       if (!has_kernel_features(KERNEL_CONN_CONTROL))
>                 return 0;
>
>         memset(&cp, 0, sizeof(cp));
> @@ -9282,7 +9277,7 @@ static void read_info_complete(uint8_t status, uint16_t length,
>                         (missing_settings & MGMT_SETTING_FAST_CONNECTABLE))
>                 set_mode(adapter, MGMT_OP_SET_FAST_CONNECTABLE, 0x01);
>
> -       if (kernel_exp_features)
> +       if (has_kernel_features(KERNEL_EXP_FEATURES))
>                 read_exp_features(adapter);
>
>         err = adapter_register(adapter);
> @@ -9403,7 +9398,8 @@ static void read_info_complete(uint8_t status, uint16_t length,
>
>         set_name(adapter, btd_adapter_get_name(adapter));
>
> -       if (kernel_blocked_keys_supported && !set_blocked_keys(adapter)) {
> +       if (has_kernel_features(KERNEL_BLOCKED_KEYS_SUPPORTED) &&
> +           !set_blocked_keys(adapter)) {
>                 btd_error(adapter->dev_id,
>                                 "Failed to set blocked keys for index %u",
>                                 adapter->dev_id);
> @@ -9414,7 +9410,7 @@ static void read_info_complete(uint8_t status, uint16_t length,
>                         !(adapter->current_settings & MGMT_SETTING_BONDABLE))
>                 set_mode(adapter, MGMT_OP_SET_BONDABLE, 0x01);
>
> -       if (!kernel_conn_control)
> +       if (!has_kernel_features(KERNEL_CONN_CONTROL))
>                 set_mode(adapter, MGMT_OP_SET_CONNECTABLE, 0x01);
>         else if (adapter->current_settings & MGMT_SETTING_CONNECTABLE)
>                 set_mode(adapter, MGMT_OP_SET_CONNECTABLE, 0x00);
> @@ -9590,19 +9586,19 @@ static void read_commands_complete(uint8_t status, uint16_t length,
>                 switch (op) {
>                 case MGMT_OP_ADD_DEVICE:
>                         DBG("enabling kernel-side connection control");
> -                       kernel_conn_control = true;
> +                       kernel_features |= KERNEL_CONN_CONTROL;
>                         break;
>                 case MGMT_OP_SET_BLOCKED_KEYS:
>                         DBG("kernel supports the set_blocked_keys op");
> -                       kernel_blocked_keys_supported = true;
> +                       kernel_features |= KERNEL_BLOCKED_KEYS_SUPPORTED;
>                         break;
>                 case MGMT_OP_SET_DEF_SYSTEM_CONFIG:
>                         DBG("kernel supports set system confic");
> -                       kernel_set_system_config = true;
> +                       kernel_features |= KERNEL_SET_SYSTEM_CONFIG;
>                         break;
>                 case MGMT_OP_READ_EXP_FEATURES_INFO:
>                         DBG("kernel supports exp features");
> -                       kernel_exp_features = true;
> +                       kernel_features |= KERNEL_EXP_FEATURES;
>                         break;
>                 default:
>                         break;
> @@ -9768,3 +9764,8 @@ bool btd_le_connect_before_pairing(void)
>
>         return false;
>  }
> +
> +bool has_kernel_features(uint32_t features)
> +{
> +       return !!(kernel_features & features);

Don't think we need the !! here, the use () should already be enough,
or change it to return (kernel_features & features) ? true : false; if
you think that is more readable.

> +}
> diff --git a/src/adapter.h b/src/adapter.h
> index f8ac20261..b0ed4915f 100644
> --- a/src/adapter.h
> +++ b/src/adapter.h
> @@ -233,3 +233,12 @@ void btd_adapter_for_each_device(struct btd_adapter *adapter,
>                         void *data);
>
>  bool btd_le_connect_before_pairing(void);
> +
> +enum kernel_features {
> +       KERNEL_CONN_CONTROL             = 1 << 0,
> +       KERNEL_BLOCKED_KEYS_SUPPORTED   = 1 << 1,
> +       KERNEL_SET_SYSTEM_CONFIG        = 1 << 2,
> +       KERNEL_EXP_FEATURES             = 1 << 3,
> +};
> +
> +bool has_kernel_features(uint32_t feature);
> --
> 2.28.0.618.gf4bc123cb7-goog
>


-- 
Luiz Augusto von Dentz
