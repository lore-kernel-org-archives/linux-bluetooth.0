Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1F7C433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 17:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1496B21D24
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 17:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GObppxl7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgIQRF5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 13:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgIQRFw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 13:05:52 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29CFC06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 10:05:51 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id z26so3245715oih.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 10:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VMLVYDWBjclWEI28bzU/NR4Kp0EA+W5FtgNf/T9DsOg=;
        b=GObppxl7EHVcxkMQH/tGWkHFLMBMj976QXJ7ndlydzrYsFK133i1KUNdtxoHrIPEWu
         azoZtDTfb/r9tN2JbVLFXrWOOBhJ2RXa1Ud9vmm8GE1D/JShQmGpP9mVvdiXCJrCBJIt
         SeJtay1TLvInMktHm2ZxMqrPyV64GJBJcsFf83hDkfjKwdGcYUVC6lh7HpwMRaWCGE/T
         A4Pq+TCZVVM54/4iB/gaYrOIHRjEKoEz3hyc9HkTdDcRZY8IEmNMQY2jJVWL6/D/QbvC
         7djGCpSJgglEbRtspeSk8HrcyKZ4XHsdcGotvaFPCqag6/XtxomnWyfwQ675XJcW/2x3
         b9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VMLVYDWBjclWEI28bzU/NR4Kp0EA+W5FtgNf/T9DsOg=;
        b=a3WvzHpDniDyBQgaqwXSNF9kN6UYbqcbSojLH0HkN/r94ls0xXHV2xB/3qTYrQQwuW
         hQ7BQNfFwAIQxaEox/xaKwTM/jsWsFiNHvMraaZwqAKMw7NhGt20liA7GP524ZQMisiy
         UFWBkegj+Hgn6M64WM7eEiEsjGmxNrKcv/vynl9kb1ZtHibHYZaNQ7Pm3+CCT0NPY2+1
         h50gF2S8yJQUKdaizb+qUDwMrQgNVAQ8HB8fMlZQma05FnGFOjwaP9mSE9jxRh435RC5
         hyI30tHMhboAJZdn6kDhtbCta1FtqxZtql1nlvF/m/iy4FMmmPxlr+GNKtONuxtco15A
         PQLQ==
X-Gm-Message-State: AOAM5308WpoIaqpKicDpSaY1Svql+36b5YF2p5+D7jv71eIWM5S0QFQr
        oSLPQHD63o89JwTRMY4Si532+TF6/DcvEbSEKqw=
X-Google-Smtp-Source: ABdhPJzheNq2MocKsTYsqrMs6tBwmI6+gMwymsa+ynFew2IsLxrlzSl3csuDov7LcHAc3iUEQ6TbIwKLvu8Z2LUhv78=
X-Received: by 2002:aca:1b01:: with SMTP id b1mr7170307oib.137.1600362350939;
 Thu, 17 Sep 2020 10:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200916223453.22537-1-sonnysasaka@chromium.org>
In-Reply-To: <20200916223453.22537-1-sonnysasaka@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 17 Sep 2020 10:05:39 -0700
Message-ID: <CABBYNZ+Vjs0R+Vxhk0V4rbf_kQ7sFdDZtaM0+pjtfN4hz-maxA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] sixaxis: Fix crash caused by return of udev_device_get_property_value
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Wed, Sep 16, 2020 at 3:37 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> From: Miao-chen Chou <mcchou@chromium.org>
>
> This adds a NULL check before calling sscanf().
>
> Reviewed-by: Yoni Shavit <yshavit@chromium.org>
> Reviewed-by: Alain Michaud <alainm@chromium.org>
>
> ---
>  plugins/sixaxis.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
> index 939fed759..996f85dd6 100644
> --- a/plugins/sixaxis.c
> +++ b/plugins/sixaxis.c
> @@ -411,7 +411,7 @@ get_pairing_type_for_device(struct udev_device *udevice, uint16_t *bus,
>
>         hid_id = udev_device_get_property_value(hid_parent, "HID_ID");
>
> -       if (sscanf(hid_id, "%hx:%hx:%hx", bus, &vid, &pid) != 3)
> +       if (!hid_id || sscanf(hid_id, "%hx:%hx:%hx", bus, &vid, &pid) != 3)
>                 return NULL;
>
>         cp = get_pairing(vid, pid);
> --
> 2.26.2

Applied, thanks.

-- 
Luiz Augusto von Dentz
