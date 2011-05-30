Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 May 2011 19:14:08 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>, luiz.dentz@gmail.com
Subject: Re: [PATCH v2] Bluetooth: Fix auth_complete_evt for legacy units
Message-ID: <20110530221408.GJ2556@joana>
References: <1306399608-10595-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306399608-10595-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldemar,

* Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com> [2011-05-26 10:46:48 +0200]:

> Legacy devices don't re-authenticate the link properly if a link key
> already exists.  Thus, don't update sec_level for this case even if
> hci_auth_complete_evt indicates success. Otherwise the sec_level will
> not reflect a real security on the link.
> 
> Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_conn.c         |    2 +
>  net/bluetooth/hci_event.c        |   73 +++++++++++++++++++++-----------------
>  3 files changed, 43 insertions(+), 33 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 6c994c0..1af6754 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -313,6 +313,7 @@ void hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data);
>  /* ----- HCI Connections ----- */
>  enum {
>  	HCI_CONN_AUTH_PEND,
> +	HCI_CONN_REAUTH_PEND,
>  	HCI_CONN_ENCRYPT_PEND,
>  	HCI_CONN_RSWITCH_PEND,
>  	HCI_CONN_MODE_CHANGE_PEND,
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 3163330..e675402 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -548,6 +548,8 @@ static int hci_conn_auth(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
>  		cp.handle = cpu_to_le16(conn->handle);
>  		hci_send_cmd(conn->hdev, HCI_OP_AUTH_REQUESTED,
>  							sizeof(cp), &cp);
> +		if (conn->key_type != 0xff)
> +			set_bit(HCI_CONN_REAUTH_PEND, &conn->pend);
>  	}
>  
>  	return 0;
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index f13ddbf..4b289a4 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1460,51 +1460,58 @@ static inline void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *s
>  	hci_dev_lock(hdev);
>  
>  	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
> -	if (conn) {
> -		if (!ev->status) {
> +	if (!conn)
> +		goto unlock;

Now you messed up everything with the !conn check. Care to split in two
patches please? One for the !conn change and the other with the actual change
to the code.

-- 
Gustavo F. Padovan
http://profusion.mobi
