Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD76C433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Apr 2021 12:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 535C561466
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Apr 2021 12:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhDWM2z convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Apr 2021 08:28:55 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:36439 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbhDWM2y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Apr 2021 08:28:54 -0400
Received: from marcel-macbook.holtmann.net (p4fefc624.dip0.t-ipconnect.de [79.239.198.36])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1038FCED00;
        Fri, 23 Apr 2021 14:36:03 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v2 03/10] Bluetooth: HCI: Use skb_pull to parse Number of
 Complete Packets event
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210419171257.3865181-4-luiz.dentz@gmail.com>
Date:   Fri, 23 Apr 2021 14:28:15 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <B75F4786-E810-4D29-AD5C-8BA33A10EB48@holtmann.org>
References: <20210419171257.3865181-1-luiz.dentz@gmail.com>
 <20210419171257.3865181-4-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This uses skb_pull to check the Number of Complete Packets events
> received have the minimum required length.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/hci.h |  2 +-
> net/bluetooth/hci_event.c   | 20 +++++++++++---------
> 2 files changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index f1f505355e81..9251ae3a2ce0 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -2021,7 +2021,7 @@ struct hci_comp_pkts_info {
> } __packed;
> 
> struct hci_ev_num_comp_pkts {
> -	__u8     num_hndl;
> +	__u8     num;
> 	struct hci_comp_pkts_info handles[];
> } __packed;
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index cc2d68389edc..c353dfafb04c 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -4264,23 +4264,25 @@ static void hci_role_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
> 
> static void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *skb)
> {
> -	struct hci_ev_num_comp_pkts *ev = (void *) skb->data;
> +	struct hci_ev_num_comp_pkts *ev;
> 	int i;
> 
> -	if (hdev->flow_ctl_mode != HCI_FLOW_CTL_MODE_PACKET_BASED) {
> -		bt_dev_err(hdev, "wrong event for mode %d", hdev->flow_ctl_mode);
> +	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_NUM_COMP_PKTS, sizeof(*ev));
> +	if (!ev)
> 		return;
> -	}
> 
> -	if (skb->len < sizeof(*ev) ||
> -	    skb->len < struct_size(ev, handles, ev->num_hndl)) {
> -		BT_DBG("%s bad parameters", hdev->name);
> +	if (!hci_ev_skb_pull(hdev, skb, HCI_EV_NUM_COMP_PKTS,
> +			     flex_array_size(ev, handles, ev->num)))
> +		return;
> +
> +	if (hdev->flow_ctl_mode != HCI_FLOW_CTL_MODE_PACKET_BASED) {
> +		bt_dev_err(hdev, "wrong event for mode %d", hdev->flow_ctl_mode);
> 		return;
> 	}
> 
> -	BT_DBG("%s num_hndl %d", hdev->name, ev->num_hndl);
> +	BT_DBG("%s num %d", hdev->name, ev->num);

If you are touching BT_DBG anyway then switch to bt_dev_dbg() please.

Regards

Marcel

