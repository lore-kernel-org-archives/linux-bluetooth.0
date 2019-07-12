Return-Path: <SRS0=25t8=VJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821F3C742D7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jul 2019 19:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5813A205C9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jul 2019 19:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfGLTDt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Jul 2019 15:03:49 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:46099 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfGLTDt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Jul 2019 15:03:49 -0400
Received: from [192.168.22.73] (unknown [157.25.100.178])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3AB36CF2CB;
        Fri, 12 Jul 2019 21:12:19 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] Fast Advertising Interval
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1562565973-20657-1-git-send-email-spoorthix.k@intel.com>
Date:   Fri, 12 Jul 2019 21:03:42 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <1822906D-5F88-47E5-A4BD-FC3E8656DCDA@holtmann.org>
References: <1562565973-20657-1-git-send-email-spoorthix.k@intel.com>
To:     SpoorthiX K <spoorthix.k@intel.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Spoorthi,

> Changes made to add support for fast advertising interval
> as per core 4.1 specification, section 9.3.11.2.
> 
> A peripheral device entering any of the following GAP modes and
> sending either non-connectable advertising events or scannable
> undirected advertising events should use adv_fast_interval2
> (100ms - 150ms) for adv_fast_period(30s).
> 
>         - Non-Discoverable Mode
>         - Non-Connectable Mode
>         - Limited Discoverable Mode
>         - General Discoverable Mode
> 
> Signed-off-by: Spoorthi Ravishankar Koppad <spoorthix.k@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  2 ++
> net/bluetooth/hci_request.c      | 25 +++++++++++++++++--------
> 2 files changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 7dfe6ff..a69534d 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1512,6 +1512,8 @@ struct hci_mgmt_chan {
> #define DISCOV_INTERLEAVED_INQUIRY_LEN	0x04
> #define DISCOV_BREDR_INQUIRY_LEN	0x08
> #define DISCOV_LE_RESTART_DELAY		msecs_to_jiffies(200)	/* msec */
> +#define DISCOV_LE_FAST_ADV_INT_MIN     100     /* msec */
> +#define DISCOV_LE_FAST_ADV_INT_MAX     150     /* msec */
> 
> void mgmt_fill_version_info(void *ver);
> int mgmt_new_settings(struct hci_dev *hdev);
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index d4ecf71..6d8ffcc 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -1199,15 +1199,24 @@ void __hci_req_enable_advertising(struct hci_request *req)
> 		return;
> 
> 	memset(&cp, 0, sizeof(cp));
> -	cp.min_interval = cpu_to_le16(hdev->le_adv_min_interval);
> -	cp.max_interval = cpu_to_le16(hdev->le_adv_max_interval);
> -
> -	if (connectable)
> +	if (connectable) {
> 		cp.type = LE_ADV_IND;
> -	else if (get_cur_adv_instance_scan_rsp_len(hdev))
> -		cp.type = LE_ADV_SCAN_IND;
> -	else
> -		cp.type = LE_ADV_NONCONN_IND;
> +		cp.min_interval = cpu_to_le16(hdev->le_adv_min_interval);
> +		cp.max_interval = cpu_to_le16(hdev->le_adv_max_interval);
> +	} else {
> +		if (get_cur_adv_instance_scan_rsp_len(hdev))
> +			cp.type = LE_ADV_SCAN_IND;
> +		else
> +			cp.type = LE_ADV_NONCONN_IND;
> +
> +		if (!hci_dev_test_flag(hdev, HCI_DISCOVERABLE) ||
> +		    hci_dev_test_flag(hdev, HCI_LIMITED_DISCOVERABLE)) {
> +			cp.min_interval =
> +				cpu_to_le16(DISCOV_LE_FAST_ADV_INT_MIN);
> +			cp.max_interval =
> +				cpu_to_le16(DISCOV_LE_FAST_ADV_INT_MAX);
> +		}

isn’t this missing an else clause?

> +	}
> 
> 	cp.own_address_type = own_addr_type;
> 	cp.channel_map = hdev->le_adv_channel_map;

I would move this block up right after the memset().

Regards

Marcel

