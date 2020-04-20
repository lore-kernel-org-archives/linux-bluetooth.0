Return-Path: <SRS0=YdAw=6E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1280C3A5A0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 08:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89D2D20CC7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 08:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pfSKR5Iw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgDTIvJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725896AbgDTIvI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Apr 2020 04:51:08 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC3BC061A0C
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2020 01:51:07 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id j3so8974453ljg.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2020 01:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=3SQVi3mviWeg4CS1cwBmZBBpKg+8/akNu+v9myGu7iY=;
        b=pfSKR5IwwyY5eTlx21cr9CVFgg/2tp5X45Q5uU83a6eNO1wBR1ZhbSVvJoGQu+w6T6
         gbe9hbXknxGjQxNs3hNXQAa353vErY9Fjwr/23YNbecaMpqR3fn9/NT0k0WzlE2wREUz
         xVWlJcgonaQZ5tYecx8OrTS3p/c3+qO6rFgDHMIyfECBcSo3BYTKlyvX3+YQPqFSoGhS
         lrEcoQpHeW52OHqsEVfEley4PD43VsfgrQXSZ7P/llfITN2HO3HRpoWRh/DwvgjVyBmI
         7pPpY/U74e8AF4FWrLC/SPuyZPC0Mx6AES8kR/GukT5o3atrQd306DTMwh1xdvmUg7PD
         1byQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=3SQVi3mviWeg4CS1cwBmZBBpKg+8/akNu+v9myGu7iY=;
        b=FqexmxHJLbM9UewY2inunD8HnHfZmdT2LTmXURpNYfD51vheVA+c9MxD0DHya5H5Jf
         LEcmAsu0s11lQesxLntX5j7HZDz5/JGGDv8klQJxWZMELljuq8mP5AMj0vUo9E6fohex
         Xjt/Tya4YvMpaD7fDc7W5dMQatgj7T4P9ze7nK/zlL1FP3CCUvPP5WoO2KpILFnDtzYB
         NuRQ4BLDhG1dCeCWuEifmS4GeMrA520zToadJQMXeSVQi7AFjWBcCgyujfm3QWWeI7Ih
         pnHspP3/vbPs0vTeT31VOCEtYAIQQ/0bw3aXgeh0yI4oiFpriRx909ajW49pk50EKtq+
         ICwA==
X-Gm-Message-State: AGi0PuZP3n8nP4Vmnuci57vWCWI2tbfGJgp5WvJf+RNXrf/lw0jiYCc+
        hbDeGOiLBaVNhKxETsykUMG4OKDP
X-Google-Smtp-Source: APiQypLG8MOu1MOzX5sCFP/mBG9YNnnspTnLAhadXmwEtuT/kuRiMYklHB9w2VlvghfQCoorkmChtg==
X-Received: by 2002:a05:651c:30b:: with SMTP id a11mr9387168ljp.164.1587372665259;
        Mon, 20 Apr 2020 01:51:05 -0700 (PDT)
Received: from [172.16.20.20] ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 73sm479895ljj.72.2020.04.20.01.51.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2020 01:51:04 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: How to handle different operating speed for QCA9377 SDIO BT module?
Message-Id: <F208C554-13FE-4943-9DA0-21A280E0DB09@gmail.com>
Date:   Mon, 20 Apr 2020 12:51:01 +0400
To:     linux-bluetooth@vger.kernel.org, linux-amlogic@lists.infradead.org,
        ath10k@lists.infradead.org
X-Mailer: Apple Mail (2.3445.104.14)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Resend to expand the audience and include the linux-amlogic and ath10k =
lists.

>>>>>

I=E2=80=99m working with a QCA9337 SDIO device on an Android (now Linux) =
set-top box with an Amlogic S905D SoC.

SDIO WiFi (ath10k) is working since 5.7-rc1, but the BT side of the =
module is still missing.

