Return-Path: <SRS0=EW2K=B4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E32AC433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 23:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E1DA20709
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 23:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R33zsjkD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgHRXvo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Aug 2020 19:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgHRXvl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Aug 2020 19:51:41 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A81CC061389
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 16:51:41 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id j16so4526526ooc.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 16:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oDxCTY7BfBW9Pv/dYaiQwuSp8dNOVAO05Nfr5H416ME=;
        b=R33zsjkDwjbxIyT9Qh0CZvO2RfEhuzPt0E6254aDha7sScFIsooC8LSibHXKqESwAW
         k4Ce+abpv7C3FwlwjaWrn3fmraECFSiCuYRTppscIc5T7pSBg7s0POIvt/Nlypv7idl5
         Q01c5rCpkI8mIIynikv73A1dZTsj/PCBhExxIiuLNvHuU1ZKY2glM7NvEzT6lqF84f+4
         OhHcu0CCdyjCQN6qpOqn50pmr6HuHuEby0rks7/whsrjATAfDmR//NkUlNVLD+K0ydLF
         /G4OUq+TQf648ZL83YNbjky/0HpCG75WlGPOR4lQV4tIsQ749YXl0FO7KqfqMN1bx9I3
         oNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oDxCTY7BfBW9Pv/dYaiQwuSp8dNOVAO05Nfr5H416ME=;
        b=nvFADRhUviwYHOjCdnmxn60Tac7/0UGx0+UB/8GdXZ37Z58Lg1WErtSPixR7N5XLWR
         e8xD6BzoI/VyBmDfXSzEeUB4At/SfI6gsrKKmAUYSvTbfCdmCZiX0FGh2jC2ws1Na/G9
         +j86qHxznQmBH8FCsr2imTurRmsa//tbynuhHLZD4zKDEtH0EP+/iBjqEp5WXJ2/yxri
         8170ubO0Jku8sHAKWat8YTQGaaPTxozR/LrO7D4t1afT9Mc2imZayE/D7C4/Z7TRrOxZ
         H85tZpgadyo+u6frkbdP/MiV6fFFMgX2UTDBP699m6LSdLOvA2Ps6Ybevo4YXbT/PNoC
         3Wwg==
X-Gm-Message-State: AOAM533ou2IwAea+WXWwvdiM4Vdboo79a4hXaj1XwskOWAQQKBVtib1K
        4DRljCTOmVtXHfxCT92PJNl4dL8ddO77PDQTFG0=
X-Google-Smtp-Source: ABdhPJxNmKShFCpTA77Cg1JH7HLwjPKVLM5vgGNdqZqjTSkxoH8DaOo7MuRw7ccTwCLiR4+iFVCG6nBU5wVL0P6wGss=
X-Received: by 2002:a4a:380b:: with SMTP id c11mr16684695ooa.17.1597794700230;
 Tue, 18 Aug 2020 16:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200818153257.Bluez.v3.1.I254123a1c85e8cb22739cbbb1ffa2f56ac41faa8@changeid>
In-Reply-To: <20200818153257.Bluez.v3.1.I254123a1c85e8cb22739cbbb1ffa2f56ac41faa8@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 18 Aug 2020 16:51:29 -0700
Message-ID: <CABBYNZJeEB82pDBT4v83T=pnMFyEHxdpoAJ_t-JPSnDTjtGLow@mail.gmail.com>
Subject: Re: [Bluez PATCH v3 1/2] device: Don't browse SDP if HIDSDPDisable is set
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Tue, Aug 18, 2020 at 12:34 AM Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> According to the HID1.1 spec, part 5.3.4.9:
> The HIDSDPDisable attribute is a Boolean value, which indicates
> whether connection to the SDP channel and Control or Interrupt
> channels are mutually exclusive. This feature supports Bluetooth
> HID devices that have minimal resources, and multiplex those
> resources between servicing the initialization (SDP) and runtime
> (Control and Interrupt) channels.
>
> However, Bluez still tries to connect SDP upon HID connection,
> regardless of the existence of the HIDSDPDisable attribute.
>
> This patch prevents the connection of SDP after HID has been
> established, if the device has HIDSDPDisable attribute.
>
> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> ---
>
> Changes in v3: None
> Changes in v2:
> * Renaming passive_sdp_discovery to refresh_discovery
>
>  profiles/input/device.c |  3 +++
>  src/device.c            | 11 +++++++++--
>  src/device.h            |  1 +
>  3 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/profiles/input/device.c b/profiles/input/device.c
> index 6ec0a4c63..5e47b88f2 100644
> --- a/profiles/input/device.c
> +++ b/profiles/input/device.c
> @@ -1373,6 +1373,9 @@ static struct input_device *input_device_new(struct btd_service *service)
>         /* Initialize device properties */
>         extract_hid_props(idev, rec);
>
> +       if (idev->disable_sdp)
> +               device_set_refresh_discovery(device, false);
> +
>         return idev;
>  }
>
> diff --git a/src/device.c b/src/device.c
> index 2237a7670..52dfea18f 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -195,6 +195,7 @@ struct btd_device {
>         bool            le;
>         bool            pending_paired;         /* "Paired" waiting for SDP */
>         bool            svc_refreshed;
> +       bool            refresh_discovery;
>
>         /* Manage whether this device can wake the system from suspend.
>          * - wake_support: Requires a profile that supports wake (i.e. HID)
> @@ -1472,7 +1473,6 @@ static gboolean dev_property_wake_allowed_exist(
>         return device_get_wake_support(device);
>  }
>
> -
>  static gboolean disconnect_all(gpointer user_data)
>  {
>         struct btd_device *device = user_data;
> @@ -1805,7 +1805,7 @@ done:
>                                 btd_error_failed(dev->connect, strerror(-err)));
>         } else {
>                 /* Start passive SDP discovery to update known services */
> -               if (dev->bredr && !dev->svc_refreshed)
> +               if (dev->bredr && !dev->svc_refreshed && dev->refresh_discovery)
>                         device_browse_sdp(dev, NULL);
>                 g_dbus_send_reply(dbus_conn, dev->connect, DBUS_TYPE_INVALID);
>         }
> @@ -2572,6 +2572,11 @@ done:
>                 browse_request_free(req);
>  }
>
> +void device_set_refresh_discovery(struct btd_device *dev, bool refresh)
> +{
> +       dev->refresh_discovery = refresh;
> +}
> +
>  static void device_set_svc_refreshed(struct btd_device *device, bool value)
>  {
>         if (device->svc_refreshed == value)
> @@ -4071,6 +4076,8 @@ static struct btd_device *device_new(struct btd_adapter *adapter,
>         device->db_id = gatt_db_register(device->db, gatt_service_added,
>                                         gatt_service_removed, device, NULL);
>
> +       device->refresh_discovery = true;
> +
>         return btd_device_ref(device);
>  }
>
> diff --git a/src/device.h b/src/device.h
> index cb8d884e8..5ba2d7fe0 100644
> --- a/src/device.h
> +++ b/src/device.h
> @@ -145,6 +145,7 @@ void device_set_wake_override(struct btd_device *device, bool wake_override);
>  void device_set_wake_allowed(struct btd_device *device, bool wake_allowed,
>                              guint32 id);
>  void device_set_wake_allowed_complete(struct btd_device *device);
> +void device_set_refresh_discovery(struct btd_device *dev, bool refresh);
>
>  typedef void (*disconnect_watch) (struct btd_device *device, gboolean removal,
>                                         void *user_data);
> --
> 2.28.0.220.ged08abb693-goog

Applied, thanks.

-- 
Luiz Augusto von Dentz
