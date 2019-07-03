Return-Path: <SRS0=/JiD=VA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FDCC5B578
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 07:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DEA22187F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 07:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="il90hIxr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfGCHQa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jul 2019 03:16:30 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34599 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfGCHQa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jul 2019 03:16:30 -0400
Received: by mail-io1-f66.google.com with SMTP id k8so2434142iot.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2019 00:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VYk1mTpxOcxV9rsqnHZcildiyIj9DSxFTTmwzh/7YFg=;
        b=il90hIxrz/XtDmxxchp/HnMvb/7w6nqNCnbj7LpZqvY4HlOQdaDgHuS8kltpGQ//72
         ACQYh5h00/uJhHhrU0sFJ12rgLpCfpihSmbzRclEsYDEOptNdocdM1XIOTnm+4Ht3bl9
         DOHjosAZBiKc6zj5V5ZdXrejAEX7Wi32BXeDqhd0zZfbzewc8ASgpZHuBJ+dyFDgb7EP
         OO+d5ZKrEzjY3hvwEOZX52d3CoJAHAxyHXlVl6i1aXq9Bp4JoKyqdn1IAPoJ1VkPFDFs
         +10/RcbjVHPIRkUuukpD9ZQMYU9ckY9C3kyJNH5TMVv+ZpOZGoqBr9Xch9L+VIATy0Ap
         iLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VYk1mTpxOcxV9rsqnHZcildiyIj9DSxFTTmwzh/7YFg=;
        b=FgS5FKb+WrKbov5tJf7NsLFLRjJkLEZrz7uxivs5a/pAg8x7hwfRVyWa54NdFTGMQm
         ReNI742gKGWoCTtgPfN2Qg9OHO/T6ssZXjc8MtvWpC5eOD6aHeN09zaPPvRZbvj9IoTS
         1ePVH5+Hbf2ZlzU+CudJYuC1eAYnODApn2apBkmy655NUemfAlsmMrsrrDp4mwVJXkB4
         usDQMgLW6LQ5jeLNYjMNis8cK+jr2JMm2gmBv4ClQKUC1Oe/KRcopxL5ZbhroLdN0v3e
         GrASC3rNDToHFy1gC28vi4spaLhnboXnE0bpwQCr82jFJrbaSyC77VGEAZRZPbq0Gapr
         I1hg==
X-Gm-Message-State: APjAAAV/OhD0WAAYoNwFYN8Sf8xXRuqJViLqIaTlyg9HOr4zq+6/Q6Lf
        V6x9uL0gQiwv7zRyk3VgIbkma5lNnEyZ23KZQZg=
X-Google-Smtp-Source: APXvYqzoFmzZf++VkAJNrKBKApI3xCPp3CVA+d+51huvpV8YlCnZom0S9K13TZOHy6Tg8yrhVqd5TLB25cHPz5+qKZM=
X-Received: by 2002:a02:b68f:: with SMTP id i15mr40331527jam.107.1562138188656;
 Wed, 03 Jul 2019 00:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190630221408.8509-1-pbrobinson@gmail.com> <D78E9769-8AFA-4BA1-AF16-CE4E4F08B14A@linaro.org>
In-Reply-To: <D78E9769-8AFA-4BA1-AF16-CE4E4F08B14A@linaro.org>
From:   Peter Robinson <pbrobinson@gmail.com>
Date:   Wed, 3 Jul 2019 08:16:16 +0100
Message-ID: <CALeDE9MX5wY9OPjwQ3BqL+CYTJWRqnwJPv2GY7ecShKc1B=yDg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btsdio: Do not bind to non-removable BCM4356
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Jul 3, 2019 at 2:45 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Hi Peter,
>
> On 1 July 2019 3:44:08 AM IST, Peter Robinson <pbrobinson@gmail.com> wrote:
> >BCM4356 devices soldered onto the PCB (non-removable) use an UART
> >connection for bluetooth, such as the Rock960, but it also advertise
> >btsdio support as a sdio function.
>
> Sorry, I don't get the point of this patch. What if BCM4356 is used in different configuration on some other platform (using SDIO for Bluetooth but still soldered on the PCB)? I haven't seen any such but just curious what if!

Without if you get duplicated interfaces, the SDIO one of which
doesn't work and causes confusion:

hci1:   Type: Primary  Bus: UART
        BD Address: CC:4B:73:04:2F:1D  ACL MTU: 1021:8  SCO MTU: 64:1
        UP RUNNING
        RX bytes:1749 acl:0 sco:0 events:89 errors:0
        TX bytes:2950 acl:0 sco:0 commands:89 errors:0

hci0:   Type: Primary  Bus: SDIO
        BD Address: 00:00:00:00:00:00  ACL MTU: 0:0  SCO MTU: 0:0
        DOWN
        RX bytes:0 acl:0 sco:0 events:0 errors:0
        TX bytes:0 acl:0 sco:0 commands:0 errors:0

It was the same work around/fix that was used for a number of other
devices, see commits b4cdaba27424 and 70ecdd3d8b36.

Peter

> Thanks,
> Mani
> >
> >Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> >CC: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >---
> > drivers/bluetooth/btsdio.c | 1 +
> > 1 file changed, 1 insertion(+)
> >
> >diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
> >index 83748b7b2033..fd9571d5fdac 100644
> >--- a/drivers/bluetooth/btsdio.c
> >+++ b/drivers/bluetooth/btsdio.c
> >@@ -286,6 +286,7 @@ static int btsdio_probe(struct sdio_func *func,
> >               switch (func->device) {
> >               case SDIO_DEVICE_ID_BROADCOM_43341:
> >               case SDIO_DEVICE_ID_BROADCOM_43430:
> >+              case SDIO_DEVICE_ID_BROADCOM_4356:
> >                       return -ENODEV;
> >               }
> >       }
>
> --
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
