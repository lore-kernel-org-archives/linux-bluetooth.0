Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v6 2/6] Bluetooth: Add bluetooth socket voice option
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1366126143-28545-3-git-send-email-frederic.dalleau@linux.intel.com>
Date: Tue, 16 Apr 2013 10:39:55 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7D7C6747-5C34-41F2-8EC7-4855C5689643@holtmann.org>
References: <1366126143-28545-1-git-send-email-frederic.dalleau@linux.intel.com> <1366126143-28545-3-git-send-email-frederic.dalleau@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> This patch extends the current bluetooth socket option to add BT_VOICE.
> This is intended to choose voice data type at runtime. It only applies to SCO
> sockets.
> Incoming connections shall be setup during defered setup. Outgoing connections
> shall be setup before connect(). The desired setting is stored in the sco
> socket info.
> This patch declares needed members, modifies getsockopt() and setsockopt().
> 
> Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
> ---
> include/net/bluetooth/bluetooth.h |    8 ++++++++
> include/net/bluetooth/sco.h       |    1 +
> net/bluetooth/sco.c               |   38 ++++++++++++++++++++++++++++++++++++-
> 3 files changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index 591fee7..e66b9b0 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -107,6 +107,14 @@ struct bt_power {
>  */
> #define BT_CHANNEL_POLICY_AMP_PREFERRED		2
> 
> +#define BT_VOICE		11
> +struct bt_voice {
> +	__u16 setting;
> +};
> +
> +#define BT_VOICE_TRANSPARENT			0x0003
> +#define BT_VOICE_CVSD				0x0060
> +
> __printf(1, 2)
> int bt_info(const char *fmt, ...);
> __printf(1, 2)
> diff --git a/include/net/bluetooth/sco.h b/include/net/bluetooth/sco.h
> index 1e35c43..e252a31 100644
> --- a/include/net/bluetooth/sco.h
> +++ b/include/net/bluetooth/sco.h
> @@ -73,6 +73,7 @@ struct sco_conn {
> struct sco_pinfo {
> 	struct bt_sock	bt;
> 	__u32		flags;
> +	__u16		setting;
> 	struct sco_conn	*conn;
> };
> 
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index 9e62102..454ab64 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -417,6 +417,8 @@ static struct sock *sco_sock_alloc(struct net *net, struct socket *sock, int pro
> 	sk->sk_protocol = proto;
> 	sk->sk_state    = BT_OPEN;
> 
> +	sco_pi(sk)->setting = 0;
> +

wouldn't it be better if this default to the current controller setting. However I realize that the controller might be actually not yet present. So shouldn't we default to 0x0060 for CVSD.

Regards

Marcel

