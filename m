Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [RFC v7 03/11] Bluetooth: Stop scanning on LE connection
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1391446588-18729-3-git-send-email-andre.guedes@openbossa.org>
Date: Mon, 3 Feb 2014 20:08:46 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <629D5403-D2BD-4DCE-B243-41CE971DE914@holtmann.org>
References: <1391446588-18729-1-git-send-email-andre.guedes@openbossa.org> <1391446588-18729-3-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Some LE controllers don't support scanning and creating a connection
> at the same time. So we should always stop scanning in order to
> establish the connection.
> 
> Since we may prematurely stop the discovery procedure in favor of
> the connection establishment, we should also cancel hdev->le_scan_
> disable delayed work and set the discovery state to DISCOVERY_STOPPED.
> 
> This change does a small improvement since it is not mandatory the
> user stops scanning before connecting anymore. Moreover, this change
> is required by upcoming LE auto connection mechanism in order to work
> properly with controllers that don't support background scanning and
> connection establishment at the same time.
> 
> In future, we might want to do a small optimization by checking if
> controller is able to scan and connect at the same time. For now,
> we want the simplest approach so we always stop scanning (even if
> the controller is able to carry out both operations).
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> include/net/bluetooth/hci.h |  1 +
> net/bluetooth/hci_conn.c    | 84 +++++++++++++++++++++++++++++++++++++++++++--
> 2 files changed, 83 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 352d3d7..a0d5262 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -352,6 +352,7 @@ enum {
> 
> /* ---- HCI Error Codes ---- */
> #define HCI_ERROR_AUTH_FAILURE		0x05
> +#define HCI_ERROR_MEMORY_EXCEEDED	0x07
> #define HCI_ERROR_CONNECTION_TIMEOUT	0x08
> #define HCI_ERROR_REJ_BAD_ADDR		0x0f
> #define HCI_ERROR_REMOTE_USER_TERM	0x13
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 6797292..63c1e4f 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -583,11 +583,71 @@ static int hci_create_le_conn(struct hci_conn *conn)
> 	return 0;
> }
> 
> +static void create_le_conn_req(struct hci_request *req, struct hci_conn *conn)
> +{
> +	struct hci_cp_le_create_conn cp;
> +	struct hci_dev *hdev = conn->hdev;
> +
> +	memset(&cp, 0, sizeof(cp));
> +	cp.scan_interval = cpu_to_le16(hdev->le_scan_interval);
> +	cp.scan_window = cpu_to_le16(hdev->le_scan_window);
> +	bacpy(&cp.peer_addr, &conn->dst);
> +	cp.peer_addr_type = conn->dst_type;
> +	cp.own_address_type = conn->src_type;
> +	cp.conn_interval_min = cpu_to_le16(conn->le_conn_min_interval);
> +	cp.conn_interval_max = cpu_to_le16(conn->le_conn_max_interval);
> +	cp.supervision_timeout = __constant_cpu_to_le16(0x002a);
> +	cp.min_ce_len = __constant_cpu_to_le16(0x0000);
> +	cp.max_ce_len = __constant_cpu_to_le16(0x0000);
> +
> +	hci_req_add(req, HCI_OP_LE_CREATE_CONN, sizeof(cp), &cp);
> +}
> +
> +static void stop_scan_complete(struct hci_dev *hdev, u8 status)
> +{
> +	struct hci_request req;
> +	struct hci_conn *conn;
> +	int err;
> +
> +	conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
> +	if (!conn)
> +		return;
> +
> +	if (status) {
> +		BT_DBG("HCI request failed to stop scanning: status 0x%2.2x",
> +		       status);
> +
> +		hci_dev_lock(hdev);
> +		le_conn_failed(conn, status);
> +		hci_dev_unlock(hdev);
> +		return;
> +	}
> +
> +	/* Since we may have prematurely stopped discovery procedure, we should
> +	 * update discovery state.
> +	 */
> +	cancel_delayed_work(&hdev->le_scan_disable);
> +	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> +
> +	hci_req_init(&req, hdev);
> +
> +	create_le_conn_req(&req, conn);
> +
> +	err = hci_req_run(&req, create_le_conn_complete);
> +	if (err) {
> +		hci_dev_lock(hdev);
> +		le_conn_failed(conn, HCI_ERROR_MEMORY_EXCEEDED);
> +		hci_dev_unlock(hdev);
> +		return;
> +	}
> +}
> +
> static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
> 				    u8 dst_type, u8 sec_level, u8 auth_type)
> {
> 	struct hci_conn_params *params;
> 	struct hci_conn *conn;
> +	struct hci_request req;
> 	int err;
> 
> 	if (test_bit(HCI_ADVERTISING, &hdev->flags))
> @@ -643,9 +703,29 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
> 		conn->le_conn_max_interval = hdev->le_conn_max_interval;
> 	}
> 
> -	err = hci_create_le_conn(conn);
> -	if (err)
> +	hci_req_init(&req, hdev);
> +
> +	/* If controller is scanning, we stop it since some controllers are
> +	 * not able to scan and connect at the same time.
> +	 */
> +	if (test_bit(HCI_LE_SCAN, &hdev->dev_flags)) {
> +		struct hci_cp_le_set_scan_enable cp;
> +
> +		memset(&cp, 0, sizeof(cp));
> +		cp.enable = LE_SCAN_DISABLE;
> +		hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
> +
> +		err = hci_req_run(&req, stop_scan_complete);
> +	} else {
> +		create_le_conn_req(&req, conn);
> +
> +		err = hci_req_run(&req, create_le_conn_complete);
> +	}

so I wonder why we not just add the disabling of the scan to the request right here. Our request queue will always fail on the first request and then do not execute the other ones. Especially when you have to send two requests this kind of request queue behavior is pretty nice.

I also think that this is currently a bit racy in error handling path. So you might want to check this in all cases. One other thing to consider is might be introducing helper for adding certain commands like disable LE scan if they are used more than once.

Regards

Marcel

