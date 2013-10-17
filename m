Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [RFC 05/15] Bluetooth: Use connection parameters if any
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1381965485-9159-6-git-send-email-andre.guedes@openbossa.org>
Date: Thu, 17 Oct 2013 11:27:35 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <06808003-600D-45E8-88FD-E8F766DCFBA4@holtmann.org>
References: <1381965485-9159-1-git-send-email-andre.guedes@openbossa.org> <1381965485-9159-6-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch changes hci_create_le_conn() so it uses the connection
> parameters specified by the user. If no parameters were configured,
> we use the default values.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> net/bluetooth/hci_conn.c | 12 ++++++++++--
> 1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 4e72650..d64000e 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -548,6 +548,7 @@ static int hci_create_le_conn(struct hci_conn *conn)
> 	struct hci_dev *hdev = conn->hdev;
> 	struct hci_cp_le_create_conn cp;
> 	struct hci_request req;
> +	struct hci_conn_param *param;
> 	int err;
> 
> 	hci_req_init(&req, hdev);
> @@ -558,11 +559,18 @@ static int hci_create_le_conn(struct hci_conn *conn)
> 	bacpy(&cp.peer_addr, &conn->dst);
> 	cp.peer_addr_type = conn->dst_type;
> 	cp.own_address_type = conn->src_type;
> -	cp.conn_interval_min = __constant_cpu_to_le16(0x0028);
> -	cp.conn_interval_max = __constant_cpu_to_le16(0x0038);
> 	cp.supervision_timeout = __constant_cpu_to_le16(0x002a);
> 	cp.min_ce_len = __constant_cpu_to_le16(0x0000);
> 	cp.max_ce_len = __constant_cpu_to_le16(0x0000);
> +	param = hci_find_conn_param(hdev, &conn->dst, conn->dst_type);
> +	if (param) {
> +		cp.conn_interval_min = cpu_to_le16(param->min_conn_interval);
> +		cp.conn_interval_max = cpu_to_le16(param->max_conn_interval);
> +		hci_conn_param_put(param);
> +	} else {
> +		cp.conn_interval_min = __constant_cpu_to_le16(0x0028);
> +		cp.conn_interval_max = __constant_cpu_to_le16(0x0038);
> +	}
> 	hci_req_add(&req, HCI_OP_LE_CREATE_CONN, sizeof(cp), &cp);

so this is part that I do not like at all. We already have the hci_conn connection object at this point. So why are these values not stored in there. In the end we are paying the price for code like this where we have to check if parameters exists, if they do apply them, if not use the defaults.

I did change the code back from the check for public address and what own address type to use. Since it turned out that later on you actually need to what you where doing.

And this is the same thing in the future. We actually want to know what connection parameters we current used. In case we have to update them or they change while the connection is on-going.

Regards

Marcel

