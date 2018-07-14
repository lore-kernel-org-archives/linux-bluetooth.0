Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH v4 12/13] Bluetooth: Implement Set ADV set random address
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1531301495-14479-13-git-send-email-jaganathx.kanakkassery@intel.com>
Date: Sat, 14 Jul 2018 22:52:34 +0200
Cc: linux-bluetooth@vger.kernel.org,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Message-Id: <52A6E0AC-1A7D-4AD1-97C6-FDED78E38C78@holtmann.org>
References: <1531301495-14479-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1531301495-14479-13-git-send-email-jaganathx.kanakkassery@intel.com>
To: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

> This basically sets the random address for the instance 0.
> Random address can be set only if the instance is created which
> is done in Set ext adv param.
> 
> This introduces a hci_get_random_address() which returns the
> own address type and random address (rpa, nrpa or static) based
> on the instance flags and hdev flags. New function is required
> since own address type should be known before setting adv params
> but address can be set only after setting params.
> 
> < HCI Command: LE Set Advertising Set Random Address (0x08|0x0035) plen 7
>        Advertising handle: 0x00
>        Advertising random address: 3C:8E:56:9B:77:84 (OUI 3C-8E-56)
>> HCI Event: Command Complete (0x0e) plen 4
>      LE Set Advertising Set Random Address (0x08|0x0035) ncmd 1
>        Status: Success (0x00)
> 
> Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
> ---
> include/net/bluetooth/hci.h |   6 +++
> net/bluetooth/hci_conn.c    |  23 +++++++++
> net/bluetooth/hci_event.c   |  24 ++++++++++
> net/bluetooth/hci_request.c | 111 +++++++++++++++++++++++++++++++++++++++++++-
> net/bluetooth/hci_request.h |   3 ++
> 5 files changed, 166 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 1a68530..40a532a 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1655,6 +1655,12 @@ struct hci_cp_le_remove_adv_set {
> 
> #define HCI_OP_LE_CLEAR_ADV_SETS	0x203d
> 
> +#define HCI_OP_LE_SET_ADV_SET_RAND_ADDR	0x2035
> +struct hci_cp_le_set_adv_set_rand_addr {
> +	__u8  handle;
> +	bdaddr_t  bdaddr;
> +} __packed;
> +
> /* ---- HCI Events ---- */
> #define HCI_EV_INQUIRY_COMPLETE		0x01
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index fc27bd8..cf180b24 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -875,6 +875,14 @@ static void hci_req_directed_advertising(struct hci_request *req,
> 
> 	if (ext_adv_capable(hdev)) {
> 		struct hci_cp_le_set_ext_adv_params cp;
> +		bdaddr_t random_addr;
> +
> +		/* Set require_privacy to false so that the remote device has a
> +		 * chance of identifying us.
> +		 */
> +		if (hci_get_random_address(hdev, false, conn_use_rpa(conn),
> +					   &own_addr_type, &random_addr) < 0)
> +			return;
> 
> 		memset(&cp, 0, sizeof(cp));
> 
> @@ -891,6 +899,21 @@ static void hci_req_directed_advertising(struct hci_request *req,
> 
> 		hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_PARAMS, sizeof(cp), &cp);
> 
> +		if (own_addr_type == ADDR_LE_DEV_RANDOM &&
> +		    bacmp(&random_addr, BDADDR_ANY) &&
> +		    bacmp(&random_addr, &hdev->random_addr)) {
> +			struct hci_cp_le_set_adv_set_rand_addr cp;
> +
> +			memset(&cp, 0, sizeof(cp));
> +
> +			cp.handle = 0;
> +			bacpy(&cp.bdaddr, &random_addr);
> +
> +			hci_req_add(req,
> +				    HCI_OP_LE_SET_ADV_SET_RAND_ADDR,
> +				    sizeof(cp), &cp);
> +		}
> +
> 		__hci_req_enable_ext_advertising(req);
> 	} else {
> 		struct hci_cp_le_set_adv_param cp;
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index e703880..dfb2a82 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1061,6 +1061,26 @@ static void hci_cc_le_set_default_phy(struct hci_dev *hdev, struct sk_buff *skb)
> 	hdev->le_tx_def_phys = cp->tx_phys;
> 	hdev->le_rx_def_phys = cp->rx_phys;
> 
> +        hci_dev_unlock(hdev);

We have some whitespace damage here.

> +}
> +
> +static void hci_cc_le_set_adv_set_random_addr(struct hci_dev *hdev,
> +                                              struct sk_buff *skb)
> +{
> +        __u8 status = *((__u8 *) skb->data);
> +        struct hci_cp_le_set_adv_set_rand_addr *cp;
> +
> +	if (status)
> +		return;
> +
> +	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_ADV_SET_RAND_ADDR);
> +	if (!cp)
> +		return;
> +
> +	hci_dev_lock(hdev);
> +
> +	bacpy(&hdev->random_addr, &cp->bdaddr);

Same as with hdev->adv_tx_power, you can not do that. You need to store these per adv instance. I really like to keep the parts that we used for legacy commands different than others.

> +
> 	hci_dev_unlock(hdev);
> }
> 
> @@ -3272,6 +3292,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
> 		hci_cc_le_set_ext_adv_enable(hdev, skb);
> 		break;
> 
> +	case HCI_OP_LE_SET_ADV_SET_RAND_ADDR:
> +		hci_cc_le_set_adv_set_random_addr(hdev, skb);
> +		break;
> +
> 	default:
> 		BT_DBG("%s opcode 0x%4.4x", hdev->name, *opcode);
> 		break;
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index 7051c5b..6825a65 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -1427,6 +1427,87 @@ static void adv_timeout_expire(struct work_struct *work)
> 	hci_dev_unlock(hdev);
> }
> 
> +int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
> +			   bool use_rpa, u8 *own_addr_type, bdaddr_t *rand_addr)
> +{
> +	int err;
> +
> +	bacpy(rand_addr, BDADDR_ANY);
> +
> +	/* If privacy is enabled use a resolvable private address. If
> +	 * current RPA has expired then generate a new one.
> +	 */
> +	if (use_rpa) {
> +		*own_addr_type = ADDR_LE_DEV_RANDOM;
> +
> +		if (!hci_dev_test_and_clear_flag(hdev, HCI_RPA_EXPIRED) &&
> +		    !bacmp(&hdev->random_addr, &hdev->rpa))
> +			return 0;
> +
> +		err = smp_generate_rpa(hdev, hdev->irk, &hdev->rpa);
> +		if (err < 0) {
> +			BT_ERR("%s failed to generate new RPA", hdev->name);
> +			return err;
> +		}
> +
> +		bacpy(rand_addr, &hdev->rpa);
> +
> +		return 0;
> +	}
> +
> +	/* In case of required privacy without resolvable private address,
> +	 * use an non-resolvable private address. This is useful for active
> +	 * scanning and non-connectable advertising.
> +	 */
> +	if (require_privacy) {
> +		bdaddr_t nrpa;
> +
> +		while (true) {
> +			/* The non-resolvable private address is generated
> +			 * from random six bytes with the two most significant
> +			 * bits cleared.
> +			 */
> +			get_random_bytes(&nrpa, 6);
> +			nrpa.b[5] &= 0x3f;
> +
> +			/* The non-resolvable private address shall not be
> +			 * equal to the public address.
> +			 */
> +			if (bacmp(&hdev->bdaddr, &nrpa))
> +				break;
> +		}
> +
> +		*own_addr_type = ADDR_LE_DEV_RANDOM;
> +		bacpy(rand_addr, &nrpa);
> +
> +		return 0;
> +	}
> +
> +	/* If forcing static address is in use or there is no public
> +	 * address use the static address as random address
> +	 *
> +	 * In case BR/EDR has been disabled on a dual-mode controller
> +	 * and a static address has been configured, then use that
> +	 * address instead of the public BR/EDR address.
> +	 */
> +	if (hci_dev_test_flag(hdev, HCI_FORCE_STATIC_ADDR) ||
> +	    !bacmp(&hdev->bdaddr, BDADDR_ANY) ||
> +	    (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED) &&
> +	     bacmp(&hdev->static_addr, BDADDR_ANY))) {
> +		*own_addr_type = ADDR_LE_DEV_RANDOM;
> +		bacpy(rand_addr, &hdev->static_addr);
> +
> +		return 0;
> +	}
> +
> +	/* Neither privacy nor static address is being used so use a
> +	 * public address.
> +	 */
> +	*own_addr_type = ADDR_LE_DEV_PUBLIC;
> +
> +	return 0;
> +}
> +

