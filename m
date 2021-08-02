Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9E1C4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 18:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBB0760F9E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 18:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhHBSwI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Aug 2021 14:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhHBSwI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Aug 2021 14:52:08 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FABEC06175F
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Aug 2021 11:51:57 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id a93so11883687ybi.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Aug 2021 11:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MEbj1vMUmBw8m6cxxJEMkOAw2gTJ3Ex0PT6ibwgy5JA=;
        b=Vc7Klj25KRkG2Y7/V7gRfADjflZabaet1PasJQmHjKdDZWKlDEkuAvCM7JxHWnabj8
         /uAdbrT09b1TSWtz8kbuGJXSlaNqTWZFUw379qMwNQkl87qM2AofeAYtbG3ObLIcU6+j
         IFVChEc9Wyz5PvbzIfsFBXUrZoXB6i3y1OkFPZoQDLx1QyZittFq0CX15gb9/A54ghLY
         bGFml2hVx6pjYikU9LTV60oXA7REsV02/mTk7sKofDZiapPZJlPYULPdAHMJtB3L+KJK
         VypSjfN5C0UXVnq/fbrq0r15SKnVvFTo6glvL7preF0S7NCsW59a7c27x3T7Er4y0x0K
         0ovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MEbj1vMUmBw8m6cxxJEMkOAw2gTJ3Ex0PT6ibwgy5JA=;
        b=IUfqOgZzq8qDHCvty4eNFDaVpitQnwk3j857HBC9jv1CKGatWA5p0HbSRZkkv3u3+o
         m4c9rrtBR4DtzFqkbkbZSOpGv+vWLqLQAEmM7H8AKoA4EHFJSLNDJTr6Hym/22uACxLl
         kYpxeJie9REN7YWFrwnlHgaBaYI6wM13c46YeeIY+21kTmiFXIagenHPqbcLOkt6djHt
         U+Jjc6nnxHbF4O/iCv730kamyr8w/iaCBabzNEsMp/31/i5zkLtdE/0Harxxy3cz+jS3
         IXkaLypJ+L1zbKSEk9tGuz11wUgpYy+Af76EYZ12X9rXoKdXkcza6akf5AvjBGQ6vD48
         /y4A==
X-Gm-Message-State: AOAM532HsFgtg5j157nSWdy7WfjcCWpCVq4r9TpYcCqUlsQ89dpUWjsb
        TN2OW00esZefndNN5mCxVe3sXbNfNF7m4AHzxZk=
X-Google-Smtp-Source: ABdhPJzP+/VBcJHiFWFM74AdQnvHn1kOr0S7Agkd7MH2Nq/uWB5TrYZO5B8S9eh8nvFT6J6kr+8UmL1/a8D964t83W0=
X-Received: by 2002:a25:9b03:: with SMTP id y3mr20977331ybn.264.1627930316774;
 Mon, 02 Aug 2021 11:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210802061250.170975-1-howardchung@google.com> <20210802141140.Bluez.v7.12.Ib26c0abdbd417673a8b5788c175c06110726a68c@changeid>
In-Reply-To: <20210802141140.Bluez.v7.12.Ib26c0abdbd417673a8b5788c175c06110726a68c@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 2 Aug 2021 11:51:45 -0700
Message-ID: <CABBYNZ+8193HOT3YZFigdAjRPQNpkbAFDsdE35zBdKZYEaARhg@mail.gmail.com>
Subject: Re: [Bluez PATCH v7 12/13] plugins/admin: persist policy settings
To:     Howard Chung <howardchung@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Sun, Aug 1, 2021 at 11:13 PM Howard Chung <howardchung@google.com> wrote:
>
> From: Yun-Hao Chung <howardchung@chromium.org>
>
> This adds code to store the ServiceAllowlist to file
> /var/lib/bluetooth/{MAC_ADDR}/admin_policy
> The stored settings will be loaded upon admin_policy initialized.
>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> ---
> The following test steps were performed:
> 1. Set ServiceAllowlist to ["1124","180A","180F","1812", "1801"]
> 2. restart bluetoothd
> 3. Verify ServiceAllowlist is ["1124","180A","180F","1812","1801"] in
>    UUID-128 form
> 4. Set ServiceAllowlist to []
> 5. restart bluetoothd
> 6. Verify ServiceAllowlist is []

Please have the format documented in doc/settings-storage.txt

