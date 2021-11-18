Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DEDC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Nov 2021 04:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4005E61AA5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Nov 2021 04:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242057AbhKREsc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Nov 2021 23:48:32 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:60250 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240916AbhKREsa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Nov 2021 23:48:30 -0500
Received: from smtpclient.apple (p4fefc15c.dip0.t-ipconnect.de [79.239.193.92])
        by mail.holtmann.org (Postfix) with ESMTPSA id ED87DCED01;
        Thu, 18 Nov 2021 05:45:29 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH v2 1/2] Bluetooth: Introduce HCI_CONN_FLAG_DEVICE_PRIVACY
 device flag
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211105222739.461398-1-luiz.dentz@gmail.com>
Date:   Thu, 18 Nov 2021 05:45:29 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <411F0489-163E-4809-B20F-282311A5BC36@holtmann.org>
References: <20211105222739.461398-1-luiz.dentz@gmail.com>
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
> v2: Fix marking Device Privacy Flag even when adapter is not capable of
> handling Set Privacy Mode.
> 
> include/net/bluetooth/hci_core.h |  4 ++++
> net/bluetooth/mgmt.c             | 24 ++++++++++++++++++++----
> 2 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index b5f061882c10..07d2d099dc2a 100644
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
> @@ -1468,6 +1469,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
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
> index 06384d761928..8a8376d32be3 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -4350,7 +4350,16 @@ static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
> 			       MGMT_STATUS_NOT_SUPPORTED);
> }
> 
> -#define SUPPORTED_DEVICE_FLAGS() ((1U << HCI_CONN_FLAG_MAX) - 1)
> +static u32 supported_device_flags(struct hci_dev *hdev)
> +{
> +	u32 flags = BIT(HCI_CONN_FLAG_MAX) - 1;
> +
> +	/* Check if Privacy Mode can be set */
> +	if (!privacy_mode_capable(hdev))
> +		flags &= ~BIT(HCI_CONN_FLAG_DEVICE_PRIVACY);
> +
> +	return flags;
> +}

I am lost on what we are doing, I know that SUPPORTED_DEVICE_FLAGS was introduced by 4c54bf2b093bb from Abhishek, but I fail to reason now why it is correct.

If we really set all bits on the supported device flags, then that is a bug. Or is it too early for me to grok this code?

> 
> static int get_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
> 			    u16 data_len)
> @@ -4359,7 +4368,7 @@ static int get_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
> 	struct mgmt_rp_get_device_flags rp;
> 	struct bdaddr_list_with_flags *br_params;
> 	struct hci_conn_params *params;
> -	u32 supported_flags = SUPPORTED_DEVICE_FLAGS();
> +	u32 supported_flags = supported_device_flags(hdev);
> 	u32 current_flags = 0;
> 	u8 status = MGMT_STATUS_INVALID_PARAMS;
> 
> @@ -4423,7 +4432,7 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
> 	struct bdaddr_list_with_flags *br_params;
> 	struct hci_conn_params *params;
> 	u8 status = MGMT_STATUS_INVALID_PARAMS;
> -	u32 supported_flags = SUPPORTED_DEVICE_FLAGS();
> +	u32 supported_flags = supported_device_flags(hdev);
> 	u32 current_flags = __le32_to_cpu(cp->current_flags);
> 
> 	bt_dev_dbg(hdev, "Set device flags %pMR (type 0x%x) = 0x%x",
> @@ -4456,6 +4465,13 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
> 		if (params) {
> 			params->current_flags = current_flags;
> 			status = MGMT_STATUS_SUCCESS;
> +
> +			/* Update passive scan if HCI_CONN_FLAG_DEVICE_PRIVACY
> +			 * has been set.
> +			 */
> +			if (hci_conn_test_flag(HCI_CONN_FLAG_DEVICE_PRIVACY,
> +					       params->current_flags))
> +				hci_update_passive_scan(hdev);
> 		} else {
> 			bt_dev_warn(hdev, "No such LE device %pMR (0x%x)",
> 				    &cp->addr.bdaddr,
> @@ -7061,7 +7077,7 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
> added:
> 	device_added(sk, hdev, &cp->addr.bdaddr, cp->addr.type, cp->action);
> 	device_flags_changed(NULL, hdev, &cp->addr.bdaddr, cp->addr.type,
> -			     SUPPORTED_DEVICE_FLAGS(), current_flags);
> +			     supported_device_flags(hdev), current_flags);

Regards

Marcel

