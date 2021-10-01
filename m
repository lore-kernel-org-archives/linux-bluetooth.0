Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D47C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Oct 2021 09:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D307761A08
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Oct 2021 09:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353097AbhJAJoU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Oct 2021 05:44:20 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:44106 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353285AbhJAJn4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Oct 2021 05:43:56 -0400
Received: from smtpclient.apple (unknown [62.214.10.150])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8123CCED29;
        Fri,  1 Oct 2021 11:42:10 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] Bluetooth: btrtl: Ask ic_info to drop firmware
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210930103634.1710-1-hildawu@realtek.com>
Date:   Fri, 1 Oct 2021 11:42:10 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        kai.heng.feng@canonical.com, apusaka@chromium.org,
        max.chou@realtek.com, alex_lu@realsil.com.cn, kidman@realtek.com
Content-Transfer-Encoding: 8BIT
Message-Id: <D5B18E08-AE60-4B8B-960B-694D62E067B5@holtmann.org>
References: <20210930103634.1710-1-hildawu@realtek.com>
To:     Hilda Wu <hildawu@realtek.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hilda,

> Some un-support wakeup platforms keep USB power and suspend signal
> is coming late, this makes Realtek some chip keep its firmware,
> and make it never load new firmware.
> 
> So use vendor specific HCI command to ask them drop its firmware after
> system shutdown or resume.
> 
> Signed-off-by: Hilda Wu <hildawu@realtek.com>
> ---
> drivers/bluetooth/btrtl.c | 12 +++++++-----
> 1 file changed, 7 insertions(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

Btw. is there a simple way (via vendor HCI commands or similar) to tell which RTL device supports the MSFT or AOSP extensions. I rather have this done once and not keep hacking it over and over again.

Regards

Marcel

