Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v3 2/4] Bluetooth: bnep: Add support for get bnep features via ioctl
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1427813761-32123-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Date: Tue, 31 Mar 2015 08:28:06 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E81E28E1-07A5-49BF-8F9D-2728E81808E1@holtmann.org>
References: <1427813761-32123-1-git-send-email-grzegorz.kolodziejczyk@tieto.com> <1427813761-32123-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

> This is needed if user space wants to know supported bnep features
> by kernel, e.g. if kernel supports sending response to bnep setup
> control message. By now there is no possibility to know supported
> features by kernel in case of bnep. Ioctls allows only to add connection,
> delete connection, get connection list, get connection info. Adding
> connection if it's possible (establishing network device connection) is
> equivalent to starting bnep session. Bnep session handles data queue of
> transmit, receive messages over bnep channel. It means that if we add
> connection the received/transmitted data will be parsed immediately. In
> case of get bnep features we want to know before session start, if we
> should leave setup data on socket queue and let kernel to handle with it,
> or in case of no setup handling support, if we should pull this message
> and handle setup response within user space.
> 
> Signed-off-by: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
> ---
> fs/compat_ioctl.c         | 1 +
> net/bluetooth/bnep/bnep.h | 4 ++++
> net/bluetooth/bnep/sock.c | 8 ++++++++
> 3 files changed, 13 insertions(+)
> 
> diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
> index afec645..19fb0c8 100644
> --- a/fs/compat_ioctl.c
> +++ b/fs/compat_ioctl.c
> @@ -570,6 +570,7 @@ static int mt_ioctl_trans(unsigned int fd, unsigned int cmd, void __user *argp)
> #define BNEPCONNDEL	_IOW('B', 201, int)
> #define BNEPGETCONNLIST	_IOR('B', 210, int)
> #define BNEPGETCONNINFO	_IOR('B', 211, int)
> +#define BNEPGETSUPPFEAT	_IOR('B', 212, int)
> 
> #define CMTPCONNADD	_IOW('C', 200, int)
> #define CMTPCONNDEL	_IOW('C', 201, int)
> diff --git a/net/bluetooth/bnep/bnep.h b/net/bluetooth/bnep/bnep.h
> index 5a5b16f..12d2c84 100644
> --- a/net/bluetooth/bnep/bnep.h
> +++ b/net/bluetooth/bnep/bnep.h
> @@ -80,6 +80,9 @@
> #define BNEP_TYPE_MASK	0x7f
> #define BNEP_EXT_HEADER	0x80
> 
> +/* Features */
> +#define BNEP_SETUP_RSP_SUPPORT	0
> +
> struct bnep_setup_conn_req {
> 	__u8 type;
> 	__u8 ctrl;
> @@ -111,6 +114,7 @@ struct bnep_ext_hdr {
> #define BNEPCONNDEL	_IOW('B', 201, int)
> #define BNEPGETCONNLIST	_IOR('B', 210, int)
> #define BNEPGETCONNINFO	_IOR('B', 211, int)
> +#define BNEPGETSUPPFEAT	_IOR('B', 212, int)

actually lets put the features definition here. They are essentially the flags like in CMTP and HIDP.

And lets use BNEP_SETUP_RESPONSE here. Then we can use it as flags and as features mask. This makes is pretty similar to what we have with HIDP and CMTP.

> 
> struct bnep_connadd_req {
> 	int   sock;		/* Connected socket */
> diff --git a/net/bluetooth/bnep/sock.c b/net/bluetooth/bnep/sock.c
> index 5f05129..ff0ea10 100644
> --- a/net/bluetooth/bnep/sock.c
> +++ b/net/bluetooth/bnep/sock.c
> @@ -29,6 +29,8 @@
> 
> #include "bnep.h"
> 
> +static const __u32 supp_feat = BIT(BNEP_SETUP_RSP_SUPPORT);
> +

And lets move this one just into bnep_sock_ioctl since there seems to be no need to make this global.

> static struct bt_sock_list bnep_sk_list = {
> 	.lock = __RW_LOCK_UNLOCKED(bnep_sk_list.lock)
> };
> @@ -120,6 +122,12 @@ static int bnep_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long
> 
> 		return err;
> 
> +	case BNEPGETSUPPFEAT:
> +		if (copy_to_user(argp, &supp_feat, sizeof(supp_feat)))
> +			return -EFAULT;
> +
> +		return 0;
> +
> 	default:
> 		return -EINVAL;
> 	}

Regards

Marcel

