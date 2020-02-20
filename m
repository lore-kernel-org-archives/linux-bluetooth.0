Return-Path: <SRS0=cA0y=4I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191BAC11D01
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Feb 2020 07:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EADD720801
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Feb 2020 07:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgBTHhW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Feb 2020 02:37:22 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:41023 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgBTHhW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Feb 2020 02:37:22 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 00282CECDC;
        Thu, 20 Feb 2020 08:46:45 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] Bluetooth: Fix - Remove adv set for directed advertising
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200218144840.2854-1-sathish.narasimman@intel.com>
Date:   Thu, 20 Feb 2020 08:37:20 +0100
Cc:     linux-bluetooth@vger.kernel.org,
        Sathish Narsimman <sathish.narasimman@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <F347B999-AB83-4E11-BAD3-7FC08D40AB9B@holtmann.org>
References: <20200218144840.2854-1-sathish.narasimman@intel.com>
To:     Sathish Narsimman <nsathish41@gmail.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sathish,

> Extended advertising Data is set during bluetooth initialization
> by default which causes InvalidHCICommandParameters when setting
> Extended advertising parameters.
> 
> As per Core Spec 5.2 Vol 2, PART E, Sec 7.8.53, for
> advertising_event_property LE_LEGACY_ADV_DIRECT_IND does not
> supports advertising data when the advertising set already
> contains some, the controller shall return erroc code
> 'InvalidHCICommandParameters(0x12).
> 
> So it is required to remove adv set for handle 0x00. since we use
> instance 0 for directed adv.
> 
> Signed-off-by: Sathish Narsimman <sathish.narasimman@intel.com>
> ---
> include/net/bluetooth/hci.h |  2 ++
> net/bluetooth/hci_conn.c    | 10 ++++++++++
> net/bluetooth/hci_request.c |  5 +++++
> net/bluetooth/hci_request.h |  1 +
> 4 files changed, 18 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 6293bdd7d862..0d7e36c54733 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1724,6 +1724,8 @@ struct hci_cp_le_set_ext_scan_rsp_data {
> 
> #define LE_SET_ADV_DATA_NO_FRAG		0x01
> 
> +#define HCI_OP_LE_REMOVE_ADV_SET	0x203c
> +
> #define HCI_OP_LE_CLEAR_ADV_SETS	0x203d
> 
> #define HCI_OP_LE_SET_ADV_SET_RAND_ADDR	0x2035
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 65fa44cbe514..1887da39a93d 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -898,6 +898,16 @@ static void hci_req_directed_advertising(struct hci_request *req,
> 		cp.peer_addr_type = conn->dst_type;
> 		bacpy(&cp.peer_addr, &conn->dst);
> 
> +		/* As per Core Spec 5.2 Vol 2, PART E, Sec 7.8.53, for
> +		 * advertising_event_property LE_LEGACY_ADV_DIRECT_IND
> +		 * does not supports advertising data when the advertising set already
> +		 * contains some, the controller shall return erroc code 'Invalid
> +		 * HCI Command Parameters(0x12).
> +		 * So it is required to remove adv set for handle 0x00. since we use
> +		 * instance 0 for directed adv.
> +		 */
> +		hci_req_add(req, HCI_OP_LE_REMOVE_ADV_SET, sizeof(cp.handle), &cp.handle);
> +
> 		hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_PARAMS, sizeof(cp), &cp);
> 
> 		if (own_addr_type == ADDR_LE_DEV_RANDOM &&
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index 2a1b64dbf76e..63da7acbb48c 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -1550,6 +1550,11 @@ int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
> 	return 0;
> }
> 
> +void __hci_req_remove_adv_set(struct hci_request *req, u8 handle)
> +{
> +	hci_req_add(req, HCI_OP_LE_REMOVE_ADV_SET, sizeof(handle), &handle);
> +}
> +
> void __hci_req_clear_ext_adv_sets(struct hci_request *req)
> {
> 	hci_req_add(req, HCI_OP_LE_CLEAR_ADV_SETS, 0, NULL);
> diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
> index a7019fbeadd3..8dd40c6c33c8 100644
> --- a/net/bluetooth/hci_request.h
> +++ b/net/bluetooth/hci_request.h
> @@ -84,6 +84,7 @@ void hci_req_clear_adv_instance(struct hci_dev *hdev, struct sock *sk,
> int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance);
> int __hci_req_start_ext_adv(struct hci_request *req, u8 instance);
> int __hci_req_enable_ext_advertising(struct hci_request *req, u8 instance);
> +void __hci_req_remove_adv_set(struct hci_request *req, u8 handle);

I don’t get this part of the patch. It is actually not used.

Regards

Marcel

