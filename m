Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1F2C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 06:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9821E60FDC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 06:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhJMGhQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Oct 2021 02:37:16 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:56895 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237867AbhJMGhP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Oct 2021 02:37:15 -0400
Received: from smtpclient.apple (p4ff9f2d2.dip0.t-ipconnect.de [79.249.242.210])
        by mail.holtmann.org (Postfix) with ESMTPSA id C90F7CECF3;
        Wed, 13 Oct 2021 08:35:06 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v2 1/4] Bluetooth: Only allow setting msft_opcode at setup
 stage
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211013003055.2664728-1-luiz.dentz@gmail.com>
Date:   Wed, 13 Oct 2021 08:35:06 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <3AF15FB4-3BE9-4758-9782-C1935A0F8B3D@holtmann.org>
References: <20211013003055.2664728-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> The msft_opcode shall only be changed while at the setup stage otherwise
> it can possible cause problems where different opcodes are used while
> running.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> v2: Fix typos: s/extention/extension/g
> 
> include/net/bluetooth/hci_core.h | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index dd8840e70e25..eb5d4ea88c3a 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1272,11 +1272,15 @@ int hci_recv_diag(struct hci_dev *hdev, struct sk_buff *skb);
> __printf(2, 3) void hci_set_hw_info(struct hci_dev *hdev, const char *fmt, ...);
> __printf(2, 3) void hci_set_fw_info(struct hci_dev *hdev, const char *fmt, ...);
> 
> -static inline void hci_set_msft_opcode(struct hci_dev *hdev, __u16 opcode)
> +static inline int hci_set_msft_opcode(struct hci_dev *hdev, __u16 opcode)
> {
> +	if (!hci_dev_test_flag(hdev, HCI_SETUP))
> +		return -EPERM;
> +
> #if IS_ENABLED(CONFIG_BT_MSFTEXT)
> 	hdev->msft_opcode = opcode;
> #endif
> +	return 0;
> }

this is also not going to work since some driver might set it in their probe() routine before calling hci_register_dev.

Regards

Marcel

