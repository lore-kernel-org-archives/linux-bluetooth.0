Return-Path: <SRS0=NTC4=43=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E472C10DCE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 06:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE98F24677
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 06:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9/vCB6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgCJGWv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Mar 2020 02:22:51 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42487 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgCJGWv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Mar 2020 02:22:51 -0400
Received: by mail-oi1-f196.google.com with SMTP id l12so12730384oil.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Mar 2020 23:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bpECiT6QvSelD1QxqToVqeQP+DDP15UpMCjgF3yk7d4=;
        b=Y9/vCB6lKa04SWlandI2/zCtLLIso+8dX7E7/UKQ1Kc5+QXkTMULodRJ+k+k2wsLPI
         xLX7EjGE/TqQ5JhA4+OM2IZvYLQOAQr+TdoiHk/yzub9ZPK6+bWK/4EJKl6yPVWY661d
         cU3GWpx33bjGwBrm1y+fgPjY3wPNZ9wz+1dhyF75i2J4OhxOghgZduanMcKOVDnWZoAV
         GuOToM2lCqfZDNtrO9Yk/7Ya9xxOoUFbc8HpH24OWQ+YqemONe7mkeJ1Q2pR17PDUr/A
         kQ3MrtfzteSuj9LViD42z8k54RVColiOo6ZNzLQqaaAsA7u2iJMVkh3EY3h1/H0OhEn/
         PkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bpECiT6QvSelD1QxqToVqeQP+DDP15UpMCjgF3yk7d4=;
        b=JT7e7SxeNMFZRhkyPaOCNFAjYhVpQcI+hPNs9KwelmzFjKz5SLohL8xATgPn1J2Nc4
         Lcuq1rN3cMRmqOjWkhnBMky5m5gYBoH9IIW4r7icV+fIoxWLQN33+PWSwzal1hQcH8pg
         Id08qmG8wVF4JDY/ZRySA/XrRkn29WCsig91qpaE3slyM9LB2XWTNjhcXvCuOp7Vf+6h
         xdIGIPXCfnTUY+J5dFT6busKnwZlKRFKxHQP/4ufN1Npp3DQwM081phW/uPxONKnvhuO
         VFUJv7bHiVGbbIoThHfD3Rwaz+nBuLSZzoSyBKePPRmfJabV7LMUAm/9IfXmdP7eIx4S
         C2TA==
X-Gm-Message-State: ANhLgQ05fGIhIs90RlPuFnPnXG3/SMH6f805AnQTbu2AWiZRKI1XpJCA
        R7fhMb2e+UlmVW4yI8+jqLidDCVDXMnzb2NwhYz5R7CM
X-Google-Smtp-Source: ADFU+vsNiD2t5yiVVrZjVUT1TCioJx7zasBn9jLNG6jeYjtFiGbWZbfq39L4oVwWGdiGE04hMNhQ1Q58Xl3MQujaDlc=
X-Received: by 2002:aca:bfc6:: with SMTP id p189mr67660oif.21.1583821369760;
 Mon, 09 Mar 2020 23:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200310023516.209146-1-alainm@chromium.org> <20200310023516.209146-3-alainm@chromium.org>
In-Reply-To: <20200310023516.209146-3-alainm@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 9 Mar 2020 23:22:38 -0700
Message-ID: <CABBYNZJtO=3_KjT1wW-uJbiMaOHmCJcBmhsKTo78QOKHFkpm3g@mail.gmail.com>
Subject: Re: [BlueZ PATCH 2/2] HID accepts bonded device connections only.
To:     Alain Michaud <alainm@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Mon, Mar 9, 2020 at 7:39 PM Alain Michaud <alainm@chromium.org> wrote:
>
> This change adds a configuration for platforms to choose a more secure
> posture for the HID profile.  While some older mice are known to not
> support pairing or encryption, some platform may choose a more secure
> posture by requiring the device to be bonded  and require the
> connection to be encrypted when bonding is required.
>
> Reference:
> https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00352.html

Weird I cannot access this link.

