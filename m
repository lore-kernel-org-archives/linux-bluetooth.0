Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Nov 2011 14:58:08 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Brian Gix <bgix@codeaurora.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC 1/1] Bluetooth: Add LE SecMgr and mgmtops support
Message-ID: <20111110125807.GC8486@aemeltch-MOBL1>
References: <4EB854F0.60808@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EB854F0.60808@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Mon, Nov 07, 2011 at 02:00:16PM -0800, Brian Gix wrote:
...
> hci_extended_inquiry_result_evt(struct hci_dev *hdev, struct
> 
>  static inline u8 hci_get_auth_req(struct hci_conn *conn)
>  {
> +	BT_DBG("%p", conn);
> +
>  	/* If remote requests dedicated bonding follow that lead */
>  	if (conn->remote_auth == 0x02 || conn->remote_auth == 0x03) {
>  		/* If both remote and local IO capabilities allow MITM
>  		 * protection then require it, otherwise don't */
> -		if (conn->remote_cap == 0x03 || conn->io_capability == 0x03)
> +		if (conn->remote_cap == 0x03 || conn->io_capability == 0x03) {
>  			return 0x02;
> -		else
> +		} else {
> +			conn->auth_type |= 0x01;
>  			return 0x03;
> +		}
>  	}

Maybe you could also fix those magic numbers issues. We shall define
capabilities.


> 
>  	/* If remote requests no-bonding follow that lead */
> -	if (conn->remote_auth == 0x00 || conn->remote_auth == 0x01)
> -		return conn->remote_auth | (conn->auth_type & 0x01);
> +	if (conn->remote_auth <= 0x01)
> +		return 0x00;
> 
>  	return conn->auth_type;
>  }
> @@ -2626,11 +2660,15 @@ static inline void
> hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff
>  	if (test_bit(HCI_PAIRABLE, &hdev->flags) ||
>  			(conn->remote_auth & ~0x01) == HCI_AT_NO_BONDING) {
>  		struct hci_cp_io_capability_reply cp;
> +		u8 io_cap = conn->io_capability;
> 
> +		/* ACL-SSP does not support IO CAP 0x04 */
> +		cp.capability = (io_cap == 0x04) ? 0x01 : io_cap;
>  		bacpy(&cp.bdaddr, &ev->bdaddr);
> -		cp.capability = conn->io_capability;
> -		conn->auth_type = hci_get_auth_req(conn);
> -		cp.authentication = conn->auth_type;
> +		if (conn->auth_initiator)
> +			cp.authentication = conn->auth_type;
> +		else
> +			cp.authentication = hci_get_auth_req(conn);
> 
>  		if ((conn->out == 0x01 || conn->remote_oob == 0x01) &&
>  				hci_find_remote_oob_data(hdev, &conn->dst))
> @@ -2675,24 +2713,28 @@ unlock:
>  	hci_dev_unlock(hdev);
...

Best regards 
Andrei Emeltchenko 
