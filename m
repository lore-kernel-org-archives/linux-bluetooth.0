Return-Path: <cyrus@holtmann.org>
Date: Tue, 16 Nov 2010 20:09:07 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@nokia.com>
Subject: Re: [PATCH 3/3] Bluetooth: Automate remote name requests
Message-ID: <20101116220907.GA30115@vigoh>
References: <1289401913-22982-1-git-send-email-johan.hedberg@gmail.com>
 <1289401913-22982-3-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289401913-22982-3-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2010-11-10 17:11:53 +0200]:

> From: Johan Hedberg <johan.hedberg@nokia.com>
> 
> In Bluetooth there are no automatic updates of remote device names when
> they get changed on the remote side. Instead, it is a good idea to do a
> manual name request when a new connection gets created (for whatever
> reason) since at this point it is very cheap (no costly baseband
> connection creation needed just for the sake of the name request).
> 
> So far userspace has been responsible for this extra name request but
> tighter control is needed in order not to flood Bluetooth controllers
> with two many commands during connection creation. It has been shown
> that some controllers simply fail to function correctly if they get too
> many (almost) simultaneous commands during connection creation. The
> simplest way to acheive better control of these commands is to move
> their sending completely to the kernel side.
> 
> This patch inserts name requests into the sequence of events that the
> kernel performs during connection creation. It does this after the
> remote features have been successfully requested and before any pending
> authentication requests are performed. The code will work sub-optimally
> with userspace versions that still do the name requesting themselves (it
> shouldn't break anything though) so it is recommended to combine this
> with a userspace software version that doesn't have automated name
> requests.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
> ---
>  net/bluetooth/hci_event.c |   74 ++++++++++++++++++++++++++++++++++----------
>  1 files changed, 57 insertions(+), 17 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 45569f2..cef970f 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -677,9 +677,8 @@ static void hci_cs_set_conn_encrypt(struct hci_dev *hdev, __u8 status)
>  	hci_dev_unlock(hdev);
>  }
>  
> -static int request_outgoing_auth(struct hci_dev *hdev, bdaddr_t *bdaddr)
> +static int outgoing_auth_needed(struct hci_dev *hdev, bdaddr_t *bdaddr)

Can you add a hci_ in the beginning of your functions, just to keep the
coherency with the rest of the code.

>  {
> -	struct hci_cp_auth_requested cp;
>  	struct hci_conn *conn;
>  
>  	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, bdaddr);
> @@ -698,15 +697,43 @@ static int request_outgoing_auth(struct hci_dev *hdev, bdaddr_t *bdaddr)
>  					conn->sec_level != BT_SECURITY_HIGH)
>  		return 0;
>  
> -	cp.handle = __cpu_to_le16(conn->handle);
> -	hci_send_cmd(hdev, HCI_OP_AUTH_REQUESTED, sizeof(cp), &cp);
> -
>  	return 1;
>  }
>  
> +static int request_auth(struct hci_dev *hdev, bdaddr_t *bdaddr)
> +{
> +	struct hci_cp_auth_requested cp;
> +	struct hci_conn *conn;
> +
> +	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, bdaddr);
> +	if (!conn)
> +		return -ENOTCONN;

I'm not happy with have to lookup the hci_conn twice when we can do that
once here. I've noted that always outgoing_auth_needed() returns 1 you do
a request_auth, and always it returns 0 you don't, so I think we can
embed request_auth() inside outgoing_auth_needed() as it was in patch
2/3 and the give a better name to outgoing_auth_needed() which you
reflect the new behavior.

Regards,

-- 
Gustavo F. Padovan
http://profusion.mobi
