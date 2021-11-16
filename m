Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3054C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Nov 2021 14:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86CB361C12
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Nov 2021 14:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237319AbhKPOSV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Nov 2021 09:18:21 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:48805 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237169AbhKPOSV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Nov 2021 09:18:21 -0500
Received: from smtpclient.apple (p4fefc15c.dip0.t-ipconnect.de [79.239.193.92])
        by mail.holtmann.org (Postfix) with ESMTPSA id B91B2CECD7;
        Tue, 16 Nov 2021 15:15:23 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH 3/3] Bluetooth: hci_request: Remove bg_scan_update work
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211112004844.176271-3-luiz.dentz@gmail.com>
Date:   Tue, 16 Nov 2021 15:15:23 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <0E533E62-AA0E-49D5-90C9-CE72F80CC4AE@holtmann.org>
References: <20211112004844.176271-1-luiz.dentz@gmail.com>
 <20211112004844.176271-3-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This work is no longer necessary since all the code using it has been
> converted to use hci_passive_scan/hci_passive_scan_sync.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/hci_core.h |   1 -
> net/bluetooth/hci_request.c      | 107 -------------------------------
> net/bluetooth/hci_request.h      |   5 --
> 3 files changed, 113 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

