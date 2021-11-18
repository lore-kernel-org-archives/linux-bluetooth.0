Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CE6C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Nov 2021 04:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E69C861AA5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Nov 2021 04:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242115AbhKREtn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Nov 2021 23:49:43 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:59215 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240916AbhKREtl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Nov 2021 23:49:41 -0500
Received: from smtpclient.apple (p4fefc15c.dip0.t-ipconnect.de [79.239.193.92])
        by mail.holtmann.org (Postfix) with ESMTPSA id EEBA6CED01;
        Thu, 18 Nov 2021 05:46:40 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH v2 2/2] Bluetooth: hci_sync: Set Privacy Mode when
 updating the resolving list
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211105222739.461398-2-luiz.dentz@gmail.com>
Date:   Thu, 18 Nov 2021 05:46:40 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <2837B8C6-392C-4CA5-9DF3-6EC81DE207F9@holtmann.org>
References: <20211105222739.461398-1-luiz.dentz@gmail.com>
 <20211105222739.461398-2-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This adds support for Set Privacy Mode when updating the resolving list
> when HCI_CONN_FLAG_DEVICE_PRIVACY so the controller shall use Device
> Mode for devices programmed in the resolving list, Device Mode is
> actually required when the remote device are not able to use RPA as
> otherwise the default mode is Network Privacy Mode in which only
> allows RPAs thus the controller would filter out advertisement using
> identity addresses for which there is an IRK.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/hci.h      | 10 ++++++
> include/net/bluetooth/hci_core.h |  1 +
> net/bluetooth/hci_event.c        | 29 +++++++++++++++++
> net/bluetooth/hci_sync.c         | 53 ++++++++++++++++++++++++++++----
> 4 files changed, 87 insertions(+), 6 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 63065bc01b76..979da5179ff4 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1930,6 +1930,16 @@ struct hci_rp_le_read_transmit_power {
> 	__s8  max_le_tx_power;
> } __packed;
> 
> +#define HCI_NETWORK_PRIVACY		0x00
> +#define HCI_DEVICE_PRIVACY		0x01
> +
> +#define HCI_OP_LE_SET_PRIVACY_MODE	0x204e
> +struct hci_cp_le_set_privacy_mode {
> +	__u8  bdaddr_type;
> +	bdaddr_t  bdaddr;
> +	__u8  mode;
> +} __packed;
> +
> #define HCI_OP_LE_READ_BUFFER_SIZE_V2	0x2060
> struct hci_rp_le_read_buffer_size_v2 {
> 	__u8    status;
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 07d2d099dc2a..cb5684da3ed4 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -758,6 +758,7 @@ struct hci_conn_params {
> 
> 	struct hci_conn *conn;
> 	bool explicit_connect;
> +	uint8_t privacy_mode;

actually u8 please.

> 	u32 current_flags;
> };
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index d4b75a6cfeee..9cadc543abcb 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1300,6 +1300,31 @@ static void hci_cc_le_read_transmit_power(struct hci_dev *hdev,
> 	hdev->max_le_tx_power = rp->max_le_tx_power;
> }
> 
> +static void hci_cc_le_set_privacy_mode(struct hci_dev *hdev,
> +				       struct sk_buff *skb)
> +{
> +	__u8 status = *((__u8 *)skb->data);
> +	struct hci_cp_le_set_privacy_mode *cp;
> +	struct hci_conn_params *params;
> +
> +	bt_dev_dbg(hdev, "status 0x%2.2x", status);
> +
> +	if (status)
> +		return;
> +
> +	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_PRIVACY_MODE);
> +	if (!cp)
> +		return;
> +
> +	hci_dev_lock(hdev);
> +
> +	params = hci_conn_params_lookup(hdev, &cp->bdaddr, cp->bdaddr_type);
> +	if (params)
> +		params->privacy_mode = cp->mode;
> +
> +	hci_dev_unlock(hdev);
> +}
> +
> static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
> {
> 	__u8 *sent, status = *((__u8 *) skb->data);
> @@ -3812,6 +3837,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
> 		hci_cc_le_read_transmit_power(hdev, skb);
> 		break;
> 
> +	case HCI_OP_LE_SET_PRIVACY_MODE:
> +		hci_cc_le_set_privacy_mode(hdev, skb);
> +		break;
> +
> 	default:
> 		BT_DBG("%s opcode 0x%4.4x", hdev->name, *opcode);
> 		break;
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index b794605dc882..32ed7da3b6dd 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -1580,8 +1580,42 @@ static int hci_le_add_resolve_list_sync(struct hci_dev *hdev,
> 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> }
> 
> +/* Set Device Privacy Mode. */
> +static int hci_le_set_privacy_mode_sync(struct hci_dev *hdev,
> +					struct hci_conn_params *params)
> +{
> +	struct hci_cp_le_set_privacy_mode cp;
> +	struct smp_irk *irk;
> +
> +	/* If device privacy mode has already been set there is nothing to do */
> +	if (params->privacy_mode == HCI_DEVICE_PRIVACY)
> +		return 0;
> +
> +	/* Set Privacy Mode requires the use of resolving list (aka. LL Privacy)
> +	 * by default Network Mode is used so only really send the command if
> +	 * Device Mode is required (HCI_CONN_FLAG_DEVICE_PRIVACY).
> +	 */
> +	if (!privacy_mode_capable(hdev) ||
> +	    !hci_conn_test_flag(HCI_CONN_FLAG_DEVICE_PRIVACY,
> +				params->current_flags))
> +		return 0;
> +
> +	irk = hci_find_irk_by_addr(hdev, &params->addr, params->addr_type);
> +	if (!irk)
> +		return 0;
> +
> +	memset(&cp, 0, sizeof(cp));
> +	cp.bdaddr_type = irk->addr_type;
> +	bacpy(&cp.bdaddr, &irk->bdaddr);
> +	cp.mode = HCI_DEVICE_PRIVACY;
> +
> +	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_PRIVACY_MODE,
> +				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> +}
> +
> /* Adds connection to allow list if needed, if the device uses RPA (has IRK)
> - * this attempts to program the device in the resolving list as well.
> + * this attempts to program the device in the resolving list as well and
> + * properly set the privacy mode.
>  */
> static int hci_le_add_accept_list_sync(struct hci_dev *hdev,
> 				       struct hci_conn_params *params,
> @@ -1590,11 +1624,6 @@ static int hci_le_add_accept_list_sync(struct hci_dev *hdev,
> 	struct hci_cp_le_add_to_accept_list cp;
> 	int err;
> 
> -	/* Already in accept list */
> -	if (hci_bdaddr_list_lookup(&hdev->le_accept_list, &params->addr,
> -				   params->addr_type))
> -		return 0;
> -
> 	/* Select filter policy to accept all advertising */
> 	if (*num_entries >= hdev->le_accept_list_size)
> 		return -ENOSPC;
> @@ -1620,6 +1649,18 @@ static int hci_le_add_accept_list_sync(struct hci_dev *hdev,
> 		return err;
> 	}
> 
> +	/* Set Privacy Mode */
> +	err = hci_le_set_privacy_mode_sync(hdev, params);
> +	if (err) {
> +		bt_dev_err(hdev, "Unable to set privacy mode: %d", err);
> +		return err;
> +	}
> +
> +	/* Check if already in accept list */
> +	if (hci_bdaddr_list_lookup(&hdev->le_accept_list, &params->addr,
> +				   params->addr_type))
> +		return 0;
> +
> 	*num_entries += 1;
> 	cp.bdaddr_type = params->addr_type;
> 	bacpy(&cp.bdaddr, &params->addr);

Regards

Marcel

