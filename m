Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH v9 3/6] Bluetooth: add hci_connect_le_scan
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1438786318-6725-3-git-send-email-jpawlowski@google.com>
Date: Fri, 7 Aug 2015 11:05:51 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A6A3672A-1B02-4751-963F-EA1D91A9CC74@holtmann.org>
References: <1438786318-6725-1-git-send-email-jpawlowski@google.com> <1438786318-6725-3-git-send-email-jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> Currently, when trying to connect to already paired device that just
> rotated its RPA MAC address, old address would be used and connection
> would fail. In order to fix that, kernel must scan and receive
> advertisement with fresh RPA before connecting.
> 
> This patch adds hci_connect_le_scan with dependencies, new method that
> will be used to connect to remote LE devices. Instead of just sending
> connect request, it adds a device to whitelist. Later patches will make
> use of this whitelist to send conenct request when advertisement is
> received, and properly handle timeouts.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
> include/net/bluetooth/hci_core.h |   6 ++
> net/bluetooth/hci_conn.c         | 174 +++++++++++++++++++++++++++++++++++++++
> net/bluetooth/hci_core.c         |  33 ++++++++
> 3 files changed, 213 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index f0a9fc1..9e1a59e 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -846,6 +846,9 @@ void hci_chan_del(struct hci_chan *chan);
> void hci_chan_list_flush(struct hci_conn *conn);
> struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle);
> 
> +struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
> +				     u8 dst_type, u8 sec_level,
> +				     u16 conn_timeout, u8 role);
> struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
> 				u8 dst_type, u8 sec_level, u16 conn_timeout,
> 				u8 role);
> @@ -1011,6 +1014,9 @@ void hci_conn_params_clear_disabled(struct hci_dev *hdev);
> struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
> 						  bdaddr_t *addr,
> 						  u8 addr_type);
> +struct hci_conn_params *hci_explicit_connect_lookup(struct hci_dev *hdev,
> +						    bdaddr_t *addr,
> +						    u8 addr_type);
> 
> void hci_uuids_clear(struct hci_dev *hdev);
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 0b4d919..aa0e7fb 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -64,6 +64,48 @@ static void hci_le_create_connection_cancel(struct hci_conn *conn)
> 	hci_send_cmd(conn->hdev, HCI_OP_LE_CREATE_CONN_CANCEL, 0, NULL);
> }
> 
> +/* This function requires the caller holds hdev->lock */
> +static void hci_connect_le_scan_cleanup(struct hci_conn *conn)
> +{
> +	struct hci_conn_params *params;
> +	struct smp_irk *irk;
> +	bdaddr_t *bdaddr;
> +	u8 bdaddr_type;
> +
> +	bdaddr = &conn->dst;
> +	bdaddr_type = conn->dst_type;
> +
> +	/* Check if we need to convert to identity address */
> +	irk = hci_get_irk(conn->hdev, bdaddr, bdaddr_type);
> +	if (irk) {
> +		bdaddr = &irk->bdaddr;
> +		bdaddr_type = irk->addr_type;
> +	}
> +
> +	params = hci_explicit_connect_lookup(conn->hdev, bdaddr, bdaddr_type);
> +	if (!params)
> +		return;
> +
> +	/* The connection attempt was doing scan for new RPA, and is
> +	 * in scan phase. If params are not associated with any other
> +	 * autoconnect action, remove them completely. If they are, just unmark
> +	 * them as awaiting for connection, by clearing explicit_connect field.

I think this should read waiting for connection instead of awaiting.

> +	 */
> +	if (params->auto_connect == HCI_AUTO_CONN_EXPLICIT)
> +		hci_conn_params_del(conn->hdev, bdaddr, bdaddr_type);
> +	else
> +		params->explicit_connect = false;
> +}
> +
> +/* This function requires the caller holds hdev->lock */
> +static void hci_connect_le_scan_remove(struct hci_conn *conn)
> +{
> +	hci_connect_le_scan_cleanup(conn);
> +
> +	hci_conn_hash_del(conn->hdev, conn);
> +	hci_update_background_scan(conn->hdev);
> +}
> +
> static void hci_acl_create_connection(struct hci_conn *conn)
> {
> 	struct hci_dev *hdev = conn->hdev;
> @@ -858,6 +900,138 @@ done:
> 	return conn;
> }
> 
> +static void hci_connect_le_scan_complete(struct hci_dev *hdev, u8 status,
> +					 u16 opcode)
> +{
> +	struct hci_conn *conn;
> +
> +	if (!status)
> +		return;
> +
> +	BT_ERR("Failed to add device to auto conn whitelist: status 0x%2.2x",
> +	       status);
> +
> +	hci_dev_lock(hdev);
> +
> +	conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
> +	if (conn)
> +		hci_le_conn_failed(conn, status);
> +
> +	hci_dev_unlock(hdev);
> +}
> +
> +static bool is_connected(struct hci_dev *hdev, bdaddr_t *addr, u8 type)
> +{
> +	struct hci_conn *conn;
> +
> +	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, addr);
> +	if (!conn)
> +		return false;
> +
> +	if (conn->dst_type != type)
> +		return false;
> +
> +	if (conn->state != BT_CONNECTED)
> +		return false;
> +
> +	return true;
> +}
> +
> +/* This function requires the caller holds hdev->lock */
> +int hci_explicit_conn_params_set(struct hci_request *req, bdaddr_t *addr,
> +				 u8 addr_type)
> +{
> +	struct hci_dev *hdev = req->hdev;
> +	struct hci_conn_params *params;
> +
> +	if (is_connected(hdev, addr, addr_type))
> +		return -EISCONN;
> +
> +	params = hci_conn_params_add(hdev, addr, addr_type);
> +	if (!params)
> +		return -EIO;
> +
> +	/* If we created new params, or exiting params were marked as disabled,
> +	 * mark them to be used just once to connect.
> +	 */

I think you mean existing parameters. Even if there are exiting parameters out there ;)

