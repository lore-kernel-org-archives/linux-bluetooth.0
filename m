Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23505C07E99
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Jul 2021 06:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0460161441
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Jul 2021 06:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhGIGEY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Jul 2021 02:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhGIGEY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Jul 2021 02:04:24 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA57C061574
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jul 2021 23:01:40 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id o139so12852319ybg.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Jul 2021 23:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rOoKhypFTF2dgCMfLROhRuFad5TEIPPSaPB/nJcvoCE=;
        b=Nkc2j9rOUsZD+THnqR2Ylpza7iAmG4Y1+0loHdB+nrRIvek8HKa6xAQpfcXd6lKUTF
         CWla+9h+G9zWOIdCHXCwlGI9AWdu12RXFX54AqG/t4EAQEkWOszqKnvGrwzala2HgPKz
         CxfkZN3+/k52CKAk4ofOrXJTMjc75eLu8hy7c6cchkYa8iQPY9Ued1p8N7a/Sb806z8D
         ECGjU8KrhDgB2BmLIHCWT/z6+Udxcrlr+nrb/uVXMQ51fuMgYrLgEAjPdCvmAk0vPWLA
         0rbU54KHboHBVPCkfUKaIJSvSC/TaJ6+XfKkZc6oWSEA4SmfTCnlwubRCClK4Co3qVR3
         HnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rOoKhypFTF2dgCMfLROhRuFad5TEIPPSaPB/nJcvoCE=;
        b=sphevF+ONyq0PAnM7tKH2dNwXJtCG1qDa0zX8bxHLym8QCD/kveb+dxKxsYKRcbaJm
         S29fBOzMIq3pXGqLHWLqTVC4nSKW7L01fHCvg2KEthsUCUra38f/jIBUgqTfqx4WnXB3
         1nsEqmIdDXZ6nL3giCqptNnTe9FpvDxJ8+IXMZCV/8jk6aZzJ1ifqSlLsI5tAy1eUbUL
         gogtK1zENpBPDaS4Y742NfGB4AgyqVG8GJb/eacrzTaPMEl+0Ug6dM8Gi+K86RBZMHeF
         iitf95Xh88SZX+GuLy9DqjeypfBZpYgptusBasDkQObJu+vw4WT79kvjp8hRHItF07ld
         8p6Q==
X-Gm-Message-State: AOAM530T+w0RVkHbr5vlp9IrDviSxR7tPnafzaRXEAjiE2cN86ZOzz3I
        ifrSjpmbIJe1S7X+NZrDl5oO2da27sOVfndfG9g=
X-Google-Smtp-Source: ABdhPJwENBLCP8U+t223AjTfz9MyDGA+/BYo+KHKEFmcC69Xj3USt88snqdkflDyVYDoKM28iWwsKyMhH6m6mNr2/8s=
X-Received: by 2002:a25:be02:: with SMTP id h2mr46211943ybk.91.1625810499585;
 Thu, 08 Jul 2021 23:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210708062314.245754-1-howardchung@google.com> <20210708142059.Bluez.v1.9.Ifbb69dd6e371da3a914049a94615064479b9024b@changeid>
