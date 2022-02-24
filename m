Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1A6C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 20:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbiBXUIq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Feb 2022 15:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiBXUIp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Feb 2022 15:08:45 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD69B186473
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Feb 2022 12:08:14 -0800 (PST)
Received: from smtpclient.apple (p4fefc101.dip0.t-ipconnect.de [79.239.193.1])
        by mail.holtmann.org (Postfix) with ESMTPSA id 00381CED1A;
        Thu, 24 Feb 2022 21:08:13 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH v2] Bluetooth: hci_sync: Fix hci_update_accept_list_sync
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220224151147.119619-1-luiz.dentz@gmail.com>
Date:   Thu, 24 Feb 2022 21:08:13 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <46FADD2F-2B35-4CC7-BC01-CACB81FC6FAE@holtmann.org>
References: <20220224151147.119619-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> hci_update_accept_list_sync is returning the filter based on the error
> but that gets overwritten by hci_le_set_addr_resolution_enable_sync
> return instead of using the actual result of the likes of
> hci_le_add_accept_list_sync which was intended.
> 
> Fixes: ad383c2c65a5b ("Bluetooth: hci_sync: Enable advertising when LL privacy is enabled")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> v2: Use u8 filter_policy instead of int ret as variable to store the result.
> 
> net/bluetooth/hci_sync.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-stable tree.

Regards

Marcel

