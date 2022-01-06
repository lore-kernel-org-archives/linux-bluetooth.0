Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3D2C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jan 2022 13:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239764AbiAFNxU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jan 2022 08:53:20 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:37982 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239519AbiAFNxT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jan 2022 08:53:19 -0500
Received: from smtpclient.apple (p4fefca45.dip0.t-ipconnect.de [79.239.202.69])
        by mail.holtmann.org (Postfix) with ESMTPSA id CA29ECECD5;
        Thu,  6 Jan 2022 14:53:16 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] Bluetooth: hci_bcm: Check for error irq
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211224025318.1541232-1-jiasheng@iscas.ac.cn>
Date:   Thu, 6 Jan 2022 14:53:16 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <6210F403-8749-45E1-9319-BEB911EBD096@holtmann.org>
References: <20211224025318.1541232-1-jiasheng@iscas.ac.cn>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jiasheng,

> For the possible failure of the platform_get_irq(), the returned irq
> could be error number and will finally cause the failure of the
> request_irq().
> Consider that platform_get_irq() can now in certain cases return
> -EPROBE_DEFER, and the consequences of letting request_irq() effectively
> convert that into -EINVAL, even at probe time rather than later on.
> So it might be better to check just now.
> 
> Fixes: 0395ffc1ee05 ("Bluetooth: hci_bcm: Add PM for BCM devices")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> drivers/bluetooth/hci_bcm.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

