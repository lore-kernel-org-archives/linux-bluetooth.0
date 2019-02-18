Return-Path: <SRS0=2sDM=QZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8AEC4360F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Feb 2019 21:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07A521738
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Feb 2019 21:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAV7IaKg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbfBRVYa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Feb 2019 16:24:30 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44316 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729382AbfBRVY3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Feb 2019 16:24:29 -0500
Received: by mail-ot1-f68.google.com with SMTP id g1so30617809otj.11;
        Mon, 18 Feb 2019 13:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=terCZ80LXxA3PBiAEs/Mo83x6p3OLzTXSdBC5o4MSuc=;
        b=mAV7IaKgmHppncLgCyXV0iacWwMeFxBzJuEEkm1Htp2xc2u8nD/zNXSc3U4amdVtHW
         0QDRZpacLpOFWaeox1+99V97K1NrRbxAr66xn7pICzQvhpPVzii3H2TDucFzDDjJQ6dh
         XjgVnCdCBr2fMg8m0pNE3QijIZi/rwlRZqYJLermzMNY5tHX2WQAITb4IweIQ0HHDpaN
         5G5IOegV8R16jxDKe6NoL5mPUKCnE1wS00oy2h/14nmkXEhW0MYL5An/tgklZHaku07s
         nIYeIvktuzLA2Xnz89a0CuhgOxSuatfjZj0EOrf4+zAZfYsFrxMIcpJ6oydWjCEX7gyY
         bveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=terCZ80LXxA3PBiAEs/Mo83x6p3OLzTXSdBC5o4MSuc=;
        b=e6J4/n8UafiX1PGMrEIqGGL9Nvy81i9UEFiYkbyad3K3lEtryaJgYp0aC12Ph/n7MR
         HKMoh9xTNqMP2WDO1xaXu+cDSMCwKQpdmw1VziNrY0h56tNRO45f9TY2qBj0YHidOVOe
         XI01reTzVuJJ15Ux4UMNx1iTspHJZoFxY2cUkLA5RlY9O5WLGbqG7i/CbAA42QNZtjMe
         nNp/gcVubOzqenavwlbSd+XAKXjYo//nxQvCIWi0f88/T+KF1tlrF8QdxTNcqDNjuJBI
         fcwREIjUgzdqxSvuz8oeUo9a5dR64zZlMmoOomCqJqh3RJNfQdT5cP4nFw1sajGbgSqS
         SK7g==
X-Gm-Message-State: AHQUAuY4DfXmrfuL5EJXFiZAYIBEHhRlzL2J1o3BlTcU/8dRcXCCqoBC
        D5KWjJUF9OgQ9BbQDfKByO9969HZ9qAWTIomgBw=
X-Google-Smtp-Source: AHgI3IZ9tYltrd7oxavWl94369EvsyvagdqvhhFtZDEex9gjRs04HZLQ3MXARmAm1kNNKVBhj3eDJpaXVD72nKK2WGs=
X-Received: by 2002:a05:6830:1193:: with SMTP id u19mr14303938otq.221.1550525069011;
 Mon, 18 Feb 2019 13:24:29 -0800 (PST)
MIME-Version: 1.0
References: <20190118170232.16142-1-anarsoul@gmail.com> <20190118170232.16142-4-anarsoul@gmail.com>
 <20190218211035.GA28145@bogus>
In-Reply-To: <20190218211035.GA28145@bogus>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Mon, 18 Feb 2019 13:24:02 -0800
Message-ID: <CA+E=qVdq5GORg-t-vVXM3zBxy3Aq93iCE+zmcGgLFBMcnTDgfw@mail.gmail.com>
Subject: Re: [PATCH 3/8] dt-bindings: net: bluetooth: Add rtl8723bs-bluetooth
To:     Rob Herring <robh@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Feb 18, 2019 at 1:10 PM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Jan 18, 2019 at 09:02:27AM -0800, Vasily Khoruzhick wrote:
> > Add binding document for bluetooth part of RTL8723BS/RTL8723CS
> >
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > ---
> >  .../bindings/net/rtl8723bs-bluetooth.txt      | 35 +++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> >
> > diff --git a/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> > new file mode 100644
> > index 000000000000..8357f242ae4c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> > @@ -0,0 +1,35 @@
> > +RTL8723BS/RTL8723CS Bluetooth
> > +---------------------
> > +
> > +RTL8723CS/RTL8723CS is WiFi + BT chip. WiFi part is connected over SDIO, while
> > +BT is connected over serial. It speaks H5 protocol with few extra commands
> > +to upload firmware and change module speed.
> > +
> > +Required properties:
> > +
> > + - compatible: should be one of the following:
> > +   * "realtek,rtl8723bs-bt"
> > +   * "realtek,rtl8723cs-bt"
> > +Optional properties:
> > +
> > + - device-wake-gpios: GPIO specifier, used to wakeup the BT module (active high)
> > + - enable-gpios: GPIO specifier, used to enable the BT module (active high)
> > + - host-wake-gpios: GPIO specifier, used to wakeup the host processor (active high)
> > + - firmware-postfix: firmware postfix to be used for firmware config
>
> How is this used?

rtl8723bs-bt needs 2 firmware binaries -- one is actual firmware,
another is firmware config which is specific to the board. If
firmware-postfix is specified, driver appends it to the name of config
and requests board-specific config while loading firmware. I.e. if
'pine64' is specified as firmware-postfix driver will load
rtl8723bs_config-pine64.bin.

> Rob
>
