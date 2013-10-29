Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: [RFC v2 06/15] Bluetooth: Use connection parameters if any
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1383053160-10175-7-git-send-email-andre.guedes@openbossa.org>
Date: Wed, 30 Oct 2013 00:04:40 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <27565BCF-8A88-4058-A2AD-F84B4612034D@holtmann.org>
References: <1383053160-10175-1-git-send-email-andre.guedes@openbossa.org> <1383053160-10175-7-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch changes hci_connect_le() so it uses the connection
> parameters specified for the certain device. If no parameters
> were configured, we use the default values.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> net/bluetooth/hci_conn.c | 13 +++++++++++--
> 1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 195b78f..075d070 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -608,6 +608,7 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
> {
> 	struct hci_conn *conn;
> 	int err;
> +	struct hci_conn_params *params;

Put it above err variable.

> 
> 	if (test_bit(HCI_ADVERTISING, &hdev->flags))
> 		return ERR_PTR(-ENOTSUPP);
> @@ -652,8 +653,16 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
> 	conn->sec_level = BT_SECURITY_LOW;
> 	conn->pending_sec_level = sec_level;
> 	conn->auth_type = auth_type;
> -	conn->conn_interval_min = hdev->le_conn_min_interval;
> -	conn->conn_interval_max = hdev->le_conn_max_interval;
> +
> +	params = hci_find_conn_params(hdev, &conn->dst, conn->dst_type);

Here is it now clear why the naming is horrible.

If you want to match with a put, then this needs to be hci_conn_params_get().

> +	if (params) {
> +		conn->conn_interval_min = params->conn_interval_min;
> +		conn->conn_interval_max = params->conn_interval_max;
> +		hci_conn_params_put(params);
> +	} else {
> +		conn->conn_interval_min = hdev->le_conn_min_interval;
> +		conn->conn_interval_max = hdev->le_conn_max_interval;
> +	}
> 
> 	err = hci_create_le_conn(conn);
> 	if (err)

Regards

Marcel

