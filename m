Return-Path: <SRS0=o7la=44=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D69C0044D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Mar 2020 21:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559A420575
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Mar 2020 21:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcK0gXYe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbgCKVla (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Mar 2020 17:41:30 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37460 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729842AbgCKVla (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Mar 2020 17:41:30 -0400
Received: by mail-ot1-f68.google.com with SMTP id b3so3791757otp.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2020 14:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VmL5i0VhLPFAeoobaUblDeEgv33qYIehND8HCgB9YYI=;
        b=AcK0gXYerygehcNb0N2wTdLQXyx3L4LbtuVIOvXrBoKBNLqLfy54ZEoYi5qK/lohLX
         H09OPH5jb7act94GhjYJXG0Nk6gJiwFgnI5QSJeTd6MRJOI680gM/8GH+xuPDNoL1fQH
         xRw9F0l7dsGBlgddOTB2CatNJIYqAR/N1pfX+jBDQMzA2XyvxqM26v6zVWx9ApIYMn7d
         ABLWx0HO9wdfpfvdZJbi1yDD7Zbsj1Ngc4B4k5hAHLbGL+EKIYBiD0SLHvS+dcEo9zL1
         sfXHsRgtMsRPDXoRHARR151A6sdtVWS0YmnItikpT9gszx+knfzu80pZUeH1KYMfbg+p
         fJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VmL5i0VhLPFAeoobaUblDeEgv33qYIehND8HCgB9YYI=;
        b=enUNcX2zjGqrAQxkjZ998eWtDC0Z9jvhR5fmyb4wuwelMAFoQSsaHZkPf5erYv388n
         TDhK/UzYHhps60l7eA6wWBo9QAxyhhqg1sKEn4BCRrAggD3YXPbZGx6sUMEHTWrmq1U/
         C/yeGIUdyY19c8gNDQylpI67ymMSdgRUG8QRY4iG0u3SzN+vXvFCk+E4S1nRoRgMyn26
         SXtAhEzLTKKnhEYZ9E9m4OlQ+ela8p9xMSPCyL5qlYtA2vs2tAwUqr401+e7oKmPp/s3
         WttdWOBIAgly8FEgmsgxR/EsTgHb6rmtIseR3w+aNY5m3fSd56358MsFzWOloXSYMMzT
         l8hw==
X-Gm-Message-State: ANhLgQ1OLoo/Gkfeju6G0H3W3nPr6lirumR+IXHx+fZf8pjIh4HBfwJJ
        mvxsgZzDQB+WPTVB4Tg5sGblB/4pnGsr6SGEhdWiIMmW
X-Google-Smtp-Source: ADFU+vtF7mgfCn/WfNsCNT08gXIGjnjwsVH+H7DcscuPrQLcGBcVBv2OzmSJKwBiOQ99Y4xgbjbDq1IdkKaG0mwcB+g=
X-Received: by 2002:a9d:720a:: with SMTP id u10mr3666806otj.177.1583962888260;
 Wed, 11 Mar 2020 14:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200311185937.9032-1-luiz.dentz@gmail.com> <20200311185937.9032-2-luiz.dentz@gmail.com>
In-Reply-To: <20200311185937.9032-2-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 11 Mar 2020 14:41:17 -0700
Message-ID: <CABBYNZJSQCRLtVjDUyG1Orwi_7KF7X0MeFbExP6HHG1V7Mu5RQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] input: Add LEAudioSecurity setting to input.conf
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Wed, Mar 11, 2020 at 11:59 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> LEAudioSecurity can be used to enable/disable automatic upgrades of
> security for LE devices, by default it is enabled so existing devices
> that did not require security and were not bonded will automatically
> upgrade the security.
>
> Note: Platforms disabling this setting would require users to manually
> bond the device which may require changes to the user interface to
> always force bonding for input devices ad APIs such as Device.Connect
> directly will no longer work which maybe perceived as a regression.

Does this attends your requirements?

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


-- 
Luiz Augusto von Dentz
