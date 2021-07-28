Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB2AC4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 17:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D4AA6023F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 17:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhG1Rmn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jul 2021 13:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhG1Rmn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jul 2021 13:42:43 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67671C061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 10:42:41 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id q15so5319506ybu.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 10:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p9dlaND77uvFHoUmaYmEjFo4SvBRJHP5Z6FPoMeFkiA=;
        b=Kjtfw9MWwulV9eM2COF6K96DIA3JMNKLL1GSWVZlz/mzgy65BUoSWbaOsFP3nqBCFj
         J56YmLMKl6/sHyo+qz6TUTU29XMCoUNHTPbgSmEcNX9HBHgLMFrfDVsX0QUZG1lYPwIa
         ULvCPS/s79qfvpi9716ZM6URPOnWTHE2mxaLRadWajoVWn+oQ4Sy9HrsOXPH2x/SWEHb
         7ShXx2ILPcqMsJNR5oHS/3WMLCABiv8sI+TrrLyvtYxEe/tNm13c52/8NkGp8MydFMY0
         07JPxRH3UYqmVg2/xJ56Lm4Kxi4ksu7m/ukyCEgvcK85c4jAW4GnGK21xrVXPBCqH6LG
         WhfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p9dlaND77uvFHoUmaYmEjFo4SvBRJHP5Z6FPoMeFkiA=;
        b=EpGykooPqAxLFCRHea2SIM6t1eaS0rUPyun5nUYQh7TIlvTKF+sWUyR+brysypxMpS
         7x5/E0AIBLR166OgZ3vp3qnrcGlr68DjwkHL3d0Ar9FBPqvktsAswcGcRf4nR5fscxV1
         /9QdvB7M2T3PV/dpaBcTa0LI4oDtOR/sYKRYF+tWwEZkQgpZzDsKMFH1BN0nkzLfjf94
         F+cJ3OnafObVun0CI/8zk+kAvsCGlCKDZ1Zn5IkWRTCox+fB0o1c3ktWrs8i2qNT3OWW
         HOf4taTVvlEFpvmkNpd1IALh7VMznbh7CEvNZYPeVznQ3AZMe5zG33elBTle7dNqxiVw
         Emrg==
X-Gm-Message-State: AOAM5309SD+43U/qeOghwVHtNu0S0Aug69GUUruEyLi7ktgB4eSGP+/q
        NWlSuzZmlKkvGoAJyAKXV5x9H8lpGOL8ZWHE+7k=
X-Google-Smtp-Source: ABdhPJwVVft7EU2K1vu/LunCye8kI/PgjRimUD6lBd/Xa/oGd5KvfwJXE6tQ2BHzfHG7hAnUtzRaLnkX9KhOW0CQb0c=
X-Received: by 2002:a25:9b03:: with SMTP id y3mr1053428ybn.264.1627494160530;
 Wed, 28 Jul 2021 10:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210728131529.3310558-1-howardchung@google.com> <20210728211405.Bluez.v3.7.I29607be7ac91b0a494ab51713ba14f583eb858ed@changeid>
In-Reply-To: <20210728211405.Bluez.v3.7.I29607be7ac91b0a494ab51713ba14f583eb858ed@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 28 Jul 2021 10:42:29 -0700
Message-ID: <CABBYNZLfv3FiB0nM6nEh=fnfa0+oqaWSGgjJqoZxeL9aLoAXsA@mail.gmail.com>
Subject: Re: [Bluez PATCH v3 07/13] plugins/admin_policy: add admin_policy
 adapter driver
To:     Howard Chung <howardchung@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Wed, Jul 28, 2021 at 6:16 AM Howard Chung <howardchung@google.com> wrote:
>
> From: Yun-Hao Chung <howardchung@chromium.org>
>
> This adds code to register admin_policy driver to adapter when
> admin_policy plugin is enabled.
>
> The following test steps were performed:
> 1. restart bluetoothd
> 2. check if "Admin Policy is enabled" in system log
>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> ---
>
> (no changes since v1)
>
>  plugins/admin.c        | 67 ++++++++++++++++++++++++++++++++++++++++++
>  plugins/admin_policy.c | 67 ++++++++++++++++++++++++++++++++++++++++++

Looks like the old file still being added, besides you should update
your patch description as well since you still mentioning it as
admin_policy in quite a few of them.