Most Amlogic devices (95%+) use Broadcom SDIO modules with the following =
device tree content:

&uart_A {
	bluetooth {
		compatible =3D "brcm,bcm43438-bt";
		shutdown-gpios =3D <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
		max-speed =3D <2000000>;
		clocks =3D <&wifi32k>;
		clock-names =3D "lpo";
	};
};

I changed the compatible to "qcom,qca9377-bt=E2=80=9D and applied the =
following patch:

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 439392b1c043..6f0350fbdcd6 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2046,6 +2046,7 @@ static SIMPLE_DEV_PM_OPS(qca_pm_ops, qca_suspend, =
qca_resume);

static const struct of_device_id qca_bluetooth_of_match[] =3D {
       { .compatible =3D "qcom,qca6174-bt" },
+       { .compatible =3D "qcom,qca9377-bt" },
       { .compatible =3D "qcom,wcn3990-bt", .data =3D =
&qca_soc_data_wcn3990},
       { .compatible =3D "qcom,wcn3991-bt", .data =3D =
&qca_soc_data_wcn3991},
       { .compatible =3D "qcom,wcn3998-bt", .data =3D =
&qca_soc_data_wcn3998},

This results in probing with errors: http://ix.io/2i6P

I noticed "max-speed =3D <2000000>;=E2=80=9D while hci_qca.c sets =
3000000. I attempted to set "max-speed =3D <3000000>;=E2=80=9D but this =
made no difference, so I patched a lower value in hci_qca:

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 6f0350fbdcd6..b7ea1e9f4904 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1678,7 +1678,7 @@ static const struct hci_uart_proto qca_proto =3D {
       .name           =3D "QCA",
       .manufacturer   =3D 29,
       .init_speed     =3D 115200,
-       .oper_speed     =3D 3000000,
+       .oper_speed     =3D 2000000,
       .open           =3D qca_open,
       .close          =3D qca_close,
       .flush          =3D qca_flush,

This results in an attempt to load firmware, see: http://ix.io/2i6Q and =
using renamed files from =
https://github.com/boundarydevices/qca-firmware/tree/bd-sdmac-ath10k/qca =
the module is now otherwise up/working - I can scan/see/pair other BT =
devices.

see: http://ix.io/2i6S and:

SML5442TW:~ # bluetoothctl show
Controller 91:08:00:00:00:00 (public)
	Name: SML5442TW
	Alias: SML5442TW
	Class: 0x000c0000
	Powered: yes
	Discoverable: no
	DiscoverableTimeout: 0x000000b4
	Pairable: yes
	UUID: Audio Source              =
(0000110a-0000-1000-8000-00805f9b34fb)
	UUID: Generic Attribute Profile =
(00001801-0000-1000-8000-00805f9b34fb)
	UUID: Generic Access Profile    =
(00001800-0000-1000-8000-00805f9b34fb)
	UUID: PnP Information           =
(00001200-0000-1000-8000-00805f9b34fb)
	UUID: A/V Remote Control Target =
(0000110c-0000-1000-8000-00805f9b34fb)
	UUID: A/V Remote Control        =
(0000110e-0000-1000-8000-00805f9b34fb)
	UUID: Audio Sink                =
(0000110b-0000-1000-8000-00805f9b34fb)
	Modalias: usb:v1D6Bp0246d0536
	Discovering: no
Advertising Features:
	ActiveInstances: 0x00
	SupportedInstances: 0x05
	SupportedIncludes: tx-power
	SupportedIncludes: appearance
	SupportedIncludes: local-name

So it looks like hci_qca.c needs modification to handle multiple =
operating speeds, perhaps using the max-speed description from =
device-tree if available, or defaulting to the current 3000000 value if =
not.

I=E2=80=99m not a coding developer so if someone can suggest a patch - I =
can test and confirm it works. Or if someone can explain how this should =
be implemented I will see if I can find someone to help with the task.

Christian

