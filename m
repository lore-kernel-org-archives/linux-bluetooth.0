Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC921C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Oct 2021 20:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B45061361
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Oct 2021 20:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbhJBUyQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 2 Oct 2021 16:54:16 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:60191 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhJBUyQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 2 Oct 2021 16:54:16 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 96C5ECECD0;
        Sat,  2 Oct 2021 22:52:26 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [RFC PATCH] Bluetooth: hci_vhci: Fix to set force_wakeup value
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211002182109.165456-1-hj.tedd.an@gmail.com>
Date:   Sat, 2 Oct 2021 22:52:26 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Tedd Ho-Jeong An <tedd.an@intel.com>
Content-Transfer-Encoding: 7bit
Message-Id: <86E45D71-62B4-4ED0-A31A-FB021D86F9B3@holtmann.org>
References: <20211002182109.165456-1-hj.tedd.an@gmail.com>
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

> This patch sets the wakeup value in the vhci driver data after reading
> the value.
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
> drivers/bluetooth/hci_vhci.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> index b45db0db347c..5fd91106e853 100644
> --- a/drivers/bluetooth/hci_vhci.c
> +++ b/drivers/bluetooth/hci_vhci.c
> @@ -176,6 +176,8 @@ static ssize_t force_wakeup_write(struct file *file,
> 	if (data->wakeup == enable)
> 		return -EALREADY;
> 
> +	data->wakeup = enable;
> +
> 	return count;

patch looks good, but the commit message is confusing.

Regards

Marcel

