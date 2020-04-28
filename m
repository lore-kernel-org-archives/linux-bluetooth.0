Return-Path: <SRS0=u/yl=6M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24000C83000
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Apr 2020 09:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 071B5206A1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Apr 2020 09:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgD1Jro convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Apr 2020 05:47:44 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:60499 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbgD1Jro (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Apr 2020 05:47:44 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0156DCECEB;
        Tue, 28 Apr 2020 11:57:21 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] Bluetooth: Handle Inquiry Cancel error after Inquiry
 Complete
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200428051151.14879-1-sonnysasaka@gmail.com>
Date:   Tue, 28 Apr 2020 11:47:42 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <D2192131-CC65-4D4E-91BE-B1C3B1C12BC4@holtmann.org>
References: <20200428051151.14879-1-sonnysasaka@gmail.com>
To:     Sonny Sasaka <sonnysasaka@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

> After sending Inquiry Cancel command to the controller, it is possible
> that Inquiry Complete event comes before Inquiry Cancel command complete
> event. In this case the Inquiry Cancel command will have status of
> Command Disallowed since there is no Inquiry session to be cancelled.
> This case should not be treated as error, otherwise we can reach an
> inconsistent state.
> 
> Example of a btmon trace when this happened:
> 
> < HCI Command: Inquiry Cancel (0x01|0x0002) plen 0
>> HCI Event: Inquiry Complete (0x01) plen 1
>        Status: Success (0x00)
>> HCI Event: Command Complete (0x0e) plen 4
>      Inquiry Cancel (0x01|0x0002) ncmd 1
>        Status: Command Disallowed (0x0c)
> ---
> net/bluetooth/hci_event.c | 19 +++++++++++++++----
> 1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 966fc543c01d..0f3f7255779f 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -42,10 +42,9 @@
> 
> /* Handle HCI Event packets */
> 
> -static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
> +static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb,
> +				  u8 status)
> {
> -	__u8 status = *((__u8 *) skb->data);
> -
> 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
> 
> 	if (status)
> @@ -3233,7 +3232,19 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
> 
> 	switch (*opcode) {
> 	case HCI_OP_INQUIRY_CANCEL:
> -		hci_cc_inquiry_cancel(hdev, skb);
> +		/* It is possible that we receive Inquiry Complete event right
> +		 * before we receive Inquiry Cancel Command Complete event, in
> +		 * which case the latter event should have status of Command
> +		 * Disallowed (0x0c). This should not be treated as error, since
> +		 * we actually achieve what Inquiry Cancel wants to achieve,
> +		 * which is to end the last Inquiry session.
> +		 */
> +		if (*status == 0x0c && !test_bit(HCI_INQUIRY, &hdev->flags)) {
> +			BT_DBG("Ignoring error of HCI Inquiry Cancel command");
> +			*status = 0;
> +		}

is there a problem with moving this check into hci_cc_inquiry_cancel? Then we don’t have to play any tricks with an extra parameter that is also included in the skb data struct itself.

I prefer we start using bt_dev_dbg and in this case maybe we just use bt_dev_warn or bt_dev_warn_ratelimited.

Regards

Marcel

