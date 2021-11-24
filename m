Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24353C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Nov 2021 15:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbhKXPaf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Nov 2021 10:30:35 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:37510 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbhKXPae (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Nov 2021 10:30:34 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8612BCED24;
        Wed, 24 Nov 2021 16:27:23 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH v3 3/4] Bluetooth: Introduce HCI_CONN_FLAG_DEVICE_PRIVACY
 device flag
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211120012448.1476960-3-luiz.dentz@gmail.com>
Date:   Wed, 24 Nov 2021 16:27:23 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <0B2956DC-56B1-43A2-BB4A-CF42ABFC9C30@holtmann.org>
References: <20211120012448.1476960-1-luiz.dentz@gmail.com>
 <20211120012448.1476960-3-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This introduces HCI_CONN_FLAG_DEVICE_PRIVACY which can be used by
> userspace to indicate to the controller to use Device Privacy Mode to a
> specific device.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  1 +
> net/bluetooth/mgmt.c             | 12 ++++++++++++
> 2 files changed, 13 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index fc93a1907c90..9c94d1c49b25 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -153,6 +153,7 @@ struct bdaddr_list_with_irk {
> 
> enum hci_conn_flags {
> 	HCI_CONN_FLAG_REMOTE_WAKEUP,
> +	HCI_CONN_FLAG_DEVICE_PRIVACY,

coming this now, I wonder if we better call them FLAG_REMOTE_WAKEUP_SUPPORT and FLAG_DEVICE_PRIVACY_SUPPORT. If I am not mistaken, then these are for indicating support for it.

Regards

Marcel

