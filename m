Return-Path: <SRS0=HCMd=3D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07099C33C9E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 18:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16752465A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 18:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgANSk5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jan 2020 13:40:57 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:43191 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANSk5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jan 2020 13:40:57 -0500
Received: from marcel-macpro.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id D245CCECE2;
        Tue, 14 Jan 2020 19:50:13 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH v2] Bleutooth: Add definitions for LE Read Tx Power
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1578592151-9220-1-git-send-email-ankit.p.navik@intel.com>
Date:   Tue, 14 Jan 2020 19:40:55 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <227F4801-990E-4C12-9E0D-A3CFD807F8CB@holtmann.org>
References: <1578592151-9220-1-git-send-email-ankit.p.navik@intel.com>
To:     Ankit Navik <ankit.p.navik@intel.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ankit,

> Add the definitions for LE read transmit power HCI commands to
> read the minimum and maximum Tx power.
> 
> Signed-off-by: Ankit Navik <ankit.p.navik@intel.com>
> ---
> include/net/bluetooth/hci.h      |  7 +++++++
> include/net/bluetooth/hci_core.h |  3 +++
> net/bluetooth/hci_event.c        | 17 +++++++++++++++++
> 3 files changed, 27 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 07b6ece..eccb6b2 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1718,6 +1718,13 @@ struct hci_cp_le_set_adv_set_rand_addr {
> 	bdaddr_t  bdaddr;
> } __packed;
> 
> +#define HCI_OP_LE_READ_TX_POWER		0x204b
> +struct hci_rp_le_read_tx_power {
> +	__u8 status;
> +	__s8 min_tx_power;
> +	__s8 max_tx_power;
> +} __packed;
> +
> /* ---- HCI Events ---- */
> #define HCI_EV_INQUIRY_COMPLETE		0x01
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index faebe38..f3d389d 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -418,6 +418,9 @@ struct hci_dev {
> 	__u8			scan_rsp_data[HCI_MAX_AD_LENGTH];
> 	__u8			scan_rsp_data_len;
> 
> +	__s8			le_min_tx_power;
> +	__s8			le_max_tx_power;
> +
> 	struct list_head	adv_instances;
> 	unsigned int		adv_instance_cnt;
> 	__u8			cur_adv_instance;
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 6ddc4a7..3646f77 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -988,6 +988,19 @@ static void hci_cc_le_read_adv_tx_power(struct hci_dev *hdev,
> 	hdev->adv_tx_power = rp->tx_power;
> }
> 
> +static void hci_cc_le_read_tx_power(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +	struct hci_rp_le_read_tx_power *rp = (void *) skb->data;
> +
> +	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
> +
> +	if (rp->status)
> +		return;
> +
> +	hdev->le_min_tx_power = rp->min_tx_power;
> +	hdev->le_max_tx_power = rp->max_tx_power;
> +}
> +
> static void hci_cc_user_confirm_reply(struct hci_dev *hdev, struct sk_buff *skb)
> {
> 	struct hci_rp_user_confirm_reply *rp = (void *) skb->data;
> @@ -3414,6 +3427,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
> 		hci_cc_le_read_max_data_len(hdev, skb);
> 		break;
> 
> +	case HCI_OP_LE_READ_TX_POWER:
> +		hci_cc_le_read_tx_power(hdev, skb);
> +		break;
> +
> 	case HCI_OP_WRITE_LE_HOST_SUPPORTED:
> 		hci_cc_write_le_host_supported(hdev, skb);
> 		break;

by itself this addition is useless. You also need to send the HCI_OP_LE_READ_TX_POWER during the power on of the controller. Please add that part.

And on the controller creation you need to the default le_{min,max}_tx_power fields to invalid.

Regards

Marcel

