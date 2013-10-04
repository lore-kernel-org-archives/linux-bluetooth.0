Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH v2 3/4] Bluetooth: Use HCI request for LE connection
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380835547-3640-4-git-send-email-andre.guedes@openbossa.org>
Date: Fri, 4 Oct 2013 08:25:41 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <BDCBCB2D-249D-4E3A-92C3-BCD21E28255D@holtmann.org>
References: <1380835547-3640-1-git-send-email-andre.guedes@openbossa.org> <1380835547-3640-4-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch introduces a new helper, which uses the HCI request
> framework, for creating LE connectons. All the handling is now
> done by this function so we can remove the hci_cs_le_create_conn()
> event handler.
> 
> This patch also removes the old hci_le_create_connection() since
> it is not used anymore.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> include/net/bluetooth/hci_core.h |  2 ++
> net/bluetooth/hci_conn.c         | 26 ++++++-----------------
> net/bluetooth/hci_core.c         | 46 ++++++++++++++++++++++++++++++++++++++++
> net/bluetooth/hci_event.c        | 31 ---------------------------
> 4 files changed, 54 insertions(+), 51 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index e09c305..0835cf9 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1217,6 +1217,8 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
> 
> u8 bdaddr_to_le(u8 bdaddr_type);
> 
> +int hci_create_le_conn(struct hci_dev *hdev, bdaddr_t *addr, u8 type);
> +
> #define SCO_AIRMODE_MASK       0x0003
> #define SCO_AIRMODE_CVSD       0x0000
> #define SCO_AIRMODE_TRANSP     0x0003
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 08e601c..cb0e5d7 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -49,25 +49,6 @@ static const struct sco_param sco_param_wideband[] = {
> 	{ EDR_ESCO_MASK | ESCO_EV3,   0x0008 }, /* T1 */
> };
> 
> -static void hci_le_create_connection(struct hci_conn *conn)
> -{
> -	struct hci_dev *hdev = conn->hdev;
> -	struct hci_cp_le_create_conn cp;
> -
> -	memset(&cp, 0, sizeof(cp));
> -	cp.scan_interval = __constant_cpu_to_le16(0x0060);
> -	cp.scan_window = __constant_cpu_to_le16(0x0030);
> -	bacpy(&cp.peer_addr, &conn->dst);
> -	cp.peer_addr_type = conn->dst_type;
> -	cp.conn_interval_min = __constant_cpu_to_le16(0x0028);
> -	cp.conn_interval_max = __constant_cpu_to_le16(0x0038);
> -	cp.supervision_timeout = __constant_cpu_to_le16(0x002a);
> -	cp.min_ce_len = __constant_cpu_to_le16(0x0000);
> -	cp.max_ce_len = __constant_cpu_to_le16(0x0000);
> -
> -	hci_send_cmd(hdev, HCI_OP_LE_CREATE_CONN, sizeof(cp), &cp);
> -}
> -
> static void hci_le_create_connection_cancel(struct hci_conn *conn)
> {
> 	hci_send_cmd(conn->hdev, HCI_OP_LE_CREATE_CONN_CANCEL, 0, NULL);
> @@ -545,6 +526,7 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
> 				    u8 dst_type, u8 sec_level, u8 auth_type)
> {
> 	struct hci_conn *conn;
> +	int err;
> 
> 	if (test_bit(HCI_LE_PERIPHERAL, &hdev->flags))
> 		return ERR_PTR(-ENOTSUPP);
> @@ -565,7 +547,11 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
> 		conn->link_mode |= HCI_LM_MASTER;
> 		conn->sec_level = BT_SECURITY_LOW;
> 
> -		hci_le_create_connection(conn);
> +		err = hci_create_le_conn(hdev, &conn->dst, conn->dst_type);
> +		if (err) {
> +			hci_conn_del(conn);
> +			return ERR_PTR(err);
> +		}

it is safe to sleep here? Since that is what the new call is doing.

> 	}
> 
> 	conn->pending_sec_level = sec_level;
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 82dbdc6..1002510 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3662,3 +3662,49 @@ u8 bdaddr_to_le(u8 bdaddr_type)
> 		return ADDR_LE_DEV_RANDOM;
> 	}
> }
> +
> +static void create_le_conn_complete(struct hci_dev *hdev, u8 status)
> +{
> +	struct hci_conn *conn;
> +
> +	if (status == 0)
> +		return;
> +
> +	BT_ERR("HCI request failed to initiate LE connection: status 0x%2.2x",
> +	       status);

This should say "create" instead of "initiate".

> +
> +	conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
> +	if (!conn)
> +		return;
> +

We are no longer setting conn->state to BT_CLOSED on purpose here?

> +	mgmt_connect_failed(hdev, &conn->dst, conn->type, conn->dst_type,
> +			    status);
> +
> +	hci_proto_connect_cfm(conn, status);
> +
> +	hci_dev_lock(hdev);
> +	hci_conn_del(conn);
> +	hci_dev_unlock(hdev);
> +}

You are changing the locking behavior without any explanation. Previous code has it around the whole section. I am not a huge fan of changes that get sneaked in this way. That should be a separate patch to explain why it is correct. This patch should not change the current behavior.

> +
> +int hci_create_le_conn(struct hci_dev *hdev, bdaddr_t *addr, u8 type)
> +{
> +	struct hci_cp_le_create_conn cp;
> +	struct hci_request req;
> +
> +	hci_req_init(&req, hdev);
> +
> +	memset(&cp, 0, sizeof(cp));
> +	cp.scan_interval = __constant_cpu_to_le16(0x0060);
> +	cp.scan_window = __constant_cpu_to_le16(0x0030);
> +	bacpy(&cp.peer_addr, addr);
> +	cp.peer_addr_type = type;
> +	cp.conn_interval_min = __constant_cpu_to_le16(0x0028);
> +	cp.conn_interval_max = __constant_cpu_to_le16(0x0038);
> +	cp.supervision_timeout = __constant_cpu_to_le16(0x002a);
> +	cp.min_ce_len = __constant_cpu_to_le16(0x0000);
> +	cp.max_ce_len = __constant_cpu_to_le16(0x0000);
> +	hci_req_add(&req, HCI_OP_LE_CREATE_CONN, sizeof(cp), &cp);
> +
> +	return hci_req_run(&req, create_le_conn_complete);
> +}

Regards

Marcel

