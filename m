Return-Path: <SRS0=YDOl=QL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203B7C282C4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Feb 2019 14:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4692087C
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Feb 2019 14:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbfBDOih convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:38:37 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:36240 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfBDOih (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Feb 2019 09:38:37 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9D3DBCF174;
        Mon,  4 Feb 2019 15:46:25 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v3] Bluetooth: Support fast advertising interval
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1549271267-12393-1-git-send-email-bharat.b.panda@intel.com>
Date:   Mon, 4 Feb 2019 15:38:35 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <278DF91F-1FF1-4FF9-BCA0-18888D2CB560@holtmann.org>
References: <1549271267-12393-1-git-send-email-bharat.b.panda@intel.com>
To:     Bharat Bhusan Panda <bharat.b.panda@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bharat,

> Changes made to add support for fast advertising interval as per
> core 4.1 specification, section 9.3.11.2.
> 
> A peripheral device entering any of the following GAP modes and
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
> net/bluetooth/hci_request.c      | 27 +++++++++++++++++++++++++++
> 2 files changed, 29 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 0db1b9b..868c2fb 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1491,6 +1491,8 @@ struct hci_mgmt_chan {
> #define DISCOV_INTERLEAVED_INQUIRY_LEN	0x04
> #define DISCOV_BREDR_INQUIRY_LEN	0x08
> #define DISCOV_LE_RESTART_DELAY		msecs_to_jiffies(200)	/* msec */
> +#define DISCOV_LE_FAST_ADV_INT_MIN	100	/* msec */
> +#define DISCOV_LE_FAST_ADV_INT_MAX	150	/* msec */
> 
> void mgmt_fill_version_info(void *ver);
> int mgmt_new_settings(struct hci_dev *hdev);
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index e8c9ef1..9b73061 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -1092,6 +1092,33 @@ void __hci_req_enable_advertising(struct hci_request *req)
> 	else
> 		cp.type = LE_ADV_NONCONN_IND;
> 
> +	/* As per core 4.1 spec, section 9.3.11.2: A peripheral device
> +	 * entering any of the following GAP modes and sending either
> +	 * non-connectable advertising events or scannable undirected
> +	 * advertising events should use adv_fast_interval2(100ms - 150ms)
> +	 * for adv_fast_period(30s).
> +	 *
> +	 *	- Non-Discoverable Mode
> +	 *	- Non-Connectable Mode
> +	 *	- Limited Discoverable Mode
> +	 *	- General Discoverable Mode
> +	 */
> +	if (cp.type == LE_ADV_NONCONN_IND || cp.type == LE_ADV_SCAN_IND) {
> +		/* Set the suggested min and max fast advertising interval,
> +		 * only if the peripheral device has entered any of the modes
> +		 * such as non-discoverable, non-connectable or limited-
> +		 * discoverable.
> +		 */
> +		if (!hci_dev_test_flag(hdev, HCI_DISCOVERABLE) ||
> +		    !hci_dev_test_flag(hdev, HCI_CONNECTABLE) ||
> +		    hci_dev_test_flag(hdev, HCI_LIMITED_DISCOVERABLE)) {
> +			cp.min_interval =
> +				cpu_to_le16(DISCOV_LE_FAST_ADV_INT_MIN);
> +			cp.max_interval =
> +				cpu_to_le16(DISCOV_LE_FAST_ADV_INT_MAX);
> +		}
> +	}
> +

I was going to apply the patch, but then looking at the resulting function seems we are doing things too complicated. This is incomplete and missing any comments, but I think you better go into this direction:

@@ -1082,15 +1082,19 @@ void __hci_req_enable_advertising(struct hci_request *req)
                return;
 
        memset(&cp, 0, sizeof(cp));
-       cp.min_interval = cpu_to_le16(hdev->le_adv_min_interval);
-       cp.max_interval = cpu_to_le16(hdev->le_adv_max_interval);
 
-       if (connectable)
+       if (connectable) {
                cp.type = LE_ADV_IND;
-       else if (get_cur_adv_instance_scan_rsp_len(hdev))
-               cp.type = LE_ADV_SCAN_IND;
-       else
-               cp.type = LE_ADV_NONCONN_IND;
+               cp.min_interval = cpu_to_le16(hdev->le_adv_min_interval);
+               cp.max_interval = cpu_to_le16(hdev->le_adv_max_interval);
+       } else {
+               if (get_cur_adv_instance_scan_rsp_len(hdev))
+                       cp.type = LE_ADV_SCAN_IND;
+               else
+                       cp.type = LE_ADV_NONCONN_IND;
+               cp.min_interval = cpu_to_le16(DISCOV_LE_FAST_ADV_INT_MIN);
+               cp.max_interval = cpu_to_le16(DISCOV_LE_FAST_ADV_INT_MAX);
+       }
 
        cp.own_address_type = own_addr_type;
        cp.channel_map = hdev->le_adv_channel_map;

I would also check if you can not rely on the connectable variable. Also you might want to get an ack from Johan on this change.

Regards

Marcel


