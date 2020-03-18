Return-Path: <SRS0=jOg2=5D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4321BC5ACD6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 11:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209C62076F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 11:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgCRLGu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:06:50 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:42883 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgCRLGu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Mar 2020 07:06:50 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 651DBCECF2;
        Wed, 18 Mar 2020 12:16:19 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH 4/7] Bluetooth: LL_PRIVACY re-load resolving list
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200312100754.3445-5-sathish.narasimman@intel.com>
Date:   Wed, 18 Mar 2020 12:06:48 +0100
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        chethan.tumkur.narayan@intel.com,
        Sathish Narsimman <sathish.narasimman@intel.com>,
        Joy Shermin <shermin.joy@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <7F7F5693-AF9F-423C-9439-FD394CC4A8B1@holtmann.org>
References: <20200312100754.3445-1-sathish.narasimman@intel.com>
 <20200312100754.3445-5-sathish.narasimman@intel.com>
To:     Sathish Narsimman <nsathish41@gmail.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sathish,

> The patch is used to load the entries in the local IRK to the
> Bluetooth LE controller resolving list.
> 
> Signed-off-by: Sathish Narsimman <sathish.narasimman@intel.com>
> Signed-off-by: Joy Shermin <shermin.joy@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  1 +
> net/bluetooth/hci_request.c      | 29 +++++++++++++++++++++++++++++
> 2 files changed, 30 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 43d31a9339a6..46d2d3e10c97 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1659,6 +1659,7 @@ void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
> 			       u8 *bdaddr_type);
> int hci_req_update_resolving_list(struct hci_dev *hdev,  u8 addr_type,
> 				  bdaddr_t *bdaddr, u8 irk[16]);
> +void hci_load_resolving_list(struct hci_dev *hdev);
> void hci_req_update_resolving_list_local_irk(struct hci_dev *hdev);
> 
> void hci_req_del_from_resolving_list(struct hci_dev *hdev, u8 addr_type,
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index 9ffb62178d24..e17db3103a3d 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -1015,6 +1015,35 @@ void hci_req_update_resolving_list_local_irk(struct hci_dev *hdev)
> 	hci_req_run(&req, NULL);
> }
> 
> +void hci_load_resolving_list (struct hci_dev *hdev)
> +{
> +	struct smp_irk *irk;
> +	u8 num = 0;
> +
> +	/* Nothing to be done if LL privacy is not supported */
> +	if ( !(hdev->le_features[0] & HCI_LE_LL_PRIVACY) )
> +		return;
> +
> +	if ( !hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION) &&
> +	    ( hci_dev_test_flag(hdev, HCI_LE_ADV) ||
> +	      hci_dev_test_flag(hdev, HCI_LE_SCAN) ||
> +	      hci_lookup_le_connect(hdev) ) )
> +		return;
> +
> +	/* Load the first le_resolving_list_size entries from IRK
> +	 * list in to resolving list.
> +	 */
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, list) {
> +		if (num++ >= hdev->le_resolv_list_size)
> +			return;
> +
> +		hci_req_update_resolving_list(hdev, irk->addr_type, &irk->bdaddr, irk->val);
> +	}

I comparison to the le_whitelist, the le_resolv_list_size does not have to match the actual available memory of the controller. It is just some guesstimate. I think we have to design this in a way that we add the IRK anyway and handle the error case gracefully.

I am also confused why we are not actually checking here if an entry is already present and just loading the whole list. I have seen code being duplicated in at least 3 places now.

Regards

Marcel

