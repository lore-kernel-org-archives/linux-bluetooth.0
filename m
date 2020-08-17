Return-Path: <SRS0=KHjC=B3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E31DC433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Aug 2020 23:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5023620709
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Aug 2020 23:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJNMagXQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgHQXYZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Aug 2020 19:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgHQXYY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Aug 2020 19:24:24 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7389C061389
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 16:24:24 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id u63so16341979oie.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 16:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YFzSXlNrmd43O0W2NTqrdb9Md3q7gFf2ih/2c/pBQSQ=;
        b=iJNMagXQPpf8hs7lTRX1o+GAj2t/B69PGNfeQQRA+J22OSRAfuqmOQdOLQ6wCTvdYa
         RByU487BY+8UeADkn+3kyRBNtYxxzvO8oeo7T82nMnZ6FPOU9+9zCFDmSn+cJ/HXEwih
         qC2oMcTJkrswg2Pw8HH3GiHiTj0lb6E+qiu6rCYasRRKK8MOEFSViCJ+zX+xdgdf9tFo
         tfeHn3xu4mfVwoGiYX6P9EmuAr+SJAWfk2EDj1DjNqMA1gbvBY/KhccpBSTZPgElSken
         tDNeoNMPpcigiVGc8Rt2lzmsRnoKiKL8rh1vKDuxi36YSz57zeC3Yynxzzp/7Px1i4jd
         +I8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YFzSXlNrmd43O0W2NTqrdb9Md3q7gFf2ih/2c/pBQSQ=;
        b=ibJWm6IbRVz9fiN5/51Fe1Px58fKtcbnQSKj0/kL/K9fFJD6OLXcL3D8bl9L7vI9Mh
         UfnVRSaVPpGVGoMkyB1gaJnrgvG6pZmV1mGuWPB6U2aK6tbsNhdOZKWOyeLXdqBy+meS
         Jz/CiSuI1ZaAREZUETD1XYkNMwgJhXzDT2ylA84+1YZekN3uvjosJClFKR4J6/gOllId
         CZ6HaQTAAQ+v9kz4RC2jt55HsAn8wg21w0L+QgDlzt5lnp2cAFmf3vyOKurdglu8qmhV
         Fae9o0n1UlE0quM90mVo/tEnUf++56/hCfj5kaEc/Y1tMgr/cRCnhpD1gz5L54SIpD3C
         8S7Q==
X-Gm-Message-State: AOAM533dE1YNXH5632uYCs1989gtDQpxHOuhrasGJ5Aq2lq5OfNJL4M6
        2t9Ktfg5hs0PdIl/wzKtngltqIX8ukx10m9inzs=
X-Google-Smtp-Source: ABdhPJyGPpFXuqlXVN796VNfEeHLmWK7nMwA+GAzfczbPwg12QiiGEMmrdeYLbsKViaKe8MNIAjJBoKrUN2PGYtmBQU=
X-Received: by 2002:aca:5703:: with SMTP id l3mr10517426oib.48.1597706663964;
 Mon, 17 Aug 2020 16:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200817135606.Bluez.v2.1.I21d21871d85db48b07ba847742c7cb933024307c@changeid>
In-Reply-To: <20200817135606.Bluez.v2.1.I21d21871d85db48b07ba847742c7cb933024307c@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 17 Aug 2020 16:24:13 -0700
Message-ID: <CABBYNZLfmuLHvvMUwz_-Lg=q5aFYt6S3UEV-SA--ESmRMX4DVQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v2] adapter- Device needs to be in the temporary
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

On Mon, Aug 17, 2020 at 4:04 PM Yu Liu <yudiliu@google.com> wrote:
>
> This caused the device hanging around as a discovered device forever
> even if it is turned off or not in present.
>
> Reviewed-by: sonnysasaka@chromium.org
>
> Signed-off-by: Yu Liu <yudiliu@google.com>
> ---
>
> Changes in v2:
> - Fix title length and format issue
>
> Changes in v1:
> - Initial change
>
>  src/device.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/src/device.c b/src/device.c
> index bb8e07e8f..93e71850c 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -6008,6 +6008,12 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
>
>         if (status) {
>                 device_cancel_authentication(device, TRUE);
> +
> +               // Put the device back to the temporary state so that it will be
> +               // treated as a newly discovered device.

Use C style comments /* */ above.

> +               if (!device_is_paired(device, bdaddr_type))
> +                       btd_device_set_temporary(device, true);

Hmm, are we perhaps removing the temporary flag too early? Or this is
a result of calling Connect which clears the temporary flag? Then
perhaps we should at least if the upper layer has marked the device as
trusted as it should indicate the device object should be kept even if
not paired.

>                 device_bonding_failed(device, status);
>                 return;
>         }
> --
> 2.28.0.220.ged08abb693-goog
>


-- 
Luiz Augusto von Dentz
