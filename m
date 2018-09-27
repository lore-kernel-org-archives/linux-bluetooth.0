Return-Path: <SRS0=a08L=MJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3E0C43382
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Sep 2018 10:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8148B215E5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Sep 2018 10:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8148B215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbeI0ROo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:14:44 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:50964 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbeI0ROo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Sep 2018 13:14:44 -0400
Received: from marcel-macbook.fritz.box (p4FEFC9BB.dip0.t-ipconnect.de [79.239.201.187])
        by mail.holtmann.org (Postfix) with ESMTPSA id AA407CF16A;
        Thu, 27 Sep 2018 13:04:17 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH] support fast advertising interval
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1535359591-27842-1-git-send-email-bharat.b.panda@intel.com>
Date:   Thu, 27 Sep 2018 12:57:01 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <2A9C1D9B-41AA-492C-9144-E8332409BF83@holtmann.org>
References: <1535359591-27842-1-git-send-email-bharat.b.panda@intel.com>
To:     Bharat Bhusan Panda <bharat.b.panda@intel.com>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bharat,

> Changes made to add support for fast advertising interval as per
> core 4.1 specification, section 9.3.11.2.
> 
> A peripheral device enetering any of the following GAP modes and
> sending either non-connectable advertising events or scannable undirected
> advertising events should use adv_fast_interval2(100ms - 150ms)
> for adv_fast_period(30s).
>         - Non-Discoverable Mode
>         - Non-Connectable Mode
>         - Limited Discoverable Mode
>         - General Discoverable Mode

can we also get a patch documenting this in mgmt-api.txt in bluez.git.

> 
> Signed-off-by: Bharat Bhusan Panda <bharat.b.panda@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  2 ++
> net/bluetooth/hci_request.c      | 22 ++++++++++++++++++++++
> 2 files changed, 24 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index b619a19..2fe908c 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1456,6 +1456,8 @@ struct hci_mgmt_chan {
> #define DISCOV_INTERLEAVED_INQUIRY_LEN	0x04
> #define DISCOV_BREDR_INQUIRY_LEN	0x08
> #define DISCOV_LE_RESTART_DELAY		msecs_to_jiffies(200)	/* msec */
> +#define DISCOV_LE_FAST_ADV_INT_MIN	100	/* msec */
> +#define DISCOV_LE_FAST_ADV_INT_MAX	150	/* msec */
> 
> void mgmt_fill_version_info(void *ver);
> int mgmt_new_settings(struct hci_dev *hdev);
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index 66c0781..5cf3ef9 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -1005,6 +1005,28 @@ void __hci_req_enable_advertising(struct hci_request *req)
> 	else
> 		cp.type = LE_ADV_NONCONN_IND;
> 
> +	/* As per core 4.1 spec, section 9.3.11.2: A peripheral device
> +	 * enetering any of the following GAP modes and sending either

Fix the typo please.

> +	 * non-connectable advertising events or scannable undirected
> +	 * advertising events should use adv_fast_interval2(100ms - 150ms)
> +	 * for adv_fast_period(30s).
> +	 *
> +	 * 	- Non-Discoverable Mode
> +	 *	- Non-Connectable Mode
> +	 * 	- Limited Discoverable Mode
> +	 * 	- General Discoverable Mode
> +	 */
> +	if ((cp.type == LE_ADV_NONCONN_IND) || (cp.type = LE_ADV_SCAN_IND)) {

This extra (x == y) parentheses are not needed.

> +		if ((hci_dev_test_flag(hdev, HCI_DISCOVERABLE)) ||
> +		(hci_dev_test_flag(hdev, HCI_LIMITED_DISCOVERABLE)) ||
> +		(hdev->discovery.limited == true)) {

And this is wrongly aligned. In addition, you need a bit more comment text above explains on what are the conditions.

> +			cp.min_interval =
> +				cpu_to_le16(DISCOV_LE_FAST_ADV_INT_MIN);
> +			cp.max_interval =
> +				cpu_to_le16(DISCOV_LE_FAST_ADV_INT_MAX);
> +		}
> +	}
> +
> 	cp.own_address_type = own_addr_type;
> 	cp.channel_map = hdev->le_adv_channel_map;

Regards

Marcel

