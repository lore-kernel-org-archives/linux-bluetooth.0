Return-Path: <SRS0=n2jO=CR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF44C43461
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Sep 2020 17:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4419021532
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Sep 2020 17:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRpz301j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgIHRZL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbgIHRZB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Sep 2020 13:25:01 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CE5C061573
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2020 10:25:01 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id a2so15495315otr.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2020 10:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=arPHdIb7XQtSkTkswlvjV8UQZrEs63VZ5dfRo8URKtA=;
        b=NRpz301jZ9yykIMdIBKRXdGY0fJ5aiBatyXMyv9mpjHDTZGv9VKUwE8+X8Y8bEWbwT
         6lHbPwH3hPzoBqhKRYEA27h4kv8Ds0slxnaCLjBDP19cX/pHSrmEp+rDrBWjaiRuhSz6
         usOuKRGLVG/J7/6pDuvkIHBISqrahei+6CXb2TZJ8MJOd2kcwfSGstkBE9aRTVghUf7i
         YnAAkrw2bfY+T2Fobp/77JL9kUVdOVgTJnbSDfEe871/tfoB7g//jcm0l6YjXb4y2LR4
         HsWkNZRuNk8lDI4wvU49iRjPOF9KmEJjTUkBaj7FPYRPS6XkWf2agcObmT7ubzAP5GuL
         kVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=arPHdIb7XQtSkTkswlvjV8UQZrEs63VZ5dfRo8URKtA=;
        b=dstOwTo7GyiCAIQzJbULCMMqmWJHG5/C8U7+isqWGa7F3z3pLiODVCK7t90iCYO0Ey
         qHR8Es01hWY3CaaXIxFIBnN9IIZ2qAdO6eetHAFy+DFZonX4UZNHlI9pPXFiYMxOJ4sR
         NKxAjHreyD8XZOzRQ3fVYYBqPsXAIhDp11uQfqVLTREVbpkIZgqTseZquWWF3jQgVDbp
         ZoaFMUL3tBnMzSgUlV2ODgnXLzaxv+/vbBl/NJrdCgGYRXvqDCW4Yxt7vGoJDbyd9PQr
         Q03VfM8J8LrmX7AIizFy6QjdQ8Xatp20NTRmWyfY75PWyfn8DxbA1fo9pZ9yy6f4gJsb
         F1gw==
X-Gm-Message-State: AOAM533+CUTnwcqOTNrm2xnSmzUPYmg4nK33Q6Q9RVERy+0sJnOiH3El
        8kpFthMT/Yx+OiU/6tPmX+Bg7iDe2K5CfA37O+o=
X-Google-Smtp-Source: ABdhPJxrbfNQtoLwDci7M6sQB3oA3bRX6ABStxQdtpM4NJKKgzONX6JPDZhxDkC5sP6U1oanKjJfjRdtUu7XBzI8fPY=
X-Received: by 2002:a9d:2208:: with SMTP id o8mr80981ota.362.1599585900722;
 Tue, 08 Sep 2020 10:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200818152612.BlueZ.v1.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
 <20200818152612.BlueZ.v1.3.I19ff9cdbd40fe453db0e81aec8bf94dd9490dce3@changeid>
In-Reply-To: <20200818152612.BlueZ.v1.3.I19ff9cdbd40fe453db0e81aec8bf94dd9490dce3@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 8 Sep 2020 10:24:50 -0700
Message-ID: <CABBYNZ+EgjjuiyiUaFDAhM1tzmvh6+w5ERA4omtfNgYy86ek7A@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1 3/7] adv_monitor: Implement RegisterMonitor()
To:     Miao-chen Chou <mcchou@chromium.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Miao,

