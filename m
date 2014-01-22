Return-Path: <cyrus@holtmann.org>
Date: Wed, 22 Jan 2014 11:03:30 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v5 06/14] Bluetooth: Stop scanning on LE connection
Message-ID: <20140122090330.GB9532@x220.p-661hnu-f1>
References: <1387540675-2466-1-git-send-email-andre.guedes@openbossa.org>
 <1387540675-2466-7-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387540675-2466-7-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Fri, Dec 20, 2013, Andre Guedes wrote:
> +	hci_req_init(&req, hdev);
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
> +	hci_req_add(&req, HCI_OP_LE_CREATE_CONN, sizeof(cp), &cp);

You might wanna split out hci_req_add a bit with an empty line before it
to make this block of assignments more readable.

> +		memset(&cp, 0, sizeof(cp));
> +		cp.scan_interval = cpu_to_le16(hdev->le_scan_interval);
> +		cp.scan_window = cpu_to_le16(hdev->le_scan_window);
> +		bacpy(&cp.peer_addr, &conn->dst);
> +		cp.peer_addr_type = conn->dst_type;
> +		cp.own_address_type = conn->src_type;
> +		cp.conn_interval_min = cpu_to_le16(conn->le_conn_min_interval);
> +		cp.conn_interval_max = cpu_to_le16(conn->le_conn_max_interval);
> +		cp.supervision_timeout = __constant_cpu_to_le16(0x002a);
> +		cp.min_ce_len = __constant_cpu_to_le16(0x0000);
> +		cp.max_ce_len = __constant_cpu_to_le16(0x0000);
> +		hci_req_add(&req, HCI_OP_LE_CREATE_CONN, sizeof(cp), &cp);
> +
> +		err = hci_req_run(&req, create_le_conn_complete);
> +	}
> +
> +	if (err) {
> +		hci_conn_del(conn);
>  		return ERR_PTR(err);
> +	}

Instead of duplicating the HCI_LE_Create_Connection parameter encoding,
did you consider refactoring this into its own function, maybe something
like:

static void le_create_conn_req(struct hci_request *req,
			       struct hci_dev *hdev, struct hci_conn *conn)
{
	...
}


	le_create_conn_req(&req, hdev, conn);
	err = hci_req_run(&req, le_create_conn_complete);
	if (err)
		...

Johan
