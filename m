Return-Path: <SRS0=5F6V=MQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA7CC64EB8
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Oct 2018 20:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C245E20877
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Oct 2018 20:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C245E20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeJEDbd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Oct 2018 23:31:33 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:56480 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeJEDbd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Oct 2018 23:31:33 -0400
Received: from marcel-macbook.fritz.box (p4FEFC9BB.dip0.t-ipconnect.de [79.239.201.187])
        by mail.holtmann.org (Postfix) with ESMTPSA id 28B00CF365;
        Thu,  4 Oct 2018 22:43:53 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH 1/2] Bluetooth:LE credit based connection result values
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1538630987-4476-1-git-send-email-mallikarjun.phulari@intel.com>
Date:   Thu, 4 Oct 2018 22:36:33 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <50248530-719B-4E1A-B195-43228207C95F@holtmann.org>
References: <1538630987-4476-1-git-send-email-mallikarjun.phulari@intel.com>
To:     Mallikarjun Phulari <mallikarjun.phulari@intel.com>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Mallikarjun,

> Changes added to rename the l2cap connect/create result values.
> Result values specific to LE Credit based connection are renamed
> as L2CAP_CR_LE*, and changed the old names wherever they were used.
> 
> Signed-off-by: Mallikarjun Phulari <mallikarjun.phulari@intel.com>
> ---
> include/net/bluetooth/l2cap.h | 29 +++++++++++++++++------------
> net/bluetooth/l2cap_core.c    | 12 ++++++------
> 2 files changed, 23 insertions(+), 18 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 0697fd4..35788d9 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -270,19 +270,24 @@ struct l2cap_conn_rsp {
> #define L2CAP_CID_DYN_END	0xffff
> #define L2CAP_CID_LE_DYN_END	0x007f
> 
> +/* Renaming the result values specific to
> + * LE Credit based connection as L2CAP_CR_LE_*,
> + * And changing the old result value wherever they were used
> + */

why is this a comment?

> +
> /* connect/create channel results */
> -#define L2CAP_CR_SUCCESS	0x0000
> -#define L2CAP_CR_PEND		0x0001
> -#define L2CAP_CR_BAD_PSM	0x0002
> -#define L2CAP_CR_SEC_BLOCK	0x0003
> -#define L2CAP_CR_NO_MEM		0x0004
> -#define L2CAP_CR_BAD_AMP	0x0005
> -#define L2CAP_CR_AUTHENTICATION	0x0005
> -#define L2CAP_CR_AUTHORIZATION	0x0006
> -#define L2CAP_CR_BAD_KEY_SIZE	0x0007
> -#define L2CAP_CR_ENCRYPTION	0x0008
> -#define L2CAP_CR_INVALID_SCID	0x0009
> -#define L2CAP_CR_SCID_IN_USE	0x000A
> +#define L2CAP_CR_SUCCESS		0x0000
> +#define L2CAP_CR_PEND			0x0001
> +#define L2CAP_CR_BAD_PSM		0x0002
> +#define L2CAP_CR_SEC_BLOCK		0x0003
> +#define L2CAP_CR_NO_MEM			0x0004
> +#define L2CAP_CR_BAD_AMP		0x0005

Keep the original BR/EDR in a separate block. So an empty line here and no need to realign them.

Then create this a block and add comment /* credit based connect results */

And it needs the following:

L2CAP_CR_LE_SUCCESS	0x0000
L2CAP_CR_LE_BAD_PSM	0x0001
L2CAP_CR_LE_NO_MEM	0x0004

And they need to be used for the LE side instead of the BR/EDR ones.

> +#define L2CAP_CR_LE_AUTHENTICATION	0x0005
> +#define L2CAP_CR_LE_AUTHORIZATION	0x0006
> +#define L2CAP_CR_LE_BAD_KEY_SIZE	0x0007
> +#define L2CAP_CR_LE_ENCRYPTION		0x0008
> +#define L2CAP_CR_LE_INVALID_SCID	0x0009
> +#define L2CAP_CR_LE_SCID_IN_USE		0x000A

Regards

Marcel