> (no changes since v1)
>
>  plugins/admin.c | 169 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 167 insertions(+), 2 deletions(-)
>
> diff --git a/plugins/admin.c b/plugins/admin.c
> index 653195a0e20b..8e6549ea8020 100644
> --- a/plugins/admin.c
> +++ b/plugins/admin.c
> @@ -14,6 +14,9 @@
>
>  #include <dbus/dbus.h>
>  #include <gdbus/gdbus.h>
> +#include <sys/file.h>
> +#include <sys/stat.h>
> +#include <errno.h>
>
>  #include "lib/bluetooth.h"
>  #include "lib/uuid.h"
> @@ -24,11 +27,13 @@
>  #include "src/error.h"
>  #include "src/log.h"
>  #include "src/plugin.h"
> +#include "src/textfile.h"
>
>  #include "src/shared/queue.h"
>
>  #define ADMIN_POLICY_SET_INTERFACE     "org.bluez.AdminPolicySet1"
>  #define ADMIN_POLICY_STATUS_INTERFACE  "org.bluez.AdminPolicyStatus1"
> +#define ADMIN_POLICY_STORAGE           STORAGEDIR "/admin_policy_settings"
>
>  #define DBUS_BLUEZ_SERVICE             "org.bluez"
>  #define BTD_DEVICE_INTERFACE           "org.bluez.Device1"
> @@ -161,6 +166,8 @@ static void update_device_affected(void *data, void *user_data)
>                         ADMIN_POLICY_STATUS_INTERFACE, "AffectedByPolicy");
>  }
>
> +static void store_policy_settings(struct btd_admin_policy *admin_policy);

Usually we recommend avoiding forward declaration if possible.

