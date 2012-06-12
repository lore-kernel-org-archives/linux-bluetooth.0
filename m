Return-Path: <cyrus@holtmann.org>
Date: Tue, 12 Jun 2012 03:59:07 -0300 (BRT)
Message-Id: <20120612.035907.1947511592259870809.pcacjr@zytor.com>
To: paulo.alcantara@openbossa.org
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Report correct error codes on disconnect
From: pcacjr@zytor.com
In-Reply-To: <1339127713-19325-1-git-send-email-paulo.alcantara@openbossa.org>
References: <1339127713-19325-1-git-send-email-paulo.alcantara@openbossa.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Paulo Alcantara <paulo.alcantara@openbossa.org>
Date: Fri,  8 Jun 2012 00:55:13 -0300

> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 47656be..2c7e4a7 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1915,9 +1915,17 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
>  	}
>  
>  	if (ev->status == 0) {
> +		__u8 reason;
> +
>  		if (conn->type == ACL_LINK && conn->flush_key)
>  			hci_remove_link_key(hdev, &conn->dst);
> -		hci_proto_disconn_cfm(conn, ev->reason);
> +
> +		reason = hci_proto_disconn_ind(conn);
> +		if (reason)
> +			hci_proto_disconn_cfm(conn, reason);
> +		else
> +			hci_proto_disconn_cfm(conn, ev->reason);
> +

This is check is wrong since disc_reason is _always_ set to
HCI_ERROR_REMOTE_USER_TERM by default and it can be set to
HCI_ERROR_AUTH_FAILURE as well in l2cap_connect_req(), but it is _never_ set to
0 in anywhere else. I still do not know the reason why is always set to
HCI_ERROR_REMOTE_USER_TERM by default, but I've got two "solutions" for handling
this specific issue so far.

Primarily, it's worth to note that what I'm doing here is to avoid overwriting
error codes returned by LE encryption change event and exposing wrong error ones
to user space. BlueZ should handle specific error codes (e.g.: 0x06 "PIN or key
missing") that are returned by LE encrpytion change event, and not enabling auto
connection when there is "PIN or key missing" error code set in this event, for
example.

Well, the "solutions" that I've got are:

1) We can set the disconnect reason to 0 by default and set it accordingly.

2) Or change this check in hci_disconn_complete_evt() function to:

/* If reason was previously set in hci_encrypt_change_evt(), then we need to use
 * the reason set in disc_reason instead of the event one.
 */
if (reason != HCI_ERROR_REMOTE_USER_TERM && reason != HCI_ERROR_AUTH_FAILURE)
	hci_proto_disconn_cfm(conn, reason);
else
	hci_proto_disconn_cfm(conn, ev->reason);

(Although, the 2nd solution looks better and probably correct to me, IMO)

Do you guys have any other solution or comment that I could take into account,
or even any improvement in one of my solutions given above ?

       	    Paulo
