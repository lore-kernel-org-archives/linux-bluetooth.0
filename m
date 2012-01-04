Return-Path: <cyrus@holtmann.org>
Message-ID: <1325692315.6454.36.camel@aeonflux>
Subject: Re: [RFC v0 2/3] Bluetooth: Use hci_conn_auth() instead of open
 coded version
From: Marcel Holtmann <marcel@holtmann.org>
To: Daniel Wagner <wagi@monom.org>
Cc: linux-bluetooth@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
Date: Wed, 04 Jan 2012 07:51:55 -0800
In-Reply-To: <1325689584-15121-3-git-send-email-wagi@monom.org>
References: <1325689584-15121-1-git-send-email-wagi@monom.org>
	 <1325689584-15121-3-git-send-email-wagi@monom.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

> Note this will also enable the encryption which will
> not happen in the open coded version.
> 
> Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
> ---
>  net/bluetooth/hci_event.c |   12 ++----------
>  1 files changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index d37f5b2..453e483 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1296,11 +1296,7 @@ static void hci_cs_remote_name_req(struct hci_dev *hdev, __u8 status)
>  	if (!hci_outgoing_auth_needed(hdev, conn))
>  		goto unlock;
>  
> -	if (!test_and_set_bit(HCI_CONN_AUTH_PEND, &conn->pend)) {
> -		struct hci_cp_auth_requested cp;
> -		cp.handle = __cpu_to_le16(conn->handle);
> -		hci_send_cmd(hdev, HCI_OP_AUTH_REQUESTED, sizeof(cp), &cp);
> -	}
> +	hci_conn_auth(conn, BT_SECURITY_HIGH, conn->auth_type);

this is not a replacement. Not even a little bit. You are currently
messing with powers that can break qualification.

Regards

Marcel


