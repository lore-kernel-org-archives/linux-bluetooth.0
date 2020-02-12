Return-Path: <SRS0=IUpk=4A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1078BC352A4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Feb 2020 21:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D071D206DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Feb 2020 21:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2yza1Uk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgBLVTK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Feb 2020 16:19:10 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46369 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbgBLVTK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Feb 2020 16:19:10 -0500
Received: by mail-ot1-f65.google.com with SMTP id g64so3392440otb.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2020 13:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kMa21Giv+GY1ft1XzVP4imOruGEaQE8XM4+rjwpZrT8=;
        b=i2yza1UkLnLyNz3CfT/vt+lbSC0kxE0pVhMXI0+fyGX1yiGZYu7SyWIruKVMjrLDDS
         Ujn1smJdNFQzLMRcY9CRZJK9Spzx78pDF35Z3IruK4DAtXLtD/BWyW+wqMAhfSX/ScrK
         8Cp2qN+XyIghX4bhnu6bytX3+jCBBwaQA51K5SqOmsrjb4DNLp/TwjVOnHcvLvwStNj6
         JFDf9Ii9OeIjE3Mdfn2nBWl8U6GlyrooPBAsDsHXOgArzJuruIq83WpjHcjxc+wTJmuL
         QEkjo+cbpUvvXtVehf0w1Z0V8qdGNIojITSDyIEiAfTUCfX8X9FNX0fxSyzc60bCmg3Y
         t3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kMa21Giv+GY1ft1XzVP4imOruGEaQE8XM4+rjwpZrT8=;
        b=AmedbtUZSs/AMHdB9sV6x/w8jBwWgobObjSMzawdFC5EYTetvotdKNtatOdvCYCiLh
         QZ4XGfrVmDYiwMTsYB4z+qhT8RzPhTKA1Ap1zu1rtsF3TR4aMM8mbDsz5Oeqf7hoLglS
         QzNO7/5LMmq4T/JXJSmcsZyaomjdWMqP0m0InR6NU6jThtu5vS7JdqouVH16xGhv26Jr
         w3Xw+8OZOnEcGBrLbBCXy9DIsLbhit/CqD1E9CBliGAygJWZm+BogMXTkuymxWOMt8G9
         kNoDJSyzjwCybMSiHgI18/QTk5JlW44e09hzt+Qfep+v6eCXMTl69uI3SA5y1oh0pgAB
         RcMw==
X-Gm-Message-State: APjAAAUi6QMly98sHj751yR3aJHTGZsNEj8jqGxHuqkaDPBAQicQs/4R
        PLrwFAcZDWnv409Tjt2ApW7HmFgbjno4l/FAu0I=
X-Google-Smtp-Source: APXvYqzU1zyLs6S6HOd1V1AHJqH0Ipuj/HjprCRk7ivkLKl9skL6oeJel9We+fiL9aUGTludjqIX7seiwGBGh1tqVjM=
X-Received: by 2002:a9d:3cf:: with SMTP id f73mr10953570otf.11.1581542348751;
 Wed, 12 Feb 2020 13:19:08 -0800 (PST)
MIME-Version: 1.0
References: <20200212212729.Bluez.v2.1.I333a90ad3c75882c6f008c94a28ca7d3e8f6c76e@changeid>
In-Reply-To: <20200212212729.Bluez.v2.1.I333a90ad3c75882c6f008c94a28ca7d3e8f6c76e@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 12 Feb 2020 13:18:56 -0800
Message-ID: <CABBYNZKpJmNvW1vB1AxrLkESkUGc88+TjkCTxVmU=jaCyk9FYg@mail.gmail.com>
Subject: Re: [Bluez PATCH v2] core: Add new policy for Just-Works repairing
To:     Howard Chung <howardchung@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        chromeos-bluetooth-upstreaming@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Wed, Feb 12, 2020 at 5:30 AM Howard Chung <howardchung@google.com> wrote:
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

Can't we just return an error here instead of creating a D-Bus error
just to call the callback?

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


-- 
Luiz Augusto von Dentz
