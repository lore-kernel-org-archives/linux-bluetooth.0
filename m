Return-Path: <SRS0=ynic=46=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D62C10DCE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Mar 2020 00:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBEE206F1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Mar 2020 00:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lu6MlrqS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgCMAGt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Mar 2020 20:06:49 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46327 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbgCMAGt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Mar 2020 20:06:49 -0400
Received: by mail-lj1-f195.google.com with SMTP id d23so8502375ljg.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2020 17:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yu4EAG89uNrfcLLQFC6TmBNtqNEDQgeF1pbDyWPCmCE=;
        b=Lu6MlrqSUwg5Wt+QgAlqjrRLmqigm1jXvOy/WEVzxSQjFtcJXESc199QcojGT5+Kfy
         Mx++DBDAI2zCgKthLnckyHuHYykwzhM7Swxm37MGMHRdUEnssEqRlVtVHSYGZ6c5+KA7
         cRFpFuDtDLiTFVsEr0XesXBy0qAV+4qpUSaOwtbpoF68CgRoq7QMy0KzoOcakNoJbFfL
         TfSbxrgjoQfqqFGtWgUulua9nnK1fqKrVYvZCghXJa1nr4AHGqYfT/yRt1RuAtj0cPrV
         e4IXxaRNxQrla0Pe3dAxJYXYoygoc4NhTHzONBORRtOKmWukoklQ3oFQucFNCPOnFRw4
         3DmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yu4EAG89uNrfcLLQFC6TmBNtqNEDQgeF1pbDyWPCmCE=;
        b=I2VSv7apvLKRkpdPE2d+qgVwYrQNWctbG3X5NSWEUObpJV7l4ruARZznHSl1JMhQbW
         Lrxeyp4RgmJuh1EJfM8c/rwHUbeI38C+30P+TKAQaQvabENfajgJUzC9DuUOh1FDMSOt
         vG6mFzvfE3FAxzZwrFZ2qf/Tr7audye2gDhuxh53tFglHp7/5HDyhjpaAG16LjsqB439
         e52p4EVQ322fQ7aswPkyoJemmCxQ+E/B4Y2ZOUjIDWNYrP++Q1RBQzUq3uKtqvkGO7HM
         QnxxI0n8i7XQL2YZUIFJ4ZU/p5X5mqfgK9IYwDLTO7SPK0yCCum6QLV5GFWannqNWAQP
         TAug==
X-Gm-Message-State: ANhLgQ1j8m8u2S+IRtSKKQ+4TPCQyjHkUWHKLnhfivTXVvbIfmrX9LhU
        QgmUj0lADVsRY1dIKgVirj8qGO2r7FOXEeUOTcueZUrF
X-Google-Smtp-Source: ADFU+vu/tg0QJfu1EmsSx5HckbZ7EuP74LXK2EPMBUW3Io3DJ2rXJh7vY+8kn/K1G4Pm3wAgfrlHnOi5z+sJqQx+KEA=
X-Received: by 2002:a2e:85cb:: with SMTP id h11mr2670162ljj.55.1584058006519;
 Thu, 12 Mar 2020 17:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200312223839.6236-1-luiz.dentz@gmail.com> <20200312223839.6236-2-luiz.dentz@gmail.com>
In-Reply-To: <20200312223839.6236-2-luiz.dentz@gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Thu, 12 Mar 2020 20:06:35 -0400
Message-ID: <CALWDO_W4YcDjHgOZ18aPnp-3bHXVOaaGbm9jfVCE5tqW2Gfvew@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] input: Add LEAutoSecurity setting to input.conf
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,


