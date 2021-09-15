Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B8DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 12:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E72E360F70
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 12:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236721AbhIOMdc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Sep 2021 08:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbhIOMdc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Sep 2021 08:33:32 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2E1C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 05:32:13 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id t6so4064828edi.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 05:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=33PPC8xkm+O/MyNjoyxtrTXfbmhW4Bexavtc9ICG6TE=;
        b=Lts/lmZP53mWOHWvKxdoquU0WuezKgd5MRebEQZPdXWkaTDAh56y2Ql4YYYq7CcSQk
         s0W8thR50boDCYiEjm25inSfSGujui7fFZxcOtw1s9bbtplZs8a/f3iZHKsgK1lCXiDm
         06w1+pizrnD0OTgHUl/dvQuG4X/BXx6vSBgTFEwSgpqhl8w+D/oYrHvDe3EgykZLMbqu
         DtqNxnHgJ62iFf5NNqLnjzyiITsmPCsoV5bPDwFLo7gOVo1GFbHBRTcwdtw394PxjyKk
         Mm+0czW5odcQ7u1PobnxZXklLYPoeNzZp81ONhHVfqfPX+vEOFEx/itTIg9cl0GeFYJB
         OmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=33PPC8xkm+O/MyNjoyxtrTXfbmhW4Bexavtc9ICG6TE=;
        b=xZ/vtH15s+Be1QehBwsn6V0jE1GrEy9osnxE8uWA2fV6dLYgivBgvtDpYephPmAMOj
         P434mZG6HAPQrJENPcXX4PZcZ9ZM6v1WB0o4owMF47PdwQoLVnmloaFtrQm0AP4GeX4v
         MWP+J/LS9UUFiwIaqNJyqZlBuwQHaZaqhpYyG8sgwSLf0426Vukb3M32lkht3bw22NIr
         0qUV4HbCiqiV+b8MxNkZwVBTJgpv1Af6K0etnC4Aed7rffHwsgZj19bjHeLma4b6YH61
         9reESOg3rh1slz1H+FRYaV9p/5tN1r6pj/Mc2N2hlOhFdxEqSkKXxsWgMUIirhhmPh8p
         53AQ==
X-Gm-Message-State: AOAM531+5bJqMXxDkwH9dkuo47fLyW/qMCGKxGwE0rjbjwRX3jqWaefY
        AJHNvILj+XhkTyvSbZgEVtSvUfSv7pIgLCtrPnIkD4z+m1E=
X-Google-Smtp-Source: ABdhPJwACWUhclbeGwEm64RzwpiUi2X9ATYN6YUspEJASXdtye6zhf6dqDNffR1DeqCbl+hWKcmw14dMPsH8o07sgNQ=
X-Received: by 2002:a05:6402:694:: with SMTP id f20mr16919917edy.100.1631709131581;
 Wed, 15 Sep 2021 05:32:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210906140250.Bluez.v2.1.Id597e5ae87e680e6a744a8ed08d5000aacfce867@changeid>
In-Reply-To: <20210906140250.Bluez.v2.1.Id597e5ae87e680e6a744a8ed08d5000aacfce867@changeid>
From:   Yun-hao Chung <howardchung@google.com>
Date:   Wed, 15 Sep 2021 20:32:00 +0800
Message-ID: <CAPHZWUf91fsLi+fz8q3ocrgTfiq=+VFez75RbNQ4ckNL1jOeKw@mail.gmail.com>
Subject: Re: [Bluez PATCH v2 1/2] plugins/admin: add adapter_remove handler
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Gentle ping. Thanks.


