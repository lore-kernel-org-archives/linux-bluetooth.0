Return-Path: <cyrus@holtmann.org>
Message-ID: <1361229721.1583.53.camel@aeonflux>
Subject: Re: [PATCH v3 5/5] Bluetooth: Fallback transparent SCO from T2 to T1
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 19 Feb 2013 00:22:01 +0100
In-Reply-To: <1359986188-24432-5-git-send-email-frederic.dalleau@linux.intel.com>
References: <1359986188-24432-1-git-send-email-frederic.dalleau@linux.intel.com>
	 <1359986188-24432-5-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> When initiating a transparent eSCO connection, make use of T2 settings at
> first try. T2 is the recommended settings from HFP 1.6 WideBand Speech. Upon
> connection failure, try T1 settings.
> To know which of T2 or T1 should be used, the connection attempt index is used.
> T2 failure is detected if Synchronous Connection Complete Event fails with
> error 0x0d. This error code has been found experimentally by sending a T2
> request to a T1 only SCO listener. It means "Connection Rejected due to
> Limited resource".
> 
> Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
> ---
>  net/bluetooth/hci_conn.c  |   11 ++++++++++-
>  net/bluetooth/hci_event.c |    1 +
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 504367e..a3f4e29 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -179,12 +179,21 @@ void hci_setup_sync(struct hci_conn *conn, __u16 handle)
>  	cp.tx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
>  	cp.rx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
>  
> -	if (test_and_clear_bit(HCI_CONN_SCO_TRANSPARENT, &conn->flags)) {
> +	if (conn->attempt == 1 &&
> +	    test_bit(HCI_CONN_SCO_TRANSPARENT, &conn->flags)) {
>  		cp.pkt_type       = __constant_cpu_to_le16(EDR_ESCO_MASK &
>  							   ~ESCO_2EV3);
>  		cp.max_latency    = __constant_cpu_to_le16(0x000d);
>  		cp.voice_setting  = __constant_cpu_to_le16(0x0003);
>  		cp.retrans_effort = 0x02;
> +	} else if (conn->attempt == 2 &&
> +		   test_bit(HCI_CONN_SCO_TRANSPARENT, &conn->flags)) {

I do not really like abusing a simple counter as a state machine. We
should do something more explicit with tracking if T2 vs T1 sco_flags or
something.

> +		cp.pkt_type       = __constant_cpu_to_le16(EDR_ESCO_MASK |
> +							   ESCO_EV3);
> +		cp.max_latency    = __constant_cpu_to_le16(0x0007);
> +		cp.voice_setting  = __constant_cpu_to_le16(0x0003);
> +		cp.retrans_effort = 0x02;
> +		clear_bit(HCI_CONN_SCO_TRANSPARENT, &conn->flags);

If we clear this here, does it mean we end up creating a CVSD link. That
can not be correct. I think we need to fail the connection procedure in
that case. We can not magically turn a transparent link into a CVSD
link. That would confuse the hell out of HFP.

>  	} else {
>  		cp.pkt_type       = cpu_to_le16(conn->pkt_type);
>  		cp.max_latency    = __constant_cpu_to_le16(0xffff);
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 3fd0212..6c1aec9 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3330,6 +3330,7 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
>  		hci_conn_add_sysfs(conn);
>  		break;
>  
> +	case 0x0d:	/* No resource available */
>  	case 0x11:	/* Unsupported Feature or Parameter Value */
>  	case 0x1c:	/* SCO interval rejected */
>  	case 0x1a:	/* Unsupported Remote Feature */

Regards

Marcel


