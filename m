Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v7 6/8] Bluetooth: Parameters for outgoing SCO connections
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1368725646-4593-7-git-send-email-frederic.dalleau@linux.intel.com>
Date: Fri, 17 May 2013 10:55:29 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <5910C04C-A52D-401A-A298-E7031A190B08@holtmann.org>
References: <1368725646-4593-1-git-send-email-frederic.dalleau@linux.intel.com> <1368725646-4593-7-git-send-email-frederic.dalleau@linux.intel.com>
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
> index a6fd544..b5996b3 100644
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
> index d1d9919..cd7452e 100644
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

same here. What are we doing with Add_SCO fallback on older controllers.

We could just reject setting transparent air mode for controllers that do not support eSCO command procedures. And the only valid option there would be CVSD then. Which is default.

In case we use Add_SCO is is important that the voice setting programmed into the controller is actually 16-bit CVSD at that time. That needs to be taken care of as well.

Regards

Marcel

