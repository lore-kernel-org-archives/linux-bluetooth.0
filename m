Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v6 5/6] Bluetooth: Parameters for outgoing SCO connections
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1366126143-28545-6-git-send-email-frederic.dalleau@linux.intel.com>
Date: Tue, 16 Apr 2013 10:47:50 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <3BDEC442-2F26-47CC-890F-F31CE1392914@holtmann.org>
References: <1366126143-28545-1-git-send-email-frederic.dalleau@linux.intel.com> <1366126143-28545-6-git-send-email-frederic.dalleau@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> In order to establish a transparent SCO connection, the correct settings must
> be specified in the Setup Synchronous Connection request. For that,
> voice_setting is added to ACL connection flags to set up the desired
> parameters. If this value is zero, a legacy SCO connection will be requested.
> This patch uses T2 settings.
> 
> Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
> ---
> include/net/bluetooth/hci_core.h |    1 +
> net/bluetooth/hci_conn.c         |   22 ++++++++++++++++++----
> 2 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 5c6c5b0..98f8c15 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -328,6 +328,7 @@ struct hci_conn {
> 	__u32		passkey_notify;
> 	__u8		passkey_entered;
> 	__u16		disc_timeout;
> +	__u16		setting;
> 	unsigned long	flags;
> 
> 	__u8		remote_cap;
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 61f686b..cface45 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -185,13 +185,25 @@ void hci_setup_sync(struct hci_conn *conn, __u16 handle)
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
> +
> +	switch (conn->setting) {
> +	case BT_VOICE_TRANSPARENT:

I think we should just check the bits for air codec and see if they match transparent vs cvsd and not use constants here.

> +		cp.pkt_type       = __constant_cpu_to_le16(EDR_ESCO_MASK &
> +							   ~ESCO_2EV3);
> +		cp.max_latency    = __constant_cpu_to_le16(0x000d);
> +		cp.voice_setting  = __constant_cpu_to_le16(0x0003);
> +		cp.retrans_effort = 0x02;
> +		break;
> +	default:
> +		cp.pkt_type       = cpu_to_le16(conn->pkt_type);
> +		cp.max_latency    = __constant_cpu_to_le16(0xffff);
> +		cp.voice_setting  = cpu_to_le16(hdev->voice_setting);

Also if we start setting socket voice_setting options, we need to start using that at some point. The controller default should only be used to initialize the controller or fill in the missing information in case of using the old Add_SCO command.

Regards

Marcel

