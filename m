Return-Path: <SRS0=PsJ4=5Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1B2C2D0EA
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Apr 2020 06:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D97206C0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Apr 2020 06:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgDHGaF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Apr 2020 02:30:05 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:59701 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgDHGaF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Apr 2020 02:30:05 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 82561CECE0
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Apr 2020 08:39:38 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] Bluetooth: Enable LE Enhanced Connection Complete event.
Date:   Wed, 8 Apr 2020 08:30:03 +0200
References: <20200407232523.1013507-1-marcel@holtmann.org>
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
In-Reply-To: <20200407232523.1013507-1-marcel@holtmann.org>
Message-Id: <201E0449-B5E0-4536-96AA-687F23F8D3A6@holtmann.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

> In case LL Privacy is supported by the controller, it is also a good
> idea to use the LE Enhanced Connection Complete event for getting all
> information about the new connection and its addresses.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
> net/bluetooth/hci_core.c | 8 ++++++++
> 1 file changed, 8 insertions(+)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index fb210f7ab7ab..d8d543e3dc9f 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -638,6 +638,14 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
> 		if (hdev->le_features[0] & HCI_LE_DATA_LEN_EXT)
> 			events[0] |= 0x40;	/* LE Data Length Change */
> 
> +		/* If the controller supports LL Privacy feature, enable
> +		 * the corresponding event.
> +		 */
> +		if (hdev->le_features[0] & HCI_LE_LL_PRIVACY)
> +			events[1] |= 0x02;	/* LE Enhanced Connection
> +						 * Complete
> +						 */
> +

so this is sort of enough to get the events, but they don’t give any extra information if LL Privacy is not used. While the current code handles the non LL Privacy parts of this event, the important local RPA and peer RPA are not handled.

Both RPAs (if used) however need to be stored in hci_conn so that SMP can make use of them if needed.

Regards

Marcel

