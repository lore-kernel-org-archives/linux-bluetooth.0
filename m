Return-Path: <SRS0=kmT4=B7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948E4C433E3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 17:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 756E320748
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 17:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pDaGmxfO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgHURWe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbgHURWa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Aug 2020 13:22:30 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F16AC061573
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 10:22:29 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id x1so503254oox.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 10:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BnMS2o5L8BK4kKFKX33LOfETEbgs7A+ySsqSj/uBlAA=;
        b=pDaGmxfOCfEpdi8+54n5D2wf2kxnFfd9eNxwc9BDw4Iuir0mC0n5Z1AS39VmW9+Gs1
         IEDvYAtXQbR56X03pr4boDSaVL4AYUN5PA/WAMWE9pTO08rs6qgoJF+1cMxCEKopSICh
         IIK6w3XyFerWbmA79An4cGYHhuWWuqHwPevG6iEVKk4wVmrTeU8bA3IXwkr2iAdrgoVI
         KyiHeLCuc7mbAkD4RRL8Zq+0uYJsrVC1vbouZY5LTg4OqyGs8fiO8wsI/yEd3oNXIxcE
         AtJ6L3NW87ECMhrDLBSdPRUUVB9HvBiRjcTS+xaB44yLeg+khw1MRTWgWabOJEeFwdAQ
         duLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BnMS2o5L8BK4kKFKX33LOfETEbgs7A+ySsqSj/uBlAA=;
        b=D6rtBu/LJSif/hyntoTIQRSvto8DGNi+Ivy/7rwiILUE+j7LDIX7klMHZ6+hqR6Gb1
         7IqPVhLBeEWvbtSM79d0IxXPWgPyzfpJiu4DZRY3p45kI1qLuDenYYTUaekXAPFo42vh
         cWklKnaFjnpyhLQp2rfNfcBexJn275a1TBUCn/9L1YL4wcU/heZFPwD07mhTplyG8EI6
         YfUdgh8ktFTNkvh3CFrEXk7ezIGqrBz6gwpHro6ZvWFJGKTt+9ikHBaFn8UNvi1+gG2Q
         8gp3JTmkuVIJmBROzikVz53es43BnOOeFjRk5En71pw9o8V/168dhi3+RxP17JC99WDk
         AnkQ==
X-Gm-Message-State: AOAM5306wqd0qpmMuY0Cjo8pDGHNLb8Fko2m9nyOCstzuTXrCv5KX63z
        2/MKgYy+bRIQAvi1WjLUrMdxWLgZWtxL0fM/CFI=
X-Google-Smtp-Source: ABdhPJwLQEy7nXQr6HRV+e1iqWbdoUMrdq2D0BeCN+XcCfNkpUQgxcfUkZFbZlCJQVgFrRr4mkQtJbBAc3FfUUZ09xU=
X-Received: by 2002:a4a:e88c:: with SMTP id g12mr2847650ooe.49.1598030548520;
 Fri, 21 Aug 2020 10:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200821064927.17578-1-sonnysasaka@chromium.org>
In-Reply-To: <20200821064927.17578-1-sonnysasaka@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 21 Aug 2020 10:22:18 -0700
Message-ID: <CABBYNZKW19qDviuBM-6MdnWnvR2+JO+nZOEpSFo7tVJo80v20w@mail.gmail.com>
Subject: Re: [PATCH BlueZ] adapter: remove eir_data.flags in device_update_last_seen()
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Joseph Hwang <josephsih@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Thu, Aug 20, 2020 at 11:52 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> From: Joseph Hwang <josephsih@chromium.org>
>
> Bluez has difficulty in pairing with Apple Airpods. This issue is
> caused by the incorrect selection of BD address type due to two factors:
>
> (1) The LE advertising reports emitted by Airpods do not carry eir
>     data flags.
> (2) If the eir data flags is missing, the found device would not be
>     considered as coming with bredr address for some historical
>     obsolete reason.
>
> This patch fixes (2) above.
>
> Tested on Chrome OS by pairing with Airpods.
> Without this patch, the pairing success rate is about 20%.
> With this patch, the pairing success rate becomes almost 100%.
>
> ---
>  src/adapter.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 5e896a9f0..36bbed2dd 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -6628,14 +6628,8 @@ static void update_found_devices(struct btd_adapter *adapter,
>
>         device_update_last_seen(dev, bdaddr_type);
>
> -       /*
> -        * FIXME: We need to check for non-zero flags first because
> -        * older kernels send separate adv_ind and scan_rsp. Newer
> -        * kernels send them merged, so once we know which mgmt version
> -        * supports this we can make the non-zero check conditional.
> -        */
> -       if (bdaddr_type != BDADDR_BREDR && eir_data.flags &&
> -                                       !(eir_data.flags & EIR_BREDR_UNSUP)) {
> +       if (bdaddr_type != BDADDR_BREDR &&
> +                       !(eir_data.flags & EIR_BREDR_UNSUP)) {
>                 device_set_bredr_support(dev);
>                 /* Update last seen for BR/EDR in case its flag is set */
>                 device_update_last_seen(dev, BDADDR_BREDR);
> --
> 2.26.2

While I'm fine with this change we might need to bump the kernel
version in order to remove the FIXME, also afaik
beacons/broadcaster/non-connectable advertisement will never have any
flags set so we need to make sure that doesn't end up updating the
last seen for BREDR, though if that is how the Airpods are advertising
then we will need to rethink how we handle the last seen logic to
select which bearer should be connected first. If the Airpods are also
responding to inquiry then we can probably check if BR/EDR has been
marked as supported when the device uses a broadcast advertisement and
not just mark it right away.

-- 
Luiz Augusto von Dentz
