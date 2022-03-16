Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360D1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Mar 2022 15:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356062AbiCPPbS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Mar 2022 11:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344573AbiCPPbR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Mar 2022 11:31:17 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 265056B093
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Mar 2022 08:30:01 -0700 (PDT)
Received: from smtpclient.apple (p5b3d2183.dip0.t-ipconnect.de [91.61.33.131])
        by mail.holtmann.org (Postfix) with ESMTPSA id C8893CECF8;
        Wed, 16 Mar 2022 16:30:00 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH v3 2/2] Bluetooth: btrtl: btmrvl: Fix firmware filename
 for some rtl chipsets
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220315095129.15254-2-tangmeng@uniontech.com>
Date:   Wed, 16 Mar 2022 16:30:00 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        martin.blumenstingl@googlemail.com, linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <8BAFC0F9-C03F-4100-B1D0-28380C732F8A@holtmann.org>
References: <20220315095129.15254-1-tangmeng@uniontech.com>
 <20220315095129.15254-2-tangmeng@uniontech.com>
To:     Meng Tang <tangmeng@uniontech.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Meng,

> Firmware for rtl chipset is as part of the linux-firmware repository
> in dir linux-firmware/rtl_bt. Today, the rtl8761a_config,
> rtl8821a_config and rtl8723b_config files are used in btrtl, but it
> doesn't actually exist, which causes errors like:
> 
> bluetooth: Direct firmware load for rtl_bt/rtl8821a_config.bin
> failed with error -2
> 
> According to the files in the rtl_bt directory in the Linux firmware,
> fixes the driver to load correct firmware file for rtl.
> 
> Fixes: f96dbd322a8f1 (Bluetooth: btrtl: add MODULE_FIRMWARE declarations)
> Signed-off-by: Meng Tang <tangmeng@uniontech.com>
> ---
> drivers/bluetooth/btrtl.c | 3 ---
> 1 file changed, 3 deletions(-)

I am ignoring this patch since the subject is bogus.

Regards

Marcel

