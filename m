Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429B6C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Nov 2022 12:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbiKVMcD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Nov 2022 07:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbiKVMcB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Nov 2022 07:32:01 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFD65917C
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Nov 2022 04:32:00 -0800 (PST)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1E2E83F479
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Nov 2022 12:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1669120318;
        bh=cy6P0DKYCsW8gS39/PQJ3z4iEtVvRmbhOaQOE/eo598=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=acDzcSD7Ddjf+KgEECeGYzYo4RQcJ7ekGCxQxc9cJLOcHGCbZ8dzlbFcy0EUsQmpF
         Z2GWIJ+/123aBdHRBe7ozTT6byyx03drgABuI9tsL+01gqOmleD4j9+4urDLFY9K14
         oT1qk224al8V9+mY+yK3/fKRDbe56lvb4w73J4wf0FaFIsKEH3oEj8BfukrL7WUjvc
         i+p/Vzy/DeKFqMm8nsBxMoMSC+5VUvvSP0d3cXCBVPbBnMI5QazMJ4bYdyo5xeb4Mn
         +sDdDPV8xQS76Sv4fbi27behNDDWkeu/AIbGLAC+0BmAwtYIn+gKZDRK551WedWiqr
         arESDqrNgAaXg==
Received: by mail-wm1-f70.google.com with SMTP id m34-20020a05600c3b2200b003cf549cb32bso10937021wms.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Nov 2022 04:31:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cy6P0DKYCsW8gS39/PQJ3z4iEtVvRmbhOaQOE/eo598=;
        b=bWyachgM1vlEF4oGNQ4XOCnd1RRWypH6H0D131sXoBiW/oKeqLxIBxk/fb3oNdrIvu
         wYnoBnqq/IurzBKShv71bHq4ws6tHhEPOy+Jp2A14pG8joavKbMWEwlGngiSyZyInjm4
         DcDufG95iDi2VRpNHeJd46D3SsN4l4OTUqWgzzrHXqycoLQ+I+vEBKoMBhua9H07qg0g
         G14yfvjusueVFl3lnTGrSb42DQkqQfMdHR5beKaB0OhkRq/fauUHfcFC1xcQGFeAoNpH
         +pd9tkoZ5lXJNGQUcQYDjMUm9Ap4MoDJSrf8CfezDI1kkXrHYU4WZdT0X2k/Xv+pfBCk
         rswA==
X-Gm-Message-State: ANoB5ploCmqKKlsl9KYjXe/4Yu7d1xbYiGtsM2+zeVZiMoYgGgS9VT+t
        QRl3RVzfg7dswmh7nMRZIFfnQi7m43kRG1srS6+JXQR1PyrAQnSk2xhYkc7a+r04Fj+mU68IoZJ
        hwmBP6Yf7tiRoz7KrfzrRmZRJX5P43K91qrDSk+bGpx0FPW8YdKRY3UDK6UtGAA==
X-Received: by 2002:a05:600c:1d12:b0:3cf:8441:4a7c with SMTP id l18-20020a05600c1d1200b003cf84414a7cmr20066042wms.0.1669120317641;
        Tue, 22 Nov 2022 04:31:57 -0800 (PST)
X-Google-Smtp-Source: AA0mqf72kPCRsfegXgNVFwZxPIV7WPirSuakl5+M57Sd3IIBXKPC9S7rsbuDbnxmwf4h3n9YGReLhuAy8ffmWSe1Qgg=
X-Received: by 2002:a05:600c:1d12:b0:3cf:8441:4a7c with SMTP id
 l18-20020a05600c1d1200b003cf84414a7cmr20066028wms.0.1669120317389; Tue, 22
 Nov 2022 04:31:57 -0800 (PST)
MIME-Version: 1.0
References: <20221121145125.1303097-1-dimitri.ledkov@canonical.com> <1398b5489da6884d86245e4a6442575e85bf2d73.camel@linux.intel.com>
In-Reply-To: <1398b5489da6884d86245e4a6442575e85bf2d73.camel@linux.intel.com>
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Date:   Tue, 22 Nov 2022 12:31:21 +0000
Message-ID: <CADWks+aAVzCKd=5jDyD=dWdq2M_ybYNGN2iKV6B1gw3M-Hw_2Q@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: btintel: Correctly declare all module
 firmware files
