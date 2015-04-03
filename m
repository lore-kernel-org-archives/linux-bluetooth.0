Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v5 2/4] Bluetooth: bnep: Add support for get bnep features via ioctl
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1428056095-21978-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Date: Fri, 3 Apr 2015 14:24:27 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <FC839784-CD2D-41FC-A6F5-1BB749D69AEB@holtmann.org>
References: <1428056095-21978-1-git-send-email-grzegorz.kolodziejczyk@tieto.com> <1428056095-21978-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
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
> net/bluetooth/bnep/bnep.h | 1 +
> net/bluetooth/bnep/sock.c | 7 +++++++
> 3 files changed, 9 insertions(+)
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

actually you forgot to add COMPATIBLE_IOCTL. Sometimes doing a git grep BNEPGETCONNINFO would have nicely given you a hint on what to do for compat ioctl use cases.

Regards

Marcel

