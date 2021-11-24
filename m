Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FE4C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Nov 2021 14:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353653AbhKXOyd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Nov 2021 09:54:33 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:33197 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353715AbhKXOy1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Nov 2021 09:54:27 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id 56AD8CED24;
        Wed, 24 Nov 2021 15:51:12 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH] Bluetooth: HCI: Fix definition of
 bt_hci_rsp_read_stored_link_key
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211124021734.2769798-1-luiz.dentz@gmail.com>
Date:   Wed, 24 Nov 2021 15:51:11 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <41622024-3262-4E65-93D7-ADB3227FFAE3@holtmann.org>
References: <20211124021734.2769798-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> Both max_num_keys and num_key are 2 octects:
> 
> BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
> page 1985:
> 
>  Max_Num_Keys:
>  Size: 2 octets
>  Range: 0x0000 to 0xFFFF
> 
>  Num_Keys_Read:
>  Size: 2 octets
>  Range: 0x0000 to 0xFFFF
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/hci.h | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 84db6b275231..5f95de7367d5 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1047,8 +1047,8 @@ struct hci_cp_read_stored_link_key {
> } __packed;
> struct hci_rp_read_stored_link_key {
> 	__u8     status;
> -	__u8     max_keys;
> -	__u8     num_keys;
> +	__u16    max_keys;
> +	__u16    num_keys;
> } __packed;
> 
> #define HCI_OP_DELETE_STORED_LINK_KEY	0x0c12

I have no idea on how this could be wrong all these years. I added this back in 2015 :(

However, you also need to touch the user of it

       if (!rp->status && sent->read_all == 0x01) {
                hdev->stored_max_keys = rp->max_keys;
                hdev->stored_num_keys = rp->num_keys;
       }

Regards

Marcel

