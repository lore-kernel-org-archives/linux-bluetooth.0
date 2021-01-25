Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA1FC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jan 2021 18:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C7C922B3F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jan 2021 18:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbhAYSdr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Jan 2021 13:33:47 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:45493 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbhAYSd0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Jan 2021 13:33:26 -0500
Received: from marcel-macbook.holtmann.net (p4ff9f11c.dip0.t-ipconnect.de [79.249.241.28])
        by mail.holtmann.org (Postfix) with ESMTPSA id 78BB2CECCA;
        Mon, 25 Jan 2021 19:39:56 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH] Bluetooth: btusb: Add a Kconfig option to disable USB
 wakeup by default
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201230065441.1179-1-max.chou@realtek.com>
Date:   Mon, 25 Jan 2021 19:32:31 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alex Lu <alex_lu@realsil.com.cn>,
        Hilda Wu <hildawu@realtek.com>, kidman@realtek.com
Content-Transfer-Encoding: 8BIT
Message-Id: <D8DB0325-437C-453B-86CC-55B4F255B335@holtmann.org>
References: <20201230065441.1179-1-max.chou@realtek.com>
To:     Max Chou <max.chou@realtek.com>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Max,

> For the original commit of 9e45524a011107a73bc2cdde8370c61e82e93a4d,
> wakeup is always disabled for Realtek Bluetooth devices.
> However, there's the capability for Realtek Bluetooth devices to
> apply USB wakeup. Otherwise, there's the better power consumption
> without USB wakeup during suspending.
> In this commit, divide the original commit into two parts.
> 1. Redefine the feature that Realtek devices should be enabled wakeup on
> auto-suspend as BTUSB_WAKEUP_AUTOSUSPEND.
> 2. Add a Kconfig option to switch disable_wakeup for Bluetooth
> USB devices by default as CONFIG_BT_HCIBTUSB_DISABLEWAKEUP.

lets not make this so complicated. Lets just make this work. So define this based on the Realtek hardware that supports it and not just a generic option. If your hardware is broken or works different from revision to revision, then quirk it inside the driver.

Regards

Marcel

