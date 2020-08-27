Return-Path: <SRS0=2B3h=CF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B73C433E1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Aug 2020 17:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69B71207CD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Aug 2020 17:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTkJhOEB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgH0RyX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Aug 2020 13:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgH0RyW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Aug 2020 13:54:22 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DB2C061264
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2020 10:54:21 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id 2so5351654ois.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2020 10:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fNCaMAIWNhN8jVlQ/Qo02eEyqA9Pcys7aVb+GnI1f+g=;
        b=lTkJhOEB1ePvUaPkQ7dOxsfO88SK408ZuMv+HKWutFbagiT1R8z5BQnjJasUdV+qHJ
         j1cF/iJFJvBmWgCLtiCMXzVZ7KmMjNP6czv+/N+IlxXGtfnBdvPPU3VivrwInEqbn9Mv
         O/t97RC5gwsJzqfTxZWDlzB0rtsbxoawhAvvsHL3Ni7dkc+L5bOyEU4jJNezEXGnhQn9
         kcUs/S6ucLX9lRNyR2WYvnNdcBCyas4sXVxd48myouMNHyBJD+2yVhykvfUcBIVR8Srn
         bjIU5Do/glut/OLBC3/Ae5ZUw605AxxWvttbDEGeR8ZWg2b31z7rETTOXFyqGEMxa1Fn
         jJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fNCaMAIWNhN8jVlQ/Qo02eEyqA9Pcys7aVb+GnI1f+g=;
        b=B6rjzQHXKeFbXrnydOuCUPXP4wGe0SIabOa2Y2z2csjo2w+eDCMrruPyrdNKgYGF7R
         6jfswh0+NCgUif1cUYQ1Fqftqde87vTnD0LOIrnUErgycifYUB65z6RbpD5NUQTUi+2f
         cAiNno01NV8zrFu4y3QO7xLHg5NSswd736q8DhS0Y5HWNTf5RP9fwaB3QRmX1PCNKBVd
         HXx8/Iaw8XTYhuTPrCnafaHwSYgpTgFxdumyjB9FfNgyRw28h9hb2/UWSLxHlSqqHkNz
         PGZr/Z55dS4NOj5MIrLeTrlaHH3HrK8BqHweenjlqg168ZuGz+hFecPrNxImPJZEHMcC
         oH/w==
X-Gm-Message-State: AOAM530Nn1lGJ1qsz05YS8Cyu2QXwsh9giBciZ2zKLuJ9hqmF2+0jX/G
        GgFyVXsR7yy8W1AC6PB5K3OTEXOGDuFM+CEyhYIB6h8m
X-Google-Smtp-Source: ABdhPJxm1xBHGK6oxfhMizCWMo0DKVce2q54uthG2vQXpWpZoYpq64Xmatui9z1DulKlB1B2AxD5GX8r9rXBK22fc28=
X-Received: by 2002:aca:a9c9:: with SMTP id s192mr31369oie.152.1598550861227;
 Thu, 27 Aug 2020 10:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200824111837.Bluez.v3.1.I21d21871d85db48b07ba847742c7cb933024307c@changeid>
In-Reply-To: <20200824111837.Bluez.v3.1.I21d21871d85db48b07ba847742c7cb933024307c@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 27 Aug 2020 10:54:10 -0700
Message-ID: <CABBYNZ+BrKk_-bgLb1HZGi2Xpiqm+xSgXZfK_w987wfd3oBTMg@mail.gmail.com>
Subject: Re: [Bluez PATCH v3] adapter - Device needs to be in the temporary
 state after pairing failure
To:     Yu Liu <yudiliu@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Yu Liu,

On Mon, Aug 24, 2020 at 11:30 AM Yu Liu <yudiliu@google.com> wrote:
>
> This caused the device hanging around as a discovered device forever
> even if it is turned off or not in present.
>
> Reviewed-by: sonnysasaka@chromium.org
> ---
>
> Changes in v3:
> - Fix comment format
> - Don't set temporary for trusted device
>
> Changes in v2:
> - Fix title length and format issue
>
> Changes in v1:
> - Initial change
>
>  src/device.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/src/device.c b/src/device.c
> index bb8e07e8f..103b5df27 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -6008,6 +6008,14 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
>
>         if (status) {
>                 device_cancel_authentication(device, TRUE);
> +
> +               /* Put the device back to the temporary state so that it will be
> +                * treated as a newly discovered device.
> +                */
> +               if (!device_is_paired(device, bdaddr_type) &&
> +                               !device_is_trusted(device))
> +                       btd_device_set_temporary(device, true);
> +
>                 device_bonding_failed(device, status);
>                 return;
>         }
> --
> 2.28.0.297.g1956fa8f8d-goog

Applied, thanks.

-- 
Luiz Augusto von Dentz
