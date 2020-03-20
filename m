Return-Path: <SRS0=7F+K=5F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC7EC4332D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 20:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB6E20777
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 20:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XIa7u3f+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgCTUAb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Mar 2020 16:00:31 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37658 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCTUAb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Mar 2020 16:00:31 -0400
Received: by mail-vs1-f65.google.com with SMTP id o3so4805985vsd.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2020 13:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9G97mtWNBX+ElGAqKmEux98igXbnng7EqPDZBWwqrlI=;
        b=XIa7u3f+gYyOZeSn2kuITnCAnmgCdTLRe8GQWf6hV2yDUSrPXqnTvD6WorITlRi7Fy
         s98Rmdc2qbHuAN53Qu1aPOiv+BIfRacxC/vrFhm0a9TQPCBXqol2FmGC2MS+3c61v+HZ
         D66aBIkoaRbAP9wLHIGo6bF43GsNX0giiYLTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9G97mtWNBX+ElGAqKmEux98igXbnng7EqPDZBWwqrlI=;
        b=bY4+l1IvCajHp19+HKT1UI3MgHkUOagu7MqOQ1r4u2VgIVKtuPKVnJSMe/YO77FYuV
         ym50Dkq7pkjTFMQzEEQVhXjogVDEbCxtdUARJ4pujUVbffHkjlwnBZRTjEYNUAO/kyBv
         hajcWP3T/nSD2QJ/HoCmFlViTkJ/MX99g8i8H7ugwk5Z3/tu7QUCfUU+Ki5ie1XIkpUN
         2SCo2193/+725Xw+P/MJkGRVB+5PDOHeW6SpCVs/mWcL7J3cooQYl2GgB6V9xRIL1Gww
         hwlQ4tTSUYDB8DscLmaeDyGDATvE11eP0THi2ZSiyaeyhOywVdis85OSs6PjXp6pkxjm
         aIjQ==
X-Gm-Message-State: ANhLgQ0kSsXdAZA7TadFmNZ2SHFxUEZVPiUdxDxjfnZVlc67RJ2/6mlE
        /ZSKZV2jMuGmoT27i7Yp0PsooROCRGc=
X-Google-Smtp-Source: ADFU+vvdYbl/Hk8vSud7cAMuFAJWIRoaKV2zGl50GLRU5RyK3F128qfxHrmj7RrhF3eV2XrnYT7EqA==
X-Received: by 2002:a67:c31e:: with SMTP id r30mr7867987vsj.197.1584734429855;
        Fri, 20 Mar 2020 13:00:29 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id s17sm3452234vsc.27.2020.03.20.13.00.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2020 13:00:27 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id i7so2716690uap.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2020 13:00:26 -0700 (PDT)
X-Received: by 2002:a9f:2478:: with SMTP id 111mr7131238uaq.0.1584734426059;
 Fri, 20 Mar 2020 13:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200320020153.98280-1-abhishekpandit@chromium.org> <20200319190144.1.I40cc9b3d5de04f0631c931d94757fb0f462b24bd@changeid>
In-Reply-To: <20200319190144.1.I40cc9b3d5de04f0631c931d94757fb0f462b24bd@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 20 Mar 2020 13:00:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XT=NTyPag9wNCotATBzT4v9pg=OOa8X6=xWkMH2AFiLQ@mail.gmail.com>
Message-ID: <CAD=FV=XT=NTyPag9wNCotATBzT4v9pg=OOa8X6=xWkMH2AFiLQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Bluetooth: btmrvl: Detect hangs and force a reset of
 the SDIO card
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Thu, Mar 19, 2020 at 7:02 PM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> From: Matthias Kaehlcke <mka@chromium.org>
>
> When scanning for BLE devices for a longer period (e.g. because a
> BLE device is paired, but not connected) the Marvell 8997 often
> ends up in a borked state, which manifests through failures on
> certain SDIO transactions.
>
> When such a SDIO failure is detected force a reset of the SDIO
> card to initialize it from scratch. Since the SDIO bus is shared
> with the WiFi part of the chip this also involves a reset of WiFi.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
>
>  drivers/bluetooth/btmrvl_sdio.c | 24 ++++++++++++++++++++++++
>  drivers/bluetooth/btmrvl_sdio.h |  1 +
>  2 files changed, 25 insertions(+)
>
> diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
> index 0f3a020703ab..69a8b6b3c11c 100644
> --- a/drivers/bluetooth/btmrvl_sdio.c
> +++ b/drivers/bluetooth/btmrvl_sdio.c
> @@ -22,6 +22,8 @@
>  #include <linux/slab.h>
>  #include <linux/suspend.h>
>
> +#include <linux/mmc/core.h>
> +#include <linux/mmc/card.h>
>  #include <linux/mmc/sdio_ids.h>
>  #include <linux/mmc/sdio_func.h>
>  #include <linux/module.h>
> @@ -59,6 +61,23 @@ static const struct of_device_id btmrvl_sdio_of_match_table[] = {
>         { }
>  };
>
> +static void btmrvl_sdio_card_reset_work(struct work_struct *work)
> +{
> +       struct btmrvl_sdio_card *card =
> +               container_of(work, struct btmrvl_sdio_card, reset_work);
> +       struct sdio_func *func = card->func;
> +
> +       sdio_claim_host(func);
> +       mmc_hw_reset(func->card->host);

The fact that you don't check the return value here seems like a
problem.  See specifically how commit cdb2256f795e ("mwifiex: Re-work
support for SDIO HW reset") handles it.

This is a distinct difference between the solution that we landed in
Chrome OS 4.19 and what landed upstream.  In Chrome OS 4.19 we went
the simple approach and said that there was only one way to reset the
card: treat it as a full unplug / replug of the card.  ...but upstream
adopted a different solution.  For upstream if there is only a single
function on the SD card it will not trigger a full unplug/replug and
it's up to the function driver to re-init itself.  This wasn't such a
big deal for the WiFi driver since it already had a way to re-init
itself (mwifiex_reinit_sw).  I don't know how hard it will be for
Bluetooth, but that needs to be part of this patch I think?

-Doug
