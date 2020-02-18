Return-Path: <SRS0=m/C2=4G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4999C34026
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Feb 2020 18:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F732070B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Feb 2020 18:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQXBfT2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgBRSWP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:22:15 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37831 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgBRSWP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Feb 2020 13:22:15 -0500
Received: by mail-ot1-f66.google.com with SMTP id w23so4044334otj.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2020 10:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wcpUjzbyx+RC5viCzm0GJwSfAumv9vNisdB7uqb41ug=;
        b=PQXBfT2cJGVAnaryS6Y6vRGDg3J7FNAryhttBwD51n1WZAwDoP0Gscsgin+1GgGGb8
         EnvNouJiLzbAEoMWIFRo0ExST9BY8JDSwpEJojt3TSNTdn2G6VBGPefzj0hegPbiPAP4
         KCFMjiEO8Et5HhQv0mgGOwZ03AA+HoudkG+Em/a5EA3F1M84hwXzRC0udMNmNPwfetQB
         9QvvPFHo7t2PR+XMuR11mQz62p4bS7coEczwp/EBX74QmA9w3k/cbbBWTjsAfqrcN0x6
         7NcDBQV0BTyKxWr1balp3WR8sdw/G6gN9tmlKsCHXOCZrXzGFQSjpQXIjdolxjku+6dK
         6muw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wcpUjzbyx+RC5viCzm0GJwSfAumv9vNisdB7uqb41ug=;
        b=Wofqqjmg4cVBcq0GLHwVhf9VeYyjHeUHpKVP+K9+WjlKGatm0ren49oillJHtqI6fy
         UjQQZOry+Dd3QoW6rch0nJufB9qj4F7uquKmEM+5q1SlvmHvUpTepolf+/xqI2iNASBL
         8bBEr2sCfoKPCSXWuDLiBiwQst9KBYTrcQIci/cMebPpRClnzGv1S0rYNJ+9GJ/JIKbw
         suDqA2B9U98iE50uYPlnwUvF2kgwO/T5b+t5humlHMfplmyf7QQB496iAbBu/ZUVh/jx
         Gjy7+Es4cXU9OImy0FcKh5OJpZNAwhEwba+SZlSaa+5Fdgb/DxPuYcDL0FR2Uors1ADQ
         ZsRA==
X-Gm-Message-State: APjAAAWcCS/bye6ORCSauv0cTnGNk0mUjvR9ZvlyM4goIszRdJOpKsZW
        OGVKYn5gBmQ/XLlIfy4j7cDCvOHNVHEHDxEVFQQ=
X-Google-Smtp-Source: APXvYqwoGm4vcYn+lRqiMzkJOQg4C/mNafAl6eo3fQAi2NQ8mw5lrbSbtn6HjdPblQV/JlKesVDtbLhwesUaYlmI4Co=
X-Received: by 2002:a9d:3cf:: with SMTP id f73mr16756920otf.11.1582050134010;
 Tue, 18 Feb 2020 10:22:14 -0800 (PST)
MIME-Version: 1.0
References: <20200215114408.Bluez.v4.1.I333a90ad3c75882c6f008c94a28ca7d3e8f6c76e@changeid>
In-Reply-To: <20200215114408.Bluez.v4.1.I333a90ad3c75882c6f008c94a28ca7d3e8f6c76e@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 18 Feb 2020 10:22:02 -0800
Message-ID: <CABBYNZ+tiW-FT5QxNCbCb4ZpmuZ-GqqW18_atdHbBHLCzr6URQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v4] core: Add new policy for Just-Works repairing
To:     Howard Chung <howardchung@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Fri, Feb 14, 2020 at 7:49 PM Howard Chung <howardchung@google.com> wrote:
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
> ---
> The Just-Works repairing policy could be one of the following:
> - never: default; reject the repairing immediately.
> - confirm: prompt a confirmation dialog to user.
> - always: always accept the repairing.
>
> Changes in v4:
> - optimize the code in src/device.c
>
> Changes in v3:
> - move the check from src/agent.c to src/device.c
> - fix the enum declaration in src/hcid.h
>
> Changes in v2:
> - let RequestAuthorization handle the situation
> - remove the changes in client/
>
>  src/device.c  | 15 +++++++++++++++
>  src/hcid.h    |  8 ++++++++
>  src/main.c    | 27 +++++++++++++++++++++++++++
>  src/main.conf |  5 +++++
>  4 files changed, 55 insertions(+)
>
> diff --git a/src/device.c b/src/device.c
> index a4fe10980..a8f4c22f3 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -6141,6 +6141,21 @@ int device_confirm_passkey(struct btd_device *device, uint8_t type,
>         struct authentication_req *auth;
>         int err;
>
> +       /* Just-Works repairing policy */
> +       if (confirm_hint && device_is_paired(device, type)) {
> +               if (main_opts.jw_repairing == JW_REPAIRING_NEVER) {
> +                       btd_adapter_confirm_reply(device->adapter,
> +                                                 &device->bdaddr,
> +                                                 type, FALSE);
> +                       return 0;
> +               } else if (main_opts.jw_repairing == JW_REPAIRING_ALWAYS) {
> +                       btd_adapter_confirm_reply(device->adapter,
> +                                                 &device->bdaddr,
> +                                                 type, TRUE);
> +                       return 0;
> +               }
> +       }
> +
>         auth = new_auth(device, type, AUTH_TYPE_CONFIRM, FALSE);
>         if (!auth)
>                 return -EPERM;
> diff --git a/src/hcid.h b/src/hcid.h
> index adea85ce2..ca405fde4 100644
> --- a/src/hcid.h
> +++ b/src/hcid.h
> @@ -35,6 +35,12 @@ typedef enum {
>         BT_GATT_CACHE_NO,
>  } bt_gatt_cache_t;
>
> +enum jw_repairing_t {
> +       JW_REPAIRING_NEVER,
> +       JW_REPAIRING_CONFIRM,
> +       JW_REPAIRING_ALWAYS,
> +};
> +
>  struct main_opts {
>         char            *name;
>         uint32_t        class;
> @@ -58,6 +64,8 @@ struct main_opts {
>         uint16_t        gatt_mtu;
>
>         uint8_t         key_size;
> +
> +       enum jw_repairing_t jw_repairing;
>  };
>
>  extern struct main_opts main_opts;
> diff --git a/src/main.c b/src/main.c
> index 1a6ab36a3..fc8c869fc 100644
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
> +static enum jw_repairing_t parse_jw_repairing(const char *jw_repairing)
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
> 2.25.0.265.gbab2e86ba0-goog

Applied, thanks.

-- 
Luiz Augusto von Dentz
