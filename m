Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/8] Bluetooth: Add support to get connection information
Date: Thu, 08 May 2014 16:20:53 +0200
Message-ID: <1625032.X2xoBufq5O@uw000953>
In-Reply-To: <1399555935-702-6-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1399555935-702-1-git-send-email-andrzej.kaczmarek@tieto.com> <1399555935-702-6-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Thursday 08 of May 2014 15:32:12 Andrzej Kaczmarek wrote:
> This patch adds support for Get Connection Information mgmt command
> which can be used to query for information about connection, i.e. RSSI
> or local TX power level.
> 
> RSSI is returned as response parameter while any other information is
> returned in standard EIR format.
> 
> Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
> ---
>  include/net/bluetooth/hci_core.h |   2 +
>  include/net/bluetooth/mgmt.h     |  16 ++++
>  net/bluetooth/mgmt.c             | 176 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 194 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 30d245f..8d7d48b 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -378,6 +378,8 @@ struct hci_conn {
>  	__s8		tx_power;
>  	unsigned long	flags;
>  
> +	unsigned long	last_info_read;
> +
>  	__u8		remote_cap;
>  	__u8		remote_auth;
>  	__u8		remote_id;
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index d4b571c..c26b7e2 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -409,6 +409,22 @@ struct mgmt_cp_load_irks {
>  } __packed;
>  #define MGMT_LOAD_IRKS_SIZE		2
>  
> +#define MGMT_CONN_INFO_DATA_TX_POWER	0x00000001
> +
> +#define MGMT_OP_GET_CONN_INFORMATION	0x0031
> +struct mgmt_cp_get_conn_information {
> +	struct mgmt_addr_info addr;
> +	__u32	data_type;
> +} __packed;
> +#define MGMT_GET_CONN_INFORMATION_SIZE	(MGMT_ADDR_INFO_SIZE + 4)
> +struct mgmt_rp_get_conn_information {
> +	struct mgmt_addr_info addr;
> +	__s8	rssi;
> +	__u32	flags;
> +	__le16	eir_len;
> +	__u8	eir[0];
> +} __packed;
> +
>  #define MGMT_EV_CMD_COMPLETE		0x0001
>  struct mgmt_ev_cmd_complete {
>  	__le16	opcode;
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index bb3188f..58074c8 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -83,6 +83,7 @@ static const u16 mgmt_commands[] = {
>  	MGMT_OP_SET_DEBUG_KEYS,
>  	MGMT_OP_SET_PRIVACY,
>  	MGMT_OP_LOAD_IRKS,
> +	MGMT_OP_GET_CONN_INFORMATION,
>  };
>  
>  static const u16 mgmt_events[] = {
> @@ -113,6 +114,8 @@ static const u16 mgmt_events[] = {
>  
>  #define CACHE_TIMEOUT	msecs_to_jiffies(2 * 1000)
>  
> +#define CONN_INFO_INTERVAL	msecs_to_jiffies(2 * 1000)
> +
>  #define hdev_is_powered(hdev) (test_bit(HCI_UP, &hdev->flags) && \
>  				!test_bit(HCI_AUTO_OFF, &hdev->dev_flags))
>  
> @@ -4574,6 +4577,178 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
>  	return err;
>  }
>  
> +struct cmd_conn_lookup {
> +	struct hci_conn *conn;
> +	u8 mgmt_status;
> +};
> +
> +static void conn_info_complete(struct pending_cmd *cmd, void *data)
> +{
> +	struct cmd_conn_lookup *match = data;
> +	struct mgmt_cp_get_conn_information *cp;
> +	struct mgmt_rp_get_conn_information *rp;
> +	char buf[sizeof(*rp) + 3];
> +	struct hci_conn *conn = cmd->user_data;
> +	__u16 eir_len = 0;
> +
> +	if (conn != match->conn)
> +		return;
> +
> +	cp = (struct mgmt_cp_get_conn_information *) cmd->param;
> +	rp = (struct mgmt_rp_get_conn_information *) buf;
> +
> +	memset(buf, 0, sizeof(buf));
> +	memcpy(&rp->addr, &cp->addr, sizeof(rp->addr));
> +
> +	if (match->mgmt_status) {
> +		cmd_complete(cmd->sk, cmd->index, MGMT_OP_GET_CONN_INFORMATION,
> +			     match->mgmt_status, rp, sizeof(*rp));
> +		goto done;
> +	}
> +
> +	rp->rssi = conn->rssi;
> +
> +	if (cp->data_type & MGMT_CONN_INFO_DATA_TX_POWER) {
> +		eir_len = eir_append_data(rp->eir, 0, EIR_TX_POWER,
> +					  &conn->tx_power,
> +					  sizeof(conn->tx_power));
> +
> +		rp->eir_len = cpu_to_le16(eir_len);
> +	}
> +
> +	cmd_complete(cmd->sk, cmd->index, MGMT_OP_GET_CONN_INFORMATION,
> +			MGMT_STATUS_SUCCESS, rp, sizeof(*rp) + eir_len);
> +
> +done:
> +	hci_conn_drop(conn);
> +
> +	mgmt_pending_remove(cmd);
> +}
> +
> +static void conn_info_query_complete(struct hci_dev *hdev, u8 status,
> +				     void *data)
> +{
> +	struct hci_conn *conn = data;
> +	struct cmd_conn_lookup match = { conn, mgmt_status(status) };
> +
> +	BT_DBG("status 0x%02x", status);
> +
> +	if (!status)
> +		conn->last_info_read = jiffies;
> +
> +	hci_dev_lock(hdev);
> +
> +	mgmt_pending_foreach(MGMT_OP_GET_CONN_INFORMATION, hdev,
> +			     conn_info_complete, &match);
> +
> +	hci_dev_unlock(hdev);
> +}
> +
> +static bool check_pending_conn_info(struct hci_dev *hdev, struct hci_conn *conn)
> +{
> +	struct pending_cmd *cmd;
> +
> +	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
> +		if (cmd->opcode == MGMT_OP_GET_CONN_INFORMATION &&
> +		    cmd->user_data == conn)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static int get_conn_info(struct sock *sk, struct hci_dev *hdev, void *data,
> +			 u16 len)
> +{
> +	struct mgmt_cp_get_conn_information *cp = data;
> +	struct mgmt_rp_get_conn_information rp;
> +	struct hci_conn *conn;
> +	struct pending_cmd *cmd;
> +	struct hci_request req;
> +	bool is_pending;
> +	int err = 0;
> +
> +	BT_DBG("%s", hdev->name);
> +
> +	memset(&rp, 0, sizeof(rp));
> +	memcpy(&rp.addr, &cp->addr, sizeof(rp.addr));
> +
> +	if (!bdaddr_type_is_valid(cp->addr.type))
> +		return cmd_complete(sk, hdev->id, MGMT_OP_GET_CONN_INFORMATION,
> +				    MGMT_STATUS_INVALID_PARAMS,
> +				    &rp, sizeof(rp));
> +
> +	hci_dev_lock(hdev);
> +
> +	if (!hdev_is_powered(hdev)) {
> +		err = cmd_complete(sk, hdev->id, MGMT_OP_GET_CONN_INFORMATION,
> +				   MGMT_STATUS_NOT_POWERED, &rp, sizeof(rp));
> +		goto unlock;
> +	}
> +
> +	if (cp->addr.type == BDADDR_BREDR)
> +		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
> +					       &cp->addr.bdaddr);
> +	else
> +		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->addr.bdaddr);
> +
> +	if (!conn || conn->state == BT_OPEN || conn->state == BT_CLOSED) {

I think this should be:
if (!conn || conn->state != BT_CONNECTED) {

> +		err = cmd_complete(sk, hdev->id, MGMT_OP_GET_CONN_INFORMATION,
> +				   MGMT_STATUS_NOT_CONNECTED, &rp, sizeof(rp));
> +		goto unlock;
> +	}
> +
> +	is_pending = check_pending_conn_info(hdev, conn);
> +
> +	cmd = mgmt_pending_add(sk, MGMT_OP_GET_CONN_INFORMATION, hdev,
> +			       data, len);
> +	if (!cmd) {
> +		err = -ENOMEM;
> +		goto unlock;
> +	}
> +
> +	hci_conn_hold(conn);
> +	cmd->user_data = conn;
> +
> +	/* There was already pending request for this connection, no need to
> +	 * start another request to controller.
> +	 */
> +	if (is_pending)
> +		goto unlock;
> +
> +	hci_req_init(&req, hdev, conn);
> +
> +	if (time_after(jiffies, conn->last_info_read + CONN_INFO_INTERVAL) ||
> +	    conn->tx_power == HCI_TX_POWER_INVALID) {
> +		struct hci_cp_read_rssi req_rssi_cp;
> +		struct hci_cp_read_tx_power_level req_txp_cp;
> +
> +		req_rssi_cp.handle = cpu_to_le16(conn->handle);
> +		hci_req_add(&req, HCI_OP_READ_RSSI, sizeof(req_rssi_cp),
> +			    &req_rssi_cp);
> +
> +		req_txp_cp.handle = cpu_to_le16(conn->handle);
> +		req_txp_cp.type = TX_POWER_TYPE_CURRENT;
> +		hci_req_add(&req, HCI_OP_READ_TX_POWER_LEVEL,
> +			    sizeof(req_txp_cp), &req_txp_cp);
> +
> +		err = hci_req_run(&req, conn_info_query_complete);
> +		if (err < 0) {
> +			hci_conn_drop(conn);
> +			mgmt_pending_remove(cmd);
> +		}
> +	} else {
> +		struct cmd_conn_lookup match = { conn, MGMT_STATUS_SUCCESS };
> +
> +		/* We know all values and can reply immediately */
> +		conn_info_complete(cmd, &match);
> +	}
> +
> +unlock:
> +	hci_dev_unlock(hdev);
> +	return err;
> +}
> +
>  static const struct mgmt_handler {
>  	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
>  		     u16 data_len);
> @@ -4629,6 +4804,7 @@ static const struct mgmt_handler {
>  	{ set_debug_keys,         false, MGMT_SETTING_SIZE },
>  	{ set_privacy,            false, MGMT_SET_PRIVACY_SIZE },
>  	{ load_irks,              true,  MGMT_LOAD_IRKS_SIZE },
> +	{ get_conn_info,          false, MGMT_GET_CONN_INFORMATION_SIZE },
>  };
>  
>  
> 

-- 
Best regards, 
Szymon Janc
