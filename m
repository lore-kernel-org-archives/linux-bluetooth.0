Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485F2C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Dec 2021 19:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348595AbhLFTmI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Dec 2021 14:42:08 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:42823 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348597AbhLFTmH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Dec 2021 14:42:07 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id 86286CECF9;
        Mon,  6 Dec 2021 20:38:37 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH] Bluetooth: msft: Fix compilation when CONFIG_BT_MSFTEXT
 is not set
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211206192701.3146782-1-luiz.dentz@gmail.com>
Date:   Mon, 6 Dec 2021 20:38:37 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <3E90FD3A-2002-4706-AFC9-B33C4028D3BE@holtmann.org>
References: <20211206192701.3146782-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This fixes compilation when CONFIG_BT_MSFTEXT is not set.
> 
> Fixes: 6b3d4c8fcf3f2 ("Bluetooth: hci_event: Use of a function table to handle HCI events")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/msft.h | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

