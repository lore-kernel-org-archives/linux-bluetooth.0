Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH 2/3] Bluetooth: bnep: Add support for get bnep features via ioctl
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1427367755-13950-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Date: Thu, 26 Mar 2015 08:13:15 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A6B5F048-964C-44D7-8915-FED770F2DDC8@holtmann.org>
References: <1427367755-13950-1-git-send-email-grzegorz.kolodziejczyk@tieto.com> <1427367755-13950-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
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
> net/bluetooth/bnep/bnep.h | 4 ++++
> net/bluetooth/bnep/sock.c | 8 ++++++++
> 2 files changed, 12 insertions(+)
> 
> diff --git a/net/bluetooth/bnep/bnep.h b/net/bluetooth/bnep/bnep.h
> index 5a5b16f..a116e2e 100644
> --- a/net/bluetooth/bnep/bnep.h
> +++ b/net/bluetooth/bnep/bnep.h
> @@ -80,6 +80,9 @@
> #define BNEP_TYPE_MASK	0x7f
> #define BNEP_EXT_HEADER	0x80
> 
> +/* Flags */
> +#define BNEP_SETUP_RSP_FLAG	0x00000000
> +
> struct bnep_setup_conn_req {
> 	__u8 type;
> 	__u8 ctrl;
> @@ -111,6 +114,7 @@ struct bnep_ext_hdr {
> #define BNEPCONNDEL	_IOW('B', 201, int)
> #define BNEPGETCONNLIST	_IOR('B', 210, int)
> #define BNEPGETCONNINFO	_IOR('B', 211, int)
> +#define BNEPGETSUPPFEAT	_IOR('B', 212, int)

as mentioned on IRC, you forgot compat_ioctl.h

> struct bnep_connadd_req {
> 	int   sock;		/* Connected socket */
> diff --git a/net/bluetooth/bnep/sock.c b/net/bluetooth/bnep/sock.c
> index 5f05129..6b84baf 100644
> --- a/net/bluetooth/bnep/sock.c
> +++ b/net/bluetooth/bnep/sock.c
> @@ -29,6 +29,8 @@
> 
> #include "bnep.h"
> 
> +static const __u32 supp_feat = BIT(BNEP_SETUP_RSP_FLAG);
> +

I am confused with the naming here. Are we exposing current state or supported features or what?

Regards

Marcel

