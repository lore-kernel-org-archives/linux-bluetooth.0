Return-Path: <SRS0=YdAw=6E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A047AC3815B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 16:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F7892078E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 16:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BW+UrLUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgDTQKi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726036AbgDTQKh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Apr 2020 12:10:37 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A065C061A0C
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2020 09:10:37 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id 1so6343831vsl.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2020 09:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qpi0J/WbUvWdEolbQKeQDKkPShB1LtnL6nCqIWc36DY=;
        b=BW+UrLUtrSDOWpQ96lKroLpJ0GwsHePk7gEl2qvro7DvnBAyWbLfxdYVxN7FfnDeCx
         uJflNPa99uT59gx0fkK578RAV2OBPkTQPj6JK+HLaXtjY51SSK7Kn8qaxH5CDXKgnC6j
         IPm+O7QSpNLXbY2QCSjbrdWF1Yu6vCqNvXsTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qpi0J/WbUvWdEolbQKeQDKkPShB1LtnL6nCqIWc36DY=;
        b=aROLlpCAGL9fcb0Uyw28r2mfJFW+ViVJA4+dvlierILnSwbOmC9oWLt5AHqG6nYgCS
         XAiqEs3VLcdWHTF+uF6MqM1KJaCxJg77taG7PXJF6NwxTgk9i5SUiA1ap+VZs26SS4YO
         NG9fdtb6Hzb23PecYXMXgk6qlAMJR3wWTeUeVTuFDhIYhWjU0MgmI7lAT2lJZmJ/0Bey
         jFMXXy6TmxRRTsfCK1QTZhS6diZZU1zSKVIp7r0wUIwx10fNDpoZtmALw1Hbx03HsE7P
         zfoI7KJ9vcnUXr+y+NHroEmd10mpoR7nnEckmL4GqxgYVbvT0QDdqJiQEt+fc9XbBVSI
         KPyg==
X-Gm-Message-State: AGi0PuaQls2m84rGJiJivU/0ho2uK5Jzu2p3wbQzdcBtOz9yHX3RXQCF
        1No2/40MWwo/UV2g3XqGGzxiPSwhZRJdJqC3fZA1IhICHFY=
X-Google-Smtp-Source: APiQypIhS53Wee3RsQbe8vsxG5wUcME+kVwG3CPn5YmAWHWxOSWNCLky0Dv3AKwNMcB18Ggu9pPBfR5XmDGTQ6pv/Dk=
X-Received: by 2002:a67:d998:: with SMTP id u24mr12522181vsj.93.1587399036183;
 Mon, 20 Apr 2020 09:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <F208C554-13FE-4943-9DA0-21A280E0DB09@gmail.com>
In-Reply-To: <F208C554-13FE-4943-9DA0-21A280E0DB09@gmail.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Mon, 20 Apr 2020 09:10:22 -0700
Message-ID: <CANFp7mWHAig=f+6iZbum0xnHA7-32LNmoY94n=wwhMkYYoNF=A@mail.gmail.com>
Subject: Re: How to handle different operating speed for QCA9377 SDIO BT module?
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        linux-amlogic@lists.infradead.org, ath10k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Christian,

Looks like the max-speed setting is inside an if block and that might
be why you're not able to set it
(https://github.com/torvalds/linux/blame/master/drivers/bluetooth/hci_qca.c=
#L1892).
I would suggest moving that outside the if block and trying again.

Abhishek

On Mon, Apr 20, 2020 at 1:51 AM Christian Hewitt
<christianshewitt@gmail.com> wrote:
>
> Resend to expand the audience and include the linux-amlogic and ath10k li=
sts.
>
> >>>>>
>
> I=E2=80=99m working with a QCA9337 SDIO device on an Android (now Linux) =
set-top box with an Amlogic S905D SoC.
>
> SDIO WiFi (ath10k) is working since 5.7-rc1, but the BT side of the modul=
e is still missing.
>
> Most Amlogic devices (95%+) use Broadcom SDIO modules with the following =
device tree content:
>
> &uart_A {
>         bluetooth {
>                 compatible =3D "brcm,bcm43438-bt";
>                 shutdown-gpios =3D <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
>                 max-speed =3D <2000000>;
>                 clocks =3D <&wifi32k>;
>                 clock-names =3D "lpo";
>         };
> };
>
> I changed the compatible to "qcom,qca9377-bt=E2=80=9D and applied the fol=
lowing patch:
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 439392b1c043..6f0350fbdcd6 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2046,6 +2046,7 @@ static SIMPLE_DEV_PM_OPS(qca_pm_ops, qca_suspend, q=
ca_resume);
>
> static const struct of_device_id qca_bluetooth_of_match[] =3D {
>        { .compatible =3D "qcom,qca6174-bt" },
> +       { .compatible =3D "qcom,qca9377-bt" },
>        { .compatible =3D "qcom,wcn3990-bt", .data =3D &qca_soc_data_wcn39=
90},
>        { .compatible =3D "qcom,wcn3991-bt", .data =3D &qca_soc_data_wcn39=
91},
>        { .compatible =3D "qcom,wcn3998-bt", .data =3D &qca_soc_data_wcn39=
98},
>
> This results in probing with errors: http://ix.io/2i6P
>
> I noticed "max-speed =3D <2000000>;=E2=80=9D while hci_qca.c sets 3000000=
. I attempted to set "max-speed =3D <3000000>;=E2=80=9D but this made no di=
fference, so I patched a lower value in hci_qca:
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 6f0350fbdcd6..b7ea1e9f4904 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1678,7 +1678,7 @@ static const struct hci_uart_proto qca_proto =3D {
>        .name           =3D "QCA",
>        .manufacturer   =3D 29,
>        .init_speed     =3D 115200,
> -       .oper_speed     =3D 3000000,
> +       .oper_speed     =3D 2000000,
>        .open           =3D qca_open,
>        .close          =3D qca_close,
>        .flush          =3D qca_flush,
>
> This results in an attempt to load firmware, see: http://ix.io/2i6Q and u=
sing renamed files from https://github.com/boundarydevices/qca-firmware/tre=
e/bd-sdmac-ath10k/qca the module is now otherwise up/working - I can scan/s=
ee/pair other BT devices.
>
> see: http://ix.io/2i6S and:
>
> SML5442TW:~ # bluetoothctl show
> Controller 91:08:00:00:00:00 (public)
>         Name: SML5442TW
>         Alias: SML5442TW
>         Class: 0x000c0000
>         Powered: yes
>         Discoverable: no
>         DiscoverableTimeout: 0x000000b4
>         Pairable: yes
>         UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b=
34fb)
>         UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b=
34fb)
>         UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b=
34fb)
>         UUID: PnP Information           (00001200-0000-1000-8000-00805f9b=
34fb)
>         UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b=
34fb)
>         UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b=
34fb)
>         UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b=
34fb)
>         Modalias: usb:v1D6Bp0246d0536
>         Discovering: no
> Advertising Features:
>         ActiveInstances: 0x00
>         SupportedInstances: 0x05
>         SupportedIncludes: tx-power
>         SupportedIncludes: appearance
>         SupportedIncludes: local-name
>
> So it looks like hci_qca.c needs modification to handle multiple operatin=
g speeds, perhaps using the max-speed description from device-tree if avail=
able, or defaulting to the current 3000000 value if not.
>
> I=E2=80=99m not a coding developer so if someone can suggest a patch - I =
can test and confirm it works. Or if someone can explain how this should be=
 implemented I will see if I can find someone to help with the task.
>
> Christian
>
