Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41A8C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Oct 2021 16:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BBCD6138D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Oct 2021 16:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhJUQmQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Oct 2021 12:42:16 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:36118 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhJUQmQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Oct 2021 12:42:16 -0400
Received: from smtpclient.apple (p54899aa7.dip0.t-ipconnect.de [84.137.154.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id E01B0CECEA;
        Thu, 21 Oct 2021 18:39:58 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] Bluetooth: vhci: Fix checking of msft_opcode
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211020183453.324777-1-luiz.dentz@gmail.com>
Date:   Thu, 21 Oct 2021 18:39:58 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <0AC1C0DE-2748-47E1-91D2-10C7A089B183@holtmann.org>
References: <20211020183453.324777-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> msft_opcode shall be use a vendor ogf (0x3f) but the check was
> swifting the bits in the wrong order due to a missing parantesis
> over val & 0xffff, but since the code already checks for values over
> 0xffff it shall not be necessary to perform that operation it now just
> removes which makes it work properly when setting opcodes like 0xfce1.

please add Fixes: tag here.

> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> drivers/bluetooth/hci_vhci.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> index 9cb7c8fafbf9..0eb90e7c3c82 100644
> --- a/drivers/bluetooth/hci_vhci.c
> +++ b/drivers/bluetooth/hci_vhci.c
> @@ -200,7 +200,7 @@ static int msft_opcode_set(void *data, u64 val)
> {
> 	struct vhci_data *vhci = data;
> 
> -	if (val > 0xffff || (val & 0xffff >> 10) != 0x3f)
> +	if (val > 0xffff || (val >> 10) != 0x3f)

Then lets use hci_opcode_ogf(val) != 0x3f.

Regards

Marcel