> ---
>
>  profiles/input/device.c   | 23 ++++++++++++++++++++++-
>  profiles/input/device.h   |  1 +
>  profiles/input/input.conf |  8 ++++++++
>  profiles/input/manager.c  | 13 ++++++++++++-
>  4 files changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/profiles/input/device.c b/profiles/input/device.c
> index 2cb3811c8..7fb22b18f 100644
> --- a/profiles/input/device.c
> +++ b/profiles/input/device.c
> @@ -92,6 +92,7 @@ struct input_device {
>
>  static int idle_timeout = 0;
>  static bool uhid_enabled = false;
> +static bool br_bonded_only = false;
>
>  void input_set_idle_timeout(int timeout)
>  {
> @@ -103,6 +104,11 @@ void input_enable_userspace_hid(bool state)
>         uhid_enabled = state;
>  }
>
> +void input_set_br_bonded_only(bool state)
> +{
> +       br_bonded_only = state;
> +}
> +
>  static void input_device_enter_reconnect_mode(struct input_device *idev);
>  static int connection_disconnect(struct input_device *idev, uint32_t flags);
>
> @@ -970,8 +976,18 @@ static int hidp_add_connection(struct input_device *idev)
>         if (device_name_known(idev->device))
>                 device_get_name(idev->device, req->name, sizeof(req->name));
>
> +       /* Make sure the device is bonded if required */
> +       if (br_bonded_only && !device_is_bonded(idev->device,
> +                               btd_device_get_bdaddr_type(idev->device))) {
> +               error("Rejected connection from !bonded device %s", dst_addr);
> +               goto cleanup;
> +       }
> +
>         /* Encryption is mandatory for keyboards */
> -       if (req->subclass & 0x40) {
> +       /* Some platforms may choose to require encryption for all devices */
> +       /* Note that this only matters for pre 2.1 devices as otherwise the */
> +       /* device is encrypted by default by the lower layers */

You should use multiline comments above.

> +       if (br_bonded_only || req->subclass & 0x40) {
>                 if (!bt_io_set(idev->intr_io, &gerr,
>                                         BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
>                                         BT_IO_OPT_INVALID)) {

This one seems to be doing what I suggested for HoG, it attempt to
bump the security so we might as well do the same for HoG.

> @@ -1203,6 +1219,11 @@ static void input_device_enter_reconnect_mode(struct input_device *idev)
>         DBG("path=%s reconnect_mode=%s", idev->path,
>                                 reconnect_mode_to_string(idev->reconnect_mode));
>
> +       /* Make sure the device is bonded if required */
> +       if (br_bonded_only && !device_is_bonded(idev->device,
> +                               btd_device_get_bdaddr_type(idev->device)))
> +               return;
> +
>         /* Only attempt an auto-reconnect when the device is required to
>          * accept reconnections from the host.
>          */
> diff --git a/profiles/input/device.h b/profiles/input/device.h
> index 51a9aee18..aaf312f0e 100644
> --- a/profiles/input/device.h
> +++ b/profiles/input/device.h
> @@ -29,6 +29,7 @@ struct input_conn;
>
>  void input_set_idle_timeout(int timeout);
>  void input_enable_userspace_hid(bool state);
> +void input_set_br_bonded_only(bool state);
>
>  int input_device_register(struct btd_service *service);
>  void input_device_unregister(struct btd_service *service);
> diff --git a/profiles/input/input.conf b/profiles/input/input.conf
> index 3e1d65aae..58791b7e6 100644
> --- a/profiles/input/input.conf
> +++ b/profiles/input/input.conf
> @@ -11,3 +11,11 @@
>  # Enable HID protocol handling in userspace input profile
>  # Defaults to false (HIDP handled in HIDP kernel module)
>  #UserspaceHID=true
> +
> +# Limit HID connections to bonded devices
> +# The HID Profile does not specify that devices must be bonded, however some
> +# platforms may want to make sure that input connections only come from bonded
> +# device connections. Several older mice have been known for not supporting
> +# pairing/encryption.
> +# Defaults to false to maximize device compatibility.
> +#BrBondedOnly=true

Id make this more generic e.g. RequireEncryption and use it for both
HoG and legacy HID, that way nobody will be caugh by surprise if we
starting doing this for HoG since there may be devices already
connecting that haven't been previously bonded, if we automatically
trigger bonding that should still work but it kind hard to know in
advance how broken peripherals are in this respect.

> diff --git a/profiles/input/manager.c b/profiles/input/manager.c
> index 1d31b0652..ec45e1649 100644
> --- a/profiles/input/manager.c
> +++ b/profiles/input/manager.c
> @@ -96,7 +96,7 @@ static int input_init(void)
>         config = load_config_file(CONFIGDIR "/input.conf");
>         if (config) {
>                 int idle_timeout;
> -               gboolean uhid_enabled;
> +               gboolean uhid_enabled, br_bonded_only;
>
>                 idle_timeout = g_key_file_get_integer(config, "General",
>                                                         "IdleTimeout", &err);
> @@ -114,6 +114,17 @@ static int input_init(void)
>                         input_enable_userspace_hid(uhid_enabled);
>                 } else
>                         g_clear_error(&err);
> +
> +               br_bonded_only = g_key_file_get_boolean(config, "General",
> +                                                       "BrBondedOnly", &err);
> +
> +               if (!err) {
> +                       DBG("input.conf: BrBondedOnly=%s", br_bonded_only ?
> +                                                       "true" : "false");
> +                       input_set_br_bonded_only(br_bonded_only);
> +               } else
> +                       g_clear_error(&err);
> +
>         }
>
>         btd_profile_register(&input_profile);
> --
> 2.25.1.481.gfbce0eb801-goog
>


-- 
Luiz Augusto von Dentz
