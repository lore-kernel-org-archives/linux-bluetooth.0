Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH v8 2/8] Bluetooth: Remove unused mask parameter in sco_conn_defer_accept
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1373036503-1349-3-git-send-email-frederic.dalleau@linux.intel.com>
Date: Mon, 8 Jul 2013 12:10:23 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <45E64423-16D6-4473-A390-226E5E76AC97@holtmann.org>
References: <1373036503-1349-1-git-send-email-frederic.dalleau@linux.intel.com> <1373036503-1349-3-git-send-email-frederic.dalleau@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Bluetooth specification states that when accepting a bluetooth synchronous
> connection request, the role parameter is unused and will be ignored by the
> controller. Moreover, the function is called only once with a fixed value.

can you give the exact reference where this is stated. Since I fail to find it.

> Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
> ---
> net/bluetooth/sco.c |   10 +++-------
> 1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index 7114984..0c15a0c 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -651,7 +651,7 @@ static int sco_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
> 	return err;
> }
> 
> -static void sco_conn_defer_accept(struct hci_conn *conn, int mask)
> +static void sco_conn_defer_accept(struct hci_conn *conn)
> {
> 	struct hci_dev *hdev = conn->hdev;
> 
> @@ -663,11 +663,7 @@ static void sco_conn_defer_accept(struct hci_conn *conn, int mask)
> 		struct hci_cp_accept_conn_req cp;
> 
> 		bacpy(&cp.bdaddr, &conn->dst);
> -
> -		if (lmp_rswitch_capable(hdev) && (mask & HCI_LM_MASTER))
> -			cp.role = 0x00; /* Become master */
> -		else
> -			cp.role = 0x01; /* Remain slave */
> +		cp.role = 0x00; /* Ignored */

Is it really 0x00 and not 0x01 to stay slave.

> 
> 		hci_send_cmd(hdev, HCI_OP_ACCEPT_CONN_REQ, sizeof(cp), &cp);
> 	} else {
> @@ -697,7 +693,7 @@ static int sco_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
> 
> 	if (sk->sk_state == BT_CONNECT2 &&
> 	    test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
> -		sco_conn_defer_accept(pi->conn->hcon, 0);
> +		sco_conn_defer_accept(pi->conn->hcon);
> 		sk->sk_state = BT_CONFIG;
> 		msg->msg_namelen = 0;

Regards

Marcel

