Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Apr 2012 14:04:52 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Hemant Gupta <hemant.gupta@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org,
	Hemant Gupta <hemantgupta.ste@gmail.com>
Subject: Re: [PATCH] Bluetooth: Send Connect failed event when LE Connection
 fails
Message-ID: <20120405110452.GA1654@x220>
References: <1333615989-15979-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333615989-15979-1-git-send-email-hemant.gupta@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hemant,

On Thu, Apr 05, 2012, Hemant Gupta wrote:
> This patch adds management connect failed event when LE Create Connection
> Command fails to inform BlueZ that LE Connection failed to get established.

s/BlueZ/user space/

Also change the summary line to:

Bluetooth: mgmt: Fix missing connect failed event for LE

> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1649,6 +1649,8 @@ static void hci_cs_le_create_conn(struct hci_dev *hdev, __u8 status)
>  	if (status) {
>  		if (conn && conn->state == BT_CONNECT) {
>  			conn->state = BT_CLOSED;
> +			mgmt_connect_failed(hdev, &cp->peer_addr, conn->type,
> +							conn->dst_type, status);
>  			hci_proto_connect_cfm(conn, status);
>  			hci_conn_del(conn);
>  		}

Please use our new alignment style for split lines, i.e. align with the
opening parenthesis.

Johan
