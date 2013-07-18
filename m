Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH v9 5/9] Bluetooth: Use voice setting in defered SCO connection request
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1373645143-7494-6-git-send-email-frederic.dalleau@linux.intel.com>
Date: Wed, 17 Jul 2013 18:08:49 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <972DEBBC-A2D1-433A-BB70-3FB9692E5278@holtmann.org>
References: <1373645143-7494-1-git-send-email-frederic.dalleau@linux.intel.com> <1373645143-7494-6-git-send-email-frederic.dalleau@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> When an incoming eSCO connection is requested, check the selected voice setting
> and reply appropriately. Voice setting should have been negotiated previously.
> For example, in case of HFP, the codec is negotiated using AT commands on the
> RFCOMM channel. This patch only changes replies for socket with defered setup
> enabled.
> 
> Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
> ---
> net/bluetooth/sco.c |   22 +++++++++++++++++-----
> 1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index ce8690f..934002c 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -653,7 +653,7 @@ static int sco_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
> 	return err;
> }
> 
> -static void sco_conn_defer_accept(struct hci_conn *conn)
> +static void sco_conn_defer_accept(struct hci_conn *conn, int setting)

since we are using the setting as input to cpu_to_le16, please make this __u16.

> {
> 	struct hci_dev *hdev = conn->hdev;
> 
> @@ -676,9 +676,21 @@ static void sco_conn_defer_accept(struct hci_conn *conn)
> 
> 		cp.tx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
> 		cp.rx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
> -		cp.max_latency    = __constant_cpu_to_le16(0xffff);
> -		cp.content_format = cpu_to_le16(hdev->voice_setting);
> -		cp.retrans_effort = 0xff;
> +		cp.content_format = cpu_to_le16(setting);
> +
> +		switch (setting & SCO_AIRMODE_MASK) {
> +		case SCO_AIRMODE_TRANSP:
> +			if (conn->pkt_type & ESCO_2EV3)
> +				cp.max_latency = __constant_cpu_to_le16(0x0008);
> +			else
> +				cp.max_latency = __constant_cpu_to_le16(0x000D);
> +			cp.retrans_effort = 0x02;
> +			break;
> +		case SCO_AIRMODE_CVSD:
> +			cp.max_latency    = __constant_cpu_to_le16(0xffff);

No need to align = here.

> +			cp.retrans_effort = 0xff;
> +			break;
> +		}
> 
> 		hci_send_cmd(hdev, HCI_OP_ACCEPT_SYNC_CONN_REQ,
> 			     sizeof(cp), &cp);
> @@ -695,7 +707,7 @@ static int sco_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
> 
> 	if (sk->sk_state == BT_CONNECT2 &&
> 	    test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
> -		sco_conn_defer_accept(pi->conn->hcon);
> +		sco_conn_defer_accept(pi->conn->hcon, pi->setting);

Please check that pi->setting is not int type. It needs to be __u16.

> 		sk->sk_state = BT_CONFIG;
> 		msg->msg_namelen = 0;

Regards

Marcel

