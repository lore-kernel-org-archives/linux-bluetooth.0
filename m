Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90C2C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Nov 2021 14:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94CDF61C15
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Nov 2021 14:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237196AbhKPOR7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Nov 2021 09:17:59 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:42415 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237277AbhKPORu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Nov 2021 09:17:50 -0500
Received: from smtpclient.apple (p4fefc15c.dip0.t-ipconnect.de [79.239.193.92])
        by mail.holtmann.org (Postfix) with ESMTPSA id 52147CECD7;
        Tue, 16 Nov 2021 15:14:52 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH 2/3] Bluetooth: hci_sync: Convert MGMT_OP_SET_CONNECTABLE
 to use cmd_sync
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211112004844.176271-2-luiz.dentz@gmail.com>
Date:   Tue, 16 Nov 2021 15:14:52 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <363382A3-EB00-4488-9AEE-38E23229BFED@holtmann.org>
References: <20211112004844.176271-1-luiz.dentz@gmail.com>
 <20211112004844.176271-2-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This makes MGMT_OP_SET_CONNEABLE use hci_cmd_sync_queue instead of
> use a dedicated connetable_update work.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  2 --
> include/net/bluetooth/hci_sync.h |  2 ++
> net/bluetooth/hci_request.c      | 43 --------------------------------
> net/bluetooth/hci_sync.c         | 31 +++++++++++++++++++++++
> net/bluetooth/mgmt.c             | 36 +++++++++++++-------------
> 5 files changed, 52 insertions(+), 62 deletions(-)

Patch has been applied to bluetooth-next tree.

Regards

Marcel

