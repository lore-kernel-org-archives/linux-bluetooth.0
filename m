Return-Path: <SRS0=qOEI=NK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC263C2BC61
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Oct 2018 07:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893392082D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Oct 2018 07:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 893392082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbeJ3Qrx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Oct 2018 12:47:53 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:54038 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbeJ3Qrw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Oct 2018 12:47:52 -0400
Received: from marcel-macbook.fritz.box (p4FF9F655.dip0.t-ipconnect.de [79.249.246.85])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1884ECEFA6;
        Tue, 30 Oct 2018 09:02:55 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH] support fast advertising interval
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1535359591-27842-1-git-send-email-bharat.b.panda@intel.com>
Date:   Tue, 30 Oct 2018 08:55:28 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <C18F1F83-945E-4FBF-97A3-E55184123932@holtmann.org>
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

“entering”

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

Remove the unneeded (x == x) braces.

> +		if ((hci_dev_test_flag(hdev, HCI_DISCOVERABLE)) ||
> +		(hci_dev_test_flag(hdev, HCI_LIMITED_DISCOVERABLE)) ||
> +		(hdev->discovery.limited == true)) {

Same here and the indentation is all messed up. In addition of just quoting the spec text, it would be good also document why these conditions are the the correct match. And why hdev->discovery.limited is even in this mix.

> +			cp.min_interval =
> +				cpu_to_le16(DISCOV_LE_FAST_ADV_INT_MIN);
> +			cp.max_interval =
> +				cpu_to_le16(DISCOV_LE_FAST_ADV_INT_MAX);
> +		}
> +	}
> +

Regards

Marcel