In-Reply-To: <20210708142059.Bluez.v1.9.Ifbb69dd6e371da3a914049a94615064479b9024b@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 8 Jul 2021 23:01:28 -0700
Message-ID: <CABBYNZ+w+FT3W3_2XDbhqsT99j3G4AdWQGKF=SbYcU57YyxpRw@mail.gmail.com>
Subject: Re: [Bluez PATCH v1 09/14] plugins/admin_policy: add ServiceAllowList method
To:     Howard Chung <howardchung@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Wed, Jul 7, 2021 at 11:23 PM Howard Chung <howardchung@google.com> wrote:
>
> From: Yun-Hao Chung <howardchung@chromium.org>
>
> This adds code to register interface org.bluez.AdminPolicySet1.
> The interface will provide methods to limit users to operate certain
> functions of bluez, such as allow/disallow user to taggle adapter power,
> or only allow users to connect services in the specified list, etc.
>
> This patch also implements ServiceAllowlist in
> org.bluez.AdminPolicySet1.
>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> ---
> The following test steps were performed:
> 1. Set ServiceAllowList to
>    ["0x1108","0x110A","0x110B","0x110C","0x110D","0x110E",
>    "0x110F","0x1112","0x111E","0x111F","0x1203"]
>    ( users are only allowed to connect headset )
> 2. Turn on paired WF1000XM3, and listen music on Youtube.
> 3. Turn on paired K830 (LE device), press any key on keyboard.
> 4. Turn on paired Samsung Bluetooth Keyboard EE-BT550 (BREDR device),
>    press any key on keyboard.
> 5. Set ServiceAllowList to
>    ["1124","180A","180F","1812"]
>    ( users are only allowed to connect HID devices )
> 6. Turn on paired WF1000XM3, and listen music on Youtube.
> 7. Turn on paired K830 (LE device), press any key on keyboard.
> 8. Turn on paired Samsung Bluetooth Keyboard EE-BT550 (BREDR device),
>    press any key on keyboard.
> 9. Set ServiceAllowList to []
>    ( users are only allowed to connect any device. )
> 10. Turn on paired WF1000XM3, and listen music on Youtube.
> 11. Turn on paired K830 (LE device), press any key on keyboard.
> 12. Turn on paired Samsung Bluetooth Keyboard EE-BT550 (BREDR device),
>    press any key on keyboard.
>
> Expected results:
> Step 2,7,8,9,10,11 should success, and step 3,4,6 should fail.

All this explanation is great but it would really help if you have
added support for bluetoothctl to control this, we also need to
document these interfaces in case someone else wants to use them (e.g:
other clients like bluetoothctl). For the bluetoothctl we could
perhaps an admin menu registered whenever the interfaces are available
and then a command allow [list/none/any] so the user can query when no
parameter is given or set a list of UUIDs. Btw, how is this supposed
to work with vendor UUIDs? I guess that would need to support UUID 128
bit format in order to support that.

