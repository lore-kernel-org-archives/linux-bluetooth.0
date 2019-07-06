Return-Path: <SRS0=OJUr=VD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F950C0650E
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Jul 2019 10:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A43A20989
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Jul 2019 10:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfGFKmU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 6 Jul 2019 06:42:20 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:54090 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfGFKmU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 6 Jul 2019 06:42:20 -0400
Received: from [192.168.0.113] (CMPC-089-239-107-172.CNet.Gawex.PL [89.239.107.172])
        by mail.holtmann.org (Postfix) with ESMTPSA id 085FECEFAE;
        Sat,  6 Jul 2019 12:50:51 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] Fast advertising interval
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1561108931-9568-1-git-send-email-spoorthix.k@intel.com>
Date:   Sat, 6 Jul 2019 12:42:18 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <CCA3FD03-9EA3-43B7-B2E8-310316BCA6AA@holtmann.org>
References: <1561108931-9568-1-git-send-email-spoorthix.k@intel.com>
To:     SpoorthiX K <spoorthix.k@intel.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Spoorthi,

> Implemented as per Core Spec 5.0
> 
> Signed-off-by: Spoorthi Ravishankar Koppad <spoorthix.k@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  2 ++
> net/bluetooth/hci_request.c      | 33 ++++++++++++++++++++++++---------
> 2 files changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index aed17df..9b19992 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1510,6 +1510,8 @@ struct hci_mgmt_chan {
> #define DISCOV_INTERLEAVED_INQUIRY_LEN	0x04
> #define DISCOV_BREDR_INQUIRY_LEN	0x08
> #define DISCOV_LE_RESTART_DELAY		msecs_to_jiffies(200)	/* msec */
> +#define DISCOV_LE_FAST_ADV_INT_MIN     100     /* msec */
> +#define DISCOV_LE_FAST_ADV_INT_MAX     150     /* msec */
> 
> void mgmt_fill_version_info(void *ver);
> int mgmt_new_settings(struct hci_dev *hdev);
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index d4f5bfa..c077b06 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -1177,8 +1177,10 @@ void __hci_req_enable_advertising(struct hci_request *req)
> 	bool connectable;
> 	u32 flags;
> 
> +       	BT_INFO("Entered __hci_req_enable_advertising");
> 	flags = get_adv_instance_flags(hdev, hdev->cur_adv_instance);
> 
> +

these two don’t belong in this patch.

> 	/* If the "connectable" instance flag was not set, then choose between
> 	 * ADV_IND and ADV_NONCONN_IND based on the global connectable setting.
> 	 */
> @@ -1208,15 +1210,28 @@ void __hci_req_enable_advertising(struct hci_request *req)
> 		return;
> 
> 	memset(&cp, 0, sizeof(cp));
> -	cp.min_interval = cpu_to_le16(hdev->le_adv_min_interval);
> -	cp.max_interval = cpu_to_le16(hdev->le_adv_max_interval);
> -
> -	if (connectable)
> -		cp.type = LE_ADV_IND;
> -	else if (get_cur_adv_instance_scan_rsp_len(hdev))
> -		cp.type = LE_ADV_SCAN_IND;
> -	else
> -		cp.type = LE_ADV_NONCONN_IND;
> +       BT_INFO("__hci_req_enable_advertising”);

This is debug code. Please remove it.

> +
> +       if (connectable) {
> +               BT_INFO("set adv min and max");
> +                cp.type = LE_ADV_IND;

The indentation is borked here and the BT_INFO also doesn’t belong here.

> +               cp.min_interval = cpu_to_le16(hdev->le_adv_min_interval);
> +               cp.max_interval = cpu_to_le16(hdev->le_adv_max_interval);
> +       } else {
> +               if (get_cur_adv_instance_scan_rsp_len(hdev))
> +                       cp.type = LE_ADV_SCAN_IND;
> +               else
> +                       cp.type = LE_ADV_NONCONN_IND;
> +
> +              if (!hci_dev_test_flag(hdev, HCI_DISCOVERABLE) ||
> +                       hci_dev_test_flag(hdev, HCI_LIMITED_DISCOVERABLE)) {
> +                       BT_INFO("Check  HCI_DISCOVERABLE or HCI_LIMITED_DISCOVERABLE”);

Same as above. No BT_INFO here please.

> +                       cp.min_interval =
> +                              cpu_to_le16(DISCOV_LE_FAST_ADV_INT_MIN);
> +                       cp.max_interval =
> +                               cpu_to_le16(DISCOV_LE_FAST_ADV_INT_MAX);
> +               }
> +       }
> 
> 	cp.own_address_type = own_addr_type;
> 	cp.channel_map = hdev->le_adv_channel_map;

Regards

Marcel

