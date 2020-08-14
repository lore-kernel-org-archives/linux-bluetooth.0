Return-Path: <SRS0=Aqt4=BY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68731C433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 18:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33D312078D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 18:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uXnhT0ec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgHNS7g (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Aug 2020 14:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgHNS7g (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Aug 2020 14:59:36 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF4AC061385
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2020 11:59:35 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id x24so8398984otp.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2020 11:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f9NmrfjmloOjIBZHPMZM+Y6w3bDNQCvO94f8urAGQjQ=;
        b=uXnhT0ecVqTx4Xo/qctxxvCCVaxdpI1vvezlZ9ZDnlUqFZy5fkr1vWrVM06WGL1Iz0
         EDXUTEe7jkeUthaYw5uhDZdQd2gwwhdr4BLz30VF5SHdOZDN9knAP9NkH322/RNATqBM
         gjI7tTwZM0ZiN1OyNDOx9bPq4I7V+m//+vIy73Ak5Pn6uk9Zr3VYZESE5mCfbku96tT1
         DKpomGSbSCKVVlO60JfBqtZKapGbbM49opT7qY1h6lk87oK5pveCI34qRxZjaoUiD9TX
         oRhPQsL7SZ/pPuldAdBmneVepXI873Wy+ssuq1bRv3eAAe4R9Rd5S7Q0nKmnElFSvoki
         I90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f9NmrfjmloOjIBZHPMZM+Y6w3bDNQCvO94f8urAGQjQ=;
        b=IRpzOAN5EAGHjJ1ITs8tpfnnkPY25A4BXHCPqglvjPbckp54SadwZPqXapfQbFC+vt
         UesdFobMKtGqnPgn0NW93tkJK+1OmbgOMyKc+Cc3iLUFnlf+qgdUcpJNL2botflIEOct
         6plDw2ClYQGVQ+x5tXqU7vmvk+VBaR2cC5jcwT6Lj2CckSCK2vU6LG8BNr9yK4lsdexU
         JUdXrG3rFsCbDJNnZc7dVi3gyWVtRFXFsML4opEaOBjGFmMOB1MJ3Ej9RVyUCyksoe3q
         kOVkk1gfx19lacwJfSoETEysvHb5Lzyfpr7XFXFduJHT7v2YmBm/dhgvuxfIXzNxrUX8
         DxWw==
X-Gm-Message-State: AOAM531neVGwOj8N2yWSYOq2A6qXT+p7ubMUWIAuOeHQp+tAtfLE9kGu
        OLzPl/+Dqlj+Qa2tYhsFYn8ddiZlRK3HBK2djQ8=
X-Google-Smtp-Source: ABdhPJxuaxXn66br6UualO06iWGRChAzWOopn0ZjnMHf+rtJSiFLvDidoIMrx4qNYcCuqsbxkBlhvDm/eWtd+HQTCFk=
X-Received: by 2002:a9d:24e7:: with SMTP id z94mr2915575ota.91.1597431575159;
 Fri, 14 Aug 2020 11:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200812121946.Bluez.v1.1.I254123a1c85e8cb22739cbbb1ffa2f56ac41faa8@changeid>
In-Reply-To: <20200812121946.Bluez.v1.1.I254123a1c85e8cb22739cbbb1ffa2f56ac41faa8@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 14 Aug 2020 11:59:25 -0700
Message-ID: <CABBYNZKUDn-gWfkZzH4kO5c6kRNMomH9-o8XHJ_Lv+7ujrMNrw@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] input: Don't browse SDP if HIDSDPDisable is set
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

On Tue, Aug 11, 2020 at 9:21 PM Archie Pusaka <apusaka@google.com> wrote:
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
>  profiles/input/device.c | 2 ++
>  src/device.c            | 8 +++++++-
>  src/device.h            | 1 +
>  3 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/profiles/input/device.c b/profiles/input/device.c
> index 6ec0a4c63..fac8c6896 100644
> --- a/profiles/input/device.c
> +++ b/profiles/input/device.c
> @@ -1373,6 +1373,8 @@ static struct input_device *input_device_new(struct btd_service *service)
>         /* Initialize device properties */
>         extract_hid_props(idev, rec);
>
> +       device_set_skip_passive_sdp_discovery(device, idev->disable_sdp);

Shouldn't you actually be checking for the presence of HIDSDPDisable,
I suppose the first time when you pair with it the SDP must be active
in order for us to be able to probe the drivers, then once we get the
SDP records stored we should inhibit the refresh of the records.

>         return idev;
>  }
>
> diff --git a/src/device.c b/src/device.c
> index 2237a7670..a67787a2d 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -195,6 +195,7 @@ struct btd_device {
>         bool            le;
>         bool            pending_paired;         /* "Paired" waiting for SDP */
>         bool            svc_refreshed;
> +       bool            skip_passive_sdp_discovery;
>
>         /* Manage whether this device can wake the system from suspend.
>          * - wake_support: Requires a profile that supports wake (i.e. HID)
> @@ -1472,6 +1473,10 @@ static gboolean dev_property_wake_allowed_exist(
>         return device_get_wake_support(device);
>  }
>
> +void device_set_skip_passive_sdp_discovery(struct btd_device *dev, bool skip)
> +{
> +       dev->skip_passive_sdp_discovery = skip;
> +}
>
>  static gboolean disconnect_all(gpointer user_data)
>  {
> @@ -1805,7 +1810,8 @@ done:
>                                 btd_error_failed(dev->connect, strerror(-err)));
>         } else {
>                 /* Start passive SDP discovery to update known services */
> -               if (dev->bredr && !dev->svc_refreshed)
> +               if (dev->bredr && !dev->svc_refreshed &&
> +                                       !dev->skip_passive_sdp_discovery)
>                         device_browse_sdp(dev, NULL);
>                 g_dbus_send_reply(dbus_conn, dev->connect, DBUS_TYPE_INVALID);
>         }
> diff --git a/src/device.h b/src/device.h
> index cb8d884e8..5348d2652 100644
> --- a/src/device.h
> +++ b/src/device.h
> @@ -145,6 +145,7 @@ void device_set_wake_override(struct btd_device *device, bool wake_override);
>  void device_set_wake_allowed(struct btd_device *device, bool wake_allowed,
>                              guint32 id);
>  void device_set_wake_allowed_complete(struct btd_device *device);
> +void device_set_skip_passive_sdp_discovery(struct btd_device *dev, bool skip);
>
>  typedef void (*disconnect_watch) (struct btd_device *device, gboolean removal,
>                                         void *user_data);
> --
> 2.28.0.236.gb10cc79966-goog
>


-- 
Luiz Augusto von Dentz
