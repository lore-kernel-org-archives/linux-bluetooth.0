Return-Path: <SRS0=kmT4=B7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AEFC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 17:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85DEC20714
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 17:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vC4TYeMF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgHURgg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgHURge (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Aug 2020 13:36:34 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C72C061573
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 10:36:34 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id r6so506741oon.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 10:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6dfREwcPDaFqu0NxJIiuzEAM2Q82qJx7DHgfCuuYP78=;
        b=vC4TYeMFO2ageMrazWQEfEs2z5+LjGRd3G6lKGSxGhsetPSRNiXc/RgTfVpp6/ntyr
         Dqm9dKU65Wu7JNQQBilu2TEBKo2e9G4g1TbhV05erLnV2PeSeoTxr8F8C7z3d7nOL/y9
         ij50xKiIOkdIau0FXlPvR7/lFtuSq+uDQmpT/XOJdPhIFtOxPakfYd49/vayTtVp/7Nq
         TCq+kB3NSt0OxMbLVTx1PMx50jh6zvTR6PCXQYXXDVMvTQCSXh5R+OG+yqPCjjEKDWA1
         qMyyvd8HDJxQZXw20cmGbfZH5zEHcRH7G2zh4eh+b3C4vXw25hNtEbHvqAPMxeEgx9j9
         cscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6dfREwcPDaFqu0NxJIiuzEAM2Q82qJx7DHgfCuuYP78=;
        b=nIcD03P8PBcz7y4eC6BRsnObllTDLNMxUrBLbaUcmIre7aCvWmQctfBh67QatpuncZ
         hOpPn973FHCU13GkvykGnZJ6rROQ+OzJ/S1prNMz4MP2J6TCH8oy5ZnyW4DRquB3+hPH
         4XQVndo2/joptLMzDizw4EwO+lbUbCvvN/FnIrpWCZ40QvZF13PdRxSrcWh8lXU5Y4IK
         sZ9RDC+QaXJHja1av3NApq47BV+PSWDJKcmX2ioXwoMvF12IQQOjk6d7fOUtnNSFMQLf
         UbuCc6iQVa3FHUUby3Ba8a2BEYtNG4RhdYXLzk0WByItuuwv9rSdRSrA78QjuXuwqWLW
         dMCg==
X-Gm-Message-State: AOAM530O2FH4E7A16J038sORjcghr8Qlc8tmg3t27G7k0krclXVmBrQ8
        iGylZUWTlz0hgWX/fkeQcQ7ttmGD4S6EqKt9SRE=
X-Google-Smtp-Source: ABdhPJzY78KkyaeEuzb2fWcW7H51lI4SS5VazAr0XBdUqIuxBdtyrPcg0V/QIQprsG1x74XzIpd/HDHt8wzH57wNS6s=
X-Received: by 2002:a4a:380b:: with SMTP id c11mr2902526ooa.17.1598031393680;
 Fri, 21 Aug 2020 10:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200821074512.19985-1-sonnysasaka@chromium.org>
In-Reply-To: <20200821074512.19985-1-sonnysasaka@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 21 Aug 2020 10:36:23 -0700
Message-ID: <CABBYNZJp2cCqRFa2zrdLnva0UgxvG2eBhYyKr52Rx54sU=znSA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] device: Fix race condition between device
 connection and disconnection
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Fri, Aug 21, 2020 at 12:47 AM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> When Connect() is called and waiting for return, dev_disconnected may be
> called due to MGMT_EV_DEVICE_DISCONNECTED event from kernel. In that
> case reply to client that the connection failed otherwise the dbus
> method will timeout because bluetoothd never replies.
>
> Tested with simulation of a lot of Connect() to bluetooth devices and
> check that error is returned from bluetoothd rather than dbus timeout
> when this race condition happens.
>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
>
> ---
>  src/device.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/src/device.c b/src/device.c
> index 7b7808405..55e7b4042 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -3006,6 +3006,7 @@ void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type)
>  void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
>  {
>         struct bearer_state *state = get_state(device, bdaddr_type);
> +       DBusMessage *reply;
>
>         if (!state->connected)
>                 return;
> @@ -3020,6 +3021,17 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
>                 device->disconn_timer = 0;
>         }
>
> +       // This could be executed while the client is waiting for Connect() but
> +       // att_connect_cb has not been invoked.
> +       // In that case reply the client that the connection failed.

Please use C style comment /* */

> +       if (device->connect) {
> +               DBG("connection removed while Connect() is waiting reply");
> +               reply = btd_error_failed(device->connect, "Disconnected early");
> +               g_dbus_send_message(dbus_conn, reply);
> +               dbus_message_unref(device->connect);
> +               device->connect = NULL;
> +       }
> +
>         while (device->disconnects) {
>                 DBusMessage *msg = device->disconnects->data;
>
> --
> 2.26.2
>

Otherwise it looks good.

-- 
Luiz Augusto von Dentz
