Return-Path: <SRS0=vV7E=WL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F43C31E40
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Aug 2019 06:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6C92171F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Aug 2019 06:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730496AbfHOG4r convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Aug 2019 02:56:47 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:40376 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730476AbfHOG4q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Aug 2019 02:56:46 -0400
Received: from marcel-macbook.fritz.box (p4FEFC580.dip0.t-ipconnect.de [79.239.197.128])
        by mail.holtmann.org (Postfix) with ESMTPSA id 2888ECED13;
        Thu, 15 Aug 2019 09:05:26 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] Add support to use resolving list
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1565770701-7274-1-git-send-email-spoorthix.k@intel.com>
Date:   Thu, 15 Aug 2019 08:56:43 +0200
Cc:     linux-bluetooth@vger.kernel.org,
        linux-bluetooth-owner@vger.kernel.org, bharat.b.panda@intel.com
Content-Transfer-Encoding: 8BIT
Message-Id: <9070A641-C315-44EA-BDB6-274662BF8958@holtmann.org>
References: <1565770701-7274-1-git-send-email-spoorthix.k@intel.com>
To:     SpoorthiX K <spoorthix.k@intel.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Spoorthi,

> As per Core specification 5.0, Vol 2, Part E, Section 7.8.38,
> following code changes implements LE add device to Resolving List.
> 
> Signed-off-by: Spoorthi Ravishankar Koppad <spoorthix.k@intel.com>
> ---
> include/net/bluetooth/hci.h |   1 +
> net/bluetooth/hci_request.c | 134 ++++++++++++++++++++++++++++++++++++++++++--
> 2 files changed, 130 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index c36dc1e..99a38cf36 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -420,6 +420,7 @@ enum {
> #define HCI_LE_SLAVE_FEATURES		0x08
> #define HCI_LE_PING			0x10
> #define HCI_LE_DATA_LEN_EXT		0x20
> +#define HCI_LE_LL_PRIVACY		0x40
> #define HCI_LE_PHY_2M			0x01
> #define HCI_LE_PHY_CODED		0x08
> #define HCI_LE_EXT_ADV			0x10
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index ca73d36..868a592 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -672,7 +672,6 @@ static void add_to_white_list(struct hci_request *req,
> 
> 	cp.bdaddr_type = params->addr_type;
> 	bacpy(&cp.bdaddr, &params->addr);
> -
> 	hci_req_add(req, HCI_OP_LE_ADD_TO_WHITE_LIST, sizeof(cp), &cp);
> }
> 
> @@ -681,7 +680,7 @@ static u8 update_white_list(struct hci_request *req)
> 	struct hci_dev *hdev = req->hdev;
> 	struct hci_conn_params *params;
> 	struct bdaddr_list *b;
> -	uint8_t white_list_entries = 0;
> +	u8 white_list_entries = 0;

I prefer if these kind of fixes come in via separate patches. They distract from the actual parts this feature changes.

> 
> 	/* Go through the current white list programmed into the
> 	 * controller one by one and check if that address is still
> @@ -773,6 +772,111 @@ static u8 update_white_list(struct hci_request *req)
> 	return 0x01;
> }
> 
> +static void add_to_resolve_list(struct hci_request *req,
> +				struct hci_conn_params *params)
> +{
> +	struct hci_cp_le_add_to_resolv_list cp;
> +	struct bdaddr_list_with_irk *entry;
> +
> +	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> +	if (!entry)
> +		return;
> +

In general we memset the cp structures first. And if there might be some missing, then that would warrant fixes this separately.

> +	cp.bdaddr_type = params->addr_type;
> +	bacpy(&cp.bdaddr, &params->addr);
> +	memcpy(entry->peer_irk, cp.peer_irk, 16);
> +	memcpy(entry->local_irk, cp.local_irk, 16);
> +	hci_req_add(req, HCI_OP_LE_ADD_TO_RESOLV_LIST, sizeof(cp), &cp);
> +}
> +
> +static u8 update_resolve_list(struct hci_request *req)
> +{
> +	struct hci_dev *hdev = req->hdev;
> +	struct hci_conn_params *params;
> +	struct bdaddr_list *b;
> +	u8 resolve_list_entries = 0;
> +
> +	/* Go through the current resolving list programmed into the
> +	 * controller one by one and check if that address is still
> +	 * in the list of pending connections or list of devices to
> +	 * report. If not present in either list, then queue
> +	 * command to remove it from the controller.
> +	 */
> +

What is up extra empty lines here. Please following the coding style since me having to point this out all the time is not going to make want to review patches.

> +	list_for_each_entry(b, &hdev->le_resolv_list, list) {
> +		/* If the device is neither in pend_le_conns nor
> +		 * pend_le_reports then remove it from the resolving list.
> +		 */
> +		if (!hci_pend_le_action_lookup(&hdev->pend_le_conns,
> +					       &b->bdaddr, b->bdaddr_type) &&
> +		    !hci_pend_le_action_lookup(&hdev->pend_le_reports,
> +					       &b->bdaddr, b->bdaddr_type)) {
> +			struct hci_cp_le_del_from_resolv_list cp;
> +
> +			cp.bdaddr_type = b->bdaddr_type;
> +			bacpy(&cp.bdaddr, &b->bdaddr);
> +			hci_req_add(req, HCI_OP_LE_DEL_FROM_RESOLV_LIST,
> +				    sizeof(cp), &cp);
> +			continue;
> +		}
> +		if (hci_find_irk_by_addr(hdev, &b->bdaddr, b->bdaddr_type))
> +			return 0x00;
> +
> +		resolve_list_entries++;
> +	}

Why would we bother with this at all. This is the resolving list and not the whitelist. The resolving list has nothing to do with connection or pending connections. I would leave the addresses in the controller to allow resolving.

> +
> +	/* Since all no longer valid resolve list entries have been
> +	 * removed, walk through the list of pending connections
> +	 * and ensure that any new device gets programmed into
> +	 * the controller.
> +	 *
> +	 * If the list of the devices is larger than the list of
> +	 * available resolve list entries in the controller, then
> +	 * just abort and return filer policy value to not use the
> +	 * resolve list.
> +	 */

But resolving list has nothing to do with the filter policy.

> +
> +	list_for_each_entry(params, &hdev->pend_le_conns, action) {
> +		if (hci_bdaddr_list_lookup(&hdev->le_resolv_list,
> +					   &params->addr, params->addr_type))
> +			continue;
> +
> +		if (resolve_list_entries >= hdev->le_resolv_list_size) {
> +			/* Select filter policy to accept all advertising */
> +			return 0x00;
> +		}
> +
> +		if (hci_find_irk_by_addr(hdev, &params->addr,
> +					 params->addr_type)) {
> +			return 0x00;
> +		}
> +		resolve_list_entries++;
> +		add_to_resolve_list(req, params);
> +	}
> +
> +	/* After adding all new pending connections, walk through
> +	 * the list of pending reports and also add these to the
> +	 * resolving list if there is still space.
> +	 */
> +
> +	list_for_each_entry(params, &hdev->pend_le_reports, action) {
> +		if (hci_bdaddr_list_lookup(&hdev->le_resolv_list,
> +					   &params->addr, params->addr_type))
> +			continue;
> +
> +		if (resolve_list_entries >= hdev->le_resolv_list_size)
> +			return 0x00;
> +
> +		if (hci_find_irk_by_addr(hdev, &params->addr,
> +					 params->addr_type)) {
> +			return 0x00;
> +		}
> +		resolve_list_entries++;
> +		add_to_resolve_list(req, params);
> +	}
> +	return 0x02;
> +}
> +
> static bool scan_use_rpa(struct hci_dev *hdev)
> {
> 	return hci_dev_test_flag(hdev, HCI_PRIVACY);
> @@ -861,6 +965,7 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
> 	struct hci_dev *hdev = req->hdev;
> 	u8 own_addr_type;
> 	u8 filter_policy;
> +	u8 ext_filter_policy;
> 
> 	/* Set require_privacy to false since no SCAN_REQ are send
> 	 * during passive scanning. Not using an non-resolvable address
> @@ -878,6 +983,12 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
> 	 */
> 	filter_policy = update_white_list(req);
> 
> +	/* Adding or removing entries from the resolve list must
> +	 * happen before enabling scanning. The controller does
> +	 * not allow resolve list modification while scanning.
> +	 */
> +	ext_filter_policy = update_resolve_list(req);
> +
> 	/* When the controller is using random resolvable addresses and
> 	 * with that having LE privacy enabled, then controllers with
> 	 * Extended Scanner Filter Policies support can now enable support
> @@ -888,11 +999,24 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
> 	 * 0x02 (no whitelist) and 0x03 (whitelist enabled).
> 	 */
> 	if (hci_dev_test_flag(hdev, HCI_PRIVACY) &&
> -	    (hdev->le_features[0] & HCI_LE_EXT_SCAN_POLICY))
> +	    (hdev->le_features[0] & HCI_LE_EXT_SCAN_POLICY) &&
> +	     (!(hdev->le_features[0] & HCI_LE_LL_PRIVACY)))
> 		filter_policy |= 0x02;

