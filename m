Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3005DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 10:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3E0D61B1E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 10:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhKSKEE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Nov 2021 05:04:04 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:40478 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhKSKEE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Nov 2021 05:04:04 -0500
Received: from smtpclient.apple (p4fefc15c.dip0.t-ipconnect.de [79.239.193.92])
        by mail.holtmann.org (Postfix) with ESMTPSA id 13197CED22;
        Fri, 19 Nov 2021 11:01:02 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH v2 1/2] Bluetooth: Introduce HCI_CONN_FLAG_DEVICE_PRIVACY
 device flag
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211118231302.1000168-1-luiz.dentz@gmail.com>
Date:   Fri, 19 Nov 2021 11:01:01 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <BA3F20E5-3D85-4513-ADB2-B2F03163A1C6@holtmann.org>
References: <20211118231302.1000168-1-luiz.dentz@gmail.com>
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
> v2: Fix supported flags not actually checking if the hdev really
> supports the flags.
> 
> include/net/bluetooth/hci_core.h |  4 ++++
> net/bluetooth/mgmt.c             | 30 ++++++++++++++++++++++++++----
> 2 files changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 2560cfe80db8..42ba40df6e20 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -160,6 +160,7 @@ struct bdaddr_list_with_flags {
> 
> enum hci_conn_flags {
> 	HCI_CONN_FLAG_REMOTE_WAKEUP,
> +	HCI_CONN_FLAG_DEVICE_PRIVACY,
> 	HCI_CONN_FLAG_MAX
> };
> 
> @@ -1465,6 +1466,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
> #define use_ll_privacy(dev) (ll_privacy_capable(dev) && \
> 			     hci_dev_test_flag(dev, HCI_ENABLE_LL_PRIVACY))
> 
> +#define privacy_mode_capable(dev) (use_ll_privacy(dev) && \
> +				   (hdev->commands[39] & 0x04))
> +
> /* Use enhanced synchronous connection if command is supported */
> #define enhanced_sco_capable(dev) ((dev)->commands[29] & 0x08)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index f8f74d344297..d82d1a62754a 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -4349,7 +4349,22 @@ static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
> 			       MGMT_STATUS_NOT_SUPPORTED);
> }
> 
> -#define SUPPORTED_DEVICE_FLAGS() ((1U << HCI_CONN_FLAG_MAX) - 1)
> +static u32 supported_device_flags(struct hci_dev *hdev)
> +{
> +	u32 flags = 0;
> +
> +	/* Check if adapter can wakeup the system */
> +	if (hdev->wakeup && hdev->wakeup(hdev))
> +		flags |= BIT(HCI_CONN_FLAG_REMOTE_WAKEUP);

I would do this change as a separate patch since it has nothing to do with the device privacy setting.

Do we have to call hdev->wakeup() as well here? Isn’t the existence of the callback enough indication.

That also said, doesn’t it make sense to store the supported_flags in the device params struct. It would make it certainly easy to return. Potentially we have a few calls to Get Device Flags and its notifications that have to rebuild this flags field over and over again.

Regards

Marcel

