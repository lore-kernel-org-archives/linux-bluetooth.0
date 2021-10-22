Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733E5C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Oct 2021 04:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C8C86056B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Oct 2021 04:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhJVEt2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Oct 2021 00:49:28 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48159 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbhJVEt0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Oct 2021 00:49:26 -0400
Received: from smtpclient.apple (p54899aa7.dip0.t-ipconnect.de [84.137.154.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 56327CED3E;
        Fri, 22 Oct 2021 06:47:07 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] Bluetooth: vhci: Fix checking of msft_opcode
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211021184435.614575-1-luiz.dentz@gmail.com>
Date:   Fri, 22 Oct 2021 06:47:06 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <094AD64A-3011-431C-8F31-5E1332DF7BA6@holtmann.org>
References: <20211021184435.614575-1-luiz.dentz@gmail.com>
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
> 
> Fixes: b8f5482c9638 ("Bluetooth: vhci: Add support for setting msft_opcode and aosp_capable")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> drivers/bluetooth/hci_vhci.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

