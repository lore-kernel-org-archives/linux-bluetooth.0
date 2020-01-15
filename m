Return-Path: <SRS0=uqsz=3E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6EAC32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 21:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0618A2081E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 21:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbgAOV0q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:26:46 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:53926 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgAOV0q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 16:26:46 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8F245CECF2;
        Wed, 15 Jan 2020 22:36:02 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH v5 05/11] Bluetooth: L2CAP: Rename FLAG_LE_CONN_REQ_SENT
 to FLAG_LE_FLOWCTL_CONN_REQ_SENT
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200115210221.13096-6-luiz.dentz@gmail.com>
Date:   Wed, 15 Jan 2020 22:26:44 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <E5494622-6FE0-4ED8-800A-79C1AD49EDD7@holtmann.org>
References: <20200115210221.13096-1-luiz.dentz@gmail.com>
 <20200115210221.13096-6-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This renames FLAG_LE_CONN_REQ_SENT to FLAG_LE_FLOWCTL_CONN_REQ_SENT so
> it is consistent with the naming scheme used for enhanced flow control.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/l2cap.h | 2 +-
> net/bluetooth/l2cap_core.c    | 4 ++--
> 2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index d81ed537984f..3b323c54dd0c 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -765,7 +765,7 @@ enum {
> 	FLAG_EXT_CTRL,
> 	FLAG_EFS_ENABLE,
> 	FLAG_DEFER_SETUP,
> -	FLAG_LE_CONN_REQ_SENT,
> +	FLAG_LE_FLOWCTL_CONN_REQ_SENT,
> 	FLAG_EXT_FLOWCTL_CONN_REQ_SENT,

Lets scrap this patch. I was mistaken earlier. This makes it worse. We keep using ECRED internally.

Regards

Marcel

