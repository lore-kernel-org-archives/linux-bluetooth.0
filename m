Return-Path: <SRS0=kmT4=B7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBDBC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 17:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C6D220714
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 17:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtLle+O+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgHURdS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgHURdQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Aug 2020 13:33:16 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81F9C061573
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 10:33:15 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id e6so2179118oii.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 10:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wQS2uBDhUd3sZz5wY/MnOMF8c1/iiCazEEEhF1oWRBg=;
        b=VtLle+O+/1zggmOAlP7NhC2a7boxj7Ode0jyk+SXNCH6hMoDPR7dtiS+qsYgXvm6zO
         2w1NgfPi1//FzObN0LsHqcLdgwy0zi/2nqahU7iSCK+31Oa3ca/a5cj/lcm2f2U+Lxqn
         H7g8m250LwRjYbjQJbwhuwg+dKOzHPoq9dzHpH6zvEpNUK6mPSN/KaI+UVEd8wYZB13w
         w+DLzmDjMYKpY0i4cyx7qofBbDPkbEsKieBXoVNgH1QuGUjja9wKGc1ajCGzqKN3wXm3
         rL/a/HaL9//h/aRo+gGZ1BJxNbH5R8eqHxJyMa8G3qeHhVSKK2YXVB0+ZB92FXkc/LQ2
         mzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wQS2uBDhUd3sZz5wY/MnOMF8c1/iiCazEEEhF1oWRBg=;
        b=gmT1fy3WeP9eEmVA9kSWDBIvfUmRJjDPaMKobskdp2GTQ/tGIpzZaoYIShERqOR+X/
         uxB/cUTqsaFVAKb7qUPm2PhEiMun2tPCJ6JgQJyQXgtoq8jq7L5ELvU/vIYAwExCXH8x
         sKJj4HzkuLlOIHD5IK4VbaT1Pkh5IcInocNGbs1OyTAsc55fB7G7K6QgFX/FdXQvO+YO
         86wX+RAoie8XuLIj3+hKPZQAGMLwSkMLWWzR2iGMbyL5JUkLFomnd6WoXDuHuW9i6jfp
         5zVaRgv/mmiqcFlemo150mbnyKHxwq9ul2UiuwuCdiwsuYvc/bp2etoduKAzdoOBI8FC
         WL9A==
X-Gm-Message-State: AOAM532IeEI8JesKiq0iapHv1TYt1yOmobe1/xHTxvak/pIBF5FDHUqh
        5fNLC33DeOKJ2sXtKk9cdnKZCECU3Y1qQebq1ZM=
X-Google-Smtp-Source: ABdhPJwsVb9fYyVBBGOrOSi0tyNQ9vSwd3IifA15JiZhptruVm87sIxHvip2vQoZD3tk9jFMPI8eX45aSUBDRWiKdKo=
X-Received: by 2002:aca:cc50:: with SMTP id c77mr2353779oig.152.1598031195003;
 Fri, 21 Aug 2020 10:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200821070409.18037-1-sonnysasaka@chromium.org>
In-Reply-To: <20200821070409.18037-1-sonnysasaka@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 21 Aug 2020 10:33:04 -0700
Message-ID: <CABBYNZ+XKyqK6gpxhZ_J43Uto+cSMGJAcgPKNtCLoi+whrAh6A@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gap: Enable the external flag
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Joseph Hwang <josephsih@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Fri, Aug 21, 2020 at 12:08 AM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> From: Joseph Hwang <josephsih@chromium.org>
>
> This patch enables the external flag for gap so that the gap service can
> be exported over D-Bus.
>
> Tested on Chrome OS that this fixes https://crbug.com/722987 so that GAP
> API can be propagated to Android apps.
>
> Test Method 1:
>   - Connect to a peripheral.
>   - Use dbus methods to query the org.bluez.GattService1
>     interface in managed objects.
>   - Confirm that the gap 0x1800 profile was exported like:
>     GattService1 path: /org/bluez/hci0/dev_xx/service0001
>     service_props: dbus.String(u'UUID'):
>         dbus.String(u'00001800-0000-1000-8000-00805f9b34fb'
>
> Test Method 2:
>   - Install BleManager APK attached in C#0 of https://crbug.com/722987
>     to ARC++ in a chromebook.
>   - Launch the application.
>   - Connect to a Dash robot. Confirm that there are 3 services
>     instead of 2.
>
> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
>
> ---
>  profiles/gap/gas.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/profiles/gap/gas.c b/profiles/gap/gas.c
> index dffa31314..abe5341c0 100644
> --- a/profiles/gap/gas.c
> +++ b/profiles/gap/gas.c
> @@ -310,6 +310,7 @@ static int gap_disconnect(struct btd_service *service)
>  static struct btd_profile gap_profile = {
>         .name           = "gap-profile",
>         .remote_uuid    = GAP_UUID,
> +       .external       = true,
>         .device_probe   = gap_probe,
>         .device_remove  = gap_remove,
>         .accept         = gap_accept,
> --
> 2.26.2

I guess you will end up exporting every single service at the end, so
perhaps we should just have an entry to main.conf
(ExportClaimedServices) where the system can define if services
claimed by plugins are allowed to be accessed over D-Bus, and we
should probably add a comment that when doing so it may cause
conflicts between the daemon and applications (especially GAP/GATT
service can be very sensitive).


-- 
Luiz Augusto von Dentz
