Return-Path: <SRS0=IUpk=4A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07B7C2BA83
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Feb 2020 13:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD172082F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Feb 2020 13:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbtBB7W+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgBLN6e (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Feb 2020 08:58:34 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39501 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727732AbgBLN6d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Feb 2020 08:58:33 -0500
Received: by mail-ot1-f65.google.com with SMTP id 77so1967817oty.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2020 05:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6EXWdJKBMXTZ1wgjEOeROfMvD3aPeZvry3+qKMj07qA=;
        b=LbtBB7W+NJDww+QDfZ7+i7YP7nPlsC7J7FTfQBi/BMhu/ZVettQHuum0mIq2bh9WCl
         zfbeutBqSMYLHddtBh6plJARpTUESH7z6zZo2k+EeHuKVpTH0qhvaEClwj2zphTjKEH6
         SLquKWZh5+35IFVsGh8VPuuulC0TQJ5pLN1QaXvS5XvzpxMzu6YlRT2+OUqUkDDLNNZr
         6jV2csjAo/V5KqKU8WLKe9d2dPxVYVXoHncZ8rr4ba6JPAGBVHl31Hk3MEYOHtoK6oMm
         s7jUaf/OmdOKFcLjlbpbTH3NwQ1GMVgdV5MdgRI7zjldOuIUdIvtTh7jWWcWGOkzwUSf
         Z52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6EXWdJKBMXTZ1wgjEOeROfMvD3aPeZvry3+qKMj07qA=;
        b=VoU4Q1FGrHvNKsvzTYBRSwOMNFeultXE2xsLY9ks+bUl4tfG8P3v+/fdvhhGJB5rxP
         tpRsqh2gLVlk5rP390KUK1M5lpYYoxYfA9/yUP6y6eTrAjizZVZXOxlvmzSAOxX/Wgsy
         GuhTK/otv1002+e4k6aE9c8VtSmkaFfiQZOHzEZ9D5SL5lRbwiF8HJ2EbTaOGQb2QSkg
         4oEe06aWWeVM3zbgzyAS0Jj2a+oNDf0LGdoN0aYPW3aEJtMLeFCOpY/aYCFlqdM5bKHF
         995QBFSsuU7+G7mo2d1Xk5EqW/dTZXS/1wgrU79Btt9OLdF/0YRVtPYBHFxDIJWybbiz
         M1ng==
X-Gm-Message-State: APjAAAV4mozv6bnCqzIAHnrgEGNa/8UwWh0UsaC2vLjYplKfNRscpTPz
        yo6+n2XLnDluG7iix0Vill1mS39whenB2c/BMh4=
X-Google-Smtp-Source: APXvYqwjNIJJ3behgk6Q68Oa5N50rJ8mngBiyQlvY7T/uEgMgzaqNdaYWKZpJoPOKlNcNoUATl++ervgn7mQjwpz3sg=
X-Received: by 2002:a9d:5786:: with SMTP id q6mr8973793oth.164.1581515913172;
 Wed, 12 Feb 2020 05:58:33 -0800 (PST)
MIME-Version: 1.0
References: <20200212212729.Bluez.v2.1.I333a90ad3c75882c6f008c94a28ca7d3e8f6c76e@changeid>
In-Reply-To: <20200212212729.Bluez.v2.1.I333a90ad3c75882c6f008c94a28ca7d3e8f6c76e@changeid>
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Wed, 12 Feb 2020 14:58:22 +0100
Message-ID: <CAO1O6sfXYs7iT972XMk=SRLrg-LXtHtDmMnSKTu2FHzMkZeNEw@mail.gmail.com>
Subject: Re: [Bluez PATCH v2] core: Add new policy for Just-Works repairing
To:     Howard Chung <howardchung@google.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        luiz.von.dentz@intel.com,
        chromeos-bluetooth-upstreaming@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

Den ons 12 feb. 2020 kl 14:30 skrev Howard Chung <howardchung@google.com>:
>
> From: "howardchung@google.com" <howardchung@google.com>
>
> When kernel find out that the incoming Just-Works pairing is
> initiated by a paired device, it is user space's responsibility to
> decide the next action.
>
> This patch includes the following:
> - add JustWorksRepairing policy as an option in main.conf
> - handle the confirmation request from kernel
>
> ---
> The Just-Works repairing policy could be one of the following:
> - never: default; reject the repairing immediately.
> - confirm: prompt a confirmation dialog to user.
> - always: always accept the repairing.
>
> Changes in v2:
> - let RequestAuthorization handle the situation
> - remove the changes in client/
>
>  src/agent.c   | 16 ++++++++++++++++
>  src/hcid.h    |  8 ++++++++
>  src/main.c    | 27 +++++++++++++++++++++++++++
>  src/main.conf |  5 +++++
>  4 files changed, 56 insertions(+)
>
> diff --git a/src/agent.c b/src/agent.c
> index e0ffcd22f..e013ec85f 100644
> --- a/src/agent.c
> +++ b/src/agent.c
> @@ -773,12 +773,28 @@ int agent_request_authorization(struct agent *agent, struct btd_device *device,
>                                                 GDestroyNotify destroy)
>  {
>         struct agent_request *req;
> +       DBusError dbus_err;
>         int err;
>
>         err = agent_has_request(agent, device, AGENT_REQUEST_AUTHORIZATION);
>         if (err)
>                 return err;
>
> +       /* Just-Works repairing policy */
> +       if (device_is_paired(device, BDADDR_BREDR) ||
> +                               device_is_paired(device, BDADDR_LE_PUBLIC)) {
> +               if (main_opts.jw_repairing == JW_REPAIRING_NEVER) {
> +                       dbus_error_init(&dbus_err);
> +                       dbus_set_error_const(&dbus_err,
> +                                       ERROR_INTERFACE ".Rejected", NULL);
> +                       cb(agent, &dbus_err, user_data);
> +                       return 0;
> +               } else if (main_opts.jw_repairing == JW_REPAIRING_ALWAYS) {
> +                       cb(agent, NULL, user_data);
> +                       return 0;
> +               }
> +       }
> +
>         DBG("Calling Agent.RequestAuthorization: name=%s, path=%s",
>                                                 agent->owner, agent->path);
>
> diff --git a/src/hcid.h b/src/hcid.h
> index adea85ce2..bcd2b9fa1 100644
> --- a/src/hcid.h
> +++ b/src/hcid.h
> @@ -35,6 +35,12 @@ typedef enum {
>         BT_GATT_CACHE_NO,
>  } bt_gatt_cache_t;
>
> +enum {
> +       JW_REPAIRING_NEVER,
> +       JW_REPAIRING_CONFIRM,
> +       JW_REPAIRING_ALWAYS,
> +} jw_repairing_t;
> +
>  struct main_opts {
>         char            *name;
>         uint32_t        class;
> @@ -58,6 +64,8 @@ struct main_opts {
>         uint16_t        gatt_mtu;
>
>         uint8_t         key_size;
> +
> +       jw_repairing_t  jw_repairing;
>  };
>
>  extern struct main_opts main_opts;
> diff --git a/src/main.c b/src/main.c
> index 1a6ab36a3..d67f469f1 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -93,6 +93,7 @@ static const char *supported_options[] = {
>         "MultiProfile",
>         "FastConnectable",
>         "Privacy",
> +       "JustWorksRepairing",
>         NULL
>  };
>
> @@ -193,6 +194,20 @@ static bt_gatt_cache_t parse_gatt_cache(const char *cache)
>         }
>  }
>
> +static jw_repairing_t parse_jw_repairing(const char *jw_repairing)
> +{
> +       if (!strcmp(jw_repairing, "never")) {
> +               return JW_REPAIRING_NEVER;
> +       } else if (!strcmp(jw_repairing, "confirm")) {
> +               return JW_REPAIRING_CONFIRM;
> +       } else if (!strcmp(jw_repairing, "always")) {
> +               return JW_REPAIRING_ALWAYS;
> +       } else {
> +               return JW_REPAIRING_NEVER;
> +       }
> +}
> +
> +
>  static void check_options(GKeyFile *config, const char *group,
>                                                 const char **options)
>  {
> @@ -331,6 +346,18 @@ static void parse_config(GKeyFile *config)
>                 g_free(str);
>         }
>
> +       str = g_key_file_get_string(config, "General",
> +                                               "JustWorksRepairing", &err);
> +       if (err) {
> +               DBG("%s", err->message);
> +               g_clear_error(&err);
> +               main_opts.jw_repairing = JW_REPAIRING_NEVER;
> +       } else {
> +               DBG("just_works_repairing=%s", str);
> +               main_opts.jw_repairing = parse_jw_repairing(str);
> +               g_free(str);
> +       }
> +
>         str = g_key_file_get_string(config, "General", "Name", &err);
>         if (err) {
>                 DBG("%s", err->message);
> diff --git a/src/main.conf b/src/main.conf
> index 40687a755..bb5ff5b15 100644
> --- a/src/main.conf
> +++ b/src/main.conf
> @@ -72,6 +72,11 @@
>  # Defaults to "off"
>  # Privacy = off
>
> +# Specify the policy to the JUST-WORKS repairing initiated by peer
> +# Possible values: "never", "confirm", "always"
> +# Defaults to "never"
> +#JustWorksRepairing = never
> +
>  [GATT]
>  # GATT attribute cache.
>  # Possible values:
> --
> 2.25.0.225.g125e21ebc7-goog
>

I haven't looked much into this, but have a question. What happens by
default currently when we have an already bonded device previously
paired using some MITM-protected mechanism, and suddenly wants to
re-bond using a less secure mechanism (Just Works)? In my opinion
denying this should obviously be the default in case no agent is
available, compared to if pairing a new device then the default should
be accept.

/Emil