To:     Tedd Ho-Jeong An <tedd.an@linux.intel.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, 21 Nov 2022 at 23:44, Tedd Ho-Jeong An <tedd.an@linux.intel.com> wrote:
>
> Hi Dimitri,
>
> On Mon, 2022-11-21 at 14:51 +0000, Dimitri John Ledkov wrote:
> > Strictly encode patterns of supported hw_variants of firmware files
> > the kernel driver supports requesting. This now includes many missing
> > and previously undeclared module firmware files for 0x07, 0x08,
> > 0x11-0x14, 0x17-0x1b hw_variants.
> >
> > This especially affects environments that only install firmware files
> > declared and referenced by the kernel modules. In such environments,
> > only the declared firmware files are copied resulting in most Intel
> > Bluetooth devices not working. I.e. host-only dracut-install initrds,
> > or Ubuntu Core kernel snaps.
> >
> > BugLink: https://bugs.launchpad.net/bugs/1970819
> > Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> > ---
> >  Changes since v3:
> >  - Hopefully pacify trailing whitespace from GitLint in this optional
> >    portion of the commit.
> >
> >  Changes since v2:
> >  - encode patterns for 0x17 0x18 0x19 0x1b hw_variants
> >  - rebase on top of latest rc tag
> >
> >  Changes since v1:
> >  - encode strict patterns of supported firmware files for each of the
> >    supported hw_variant generations.
> >
> >  drivers/bluetooth/btintel.c | 26 ++++++++++++++++++++++----
> >  1 file changed, 22 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> > index a657e9a3e96a..55efc4a067db 100644
> > --- a/drivers/bluetooth/btintel.c
> > +++ b/drivers/bluetooth/btintel.c
> > @@ -2656,7 +2656,25 @@ MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
> >  MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
> >  MODULE_VERSION(VERSION);
> >  MODULE_LICENSE("GPL");
> > -MODULE_FIRMWARE("intel/ibt-11-5.sfi");
> > -MODULE_FIRMWARE("intel/ibt-11-5.ddc");
> > -MODULE_FIRMWARE("intel/ibt-12-16.sfi");
> > -MODULE_FIRMWARE("intel/ibt-12-16.ddc");
> > +/* hw_variant 0x07 0x08 */
> > +MODULE_FIRMWARE("intel/ibt-hw-37.7.*-fw-*.*.*.*.*.bseq");
> > +MODULE_FIRMWARE("intel/ibt-hw-37.7.bseq");
> > +MODULE_FIRMWARE("intel/ibt-hw-37.8.*-fw-*.*.*.*.*.bseq");
> > +MODULE_FIRMWARE("intel/ibt-hw-37.8.bseq");
> > +/* hw_variant 0x0b 0x0c */
> > +MODULE_FIRMWARE("intel/ibt-11-*.sfi");
> > +MODULE_FIRMWARE("intel/ibt-12-*.sfi");
> > +MODULE_FIRMWARE("intel/ibt-11-*.ddc");
> > +MODULE_FIRMWARE("intel/ibt-12-*.ddc");
> > +/* hw_variant 0x11 0x12 0x13 0x14 */
> > +MODULE_FIRMWARE("intel/ibt-17-*-*.sfi");
> > +MODULE_FIRMWARE("intel/ibt-18-*-*.sfi");
> > +MODULE_FIRMWARE("intel/ibt-19-*-*.sfi");
> > +MODULE_FIRMWARE("intel/ibt-20-*-*.sfi");
> > +MODULE_FIRMWARE("intel/ibt-17-*-*.ddc");
> > +MODULE_FIRMWARE("intel/ibt-18-*-*.ddc");
> > +MODULE_FIRMWARE("intel/ibt-19-*-*.ddc");
> > +MODULE_FIRMWARE("intel/ibt-20-*-*.ddc");
>
> There are firmware files for hw_variant 0x11 and 0x12 in an old format like
> ibt-17-*.sfi, ibt-17-*.ddc, ibt-18-*.sfi, and ibt-18-*.ddc.
>

I believe 0x11 and 0x12 variants have stopped using the ibt-17-*.sfi,
ibt-17-*.ddc, ibt-18-*.sfi, and ibt-18-*.ddc patterns in
af3715e5cef8 ("Bluetooth: btusb: Update firmware filename for Intel
9x60 and later")
Which was shipped in v4.15. As long as I mark this patch for stable
v4.15+ this is documenting the firmware file the current driver can
request.
Distributions/deployments that use this current version of the driver
should not ship  unused ibt-17-*.sfi, ibt-17-*.ddc, ibt-18-*.sfi, and
ibt-18-*.ddc files anymore.

> > +/* hw_variant 0x17 0x18 0x19 0x1b, read and use cnvi/cnvr */
> > +MODULE_FIRMWARE("ibt-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9].sfi");
> > +MODULE_FIRMWARE("ibt-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9].ddc");
>
> I believe these are under intel/ folder.
>

Yes!

Will fix this up.

-- 
okurrr,

Dimitri
