Return-Path: <cyrus@holtmann.org>
Message-ID: <1358432224.3059.19.camel@aeonflux>
Subject: Re: [PATCH 4/5] Bluetooth: Parameters for outgoing SCO connections
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 17 Jan 2013 06:17:04 -0800
In-Reply-To: <1358426389-25903-5-git-send-email-frederic.dalleau@linux.intel.com>
References: <1358426389-25903-1-git-send-email-frederic.dalleau@linux.intel.com>
	 <1358426389-25903-5-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> In order to establish a transparent SCO connection, the correct settings must
> be specified in the SetupSynchronousConnection request. For that, a bit is set
> in ACL connection flags to set up the desired parameters. If this bit is not
> set, a legacy SCO connection will be requested.
> This patch uses T2 settings.
> ---
>  include/net/bluetooth/hci_core.h |    3 +++
>  net/bluetooth/hci_conn.c         |   27 ++++++++++++++++++++-------
>  net/bluetooth/sco.c              |    4 ++--
>  3 files changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index cb5d131..9ef7fe0 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -438,6 +438,7 @@ enum {
>  	HCI_CONN_SSP_ENABLED,
>  	HCI_CONN_POWER_SAVE,
>  	HCI_CONN_REMOTE_OOB,
> +	HCI_CONN_SCO_TRANSPARENT,
>  };
>  
>  static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
> @@ -586,6 +587,8 @@ struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle);
>  
>  struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
>  			     __u8 dst_type, __u8 sec_level, __u8 auth_type);
> +struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
> +				 u8 sec_level, u8 auth_type, u8 codec);
>  int hci_conn_check_link_mode(struct hci_conn *conn);
>  int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
>  int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type);
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 25bfce0..e3f1fad 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -175,13 +175,22 @@ void hci_setup_sync(struct hci_conn *conn, __u16 handle)
>  	conn->attempt++;
>  
>  	cp.handle   = cpu_to_le16(handle);
> -	cp.pkt_type = cpu_to_le16(conn->pkt_type);
>  
>  	cp.tx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
>  	cp.rx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
> -	cp.max_latency    = __constant_cpu_to_le16(0xffff);
> -	cp.voice_setting  = cpu_to_le16(hdev->voice_setting);
> -	cp.retrans_effort = 0xff;
> +
> +	if (test_and_clear_bit(HCI_CONN_SCO_TRANSPARENT, &conn->flags)) {
> +		cp.pkt_type       = __constant_cpu_to_le16(EDR_ESCO_MASK &
> +							   ~ESCO_2EV3);
> +		cp.max_latency    = __constant_cpu_to_le16(0x000d);
> +		cp.voice_setting  = __constant_cpu_to_le16(0x0003);
> +		cp.retrans_effort = 0x02;
> +	} else {
> +		cp.pkt_type       = cpu_to_le16(conn->pkt_type);
> +		cp.max_latency    = __constant_cpu_to_le16(0xffff);
> +		cp.voice_setting  = cpu_to_le16(hdev->voice_setting);
> +		cp.retrans_effort = 0xff;
> +	}
>  
>  	hci_send_cmd(hdev, HCI_OP_SETUP_SYNC_CONN, sizeof(cp), &cp);
>  }
> @@ -551,8 +560,9 @@ static struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
>  	return acl;
>  }
>  
> -static struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type,
> -				bdaddr_t *dst, u8 sec_level, u8 auth_type)
> +struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type,
> +					bdaddr_t *dst, u8 sec_level,
> +					u8 auth_type, u8 codec)
>  {
>  	struct hci_conn *acl;
>  	struct hci_conn *sco;
> @@ -575,6 +585,9 @@ static struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type,
>  
>  	hci_conn_hold(sco);
>  
> +	if (codec)
> +		set_bit(HCI_CONN_SCO_TRANSPARENT, &sco->flags);
> +
>  	if (acl->state == BT_CONNECTED &&
>  	    (sco->state == BT_OPEN || sco->state == BT_CLOSED)) {
>  		set_bit(HCI_CONN_POWER_SAVE, &acl->flags);
> @@ -605,7 +618,7 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
>  		return hci_connect_acl(hdev, dst, sec_level, auth_type);
>  	case SCO_LINK:
>  	case ESCO_LINK:
> -		return hci_connect_sco(hdev, type, dst, sec_level, auth_type);
> +		return hci_connect_sco(hdev, type, dst, sec_level, auth_type, 0);
>  	}
>  
>  	return ERR_PTR(-EINVAL);
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index 6a957a3..bee0b5c 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -176,8 +176,8 @@ static int sco_connect(struct sock *sk)
>  	else
>  		type = SCO_LINK;
>  
> -	hcon = hci_connect(hdev, type, dst, BDADDR_BREDR, BT_SECURITY_LOW,
> -			   HCI_AT_NO_BONDING);
> +	hcon = hci_connect_sco(hdev, type, dst, BT_SECURITY_LOW,
> +			       HCI_AT_NO_BONDING, sco_pi(sk)->mode);

if we start doing this, then the security requirements for SCO channels
are pointless. They do not exists.

Regards

Marcel


