Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58454C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Sep 2021 20:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DE8060EBB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Sep 2021 20:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbhI0UZT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Sep 2021 16:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236910AbhI0UZQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Sep 2021 16:25:16 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A8FC061575
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Sep 2021 13:23:37 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id n17so19549023vsr.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Sep 2021 13:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=evY07ERc5o3CxaWJROXLfeIqIcphpacLS/0ORBNDVrE=;
        b=BgDDTa+zxOfFFwQ6BqOcniHG24ipj+Dy9Qv7PjDIlWEHWePd9jHvuFQrJlJmCyE/VV
         Skyw6fKCMcAnMmQ0+JzOwaQagjTwL0eV175qeRxFZ3857UTMFplj0hbcelfOkmzqc5pC
         +eVm1Yji+cv0kHVhHFElqrbf9L/sjU5OD5pD3SwM3T4+GifSmPqV1JxkD/RLGhuhjGBl
         OVehAJidwRHfzVOqtnkTSbMMY/8GxaPD1swHv5q9zroVvD9dkkvMgkiIVGKe/W5URvO0
         Q5sR32MkRLKR17Squ0qUb7X9y/T4m5F+hzP/LXVxs50z0eKJ9+te1OKbH9/QbP4EzyoU
         EoEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=evY07ERc5o3CxaWJROXLfeIqIcphpacLS/0ORBNDVrE=;
        b=Sx6inwHu8OsVwEWW9N8OS7Qz2r7eszIDLPWVLq2S6wCSYuj8XVNV8O/dzEj4ApmGiQ
         rlU+S7lVzYBjM8OHupwCpIfUGQ12PEc8ppxcD/VnXlrkhp3/of7+mMjO2rhTGbjAtgu/
         e80C6DLiEOafCmUeWMc5DY5z/728FrxYCmhuq78Fo5STtk9tLWVwPzuJriESgQ+Cx+Wz
         CMzdND4khuRmg60T44YLVTdsq2sblIZwKwcW3JnBOcUzZwFLXWuXLxOPhDrIeHnFQE4U
         8aK61F1BKjuTY1j8y65ecxZ865vZN/0ujq6aACH5YrJFN6t2oUVDGFDZE89RZb0pyhs4
         CcDA==
X-Gm-Message-State: AOAM530vZGMl94qj0ov9HVQZuag0VaGnqEabsZmfvSYGsbBq5+xFzBQF
        BvDBhtZyUgKqKjAMfA9bAsa/qOTFA0w8wBAlJDnPjOqw
X-Google-Smtp-Source: ABdhPJzYtERvCYvx5Pc7Iy2aqsrxgC7cfriiGPxj0JyGOEqjeSw1HOl2lvMVZllMrJfYF973EywYTbhW2R4R7g6fQfU=
X-Received: by 2002:a05:6102:21d0:: with SMTP id r16mr1973687vsg.39.1632774216818;
 Mon, 27 Sep 2021 13:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210927201657.593569-1-mmandlik@google.com> <20210927131456.BlueZ.v1.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
In-Reply-To: <20210927131456.BlueZ.v1.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 27 Sep 2021 13:23:26 -0700
Message-ID: <CABBYNZ+ohoccO4Y1fYR==qMaeYpKS1vVJyCRN6fAKru0n1AEBQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1 1/3] doc: Add Advertisement Monitor Device
 Tracking event
To:     Manish Mandlik <mmandlik@google.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Miao-chen Chou <mcchou@google.com>,
        Yun-Hao Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Manish,

On Mon, Sep 27, 2021 at 1:17 PM Manish Mandlik <mmandlik@google.com> wrote:
>
> This patch adds the Advertisement Monitor Device Traching event. This
> event indicates that the controller has stated/stopped tracking a
> particular device matching one of the already added Advertisement
> Monitor.
>
> Reviewed-by: Miao-chen Chou <mcchou@google.com>
> Reviewed-by: Yun-Hao Chung <howardchung@google.com>
> ---
>
>  doc/mgmt-api.txt | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 5355fedb0..06df3e914 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -107,7 +107,8 @@ Configuration command, Default Runtime Configuration Changed event, Get
>  Device Flags command, Set Device Flags command, Device Flags Changed event,
>  Read Advertisement Monitor Features command, Add Advertisement Patterns
>  Monitor command, Remove Advertisement Monitor command, Advertisement Monitor
> -Added event and Advertisement Monitor Removed event.
> +Added event, Advertisement Monitor Removed event and Advertisement Monitor
> +Device Tracking event.
>
>
>  Example
> @@ -4910,3 +4911,27 @@ Controller Resume Event
>         Address_Type. Otherwise, Address and Address_Type will both be zero.
>
>         This event will be sent to all management sockets.
> +
> +
> +Advertisement Monitor Device Tracking Event
> +===========================================
> +
> +       Event code:             0x002f
> +       Controller Index:       <controller_id>
> +       Event Parameters:       Monitor_Handle (2 octets)
> +                               Monitor_State (1 octet)
> +                               Address (6 octets)
> +                               Address_Type (1 octet)
> +
> +       This event indicates that the controller has started/stopped tracking
> +       a particular device matching the Advertisement Monitor with handle
> +       Monitor_Handle.
> +
> +       Possible values for the Monitor_State parameter:
> +               0       The controller has stopped tracking a device
> +               1       The controller has started tracking a device
> +
> +       The address of the device being tracked will be shared in Address and
> +       Address_Type.
> +
> +       This event will be sent to all management sockets.

I wonder if wouldn't it be better to indicate this over Device Found?
Or the controller will indicate the advertising report in addition to
this event? Btw, I think it is about time we introduce these commands
to the emulator in order to have proper CI tests, without it cannot
become a stable API.

> --
> 2.33.0.685.g46640cef36-goog
>


-- 
Luiz Augusto von Dentz
