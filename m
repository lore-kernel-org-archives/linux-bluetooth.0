Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1C9C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 08:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D91260FDC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 08:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237820AbhJFI7B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Oct 2021 04:59:01 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48198 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237744AbhJFI7A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Oct 2021 04:59:00 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9F590CED2D;
        Wed,  6 Oct 2021 10:57:06 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH V2] Bluetooth: hci_vhci: Fix to set the force_wakeup value
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211004170126.206054-1-hj.tedd.an@gmail.com>
Date:   Wed, 6 Oct 2021 10:57:06 +0200
Cc:     linux-bluetooth@vger.kernel.org,
        Tedd Ho-Jeong An <tedd.an@intel.com>
Content-Transfer-Encoding: 7bit
Message-Id: <054940FA-80C2-463B-A703-364D054F7782@holtmann.org>
References: <20211004170126.206054-1-hj.tedd.an@gmail.com>
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

> This patch sets the wakeup state of the vhci driver when the
> force_wakeup is updated.
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
> drivers/bluetooth/hci_vhci.c | 2 ++
> 1 file changed, 2 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

