Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH] Bluetooth: Add support for limited privacy mode
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1457522545-30785-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 9 Mar 2016 07:03:15 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C144B935-3349-41BF-8D3D-46EC6E9C9DBF@holtmann.org>
References: <1457522545-30785-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Introduce a limited privacy mode indicated by value 0x02 to the mgmt
> Set Privacy command.
> 
> With value 0x02 the kernel will use privacy mode with a resolvable
> private address. In case the controller is bondable and discoverable
> the identity address will be used. Also, when not previously paired,
> connections will be established with the identity address.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci.h |  1 +
> net/bluetooth/hci_conn.c    | 31 ++++++++++++++++++++++----
> net/bluetooth/hci_request.c | 54 ++++++++++++++++++++++++++++++++++++++++-----
> net/bluetooth/hci_request.h |  2 +-
> net/bluetooth/mgmt.c        | 20 +++++++++++++++--
> 5 files changed, 95 insertions(+), 13 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 339ea57be423..5d38d980b89d 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -233,6 +233,7 @@ enum {
> 	HCI_SC_ENABLED,
> 	HCI_SC_ONLY,
> 	HCI_PRIVACY,
> +	HCI_LIMITED_PRIVACY,
> 	HCI_RPA_EXPIRED,
> 	HCI_RPA_RESOLVING,
> 	HCI_HS_ENABLED,
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 32575b49f4a0..85e46fd9c50b 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -719,6 +719,27 @@ done:
> 	hci_dev_unlock(hdev);
> }
> 
> +static bool conn_use_rpa(struct hci_conn *conn)
> +{
> +	struct hci_dev *hdev = conn->hdev;
> +
> +	/* If privacy is not enabled don't use RPA */
> +	if (!hci_dev_test_flag(hdev, HCI_PRIVACY))
> +		return false;
> +
> +	/* If privacy is enabled in the basic mode use RPA */
> +	if (!hci_dev_test_flag(hdev, HCI_LIMITED_PRIVACY))
> +		return true;
> +
> +	/* If the limited privacy mode is enabled use an RPA only if
> +	 * we're already paired.
> +	 */
> +	if (hci_find_ltk(hdev, &conn->dst, conn->dst_type, conn->role))
> +		return true;
> +
> +	return false;
> +}
> +
> static void hci_req_add_le_create_conn(struct hci_request *req,
> 				       struct hci_conn *conn)
> {
> @@ -726,14 +747,15 @@ static void hci_req_add_le_create_conn(struct hci_request *req,
> 	struct hci_dev *hdev = conn->hdev;
> 	u8 own_addr_type;
> 
> -	memset(&cp, 0, sizeof(cp));
> -
> 	/* Update random address, but set require_privacy to false so
> 	 * that we never connect with an non-resolvable address.
> 	 */
> -	if (hci_update_random_address(req, false, &own_addr_type))
> +	if (hci_update_random_address(req, false, conn_use_rpa(conn),
> +				      &own_addr_type))
> 		return;

so this is something I really wonder if that is needed at all. If we create a connection, I think we should always create it with the RPA. I mean if we do not connect with the RPA, then on every connection attempt we leak the identity address. My thinking of the mode 0x02 was that when we are going to make ourselves discoverable, then we allow the identity address to be revealed. Mainly since that is what happens on BR/EDR when it becomes discoverable. Leaking the address when initiating connections seems unclear.

However if that is wanted, then I rather also add mode 0x03 that goes one step further, but for mode 0x02 this seems a bit too much.

To ask the question a different way around, what benefit does it have to connect with the identity address. If the peripheral cares to learn our identity it can trigger pairing with no bonding and retrieve our IRK. So it is not that it can not learn the address.

> 
> +	memset(&cp, 0, sizeof(cp));
> +

Don't get this memset moving around.

> 	/* Set window to be the same value as the interval to enable
> 	 * continuous scanning.
> 	 */
> @@ -774,7 +796,8 @@ static void hci_req_directed_advertising(struct hci_request *req,
> 	/* Set require_privacy to false so that the remote device has a
> 	 * chance of identifying us.
> 	 */
> -	if (hci_update_random_address(req, false, &own_addr_type) < 0)
> +	if (hci_update_random_address(req, false, conn_use_rpa(conn),
> +				      &own_addr_type) < 0)
> 		return;
> 
> 	memset(&cp, 0, sizeof(cp));
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index c78ee2dc9323..95a545ca9dbc 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -771,6 +771,11 @@ static u8 update_white_list(struct hci_request *req)
> 	return 0x01;
> }
> 
> +static bool scan_use_rpa(struct hci_dev *hdev)
> +{
> +	return hci_dev_test_flag(hdev, HCI_PRIVACY);
> +}
> +
> void hci_req_add_le_passive_scan(struct hci_request *req)
> {
> 	struct hci_cp_le_set_scan_param param_cp;
> @@ -785,7 +790,8 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
> 	 * advertising with our address will be correctly reported
> 	 * by the controller.
> 	 */
> -	if (hci_update_random_address(req, false, &own_addr_type))
> +	if (hci_update_random_address(req, false, scan_use_rpa(hdev),
> +				      &own_addr_type))
> 		return;
> 
> 	/* Adding or removing entries from the white list must
> @@ -866,6 +872,9 @@ static u32 get_adv_instance_flags(struct hci_dev *hdev, u8 instance)
> 		if (hci_dev_test_flag(hdev, HCI_ADVERTISING_CONNECTABLE))
> 			flags |= MGMT_ADV_FLAG_CONNECTABLE;
> 
> +		if (hci_dev_test_flag(hdev, HCI_DISCOVERABLE))
> +			flags |= MGMT_ADV_FLAG_DISCOV;
> +

Seems unrelated to this patch. Is this a bug we already have?

> 		return flags;
> 	}
> 
> @@ -878,6 +887,29 @@ static u32 get_adv_instance_flags(struct hci_dev *hdev, u8 instance)
> 	return adv_instance->flags;
> }
> 
> +static bool adv_use_rpa(struct hci_dev *hdev, uint32_t flags)
> +{
> +	/* If privacy is not enabled don't use RPA */
> +	if (!hci_dev_test_flag(hdev, HCI_PRIVACY))
> +		return false;
> +
> +	/* If basic privacy mode is enabled use RPA */
> +	if (!hci_dev_test_flag(hdev, HCI_LIMITED_PRIVACY))
> +		return true;
> +
> +	/* If limited privacy mode is enabled don't use RPA if we're
> +	 * both discoverable and bondable.
> +	 */
> +	if ((flags & MGMT_ADV_FLAG_DISCOV) &&
> +	    hci_dev_test_flag(hdev, HCI_BONDABLE))
> +		return false;
> +
> +	/* We're neither bondable nor discoverable in the limited
> +	 * privacy mode, therefore use RPA.
> +	 */
> +	return true;
> +}
> +
> void __hci_req_enable_advertising(struct hci_request *req)
> {
> 	struct hci_dev *hdev = req->hdev;
> @@ -911,7 +943,9 @@ void __hci_req_enable_advertising(struct hci_request *req)
> 	 * advertising is used. In that case it is fine to use a
> 	 * non-resolvable private address.
> 	 */
> -	if (hci_update_random_address(req, !connectable, &own_addr_type) < 0)
> +	if (hci_update_random_address(req, !connectable,
> +				      adv_use_rpa(hdev, flags),
> +				      &own_addr_type) < 0)
> 		return;
> 
> 	memset(&cp, 0, sizeof(cp));
> @@ -1325,7 +1359,7 @@ static void set_random_addr(struct hci_request *req, bdaddr_t *rpa)
> }
> 
> int hci_update_random_address(struct hci_request *req, bool require_privacy,
> -			      u8 *own_addr_type)
> +			      bool use_rpa, u8 *own_addr_type)
> {
> 	struct hci_dev *hdev = req->hdev;
> 	int err;
> @@ -1334,7 +1368,7 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
> 	 * current RPA has expired or there is something else than
> 	 * the current RPA in use, then generate a new one.
> 	 */
> -	if (hci_dev_test_flag(hdev, HCI_PRIVACY)) {
> +	if (use_rpa) {
> 		int to;
> 
> 		*own_addr_type = ADDR_LE_DEV_RANDOM;
> @@ -1596,9 +1630,16 @@ static int discoverable_update(struct hci_request *req, unsigned long opt)
> 	/* Advertising instances don't use the global discoverable setting, so
> 	 * only update AD if advertising was enabled using Set Advertising.
> 	 */
> -	if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
> +	if (hci_dev_test_flag(hdev, HCI_ADVERTISING)) {
> 		__hci_req_update_adv_data(req, 0x00);
> 
> +		/* Discoverable mode affects the local advertising
> +		 * address in limited privacy mode.
> +		 */
> +		if (hci_dev_test_flag(hdev, HCI_LIMITED_PRIVACY))
> +			__hci_req_enable_advertising(req);

Isn't this unbalanced now. I do not want to end up in the case where we try to enable advertising twice.

> +	}
> +
> 	hci_dev_unlock(hdev);
> 
> 	return 0;
> @@ -1941,7 +1982,8 @@ static int active_scan(struct hci_request *req, unsigned long opt)
> 	 * address (when privacy feature has been enabled) or non-resolvable
> 	 * private address.
> 	 */
> -	err = hci_update_random_address(req, true, &own_addr_type);
> +	err = hci_update_random_address(req, true, scan_use_rpa(hdev),
> +					&own_addr_type);
> 	if (err < 0)
> 		own_addr_type = ADDR_LE_DEV_PUBLIC;
> 
> diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
> index 64ff8c040d50..b2d044bdc732 100644
> --- a/net/bluetooth/hci_request.h
> +++ b/net/bluetooth/hci_request.h
> @@ -89,7 +89,7 @@ static inline void hci_req_update_scan(struct hci_dev *hdev)
> void __hci_req_update_scan(struct hci_request *req);
> 
> int hci_update_random_address(struct hci_request *req, bool require_privacy,
> -			      u8 *own_addr_type);
> +			      bool use_rpa, u8 *own_addr_type);
> 
> int hci_abort_conn(struct hci_conn *conn, u8 reason);
> void __hci_abort_conn(struct hci_request *req, struct hci_conn *conn,
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 5a5089cb6570..2ca355519d79 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -1382,8 +1382,19 @@ static int set_bondable(struct sock *sk, struct hci_dev *hdev, void *data,
> 	if (err < 0)
> 		goto unlock;
> 
> -	if (changed)
> +	if (changed) {
> +		/* In limited privacy mode the change of bondable mode
> +		 * may affect the local advertising address.
> +		 */
> +		if (hdev_is_powered(hdev) &&
> +		    hci_dev_test_flag(hdev, HCI_ADVERTISING) &&
> +		    hci_dev_test_flag(hdev, HCI_DISCOVERABLE) &&
> +		    hci_dev_test_flag(hdev, HCI_LIMITED_PRIVACY))
> +			queue_work(hdev->req_workqueue,
> +				   &hdev->discoverable_update);
> +
> 		err = new_settings(hdev, sk);
> +	}
> 
> unlock:
> 	hci_dev_unlock(hdev);
> @@ -4423,7 +4434,7 @@ static int set_privacy(struct sock *sk, struct hci_dev *hdev, void *cp_data,
> 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_PRIVACY,
> 				       MGMT_STATUS_NOT_SUPPORTED);
> 
> -	if (cp->privacy != 0x00 && cp->privacy != 0x01)
> +	if (cp->privacy != 0x00 && cp->privacy != 0x01 && cp->privacy != 0x02)
> 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_PRIVACY,
> 				       MGMT_STATUS_INVALID_PARAMS);
> 
> @@ -4442,10 +4453,15 @@ static int set_privacy(struct sock *sk, struct hci_dev *hdev, void *cp_data,
> 		changed = !hci_dev_test_and_set_flag(hdev, HCI_PRIVACY);
> 		memcpy(hdev->irk, cp->irk, sizeof(hdev->irk));
> 		hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
> +		if (cp->privacy == 0x02)
> +			hci_dev_set_flag(hdev, HCI_LIMITED_PRIVACY);
> +		else
> +			hci_dev_clear_flag(hdev, HCI_LIMITED_PRIVACY);
> 	} else {
> 		changed = hci_dev_test_and_clear_flag(hdev, HCI_PRIVACY);
> 		memset(hdev->irk, 0, sizeof(hdev->irk));
> 		hci_dev_clear_flag(hdev, HCI_RPA_EXPIRED);
> +		hci_dev_clear_flag(hdev, HCI_LIMITED_PRIVACY);
> 	}
> 
> 	err = send_settings_rsp(sk, MGMT_OP_SET_PRIVACY, hdev);

Regards

Marcel

