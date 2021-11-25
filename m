Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D60C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Nov 2021 20:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356961AbhKYUMS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Nov 2021 15:12:18 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:54382 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244538AbhKYUKR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Nov 2021 15:10:17 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id 84FF7CECC7;
        Thu, 25 Nov 2021 21:07:04 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH v2 2/2] Bluetooth: HCI: Fix definition of
 hci_rp_delete_stored_link_key
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211125001613.3274241-2-luiz.dentz@gmail.com>
Date:   Thu, 25 Nov 2021 21:07:04 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <727C868F-FA26-4A77-ACBE-10A7E22E66F9@holtmann.org>
References: <20211125001613.3274241-1-luiz.dentz@gmail.com>
 <20211125001613.3274241-2-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> num_keys is actually 2 octects not 1:
> 
> BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
> page 1989:
> 
>  Num_Keys_Deleted:
>  Size: 2 octets
>  0xXXXX	Number of Link Keys Deleted
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/hci.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree. However I also had to fix the user of this struct.

Regards

Marcel

