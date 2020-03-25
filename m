Return-Path: <SRS0=+pQP=5K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B87C2D0E5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 19:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08402076F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 19:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0IIxEc2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgCYT5x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Mar 2020 15:57:53 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38196 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbgCYT5x (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Mar 2020 15:57:53 -0400
Received: by mail-oi1-f196.google.com with SMTP id w2so3330853oic.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2020 12:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TuGwVlTCx8khSsmqVPtuimBG2AKGyIBdXFi7e91IgQI=;
        b=h0IIxEc2hyytX0cdgXyWdXYfFthooa7EpMV3D8EGEQP2egnVIaWc6zs2zWS2vKyaeP
         0laH8UCmA0KewEAdCWXgtRgqXWTlRWZjI8gNGgqlitTYyFvw1e/qiNe5HX/ipr5BNbnS
         JOUkcjvxp3rk3NsxyWTj6WoUt0WcfjqztIsg1uROH92yiP9JUpRtNt7aWyOs54M4451+
         QVukEp/bUEk4Uzh2KFPXxp/rR7PQB5B8+nNvcvIO9TkC5x0EVB35dZv0cn/pVFz2iuPN
         goBaPpR2UYZlAh2IhoGl/CayfM9lgaaNtaW9w9HVgpYc9Ybj7MzTbYmtl9ol+rN/myGK
         n1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TuGwVlTCx8khSsmqVPtuimBG2AKGyIBdXFi7e91IgQI=;
        b=hqzru7uPoeNrtu7r4tFA/IbBozR+jMKCAQZGE0jwxG295VZW0uuQKWtiDGX2LYwXcX
         DASfGoqPNsrhfpAD+tnNpkMIBrc5iMYqbktVjbGfHiJT10b27B1lJECbmUtAPG+N3deS
         xhZ2CloQyVmcE5a7k7teMBPqSNAaXuo/90q7M7IosgbQiD8OYyfZ2zwbR8ognZhJVw8y
         IKkBsd8kpAy5fi61HksUjPXhUz3vdmyX9ewLlkVYYq1XaOjT+VcP68PclEZXoWz8DAKO
         qMpWD4GhsL34P1YioXmCOAVTlaoyW9pEj4q2JSM4ONc/YX4JR7MJz/HMUxsB+yzDG7AK
         ugoA==
X-Gm-Message-State: ANhLgQ2Nnr/JCB67cBiYI0OSBXR61LVzniqHyHS0a33BndehvgzXQMpg
        STlbP7tnkSbLPn2aeSzk5uydp0OupCrHjqw4fSz33Q==
X-Google-Smtp-Source: ADFU+vtpej8DNr8I5xa1WUXVgFkF9V4WgnYql1vWGBVIx0Lr77xgKxI6liI5HxkFOeCA/kj9JpMxnw7o07GCv6gq/YM=
X-Received: by 2002:aca:b602:: with SMTP id g2mr3649208oif.82.1585166272197;
 Wed, 25 Mar 2020 12:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200320015023.85896-1-abhishekpandit@chromium.org> <20200319185000.BlueZ.v4.1.Idb4f0444e40064a861ee73b098264abd30114aaa@changeid>
In-Reply-To: <20200319185000.BlueZ.v4.1.Idb4f0444e40064a861ee73b098264abd30114aaa@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 25 Mar 2020 12:57:40 -0700
Message-ID: <CABBYNZ+cYGjTqV8j2oGLujwOyZgoS02uB3K37P_Y35Utgxxmwg@mail.gmail.com>
Subject: Re: [BlueZ PATCH v4 1/5] mgmt: Update docs for Add Device
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

On Thu, Mar 19, 2020 at 6:50 PM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> Update the docs for Add Device with information on flags mask and value.
> Add information on the Wakeable flag that can be set to allow the device
> to wake the system from suspend.
> ---
>
> Changes in v4:
> * Newly added support in Add Device for flags
>
> Changes in v3: None
> Changes in v2: None
>
>  doc/mgmt-api.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 27a41f334..e99c23710 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -1997,6 +1997,8 @@ Add Device Command
>         Command Parameters:     Address (6 Octets)
>                                 Address_Type (1 Octet)
>                                 Action (1 Octet)
> +                               Flags Mask (1 Octet)
> +                               Flags Value (1 Octet)
>         Return Parameters:      Address (6 Octets)
>                                 Address_Type (1 Octet)
>
> @@ -2014,6 +2016,9 @@ Add Device Command
>                 1       Allow incoming connection
>                 2       Auto-connect remote device
>
> +       The following flags are supported:
> +               0x1     Wakeable
> +

Hmm I thought we would be adding another action, adding this as a flag
is not backward compatible so the command will probably fail on older
kernels.

>         With the Action 0, when the device is found, a new Device Found
>         event will be sent indicating this device is available. This
>         action is only valid for LE Public and LE Random address types.
> @@ -2036,6 +2041,13 @@ Add Device Command
>         connectable setting is off. This acts as list of known trusted
>         devices.
>
> +       To set flags on the device, first set the bit in the mask for the
> +       flag to set and then set or clear the bit in the value to indicate
> +       whether the flag should be set.
> +
> +       The Wakeable flag controls whether this device can wake the system
> +       from suspend.
> +
>         This command can be used when the controller is not powered and
>         all settings will be programmed once powered.
>
> --
> 2.25.1.696.g5e7596f4ac-goog
>


-- 
Luiz Augusto von Dentz
