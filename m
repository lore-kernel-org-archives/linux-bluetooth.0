Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733C4C74A4B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Mar 2023 16:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjCJQ3g (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Mar 2023 11:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCJQ3S (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Mar 2023 11:29:18 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7852A12C0D5;
        Fri, 10 Mar 2023 08:25:53 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1755e639b65so6417133fac.3;
        Fri, 10 Mar 2023 08:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678465552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2PgjZ/8V+cl158bxCaGpHbEL4XOy790DRH6Lk1TPsw=;
        b=Xxw16YGU5lxrcjb5M6HshOp/QA5ymHzLVHjdQZtkgIjUGbYt2QchROnfQhAo7Lm6uI
         leE6pxcrAaHKTwovkDDHUzAz8WGRrZ+6EjucH2MxbLxgrALXjPsiiVe2kQTM4s6MM7k7
         vYdi5XVp4bVXirH0sDVistEAYELS062s4havTYcEPZhGNItohNt6+x5x4gVNKQ4x9/4r
         vQHyjqYwRCZTuRU4LZeCerajPNsHpOMtB4td29wJjeMMbCLGleTmYuuw974i5rGWXGz3
         gpCQ/ihsXu/XHFwL9W7N/4O5RXnWUBn7L1r188DmAFjYMkm3a3X6nyoJUbBcVdm21uyT
         lyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678465552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2PgjZ/8V+cl158bxCaGpHbEL4XOy790DRH6Lk1TPsw=;
        b=gxe4c2KBvf/Hfj81xBb8RLYuzAjTU0hLev16ejp63U4G/3V1U00j12v0GhHECvry8/
         Rs26XRjSBtA6UpQRAvnqpOgks5V7UVltIAMJaQpoZ+KY0hoswxGeEh3XV8Zb7KgE/FqC
         MlMEQ6znBwMwYl38spgLuNKQIXV6xibLWZcHzORGWDqoLnmVKCv13ePe6jbEcESqOgMv
         SM7h0gdqbVojUPR142trZq/dpw7j/q+XpuWQ5PqdUHR296gD4ZY/2rX1/slHngTe4TW9
         h+YSHJnUbXEm69eRYqHzAaprjICjNNHwwx11N0p7V2e8D/mH1fI66kd/b2DdU5y5Wwz1
         fANw==
X-Gm-Message-State: AO0yUKXS5DQHV9beMSRXM9FkemYc8A6URnDMZRs1w2NW9XbzTMrvbeVV
        bjCjw3zl3WxNNJa4JB+jOlbh8rVuOm9/W7J8gU/1/OjKDS0=
X-Google-Smtp-Source: AK7set8oNerOfLCLDaZ3iQ7XsqoUVqgWXVGvLlrdF8Cd7tCykN6/WBCkpJzhIUKJp6K6SkElX7hOPSaujWIfJvliH58=
X-Received: by 2002:a05:6870:8c28:b0:16d:fb8e:3ba with SMTP id
 ec40-20020a0568708c2800b0016dfb8e03bamr8932410oab.0.1678465552612; Fri, 10
 Mar 2023 08:25:52 -0800 (PST)
MIME-Version: 1.0
References: <20230228152205.133582-1-macroalpha82@gmail.com> <20230228152205.133582-3-macroalpha82@gmail.com>
In-Reply-To: <20230228152205.133582-3-macroalpha82@gmail.com>
From:   Chris Morgan <macroalpha82@gmail.com>
Date:   Fri, 10 Mar 2023 10:25:41 -0600
Message-ID: <CADcbR4+Onb6RM7grPrqRL8Rth0mbFXykRmPq8R1QxYRGaHQHtA@mail.gmail.com>
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

I shudder to bring this up now, but I'm encountering a new bug and
might have to withdraw this.

I'm receiving errors in dmesg of the following, and I can't seem to
figure out the root cause:
Bluetooth: hci0: Out-of-order packet arrived

Any thoughts on what might cause it?
Thank you.

On Tue, Feb 28, 2023 at 9:22=E2=80=AFAM Chris Morgan <macroalpha82@gmail.co=
m> wrote:
>
> From: Chris Morgan <macromorgan@hotmail.com>
>
> RTL8821CS is a WiFi + Bluetooth combo chip from Realtek that provides
> WiFi A/B/G/N/AC over an SDIO interface and Bluetooth 4.2 over a UART
> interface.
>
> Note that the firmware this was tested with was firmware version
> 0x75b8f098.
>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  drivers/bluetooth/btrtl.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 69c3fe649ca7..72947d319fa6 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -128,6 +128,14 @@ static const struct id_table ic_id_table[] =3D {
>           .fw_name  =3D "rtl_bt/rtl8821c_fw.bin",
>           .cfg_name =3D "rtl_bt/rtl8821c_config" },
>
> +       /* 8821CS */
> +       { IC_INFO(RTL_ROM_LMP_8821A, 0xc, 0x8, HCI_UART),
> +         .config_needed =3D true,
> +         .has_rom_version =3D true,
> +         .has_msft_ext =3D true,
> +         .fw_name  =3D "rtl_bt/rtl8821cs_fw.bin",
> +         .cfg_name =3D "rtl_bt/rtl8821cs_config" },
> +
>         /* 8761A */
>         { IC_INFO(RTL_ROM_LMP_8761A, 0xa, 0x6, HCI_USB),
>           .config_needed =3D false,
> --
> 2.34.1
>
