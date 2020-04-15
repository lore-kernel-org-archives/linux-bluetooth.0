Return-Path: <SRS0=7bNH=57=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAEDC2BA2B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Apr 2020 05:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 346CC20767
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Apr 2020 05:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pKi7Y5Cp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393234AbgDOFHl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Apr 2020 01:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389851AbgDOFHj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Apr 2020 01:07:39 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3658C061A0C
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2020 22:07:37 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id r17so1617192lff.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2020 22:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=NGXx9M4AMUDqiyXTQf3bXZxEMC4hWGJ8ee6YLgmW8KY=;
        b=pKi7Y5CpV4QwcBUujM6YKgR+dbxbHo0yR4hnHp6tX0xpT9aLSs9Zrgq74XCuUPxEt9
         uXJR3C+o0+kcQJZUUDO3R8hZGGFv7GqYkZOLpFiQqi2pxteTGyXFYGPSCYBMTTG+IUQD
         l4AAXUvcoiXZSaz99eW8kpJ2o2aRyBaJX2fV9+y5zg1HyQGgxJjxYZaheQ7M1i/BOryZ
         MEPqU1Ng1C9B8Hdhh4YzNZuTgYyxYdCssVKvpyZbSE3QBYsDJY6VBfIUxmNRDtP1KFfr
         QFMHM4RCVzSysPfh3yCPYjbHYD5RbUZ7KFFFhDTXBpw7W5nzJuLwii/fqJpgHeqn+FJ3
         7S0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=NGXx9M4AMUDqiyXTQf3bXZxEMC4hWGJ8ee6YLgmW8KY=;
        b=h26y5UTB7SoSQ+5sk+j2y3zyo9EtT3CQ97lFk4D4AiBTkx376ujNLFj0Bqv426oWS0
         LsLQIc+mv/OHoMjqHv4+jFOXynVxppU2NcLAMP/+Qu/MrtjFY3sH68vmxUUZxvUrVp1W
         VYptjCfl1dpbqN3O3C2YFodaXRySvk1KaQ+9GYZbirU6y1RcGkYh0GzY8h80j6tL7Ewo
         THfxsXaW/3E9LvSYrjrbFaWEAn5VVmtaKQQLHrhMexWNHhafk058yfJCL5LG6wwT+z9U
         u+M9twug/4VoYnFiirL4PxvWSN3CYHqvx5WQyH/lXgvYaznRLmqsAkAcecNZgEt24s4F
         UDag==
X-Gm-Message-State: AGi0PuZ7GGDayxscUYJTXZvbczfZB7dkKqyGa+ZWleLJwwlO1RBYoQyx
        7pGggX8tb9HPO52AYS8J9bFRh7cZ
X-Google-Smtp-Source: APiQypIyI0xvKl4KNfB53nNN3x7k1h46cQW/y1g7vvypgv1o7kBry5wvy5nt9nXSIW5mFGzG0hooUg==
X-Received: by 2002:a05:6512:3187:: with SMTP id i7mr1928107lfe.101.1586927255882;
        Tue, 14 Apr 2020 22:07:35 -0700 (PDT)
Received: from [172.16.20.20] ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id d3sm8823741lfq.63.2020.04.14.22.07.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2020 22:07:35 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: How to handle different operating speed for QCA9377 SDIO BT module?
Message-Id: <1D4C533D-575D-4AC5-A627-389502097A77@gmail.com>
Date:   Wed, 15 Apr 2020 09:07:32 +0400
To:     linux-bluetooth@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.14)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

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
=20
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

This shows a frame reassembly error, but an attempt to load firmware, =
see: http://ix.io/2i6Q

Using renamed files from =
https://github.com/boundarydevices/qca-firmware/tree/bd-sdmac-ath10k/qca

There is still a "kernel: Bluetooth: hci0: Frame reassembly failed =
(-84)=E2=80=9D error, but the module is now otherwise up/working - I can =
scan/see/pair other BT devices.

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

I=E2=80=99m not a coding developer so I need to ask for help. If someone =
can suggest a patch - I can test and confirm it works. Or if someone can =
explain how this should be implemented, I can see if I can find someone =
to help with the task.

Christian

