Return-Path: <SRS0=RPtH=4T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E04C3F2CD
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Mar 2020 22:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32FCD21775
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Mar 2020 22:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgCBWMx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Mar 2020 17:12:53 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:48079 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCBWMx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Mar 2020 17:12:53 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 109EDCECC4;
        Mon,  2 Mar 2020 23:22:19 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH v2] bluetooth: guard against controllers sending zero'd
 events
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200302154249.25047-1-alainm@chromium.org>
Date:   Mon, 2 Mar 2020 23:12:51 +0100
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <DA78EC88-88D2-4086-BC83-FCC1E2B2BE2C@holtmann.org>
References: <20200302154249.25047-1-alainm@chromium.org>
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
> 
> Signed-off-by: Alain Michaud <alainm@chromium.org>
> ---
> 
> net/bluetooth/hci_event.c | 6 ++++++
> 1 file changed, 6 insertions(+)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 591e7477e925..56305b3a865e 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -5868,6 +5868,12 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
> 	u8 status = 0, event = hdr->evt, req_evt = 0;
> 	u16 opcode = HCI_OP_NOP;
> 
> +	if (!event) {
> +		bt_dev_warn(hdev, "Received unexpected HCI Event 00000000");
> +		kfree_skb(skb);
> +		hdev->stat.evt_rx++;
> +	}
> +
> 	if (hdev->sent_cmd && bt_cb(hdev->sent_cmd)->hci.req_event == event) {
> 		struct hci_command_hdr *cmd_hdr = (void *) hdev->sent_cmd->data;
> 		opcode = __le16_to_cpu(cmd_hdr->opcode);

what about doing just this:

@@ -5868,6 +5868,11 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
        u8 status = 0, event = hdr->evt, req_evt = 0;
        u16 opcode = HCI_OP_NOP;
 
+       if (!event) {
+               bt_dev_warn(hdev, ..);
+               goto done;
+       }
+
        if (hdev->sent_cmd && bt_cb(hdev->sent_cmd)->hci.req_event == event) {
                struct hci_command_hdr *cmd_hdr = (void *) hdev->sent_cmd->data;
                opcode = __le16_to_cpu(cmd_hdr->opcode);
@@ -6079,6 +6084,7 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
                req_complete_skb(hdev, status, opcode, orig_skb);
        }
 
+done:
        kfree_skb(orig_skb);
        kfree_skb(skb);
        hdev->stat.evt_rx++;

Regards

Marcel

