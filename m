Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: [RFC v2 09/15] Bluetooth: Introduce LE auto connection infrastructure
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1383053160-10175-10-git-send-email-andre.guedes@openbossa.org>
Date: Wed, 30 Oct 2013 00:30:50 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <E3A72B5D-1AC1-469B-B6AF-36C25A1EE1F8@holtmann.org>
References: <1383053160-10175-1-git-send-email-andre.guedes@openbossa.org> <1383053160-10175-10-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch introduces the LE auto connection infrastructure.
> This infrastructure will be used to implement the auto_connect
> options from hci_conn_params.
> 
> The auto connection mechanism works as follows: When the first
> device address is inserted into hdev->pending_auto_con list, we
> start the background scanning. Once the target device is found
> in range, the kernel creates the connection. If connection is
> established successfully, the device address is removed from
> hdev->pending_auto_conn list. Finally, when the last device
> address is removed, the background scanning is stopped.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> include/net/bluetooth/hci_core.h |   2 +
> net/bluetooth/hci_conn.c         |   6 ++
> net/bluetooth/hci_core.c         | 115 +++++++++++++++++++++++++++++++++++++++
> net/bluetooth/hci_event.c        |  43 +++++++++++++++
> 4 files changed, 166 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 0049036..322918f 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -784,6 +784,8 @@ void __hci_remove_pending_auto_conn(struct hci_dev *hdev, bdaddr_t *addr,
> 
> bool hci_is_scan_and_conn_supported(struct hci_dev *hdev);
> 
> +void hci_check_background_scan(struct hci_dev *hdev);
> +
> int hci_uuids_clear(struct hci_dev *hdev);
> 
> int hci_link_keys_clear(struct hci_dev *hdev);
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index b52bcb2..bbe3cab 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -544,6 +544,12 @@ static void create_le_conn_complete(struct hci_dev *hdev, u8 status)
> 
> done:
> 	hci_dev_unlock(hdev);
> +
> +	/* Check the background scanning since it may have been temporarily
> +	 * stopped if the controller doesn't support scanning and creating
> +	 * connection at the same time.
> +	 */
> +	hci_check_background_scan(hdev);
> }
> 
> static int hci_create_le_conn(struct hci_conn *conn)
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 19624d1..79debc3 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2923,6 +2923,72 @@ bool hci_has_pending_auto_conn(struct hci_dev *hdev, bdaddr_t *addr,
> 	return res;
> }
> 
> +static void start_background_scan_complete(struct hci_dev *hdev, u8 status)
> +{
> +	if (status)
> +		BT_DBG("HCI request failed to start background scanning: "
> +		       "status 0x%2.2x", status);
> +}
> +
> +static int start_background_scan(struct hci_dev *hdev)
> +{
> +	struct hci_cp_le_set_scan_param param_cp;
> +	struct hci_cp_le_set_scan_enable enable_cp;
> +	struct hci_request req;
> +
> +	if (test_bit(HCI_LE_SCAN, &hdev->dev_flags))
> +		return 0;
> +
> +	BT_DBG("%s", hdev->name);
> +
> +	hci_req_init(&req, hdev);
> +
> +	memset(&param_cp, 0, sizeof(param_cp));
> +	param_cp.type = LE_SCAN_PASSIVE;
> +	param_cp.interval = cpu_to_le16(hdev->le_scan_interval);
> +	param_cp.window = cpu_to_le16(hdev->le_scan_window);
> +	hci_req_add(&req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(param_cp),
> +		    &param_cp);
> +
> +	memset(&enable_cp, 0, sizeof(enable_cp));
> +	enable_cp.enable = LE_SCAN_ENABLE;
> +	enable_cp.filter_dup = LE_SCAN_FILTER_DUP_DISABLE;
> +	hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
> +		    &enable_cp);
> +
> +	return hci_req_run(&req, start_background_scan_complete);
> +}
> +
> +static void stop_background_scan_complete(struct hci_dev *hdev, u8 status)
> +{
> +	if (status)
> +		BT_DBG("HCI request failed to stop background scanning: "
> +		       "status 0x%2.2x", status);
> +}
> +
> +static int stop_background_scan(struct hci_dev *hdev)
> +{
> +	struct hci_cp_le_set_scan_enable cp;
> +	struct hci_request req;
> +
> +	if (!test_bit(HCI_LE_SCAN, &hdev->dev_flags))
> +		return 0;

The background scanning needs its own HCI_LE_BG_SCAN flag.

> +
> +	/* If device discovery is running, background scanning is stopped so
> +	 * we return sucess.
> +	 */
> +	if (hdev->discovery.state == DISCOVERY_FINDING)
> +		return 0;
> +
> +	hci_req_init(&req, hdev);
> +
> +	memset(&cp, 0, sizeof(cp));
> +	cp.enable = LE_SCAN_DISABLE;
> +	hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
> +
> +	return hci_req_run(&req, stop_background_scan_complete);
> +}
> +
> /* This function requires the caller holds hdev->lock */
> int __hci_add_pending_auto_conn(struct hci_dev *hdev, bdaddr_t *addr,
> 				u8 addr_type)
> @@ -2940,6 +3006,19 @@ int __hci_add_pending_auto_conn(struct hci_dev *hdev, bdaddr_t *addr,
> 	bacpy(&entry->bdaddr, addr);
> 	entry->bdaddr_type = addr_type;
> 
> +	/* If there is no pending auto connection, the background scanning
> +	 * is not runnning. So we should start it.
> +	 */
> +	if (list_empty(&hdev->pending_auto_conn)) {
> +		int err;
> +
> +		err = start_background_scan(hdev);
> +		if (err) {
> +			kfree(entry);
> +			return err;
> +		}
> +	}
> +
> 	list_add(&entry->list, &hdev->pending_auto_conn);
> 
> 	return 0;
> @@ -2957,6 +3036,14 @@ void __hci_remove_pending_auto_conn(struct hci_dev *hdev, bdaddr_t *addr,
> 
> 	list_del(&entry->list);
> 	kfree(entry);
> +
> +	if (list_empty(&hdev->pending_auto_conn)) {
> +		int err;
> +
> +		err = stop_background_scan(hdev);
> +		if (err)
> +			BT_ERR("Failed to run HCI request: err %d", err);

I am getting sick of these errors. Return an error from a function if you plan to do something with it. Otherwise just don’t. Not to mention that the only one possible here is ENOMEM. That I declared tons and tons of functions void in bluetooth-next might have been an indication that we are not doing this anymore.

> +	}
> }

And this should be all one function. Move the list_empty check into the function that updates the background scanning status. This all feels cluttered.

I mean at the end of the day it is pretty simple logic. If the list is empty stop scanning and if the list has at least one item, start scanning. Then deal with the cases where we have discovery, connection attempts etc. And done. I do not want to check 20 different locations that we call the right function with the right if around it.

> 
> /* This function requires the caller holds hdev->lock */
> @@ -2970,6 +3057,34 @@ static void __clear_pending_auto_conn(struct hci_dev *hdev)
> 	}
> }
> 
> +/* This function starts the background scanning in case there is still
> + * pending auto connections.
> + */
> +void hci_check_background_scan(struct hci_dev *hdev)
> +{
> +	struct hci_conn *conn;
> +	int err;
> +
> +	if (list_empty(&hdev->pending_auto_conn))
> +		return;
> +
> +	if (test_bit(HCI_LE_SCAN, &hdev->dev_flags))
> +		return;
> +
> +	/* If the controller is connecting but it doesn't support scanning
> +	 * scanning and connecting at the same time we don't start the
> +	 * background scanning now. It will be started once the connection
> +	 * is established.
> +	 */
> +	conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
> +	if (conn && !hci_is_scan_and_conn_supported(hdev))
> +		return;
> +
> +	err = start_background_scan(hdev);
> +	if (err)
> +		BT_ERR("Failed to start background scanning: err %d", err);

The err crap has to go away. It is pretty much annoying me now.

> +}
> +
> static void inquiry_complete(struct hci_dev *hdev, u8 status)
> {
> 	if (status) {
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 8b7cd37..e48601d 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3547,8 +3547,49 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
> 
> 	hci_proto_connect_cfm(conn, ev->status);
> 
> +	__hci_remove_pending_auto_conn(hdev, &ev->bdaddr, ev->bdaddr_type);
> +
> unlock:
> 	hci_dev_unlock(hdev);
> +
> +	/* Check the background scanning since it may have been temporarily
> +	 * stopped if the controller doesn't support scanning and creating
> +	 * connection at the same time.
> +	 */
> +	hci_check_background_scan(hdev);

I have no idea why hci_remove_pending_auto_conn can not also call the code for updating the scanning status. Make it really simple.

> +}
> +
> +static void check_pending_auto_conn(struct hci_dev *hdev, bdaddr_t *addr,
> +				    u8 addr_type)
> +{
> +	struct hci_conn *conn;
> +	u8 bdaddr_type;
> +
> +	if (!hci_has_pending_auto_conn(hdev, addr, addr_type))
> +		return;
> +
> +	if (addr_type == ADDR_LE_DEV_PUBLIC)
> +		bdaddr_type = BDADDR_LE_PUBLIC;
> +	else
> +		bdaddr_type = BDADDR_LE_RANDOM;
> +
> +	conn = hci_connect(hdev, LE_LINK, addr, bdaddr_type, BT_SECURITY_LOW,
> +			   HCI_AT_NO_BONDING);
> +	if (IS_ERR(conn)) {

Just returning is !IS_ERR(conn) is better to read.

> +		switch (PTR_ERR(conn)) {
> +		case -EBUSY:
> +			/* When hci_connect() returns EBUSY it means there is
> +			 * already an LE connection attempt going on. Since the
> +			 * controller supports only one connection attempt at
> +			 * the time, we simply return.
> +			 */
> +			return;

And this can be a break then.

> +		default:
> +			BT_ERR("Failed to auto connect: err %ld",
> +			       PTR_ERR(conn));
> +			return;

Same here.

> +		}
> +	}
> }

Also do we really care with printing an error here.

> 
> static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
> @@ -3560,6 +3601,8 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
> 	while (num_reports--) {
> 		struct hci_ev_le_advertising_info *ev = ptr;
> 
> +		check_pending_auto_conn(hdev, &ev->bdaddr, ev->bdaddr_type);
> +
> 		rssi = ev->data[ev->length];
> 		mgmt_device_found(hdev, &ev->bdaddr, LE_LINK, ev->bdaddr_type,
> 				  NULL, rssi, 0, 1, ev->data, ev->length);

Regards

Marcel