>  static DBusMessage *set_service_allowlist(DBusConnection *conn,
>                                         DBusMessage *msg, void *user_data)
>  {
> @@ -179,7 +186,9 @@ static DBusMessage *set_service_allowlist(DBusConnection *conn,
>                 return btd_error_invalid_args(msg);
>         }
>
> -       if (!service_allowlist_set(admin_policy, uuid_list)) {
> +       if (service_allowlist_set(admin_policy, uuid_list)) {
> +               store_policy_settings(admin_policy);
> +       } else {
>                 free_service_allowlist(uuid_list);
>                 return btd_error_failed(msg, "service_allowlist_set failed");
>         }
> @@ -200,7 +209,7 @@ static const GDBusMethodTable admin_policy_adapter_methods[] = {
>         { }
>  };
>
> -void append_service_uuid(void *data, void *user_data)
> +static void append_service_uuid(void *data, void *user_data)
>  {
>         bt_uuid_t *uuid = data;
>         DBusMessageIter *entry = user_data;
> @@ -237,6 +246,161 @@ static const GDBusPropertyTable admin_policy_adapter_properties[] = {
>         { }
>  };
>
> +static void free_uuid_strings(char **uuid_strs, gsize num)
> +{
> +       gsize i;
> +
> +       for (i = 0; i < num; i++)
> +               g_free(uuid_strs[i]);
> +       g_free(uuid_strs);
> +}
> +
> +static char **new_uuid_strings(struct queue *allowlist, gsize *num)
> +{
> +       const struct queue_entry *entry = NULL;
> +       bt_uuid_t *uuid = NULL;
> +       char **uuid_strs = NULL;
> +       gsize i = 0, allowlist_num;
> +
> +       /* Set num to a non-zero number so that whoever call this could know if
> +        * this function success or not
> +        */
> +       *num = 1;
> +
> +       allowlist_num = queue_length(allowlist);
> +       uuid_strs = g_try_malloc_n(allowlist_num, sizeof(char *));
> +       if (!uuid_strs)
> +               return NULL;
> +
> +       for (entry = queue_get_entries(allowlist); entry != NULL;
> +                                                       entry = entry->next) {
> +               uuid = entry->data;
> +               uuid_strs[i] = g_try_malloc0(MAX_LEN_UUID_STR * sizeof(char));
> +
> +               if (!uuid_strs[i])
> +                       goto failed;
> +
> +               bt_uuid_to_string(uuid, uuid_strs[i], MAX_LEN_UUID_STR);
> +               i++;
> +       }
> +
> +       *num = allowlist_num;
> +       return uuid_strs;
> +
> +failed:
> +       free_uuid_strings(uuid_strs, i);
> +
> +       return NULL;
> +}
> +
> +static void store_policy_settings(struct btd_admin_policy *admin_policy)
> +{
> +       GKeyFile *key_file = NULL;
> +       char *filename = ADMIN_POLICY_STORAGE;
> +       char *key_file_data = NULL;
> +       char **uuid_strs = NULL;
> +       gsize length, num_uuids;
> +
> +       key_file = g_key_file_new();
> +
> +       uuid_strs = new_uuid_strings(admin_policy->service_allowlist,
> +                                                               &num_uuids);
> +
> +       if (!uuid_strs && num_uuids) {
> +               btd_error(admin_policy->adapter_id,
> +                                       "Failed to allocate uuid strings");
> +               goto failed;
> +       }
> +
> +       g_key_file_set_string_list(key_file, "General", "ServiceAllowlist",
> +                                       (const gchar * const *)uuid_strs,
> +                                       num_uuids);
> +
> +       if (create_file(ADMIN_POLICY_STORAGE, 0600) < 0) {
> +               btd_error(admin_policy->adapter_id, "create %s failed, %s",
> +                                               filename, strerror(errno));
> +               goto failed;
> +       }
> +
> +       key_file_data = g_key_file_to_data(key_file, &length, NULL);
> +       g_file_set_contents(ADMIN_POLICY_STORAGE, key_file_data, length, NULL);
> +
> +       g_free(key_file_data);
> +       free_uuid_strings(uuid_strs, num_uuids);
> +
> +failed:
> +       g_key_file_free(key_file);
> +}
> +
> +static void key_file_load_service_allowlist(GKeyFile *key_file,
> +                                       struct btd_admin_policy *admin_policy)
> +{
> +       GError *gerr = NULL;
> +       struct queue *uuid_list = NULL;
> +       gchar **uuids = NULL;
> +       gsize num, i;
> +
> +       uuids = g_key_file_get_string_list(key_file, "General",
> +                                       "ServiceAllowlist", &num, &gerr);
> +
> +       if (gerr) {
> +               btd_error(admin_policy->adapter_id,
> +                                       "Failed to load ServiceAllowlist");
> +               g_error_free(gerr);
> +               return;
> +       }
> +
> +       uuid_list = queue_new();
> +       for (i = 0; i < num; i++) {
> +               bt_uuid_t *uuid = g_try_malloc(sizeof(*uuid));
> +
> +               if (!uuid)
> +                       goto failed;
> +
> +               if (bt_string_to_uuid(uuid, *uuids)) {
> +
> +                       btd_error(admin_policy->adapter_id,
> +                                       "Failed to convert '%s' to uuid struct",
> +                                       *uuids);
> +
> +                       g_free(uuid);
> +                       goto failed;
> +               }
> +
> +               queue_push_tail(uuid_list, uuid);
> +               uuids++;
> +       }
> +
> +       if (!service_allowlist_set(admin_policy, uuid_list))
> +               goto failed;
> +
> +       return;
> +failed:
> +       free_service_allowlist(uuid_list);
> +}
> +
> +static void load_policy_settings(struct btd_admin_policy *admin_policy)
> +{
> +       GKeyFile *key_file;
> +       char *filename = ADMIN_POLICY_STORAGE;
> +       struct stat st;
> +
> +       if (stat(filename, &st) < 0) {
> +               btd_error(admin_policy->adapter_id,
> +                               "Failed to get file %s information",
> +                               filename);
> +               return;
> +       }
> +
> +       key_file = g_key_file_new();
> +
> +       g_key_file_load_from_file(key_file, filename, 0, NULL);
> +
> +       key_file_load_service_allowlist(key_file, admin_policy);
> +
> +       g_key_file_free(key_file);
> +}
> +
>  static bool device_data_match(const void *a, const void *b)
>  {
>         const struct device_data *data = a;
> @@ -305,6 +469,7 @@ static int admin_policy_adapter_probe(struct btd_adapter *adapter)
>         if (!policy_data)
>                 return -ENOMEM;
>
> +       load_policy_settings(policy_data);
>         adapter_path = adapter_get_path(adapter);
>
>         if (!g_dbus_register_interface(dbus_conn, adapter_path,
> --
> 2.32.0.554.ge1b32706d8-goog
>


-- 
Luiz Augusto von Dentz
