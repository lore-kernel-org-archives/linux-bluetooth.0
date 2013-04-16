Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v6 4/6] Bluetooth: Use voice setting in incoming SCO connection
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1366126143-28545-5-git-send-email-frederic.dalleau@linux.intel.com>
Date: Tue, 16 Apr 2013 10:44:51 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A250FDDC-0B69-4735-BC9D-3C988FBE5F95@holtmann.org>
References: <1366126143-28545-1-git-send-email-frederic.dalleau@linux.intel.com> <1366126143-28545-5-git-send-email-frederic.dalleau@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> When an incoming SCO connection is requested, check the selected voice setting,
> and reply appropriately. Voice setting should have been negotiated previously.
> For example, in case of HFP, the codec is negotiated using AT commands on the
> RFCOMM channel. This patch only changes replies for socket with defered setup
> enabled.
> 
> Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
> ---
> net/bluetooth/sco.c |   23 ++++++++++++++++++-----
> 1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index 4e69923..876f80e 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -653,7 +653,7 @@ static int sco_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
> 	return err;
> }
> 
> -static void sco_conn_defer_accept(struct hci_conn *conn, int mask)
> +static void sco_conn_defer_accept(struct hci_conn *conn, int mask, int setting)
> {
> 	struct hci_dev *hdev = conn->hdev;
> 
> @@ -680,9 +680,22 @@ static void sco_conn_defer_accept(struct hci_conn *conn, int mask)

are we keep using the mask parameter here?

> 
> 		cp.tx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
> 		cp.rx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
> -		cp.max_latency    = __constant_cpu_to_le16(0xffff);
> -		cp.content_format = cpu_to_le16(hdev->voice_setting);
> -		cp.retrans_effort = 0xff;
> +
> +		switch (setting) {
> +		case BT_VOICE_TRANSPARENT:
> +			if (conn->pkt_type & ESCO_2EV3)
> +				cp.max_latency = __constant_cpu_to_le16(0x0008);
> +			else
> +				cp.max_latency = __constant_cpu_to_le16(0x000D);
> +			cp.content_format = __constant_cpu_to_le16(0x0003);
> +			cp.retrans_effort = 0x02;
> +			break;
> +		default:
> +			cp.max_latency    = __constant_cpu_to_le16(0xffff);
> +			cp.content_format = cpu_to_le16(hdev->voice_setting);
> +			cp.retrans_effort = 0xff;
> +			break;
> +		}
> 
> 		hci_send_cmd(hdev, HCI_OP_ACCEPT_SYNC_CONN_REQ,
> 			     sizeof(cp), &cp);
> @@ -699,7 +712,7 @@ static int sco_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
> 
> 	if (sk->sk_state == BT_CONNECT2 &&
> 	    test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
> -		sco_conn_defer_accept(pi->conn->hcon, 0);
> +		sco_conn_defer_accept(pi->conn->hcon, 0, pi->setting);

If the mask is always 0, then please just send a patch to remove that parameter.

Regards

Marcel

