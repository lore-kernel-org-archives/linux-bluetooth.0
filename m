Return-Path: <SRS0=evP7=XW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D96C4360C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Sep 2019 07:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E876207FF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Sep 2019 07:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbfI0HHg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Sep 2019 03:07:36 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:56096 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfI0HHg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Sep 2019 03:07:36 -0400
Received: from marcel-macpro.fritz.box (p4FEFC197.dip0.t-ipconnect.de [79.239.193.151])
        by mail.holtmann.org (Postfix) with ESMTPSA id 65AFECECE9;
        Fri, 27 Sep 2019 09:16:28 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] Add support to use Resolving list
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1568802985-9990-1-git-send-email-spoorthix.k@intel.com>
Date:   Fri, 27 Sep 2019 09:07:34 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <3ED849F8-3208-4576-9A99-29DD2AC24703@holtmann.org>
References: <1568802985-9990-1-git-send-email-spoorthix.k@intel.com>
To:     SpoorthiX K <spoorthix.k@intel.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Spoorthi,

please add a proper commit message to the patch. I let this slide for now, but really we have not accepted any patch that doesn’t have a detailed commit message.

> 
> Signed-off-by: Spoorthi Ravishankar Koppad <spoorthix.k@intel.com>
> ---
> include/net/bluetooth/hci.h |  1 +
> net/bluetooth/hci_request.c | 88 +++++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 89 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 5bc1e30..1574dc1 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -433,6 +433,7 @@ enum {
> #define HCI_LE_SLAVE_FEATURES		0x08
> #define HCI_LE_PING			0x10
> #define HCI_LE_DATA_LEN_EXT		0x20
> +#define HCI_LE_LL_PRIVACY		0x40
> #define HCI_LE_PHY_2M			0x01
> #define HCI_LE_PHY_CODED		0x08
> #define HCI_LE_EXT_ADV			0x10
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index 621f1a9..2c0d7e8 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -670,6 +670,82 @@ void hci_req_add_le_scan_disable(struct hci_request *req)
> 	}
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
> +	memset(&cp, 0, sizeof(cp));
> +
> +	cp.bdaddr_type = params->addr_type;
> +	bacpy(&cp.bdaddr, &params->addr);
> +	memcpy(entry->peer_irk, cp.peer_irk, 16);
> +	memcpy(entry->local_irk, cp.local_irk, 16);
> +
> +	hci_req_add(req, HCI_OP_LE_ADD_TO_RESOLV_LIST, sizeof(cp), &cp);
> +}
> +
> +static void update_resolve_list(struct hci_request *req)
> +{
> +	struct hci_dev *hdev = req->hdev;
> +	struct bdaddr_list *b;
> +	struct hci_conn_params *params;
> +	int err;
> +	u8 resolve_list_entries = 0;
> +
> +	list_for_each_entry(b, &hdev->le_resolv_list, list) {
> +	/* Cannot Remove or add the device to the Resolving list
> +	 * whenever there is an outstanding connection.
> +	 */
> +		if (!hci_pend_le_action_lookup(&hdev->pend_le_conns,
> +					       &b->bdaddr,
> +					       b->bdaddr_type) &&
> +		    !hci_pend_le_action_lookup(&hdev->pend_le_reports,
> +					       &b->bdaddr,
> +					       b->bdaddr_type)) {
> +			struct hci_cp_le_del_from_resolv_list cp;
> +
> +			cp.bdaddr_type = b->bdaddr_type;
> +			bacpy(&cp.bdaddr, &b->bdaddr);
> +
> +			hci_req_add(req, HCI_OP_LE_DEL_FROM_RESOLV_LIST,
> +				    sizeof(cp), &cp);
> +		}
> +	}
> +	/* During background scanning/active scanning the
> +	 * device BD address is populated in LE pending
> +	 * connections list. So, track the list and add to Resolving
> +	 * list if found by IRK.
> +	 */
> +	list_for_each_entry(params, &hdev->pend_le_conns, action) {
> +		if (hci_bdaddr_list_lookup(&hdev->le_resolv_list,
> +					   &params->addr, params->addr_type))
> +			resolve_list_entries++;
> +
> +		if (hci_find_irk_by_addr(hdev, &params->addr,
> +					 params->addr_type)) {
> +			/* Add device to resolving list */
> +			resolve_list_entries++;
> +			add_to_resolve_list(req, params);
> +		}
> +	}
> +
> +	/* Device can be resolved in the Host if size of resolving
> +	 * list is greater than defined in the controller.
> +	 */
> +	if (resolve_list_entries >= hdev->le_resolv_list_size) {
> +		err = smp_generate_rpa(hdev, hdev->irk, &hdev->rpa);
> +		if (err < 0)
> +			BT_ERR("%s failed to generate new RPA",
> +			       hdev->name);
> +		}
> +}
> +
> static void add_to_white_list(struct hci_request *req,
> 			      struct hci_conn_params *params)
> {
> @@ -896,6 +972,12 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
> 	    (hdev->le_features[0] & HCI_LE_EXT_SCAN_POLICY))
> 		filter_policy |= 0x02;
> 
> +	/* If LE Privacy is supported in controller
> +	 * add the device to resolving list.
> +	 */
> +	if (hci_dev_test_flag(hdev, HCI_LE_LL_PRIVACY))
> +		update_resolve_list(req);
> +
> 	hci_req_start_scan(req, LE_SCAN_PASSIVE, hdev->le_scan_interval,
> 			   hdev->le_scan_window, own_addr_type, filter_policy);
> }
> @@ -2513,6 +2595,12 @@ static int active_scan(struct hci_request *req, unsigned long opt)
> 	if (err < 0)
> 		own_addr_type = ADDR_LE_DEV_PUBLIC;
> 
> +	/* Update resolving list when privacy feature is
> +	 * is enabled in the controller */
> +	if (hci_dev_test_flag(hdev, HCI_LE_LL_PRIVACY)) {
> +		update_resolve_list(req);
> +	}
> +
> 	hci_req_start_scan(req, LE_SCAN_ACTIVE, interval, DISCOV_LE_SCAN_WIN,
> 			   own_addr_type, 0);

