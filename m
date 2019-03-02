Return-Path: <SRS0=Oh6E=RF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFD0C4360F
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Mar 2019 16:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DDC820838
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Mar 2019 16:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="YBM/OVfm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfCBQoK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 2 Mar 2019 11:44:10 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38923 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfCBQoK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 2 Mar 2019 11:44:10 -0500
Received: by mail-oi1-f193.google.com with SMTP id b4so676145oif.6;
        Sat, 02 Mar 2019 08:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zPi8YjjrYHHZt+Tq08fmeWW/ylrpE7FbsL0XKvb4AQE=;
        b=YBM/OVfmHGSGQOG4eh/AZgc0BtCLWlvuq6XndNv9uEncvu+XleZ10J3od/ROp2keQ5
         h7IXjA8+Qbo+xtZ/bnL2rfefn7TGfkiV1CP0va4eucHYMLdRz9TbN5LKPpOT2QClvLT7
         q6Ssnj0i8YXr3ww0zVoyIVZH7kIHSdurXt0t49twQNL/5REFL2R1mZ7lWUCAhELatQjW
         QRMEp1SEUYmsd5lmlyPcxNMDEAagrm3he+2RRrV8WyE/rYXVJyJGeVp+8kBrRqRYfnAg
         eCU2ULoGjiAzCiKuBnmBGoIiZgWq54WP+pJ6N3AzrYiU1/IqWHqIrUhzV1Ezj3BIKxdR
         r6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zPi8YjjrYHHZt+Tq08fmeWW/ylrpE7FbsL0XKvb4AQE=;
        b=qUx1mps/WPbbz9vBsBpAfHw3ic2yOoSCOtIPziYPXHf4MfXGdq/hy17oHL+73SWV4k
         RzTS8lbWuaAjTJXL2I+h6zwEidqum2yKmLYcAHWj0CFae2ZOB3HugTFmK0kJgg3fWvv5
         WYkX5DvIqEM5jMITT0hU6C1vbgrfSh3wP157TyEaSS4Gyo3L7G0UfQO45ga0FPOzN4yA
         pPlvdqLOUtHVTn6m6nzdV06fwYhdI7lCXoG4cjvp+Z4YK4HbLbH59Nj3MBIoH78xuWNH
         KoTobZR4QD8VAKKYYdj0Y/Q0jJ6oyq6sYcpjdDnTjY6RUyMumCqE+/g9o21L/UBCCcvN
         Yjdg==
X-Gm-Message-State: APjAAAVloK8Ds52dyRQLKnbzIRlfWrUzKlpz1maGeYwMGxnw22xsSNgT
        3cMMRmKJ0Qsp4P+vbJ5j2TKcmZlDeUTc/VYqgdM=
X-Google-Smtp-Source: APXvYqy9movL6xt/Nbr+y40nHfWf77Opeqn0RKF54C6zcBYvk/SkrTCMljEbR5ywkUYlfy00B+jmi/QD1IU/7A7Ze9U=
X-Received: by 2002:aca:af01:: with SMTP id y1mr2101686oie.140.1551545049197;
 Sat, 02 Mar 2019 08:44:09 -0800 (PST)
MIME-Version: 1.0
References: <CA+E=qVdsU7sBkOQUmMprhD-Sdw7TdFnwFdGCv=4iRe++y1AwOg@mail.gmail.com>
 <20190301201519.21953-1-martin.blumenstingl@googlemail.com> <0551C926975A174EA8972327741C7889EE6B1008@RS-MBS01.realsil.com.cn>
In-Reply-To: <0551C926975A174EA8972327741C7889EE6B1008@RS-MBS01.realsil.com.cn>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 2 Mar 2019 17:43:58 +0100
Message-ID: <CAFBinCDFY+fZs2unV1T5Mhh_VVSUfxK75zZXKdanLKG+arRX5g@mail.gmail.com>
Subject: Re: [PATCH 3/8] dt-bindings: net: bluetooth: Add rtl8723bs-bluetooth
To:     =?UTF-8?B?6ZmG5pyx5Lyf?= <alex_lu@realsil.com.cn>
Cc:     "anarsoul@gmail.com" <anarsoul@gmail.com>,
        "beagleboard@davidjohnsummers.uk" <beagleboard@davidjohnsummers.uk>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "wens@csie.org" <wens@csie.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alex,

On Sat, Mar 2, 2019 at 10:30 AM =E9=99=86=E6=9C=B1=E4=BC=9F <alex_lu@realsi=
l.com.cn> wrote:
>
> Hi Martin,
> Thanks for your information.
thank you for the quick reply!

> The config is related to eFuse in chips. I'm sorry that the details can't=
 be open.
> Only some special configurations are related to the host platforms, such =
as UART working baudrate, hardware flow control, PCM settings, etc. These a=
re the settings for HCI UART and PCM Interface.
> Most of configurations are only relevant to chips.
please let me repeat this with my own words to see if I understand the
"config blob" correctly. Feel free to correct me if anything is wrong:
- the data in the config blob "patches" eFuse values at runtime (non-persis=
tent)
- we know the offsets of the UART_CONFIG, PCM_SETTING and BD_ADDR -
these can be "board specific" (like baud rate, flow control, ...)
- most other values from the "config blob" are "chip specific" -
meaning they are identical for each board and they only depend on the
chip

do you have any suggestions how we can support multiple boards (the
main goal of this whole discussion is: how to do this "correct")?
so far different approaches were discussed (not only in this thread,
but also in the past):
- use a separate config blob for each board. this means that whenever
a new board is supported (for example by adding a .dts for it to the
mainline kernel) then Bluetooth won't work out-of-the-box unless a
config is provided.
- specify the properties of the connection to the chip (for example by
adding a device-tree property for the speed, flow control, ...) and
generate the config based on the device-tree properties.
- (I am open for other suggestions, please let us know if you have any)

I would like to hear your opinion on this topic and especially the
reasons behind your suggestions.


Best regards
Martin
