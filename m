Return-Path: <SRS0=jOg2=5D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046CFC10DCE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 11:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B332920770
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 11:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgCRLEG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:04:06 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:59916 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgCRLEG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Mar 2020 07:04:06 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7E24CCECF2;
        Wed, 18 Mar 2020 12:13:34 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH 6/7] Bluetooth: Enable LL Privacy
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200312100754.3445-7-sathish.narasimman@intel.com>
Date:   Wed, 18 Mar 2020 12:04:03 +0100
Cc:     linux-bluetooth@vger.kernel.org, chethan.tumkur.narayan@intel.com,
        Sathish Narsimman <sathish.narasimman@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <7233C086-6DB5-4070-BD70-6C72D5565534@holtmann.org>
References: <20200312100754.3445-1-sathish.narasimman@intel.com>
 <20200312100754.3445-7-sathish.narasimman@intel.com>
To:     Sathish Narsimman <nsathish41@gmail.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sathish,

> This enables Link Layer Privacy and sets RPA timeout to 900sec
> 
> < HCI Command: LE Set Address Resolution Enable (0x08|0x002d) plen 1
>        Address resolution: Enabled (0x01)
>> HCI Event: Command Complete (0x0e) plen 4
>      LE Set Address Resolution Enable (0x08|0x002d) ncmd 1d
>        Status: Success (0x00)
> < HCI Command: LE Set Resolvable Private Address Timeout (0x08|0x002e) plen 2
>        Timeout: 900 seconds
>> HCI Event: Command Complete (0x0e) plen 4
>      LE Set Resolvable Private Address Timeout (0x08|0x002e) ncmd 1
>        Status: Success (0x00)
> 
> During Successfull pairing adding the information to device Resolving
> list
> 
> < HCI Command: LE Add Device To Resolving List (0x08|0x0027) plen 39
>        Address type: Random (0x01)
>        Address: D1:79:92:B1:83:DF (Static)
>        Peer identity resolving key: ecc317056e5b385cda281b9c24a453e9
>        Local identity resolving key: 00000000000000000000000000000000
> 
> < ACL Data TX: Handle 3585 flags 0x00 dlen 21
>      SMP: Signing Information (0x0a) len 16
>        Signature key: 37b6c45656c7e8b3ec8db062c3e0c2b2
>> ACL Data RX: Handle 3585 flags 0x02 dlen 9
>      ATT: Error Response (0x01) len 4
>        Read By Group Type Request (0x10)
>        Handle: 0x0001
>        Error: Attribute Not Found (0x0a)
>> ACL Data RX: Handle 3585 flags 0x02 dlen 11
>      ATT: Read By Group Type Request (0x10) len 6
>        Handle range: 0x000a-0xffff
>        Attribute group type: Primary Service (0x2800)
> 
>> HCI Event: Command Complete (0x0e) plen 4
>      LE Add Device To Resolving List (0x08|0x0027) ncmd 1
>        Status: Success (0x00)
> 
> Signed-off-by: Sathish Narsimman <sathish.narasimman@intel.com>
> ---
> include/net/bluetooth/hci.h |  2 ++
> net/bluetooth/hci_conn.c    | 32 ++++++++++++++++++++++++++++++++
> net/bluetooth/hci_core.c    | 20 +++++++++++++++++++-
> net/bluetooth/hci_event.c   | 32 +++++++++++++++++++++++++-------
> net/bluetooth/hci_request.c | 16 +++++++++++++---
> net/bluetooth/mgmt.c        | 10 +++++++++-
> net/bluetooth/smp.c         | 11 +++++++++++
> 7 files changed, 111 insertions(+), 12 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 352bc43940ff..d8431ebb8baa 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1617,6 +1617,8 @@ struct hci_rp_le_read_resolv_list_size {
> 
> #define HCI_OP_LE_SET_ADDR_RESOLV_ENABLE 0x202d
> 
> +#define HCI_OP_LE_SET_RPA_TIMEOUT 	 0x202e
> +
> #define HCI_OP_LE_READ_MAX_DATA_LEN	0x202f
> struct hci_rp_le_read_max_data_len {
> 	__u8	status;
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index e245bc155cc2..06067c0852a6 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -830,6 +830,14 @@ static void hci_req_add_le_create_conn(struct hci_request *req,
> 
> 		plen = sizeof(*cp);
> 
> +		/* If the own_addr_type is 0x03 or 0x02 and peer is present
> +		 * in Kernel IRK list, but not in resolving add the peer to
> +		 * the resolving list.
> +		 */
> +		if (own_addr_type == 0x03 || own_addr_type == 0x02)
> +			hci_req_check_and_update_resolving_list(hdev, conn->dst_type,
> +								&conn->dst);
> +

I am failing to understand this part. The address should have been in the resolving list already. Either via Load Identify Resolving Keys mgmt command or from the SMP pairing. Doing that at time when calling Create Connection seems wrong. It should be independent from that.

> 		if (scan_1m(hdev)) {
> 			cp->phys |= LE_SCAN_PHY_1M;
> 			set_ext_conn_params(conn, p);
> @@ -866,6 +874,14 @@ static void hci_req_add_le_create_conn(struct hci_request *req,
> 		cp.scan_interval = cpu_to_le16(hdev->le_scan_interval);
> 		cp.scan_window = cp.scan_interval;
> 
> +		/* If the own_addr_type is 0x03 or 0x02 and peer is present
> +		 * in Kernel IRK list, but not in resolving add the peer to
> +		 * the resolving list.
> +		 */
> +		if (own_addr_type == 0x03 || own_addr_type == 0x02)
> +			hci_req_check_and_update_resolving_list(hdev, conn->dst_type,
> +								&conn->dst);
> +
> 		bacpy(&cp.peer_addr, &conn->dst);
> 		cp.peer_addr_type = conn->dst_type;
> 		cp.own_address_type = own_addr_type;
> @@ -901,6 +917,14 @@ static void hci_req_directed_advertising(struct hci_request *req,
> 					   &own_addr_type, &random_addr) < 0)
> 			return;
> 
> +		/* If the own_addr_type is 0x03 or 0x02 and peer is present
> +		 * in Kernel IRK list, but not in resolving add the peer to
> +		 * the resolving list.
> +		 */
> +		if (own_addr_type == 0x03 || own_addr_type == 0x03)
> +			hci_req_check_and_update_resolving_list(hdev, conn->dst_type,
> +								&conn->dst);
> +
> 		memset(&cp, 0, sizeof(cp));
> 
> 		cp.evt_properties = cpu_to_le16(LE_LEGACY_ADV_DIRECT_IND);
> @@ -959,6 +983,14 @@ static void hci_req_directed_advertising(struct hci_request *req,
> 					      &own_addr_type) < 0)
> 			return;
> 
> +		/* If the own_addr_type is 0x03 or 0x02 and peer is present
> +		 * in Kernel IRK list, but not in resolving add the peer to
> +		 * the resolving list.
> +		 */
> +		if (own_addr_type == 0x03 || own_addr_type == 0x02)
> +			hci_req_check_and_update_resolving_list(hdev, conn->dst_type,
> +								&conn->dst);
> +

We just keep repeating this code. It doesn’t look right.

> 		memset(&cp, 0, sizeof(cp));
> 
> 		/* Some controllers might reject command if intervals are not
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index dbd2ad3a26ed..7727be922084 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -713,7 +713,7 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
> 		/* If the controller supports the LE Extended Create Connection
> 		 * command, enable the corresponding event.
> 		 */
> -		if (use_ext_conn(hdev))
> +		if (use_ext_conn(hdev) || hdev->le_features[0] & HCI_LE_LL_PRIVACY)
> 			events[1] |= 0x02;      /* LE Enhanced Connection
> 						 * Complete
> 						 */

I do not get this change.

> @@ -762,6 +762,24 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
> 			hci_req_add(req, HCI_OP_LE_CLEAR_RESOLV_LIST, 0, NULL);
> 		}
> 
> +		if (hdev->commands[35] & 0x02) {
> +			u8 addr_resoln_enable = 0x01;

I don’t know what resoln is suppose to stand for.

> +
> +			/* Enable Address Resolution in controller */
> +			hci_req_add(req, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE,
> +				    sizeof(addr_resoln_enable),
> +				    &addr_resoln_enable);
> +		}
> +
> +		if (hdev->commands[35] & 0x40) {
> +			__le16 rpa_timeout = cpu_to_le16(hdev->rpa_timeout);
> +
> +			/* Set RPA timeout */
> +			hci_req_add(req, HCI_OP_LE_SET_RPA_TIMEOUT, 2,
> +				    &rpa_timeout);
> +
> +		}
> +

I think you should be adding RPA timeout handling in a separate patch. It is also important to note that there is a debugfs setting that should be capable of changing this value at runtime.

> 		if (hdev->le_features[0] & HCI_LE_DATA_LEN_EXT) {
> 			/* Read LE Maximum Data Length */
> 			hci_req_add(req, HCI_OP_LE_READ_MAX_DATA_LEN, 0, NULL);
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 20408d386268..d5ce1921fadd 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1684,7 +1684,11 @@ static void hci_cc_set_adv_param(struct hci_dev *hdev, struct sk_buff *skb)
> 		return;
> 
> 	hci_dev_lock(hdev);
> -	hdev->adv_addr_type = cp->own_address_type;
> +
> +	if (cp->own_address_type == ADDR_LE_DEV_PUBLIC)
> +		hdev->adv_addr_type = ADDR_LE_DEV_PUBLIC;
> +	else
> +		hdev->adv_addr_type = ADDR_LE_DEV_RANDOM;

I don’t get this change.

> 	hci_dev_unlock(hdev);
> }
> 
> @@ -1704,7 +1708,12 @@ static void hci_cc_set_ext_adv_param(struct hci_dev *hdev, struct sk_buff *skb)
> 		return;
> 
> 	hci_dev_lock(hdev);
> -	hdev->adv_addr_type = cp->own_addr_type;
> +
> +	if (cp->own_addr_type == ADDR_LE_DEV_PUBLIC)
> +		hdev->adv_addr_type = ADDR_LE_DEV_PUBLIC;
> +	else
> +		hdev->adv_addr_type = ADDR_LE_DEV_RANDOM;
> +

Same as above. I fail to see why this is important.

> 	if (!hdev->cur_adv_instance) {
> 		/* Store in hdev for instance 0 */
> 		hdev->adv_tx_power = rp->tx_power;
> @@ -2267,11 +2276,13 @@ static void cs_le_create_conn(struct hci_dev *hdev, bdaddr_t *peer_addr,
> 	 * is needed for SMP. These values will not change during the
> 	 * lifetime of the connection.
> 	 */
> -	conn->init_addr_type = own_address_type;
> -	if (own_address_type == ADDR_LE_DEV_RANDOM)
> +	if (own_address_type == 0x03 || own_address_type == 0x01) {
> +		conn->init_addr_type = ADDR_LE_DEV_RANDOM;
> 		bacpy(&conn->init_addr, &hdev->random_addr);
> -	else
> +	} else {
> +		conn->init_addr_type = ADDR_LE_DEV_PUBLIC;
> 		bacpy(&conn->init_addr, &hdev->bdaddr);
> +	}

This requires an appropriate comment change as well.

> 
> 	conn->resp_addr_type = peer_addr_type;
> 	bacpy(&conn->resp_addr, peer_addr);
> @@ -5141,6 +5152,8 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
> 		}
> 	}
> 
> +	hci_req_check_and_update_resolving_list(hdev, (conn->dst_type), &conn->dst);
> +
> unlock:
> 	hci_update_background_scan(hdev);
> 	hci_dev_unlock(hdev);
> @@ -5365,8 +5378,13 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
> 		/* Only resolvable random addresses are valid for these
> 		 * kind of reports and others can be ignored.
> 		 */
> -		if (!hci_bdaddr_is_rpa(direct_addr, direct_addr_type))
> -			return;
> +		if (!hci_bdaddr_is_rpa(direct_addr, direct_addr_type)) {
> +			/* Controller with LL Privacy Supported tend to resolve
> +			 * the RPA. In that case we should ignore this condition
> +			 */
> +			if ( !(hdev->le_features[0] & HCI_LE_LL_PRIVACY))
> +				return;

Please obey the coding style.

And just checking the existence of feature bit is not enough. We also need to check that the feature is active and actually used in this case.

> +		}
> 
> 		/* If the controller is not using resolvable random
> 		 * addresses, then this report can be ignored.
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index 6b685cdc7de5..12868caf50ea 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -1916,7 +1916,12 @@ int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
> 	if (use_rpa) {
> 		int to;
> 
> -		*own_addr_type = ADDR_LE_DEV_RANDOM;
> +		if (hdev->le_features[0] & HCI_LE_LL_PRIVACY) {
> +			/*if there is no resolving list used in the controller
> +			 * use the bd_addr from latest Le_set_random_address*/
> +			*own_addr_type = 0x03;
> +		} else
> +			*own_addr_type = ADDR_LE_DEV_RANDOM;

I really don’t see how this is going to work. Local privacy can off and maybe remote device don’t use privacy. As noted above the le_features bit is not an indicate if LL Privacy is in use.

In addition, please get the coding style right.
> 
> 		if (adv_instance) {
> 			if (!adv_instance->rpa_expired &&
> @@ -2074,7 +2079,7 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
> 
> 	hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_PARAMS, sizeof(cp), &cp);
> 
> -	if (own_addr_type == ADDR_LE_DEV_RANDOM &&
> +	if (((own_addr_type == ADDR_LE_DEV_RANDOM) || (own_addr_type == 0x03)) &&

The extra (x == y) are not needed and it might be a good idea to introduce constants for 0x02 and 0x03 early on.

> 	    bacmp(&random_addr, BDADDR_ANY)) {
> 		struct hci_cp_le_set_adv_set_rand_addr cp;
> 
> @@ -2341,7 +2346,12 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
> 	if (use_rpa) {
> 		int to;
> 
> -		*own_addr_type = ADDR_LE_DEV_RANDOM;
> +		if (hdev->le_features[0] & HCI_LE_LL_PRIVACY) {
> +			/*if there is no resolving list used in the controller
> +			 * use the bd_addr from latest Le_set_random_address*/
> +			*own_addr_type = 0x03;
> +		} else
> +			*own_addr_type = ADDR_LE_DEV_RANDOM;

I really need to stop reviewing patches where the coding style mistakes are this many.

> 
> 		if (!hci_dev_test_and_clear_flag(hdev, HCI_RPA_EXPIRED) &&
> 		    !bacmp(&hdev->random_addr, &hdev->rpa))
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 6552003a170e..2b2bc011a130 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -5084,8 +5084,10 @@ static int set_debug_keys(struct sock *sk, struct hci_dev *hdev,
> 	if (err < 0)
> 		goto unlock;
> 
> -	if (changed)
> +	if (changed) {
> 		err = new_settings(hdev, sk);
> +		hci_req_update_resolving_list_local_irk(hdev);
> +	}
> 
> unlock:
> 	hci_dev_unlock(hdev);
> @@ -5227,6 +5229,8 @@ static int load_irks(struct sock *sk, struct hci_dev *hdev, void *cp_data,
> 			    BDADDR_ANY);
> 	}
> 
> +	/* Load the resolving list with entries from IRK list.*/
> +	hci_load_resolving_list(hdev);
> 	hci_dev_set_flag(hdev, HCI_RPA_RESOLVING);
> 
> 	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_LOAD_IRKS, 0, NULL, 0);
> @@ -7213,6 +7217,10 @@ void mgmt_power_on(struct hci_dev *hdev, int err)
> 	if (match.sk)
> 		sock_put(match.sk);
> 
> +	/* If load _irk was called when controller was powered down,
> +	 * then the resolving list has to be updated now.
> +	 */
> +	hci_load_resolving_list(hdev);
> 	hci_dev_unlock(hdev);
> }
> 
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index 1476a91ce935..85be3f5d869a 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -2425,6 +2425,8 @@ int smp_cancel_and_remove_pairing(struct hci_dev *hdev, bdaddr_t *bdaddr,
> 	struct smp_chan *smp;
> 	int err;
> 
> +	hci_req_del_from_resolving_list(hdev, addr_type, bdaddr);
> +
> 	err = hci_remove_ltk(hdev, bdaddr, addr_type);
> 	hci_remove_irk(hdev, bdaddr, addr_type);
> 
> @@ -2619,6 +2621,15 @@ static int smp_cmd_ident_addr_info(struct l2cap_conn *conn,
> 	smp->remote_irk = hci_add_irk(conn->hcon->hdev, &smp->id_addr,
> 				      smp->id_addr_type, smp->irk, &rpa);
> 
> +	/* Add the device to the resolving list.*/
> +	hci_req_update_resolving_list(conn->hcon->hdev,
> +					      smp->remote_irk->addr_type,
> +					      &smp->remote_irk->bdaddr,
> +					      smp->remote_irk->val);
> +
> +
> +	/*TODO:  Check remote device Supports LL Privacy. If not set the device
> +	 * with IRK to Device-privacy Mode - Should be discussed - Based on */

I rather have this fixed instead of keeping a TODO in here.

> distribute:
> 	if (!(smp->remote_key_dist & KEY_DIST_MASK))
> 		smp_distribute_keys(smp);

Regards

Marcel

