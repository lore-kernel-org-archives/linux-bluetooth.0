Return-Path: <SRS0=I8IU=AS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6784C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 09:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F6DD20708
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 09:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p4SZRfJQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgGGJfB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jul 2020 05:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbgGGJfA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jul 2020 05:35:00 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1E3C061755
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2020 02:35:00 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k6so44430719wrn.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2020 02:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uA8EhsPuwTAmoWTLY0mx1vOJ7jGJwFLaF3KRVuoae/s=;
        b=p4SZRfJQlGDxKqQkwezbwPHU1pvNMWIVhAdwqcIYSCYZ1vw8XmEK3pdcQrhfjKmG4H
         yFCCdpdBwkRVBsqZNgf6FGvl/49iI7GZKJjiH+GTeCeDsfP5UhUH7IUXk0elWt8EwkI8
         8Z5CJaYqXUYRE/TOrfUcwOxDf3r9vLRGw/W+9eg3yKzoe/VNhtoRkm+YXqDnK8Hw3xrH
         GqZbIGNCMZH71JYU3xZnlmdDyYEKGxV7Fja6RJ/oAv+xk5DsdvIArQXLtwMMW+eTR6iN
         Mlgk+stKN0iZ1vj0/fOvOoihgDuXWagMuPXNXANxH2WNGVWsVSgKk7MrTEA/8fC1HIl/
         Wxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uA8EhsPuwTAmoWTLY0mx1vOJ7jGJwFLaF3KRVuoae/s=;
        b=nXYYc9PM/K7YQQortp1V9rW/p8oQSqLIv/x1Ofz2K22FZCOA5DtgkIXZUT22OGHuab
         VgeAtvcR0POf5D+BEA+AyiJX/pgMuqyTkvAoefn1qbB183Jah9T0/5BmbtYSw8pRJjDW
         pxhI7BtjKGcyHZXRIJrbNCDCngKFZNDoXezmcbr48AFUBOtELEL1XxsP+jEzJJv2EM9/
         cnrW5N1zPfqP1/anlxOXWuWC09o2Y/9nQy7zMFDS40aGjl9V9L5tIkWSIk/2vBFXXDC8
         2TZyPdaMkjxPL52tqSGgPLC1Ky94odEXp62AGx7Pk0+DgtA3HA5hy2hs/VbS+Uja4U3T
         04mg==
X-Gm-Message-State: AOAM530lS70KihDx5ZUtJoX978SG5YMux4dRWBvktT4fr3b9kUivx7Em
        HTWa7ZrTPbmaEeCfkbsq0Kei70kaZqPj2vBo+1YiV4Ol
X-Google-Smtp-Source: ABdhPJwZ4t/cKR4jQ4ufTUeYIKAjlG9WXvyHxO8SCcLKnYdEw37u4KMNYIVPA8XFcPNa0eioj0JVF2f8KydpkeXmm/4=
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr52696015wrs.365.1594114498536;
 Tue, 07 Jul 2020 02:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200627235318.Bluez.v2.1.I1322f6745fa50365c1c88de3e2c50c9c5962c094@changeid>
 <20200627235318.Bluez.v2.2.I16f38fd33617bbbf84d144605861b8391605a761@changeid>
In-Reply-To: <20200627235318.Bluez.v2.2.I16f38fd33617bbbf84d144605861b8391605a761@changeid>
From:   Archie Pusaka <apusaka@google.com>
Date:   Tue, 7 Jul 2020 17:34:47 +0800
Message-ID: <CAJQfnxG_Mw5DsajUgGPKYZt+ZjjVNQP8mTQ8W28BsK-=LGjcBw@mail.gmail.com>
Subject: Re: [Bluez PATCH v2 2/2] input: Remove bonding info when receiving
 virtual cable unplug
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Archie Pusaka <apusaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bluez maintainers,

Could you take a look at this patch?

Thanks,
Archie


