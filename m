Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC423C07E99
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Jul 2021 16:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D33661154
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Jul 2021 16:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbhGLQoa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Jul 2021 12:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbhGLQo3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Jul 2021 12:44:29 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80F5C0613DD
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jul 2021 09:41:39 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id p22so30009183yba.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jul 2021 09:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dgJKEr7uc0o4cEs35R2tZWqkfS8h6fxnirK9vbYmAig=;
        b=j+oZiVHWACNuM3YjLjiWC7LWv/dOxHOBOVk/By2xGbhSCoEengbWv3z8c+dY7Qt+UZ
         jx85Rw/aZNfraU2m+PmhLhy4ZvwnTBuOlLVmSlSpoWBCH+nrSgy2/OftZDSzQlZCsuHt
         rDZak/tL5K7NbSZkJ+PbOTMArkudeEysKd4SgU2UsHV1lYR+A26IgbxHpfTOu8g2k7uU
         IcledeVacqNGbyARRWNIO1eXDxbowwKndNQO8E6aazWaePSdcNdxrczxSsU4Y3R6lwRp
         Miu4lbiR5aW0MjCQWRlPlPEKYe91QIMsPchkrx8+DXWay99ZSik51MSYQ5QvgUxlInjb
         c3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dgJKEr7uc0o4cEs35R2tZWqkfS8h6fxnirK9vbYmAig=;
        b=JdsE5665T+ogx06oAcY1mjnKOgDIOCLZ1cTsvw1mWAfr98NvBNqCwY3Mw3ckGY3ovt
         jLUnZP1LioS0mVIA/ZcGoRNgzKfUp6qA9MDD3tuQJDUV5BDHCUV2f/T7QOdJgzH/Cap1
         +h04AcNKfW0kbSViAIHFnmtO+jutSVUU79EKlDJz4Eym18Hm2WSDHLT7Z9ZOVr+AN6UI
         uvZ8B97hTUhbiDS4G/sZJwg2ltmndKZtjb7VFPadwtDGoHtqa8CLXkqxY+HE26m9Hq09
         Z2FFjHGt2m8QTTBxWGb0Eu3zwBH+VnlfrXe8oe6OlHAivQENfdatcompa4va1+SaOZP7
         B3Hg==
X-Gm-Message-State: AOAM532aUR1/PQjjiocWOEaycKE2I7C1FlymdOL3S9f3bYuZ/7WtzQfD
        KpH7TvITV61MlUin5kRaFlycFfHs/erSYXmC1Eo=
X-Google-Smtp-Source: ABdhPJyHR0xmMKO8H0QAaXJG0lTL5aCdUpeR7HweGsPhq3x6rxjexhvNZs1FYqpL+cIw2FUKAsEgdk+MLL4ISRDA08A=
X-Received: by 2002:a25:be02:: with SMTP id h2mr69025539ybk.91.1626108098972;
 Mon, 12 Jul 2021 09:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210708062314.245754-1-howardchung@google.com>
 <20210708142059.Bluez.v1.9.Ifbb69dd6e371da3a914049a94615064479b9024b@changeid>
 <CABBYNZ+w+FT3W3_2XDbhqsT99j3G4AdWQGKF=SbYcU57YyxpRw@mail.gmail.com> <CAPHZWUdGaFso6QQTAfDGT5LYgbvfoRaYv80uxmn-3fr74wDg8w@mail.gmail.com>
In-Reply-To: <CAPHZWUdGaFso6QQTAfDGT5LYgbvfoRaYv80uxmn-3fr74wDg8w@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 12 Jul 2021 09:41:28 -0700
Message-ID: <CABBYNZKXdqJUgOrxLwXNq5v4FqmAxgZMGBDjT79mnyrwQLFYVA@mail.gmail.com>
Subject: Re: [Bluez PATCH v1 09/14] plugins/admin_policy: add ServiceAllowList method
To:     Yun-hao Chung <howardchung@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Mon, Jul 12, 2021 at 2:09 AM Yun-hao Chung <howardchung@google.com> wrote:
>
> On Fri, Jul 9, 2021 at 2:01 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Howard,
> >
> > On Wed, Jul 7, 2021 at 11:23 PM Howard Chung <howardchung@google.com> wrote:
> > >
> > > From: Yun-Hao Chung <howardchung@chromium.org>
> > >
> > > This adds code to register interface org.bluez.AdminPolicySet1.
> > > The interface will provide methods to limit users to operate certain
> > > functions of bluez, such as allow/disallow user to taggle adapter power,
> > > or only allow users to connect services in the specified list, etc.
> > >
> > > This patch also implements ServiceAllowlist in
> > > org.bluez.AdminPolicySet1.
> > >
> > > Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> > > ---
> > > The following test steps were performed:
> > > 1. Set ServiceAllowList to
> > >    ["0x1108","0x110A","0x110B","0x110C","0x110D","0x110E",
> > >    "0x110F","0x1112","0x111E","0x111F","0x1203"]
> > >    ( users are only allowed to connect headset )
> > > 2. Turn on paired WF1000XM3, and listen music on Youtube.
> > > 3. Turn on paired K830 (LE device), press any key on keyboard.
> > > 4. Turn on paired Samsung Bluetooth Keyboard EE-BT550 (BREDR device),
> > >    press any key on keyboard.
> > > 5. Set ServiceAllowList to
> > >    ["1124","180A","180F","1812"]
> > >    ( users are only allowed to connect HID devices )
> > > 6. Turn on paired WF1000XM3, and listen music on Youtube.
> > > 7. Turn on paired K830 (LE device), press any key on keyboard.
> > > 8. Turn on paired Samsung Bluetooth Keyboard EE-BT550 (BREDR device),
> > >    press any key on keyboard.
> > > 9. Set ServiceAllowList to []
> > >    ( users are only allowed to connect any device. )
> > > 10. Turn on paired WF1000XM3, and listen music on Youtube.
> > > 11. Turn on paired K830 (LE device), press any key on keyboard.
> > > 12. Turn on paired Samsung Bluetooth Keyboard EE-BT550 (BREDR device),
> > >    press any key on keyboard.
> > >
> > > Expected results:
> > > Step 2,7,8,9,10,11 should success, and step 3,4,6 should fail.
> >
> > All this explanation is great but it would really help if you have
> > added support for bluetoothctl to control this,  we also need to
> Document it sounds good to me, but I notice that there is no document
> for any plugin yet.
> Where do you think we should put the document in?