On Mon, Sep 6, 2021 at 2:03 PM Howard Chung <howardchung@google.com> wrote:
>
> From: Yun-Hao Chung <howardchung@chromium.org>
>
> Currently admin doesn't handle adapter removed callbacks, which causes
> interfaces AdminPolicySet1 and AdminPolicyStatus1 not being
> unregistered, which in turns causes these interfaces can not be
> re-registered once adapter is back.
>
> This adds handler for adapter_remove.
>
> Reviewed-by: Shyh-In Hwang <josephsih@chromium.org>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> ---
> tested with following steps
> 1. rmmod btusb
> 2. modprobe btusb
> 3. read allowlist via bluetoothctl
>
> Changes in v2:
> 1. Fix make errors
>
>  plugins/admin.c | 35 ++++++++++++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 7 deletions(-)
>
> diff --git a/plugins/admin.c b/plugins/admin.c
> index 02fec04568ba..82c00cabdb6b 100644
> --- a/plugins/admin.c
> +++ b/plugins/admin.c
> @@ -85,6 +85,17 @@ static void admin_policy_free(void *data)
>         g_free(admin_policy);
>  }
>
> +static void admin_policy_destroy(struct btd_admin_policy *admin_policy)
> +{
> +       const char *path = adapter_get_path(admin_policy->adapter);
> +
> +       g_dbus_unregister_interface(dbus_conn, path,
> +                                               ADMIN_POLICY_SET_INTERFACE);
> +       g_dbus_unregister_interface(dbus_conn, path,
> +                                               ADMIN_POLICY_STATUS_INTERFACE);
> +       admin_policy_free(admin_policy);
> +}
> +
>  static bool uuid_match(const void *data, const void *match_data)
>  {
>         const bt_uuid_t *uuid = data;
> @@ -492,7 +503,7 @@ static int admin_policy_adapter_probe(struct btd_adapter *adapter)
>         if (!g_dbus_register_interface(dbus_conn, adapter_path,
>                                         ADMIN_POLICY_SET_INTERFACE,
>                                         admin_policy_adapter_methods, NULL,
> -                                       NULL, policy_data, admin_policy_free)) {
> +                                       NULL, policy_data, NULL)) {
>                 btd_error(policy_data->adapter_id,
>                         "Admin Policy Set interface init failed on path %s",
>                                                                 adapter_path);
> @@ -506,7 +517,7 @@ static int admin_policy_adapter_probe(struct btd_adapter *adapter)
>                                         ADMIN_POLICY_STATUS_INTERFACE,
>                                         NULL, NULL,
>                                         admin_policy_adapter_properties,
> -                                       policy_data, admin_policy_free)) {
> +                                       policy_data, NULL)) {
>                 btd_error(policy_data->adapter_id,
>                         "Admin Policy Status interface init failed on path %s",
>                                                                 adapter_path);
> @@ -574,10 +585,24 @@ static void admin_policy_device_removed(struct btd_adapter *adapter,
>                 unregister_device_data(data, NULL);
>  }
>
> +static void admin_policy_remove(struct btd_adapter *adapter)
> +{
> +       DBG("");
> +
> +       queue_foreach(devices, unregister_device_data, NULL);
> +       queue_destroy(devices, g_free);
> +
> +       if (policy_data) {
> +               admin_policy_destroy(policy_data);
> +               policy_data = NULL;
> +       }
> +}
> +
>  static struct btd_adapter_driver admin_policy_driver = {
>         .name   = "admin_policy",
>         .probe  = admin_policy_adapter_probe,
>         .resume = NULL,
> +       .remove = admin_policy_remove,
>         .device_resolved = admin_policy_device_added,
>         .device_removed = admin_policy_device_removed
>  };
> @@ -597,11 +622,7 @@ static void admin_exit(void)
>         DBG("");
>
>         btd_unregister_adapter_driver(&admin_policy_driver);
> -       queue_foreach(devices, unregister_device_data, NULL);
> -       queue_destroy(devices, g_free);
> -
> -       if (policy_data)
> -               admin_policy_free(policy_data);
> +       admin_policy_remove(NULL);
>  }
>
>  BLUETOOTH_PLUGIN_DEFINE(admin, VERSION,
> --
> 2.33.0.153.gba50c8fa24-goog
>