On Sat, 27 Jun 2020 at 23:54, Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> From Bluetooth HID Profile 1.1 Spec: If a Virtual Cable is
> unplugged via a HID control Virtual Unplug command, then both the
> Bluetooth HID device and Bluetooth HID Host shall destroy or
> invalidate all Bluetooth bonding and Virtual Cable information
> that was previously stored in persistent memory for the respective
> Virtually Cabled devices and hosts.
>
> This patch removes the bonding information upon receiving and/or
> sending a "virtual cable unplug".
>
> Reviewed-by: Alain Michaud <alainm@chromium.org>
> ---
>
> Changes in v2:
> - Properly pass the correct argument to device_remove_bonding
> - rename unbond_on_disconnect to virtual_cable_unplug
>
>  profiles/input/device.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/profiles/input/device.c b/profiles/input/device.c
> index d3724ed54..a76ab90bd 100644
> --- a/profiles/input/device.c
> +++ b/profiles/input/device.c
> @@ -88,6 +88,7 @@ struct input_device {
>         uint8_t                 report_req_pending;
>         guint                   report_req_timer;
>         uint32_t                report_rsp_id;
> +       bool                    virtual_cable_unplug;
>  };
>
>  static int idle_timeout = 0;
> @@ -148,6 +149,14 @@ static void input_device_free(struct input_device *idev)
>         g_free(idev);
>  }
>
> +static void virtual_cable_unplug(struct input_device *idev)
> +{
> +       device_remove_bonding(idev->device,
> +                               btd_device_get_bdaddr_type(idev->device));
> +
> +       idev->virtual_cable_unplug = false;
> +}
> +
>  static bool hidp_send_message(GIOChannel *chan, uint8_t hdr,
>                                         const uint8_t *data, size_t size)
>  {
> @@ -188,6 +197,9 @@ static bool hidp_send_message(GIOChannel *chan, uint8_t hdr,
>  static bool hidp_send_ctrl_message(struct input_device *idev, uint8_t hdr,
>                                         const uint8_t *data, size_t size)
>  {
> +       if (hdr == (HIDP_TRANS_HID_CONTROL | HIDP_CTRL_VIRTUAL_CABLE_UNPLUG))
> +               idev->virtual_cable_unplug = true;
> +
>         return hidp_send_message(idev->ctrl_io, hdr, data, size);
>  }
>
> @@ -344,6 +356,9 @@ static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data
>         /* Enter the auto-reconnect mode if needed */
>         input_device_enter_reconnect_mode(idev);
>
> +       if (!idev->ctrl_io && idev->virtual_cable_unplug)
> +               virtual_cable_unplug(idev);
> +
>         return FALSE;
>  }
>
> @@ -408,7 +423,7 @@ static void hidp_recv_ctrl_hid_control(struct input_device *idev, uint8_t param)
>         DBG("");
>
>         if (param == HIDP_CTRL_VIRTUAL_CABLE_UNPLUG)
> -               connection_disconnect(idev, 0);
> +               connection_disconnect(idev, (1 << HIDP_VIRTUAL_CABLE_UNPLUG));
>  }
>
>  static void hidp_recv_ctrl_data(struct input_device *idev, uint8_t param,
> @@ -532,6 +547,9 @@ static gboolean ctrl_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data
>         if (idev->intr_io && !(cond & G_IO_NVAL))
>                 g_io_channel_shutdown(idev->intr_io, TRUE, NULL);
>
> +       if (!idev->intr_io && idev->virtual_cable_unplug)
> +               virtual_cable_unplug(idev);
> +
>         return FALSE;
>  }
>
> @@ -1042,6 +1060,9 @@ static int connection_disconnect(struct input_device *idev, uint32_t flags)
>                 shutdown(sock, SHUT_WR);
>         }
>
> +       if (flags & (1 << HIDP_VIRTUAL_CABLE_UNPLUG))
> +               idev->virtual_cable_unplug = true;
> +
>         if (idev->uhid)
>                 return 0;
>         else
> --
> 2.27.0.212.ge8ba1cc988-goog
>