> +	if (params->auto_connect == HCI_AUTO_CONN_DISABLED) {
> +		params->auto_connect = HCI_AUTO_CONN_EXPLICIT;
> +		list_del_init(&params->action);
> +		list_add(&params->action, &hdev->pend_le_conns);
> +	}
> +
> +	params->explicit_connect = true;
> +	__hci_update_background_scan(req);
> +
> +	BT_DBG("addr %pMR (type %u) auto_connect %u", addr, addr_type,
> +	       params->auto_connect);
> +
> +	return 0;
> +}
> +
> +/* This function requires the caller holds hdev->lock */
> +struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
> +				     u8 dst_type, u8 sec_level,
> +				     u16 conn_timeout, u8 role)
> +{
> +	struct hci_conn *conn;
> +	struct hci_request req;
> +	int err;
> +
> +	/* Let's make sure that le is enabled.*/
> +	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
> +		if (lmp_le_capable(hdev))
> +			return ERR_PTR(-ECONNREFUSED);
> +
> +		return ERR_PTR(-EOPNOTSUPP);
> +	}
> +
> +	/* Some devices send ATT messages as soon as the physical link is
> +	 * established. To be able to handle these ATT messages, the user-
> +	 * space first establishes the connection and then starts the pairing
> +	 * process.
> +	 *
> +	 * So if a hci_conn object already exists for the following connection
> +	 * attempt, we simply update pending_sec_level and auth_type fields
> +	 * and return the object found.
> +	 */
> +	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
> +	if (conn) {
> +		if (conn->pending_sec_level < sec_level)
> +			conn->pending_sec_level = sec_level;
> +		goto done;
> +	}
> +
> +	BT_DBG("requesting refresh of dst_addr.");

Kill the . at the end of the debug text.

> +
> +	conn = hci_conn_add(hdev, LE_LINK, dst, role);
> +	if (!conn)
> +		return ERR_PTR(-ENOMEM);
> +
> +	hci_req_init(&req, hdev);
> +
> +	if (hci_explicit_conn_params_set(&req, dst, dst_type) < 0)
> +		return ERR_PTR(-EBUSY);
> +
> +	conn->state = BT_CONNECT;
> +	set_bit(HCI_CONN_SCANNING, &conn->flags);
> +
> +	err = hci_req_run(&req, hci_connect_le_scan_complete);
> +	if (err && err != -ENODATA) {
> +		hci_conn_del(conn);
> +		return ERR_PTR(err);
> +	}
> +
> +	conn->dst_type = dst_type;
> +	conn->sec_level = BT_SECURITY_LOW;
> +	conn->pending_sec_level = sec_level;
> +	conn->conn_timeout = conn_timeout;
> +
> +done:
> +	hci_conn_hold(conn);
> +	return conn;
> +}
> +
> struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
> 				 u8 sec_level, u8 auth_type)
> {
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index bc43b64..adcbc74 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2848,6 +2848,30 @@ struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
> }
> 
> /* This function requires the caller holds hdev->lock */
> +struct hci_conn_params *hci_explicit_connect_lookup(struct hci_dev *hdev,
> +						    bdaddr_t *addr,
> +						    u8 addr_type)
> +{
> +	struct hci_conn_params *param;
> +
> +	list_for_each_entry(param, &hdev->pend_le_conns, action) {
> +		if (bacmp(&param->addr, addr) == 0 &&
> +		    param->addr_type == addr_type &&
> +		    param->explicit_connect)
> +			return param;
> +	}
> +
> +	list_for_each_entry(param, &hdev->pend_le_reports, action) {
> +		if (bacmp(&param->addr, addr) == 0 &&
> +		    param->addr_type == addr_type &&
> +		    param->explicit_connect)
> +			return param;
> +	}
> +
> +	return NULL;
> +}
> +
> +/* This function requires the caller holds hdev->lock */
> struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
> 					    bdaddr_t *addr, u8 addr_type)
> {
> @@ -2916,6 +2940,15 @@ void hci_conn_params_clear_disabled(struct hci_dev *hdev)
> 	list_for_each_entry_safe(params, tmp, &hdev->le_conn_params, list) {
> 		if (params->auto_connect != HCI_AUTO_CONN_DISABLED)
> 			continue;
> +
> +		/* If trying to estabilish one time connection to disabled
> +		 * device, leave the params, but mark them as just once.
> +		 */
> +		if (params->explicit_connect) {
> +			params->auto_connect = HCI_AUTO_CONN_EXPLICIT;
> +			continue;
> +		}
> +
> 		list_del(&params->list);
> 		kfree(params);

Regards

Marcel

