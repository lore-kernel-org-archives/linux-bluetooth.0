Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B783C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 10:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65E4361B44
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 10:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhKSKFm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Nov 2021 05:05:42 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:53524 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhKSKFl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Nov 2021 05:05:41 -0500
Received: from smtpclient.apple (p4fefc15c.dip0.t-ipconnect.de [79.239.193.92])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7E3FCCED22;
        Fri, 19 Nov 2021 11:02:39 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH v2 2/2] Bluetooth: hci_sync: Set Privacy Mode when
 updating the resolving list
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211118231302.1000168-2-luiz.dentz@gmail.com>
Date:   Fri, 19 Nov 2021 11:02:39 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <7E27934B-018E-462D-8593-A873C0206A7D@holtmann.org>
References: <20211118231302.1000168-1-luiz.dentz@gmail.com>
 <20211118231302.1000168-2-luiz.dentz@gmail.com>
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
> index 84db6b275231..7444d286e6be 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1931,6 +1931,16 @@ struct hci_rp_le_read_transmit_power {
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
> index 42ba40df6e20..0b3de5411948 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -755,6 +755,7 @@ struct hci_conn_params {
> 
> 	struct hci_conn *conn;
> 	bool explicit_connect;
> +	u8  privacy_mode;
> 	u32 current_flags;
> };
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index efc5458b1345..51c88f4f1274 100644
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
> index ad86caf41f91..08acd664590b 100644
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

does this also account for the fact that LL Privacy is behind an experimental option. I think in the previous patch it is more important to check if LL Privacy is actually enabled via experimental setting.

Regards

Marcel