This is not correct. What we need to know is if we have more IRKs available than we have space in the resolving list. If that is the case, then we let the controller report up unresolved RPAs to the host to resolve. This is not a mutual exclusive setting in comparison with link layer privacy. It is complementary.

> 
> -	hci_req_start_scan(req, LE_SCAN_PASSIVE, hdev->le_scan_interval,
> -			   hdev->le_scan_window, own_addr_type, filter_policy);
> +	if (!ext_filter_policy && (hdev->le_features[0] & HCI_LE_LL_PRIVACY)) {
> +		/* If resolve list can not be used then check if
> +		 * whitelist can be used and set filter policy
> +		 * accordingly.
> +		 */

I do not understand this logic.

> +		ext_filter_policy = filter_policy;
> +		hci_req_start_scan(req, LE_SCAN_PASSIVE, hdev->le_scan_interval,
> +				   hdev->le_scan_window, own_addr_type,
> +				   ext_filter_policy);
> +	} else {
> +		hci_req_start_scan(req, LE_SCAN_PASSIVE, hdev->le_scan_interval,
> +				   hdev->le_scan_window, own_addr_type,
> +				   filter_policy);
> +	}
> }
> 
> static u8 get_adv_instance_scan_rsp_len(struct hci_dev *hdev, u8 instance)

Regards

Marcel