I am actually not convinced you have fully tested this patch at all. Maybe it is better you actually write a bunch of test cases for one of our -tester tools and get this automated.

So there are two cases when we want to ensure that the resolving list is up-to-date and correct. And that is mainly just before we either start background scanning (passive scanning) or before we do discovery (active scanning). We also need to ensure that the resolving list is correct when we do advertising (scannable and connectable), but I just ignore that for now.

When we do passive scanning, our whitelist is important. That is why hci_req_le_add_le_passive_scanning has this line:

        /* Adding or removing entries from the white list must                   
         * happen before enabling scanning. The controller does                  
         * not allow white list modification while scanning.                     
         */                                                                      
        filter_policy = update_white_list(req);

Updating the whitelist returns the filter policy on when to use the whitelist. It will not be used when we have an RPA in our device list. However that really only holds true if the controller can not resolve it. Otherwise we can keep using the whitelist.

Now update_white_list contains these pieces:

                if (hci_find_irk_by_addr(hdev, &params->addr,                    
                                         params->addr_type)) {                   
                        /* White list can not be used with RPAs */               
                        return 0x00;                                             
                }                                                

This is no longer a valid statement if we successfully programmed the address into the controller. And if we have switched on resolving list.

So we need to correctly store the current resolving list information and map and in case resolving list is active, we need to add checks here to decide on the filer policy.

For active scanning this is not needed since we are not using the whitelist. Actually for active scanning I don’t even care much if we are using the resolving list. If it is there, great if not, we can just as easily resolve the RPAs in the host. So for active scanning, I would not bother touching the resolving list at all.

Regards

Marcel

