Return-Path: <cyrus@holtmann.org>
Date: Fri, 22 Oct 2010 17:14:57 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/6] Bluetooth: Add LE connection support to L2CAP
Message-ID: <20101022191457.GE980@vigoh>
References: <1287406976-13463-1-git-send-email-ville.tervo@nokia.com>
 <1287406976-13463-5-git-send-email-ville.tervo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1287406976-13463-5-git-send-email-ville.tervo@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ville,

* Ville Tervo <ville.tervo@nokia.com> [2010-10-18 16:02:54 +0300]:

> Add basic LE connection support to L2CAP. LE
> connection can be created by specifying cid
> in struct sockaddr_l2
> 
> Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
> ---
>  include/net/bluetooth/l2cap.h |    3 +++
>  net/bluetooth/l2cap.c         |   32 ++++++++++++++++++++++++--------
>  2 files changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index c819c8b..cc3a140 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -160,6 +160,9 @@ struct l2cap_conn_rsp {
>  /* channel indentifier */
>  #define L2CAP_CID_SIGNALING	0x0001
>  #define L2CAP_CID_CONN_LESS	0x0002
> +#define L2CAP_CID_LE_DATA	0x0004
> +#define L2CAP_CID_LE_SIGNALING	0x0005
> +#define L2CAP_CID_SMP		0x0006
>  #define L2CAP_CID_DYN_START	0x0040
>  #define L2CAP_CID_DYN_END	0xffff
>  
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index 16049de..bf5daf3 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -617,6 +617,12 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
>  	for (sk = l->head; sk; sk = l2cap_pi(sk)->next_c) {
>  		bh_lock_sock(sk);
>  
> +		if (conn->hcon->type == LE_LINK) {
> +			l2cap_sock_clear_timer(sk);
> +			sk->sk_state = BT_CONNECTED;
> +			sk->sk_state_change(sk);
> +		}
> +
>  		if (sk->sk_type != SOCK_SEQPACKET &&
>  				sk->sk_type != SOCK_STREAM) {
>  			l2cap_sock_clear_timer(sk);
> @@ -675,7 +681,11 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
>  
>  	BT_DBG("hcon %p conn %p", hcon, conn);
>  
> -	conn->mtu = hcon->hdev->acl_mtu;
> +	if (hcon->hdev->le_mtu && hcon->type == LE_LINK)
> +		conn->mtu = hcon->hdev->le_mtu;
> +	else
> +		conn->mtu = hcon->hdev->acl_mtu;
> +
>  	conn->src = &hcon->hdev->bdaddr;
>  	conn->dst = &hcon->dst;
>  
> @@ -1102,8 +1112,13 @@ static int l2cap_do_connect(struct sock *sk)
>  		}
>  	}
>  
> -	hcon = hci_connect(hdev, ACL_LINK, dst,
> +	if (l2cap_pi(sk)->dcid == L2CAP_CID_LE_DATA)
> +		hcon = hci_connect(hdev, LE_LINK, dst,
> +					l2cap_pi(sk)->sec_level, auth_type);
> +	else


I think that "else if (l2cap_pi(sk)->psm)" is better here, we do not
want to permit go ahead with psm 0.


-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
