Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D212C74A4B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Mar 2023 18:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjCMSNE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Mar 2023 14:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjCMSM7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Mar 2023 14:12:59 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8787B9AC;
        Mon, 13 Mar 2023 11:12:54 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-17711f56136so14639040fac.12;
        Mon, 13 Mar 2023 11:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678731173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGtf6SIwprkjjvb6epaITev79WRWoV5Y4O2K1yfDb1g=;
        b=qMqZVk3pLC3xbzWkPm4wfcJhhQHPdRhZi/P062twH/OW5f2XPAj4jkyFv381Zi/SVS
         srkmVayQYr959ujuB0Qvu2D7/iE43qCy9kLlWpiZvguS9Wt7Eb2bJm2Q1jDOjmZC1DkJ
         31SaMVh56/QZmRqdJuv+ebT2K64l5MH0OMxnrY4XGWi5k9ee/js33P0G13YYGqgb51zJ
         miLeh4cMguKjBWs5goeTReFPfLnHBWqJyVjPFOLUQe3Oqeku3OAvtvYI0CY0etC724Gv
         IpGDkMnzYSM/z+Twv6lgJhHIm2BzWl9weHJNOomYKl+CBCCPbtHf3qlV2XS4pJv0bQuq
         bSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678731173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WGtf6SIwprkjjvb6epaITev79WRWoV5Y4O2K1yfDb1g=;
        b=YQG4P98LYZAeoPVaqwc5TQS592y3vZLsd90bpD02pPlYABdvtS8kXd0uWdmNV+L8Ww
         4FWJjv5FYlu7w6xEI+S5Tbv2wkMSpX2fXVYal645mDnDHvJpgQpRslrlXLtBrAsdeTxb
         SU0yXhT4jilV2hcc4LkFfjcI34YYkBrQ8xxyL9aGwOJRLZXkk6qIyoPqULeEn1HJGGWh
         +Hva7+EDed9AX7SZLaw1PEUGlYj6AB5uFNoxayAYRvp4++bmyG2P++cln9OUPigb2XRz
         1aUt6OWlTg1LNoamUP+kSoR0ktQLoVjz3gvEFkkjDS3HA795bOCVeNKFbo1vIHLh7eKy
         JqyA==
X-Gm-Message-State: AO0yUKXzjOyI2dXwZO5B1ickowWk94GpUYumQ+OIqzLvPl7yWfsNxT3A
        dFDKk/qjuNK54RgX8Iky1K+z9qZA6ewiVWeQJatFd3CAuIs=
X-Google-Smtp-Source: AK7set/m+WIBlxqTBPAs2AyFRkV53zHJpk20UMpb6nDf28b6xYjPLegqpDGBwah+5gYtE/nCTO+FsRO9TFQoxsfBd6o=
X-Received: by 2002:a05:6870:d20d:b0:172:39d6:edc7 with SMTP id
 g13-20020a056870d20d00b0017239d6edc7mr5178902oac.4.1678731173552; Mon, 13 Mar
 2023 11:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230228152205.133582-1-macroalpha82@gmail.com>
 <20230228152205.133582-3-macroalpha82@gmail.com> <CADcbR4+Onb6RM7grPrqRL8Rth0mbFXykRmPq8R1QxYRGaHQHtA@mail.gmail.com>
In-Reply-To: <CADcbR4+Onb6RM7grPrqRL8Rth0mbFXykRmPq8R1QxYRGaHQHtA@mail.gmail.com>
From:   Chris Morgan <macroalpha82@gmail.com>
Date:   Mon, 13 Mar 2023 13:12:42 -0500
Message-ID: <CADcbR4L6b9D1FJx9u1jFvZ6jhixNs3_Ky+Mu0rHwtXZ6ATO-Eg@mail.gmail.com>
Subject: Re: [PATCH 2/3 V4] Bluetooth: hci_h5: btrtl: Add support for RTL8821CS
To:     linux-bluetooth@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        alistair@alistair23.me, anarsoul@gmail.com, luiz.dentz@gmail.com,
        johan.hedberg@gmail.com, marcel@holtmann.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I found the fix, simply put changing the compatible from
realtek,rtl8822cs-bt to realtek,rtl8732bs-bt fixes it (because it sets
the "H5_INFO_WAKEUP_DISABLE" flag). Is it too late for a V5, or should
I submit this as a fix to the devicetree and devicetree documentation?

Thank you.

On Fri, Mar 10, 2023 at 10:25=E2=80=AFAM Chris Morgan <macroalpha82@gmail.c=
om> wrote:
>
> I shudder to bring this up now, but I'm encountering a new bug and
> might have to withdraw this.
>
> I'm receiving errors in dmesg of the following, and I can't seem to
> figure out the root cause:
> Bluetooth: hci0: Out-of-order packet arrived
>
> Any thoughts on what might cause it?
> Thank you.
>
> On Tue, Feb 28, 2023 at 9:22=E2=80=AFAM Chris Morgan <macroalpha82@gmail.=
com> wrote:
> >
> > From: Chris Morgan <macromorgan@hotmail.com>
> >
> > RTL8821CS is a WiFi + Bluetooth combo chip from Realtek that provides
> > WiFi A/B/G/N/AC over an SDIO interface and Bluetooth 4.2 over a UART
> > interface.
> >
> > Note that the firmware this was tested with was firmware version
> > 0x75b8f098.
> >
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >  drivers/bluetooth/btrtl.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> > index 69c3fe649ca7..72947d319fa6 100644
> > --- a/drivers/bluetooth/btrtl.c
> > +++ b/drivers/bluetooth/btrtl.c
> > @@ -128,6 +128,14 @@ static const struct id_table ic_id_table[] =3D {
> >           .fw_name  =3D "rtl_bt/rtl8821c_fw.bin",
> >           .cfg_name =3D "rtl_bt/rtl8821c_config" },
> >
> > +       /* 8821CS */
> > +       { IC_INFO(RTL_ROM_LMP_8821A, 0xc, 0x8, HCI_UART),
> > +         .config_needed =3D true,
> > +         .has_rom_version =3D true,
> > +         .has_msft_ext =3D true,
> > +         .fw_name  =3D "rtl_bt/rtl8821cs_fw.bin",
> > +         .cfg_name =3D "rtl_bt/rtl8821cs_config" },
> > +
> >         /* 8761A */
> >         { IC_INFO(RTL_ROM_LMP_8761A, 0xa, 0x6, HCI_USB),
> >           .config_needed =3D false,
> > --
> > 2.34.1
> >
