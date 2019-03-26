Return-Path: <SRS0=6DA+=R5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C48C43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Mar 2019 18:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A0320823
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Mar 2019 18:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ohkc212Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731467AbfCZSxX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:53:23 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36433 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfCZSxW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Mar 2019 14:53:22 -0400
Received: by mail-lf1-f67.google.com with SMTP id d18so9496320lfn.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Mar 2019 11:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L/3OBAKAOSO/1AIbYk5hXO8vRD4tZbOgI5tqSvL0l7U=;
        b=ohkc212Z0MDOWMPvd2KYwtXD7YLmxpPPxtlSRClo8I8cN3Dca36DbP7x2tVo2J6ZfX
         diU5jBi5juJXNVvFqyL19nSjySh7zbIKt/QhOi0tgstxsHmbMfSaaGQwTWmBTPlk6+FL
         S93E58jVWyHh2p+2MbofNoE5lgtzx6WuSmu2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L/3OBAKAOSO/1AIbYk5hXO8vRD4tZbOgI5tqSvL0l7U=;
        b=pQ8IRWQ/+OM6A2bMbtV7fcI1uG9Yk65fRiGqqpwcMBbSsd8Omn9/tymRmpo0tX6uD/
         dlCEPBM3hud6fUg7WX2xE4Q0BqYYbSZWun89o4pJDqIRmfyMsacfhEyASKGwlZjWWaJk
         pRIRmztHGyWq6wgLojih2NDm5+VpE3NEPH40xF59H80iF3ar2W9amSMEYfK3bMV/wHzt
         A6DCReJC8kndDa4jFb28NI6zqzFOCCIK2lGTpBQeujlluU4ZA0gJScUjQPib5/jkctcw
         lGDWJJhkcAHSHX4AtFXykzKLodZqlonscOS2zJahBVDhCfaeCPcQmz4LmC8KuiAFmF6z
         ESTg==
X-Gm-Message-State: APjAAAUJ7MvIdI6Pi+1Y2+b5UqWM4KKmrofYZgVZR1Vc7XchfNc3fCky
        a3sGRlzmtk0AzdIrsFypl/ODkoOA49k=
X-Google-Smtp-Source: APXvYqzX727vBohs3HmN7Bjw05/8MVCKhyWXvWKC16H2cgoi5xdsuO9hv/qUzqzQKwWpe4P06+Xw/Q==
X-Received: by 2002:a19:4a49:: with SMTP id x70mr522353lfa.11.1553626399126;
        Tue, 26 Mar 2019 11:53:19 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id o17sm3425327ljc.66.2019.03.26.11.53.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 11:53:19 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id g7so9486916lfh.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Mar 2019 11:53:18 -0700 (PDT)
X-Received: by 2002:ac2:598b:: with SMTP id w11mr17028560lfn.139.1553625970009;
 Tue, 26 Mar 2019 11:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190222225345.69084-1-briannorris@chromium.org>
 <C908FF06-43F1-4A5C-B80F-0982315DDB6A@holtmann.org> <CA+ASDXOG43dRtqzZJuA4ixVvfpt-Wd1rUVMMG3QFRnNGOmY5GA@mail.gmail.com>
In-Reply-To: <CA+ASDXOG43dRtqzZJuA4ixVvfpt-Wd1rUVMMG3QFRnNGOmY5GA@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 26 Mar 2019 11:45:57 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMePkQDRfaSwNGnRYyGdsuvfUCXBtDK79o2mP=1hdNQUA@mail.gmail.com>
Message-ID: <CA+ASDXMePkQDRfaSwNGnRYyGdsuvfUCXBtDK79o2mP=1hdNQUA@mail.gmail.com>
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

On Wed, Feb 27, 2019 at 1:34 PM Brian Norris <briannorris@chromium.org> wrote:
> On Tue, Feb 26, 2019 at 11:53 PM Marcel Holtmann <marcel@holtmann.org> wrote:
> > all 3 patches have been applied to bluetooth-next tree.
>
> Thanks! I failed to repeat my comment from v1:
>
> """
> This patch is also required to make this stable, but since it's not
> really tied to the device tree, and it's an existing bug, I sent it
> separately:
>
>   https://lore.kernel.org/patchwork/patch/1044896/
>   Subject: Bluetooth: btusb: request wake pin with NOAUTOEN
> """
>
> Can you take this one too? Otherwise Scarlet will be less stable
> (possible interrupt storm at boot).

Ping? RK3399/Scarlet is currently in bad shape on v5.1-rc2, since it
doesn't have the interrupt storm fix.

I'll ping on that patch directly too.

Brian
