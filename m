Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
CC: "padovan@profusion.mobi" <padovan@profusion.mobi>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 8 Sep 2011 14:16:57 -0400
Subject: Re: [PATCH v3 1/2] Bluetooth: Fix auth_complete_evt for legacy units
Message-ID: <1315505817.2004.70.camel@THOR>
References: <1306849766-31540-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
In-Reply-To: <1306849766-31540-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldemar,

On Tue, 2011-05-31 at 09:49 -0400, Waldemar Rymarkiewicz wrote: 
> Legacy devices don't re-authenticate the link properly if a link key
> already exists.  Thus, don't update sec_level for this case even if
> hci_auth_complete_evt indicates success. Otherwise the sec_level will
> not reflect a real security on the link.
> 
> Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>

Can you clarify what you mean by "Legacy devices don't re-authenticate
the link properly if a link key already exists"?

Other than a controller defect, I'm having trouble understanding how an
authentication could be reported as successful by the host controller
if the remote fails to provide an acceptable LMP_sres pdu. Or did the
link manager not send an LMP_au_rand or was a new AU_RAND not issued? 

The reason this came up is because I'm testing a patch set that performs
automatic re-authentication tied to l2cap channel sec_level promotion,
via sockopts, and I'm not seeing problems with this reverted.

> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_conn.c         |    2 ++
>  net/bluetooth/hci_event.c        |   12 ++++++++++--
>  3 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index af4b0ed..0ac820d 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -322,6 +322,7 @@ void hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data);
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

Also, can you help me understand why the AUTH_REQUESTED cmd is sent
anyway and a pend status used for indication (as opposed to testing
for the legacy device in hci_conn_auth and returning early).

>  	}
>  
>  	return 0;
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index c456f9c..82061db 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1491,13 +1491,21 @@ static inline void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *s
>  	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
>  	if (conn) {
>  		if (!ev->status) {
> -			conn->link_mode |= HCI_LM_AUTH;
> -			conn->sec_level = conn->pending_sec_level;
> +			if (!(conn->ssp_mode > 0 && hdev->ssp_mode > 0) &&
> +						test_bit(HCI_CONN_REAUTH_PEND,
> +						&conn->pend)) {
> +				BT_INFO("re-auth of legacy device is not"
> +								"possible.");
> +			} else {
> +				conn->link_mode |= HCI_LM_AUTH;
> +				conn->sec_level = conn->pending_sec_level;
> +			}
>  		} else {
>  			mgmt_auth_failed(hdev->id, &conn->dst, ev->status);
>  		}
>  
>  		clear_bit(HCI_CONN_AUTH_PEND, &conn->pend);
> +		clear_bit(HCI_CONN_REAUTH_PEND, &conn->pend);
>  
>  		if (conn->state == BT_CONFIG) {
>  			if (!ev->status && hdev->ssp_mode > 0 &&

Regards,
Peter Hurley

