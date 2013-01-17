Return-Path: <cyrus@holtmann.org>
Message-ID: <1358432106.3059.18.camel@aeonflux>
Subject: Re: [PATCH 3/5] Bluetooth: Use mode when accepting SCO connection
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 17 Jan 2013 06:15:06 -0800
In-Reply-To: <1358426389-25903-4-git-send-email-frederic.dalleau@linux.intel.com>
References: <1358426389-25903-1-git-send-email-frederic.dalleau@linux.intel.com>
	 <1358426389-25903-4-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> When an incoming SCO connection is requested, check the selected mode, and
> reply appropriately. Mode should have been negotiated previously. For example,
> in case of HFP, the codec is negotiated using AT commands on the RFCOMM
> channel. This patch only changes replies for socket with defered setup enabled.
> ---
>  include/net/bluetooth/hci_core.h |    2 +-
>  net/bluetooth/hci_event.c        |   21 +++++++++++++++++----
>  net/bluetooth/sco.c              |    2 +-
>  3 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 014a2ea..cb5d131 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -577,7 +577,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst);
>  int hci_conn_del(struct hci_conn *conn);
>  void hci_conn_hash_flush(struct hci_dev *hdev);
>  void hci_conn_check_pending(struct hci_dev *hdev);
> -void hci_conn_accept(struct hci_conn *conn, int mask);
> +void hci_conn_accept(struct hci_conn *conn, int mask, int mode);
>  
>  struct hci_chan *hci_chan_create(struct hci_conn *conn);
>  void hci_chan_del(struct hci_chan *chan);
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 705078a..afa0104 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2047,7 +2047,7 @@ unlock:
>  	hci_conn_check_pending(hdev);
>  }
>  
> -void hci_conn_accept(struct hci_conn *conn, int mask)
> +void hci_conn_accept(struct hci_conn *conn, int mask, int mode)
>  {
>  	struct hci_dev *hdev = conn->hdev;
>  
> @@ -2074,9 +2074,22 @@ void hci_conn_accept(struct hci_conn *conn, int mask)
>  
>  		cp.tx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
>  		cp.rx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
> -		cp.max_latency    = __constant_cpu_to_le16(0xffff);
> -		cp.content_format = cpu_to_le16(hdev->voice_setting);
> -		cp.retrans_effort = 0xff;
> +
> +		switch (mode) {
> +		case 0:
> +			cp.max_latency    = __constant_cpu_to_le16(0xffff);
> +			cp.content_format = cpu_to_le16(hdev->voice_setting);
> +			cp.retrans_effort = 0xff;
> +			break;
> +		case 1:
> +			if (conn->pkt_type & ESCO_2EV3)
> +				cp.max_latency = __constant_cpu_to_le16(0x0008);
> +			else
> +				cp.max_latency = __constant_cpu_to_le16(0x000D);
> +			cp.content_format = __constant_cpu_to_le16(0x0003);
> +			cp.retrans_effort = 0x02;
> +			break;
> +		}

so what happens if someone sets mode == 0x02, then we just send some
random data. This reminds me, we need to do range checks for the
setsockopt call. Only valid modes are suppose to be allowed.
>  
>  		hci_send_cmd(hdev, HCI_OP_ACCEPT_SYNC_CONN_REQ,
>  			     sizeof(cp), &cp);
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index 22ad5fa..6a957a3 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -666,7 +666,7 @@ static int sco_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
>  
>  	if (sk->sk_state == BT_CONNECT2 &&
>  	    test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
> -		hci_conn_accept(pi->conn->hcon, 0);
> +		hci_conn_accept(pi->conn->hcon, 0, pi->mode);
>  		sk->sk_state = BT_CONFIG;
>  
>  		release_sock(sk);

Regards

Marcel