>  2 files changed, 134 insertions(+)
>
> diff --git a/plugins/admin.c b/plugins/admin.c
> index 42866bcf7..923e08cb8 100644
> --- a/plugins/admin.c
> +++ b/plugins/admin.c
> @@ -12,17 +12,84 @@
>  #include <config.h>
>  #endif
>
> +#include "lib/bluetooth.h"
> +
> +#include "src/adapter.h"
> +#include "src/error.h"
>  #include "src/log.h"
>  #include "src/plugin.h"
>
> +#include "src/shared/queue.h"
> +
> +/* |policy_data| has the same life cycle as btd_adapter */
> +static struct btd_admin_policy {
> +       struct btd_adapter *adapter;
> +       uint16_t adapter_id;
> +} *policy_data = NULL;
> +
> +static struct btd_admin_policy *admin_policy_new(struct btd_adapter *adapter)
> +{
> +       struct btd_admin_policy *admin_policy = NULL;
> +
> +       admin_policy = g_try_malloc(sizeof(*admin_policy));
> +       if (!admin_policy) {
> +               btd_error(btd_adapter_get_index(adapter),
> +                               "Failed to allocate memory for admin_policy");
> +               return NULL;
> +       }
> +
> +       admin_policy->adapter = adapter;
> +       admin_policy->adapter_id = btd_adapter_get_index(adapter);
> +
> +       return admin_policy;
> +}
> +
> +static void admin_policy_free(void *data)
> +{
> +       struct btd_admin_policy *admin_policy = data;
> +
> +       g_free(admin_policy);
> +}
> +
> +static int admin_policy_adapter_probe(struct btd_adapter *adapter)
> +{
> +       if (policy_data) {
> +               btd_warn(policy_data->adapter_id,
> +                                               "Policy data already exists");
> +               admin_policy_free(policy_data);
> +               policy_data = NULL;
> +       }
> +
> +       policy_data = admin_policy_new(adapter);
> +       if (!policy_data)
> +               return -ENOMEM;
> +
> +       btd_info(policy_data->adapter_id, "Admin Policy has been enabled");
> +
> +       return 0;
> +}
> +
> +static struct btd_adapter_driver admin_policy_driver = {
> +       .name   = "admin_policy",
> +       .probe  = admin_policy_adapter_probe,
> +       .resume = NULL,
> +};
> +
>  static int admin_init(void)
>  {
>         DBG("");
> +
> +       return btd_register_adapter_driver(&admin_policy_driver);
>  }
>
>  static void admin_exit(void)
>  {
>         DBG("");
> +
> +       btd_unregister_adapter_driver(&admin_policy_driver);
> +
> +       if (policy_data)
> +               admin_policy_free(policy_data);
>  }
>
>  BLUETOOTH_PLUGIN_DEFINE(admin, VERSION,
> diff --git a/plugins/admin_policy.c b/plugins/admin_policy.c
> index dd8d89736..2ece87156 100644
> --- a/plugins/admin_policy.c
> +++ b/plugins/admin_policy.c
> @@ -12,17 +12,84 @@
>  #include <config.h>
>  #endif
>
> +#include "lib/bluetooth.h"
> +
> +#include "src/adapter.h"
> +#include "src/error.h"
>  #include "src/log.h"
>  #include "src/plugin.h"
>
> +#include "src/shared/queue.h"
> +
> +/* |policy_data| has the same life cycle as btd_adapter */
> +static struct btd_admin_policy {
> +       struct btd_adapter *adapter;
> +       uint16_t adapter_id;
> +} *policy_data = NULL;
> +
> +static struct btd_admin_policy *admin_policy_new(struct btd_adapter *adapter)
> +{
> +       struct btd_admin_policy *admin_policy = NULL;
> +
> +       admin_policy = g_try_malloc(sizeof(*admin_policy));
> +       if (!admin_policy) {
> +               btd_error(btd_adapter_get_index(adapter),
> +                               "Failed to allocate memory for admin_policy");
> +               return NULL;
> +       }
> +
> +       admin_policy->adapter = adapter;
> +       admin_policy->adapter_id = btd_adapter_get_index(adapter);
> +
> +       return admin_policy;
> +}
> +
> +static void admin_policy_free(void *data)
> +{
> +       struct btd_admin_policy *admin_policy = data;
> +
> +       g_free(admin_policy);
> +}
> +
> +static int admin_policy_adapter_probe(struct btd_adapter *adapter)
> +{
> +       if (policy_data) {
> +               btd_warn(policy_data->adapter_id,
> +                                               "Policy data already exists");
> +               admin_policy_free(policy_data);
> +               policy_data = NULL;
> +       }
> +
> +       policy_data = admin_policy_new(adapter);
> +       if (!policy_data)
> +               return -ENOMEM;
> +
> +       btd_info(policy_data->adapter_id, "Admin Policy has been enabled");
> +
> +       return 0;
> +}
> +
> +static struct btd_adapter_driver admin_policy_driver = {
> +       .name   = "admin_policy",
> +       .probe  = admin_policy_adapter_probe,
> +       .resume = NULL,
> +};
> +
>  static int admin_policy_init(void)
>  {
>         DBG("");
> +
> +       return btd_register_adapter_driver(&admin_policy_driver);
>  }
>
>  static void admin_policy_exit(void)
>  {
>         DBG("");
> +
> +       btd_unregister_adapter_driver(&admin_policy_driver);
> +
> +       if (policy_data)
> +               admin_policy_free(policy_data);
>  }
>
>  BLUETOOTH_PLUGIN_DEFINE(admin_policy, VERSION,
> --
> 2.32.0.432.gabb21c7263-goog
>


-- 
Luiz Augusto von Dentz
