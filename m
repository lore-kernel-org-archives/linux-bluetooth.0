Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH v7 4/6] Bluetooth: advertisement handling in new connect procedure
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1438694299-5991-4-git-send-email-jpawlowski@google.com>
Date: Tue, 4 Aug 2015 18:47:10 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <2D952E7F-7A09-4BA4-8E21-C21DA79611B4@holtmann.org>
References: <1438694299-5991-1-git-send-email-jpawlowski@google.com> <1438694299-5991-4-git-send-email-jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> Currently, when trying to connect to already paired device that just
> rotated its RPA MAC address, old address would be used and connection
> would fail. In order to fix that, kernel must scan and receive
> advertisement with fresh RPA before connecting.
> 
> This path makes sure that after advertisement is received from device that
> we try to connect to, it is properly handled in check_pending_le_conn and
> trigger connect attempt.
> 
> It also modifies hci_le_connect to make sure that connect attempt will be
> properly continued.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
> net/bluetooth/hci_conn.c  | 48 ++++++++++++++++++++++++++++++--------------
> net/bluetooth/hci_event.c | 51 +++++++++++++++++++++++++++--------------------
> net/bluetooth/mgmt.c      |  6 ++++++
> 3 files changed, 68 insertions(+), 37 deletions(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index a74c636..64aaee3 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -667,15 +667,18 @@ static void create_le_conn_complete(struct hci_dev *hdev, u8 status, u16 opcode)
> {
> 	struct hci_conn *conn;
> 
> -	if (status == 0)
> -		return;
> +	hci_dev_lock(hdev);
> +
> +	conn = hci_lookup_le_connecting(hdev);
> +
> +	if (status == 0) {

Lets do if (!status) here if if the previous code did it differently.

> +		hci_connect_le_scan_cleanup(conn);
> +		goto done;
> +	}
> 
> 	BT_ERR("HCI request failed to create LE connection: status 0x%2.2x",
> 	       status);
> 
> -	hci_dev_lock(hdev);
> -
> -	conn = hci_lookup_le_connecting(hdev);
> 	if (!conn)
> 		goto done;
> 
> @@ -715,6 +718,7 @@ static void hci_req_add_le_create_conn(struct hci_request *req,
> 	hci_req_add(req, HCI_OP_LE_CREATE_CONN, sizeof(cp), &cp);
> 
> 	conn->state = BT_CONNECT;
> +	clear_bit(HCI_CONN_SCANNING, &conn->flags);
> }
> 
> static void hci_req_directed_advertising(struct hci_request *req,
> @@ -758,7 +762,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
> 				u8 role)
> {
> 	struct hci_conn_params *params;
> -	struct hci_conn *conn;
> +	struct hci_conn *conn, *conn_unfinished;
> 	struct smp_irk *irk;
> 	struct hci_request req;
> 	int err;
> @@ -781,9 +785,17 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
> 	 * and return the object found.
> 	 */
> 	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
> +	conn_unfinished = NULL;
> 	if (conn) {
> -		conn->pending_sec_level = sec_level;
> -		goto done;
> +		if (conn->state == BT_CONNECT &&
> +		    test_bit(HCI_CONN_SCANNING, &conn->flags)) {
> +			BT_DBG("will coninue unfinished conn %pMR", dst);

Lets write "continue" correctly.

> +			conn_unfinished = conn;
> +		} else {
> +			if (conn->pending_sec_level < sec_level)
> +				conn->pending_sec_level = sec_level;
> +			goto done;
> +		}
> 	}
> 
> 	/* Since the controller supports only one LE connection attempt at a
> @@ -796,10 +808,6 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
> 	 * resolving key, the connection needs to be established
> 	 * to a resolvable random address.
> 	 *
> -	 * This uses the cached random resolvable address from
> -	 * a previous scan. When no cached address is available,
> -	 * try connecting to the identity address instead.
> -	 *
> 	 * Storing the resolvable random address is required here
> 	 * to handle connection failures. The address will later
> 	 * be resolved back into the original identity address
> @@ -811,15 +819,23 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
> 		dst_type = ADDR_LE_DEV_RANDOM;
> 	}
> 
> -	conn = hci_conn_add(hdev, LE_LINK, dst, role);
> +	if (conn_unfinished) {
> +		conn = conn_unfinished;
> +		bacpy(&conn->dst, dst);
> +	} else {
> +		conn = hci_conn_add(hdev, LE_LINK, dst, role);
> +	}
> +
> 	if (!conn)
> 		return ERR_PTR(-ENOMEM);
> 
> 	conn->dst_type = dst_type;
> 	conn->sec_level = BT_SECURITY_LOW;
> -	conn->pending_sec_level = sec_level;
> 	conn->conn_timeout = conn_timeout;
> 
> +	if (!conn_unfinished)
> +		conn->pending_sec_level = sec_level;
> +
> 	hci_req_init(&req, hdev);
> 
> 	/* Disable advertising if we're active. For master role
> @@ -884,7 +900,9 @@ create_conn:
> 	}
> 
> done:
> -	hci_conn_hold(conn);
> +	if (!conn_unfinished)
> +		hci_conn_hold(conn);
> +

This part I do not really like. Reference counting based o the point being valid is something I find terrible to debug later on.

Why is this needed anyway? Don't we assign conn = conn_unfinished anyway?

> 	return conn;
> }
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 1859916..705c34f 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -4640,42 +4640,49 @@ static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
> 	/* If we're not connectable only connect devices that we have in
> 	 * our pend_le_conns list.
> 	 */
> -	params = hci_pend_le_action_lookup(&hdev->pend_le_conns,
> -					   addr, addr_type);
> +	params = hci_explicit_connect_lookup(hdev, addr, addr_type);
> +
> 	if (!params)
> 		return NULL;
> 
> -	switch (params->auto_connect) {
> -	case HCI_AUTO_CONN_DIRECT:
> -		/* Only devices advertising with ADV_DIRECT_IND are
> -		 * triggering a connection attempt. This is allowing
> -		 * incoming connections from slave devices.
> -		 */
> -		if (adv_type != LE_ADV_DIRECT_IND)
> +	if (!params->explicit_connect) {
> +		switch (params->auto_connect) {
> +		case HCI_AUTO_CONN_DIRECT:
> +			/* Only devices advertising with ADV_DIRECT_IND are
> +			 * triggering a connection attempt. This is allowing
> +			 * incoming connections from slave devices.
> +			 */
> +			if (adv_type != LE_ADV_DIRECT_IND)
> +				return NULL;
> +			break;
> +		case HCI_AUTO_CONN_ALWAYS:
> +			/* Devices advertising with ADV_IND or ADV_DIRECT_IND
> +			 * are triggering a connection attempt. This means
> +			 * that incoming connectioms from slave device are
> +			 * accepted and also outgoing connections to slave
> +			 * devices are established when found.
> +			 */
> +			break;
> +		default:
> 			return NULL;
> -		break;
> -	case HCI_AUTO_CONN_ALWAYS:
> -		/* Devices advertising with ADV_IND or ADV_DIRECT_IND
> -		 * are triggering a connection attempt. This means
> -		 * that incoming connectioms from slave device are
> -		 * accepted and also outgoing connections to slave
> -		 * devices are established when found.
> -		 */
> -		break;
> -	default:
> -		return NULL;
> +		}
> 	}
> 
> 	conn = hci_connect_le(hdev, addr, addr_type, BT_SECURITY_LOW,
> 			      HCI_LE_AUTOCONN_TIMEOUT, HCI_ROLE_MASTER);
> 	if (!IS_ERR(conn)) {
> -		/* Store the pointer since we don't really have any
> +		/* If HCI_AUTO_CONN_EXPLICIT is set, conn is already owned
> +		 * by higher layer that tried to connect, if no then
> +		 * store the pointer since we don't really have any
> 		 * other owner of the object besides the params that
> 		 * triggered it. This way we can abort the connection if
> 		 * the parameters get removed and keep the reference
> 		 * count consistent once the connection is established.
> 		 */
> -		params->conn = hci_conn_get(conn);
> +
> +		if (!params->explicit_connect)
> +			params->conn = hci_conn_get(conn);
> +
> 		return conn;
> 	}
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 0131866..af592eb 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -6107,6 +6107,12 @@ static int hci_conn_params_set(struct hci_request *req, bdaddr_t *addr,
> 	switch (auto_connect) {
> 	case HCI_AUTO_CONN_DISABLED:
> 	case HCI_AUTO_CONN_LINK_LOSS:
> +		/* If auto connect is being disabled when we're trying to
> +		 * connect to device, keep connecting.
> +		 */
> +		if (params->explicit_connect)
> +			list_add(&params->action, &hdev->pend_le_conns);
> +
> 		__hci_update_background_scan(req);
> 		break;
> 	case HCI_AUTO_CONN_REPORT:

Regards

Marcel

