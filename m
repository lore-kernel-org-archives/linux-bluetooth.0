Return-Path: <SRS0=JgXz=ZG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011F4C432C3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Nov 2019 17:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE84D206F4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Nov 2019 17:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iMlPJ+NJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfKNR3r (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Nov 2019 12:29:47 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:34037 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbfKNR3q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Nov 2019 12:29:46 -0500
Received: by mail-io1-f66.google.com with SMTP id q83so7760869iod.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2019 09:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RftPJC/z3aKe9Z2EQoJhnzZgJpMcylstQtfS6pNT5zM=;
        b=iMlPJ+NJiZRBpDqEg1HSfcU3t5/w56CFqZq6rf17WXZtLre8hZjCjdf2fMoa0PRE9R
         /RbNAy4ORogOiWqA8tDWCzhZo1WcPdQi5GyBEhjRPBqylco9vrfdCSM0R0mvB4WpUKZQ
         EK8xlGCBJpsP+VtQqf6/0uzWYpwacWeZji/VM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RftPJC/z3aKe9Z2EQoJhnzZgJpMcylstQtfS6pNT5zM=;
        b=Lw8+lIE2kp4wzysV/eAK7+lCpYp4T7nD5umBALuBDd6hmiTldL51+ug8dJLcTfVl+D
         +Jky34KxtIjiGpWNJTAm/o0reO7kWaTyiVGupRnAr1HY1uM1iGukHVQzSqrAmmwk1PHm
         ijLZilH2sz7gcDqwDaA3z6Pcqo7mAEkE0+3rARjieADF4pFVOzGITwyoqS9pZyblz+c8
         GzVHDfIMZNBpNqyaQoR9bQ7xbslHTCrY10nIIC6i1nZL4PvTPXuTEo6nF++r+V7lw21a
         nmCFrRdgJw+HUwu2S5q4AaDpY/Wg2AfuOA1cXfSSvLgVYLbhGEh++K0FqP8tqLvBs3Fm
         JJTA==
X-Gm-Message-State: APjAAAVvvGtJx9oADbL2mAC1KmohhjMZCRST02QWwZsP76fety+pjXuz
        x99GBOEKwlHZgSVA8V9lSHUZo//1PVc=
X-Google-Smtp-Source: APXvYqzDG2Z2T6KNhcEwDHOceTSSl87v7/XaD3ZCsE1V6Z818B2qCfBFxfieigiGeKBNv3EOddxleA==
X-Received: by 2002:a6b:f117:: with SMTP id e23mr10379407iog.286.1573752585195;
        Thu, 14 Nov 2019 09:29:45 -0800 (PST)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id c16sm626293ioh.57.2019.11.14.09.29.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2019 09:29:44 -0800 (PST)
Received: by mail-io1-f53.google.com with SMTP id j13so7749465ioe.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2019 09:29:44 -0800 (PST)
X-Received: by 2002:a02:a813:: with SMTP id f19mr8324725jaj.12.1573752583817;
 Thu, 14 Nov 2019 09:29:43 -0800 (PST)
MIME-Version: 1.0
References: <20191112230944.48716-1-abhishekpandit@chromium.org> <20191112230944.48716-5-abhishekpandit@chromium.org>
In-Reply-To: <20191112230944.48716-5-abhishekpandit@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 14 Nov 2019 09:29:29 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UfGDAtePrDmsEsdCNsHQZwDkU8z6E=qzSu=opht7evpQ@mail.gmail.com>
Message-ID: <CAD=FV=UfGDAtePrDmsEsdCNsHQZwDkU8z6E=qzSu=opht7evpQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] dt-bindings: net: broadcom-bluetooth: Add pcm config
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-bluetooth@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ondrej Jirman <megous@megous.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, Nov 12, 2019 at 3:10 PM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> Add documentation for pcm parameters.
>
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
>
> ---
>
> Changes in v4:
> - Fix incorrect function name in hci_bcm
>
> Changes in v3:
> - Change disallow baudrate setting to return -EBUSY if called before
>   ready. bcm_proto is no longer modified and is back to being const.
> - Changed btbcm_set_pcm_params to btbcm_set_pcm_int_params
> - Changed brcm,sco-routing to brcm,bt-sco-routing
>
> Changes in v2:
> - Use match data to disallow baudrate setting
> - Parse pcm parameters by name instead of as a byte string
> - Fix prefix for dt-bindings commit
>
>  .../devicetree/bindings/net/broadcom-bluetooth.txt    | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> index c749dc297624..42fb2fa8143d 100644
> --- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> +++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> @@ -29,6 +29,11 @@ Optional properties:
>     - "lpo": external low power 32.768 kHz clock
>   - vbat-supply: phandle to regulator supply for VBAT
>   - vddio-supply: phandle to regulator supply for VDDIO
> + - brcm,bt-sco-routing: 0-3 (PCM, Transport, Codec, I2S)
> + - brcm,pcm-interface-rate: 0-4 (128KBps, 256KBps, 512KBps, 1024KBps, 2048KBps)
> + - brcm,pcm-frame-type: 0-1 (short, long)
> + - brcm,pcm-sync-mode: 0-1 (slave, master)
> + - brcm,pcm-clock-mode: 0-1 (slave, master)

Since these are optional your patch should describe what happens if
they are not present.  I think in patch #3 of the series you guys are
discussing it, but whatever you end up with should be documented here.

That actually made me realize that this is patch #4 in the series.  To
be pedantic, bindings are supposed to be _earlier_ in the series than
the code that implements them.


>  Example:
> @@ -40,5 +45,11 @@ Example:
>         bluetooth {
>                 compatible = "brcm,bcm43438-bt";
>                 max-speed = <921600>;
> +
> +               brcm,bt-sco-routing = [01];
> +               brcm,pcm-interface-rate = [02];
> +               brcm,pcm-frame-type = [00];
> +               brcm,pcm-sync-mode = [01];
> +               brcm,pcm-clock-mode = [01];

I'm at least marginally curious why your example has a leading 0 for
all numbers.  It makes me think you intend them to be represented in
octal, though I don't know offhand if dtc uses that format for octal.
I guess it doesn't matter since all your numbers are between 0 and 5,
but it does seem strange.

-Doug