>
>  plugins/admin_policy.c | 123 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 122 insertions(+), 1 deletion(-)
>
> diff --git a/plugins/admin_policy.c b/plugins/admin_policy.c
> index 2ece871564e6..242b8d5dacb0 100644
> --- a/plugins/admin_policy.c
> +++ b/plugins/admin_policy.c
> @@ -12,19 +12,29 @@
>  #include <config.h>
>  #endif
>
> +#include <dbus/dbus.h>
> +#include <gdbus/gdbus.h>
> +
>  #include "lib/bluetooth.h"
> +#include "lib/uuid.h"
>
>  #include "src/adapter.h"
> +#include "src/dbus-common.h"
>  #include "src/error.h"
>  #include "src/log.h"
>  #include "src/plugin.h"
>
>  #include "src/shared/queue.h"
>
> +#define ADMIN_POLICY_SET_INTERFACE     "org.bluez.AdminPolicySet1"
> +
> +static DBusConnection *dbus_conn;
> +
>  /* |policy_data| has the same life cycle as btd_adapter */
>  static struct btd_admin_policy {
>         struct btd_adapter *adapter;
>         uint16_t adapter_id;
> +       struct queue *service_allowlist;
>  } *policy_data = NULL;
>
>  static struct btd_admin_policy *admin_policy_new(struct btd_adapter *adapter)
> @@ -40,17 +50,116 @@ static struct btd_admin_policy *admin_policy_new(struct btd_adapter *adapter)
>
>         admin_policy->adapter = adapter;
>         admin_policy->adapter_id = btd_adapter_get_index(adapter);
> +       admin_policy->service_allowlist = NULL;
>
>         return admin_policy;
>  }
>
> +static void free_service_allowlist(struct queue *q)
> +{
> +       queue_destroy(q, g_free);
> +}
> +
>  static void admin_policy_free(void *data)
>  {
>         struct btd_admin_policy *admin_policy = data;
>
> +       free_service_allowlist(admin_policy->service_allowlist);
>         g_free(admin_policy);
>  }
>
> +static struct queue *parse_allow_service_list(struct btd_adapter *adapter,
> +                                                       DBusMessage *msg)
> +{
> +       DBusMessageIter iter, arr_iter;
> +       struct queue *uuid_list = NULL;
> +
> +       dbus_message_iter_init(msg, &iter);
> +       if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
> +               return NULL;
> +
> +       uuid_list = queue_new();
> +       dbus_message_iter_recurse(&iter, &arr_iter);
> +       do {
> +               const int type = dbus_message_iter_get_arg_type(&arr_iter);
> +               char *uuid_param;
> +               bt_uuid_t *uuid;
> +
> +               if (type == DBUS_TYPE_INVALID)
> +                       break;
> +
> +               if (type != DBUS_TYPE_STRING)
> +                       goto failed;
> +
> +               dbus_message_iter_get_basic(&arr_iter, &uuid_param);
> +
> +               uuid = g_try_malloc(sizeof(*uuid));
> +               if (!uuid)
> +                       goto failed;
> +
> +               if (bt_string_to_uuid(uuid, uuid_param)) {
> +                       g_free(uuid);
> +                       goto failed;
> +               }
> +
> +               queue_push_head(uuid_list, uuid);
> +
> +               dbus_message_iter_next(&arr_iter);
> +       } while (true);
> +
> +       return uuid_list;
> +
> +failed:
> +       queue_destroy(uuid_list, g_free);
> +       return NULL;
> +}
> +
> +static bool service_allowlist_set(struct btd_admin_policy *admin_policy,
> +                                                       struct queue *uuid_list)
> +{
> +       struct btd_adapter *adapter = admin_policy->adapter;
> +
> +       if (!btd_adapter_set_allowed_uuids(adapter, uuid_list))
> +               return false;
> +
> +       free_service_allowlist(admin_policy->service_allowlist);
> +       admin_policy->service_allowlist = uuid_list;
> +
> +       return true;
> +}
> +
> +static DBusMessage *set_service_allowlist(DBusConnection *conn,
> +                                       DBusMessage *msg, void *user_data)
> +{
> +       struct btd_admin_policy *admin_policy = user_data;
> +       struct btd_adapter *adapter = admin_policy->adapter;
> +       struct queue *uuid_list = NULL;
> +       const char *sender = dbus_message_get_sender(msg);
> +
> +       DBG("sender %s", sender);
> +
> +       /* Parse parameters */
> +       uuid_list = parse_allow_service_list(adapter, msg);
> +       if (!uuid_list) {
> +               btd_error(admin_policy->adapter_id,
> +                               "Failed on parsing allowed service list");
> +               return btd_error_invalid_args(msg);
> +       }
> +
> +       if (!service_allowlist_set(admin_policy, uuid_list)) {
> +               free_service_allowlist(uuid_list);
> +               return btd_error_failed(msg, "service_allowlist_set failed");
> +       }
> +
> +       return dbus_message_new_method_return(msg);
> +}
> +
> +static const GDBusMethodTable admin_policy_adapter_methods[] = {
> +       { GDBUS_METHOD("SetServiceAllowList", GDBUS_ARGS({ "UUIDs", "as" }),
> +                                               NULL, set_service_allowlist) },
> +       { }
> +};
> +
>  static int admin_policy_adapter_probe(struct btd_adapter *adapter)
>  {
>         if (policy_data) {
> @@ -64,8 +173,18 @@ static int admin_policy_adapter_probe(struct btd_adapter *adapter)
>         if (!policy_data)
>                 return -ENOMEM;
>
> -       btd_info(policy_data->adapter_id, "Admin Policy has been enabled");
> +       if (!g_dbus_register_interface(dbus_conn, adapter_get_path(adapter),
> +                                       ADMIN_POLICY_SET_INTERFACE,
> +                                       admin_policy_adapter_methods, NULL,
> +                                       NULL, policy_data, admin_policy_free)) {
> +               btd_error(policy_data->adapter_id,
> +                       "Admin Policy Set interface init failed on path %s",
> +                                               adapter_get_path(adapter));
> +               return -EINVAL;
> +       }
>
> +       btd_info(policy_data->adapter_id,
> +                               "Admin Policy Set interface registered");
>         return 0;
>  }
>
> @@ -79,6 +198,8 @@ static int admin_policy_init(void)
>  {
>         DBG("");
>
> +       dbus_conn = btd_get_dbus_connection();
> +
>         return btd_register_adapter_driver(&admin_policy_driver);
>  }
>
> --
> 2.32.0.93.g670b81a890-goog
>


-- 
Luiz Augusto von Dentz
