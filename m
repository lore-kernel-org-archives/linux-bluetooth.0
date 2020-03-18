Return-Path: <SRS0=jOg2=5D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B0DC10DCE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 10:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAB020768
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 10:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgCRKp2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:45:28 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:54456 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgCRKp2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Mar 2020 06:45:28 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id D339ECECF2;
        Wed, 18 Mar 2020 11:54:56 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH 3/7] Bluetooth: Update the Resolving list when Local IRK
 changed
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200312100754.3445-4-sathish.narasimman@intel.com>
Date:   Wed, 18 Mar 2020 11:45:26 +0100
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        chethan.tumkur.narayan@intel.com,
        Sathish Narsimman <sathish.narasimman@intel.com>,
        Joy Shermin <shermin.joy@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <6BC384B1-7F1B-4736-BF0F-0B57450E4CE9@holtmann.org>
References: <20200312100754.3445-1-sathish.narasimman@intel.com>
 <20200312100754.3445-4-sathish.narasimman@intel.com>
To:     Sathish Narsimman <nsathish41@gmail.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sathish,

> Whenever the Local IRK changes. i.e privacy mode is toggled
> this patch helps to change the IRK list in the bluetooth
> controller
> 
> Signed-off-by: Sathish Narsimman <sathish.narasimman@intel.com>
> Signed-off-by: Joy Shermin <shermin.joy@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  2 ++
> net/bluetooth/hci_request.c      | 50 ++++++++++++++++++++++++++++++++
> 2 files changed, 52 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index e5e09d530ce7..43d31a9339a6 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1659,6 +1659,8 @@ void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
> 			       u8 *bdaddr_type);
> int hci_req_update_resolving_list(struct hci_dev *hdev,  u8 addr_type,
> 				  bdaddr_t *bdaddr, u8 irk[16]);
> +void hci_req_update_resolving_list_local_irk(struct hci_dev *hdev);
> +
> void hci_req_del_from_resolving_list(struct hci_dev *hdev, u8 addr_type,
> 				     bdaddr_t *bdaddr);
> 
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index 88225a9ca1f8..9ffb62178d24 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -965,6 +965,56 @@ int hci_req_update_resolving_list(struct hci_dev *hdev, u8 type, bdaddr_t *bdadd
> 	return 0;
> }
> 
> +void hci_req_update_resolving_list_local_irk(struct hci_dev *hdev)
> +{
> +	struct bdaddr_list_with_irk *irk;
> +	struct hci_request req;
> +
> +	BT_DBG("");
> +
> +	/* Nothing to be done if LL privacy is not supported. */
> +	if (!(hdev->le_features[0] & HCI_LE_LL_PRIVACY))
> +		return;
> +
> +	/* If resolving list is empty, nothing is to be done.*/
> +	if (list_empty(&hdev->le_resolv_list))
> +		return;

actually the le_resolv_list represents the current list programmed into the controller.

> +
> +	/* Resolving List cannot be updated if address resolution
> +	 * in the controller is enabled and advertisement or scanning
> +	 * or create connection command is ongoing.
> +	 */
> +	if ( !hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION) &&
> +	    ( hci_dev_test_flag(hdev, HCI_LE_ADV) ||
> +	      hci_dev_test_flag(hdev, HCI_LE_SCAN) ||
> +	      hci_lookup_le_connect(hdev) ) )
> +		return;

Coding style needs to be correct.

> +
> +	/* If resolving list is not empty, then clear the resolving list
> +	 * and add back each entry with updated local IRK.
> +	 */
> +	hci_req_init(&req, hdev);
> +
> +	list_for_each_entry(irk, &hdev->le_resolv_list, list) {
> +		struct hci_cp_le_add_to_resolv_list cp;
> +		struct hci_cp_le_del_from_resolv_list cp1;
> +
> +		cp1.bdaddr_type = irk->bdaddr_type;
> +		bacpy(&cp1.bdaddr, &irk->bdaddr);
> +		hci_req_add(&req, HCI_OP_LE_DEL_FROM_RESOLV_LIST,
> +			    sizeof(cp1), &cp1);
> +
> +		cp.bdaddr_type = irk->bdaddr_type;
> +		bacpy(&cp.bdaddr, &irk->bdaddr);
> +		memcpy(cp.peer_irk, irk->peer_irk, 16);
> +		memcpy(cp.local_irk, hdev->irk, 16);
> +		hci_req_add(&req, HCI_OP_LE_ADD_TO_RESOLV_LIST,
> +			    sizeof(cp), &cp);
> +	}

Can we please do this the smart way, no need to remove and entry to just add it back later.

Regards

Marcel

