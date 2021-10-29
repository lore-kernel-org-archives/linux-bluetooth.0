Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E50C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Oct 2021 08:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA00E61165
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Oct 2021 08:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbhJ2IYP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Oct 2021 04:24:15 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:40869 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbhJ2IYO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Oct 2021 04:24:14 -0400
Received: from smtpclient.apple (p4ff9fd51.dip0.t-ipconnect.de [79.249.253.81])
        by mail.holtmann.org (Postfix) with ESMTPSA id 480D7CED12;
        Fri, 29 Oct 2021 10:21:45 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH v6 3/3] Bluetooth: btusb: enable Mediatek to support AOSP
 extension
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHFy41_y8LS81gTHNidMdrD9tpeXf0YyvHaTKZJU+jmjuFgYXQ@mail.gmail.com>
Date:   Fri, 29 Oct 2021 10:21:44 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        pali@kernel.org, chromeos-bluetooth-upstreaming@chromium.org,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?Ik1hcmstWVcgQ2hlbiAo6Zmz5o+a5paHKSI=?= 
        <Mark-YW.Chen@mediatek.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <92566E17-4D3A-4FB5-83B2-E2B9D4BBE2EF@holtmann.org>
References: <20211021230356.v6.1.I139e71adfd3f00b88fe9edb63d013f9cd3e24506@changeid>
 <20211021230356.v6.3.I257ac5cfaf955d15670479efc311bbab702397f4@changeid>
 <AB7796C2-6543-43CD-8FA3-DAF57AB68767@holtmann.org>
 <CAHFy41_y8LS81gTHNidMdrD9tpeXf0YyvHaTKZJU+jmjuFgYXQ@mail.gmail.com>
To:     Joseph Hwang <josephsih@google.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Joseph,

> Some of Mediatek's controllers/firmwares do NOT support AOSP extensions.
> 
> Please refer to this Gerrit patch review link for chrome os
> (https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/3054233/8/drivers/bluetooth/btusb.c)
> which was reviewed by Mark-YW Chen, Mediatek's engineer.
> 
> As an example, MediaTek MT7615E does not support the AOSP extensions.
> 
> That was why I used a new BTUSB_QUALITY_REPORT flag in the changes v4
> and earlier ones.
> 
> Please let me know how you would like to proceed with this patch.

I want that inside the Mediatek specific hdev->setup() procedure, they decide if AOSP extensions are supported or not. The BTUSB flag business is getting out of hand. I really don’t want that in btusb.c anymore. I moved Intel over to do that in btintel.c and also Realtek is doing it in btrtl.c for their hardware with the MSFT extensions.

We are not doing try-and-error of HCI commands. Just keep that in mind since I said that multiple times now.

Regards

Marcel