On Thu, Mar 12, 2020 at 6:38 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> LEAutoSecurity can be used to enable/disable automatic upgrades of
> security for LE devices, by default it is enabled so existing devices
> that did not require security and were not bonded will automatically
> upgrade the security.
>
> Note: Platforms disabling this setting would require users to manually
> bond the device which may require changes to the user interface to
> always force bonding for input devices as APIs such as Device.Connect
> will no longer work which maybe perceived as a regression.
> ---
>  profiles/input/device.h   |  1 +
>  profiles/input/hog.c      | 13 +++++++++++--
>  profiles/input/input.conf |  5 +++++
>  profiles/input/manager.c  | 11 ++++++++++-
>  4 files changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/profiles/input/device.h b/profiles/input/device.h
> index 3044db673..5a077f92a 100644
> --- a/profiles/input/device.h
> +++ b/profiles/input/device.h
> @@ -30,6 +30,7 @@ struct input_conn;
>  void input_set_idle_timeout(int timeout);
>  void input_enable_userspace_hid(bool state);
>  void input_set_classic_bonded_only(bool state);
> +void input_set_auto_sec(bool state);
>
>  int input_device_register(struct btd_service *service);
>  void input_device_unregister(struct btd_service *service);
> diff --git a/profiles/input/hog.c b/profiles/input/hog.c
> index f0226ebbd..327a1d1c3 100644
> --- a/profiles/input/hog.c
> +++ b/profiles/input/hog.c
> @@ -53,6 +53,7 @@
>  #include "src/shared/gatt-client.h"
>  #include "src/plugin.h"
>
> +#include "device.h"
>  #include "suspend.h"
>  #include "attrib/att.h"
>  #include "attrib/gattrib.h"
> @@ -67,8 +68,14 @@ struct hog_device {
>  };
>
>  static gboolean suspend_supported = FALSE;
> +static bool auto_sec = true;
>  static struct queue *devices = NULL;
>
> +void input_set_auto_sec(bool state)
> +{
> +       auto_sec = state;
> +}
> +
>  static void hog_device_accept(struct hog_device *dev, struct gatt_db *db)
>  {
>         char name[248];
> @@ -192,11 +199,13 @@ static int hog_accept(struct btd_service *service)
>         if (!device_is_bonded(device, btd_device_get_bdaddr_type(device))) {
>                 struct bt_gatt_client *client;
>
> +               if (!auto_sec)
> +                       return -ECONNREFUSED;
> +
>                 client = btd_device_get_gatt_client(device);
>                 if (!bt_gatt_client_set_security(client,
> -                                               BT_ATT_SECURITY_MEDIUM)) {
> +                                               BT_ATT_SECURITY_MEDIUM))
>                         return -ECONNREFUSED;
> -               }
>         }
>
>         /* TODO: Replace GAttrib with bt_gatt_client */
> diff --git a/profiles/input/input.conf b/profiles/input/input.conf
> index 166aff4a4..4c70bc561 100644
> --- a/profiles/input/input.conf
> +++ b/profiles/input/input.conf
> @@ -19,3 +19,8 @@
>  # pairing/encryption.
>  # Defaults to false to maximize device compatibility.
>  #ClassicBondedOnly=true
> +
> +# LE upgrade security
> +# Enables upgrades of security automatically if required.
> +# Defaults to true to maximize device compatibility.
> +#LEAutoSecurity=true
> diff --git a/profiles/input/manager.c b/profiles/input/manager.c
> index 5cd27b839..bf4acb4ed 100644
> --- a/profiles/input/manager.c
> +++ b/profiles/input/manager.c
> @@ -96,7 +96,7 @@ static int input_init(void)
>         config = load_config_file(CONFIGDIR "/input.conf");
>         if (config) {
>                 int idle_timeout;
> -               gboolean uhid_enabled, classic_bonded_only;
> +               gboolean uhid_enabled, classic_bonded_only, auto_sec;
>
>                 idle_timeout = g_key_file_get_integer(config, "General",
>                                                         "IdleTimeout", &err);
> @@ -125,6 +125,15 @@ static int input_init(void)
>                 } else
>                         g_clear_error(&err);
>
> +               auto_sec = g_key_file_get_boolean(config, "General",
> +                                               "LEAutoSecurity", &err);
> +               if (!err) {
> +                       DBG("input.conf: LEAutoSecurity=%s",
> +                                       auto_sec ? "true" : "false");
> +                       input_set_auto_sec(auto_sec);
> +               } else
> +                       g_clear_error(&err);
> +
>         }
>
>         btd_profile_register(&input_profile);
> --
> 2.21.1
>

Thanks, this LGTM.
