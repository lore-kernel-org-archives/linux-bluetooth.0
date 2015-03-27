Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v2 2/3] Bluetooth: bnep: Add support for get bnep features via ioctl
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1427444231-25010-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Date: Fri, 27 Mar 2015 16:15:16 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <6F9BF6F7-55D5-4BF1-93A7-723BF01665DE@holtmann.org>
References: <1427444231-25010-1-git-send-email-grzegorz.kolodziejczyk@tieto.com> <1427444231-25010-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

> This is needed if user space wants to know supported bnep features
> by kernel, eg. if kernel supports sending response to bnep setup
> control message.
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
> index 5a5b16f..d19831e 100644
> --- a/net/bluetooth/bnep/bnep.h
> +++ b/net/bluetooth/bnep/bnep.h
> @@ -80,6 +80,9 @@
> #define BNEP_TYPE_MASK	0x7f
> #define BNEP_EXT_HEADER	0x80
> 
> +/* Features */
> +#define BNEP_SETUP_RSP_FEAT	0x01
> +

this should be most likely defined like this:

#define BNEP_SETUP_RSP_SUPPORT	0

Most of the code in HIPD and CMTP does (1 << FOO). So we should use bit positions here.

> struct bnep_setup_conn_req {
> 	__u8 type;
> 	__u8 ctrl;
> @@ -111,6 +114,7 @@ struct bnep_ext_hdr {
> #define BNEPCONNDEL	_IOW('B', 201, int)
> #define BNEPGETCONNLIST	_IOR('B', 210, int)
> #define BNEPGETCONNINFO	_IOR('B', 211, int)
> +#define BNEPGETSUPPFEAT	_IOR('B', 212, int)
> 
> struct bnep_connadd_req {
> 	int   sock;		/* Connected socket */
> diff --git a/net/bluetooth/bnep/sock.c b/net/bluetooth/bnep/sock.c
> index 5f05129..fea611c 100644
> --- a/net/bluetooth/bnep/sock.c
> +++ b/net/bluetooth/bnep/sock.c
> @@ -29,6 +29,8 @@
> 
> #include "bnep.h"
> 
> +static const __u8 supp_feat = BNEP_SETUP_RSP_FEAT;
> +

Why are we doing here __u8 and not __u32. I like to understand the rational since the commit message is pretty sparse actually. A more detailed commit message explaining the new API would actually help.

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