So I am not convinced that we need all of this. For example we only use this for advertising. So our decision for active scanning is useless.

What I think is best that we actually add rand_addr to the adv instance structure and just calculate what random address we want to use ahead of time and keep it stored in the instance. I mean, we want to rotate the address for each instance independently.

> void __hci_req_clear_ext_adv_sets(struct hci_request *req)
> {
> 	hci_req_add(req, HCI_OP_LE_REMOVE_ADV_SET, 0, NULL);
> @@ -1438,6 +1519,9 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
> 	struct hci_dev *hdev = req->hdev;
> 	bool connectable;
> 	u32 flags;
> +	bdaddr_t random_addr;
> +	u8 own_addr_type;
> +	int err;
> 	/* In ext adv set param interval is 3 octets */
> 	const u8 adv_interval[3] = { 0x00, 0x08, 0x00 };
> 
> @@ -1452,6 +1536,16 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
> 	 if (!is_advertising_allowed(hdev, connectable))
> 		return -EPERM;
> 
> +	/* Set require_privacy to true only when non-connectable
> +	 * advertising is used. In that case it is fine to use a
> +	 * non-resolvable private address.
> +	 */
> +	err = hci_get_random_address(hdev, !connectable,
> +				     adv_use_rpa(hdev, flags),
> +				     &own_addr_type, &random_addr);
> +	if (err < 0)
> +		return err;
> +
> 	memset(&cp, 0, sizeof(cp));
> 
> 	memcpy(cp.min_interval, adv_interval, sizeof(cp.min_interval));
> @@ -1464,7 +1558,7 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
> 	else
> 		cp.evt_properties = cpu_to_le16(LE_LEGACY_NONCONN_IND);
> 
> -	cp.own_addr_type = BDADDR_LE_PUBLIC;
> +	cp.own_addr_type = own_addr_type;
> 	cp.channel_map = hdev->le_adv_channel_map;
> 	cp.tx_power = 127;
> 	cp.primary_phy = HCI_ADV_PHY_1M;
> @@ -1473,6 +1567,21 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
> 
> 	hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_PARAMS, sizeof(cp), &cp);
> 
> +	if (own_addr_type == ADDR_LE_DEV_RANDOM &&
> +	    bacmp(&random_addr, BDADDR_ANY) &&
> +	    bacmp(&random_addr, &hdev->random_addr)) {

This really needs to have to compare it per instance. Which means we might actually track the settings for each adv set. So even while initially we only map all instances to a single adv set, we should still track what the current adv set has in it.

> +		struct hci_cp_le_set_adv_set_rand_addr cp;
> +
> +		memset(&cp, 0, sizeof(cp));
> +
> +		cp.handle = 0;
> +		bacpy(&cp.bdaddr, &random_addr);
> +
> +		hci_req_add(req,
> +			    HCI_OP_LE_SET_ADV_SET_RAND_ADDR,
> +			    sizeof(cp), &cp);
> +	}
> +
> 	return 0;
> }
> 
> diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
> index 2451861..5329faf 100644
> --- a/net/bluetooth/hci_request.h
> +++ b/net/bluetooth/hci_request.h
> @@ -84,6 +84,9 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance);
> int __hci_req_start_ext_adv(struct hci_request *req, u8 instance);
> void __hci_req_enable_ext_advertising(struct hci_request *req);
> void __hci_req_clear_ext_adv_sets(struct hci_request *req);
> +int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
> +			   bool use_rpa, u8 *own_addr_type,
> +			   bdaddr_t *rand_addr);
> 

Regards

Marcel

