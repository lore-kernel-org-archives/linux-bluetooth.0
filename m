Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH v9 6/9] Bluetooth: Parameters for outgoing SCO connections
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1373645143-7494-7-git-send-email-frederic.dalleau@linux.intel.com>
Date: Wed, 17 Jul 2013 18:22:02 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <EB1AE355-6489-4D96-BFDB-BEF7935CFE34@holtmann.org>
References: <1373645143-7494-1-git-send-email-frederic.dalleau@linux.intel.com> <1373645143-7494-7-git-send-email-frederic.dalleau@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> In order to establish a transparent SCO connection, the correct settings must
> be specified in the Setup Synchronous Connection request. For that,
> a setting field is added to ACL connection data to set up the desired
> parameters.
> Remove usage of hdev->voice_setting in CVSD connection.
> Make use of T2 parameters for transparent data.
> 
> Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
> ---
> include/net/bluetooth/hci_core.h |    1 +
> net/bluetooth/hci_conn.c         |   21 +++++++++++++++++----
> 2 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 69bdb67..61ca2ce 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -320,6 +320,7 @@ struct hci_conn {
> 	__u32		passkey_notify;
> 	__u8		passkey_entered;
> 	__u16		disc_timeout;
> +	__u16		setting;
> 	unsigned long	flags;
> 
> 	__u8		remote_cap;
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index d1d9919..c4d6163 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -185,13 +185,24 @@ void hci_setup_sync(struct hci_conn *conn, __u16 handle)
> 	conn->attempt++;
> 
> 	cp.handle   = cpu_to_le16(handle);
> -	cp.pkt_type = cpu_to_le16(conn->pkt_type);
> 
> 	cp.tx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
> 	cp.rx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
> -	cp.max_latency    = __constant_cpu_to_le16(0xffff);
> -	cp.voice_setting  = cpu_to_le16(hdev->voice_setting);
> -	cp.retrans_effort = 0xff;
> +	cp.voice_setting  = cpu_to_le16(conn->setting);
> +
> +	switch (conn->setting & SCO_AIRMODE_MASK) {
> +	case SCO_AIRMODE_TRANSP:
> +		cp.pkt_type       = __constant_cpu_to_le16(EDR_ESCO_MASK &
> +							   ~ESCO_2EV3);
> +		cp.max_latency    = __constant_cpu_to_le16(0x000d);

please do not try to align = here.

> +		cp.retrans_effort = 0x02;
> +		break;
> +	case SCO_AIRMODE_CVSD:
> +		cp.pkt_type       = cpu_to_le16(conn->pkt_type);
> +		cp.max_latency    = __constant_cpu_to_le16(0xffff);

And here as well. No need for that.

> +		cp.retrans_effort = 0xff;
> +		break;
> +	}
> 
> 	hci_send_cmd(hdev, HCI_OP_SETUP_SYNC_CONN, sizeof(cp), &cp);
> }
> @@ -584,6 +595,8 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
> 
> 	hci_conn_hold(sco);
> 
> +	sco->setting = setting;
> +
> 	if (acl->state == BT_CONNECTED &&
> 	    (sco->state == BT_OPEN || sco->state == BT_CLOSED)) {
> 		set_bit(HCI_CONN_POWER_SAVE, &acl->flags);

Regards

Marcel

