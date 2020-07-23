Return-Path: <SRS0=glhu=BC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E113EC433EA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jul 2020 16:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFB6620714
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jul 2020 16:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vV70HGOZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbgGWQoH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jul 2020 12:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729841AbgGWQoH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Jul 2020 12:44:07 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB440C0619DC
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2020 09:44:06 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id a21so4816836otq.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2020 09:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GOMz2Q/47nTESPFdNOKAcr/LxRDSdhzbZLCJhwBaSMA=;
        b=vV70HGOZovZX99Smj9azcQDxBVh1TDvfFt9NvqSj1PD8BWAEL2iXUxh1yuZZby7PPL
         oMjMFuM5YJHmzrkGUY1Ph/TqRGP0olm9MjJz3/HYiuGog2nqz2Z3ZTBWptKLsWUwsp7I
         5TrOlvVN6cecTDmtIWbFQyNzhiC1rLfV5WwUViAbTmKf86k4hAaKtDrKTqRAz0Kwp61P
         xIlCOpX/gA26tmtes/dMMuLSwLPg5bI1TSyMaZ0MAqHsaQjQVOI4jPX0BLVTmtY30BBg
         bmMNd5EzddPwx1NnMr8HyovrCbS8niKtIb6GR6nw7djnxUB151rM1nVUk3Ob/Y1GLPJj
         qgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GOMz2Q/47nTESPFdNOKAcr/LxRDSdhzbZLCJhwBaSMA=;
        b=gEdk3SOQzq6dH/eZMbN4B4Scp6fP+VNiBVo1lteuboF0VJI6tBGKdrLOFxiEhOSPAV
         2Rh3RiUvFoJTPGr1FlUsQGVFg6yucxQJATbeX6YePx/eRT2iwx+BiJjJtnjg6990lLoN
         ua9i6rENwk1r3uLvR3EtD4acuYyX1Zzxgy5jGnTMkTK0rYtFwoh4YQrE3DuDX5E7vR8P
         iUiA6Y3fNEy8HCcyYFnYWQgg/TbZ1HC6aQXtKAth96fwDy7yF8ozjpN0dusVm9dZrQjK
         J4cJg5r1TU+i982UIjmjZ8m+9zVxvNxpZdBEYtaQ3AaTAJ8uHZ5rR+kd5IPDUQ5p5GQ3
         0YfQ==
X-Gm-Message-State: AOAM532YGnKkRqDUmm5tKRukpI9pglWTr0YgfkDdCdHIlgYgwP8d5roU
        JH5yhXMpFVYjfQCg8tcU15Hcq0iwiPNqGCbt66kfnezH
X-Google-Smtp-Source: ABdhPJziKIVFQZZyGAc19wkoW8k4tTThOGnjlMwwbLjGzJvYykpLjFytDjQepmXpfbFy9m0D/iU2m46wZui/FcOuteM=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id v19mr4937480ota.91.1595522646286;
 Thu, 23 Jul 2020 09:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200723002022.Bluez.v1.1.I45e09d196073f099e1b67d2d69efd5cd20237ad1@changeid>
In-Reply-To: <20200723002022.Bluez.v1.1.I45e09d196073f099e1b67d2d69efd5cd20237ad1@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 23 Jul 2020 09:43:55 -0700
Message-ID: <CABBYNZ+PuAxJn_-0q-nanE6ovAbRk2d8s3x=nHGe4F955UL4hA@mail.gmail.com>
Subject: Re: [Bluez PATCH v1 1/2] input: authenticate when connecting to a
 bonded device
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Wed, Jul 22, 2020 at 9:20 AM Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> According to bluetooth HID1.1 spec, part 5.4.3.4.3:
> If the Bluetooth HID Host is bonded to a Bluetooth HID device:
> If encryption is not already enabled, the Bluetooth HID Host shall
> enable encryption with the Bluetooth HID device before sending an
> L2CAP Connect Request to open the HID L2CAP Control channel.
>
> When creating connection, this patch checks whether the target
> device is bonded, if yes then we use the medium security level
> instead of the low one to enable encryption.
>
> Reviewed-by: Alain Michaud <alainm@chromium.org>
> ---
>
>  profiles/input/device.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/profiles/input/device.c b/profiles/input/device.c
> index 2dc2ecab2..9f89f4459 100644
> --- a/profiles/input/device.c
> +++ b/profiles/input/device.c
> @@ -112,6 +112,12 @@ void input_set_classic_bonded_only(bool state)
>  static void input_device_enter_reconnect_mode(struct input_device *idev);
>  static int connection_disconnect(struct input_device *idev, uint32_t flags);
>
> +static bool input_device_bonded(struct input_device *idev)
> +{
> +       return device_is_bonded(idev->device,
> +                               btd_device_get_bdaddr_type(idev->device));
> +}
> +
>  static void input_device_free(struct input_device *idev)
>  {
>         bt_uhid_unref(idev->uhid);
> @@ -979,8 +985,7 @@ static int hidp_add_connection(struct input_device *idev)
>                 device_get_name(idev->device, req->name, sizeof(req->name));
>
>         /* Make sure the device is bonded if required */
> -       if (classic_bonded_only && !device_is_bonded(idev->device,
> -                               btd_device_get_bdaddr_type(idev->device))) {
> +       if (classic_bonded_only && !input_device_bonded(idev)) {
>                 error("Rejected connection from !bonded device %s", dst_addr);
>                 goto cleanup;
>         }
> @@ -1153,16 +1158,23 @@ static int dev_connect(struct input_device *idev)
>  {
>         GError *err = NULL;
>         GIOChannel *io;
> +       BtIOSecLevel sec_level;
>
>         if (idev->disable_sdp)
>                 bt_clear_cached_session(&idev->src, &idev->dst);
>
> +       /* encrypt connection if device is bonded */
> +       if (input_device_bonded(idev))
> +               sec_level = BT_IO_SEC_MEDIUM;
> +       else
> +               sec_level = BT_IO_SEC_LOW;
> +
>         io = bt_io_connect(control_connect_cb, idev,
>                                 NULL, &err,
>                                 BT_IO_OPT_SOURCE_BDADDR, &idev->src,
>                                 BT_IO_OPT_DEST_BDADDR, &idev->dst,
>                                 BT_IO_OPT_PSM, L2CAP_PSM_HIDP_CTRL,
> -                               BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
> +                               BT_IO_OPT_SEC_LEVEL, sec_level,
>                                 BT_IO_OPT_INVALID);
>         idev->ctrl_io = io;
>
> @@ -1227,8 +1239,7 @@ static void input_device_enter_reconnect_mode(struct input_device *idev)
>                                 reconnect_mode_to_string(idev->reconnect_mode));
>
>         /* Make sure the device is bonded if required */
> -       if (classic_bonded_only && !device_is_bonded(idev->device,
> -                               btd_device_get_bdaddr_type(idev->device)))
> +       if (classic_bonded_only && !input_device_bonded(idev))
>                 return;
>
>         /* Only attempt an auto-reconnect when the device is required to
> --
> 2.28.0.rc0.105.gf9edc3c819-goog
>

Applied, thanks.

-- 
Luiz Augusto von Dentz
