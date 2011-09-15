Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Thu, 15 Sep 2011 09:03:54 -0400
Subject: Re: [PATCH v2] Bluetooth: Preserve auth + encrypt for sec mode 3
 remotes
Message-ID: <1316091834.11366.16.camel@THOR>
References: <1312922561.2261.9.camel@THOR>
In-Reply-To: <1312922561.2261.9.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2011-08-09 at 16:42 -0400, Peter Hurley wrote:
> Legacy remote devices (v 2.0-) can establish link-level
> encryption as part of ACL connection establishment
> (ie., security mode 3). The host controller indicates link-level
> encryption is established in this case with the
> Encryption_Enabled flag of the Connection Complete event.
> 
> This two-part fix first sets the correct link state for this
> condition and, second, bypasses additional auth + encrypt for
> subsequent security level elevations (up to but not including
> BT_SECURITY_HIGH).
> 
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
> 
> v2: Remove redundant ssp_mode tests and set connection
> security level from pending when handling conn_complete evt 
> 
>  net/bluetooth/hci_conn.c  |   13 +++++++++++--
>  net/bluetooth/hci_event.c |    9 +++++++++
>  2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index e333274..bfdd63f 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -541,9 +541,18 @@ static int hci_conn_auth(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
>  	if (conn->pending_sec_level > sec_level)
>  		sec_level = conn->pending_sec_level;
>  
> -	if (sec_level > conn->sec_level)
> +	if (sec_level > conn->sec_level) {
>  		conn->pending_sec_level = sec_level;
> -	else if (conn->link_mode & HCI_LM_AUTH)
> +		/* Legacy security mode 3 remote devices that are already
> +		 * auth'd do not need to re-auth unless promoting to
> +		 * BT_SECURITY_HIGH */
> +		if (!(conn->hdev->ssp_mode > 0 && conn->ssp_mode > 0) &&
> +				(sec_level != BT_SECURITY_HIGH) &&
> +				(conn->link_mode & HCI_LM_AUTH)) {
> +			conn->sec_level = sec_level;
> +			return 1;
> +		}
> +	} else if (conn->link_mode & HCI_LM_AUTH)
>  		return 1;
>  
>  	/* Make sure we preserve an existing MITM requirement*/
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 77930aa..464cfb4 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1311,6 +1311,15 @@ static inline void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *s
>  		if (test_bit(HCI_ENCRYPT, &hdev->flags))
>  			conn->link_mode |= HCI_LM_ENCRYPT;
>  
> +		/* Indicate the correct link state for legacy sec mode 3
> +		 * remote devices for which the LM has already established
> +		 * link encryption */
> +		if (conn->type == ACL_LINK && ev->encr_mode == 0x01 &&
> +				conn->pending_sec_level != BT_SECURITY_HIGH) {
> +			conn->link_mode |= HCI_LM_AUTH | HCI_LM_ENCRYPT;
> +			conn->sec_level = conn->pending_sec_level;
> +		}
> +
>  		/* Get remote features */
>  		if (conn->type == ACL_LINK) {
>  			struct hci_cp_read_remote_features cp;
> -- 

Turns out this is not allowed per spec. From the Core 4.0 spec, Vol 3,
Part C - Generic Access Profile, Section 5.2.2.2.2, Authentication
Required for Access to Local Service by Remote Device:

"A Bluetooth device in security mode 4 shall respond to authentication
and pairing requests during link establishment when the remote device is
in security mode 3 for backwards compatibility reasons. However,
authentication of the remote device shall be performed after the receipt
of the channel establishment request is received, and before the channel
establishment response is sent."

