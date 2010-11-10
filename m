Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2] Bluetooth: Automate remote name requests
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@nokia.com>
In-Reply-To: <1288282824-30736-1-git-send-email-johan.hedberg@gmail.com>
References: <1288282824-30736-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 10 Nov 2010 14:44:22 +0900
Message-ID: <1289367862.9615.243.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

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
> v2 makes sure that the name request gets always sent instead of just
> doing it for cases when we're also going to request authentication.
> 
>  net/bluetooth/hci_event.c |  151 ++++++++++++++++++++++++++++++++-------------
>  1 files changed, 107 insertions(+), 44 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 84093b0..6e770e8 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -677,9 +677,51 @@ static void hci_cs_set_conn_encrypt(struct hci_dev *hdev, __u8 status)
>  	hci_dev_unlock(hdev);
>  }
>  
> +static void request_outgoing_auth(struct hci_dev *hdev, bdaddr_t *bdaddr)
> +{
> +	struct hci_cp_auth_requested cp;
> +	struct hci_conn *conn;
> +
> +	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, bdaddr);
> +	if (!conn)
> +		return;
> +
> +	if (conn->state != BT_CONFIG || !conn->out)
> +		return;
> +
> +	if (conn->sec_level == BT_SECURITY_SDP)
> +		return;
> +
> +	/* Only request authentication for SSP connections or non-SSP
> +	 * devices with sec_level HIGH */
> +	if (!(hdev->ssp_mode > 0 && conn->ssp_mode > 0) &&
> +					conn->sec_level != BT_SECURITY_HIGH)
> +		return;
> +
> +	cp.handle = __cpu_to_le16(conn->handle);
> +	hci_send_cmd(hdev, HCI_OP_AUTH_REQUESTED, sizeof(cp), &cp);
> +}

please split this patch into two. One creating the common function for
the authentication requested and one for adding the name request.

My brain actually core dumps when following the logic and making sure
that it is still correct. I pretty sure it is correct, but the whole
patch is damn hard to review.

Regards

Marcel


