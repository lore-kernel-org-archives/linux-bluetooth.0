Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171DFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Oct 2021 20:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E56B861AA4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Oct 2021 20:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355258AbhJAUfE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Oct 2021 16:35:04 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:46521 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbhJAUfD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Oct 2021 16:35:03 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 06E97CED35;
        Fri,  1 Oct 2021 22:33:16 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] Bluetooth: Rename driver .prevent_wake to .wakeup
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211001202231.3599199-1-luiz.dentz@gmail.com>
Date:   Fri, 1 Oct 2021 22:33:15 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <F375A24B-C6F1-4AFF-968A-DD2E896F01E9@holtmann.org>
References: <20211001202231.3599199-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> prevent_wake logic is backward since what it is really checking is
> if the device may wakeup the system or not, not that it will prevent
> the to be awaken.
> 
> Also looking on how other subsystems have the entry as power/wakeup
> this also renames the force_prevent_wake to force_wakeup in vhci driver.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> drivers/bluetooth/btusb.c        |  4 ++--
> drivers/bluetooth/hci_vhci.c     | 32 ++++++++++++++++----------------
> include/net/bluetooth/hci_core.h |  2 +-
> net/bluetooth/hci_core.c         | 13 +++++++------
> 4 files changed, 26 insertions(+), 25 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