Under doc (e.g. admin-policy.txt) should be fine since the plugin will
be in the tree anyway.

> > document these interfaces in case someone else wants to use them (e.g:
> > other clients like bluetoothctl). For the bluetoothctl we could
> > perhaps an admin menu registered whenever the interfaces are available
> > and then a command allow [list/none/any] so the user can query when no
> > parameter is given or set a list of UUIDs. Btw, how is this supposed
> Adding commands in bluetoothctl sounds good to me as well. Can we
> implement this in
> a separate series?

Sure.

> > to work with vendor UUIDs? I guess that would need to support UUID 128
> > bit format in order to support that.
> Since we are using bt_string_to_uuid to parse the given string,
> internally it checks if it can be parsed as UUID128/UUID32/UUID16.

Ok, that said in the comments you were using 0x so it sounded to me
the UUID type over D-Bus would be binary type not string, if we really
choose to support UUID 128 it is probably better to use string type
like we do with other APIs.

> >
> > >
> > >  plugins/admin_policy.c | 123 ++++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 122 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/plugins/admin_policy.c b/plugins/admin_policy.c
> > > index 2ece871564e6..242b8d5dacb0 100644
> > > --- a/plugins/admin_policy.c
> > > +++ b/plugins/admin_policy.c
> > > @@ -12,19 +12,29 @@
> > >  #include <config.h>
> > >  #endif
> > >
> > > +#include <dbus/dbus.h>
> > > +#include <gdbus/gdbus.h>
> > > +
> > >  #include "lib/bluetooth.h"
> > > +#include "lib/uuid.h"
> > >
> > >  #include "src/adapter.h"
> > > +#include "src/dbus-common.h"
> > >  #include "src/error.h"
> > >  #include "src/log.h"
> > >  #include "src/plugin.h"
> > >
> > >  #include "src/shared/queue.h"
> > >
> > > +#define ADMIN_POLICY_SET_INTERFACE     "org.bluez.AdminPolicySet1"
> > > +
> > > +static DBusConnection *dbus_conn;
> > > +
> > >  /* |policy_data| has the same life cycle as btd_adapter */
> > >  static struct btd_admin_policy {
> > >         struct btd_adapter *adapter;
> > >         uint16_t adapter_id;
> > > +       struct queue *service_allowlist;
> > >  } *policy_data = NULL;
> > >
> > >  static struct btd_admin_policy *admin_policy_new(struct btd_adapter *adapter)
> > > @@ -40,17 +50,116 @@ static struct btd_admin_policy *admin_policy_new(struct btd_adapter *adapter)
> > >
> > >         admin_policy->adapter = adapter;
> > >         admin_policy->adapter_id = btd_adapter_get_index(adapter);
> > > +       admin_policy->service_allowlist = NULL;
> > >
> > >         return admin_policy;
> > >  }
> > >
> > > +static void free_service_allowlist(struct queue *q)
> > > +{
> > > +       queue_destroy(q, g_free);
> > > +}
> > > +
> > >  static void admin_policy_free(void *data)
> > >  {
> > >         struct btd_admin_policy *admin_policy = data;
> > >
> > > +       free_service_allowlist(admin_policy->service_allowlist);
> > >         g_free(admin_policy);
> > >  }
> > >
> > > +static struct queue *parse_allow_service_list(struct btd_adapter *adapter,
> > > +                                                       DBusMessage *msg)
> > > +{
> > > +       DBusMessageIter iter, arr_iter;
> > > +       struct queue *uuid_list = NULL;
> > > +
> > > +       dbus_message_iter_init(msg, &iter);
> > > +       if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
> > > +               return NULL;
> > > +
> > > +       uuid_list = queue_new();
> > > +       dbus_message_iter_recurse(&iter, &arr_iter);
> > > +       do {
> > > +               const int type = dbus_message_iter_get_arg_type(&arr_iter);
> > > +               char *uuid_param;
> > > +               bt_uuid_t *uuid;
> > > +
> > > +               if (type == DBUS_TYPE_INVALID)
> > > +                       break;
> > > +
> > > +               if (type != DBUS_TYPE_STRING)
> > > +                       goto failed;
> > > +
> > > +               dbus_message_iter_get_basic(&arr_iter, &uuid_param);
> > > +
> > > +               uuid = g_try_malloc(sizeof(*uuid));
> > > +               if (!uuid)
> > > +                       goto failed;
> > > +
> > > +               if (bt_string_to_uuid(uuid, uuid_param)) {
> > > +                       g_free(uuid);
> > > +                       goto failed;
> > > +               }
> > > +
> > > +               queue_push_head(uuid_list, uuid);
> > > +
> > > +               dbus_message_iter_next(&arr_iter);
> > > +       } while (true);
> > > +
> > > +       return uuid_list;
> > > +
> > > +failed:
> > > +       queue_destroy(uuid_list, g_free);
> > > +       return NULL;
> > > +}
> > > +
> > > +static bool service_allowlist_set(struct btd_admin_policy *admin_policy,
> > > +                                                       struct queue *uuid_list)
> > > +{
> > > +       struct btd_adapter *adapter = admin_policy->adapter;
> > > +
> > > +       if (!btd_adapter_set_allowed_uuids(adapter, uuid_list))
> > > +               return false;
> > > +
> > > +       free_service_allowlist(admin_policy->service_allowlist);
> > > +       admin_policy->service_allowlist = uuid_list;
> > > +
> > > +       return true;
> > > +}
> > > +
> > > +static DBusMessage *set_service_allowlist(DBusConnection *conn,
> > > +                                       DBusMessage *msg, void *user_data)
> > > +{
> > > +       struct btd_admin_policy *admin_policy = user_data;
> > > +       struct btd_adapter *adapter = admin_policy->adapter;
> > > +       struct queue *uuid_list = NULL;
> > > +       const char *sender = dbus_message_get_sender(msg);
> > > +
> > > +       DBG("sender %s", sender);
> > > +
> > > +       /* Parse parameters */
> > > +       uuid_list = parse_allow_service_list(adapter, msg);
> > > +       if (!uuid_list) {
> > > +               btd_error(admin_policy->adapter_id,
> > > +                               "Failed on parsing allowed service list");
> > > +               return btd_error_invalid_args(msg);
> > > +       }
> > > +
> > > +       if (!service_allowlist_set(admin_policy, uuid_list)) {
> > > +               free_service_allowlist(uuid_list);
> > > +               return btd_error_failed(msg, "service_allowlist_set failed");
> > > +       }
> > > +
> > > +       return dbus_message_new_method_return(msg);
> > > +}
> > > +
> > > +static const GDBusMethodTable admin_policy_adapter_methods[] = {
> > > +       { GDBUS_METHOD("SetServiceAllowList", GDBUS_ARGS({ "UUIDs", "as" }),
> > > +                                               NULL, set_service_allowlist) },
> > > +       { }
> > > +};
> > > +
> > >  static int admin_policy_adapter_probe(struct btd_adapter *adapter)
> > >  {
> > >         if (policy_data) {
> > > @@ -64,8 +173,18 @@ static int admin_policy_adapter_probe(struct btd_adapter *adapter)
> > >         if (!policy_data)
> > >                 return -ENOMEM;
> > >
> > > -       btd_info(policy_data->adapter_id, "Admin Policy has been enabled");
> > > +       if (!g_dbus_register_interface(dbus_conn, adapter_get_path(adapter),
> > > +                                       ADMIN_POLICY_SET_INTERFACE,
> > > +                                       admin_policy_adapter_methods, NULL,
> > > +                                       NULL, policy_data, admin_policy_free)) {
> > > +               btd_error(policy_data->adapter_id,
> > > +                       "Admin Policy Set interface init failed on path %s",
> > > +                                               adapter_get_path(adapter));
> > > +               return -EINVAL;
> > > +       }
> > >
> > > +       btd_info(policy_data->adapter_id,
> > > +                               "Admin Policy Set interface registered");
> > >         return 0;
> > >  }
> > >
> > > @@ -79,6 +198,8 @@ static int admin_policy_init(void)
> > >  {
> > >         DBG("");
> > >
> > > +       dbus_conn = btd_get_dbus_connection();
> > > +
> > >         return btd_register_adapter_driver(&admin_policy_driver);
> > >  }
> > >
> > > --
> > > 2.32.0.93.g670b81a890-goog
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
