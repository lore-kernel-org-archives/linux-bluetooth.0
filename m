Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707E1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 20:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F02D6140F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 20:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346783AbhI2Uu6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Sep 2021 16:50:58 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:51744 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346777AbhI2Uu6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Sep 2021 16:50:58 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0A031CED00;
        Wed, 29 Sep 2021 22:49:16 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 1/2] Bluetooth: hci_vhci: Add force_suspend entry
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210929203855.3290899-1-luiz.dentz@gmail.com>
Date:   Wed, 29 Sep 2021 22:49:15 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <A7D924D0-7EFC-4DA0-B08D-99B2F25367AE@holtmann.org>
References: <20210929203855.3290899-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This adds force_suspend which can be used to force the controller into
> suspend/resume state.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> drivers/bluetooth/hci_vhci.c | 53 ++++++++++++++++++++++++++++++++++++
> 1 file changed, 53 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

