Return-Path: <cyrus@holtmann.org>
Date: Sun, 11 Mar 2012 15:02:49 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arik Nemtsov <arik@wizery.com>
Cc: linux-bluetooth@vger.kernel.org,
	Bruna Moreira <bruna.moreira@openbossa.org>
Subject: Re: [PATCH] Bluetooth: Implement Read Transmit Power Level command
Message-ID: <20120311130249.GA8525@x220.P-661HNU-F1>
References: <1331455196-26441-1-git-send-email-arik@wizery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331455196-26441-1-git-send-email-arik@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arik,

On Sun, Mar 11, 2012, Arik Nemtsov wrote:
> +static int read_tx_power_level(struct sock *sk, struct hci_dev *hdev,
> +			       void *data, u16 len)
> +{
> +	struct mgmt_cp_read_tx_power_level *cp = data;
> +	struct hci_cp_read_tx_power hci_cp;
> +	struct pending_cmd *cmd;
> +	struct hci_conn *conn;
> +	int err;
> +
> +	BT_DBG("");
> +
> +	if (len != sizeof(*cp))
> +		return cmd_status(sk, hdev->id, MGMT_OP_READ_TX_POWER_LEVEL,
> +				  MGMT_STATUS_INVALID_PARAMS);
> +
> +	hci_dev_lock(hdev);
> +
> +	if (!test_bit(HCI_UP, &hdev->flags)) {
> +		err = cmd_status(sk, hdev->id, MGMT_OP_READ_TX_POWER_LEVEL,
> +				 MGMT_STATUS_NOT_POWERED);
> +		goto unlock;
> +	}
> +
> +	if (mgmt_pending_find(MGMT_OP_READ_TX_POWER_LEVEL, hdev)) {
> +		err = cmd_status(sk, hdev->id, MGMT_OP_READ_TX_POWER_LEVEL,
> +				 MGMT_STATUS_BUSY);
> +		goto unlock;
> +	}
> +
> +	cmd = mgmt_pending_add(sk, MGMT_OP_READ_TX_POWER_LEVEL, hdev, data,
> +			       len);
> +	if (!cmd) {
> +		err = -ENOMEM;
> +		goto unlock;
> +	}
> +
> +	if (cp->addr.type == MGMT_ADDR_BREDR)
> +		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
> +					       &cp->addr.bdaddr);
> +	else
> +		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK,
> +					       &cp->addr.bdaddr);
> +
> +	if (!conn) {
> +		err = cmd_status(sk, hdev->id, MGMT_OP_READ_TX_POWER_LEVEL,
> +				 MGMT_STATUS_NOT_CONNECTED);
> +		mgmt_pending_remove(cmd);
> +		goto unlock;
> +	}
> +
> +	put_unaligned_le16(conn->handle, &hci_cp.handle);
> +	hci_cp.type = cp->type;
> +
> +	err = hci_send_cmd(hdev, HCI_OP_READ_TX_POWER, sizeof(hci_cp), &hci_cp);
> +	if (err < 0)
> +		mgmt_pending_remove(cmd);
> +
> +unlock:
> +	hci_dev_unlock(hdev);
> +	hci_dev_put(hdev);

The dev_put here looks like a bug (probably from before the rebase when
this function was still calling hci_dev_get).

Other than that I don't see anything obviously wrong with the patch,
except that you might have maybe tried splitting it up a bit (not that
it's very big now either).

Johan
