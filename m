Return-Path: <SRS0=vyxk=RC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16724C43381
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Feb 2019 21:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D554F2186A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Feb 2019 21:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j78GG+Lr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730393AbfB0Vem (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Feb 2019 16:34:42 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45228 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730477AbfB0Vek (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Feb 2019 16:34:40 -0500
Received: by mail-ed1-f66.google.com with SMTP id f19so5817679eds.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Feb 2019 13:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=33TM7Cs9TumwVat/O6BjwK7P3AjdXMLeuWOXQzZThW8=;
        b=j78GG+Lrn1m27fhQUz5AsdhDeKRuAcUJsYc2XG5rZ4ek5f1nzqDYYDs09/lGWkxmDR
         DGWCAwlGCU1kU/oArEaeCjpCKANvohSRctwMeKX7NASMiT99ct2TZLPoBFnY78sKeVzK
         UA4X5Ummsm0DWgvmhKg29vBsDo+1uR+a3KCQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=33TM7Cs9TumwVat/O6BjwK7P3AjdXMLeuWOXQzZThW8=;
        b=btueH76z2pXo1oTossIJF56hosf/E8Zhg9AQTvY96htIm+MPgosaOEudFSU31vY+zm
         uOUdfK8flCG1yRO0lpLH42NONZm4cyOkpM+ZkkFxa/jKbMbYIa3vZP+e4iRnEYFR4qGN
         dGZe5q6RK6hpgkhLxOe/8LfUKEY34xHC2I27F2Sd1Z7JQrq9PciK+ByS+5rEDVPIBdUC
         HlDDn0DkAq/yGjWoQZsy6ogyOERT/XxBQPTdz7bH/v3bGcl9FEiW9yUEVRTOkGd1pRjC
         ewBPbOvy22HypSnCARG523TtA52hGdgCZDW1CccI0rv8A9+Xzkz2V/+fA4DtctNOttn1
         XlLA==
X-Gm-Message-State: AHQUAuZHr3gYrWnNbpHDseqFeydkSYwj52HHI1UsFYAvmJyrcmzdIdef
        XtevqNIK4zq6PST7YZ1CPV8y+fv/37M=
X-Google-Smtp-Source: AHgI3IaipRz5/4Lyp36IEcqqaM1aGlBkqs38gZakSzv5gpOasi46Jt0Iz+7wL7B+Z3bZuK8FgE7Vyw==
X-Received: by 2002:a17:906:28c4:: with SMTP id p4mr3019863ejd.63.1551303278225;
        Wed, 27 Feb 2019 13:34:38 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id b29sm4552265eda.48.2019.02.27.13.34.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 13:34:36 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id a16so15238669edn.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Feb 2019 13:34:34 -0800 (PST)
X-Received: by 2002:a50:a3bc:: with SMTP id s57mr4018952edb.4.1551303274387;
 Wed, 27 Feb 2019 13:34:34 -0800 (PST)
MIME-Version: 1.0
References: <20190222225345.69084-1-briannorris@chromium.org> <C908FF06-43F1-4A5C-B80F-0982315DDB6A@holtmann.org>
In-Reply-To: <C908FF06-43F1-4A5C-B80F-0982315DDB6A@holtmann.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 27 Feb 2019 13:34:22 -0800
X-Gmail-Original-Message-ID: <CA+ASDXOG43dRtqzZJuA4ixVvfpt-Wd1rUVMMG3QFRnNGOmY5GA@mail.gmail.com>
Message-ID: <CA+ASDXOG43dRtqzZJuA4ixVvfpt-Wd1rUVMMG3QFRnNGOmY5GA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Bluetooth: btusb: add QCA6174A compatible properties
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Bluetooth mailing list 
        <linux-bluetooth@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Tue, Feb 26, 2019 at 11:53 PM Marcel Holtmann <marcel@holtmann.org> wrote:
> > We may need to specify a GPIO wake pin for this device, so add a
> > compatible property for it.
> >
> > There are at least to USB PID/VID variations of this chip: one with a
> > Lite-On ID and one with an Atheros ID.
> >
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > v2:
> > * drop leading zeroes from VID, per documented binding
> > ---
> > drivers/bluetooth/btusb.c | 2 ++
> > 1 file changed, 2 insertions(+)
>
> all 3 patches have been applied to bluetooth-next tree.

Thanks! I failed to repeat my comment from v1:

"""
This patch is also required to make this stable, but since it's not
really tied to the device tree, and it's an existing bug, I sent it
separately:

  https://lore.kernel.org/patchwork/patch/1044896/
  Subject: Bluetooth: btusb: request wake pin with NOAUTOEN
"""

Can you take this one too? Otherwise Scarlet will be less stable
(possible interrupt storm at boot).

Regards,
Brian
