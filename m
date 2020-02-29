Return-Path: <SRS0=KJgL=4R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A363C3F2D7
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Feb 2020 07:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF3224697
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Feb 2020 07:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgB2HOz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Feb 2020 02:14:55 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:34044 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgB2HOz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Feb 2020 02:14:55 -0500
Received: from marcel-macpro.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id D2995CED04;
        Sat, 29 Feb 2020 08:24:20 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH v1] bluetooth: guard against controllers sending zero'd
 events
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200228205146.161229-1-alainm@chromium.org>
Date:   Sat, 29 Feb 2020 08:14:54 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <788439D3-E0CC-4CBA-99C2-0B9C3703B23D@holtmann.org>
References: <20200228205146.161229-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> Some controllers have been observed to send zero'd events under some
> conditions.  This change guards against this condition as well as adding
> a trace to facilitate diagnosability of this condition.

can you include a trace for this as well please.

> 
> Signed-off-by: Alain Michaud <alainm@chromium.org>
> ---
> 
> net/bluetooth/hci_event.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 591e7477e925..f865eddb8d69 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -5868,7 +5868,8 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
> 	u8 status = 0, event = hdr->evt, req_evt = 0;
> 	u16 opcode = HCI_OP_NOP;
> 
> -	if (hdev->sent_cmd && bt_cb(hdev->sent_cmd)->hci.req_event == event) {
> +	if (hdev->sent_cmd && event &&
> +	    bt_cb(hdev->sent_cmd)->hci.req_event == event) {

Why are you bothering to check for event here. Do we have requests set with hci_req.event == 0?

> 		struct hci_command_hdr *cmd_hdr = (void *) hdev->sent_cmd->data;
> 		opcode = __le16_to_cpu(cmd_hdr->opcode);
> 		hci_req_cmd_complete(hdev, opcode, status, &req_complete,
> @@ -5876,6 +5877,9 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
> 		req_evt = event;
> 	}
> 
> +	if (!event)
> +		BT_ERR("Received unexpected HCI Event 00000000");
> +

We need to start using bt_dev_err if we want to do that. However in this case bt_dev_warn is better since we should be gracefully handling this anyway.

Regards

Marcel

