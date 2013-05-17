Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v7 3/8] Bluetooth: Add bluetooth socket voice option
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1368725646-4593-4-git-send-email-frederic.dalleau@linux.intel.com>
Date: Fri, 17 May 2013 10:48:02 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <630221C9-B0B8-4670-B3E6-8EB597CC3D8D@holtmann.org>
References: <1368725646-4593-1-git-send-email-frederic.dalleau@linux.intel.com> <1368725646-4593-4-git-send-email-frederic.dalleau@linux.intel.com>
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
> index 6912ef9..0239a49 100644
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

call this BT_VOICE_CVSD_16BIT. You could run this with CVSD_8BIT as well if we ever care to get that fixed.

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
> index 26c9d51..7b4c3df 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -416,6 +416,8 @@ static struct sock *sco_sock_alloc(struct net *net, struct socket *sock, int pro
> 	sk->sk_protocol = proto;
> 	sk->sk_state    = BT_OPEN;
> 
> +	sco_pi(sk)->setting = BT_VOICE_CVSD;
> +
> 	setup_timer(&sk->sk_timer, sco_sock_timeout, (unsigned long)sk);
> 
> 	bt_sock_link(&sco_sk_list, sk);
> @@ -708,7 +710,8 @@ static int sco_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
> static int sco_sock_setsockopt(struct socket *sock, int level, int optname, char __user *optval, unsigned int optlen)
> {
> 	struct sock *sk = sock->sk;
> -	int err = 0;
> +	int len, err = 0;
> +	struct bt_voice voice;
> 	u32 opt;
> 
> 	BT_DBG("sk %p", sk);
> @@ -734,6 +737,29 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname, char
> 			clear_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
> 		break;
> 
> +	case BT_VOICE:
> +		if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND &&
> +		    sk->sk_state != BT_CONNECT2) {
> +			err = -EINVAL;
> +			break;
> +		}
> +

Actually you need to set defaults here first. Otherwise updated userspaces with more options might not work properly.

		voice.setting = sco_pi(sk)->setting.

> +		len = min_t(unsigned int, sizeof(voice), optlen);
> +		if (copy_from_user((char *) &voice, optval, len)) {
> +			err = -EFAULT;
> +			break;
> +		}
> +
> +

Double empty line here. I assume you wanted to add a comment that for now we are only accepting two settings at the moment.

> +		if (voice.setting != BT_VOICE_TRANSPARENT &&
> +		    voice.setting != BT_VOICE_CVSD) {
> +			err = -EINVAL;
> +			break;
> +		}
> +
> +		sco_pi(sk)->setting = voice.setting;
> +		break;
> +
> 	default:
> 		err = -ENOPROTOOPT;
> 		break;
> @@ -803,6 +829,7 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname, char
> {
> 	struct sock *sk = sock->sk;
> 	int len, err = 0;
> +	struct bt_voice voice;
> 
> 	BT_DBG("sk %p", sk);
> 
> @@ -828,6 +855,15 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname, char
> 
> 		break;
> 
> +	case BT_VOICE:
> +		voice.setting = sco_pi(sk)->setting;
> +
> +		len = min_t(unsigned int, len, sizeof(voice));
> +		if (copy_to_user(optval, (char *)&voice, len))
> +			err = -EFAULT;
> +
> +		break;
> +
> 	default:
> 		err = -ENOPROTOOPT;
> 		break;

Regards

Marcel

