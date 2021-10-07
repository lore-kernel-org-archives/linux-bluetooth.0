Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974C7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Oct 2021 15:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AA9760EDF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Oct 2021 15:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241048AbhJGP6l convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Oct 2021 11:58:41 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:51172 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbhJGP6h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Oct 2021 11:58:37 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1D7AFCECE5;
        Thu,  7 Oct 2021 17:56:42 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] Bluetooth: btrtl: Ask ic_info to drop firmware
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <912f4b6441b54a1d89df6ffe4a0511ab@realtek.com>
Date:   Thu, 7 Oct 2021 17:56:41 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "apusaka@chromium.org" <apusaka@chromium.org>,
        Max Chou <max.chou@realtek.com>,
        "alex_lu@realsil.com.cn" <alex_lu@realsil.com.cn>,
        KidmanLee <kidman@realtek.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <065AC802-1C20-42F0-9B2F-24F2B2698B90@holtmann.org>
References: <20210930103634.1710-1-hildawu@realtek.com>
 <D5B18E08-AE60-4B8B-960B-694D62E067B5@holtmann.org>
 <912f4b6441b54a1d89df6ffe4a0511ab@realtek.com>
To:     Hilda Wu <hildawu@realtek.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hilda,

> The MSFT extension has a HCI_VS_MSFT_Read_Supported_Features command. The AOSP extension has a read capability cmd too.
> https://docs.microsoft.com/en-us/windows-hardware/drivers/bluetooth/microsoft-defined-bluetooth-hci-commands-and-events#hci_vs_msft_read_supported_features
> https://source.android.com/devices/bluetooth/hci_requirements#vendor-specific-capabilities
> If commands did not support, the controller should feedback event status as Unknown HCI Command (0x01).
> We can go on this way.

I am not doing trial-and-error programming here. I rather better disable any extensions for Realtek devices altogether.

Regards

Marcel