On Tue, Aug 18, 2020 at 3:31 PM Miao-chen Chou <mcchou@chromium.org> wrote:
>
> This implements the RegisterMonitor() method handler of ADV monitor
> manager interface.
>
> The following tests were performed.
> - Issue a RegisterMonitor() call with a valid path and expect a
> success as return.
> - Issue a RegisterMonitor() call with an invalid path and expect
> org.bluez.Error.InvalidArguments as return.
> - Issue two Registermonitor() calls with the same path and expect
> org.bluez.Error.AlreadyExists.
> - Verify the values of the registered paths with logging.
> - Verify D-Bus disconnection callback was triggered when the client detach
> from D-Bus.
>
> Reviewed-by: Yun-Hao Chung <howardchung@google.com>
> Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
>
>  src/adv_monitor.c | 167 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 166 insertions(+), 1 deletion(-)
>
> diff --git a/src/adv_monitor.c b/src/adv_monitor.c
> index 4d02237e8..3d27ad18b 100644
> --- a/src/adv_monitor.c
> +++ b/src/adv_monitor.c
> @@ -22,7 +22,9 @@
>  #endif
>
>  #define _GNU_SOURCE
> +#include <errno.h>
>  #include <stdint.h>
> +#include <string.h>
>
>  #include <glib.h>
>  #include <dbus/dbus.h>
> @@ -34,7 +36,9 @@
>  #include "adapter.h"
>  #include "dbus-common.h"
>  #include "log.h"
> +#include "src/error.h"
>  #include "src/shared/mgmt.h"
> +#include "src/shared/queue.h"
>  #include "src/shared/util.h"
>
>  #include "adv_monitor.h"
> @@ -52,12 +56,170 @@ struct btd_adv_monitor_manager {
>         uint16_t max_num_monitors;
>         uint8_t max_num_patterns;
>
> +       struct queue *apps;     /* apps who registered for Adv monitoring */
>  };
>
> +struct adv_monitor_app {
> +       struct btd_adv_monitor_manager *manager;
> +       char *owner;
> +       char *path;
> +
> +       DBusMessage *reg;
> +       GDBusClient *client;
> +};
> +
> +struct app_match_data {
> +       const char *owner;
> +       const char *path;
> +};
> +
> +/* Replies to an app's D-Bus message and unref it */
> +static void app_reply_msg(struct adv_monitor_app *app, DBusMessage *reply)
> +{
> +       if (!app || !app->reg || !reply)
> +               return;
> +
> +       g_dbus_send_message(btd_get_dbus_connection(), reply);
> +       dbus_message_unref(app->reg);
> +       app->reg = NULL;
> +}
> +
> +/* Destroys an app object along with related D-Bus handlers */
> +static void app_destroy(void *data)
> +{
> +       struct adv_monitor_app *app = data;
> +
> +       if (!app)
> +               return;
> +
> +       DBG("Destroy Adv Monitor app %s at path %s", app->owner, app->path);
> +
> +       if (app->reg) {
> +               app_reply_msg(app, btd_error_failed(app->reg,
> +                                               "Adv Monitor app destroyed"));
> +       }
> +
> +       if (app->client) {
> +               g_dbus_client_set_disconnect_watch(app->client, NULL, NULL);
> +               g_dbus_client_set_proxy_handlers(app->client, NULL, NULL, NULL,
> +                                                       NULL);
> +               g_dbus_client_set_ready_watch(app->client, NULL, NULL);
> +               g_dbus_client_unref(app->client);
> +               app->client = NULL;
> +       }
> +
> +       g_free(app->owner);
> +       app->owner = NULL;
> +       g_free(app->path);
> +       app->path = NULL;

Same comment as before, if the whole object would be free then there
is no need to reset each individual field.

> +
> +       g_free(app);
> +}
> +
> +/* Handles a D-Bus disconnection event of an app */
> +static void app_disconnect_cb(DBusConnection *conn, void *user_data)
> +{
> +       struct adv_monitor_app *app = user_data;
> +
> +       btd_info(app->manager->adapter_id, "Adv Monitor app %s disconnected "
> +                       "from D-Bus", app->owner);
> +       if (app && queue_remove(app->manager->apps, app))
> +               app_destroy(app);
> +}
> +
> +/* Creates an app object, initiates it and sets D-Bus event handlers */
> +static struct adv_monitor_app *app_create(DBusConnection *conn,
> +                                       const char *sender, const char *path,
> +                                       struct btd_adv_monitor_manager *manager)
> +{
> +       struct adv_monitor_app *app;
> +
> +       if (!path || !sender || !manager)
> +               return NULL;
> +
> +       app = g_new0(struct adv_monitor_app, 1);

Please use new0 instead of g_new0 in new code.

> +       if (!app)
> +               return NULL;
> +
> +       app->owner = g_strdup(sender);
> +       app->path = g_strdup(path);
> +       app->manager = manager;
> +       app->reg = NULL;
> +
> +       app->client = g_dbus_client_new(conn, sender, path);
> +       if (!app->client) {
> +               app_destroy(app);
> +               return NULL;
> +       }
> +
> +       g_dbus_client_set_disconnect_watch(app->client, app_disconnect_cb, app);
> +       g_dbus_client_set_proxy_handlers(app->client, NULL, NULL, NULL, NULL);
> +       g_dbus_client_set_ready_watch(app->client, NULL, NULL);
> +
> +       return app;
> +}
> +
> +/* Matches an app based on its owner and path */
> +static bool app_match(const void *a, const void *b)
> +{
> +       const struct adv_monitor_app *app = a;
> +       const struct app_match_data *match = b;
> +
> +       if (match->owner && strcmp(app->owner, match->owner))
> +               return false;
> +
> +       if (match->path && strcmp(app->path, match->path))
> +               return false;
> +
> +       return true;
> +}
> +
> +/* Handles a RegisterMonitor D-Bus call */
> +static DBusMessage *register_monitor(DBusConnection *conn, DBusMessage *msg,
> +                                       void *user_data)
> +{
> +       DBusMessageIter args;
> +       struct app_match_data match;
> +       struct adv_monitor_app *app;
> +       struct btd_adv_monitor_manager *manager = user_data;
> +
> +       if (!dbus_message_iter_init(msg, &args))
> +               return btd_error_invalid_args(msg);
> +
> +       if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_OBJECT_PATH)
> +               return btd_error_invalid_args(msg);
> +
> +       dbus_message_iter_get_basic(&args, &match.path);
> +
> +       if (!strlen(match.path) || !g_str_has_prefix(match.path, "/"))
> +               return btd_error_invalid_args(msg);
> +
> +       match.owner = dbus_message_get_sender(msg);
> +
> +       if (queue_find(manager->apps, app_match, &match))
> +               return btd_error_already_exists(msg);
> +
> +       app = app_create(conn, match.owner, match.path, manager);
> +       if (!app) {
> +               btd_error(manager->adapter_id,
> +                               "Failed to reserve %s for Adv Monitor app %s",
> +                               match.path, match.owner);
> +               return btd_error_failed(msg,
> +                                       "Failed to create Adv Monitor app");
> +       }
> +
> +       queue_push_tail(manager->apps, app);
> +
> +       btd_info(manager->adapter_id, "Path %s reserved for Adv Monitor app %s",
> +                       match.path, match.owner);
> +
> +       return dbus_message_new_method_return(msg);
> +}
> +
>  static const GDBusMethodTable adv_monitor_methods[] = {
>         { GDBUS_METHOD("RegisterMonitor",
>                                         GDBUS_ARGS({ "application", "o" }),
> -                                       NULL, NULL) },
> +                                       NULL, register_monitor) },
>         { GDBUS_ASYNC_METHOD("UnregisterMonitor",
>                                         GDBUS_ARGS({ "application", "o" }),
>                                         NULL, NULL) },
> @@ -157,6 +319,7 @@ static struct btd_adv_monitor_manager *manager_new(
>         manager->mgmt = mgmt_ref(mgmt);
>         manager->adapter_id = btd_adapter_get_index(adapter);
>         manager->path = g_strdup(adapter_get_path(manager->adapter));
> +       manager->apps = queue_new();
>
>         return manager;
>  }
> @@ -170,6 +333,8 @@ static void manager_free(struct btd_adv_monitor_manager *manager)
>         g_free(manager->path);
>         manager->path = NULL;
>
> +       queue_destroy(manager->apps, app_destroy);
> +
>         g_free(manager);
>  }
>
> --
> 2.26.2
>


-- 
Luiz Augusto von Dentz
