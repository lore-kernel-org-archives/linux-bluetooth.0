Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AACC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 18:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4604C206F4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 18:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QO+aX1+q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgFJSSp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 14:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbgFJSSo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 14:18:44 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95162C03E96B
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 11:18:44 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id d67so2948604oig.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 11:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QzQPuQfJHIEzoAn4btZZPcvZ/nMuySwP4NP/Trdew+c=;
        b=QO+aX1+q/A77qDRtmG76w2rvHOtWy9lgN5O2ohhb6N7UoOosp098KpZ/8miEGaONvt
         Q3/zm65ua3Abvt9RmknVlJpfqlkxzwDOq6X9E/Kc9D3Tg0D0VT/TlGXYlCr6rLOG5Nlr
         f0IPljgRulI54IfNPduUQP9UcCOkjF7wVN/xn3ifx5F37hWJmRs+4VlNwp/wAgq4I+L0
         YTmlDOUH6OX0XZXbvVxVxgCJlDXndVkGua3oPLhPkdmhyGs12slDDpDZjrCzc/OX/d8p
         KhYSv7SIeqbw4CF5XwyY3nlH2M57Zzp5B0FdNq9nIi8wmWk2+OQ0t4ZrhV9jekgL9XlJ
         R/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QzQPuQfJHIEzoAn4btZZPcvZ/nMuySwP4NP/Trdew+c=;
        b=aN8vXiWanZGiEPbeOBTlLqROuS7/ROpMxoUvujjitYe5fO4U52dYzxqb7UgRSBUoHJ
         6gwoJoT7pYteDlbuaMQ0lsD9n1CZp8GCCBrGJ7dQeM384qQdzCoTQDIxo1xUilb/+d+i
         tO5t6pBslxIyGTDZvlYMrnZYDcaWY21H/w6Bjk4qf3Kz4CMU0Q2ZK3OQhicwG9WmCaU6
         PkZhpVtpv/sB9K0dYCKDKIftkjBQaAHIiNatOxC2mGRW6F6Pw1kL7eqk/OS1/vXd7SJc
         +fjwAaNOn4IcWqHMfg/rSyZLAg1DoPFymIslCX3fqlGgG5CR1OTSVmPRsG4lyfAvwz0s
         9q3A==
X-Gm-Message-State: AOAM5309EBl4MLlPmnIMvzXJegig78m/i0JsTE0kiLHE+SCZxpEFrp7l
        zEPMik6r1ESRdgaphHS5iiOsrJDhQThhmcRkqOeHlA==
X-Google-Smtp-Source: ABdhPJwgFK9i+FlfClg3TuiVcMzh0cFCO8rFsbKJBtYpJFNrxav6xbjV5pEr809Z17BYOi/b8qjkk1nuSLH0gv76Fxo=
X-Received: by 2002:aca:2b15:: with SMTP id i21mr3643555oik.110.1591813123471;
 Wed, 10 Jun 2020 11:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200610230524.Bluez.v1.1.I1322f6745fa50365c1c88de3e2c50c9c5962c094@changeid>
 <20200610230524.Bluez.v1.2.I16f38fd33617bbbf84d144605861b8391605a761@changeid>
In-Reply-To: <20200610230524.Bluez.v1.2.I16f38fd33617bbbf84d144605861b8391605a761@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 10 Jun 2020 11:18:31 -0700
Message-ID: <CABBYNZL1GzTjTceo1eRTLhTyUK4zDy3JB0Wr_Tf8p+ApPuuBpw@mail.gmail.com>
Subject: Re: [Bluez PATCH v1 2/2] input: Remove bonding info when receiving
 virtual cable unplug
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Wed, Jun 10, 2020 at 8:06 AM Archie Pusaka <apusaka@google.com> wrote:
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
> ---
>
>  profiles/input/device.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/profiles/input/device.c b/profiles/input/device.c
> index d89da2d7c..45d86b6cb 100644
> --- a/profiles/input/device.c
> +++ b/profiles/input/device.c
> @@ -88,6 +88,7 @@ struct input_device {
>         uint8_t                 report_req_pending;
>         guint                   report_req_timer;
>         uint32_t                report_rsp_id;
> +       bool                    unbond_on_disconnect;

Either name it cable_unplug or have a flag with one bit field reserved
to indicate cable unplugged case.

>  };
>
>  static int idle_timeout = 0;
> @@ -148,6 +149,14 @@ static void input_device_free(struct input_device *idev)
>         g_free(idev);
>  }
>
> +static void invalidate_bonding(struct input_device *idev)
> +{
> +       device_remove_bonding(device_get_adapter(idev->device),
> +                               btd_device_get_bdaddr_type(idev->device));
> +
> +       idev->unbond_on_disconnect = false;
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
> +               idev->unbond_on_disconnect = true;
> +
>         return hidp_send_message(idev->ctrl_io, hdr, data, size);
>  }
>
> @@ -342,6 +354,9 @@ static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data
>         /* Enter the auto-reconnect mode if needed */
>         input_device_enter_reconnect_mode(idev);
>
> +       if (!idev->ctrl_io && idev->unbond_on_disconnect)
> +               invalidate_bonding(idev);
> +
>         return FALSE;
>  }
>
> @@ -406,7 +421,7 @@ static void hidp_recv_ctrl_hid_control(struct input_device *idev, uint8_t param)
>         DBG("");
>
>         if (param == HIDP_CTRL_VIRTUAL_CABLE_UNPLUG)
> -               connection_disconnect(idev, 0);
> +               connection_disconnect(idev, (1 << HIDP_VIRTUAL_CABLE_UNPLUG));
>  }
>
>  static void hidp_recv_ctrl_data(struct input_device *idev, uint8_t param,
> @@ -530,6 +545,9 @@ static gboolean ctrl_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data
>         if (idev->intr_io && !(cond & G_IO_NVAL))
>                 g_io_channel_shutdown(idev->intr_io, TRUE, NULL);
>
> +       if (!idev->intr_io && idev->unbond_on_disconnect)
> +               invalidate_bonding(idev);
> +
>         return FALSE;
>  }
>
> @@ -1035,6 +1053,9 @@ static int connection_disconnect(struct input_device *idev, uint32_t flags)
>         if (idev->ctrl_io)
>                 g_io_channel_shutdown(idev->ctrl_io, TRUE, NULL);
>
> +       if (flags & (1 << HIDP_VIRTUAL_CABLE_UNPLUG))
> +               idev->unbond_on_disconnect = true;
> +
>         if (idev->uhid)
>                 return 0;
>         else
> --
> 2.27.0.278.ge193c7cf3a9-goog
>


-- 
Luiz Augusto von Dentz
